From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.10-rc1 #1
Date: Thu, 17 Nov 2016 19:42:32 -0800
Message-ID: <20161118034230.GA4013@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui, linux-pm,

These are essentially driver fixes, meant for an rcX. But given that we are
already 4.9-rc5 going for rc6, please, consider the following changes
for v4.10-rc1. This is my first request, I will continue monitoring
the mailing list for outstanding changes.

Therefore, please consider pulling these changes since commit 961b708e95181041f403251f660bc70be3ff6ba3:

  Merge tag 'drm-fixes-for-v4.9-rc6' of git://people.freedesktop.org/~airlied/linux (2016-11-16 17:24:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 6ee459f5f967073a240e17245d12417a5d596ed1:

  devfreq_cooling: pass a pointer to devfreq in the power model callbacks (2016-11-16 19:17:08 -0800)

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
