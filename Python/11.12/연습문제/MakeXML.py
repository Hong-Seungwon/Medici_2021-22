
from xml.etree.ElementTree import Element, SubElement, ElementTree

filname = 'XmlSample'
root = Element('Books')
firstSub = SubElement(root, 'book')
scondeSub = SubElement(firstSub, 'author').text = '아무개'
scondeSub = SubElement(firstSub, 'price').text = '30000'
scondeSub = SubElement(firstSub, 'pubdate').text = '01112001'
thirdSub =SubElement(root, 'pubinfo')
fourthSub = SubElement(thirdSub, 'publisher').text='Korea Books'
fourthSub = SubElement(thirdSub, 'state').text='Jejudo'

tree = ElementTree(root)
tree.write('./'+filname+'.xml')
