<div align="center">
    <img href="https://projecterror.dev" width="150" src="https://user-images.githubusercontent.com/55056068/147729117-5ab762d8-44be-48f0-bc33-a6664061b6cf.png" alt="Material-UI logo" />
</div>
<h1 align="center">NPWD</h1>

<div align="center">

[![Discord](https://img.shields.io/discord/791854454760013827?label=我们的Discord)](https://discord.com/invite/HYwBjTbAY5)

[**观看NPWD预告片**](https://www.youtube.com/watch?v=Yh8gT8wuywU)

![2-1](https://user-images.githubusercontent.com/55056068/147857192-cd8502e6-fb38-4975-b182-4aaaeadff877.png)

</div>

## 单仓库结构

### 应用程序

- `phone`：NPWD的React代码。
- `game`：在FiveM客户端/服务器端运行的游戏相关脚本和代码。

### 包

- `npwd-hooks`：外部应用程序中使用的钩子。主要用于通过自定义窗口事件与`npwd`进行通信。
- `npwd-types`：NPWD自动生成的类型，可在外部应用程序中使用。
- `database`：每个应用程序的数据库配置和类。
- `logger`：使用`winston`的日志库。
- `config`：与NPWD相关的配置函数。

## 独立信息与安装

我们设计的 _NPWD_ 通常与框架无关，这意味着它可以轻松地与ESX和QBCore等流行的开源框架或任何自定义框架集成。

有关此系统的更多详细信息，请参考我们的安装[文档](https://projecterror.dev/docs/npwd/start/installation)。

你还需要 [screenshot-basic](https://github.com/project-error/screenshot-basic)。

## 技术栈与开发

_NPWD_ 使用React + TypeScript构建NUI前端，并使用TypeScript（V8运行时）编写游戏脚本。你可以在我们的文档页面[此处](https://projecterror.dev/docs/npwd/dev/dev_bootstrap)找到有关此项目开发的更多技术信息。

## 功能请求与问题报告

请在我们的[GitHub仓库](https://github.com/project-error/npwd/issues/new/choose)上创建问题/增强请求。这是我们跟踪需要解决或改进问题的最佳方式。

## 功能

- [优化](https://i.imgur.com/mN5ib42.png)
  - 闲置时为0.01毫秒，使用时为0.05毫秒。
- [推特](https://i.imgur.com/BjwovRR.png)
  - 点赞、回复、转发、举报和删除自己的推文。
  - 直接从手机相册或外部URL发送表情符号和图片。_也支持GIF！_
  - NPWD具备Discord日志记录功能，因此所有被举报的推文将发送到配置的Webhook。
  - 使用配置的Webhook将推文直接记录到Discord。
- [配对器](https://i.imgur.com/46XtZ06.jpeg)
  - 类似于Tinder，但没有那么多机器人。向右滑动开启浪漫或拒绝之旅。
  - 截至v1.0版本，没有性取向过滤器。
  - 如果你不想要这个应用程序，请按照[此处](https://projecterror.dev/docs/npwd/dev/disable_apps)的文档进行禁用。
- [市场](https://user-images.githubusercontent.com/55056068/147530933-d56ceb19-0db2-471f-a8ca-7cc3986b87be.png)
  - 发布带或不带图片的广告。
  - 从相册或URL选择图片。
  - 具备通话/消息图标，因此无需提供电话号码。
- [Text Messaging](https://i.imgur.com/9vFHqhW.png)
  - Send a message or an image taken straight from the phones Gallery.
  - Group messages
- [Calling](https://i.imgur.com/7T0JbQl.png)
  - Call anyone from anywhere.
- [Camera](https://i.imgur.com/Fk6wQkg.png)
  - Take pictures of oneself or your surroundings.
  - All pictures save to the gallery where they can be retrieved with a copyable link.
  - As of v1.0, there is currently [two photo modes](https://i.imgur.com/pole8bA.jpeg) for front/rear camera.
- [Contacts](https://i.imgur.com/Qxs35rj.png)
  - Add a phone number to your contacts for easier access.
  - Supports up to 19 characters for phone number by default and easily changed within the
  - Gif support for avatar.
  - Quickly call, text, and with additional configuration send money.
- [Notes](https://i.imgur.com/0Hvvlah.png)
  - Something you want to remember in game? Make a note!
- [Calculator](https://user-images.githubusercontent.com/55056068/147531020-b7527a69-0b0e-4e81-83c7-58ad836eab23.png)
  - Peform calculations.
- [Themes](https://i.imgur.com/2DpBHuM.png)
  - Default dark theme or light theme with other themes in the works. Want to make your own? Follow our [documentation](https://projecterror.dev/docs/npwd/dev/setup#setting-up-the-theme).
  - Set within the Settings app.
- [6 Custom Cases/Frames](https://i.imgur.com/opyF0J1.png)
  - These cases were made by [DayIsKuan](https://github.com/dayiskuan)
  - Set within the Settings app.
- [Icon Sets](https://i.imgur.com/z7pyrmU.png)
  - Change between material UI icons or our custom made icons.
  - Want to make your own? Follow our [documentation](https://projecterror.dev/docs/npwd/dev/setup#adding-icons).
  - Set within the Settings app.
- [Notifications - Closed](https://i.imgur.com/j474Sc2.png)
  - While closed, only a portion of it will render to display a notification.
  - As of v1.0, this is currently used for calls, text and tweets.
- [Notifications - Open](https://i.imgur.com/33BlJn6.png)
  - While open, all notifications occur across the top of the phone.
  - View [missed notifications](https://i.imgur.com/3B4Ezyq.png) by clicking on the phone's header.
- [Streamer Mode](https://i.imgur.com/jzU075n.png)
  - A mode designed for streamers where images are hidden unless clicked.
  - This applies across all apps on the phone.
  - Easily set within the phone's setting app.
- [Settings Configuration](https://user-images.githubusercontent.com/55056068/147530852-78934a48-b478-472c-b7f4-61860e4f8479.mp4)
  - Use a slider to set ringtone and notification alert volume.
  - Copy your phone number to clipboard for easy sharing.
  - Configure a chosen ringtone or alert sound.
  - Choose betwen **twelve** languages as of v1.0.
  - Change frames, icon sets and themes.
  - Adjust Zoom (100% to 70%).
  - Filter notification preferences.
- Discord Logging
  - Follow our [documentation](https://projecterror.dev/docs/npwd/start/installation#setting-up-discord-log-integration) for intial setup.
  - Never used a webhook before? Follow Discord's [documentation](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks) for creating a webhook.

## Final words

A special thanks to all the people who have helped out with the translations! You have all been amazing.

Thanks to [Ultrahacx](https://github.com/ultrahacx) for all the artwork and animations seen in the trailer and this post.
