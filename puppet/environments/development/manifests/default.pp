hiera_include('classes')

# Get rid of that stupid bright red deprecation warning
Package {
  allow_virtual => true,
}
