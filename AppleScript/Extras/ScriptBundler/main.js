MyFancyLibrary = Library('MyFancyLibrary')
MyBoringLibrary = Library('MyBoringLibrary')

function documentOpened(doc) {
  MyFancyLibrary.hello()
}

function documentSaved(doc) {
  MyBoringLibrary.hello()
}
