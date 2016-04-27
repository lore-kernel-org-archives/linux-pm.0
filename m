From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 0/9] Add HW throttle for Tegra soctherm
Date: Wed, 27 Apr 2016 11:25:45 +0800
Message-ID: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This series add following functions for Tegra soctherm:
1. add Tegra132 support.
2. add HW throttle function.
3. set hot trip temperatures which can trigger the HW throttle.

Main changes from V1:
1. use readl/writel instead of __raw_readl/__raw_writel.
2. rebase on the linux-next.

The v1 series is in:
https://lkml.org/lkml/2016/3/31/230

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

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  89 ++-
 arch/arm/boot/dts/tegra124.dtsi                    |  39 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           | 119 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  41 +-
 drivers/thermal/tegra/Makefile                     |   1 +
 drivers/thermal/tegra/soctherm.c                   | 838 ++++++++++++++++++++-
 drivers/thermal/tegra/soctherm.h                   |  14 +
 drivers/thermal/tegra/tegra124-soctherm.c          |  18 +
 drivers/thermal/tegra/tegra132-soctherm.c          | 214 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c          |  18 +
 include/dt-bindings/thermal/tegra124-soctherm.h    |   5 +
 11 files changed, 1359 insertions(+), 37 deletions(-)
 create mode 100644 drivers/thermal/tegra/tegra132-soctherm.c

-- 
1.9.1
