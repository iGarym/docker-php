# docker-php

## 说明

* `libxml2-dev` 和 `zlib1g-dev` 分别依赖 `libxml2` 和 `zlib1g`，由于系统中已经存在对应的高版本依赖，所以这里指定版本，并且声明允许降级（`--allow-downgrades`）

* `libxml2` 和 `zlib1g` 在原系统中已经存在，为防止卸载后出现问题，所以不加入 _buildDeps_ 中
