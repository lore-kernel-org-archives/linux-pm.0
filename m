From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/9] Add HW throttle for Tegra soctherm
Date: Thu, 31 Mar 2016 16:43:59 +0800
Message-ID: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This series add following functions for Tegra soctherm:
1. add Tegra132 support.
2. add HW throttle function.
3. set hot trip temperatures which can trigger the HW throttle.

Wei Ni (9):
  thermal: tegra: add Tegra132 specific SOC_THERM driver
  arm64: tegra: use tegra132-soctherm for Tegra132
  arm64: tegra: set critical trips for Tegra132
  of: Add bindings of hw throttle for soctherm
  thermal: tegra: add hw-throttle function
  thermal: tegra: add hw-throttle for Tegra132
  arm64: tegra: set hot trips for Tegra210
  arm64: tegra: set hot trips for Tegra132
  arm: tegra: set hot trips for Tegra124

 .../devicetree/bindings/thermal/tegra-soctherm.txt |  89 ++-
 arch/arm/boot/dts/tegra124.dtsi                    |  39 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  41 +-
 drivers/thermal/tegra/Makefile                     |   1 +
 drivers/thermal/tegra/soctherm.c                   | 834 ++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h                   |  14 +
 drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra132-soctherm.c          | 214 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
 include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
 11 files changed, 1355 insertions(+), 37 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra132-soctherm.c

-- 
1.9.1
