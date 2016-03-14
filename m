From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.6-rc1
Date: Sun, 13 Mar 2016 21:55:29 -0700
Message-ID: <20160314045521.GA4330@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.6-rc1 with top-most

61f846f37354fd294f3172845d9fec2c03f60a45:

  thermal: doc: Add details of devm_thermal_zone_of_sensor_{register,unregister} (2016-03-09 10:51:41 -0800)

on top of commit 2850713576e81e3b887cd92a9965fba0dd1717c0:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block (2016-02-17 11:59:23 -0800)

Specifics in this pull request:
- New driver:  Mediatek thermal driver, thanks Sascha
- New API: devm_ versions for OF thermal sensor register API, thanks Laxman
- These change have been CI tested using KernelCI bot [1,2]. \o/

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.5-rc6-28-g873b196fb797/
[2] - https://kernelci.org/build/evalenti/kernel/v4.5-rc6-28-g873b196fb797/

BR,

Eduardo Valentin

----------------------------------------------------------------
Eduardo Valentin (2):
      thermal: small style cleanup in mtk_thermal
      thermal: mtk: allow compile testing on UM

Laxman Dewangan (3):
      thermal: doc: Add details of thermal_zone_of_sensor_{register,unregister}
      thermal: of-thermal: Add devm version of thermal_zone_of_sensor_register
      thermal: doc: Add details of devm_thermal_zone_of_sensor_{register,unregister}

Sascha Hauer (2):
      dt-bindings: thermal: Add binding document for Mediatek thermal controller
      thermal: Add Mediatek thermal controller support

 .../bindings/thermal/mediatek-thermal.txt          |  43 ++
 Documentation/thermal/sysfs-api.txt                |  68 +++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/mtk_thermal.c                      | 625 +++++++++++++++++++++
 drivers/thermal/of-thermal.c                       |  81 +++
 include/linux/thermal.h                            |  18 +
 7 files changed, 845 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 drivers/thermal/mtk_thermal.c
