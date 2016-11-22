From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL V2] Thermal SoC management updates for v4.10-rc1 #1
Date: Tue, 22 Nov 2016 02:48:56 -0800
Message-ID: <20161122104854.GA3011@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please considering pull the following driver fixes for 4.10-rc1. This is now
base on your current master.

The following changes since commit b58ec8b5824717875b844a9e8cc62fc6eb5fd289:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2016-11-07 10:16:23 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 2caa24332dd241549cd5af91b6d8d5d500b7d286:

  devfreq_cooling: pass a pointer to devfreq in the power model callbacks (2016-11-22 02:44:40 -0800)

----------------------------------------------------------------
Javi Merino (1):
      devfreq_cooling: pass a pointer to devfreq in the power model callbacks

Javier Martinez Canillas (3):
      thermal: max77620: Fix module autoload
      thermal: tango: Fix module autoload
      thermal: db8500: Fix module autoload

Leo Yan (1):
      thermal: hisilicon: fix for dependency

Luis Henriques (1):
      thermal: ti-soc-thermal: add missing clk_put()

Lukasz Luba (1):
      devfreq_cooling: make the structs devfreq_cooling_xxx visible for all

Shawn Lin (2):
      thermal: rockchip: improve the warning log
      dt-bindings: rockchip-thermal: fix the misleading description

Stephen Boyd (1):
      thermal: qcom-spmi: Treat reg property as a single cell

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 3 +++
 drivers/thermal/Kconfig                                        | 4 +++-
 drivers/thermal/db8500_thermal.c                               | 1 +
 drivers/thermal/devfreq_cooling.c                              | 5 +++--
 drivers/thermal/max77620_thermal.c                             | 1 +
 drivers/thermal/qcom-spmi-temp-alarm.c                         | 6 +++---
 drivers/thermal/rockchip_thermal.c                             | 7 ++-----
 drivers/thermal/tango_thermal.c                                | 1 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                    | 5 +++--
 include/linux/devfreq_cooling.h                                | 9 ++++++---
 10 files changed, 26 insertions(+), 16 deletions(-)
