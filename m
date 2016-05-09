From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 00/11] Add HW throttle for Tegra soctherm
Date: Mon, 9 May 2016 14:53:53 +0800
Message-ID: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series add following functions for Tegra soctherm:
1. add HW throttle function.
2. enable soctherm node for Tegra124, Tegra132, Tegra210, and
set "critical", "hot" trips for them.

Main changes from v3:
1. change some properties'name and descriptions, per Rob's comments.
2. change the corresponding driver codes.

Main changes from v2:
1. improve the of-binding, per Eduardo's comments, and
change the corresponding driver codes.
2. move two setting critical trip patches in this series,
3. fix some bugs in dts changes.

Main changes from v1:
1. use readl/writel instead of __raw_readl/__raw_writel.
2. rebase on the linux-next.

The v1 series is in:
https://lkml.org/lkml/2016/3/31/230

The v2 series is in:
https://lkml.org/lkml/2016/4/26/1577

The v3 series is in:
https://lkml.org/lkml/2016/5/3/274

Wei Ni (11):
  of: Add bindings of hw throttle for Tegra soctherm
  thermal: tegra: add hw-throttle function
  thermal: tegra: add hw-throttle for Tegra132
  arm: tegra: set critical trips for Tegra124
  arm: tegra: set hot trips for Tegra124
  arm64: tegra: use tegra132-soctherm for Tegra132
  arm64: tegra: set critical trips for Tegra132
  arm64: tegra: set hot trips for Tegra132
  arm64: tegra: add soctherm node for Tegra210
  arm64: tegra: set critical trips for Tegra210
  arm64: tegra: set hot trips for Tegra210

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  18 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  83 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 127 ++++
 drivers/thermal/tegra/soctherm.c                   | 842 ++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h                   |  10 +
 drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra132-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
 include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
 11 files changed, 1344 insertions(+), 35 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
