#ifndef FILEICONIMAGEPROVIDER_H
#define FILEICONIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QIcon>
#include <QFileInfo>
#include <QFileIconProvider>
#include <iostream>

class FileIconImageProvider : public QQuickImageProvider
{
public:
    FileIconImageProvider();
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;
};

#endif // FILEICONIMAGEPROVIDER_H
