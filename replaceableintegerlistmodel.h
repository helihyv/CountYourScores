#ifndef REPLACEABLEINTEGERLISTMODEL_H
#define REPLACEABLEINTEGERLISTMODEL_H

#include <QAbstractListModel>

class ReplaceableIntegerListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ReplaceableIntegerListModel(QObject *parent = 0);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role) const;


    
signals:
    
public slots:

protected:

    QList<int> values_;
    
};

#endif // REPLACEABLEINTEGERLISTMODEL_H
