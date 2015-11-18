# Version 1.1.31 - Dec, 9, 2009 #

### Added: ###
  * Action classes.
  * ZedSprite.screenX and ZedSprite.screenY properties.

### Modified: ###
  * Matrix3D update optimized.
  * Matrix3D.concat() method replaced by Matrix3D.preMultiply() and Matrix3D.postMultiply().
  * IZFilter interface replaced by the Action class.
  * BlurZFilter replaced by DOFBlur action.
  * AlphaZFilter replaced by DOFAlpha action.
  * ZedScene.zFilters property replaced by ZedScene.addAction() method.
  * Most classes are now distributed across different subpackages instead of the top-level idv.cjcat.zedbox package.


---


## Version 1.0.9 - May, 23, 2009 ##

### Added: ###
  * ZedSprite.rotationOrder property.
  * RotationOrder class.
  * ZFilter support.
  * ZFilters: AlphaZFilter, BlurZFilter.
  * Documentation.


---


## Version 0.1.3 ##
  * Initial release.