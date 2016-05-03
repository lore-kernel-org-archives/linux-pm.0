From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v3 00/11] Add HW throttle for Tegra soctherm
Date: Tue, 3 May 2016 18:13:19 +0800
Message-ID: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This series add following functions for Tegra soctherm:
1. add HW throttle function.
2. enable soctherm node for Tegra124, Tegra132, Tegra210, and
set "critical", "hot" trips for them.

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

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 120 ++-
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
 11 files changed, 1343 insertions(+), 35 deletions(-)

-- 
1.9.1
