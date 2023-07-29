#include "filecryptor.hpp"
#include <QApplication>
#include <QFileDialog>
#include <fstream>
#include <string>
#include <QStringList>
#include <QFile>
#include <QTextStream>
#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QStandardPaths>

FileCryptor::FileCryptor(QObject *parent)
    : QObject{parent}
{

}
QString FileCryptor::convertFilePath(const QString& filePath)
{
    QUrl url(filePath);
    return url.toLocalFile();
}

QStringList FileCryptor::encryptFile(QString filePath, QString password)
{
    QStringList retVals;
    filePath = convertFilePath(filePath);
    qsizetype lastIndexOfSlash = filePath.lastIndexOf("/");
    QString tmpFilePath = filePath.left(lastIndexOfSlash + 1) + "crypted_" + filePath.mid(lastIndexOfSlash + 1);
    // Open the input and output files
    std::ifstream input(filePath.toStdString(), std::ios::binary);
    std::ofstream output(tmpFilePath.toStdString(), std::ios::binary);
    if(!input || !output){
        retVals.push_back("error openning the file");
        retVals.push_back(filePath);
        return retVals;
    }
    // Encrypt the file
    encryptDecrypt(input, output, password.toStdString());
    input.close();
    output.close();
    if( remove( filePath.toStdString().c_str() ) != 0 ){
        retVals.push_back("error deleting previous file");
        retVals.push_back(filePath);
        return retVals;
    }
    QString resFilePath = tmpFilePath;
    retVals = {"success", resFilePath, password};
    return retVals;
}

QStringList FileCryptor::decryptFile(QString filePath, QString password)
{
    QStringList retVals;
    filePath = convertFilePath(filePath);
    QString tmpFilePath;
    qsizetype lastIndexOfSlash = filePath.lastIndexOf("/");
    QString checkCrypted = filePath.mid(lastIndexOfSlash + 1, 8);
    if(checkCrypted == "crypted_"){
        tmpFilePath = filePath.left(lastIndexOfSlash + 1) +  filePath.mid(lastIndexOfSlash + 9);
    }else{
        tmpFilePath = filePath.left(lastIndexOfSlash + 1) + "decrypted_" + filePath.mid(lastIndexOfSlash + 1);
    }
    // Open the input and output files
    std::ifstream input(filePath.toStdString(), std::ios::binary);
    std::ofstream output(tmpFilePath.toStdString(), std::ios::binary);
    if(!input || !output){
        retVals.push_back("error openning the file");
        retVals.push_back(filePath);
        return retVals;
    }
    // Encrypt the file
    encryptDecrypt(input, output, password.toStdString());
    input.close();
    output.close();
    if( remove( filePath.toStdString().c_str() ) != 0 ){
        retVals.push_back("error deleting previous file");
        retVals.push_back(filePath);
        return retVals;
    }
    QString resFilePath = tmpFilePath;
    retVals = {"success", resFilePath, password};
    return retVals;
}

void FileCryptor::encryptDecrypt(std::ifstream &inputFile, std::ofstream &outputFile, std::string key)
{
    int keyLength = key.size();
    char data;
    int i = 0;
    while (inputFile.get(data)) {
        data ^= key[i % keyLength];
        outputFile.put(data);
        i++;
    }
}

