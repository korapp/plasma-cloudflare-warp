# Cloudflare WARP Plasmoid

[![plasma](https://img.shields.io/static/v1?message=KDE%20Store&color=54a3d8&logo=kde&logoColor=FFFFFF&label=)][kdestore]
[![downloads](https://img.shields.io/github/downloads/korapp/plasma-cloudflare-warp/total)][releases]
[![release](https://img.shields.io/github/v/release/korapp/plasma-cloudflare-warp)][releases]

Plasmoid for the official [Cloudflare WARP client][warp].

![Plasmoid preview](preview.png)

## Features

* Connection status information as the icon color and a tooltip
* Quick connect/disconnect by middle click on the icon
* Connection stats after expand
* Status change notifications

## Requirements

* [Cloudflare WARP][warp]
* KDE Plasma >= 6.0

## Installation

The preferred and easiest way to install is to use Plasma Discover or KDE Get New Stuff and search for *Cloudflare WARP*.

### From file

Download the latest version of plasmoid from [KDE Store][kdestore] or [release page][releases]

#### A) Plasma UI

1. Right click on panel or desktop
2. Select *Add Widgets > Get New Widgets > Install From Local File*
3. Choose downloaded plasmoid file

#### B) Terminal

```sh
plasmapkg2 -i plasma-cloudflare-warp-*.plasmoid
```

### From GitHub

Clone repository and go to the project directory

```sh
git clone https://github.com/korapp/plasma-cloudflare-warp.git
cd plasma-cloudflare-warp
```

Install

```sh
plasmapkg2 -i package
```

## Support

Say thank you with coffee ☕ if you'd like.

[![liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/korapp/donate)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/korapp)
[<img src="https://img.shields.io/badge/Revolut-white?logo=Revolut&logoColor=black" height="30"/>](https://revolut.me/korapp)

[kdestore]: https://store.kde.org/p/2113872/
[releases]: https://github.com/korapp/plasma-cloudflare-warp/releases
[warp]: https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/download-warp/#linux
