使用方法：

HttpProxyCacheServer *proxy = [HttpProxyCacheServer defaultProxyServer];

url = [proxy getProxyUrl:url];

完了把这个url是你要播放的资源url，这样处理之后扔给播放器就行了，啥播放器都不要紧，音频视频都行

配置文件：

HttpProxyCacheServerConfig.h
