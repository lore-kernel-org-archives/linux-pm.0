From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 0/4] add reboot mode driver
Date: Wed, 13 Jan 2016 10:17:35 +0800
Message-ID: <5695B3BF.4030505@gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35352 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbcAMCRp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 21:17:45 -0500
In-Reply-To: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org
Cc: mark.rutland@arm.com, geert+renesas@glider.be, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, lorenzo.pieralisi@arm.com, f.fainelli@gmail.com, linux@arm.linux.org.uk, dbaryshkov@gmail.com, cernekee@gmail.com, linux-rockchip@lists.infradead.org, linux@roeck-us.net, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org, moritz.fischer@ettus.com, linux-pm@vger.kernel.org, sre@kernel.org, galak@codeaurora.org, olof@lixom.net, jun.nie@linaro.org, dwmw2@infradead.org

Hi ,

=E5=9C=A8 2016=E5=B9=B401=E6=9C=8812=E6=97=A5 19:27, Andy Yan =E5=86=99=
=E9=81=93:
> This driver parse the reboot commands like "reboot loader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the corresponding  write interface
> to store the boot mode magic value in some persistent storage
> like special register or ram , which can be read by the bootloader
> after system reboot.
>
> This is commonly used on Android based devices, which in order
> to reboot the device into fastboot or recovery mode.
>
> Before this patch , I have try some hack on[0], and then found
> John Stultz also doing the same work[1].
>
> As John is busy these days, I go on with this work.
>
> [0]https://patchwork.kernel.org/patch/7647751/
> [1]https://patchwork.kernel.org/patch/7802391/
>
> Changes in v2:
> - move to dir drivers/power/reset/
> - make syscon-reboot-mode a generic driver
> - make this DT node as a subnode of PMU/PMUGRF
>
> Changes in v1:
> - fix the embarrassed compile warning
> - correct the maskrom magic number
> - check for the normal reboot
> - correct the maskrom magic number
> - use macro defined in rockchip_boot-mode.h for reboot-mode DT node
>
> Andy Yan (4):
>    dt-bindings: power: reset: add document for reboot-mode driver
>    power: reset: add reboot mode driver
>    ARM: dts: rockchip: add syscon-reboot-mode node
>    ARM64: dts: rockchip: add syscon-reboot-mode DT node

This series patches are verified by my github based on kernel 4.4 relea=
se.
https://github.com/Caesar-github/rockchip/commits/kylin-develop4.4

reboot loader, reboot recovery, reboot fastboot..... these are okay for=
=20
rk3288, rk3368. rk3036 Socs on my hand board.
(Note: the loader need that jeffy send patches to support uboot on=20
upstream,  that's also okay if you are using the RK loader from Rockchi=
p)

I just send the patch to support the rk3036 dts.=20
<https://patchwork.kernel.org/patch/8021581/>

So feel free add my test tags:

Tested-by: Caesar Wang <wxt@rock-chips.com>

>
>   .../bindings/power/reset/reboot-mode.txt           |  41 +++++++++
>   .../bindings/power/reset/syscon-reboot-mode.txt    |  52 ++++++++++=
+
>   arch/arm/boot/dts/rk3288.dtsi                      |  31 +++++++
>   arch/arm/boot/dts/rk3xxx.dtsi                      |  33 ++++++-
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  33 ++++++-
>   drivers/power/reset/Kconfig                        |  16 ++++
>   drivers/power/reset/Makefile                       |   2 +
>   drivers/power/reset/reboot-mode.c                  | 100 ++++++++++=
+++++++++++
>   drivers/power/reset/reboot-mode.h                  |   6 ++
>   drivers/power/reset/syscon-reboot-mode.c           |  62 ++++++++++=
+++
>   include/dt-bindings/soc/rockchip_boot-mode.h       |  30 +++++++
>   11 files changed, 404 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/reset/re=
boot-mode.txt
>   create mode 100644 Documentation/devicetree/bindings/power/reset/sy=
scon-reboot-mode.txt
>   create mode 100644 drivers/power/reset/reboot-mode.c
>   create mode 100644 drivers/power/reset/reboot-mode.h
>   create mode 100644 drivers/power/reset/syscon-reboot-mode.c
>   create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h
>


--=20
Thanks,
Caesar

