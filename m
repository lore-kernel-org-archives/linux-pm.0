From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 00/12] Add some functionalities for Tegra soctherm
Date: Thu, 21 Feb 2019 18:18:35 +0800
Message-ID: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Move the hw/sw shutdown patches into this serial. There already have
some discussion for it in https://lkml.org/lkml/2018/12/7/225.
Support GPU HW throttle, thermal IRQ, set_trips(), EDP IRQ and OC
hw throttle.

Main change from v1:
1. Use boolean for "nvidia,polarity-active-low".
2. Add suffix "-us" for "nvidia,throttle-period".


Wei Ni (12):
  of: Add bindings of thermtrip for Tegra soctherm
  thermal: tegra: support hw and sw shutdown
  arm64: dts: tegra210: set thermtrip
  of: Add bindings of gpu hw throttle for Tegra soctherm
  thermal: tegra: add support for gpu hw-throttle
  arm64: dts: tegra210: set gpu hw throttle level
  thermal: tegra: add support for thermal IRQ
  thermal: tegra: add set_trips functionality
  thermal: tegra: add support for EDP IRQ
  arm64: dts: tegra210: set EDP interrupt line
  of: Add bindings of OC hw throttle for Tegra soctherm
  thermal: tegra: enable OC hw throttle

 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  62 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  20 +-
 drivers/thermal/tegra/soctherm.c                   | 961 +++++++++++++++++++--
 drivers/thermal/tegra/soctherm.h                   |  16 +
 drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
 include/dt-bindings/thermal/tegra124-soctherm.h    |   8 +-
 8 files changed, 1020 insertions(+), 76 deletions(-)

-- 
2.7.4
