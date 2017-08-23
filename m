From: <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v1 0/3] Enable some devices for rk3328 evaluation board
Date: Wed, 23 Aug 2017 16:40:29 +0800
Message-ID: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

1. enalbe sdio/sdmmc/emmc.
2. enable cpufreq.

Liang Chen (3):
  arm64: dts: rockchip: add mmc nodes for rk3328 evaluation board
  cpufreq: rockchip: add support for rk3328 soc
  arm64: dts: rockchip: add cpu regulator for rk3328 evaluation board

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 78 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 2 files changed, 79 insertions(+)

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
