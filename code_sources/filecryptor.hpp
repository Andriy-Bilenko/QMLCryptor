#ifndef FILECRYPTOR_HPP
#define FILECRYPTOR_HPP

#include <QObject>
#include <QQmlEngine>
#include <fstream>
#include <string>
#include <QStringList>

class FileCryptor : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit FileCryptor(QObject *parent = nullptr);
public slots:
    QStringList encryptFile(QString filePath, QString password);
    QStringList decryptFile(QString filePath, QString password);
private:
    void encryptDecrypt(std::ifstream &inputFile, std::ofstream &outputFile, std::string key);
    QString convertFilePath(const QString& filePath);
};

#endif // FILECRYPTOR_HPP
