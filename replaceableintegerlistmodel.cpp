#include "replaceableintegerlistmodel.h"

ReplaceableIntegerListModel::ReplaceableIntegerListModel(QObject *parent) :
    QAbstractListModel(parent)
{
    //Testcode

    values_.append(1);
    values_.append(2);
    values_.append(3);
    values_.append(4);
    values_.append(5);
    values_.append(6);
    values_.append(7);
    values_.append(8);
    values_.append(9);
    values_.append(20);
    values_.append(50);
    values_.append(75);

}

int ReplaceableIntegerListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;   //No item in a list model has children

    return values_.count();

}

QVariant ReplaceableIntegerListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
        case Qt::DisplayRole:
        case Qt::EditRole:
        case Qt::AccessibleTextRole:

            return values_.at(index.row());

        default:

            return QVariant();

    }
}
