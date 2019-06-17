#ifndef PROCESS_H
#define PROCESS_H

#include <QObject>

class Process : public QObject {
    Q_OBJECT

public:
    Process(QObject *parent);
    Q_INVOKABLE void start(const QString &program);
};

#endif // PROCESS_H
