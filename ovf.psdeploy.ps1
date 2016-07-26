Deploy OVF-Module {        
    By PSGalleryModule Artifactory {
        FromSource '.\OVF.Windows.Server\'
        To 'Artifactory'
        WithOptions @{
            ApiKey = $env:ARTIFACTORY_API_KEY
        }
    }       
}
