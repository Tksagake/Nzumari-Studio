#include <QBuffer>
#include <QGuiApplication>
#include <QDataStream>
#include <QFile>
#include <QImage>
#include <QPainter>
#include <QSvgRenderer>

int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    if (argc != 3) {
        return 2;
    }

    QSvgRenderer renderer(QString::fromLocal8Bit(argv[1]));
    if (!renderer.isValid()) {
        return 3;
    }

    const QList<int> sizes { 256, 128, 64, 48, 32, 16 };
    QList<QByteArray> images;

    for (const int size : sizes) {
        QImage image(size, size, QImage::Format_ARGB32_Premultiplied);
        image.fill(Qt::transparent);

        QPainter painter(&image);
        painter.setRenderHint(QPainter::Antialiasing);
        painter.setRenderHint(QPainter::SmoothPixmapTransform);
        renderer.render(&painter, QRectF(0, 0, size, size));
        painter.end();

        QByteArray png;
        QBuffer buffer(&png);
        if (!buffer.open(QIODevice::WriteOnly) || !image.save(&buffer, "PNG")) {
            return 4;
        }
        images.append(png);
    }

    QFile output(QString::fromLocal8Bit(argv[2]));
    if (!output.open(QIODevice::WriteOnly)) {
        return 5;
    }

    QDataStream stream(&output);
    stream.setByteOrder(QDataStream::LittleEndian);
    stream << quint16(0) << quint16(1) << quint16(sizes.size());

    quint32 offset = 6 + quint32(16 * sizes.size());
    for (int i = 0; i < sizes.size(); ++i) {
        const quint8 dimension = sizes[i] == 256 ? 0 : quint8(sizes[i]);
        stream << dimension << dimension
               << quint8(0) << quint8(0)
               << quint16(1) << quint16(32)
               << quint32(images[i].size()) << offset;
        offset += quint32(images[i].size());
    }

    for (const QByteArray& image : images) {
        if (output.write(image) != image.size()) {
            return 6;
        }
    }

    return 0;
}
