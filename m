From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V7 00/12] Add T210 support in Tegra soctherm
Date: Fri, 11 Mar 2016 11:09:11 +0800
Message-ID: <1457665763-29781-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This patchset adds following functions for tegra_soctherm driver:
1. add T210 support.
2. export debugfs to show some registers.
3. add thermtrip funciton.
4. add suspend/resume function.

The v6 series is in:
https://lkml.org/lkml/2016/2/22/66
The v5 series is in:
http://www.spinics.net/lists/linux-tegra/msg25079.html
The v4 series is in:
http://www.spinics.net/lists/linux-tegra/msg24972.html
The V3 series is in:
http://www.spinics.net/lists/linux-tegra/msg24911.html
The V2 series is in:
http://www.spinics.net/lists/linux-tegra/msg24901.html
The V1 series is in:
http://www.spinics.net/lists/linux-tegra/msg24808.html

Main changes from V6:
1. rebased patches on Eduardo's
[PATCH 00/13] thermal: convert users of thermal_zone_of_sensor_register to devm_

Main changes from V5:
1. Change to use linux thermal framework to implement
thermtrip funciton, per Rob's comment.
2. Add .set_trip_temp() in of-thermal driver, so that
we can set trips on hardware.

Main changes from V4:
1. Change description of devicetree binding per Rob's comment.
2. Call of_node_put to decrement refcount of the node.

Main changes from V3:
1. Change structures to "const" in chip specific files.
2. Minor changes per Thieery's comments.

Main changes from V2:
1. Fix build error in patch [1/11].
2. Use of_get_child_by_name instead of of_find_node_by_name in patch [8/11].
3. Use debugfs_remove_recursive to remove debugfs in patch [6/11].

Main changes from V1:
1. Use the new type to handl different Tegra chips in one driver, which suggested by Thierry.
2. Changes per Thieery's other comments.

Wei Ni (12):
  thermal: tegra: move tegra thermal files into tegra directory
  thermal: tegra: combine sensor group-related data
  thermal: tegra: get rid of PDIV/HOTSPOT hack
  thermal: tegra: split tegra_soctherm driver
  thermal: tegra: add Tegra210 specific SOC_THERM driver
  thermal: tegra: add a debugfs to show registers
  thermal: of-thermal: allow setting trip_temp on hardware
  of: add notes of critical trips for soctherm
  thermal: tegra: add thermtrip function
  thermal: tegra: add PM support
  arm64: tegra: add soctherm node for Tegra210
  arm: tegra: set critical trips for Tegra124

 .../devicetree/bindings/thermal/tegra-soctherm.txt |  12 +
 arch/arm/boot/dts/tegra124.dtsi                    |  16 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  60 ++
 drivers/thermal/Kconfig                            |  12 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/of-thermal.c                       |   8 +
 drivers/thermal/tegra/Kconfig                      |  13 +
 drivers/thermal/tegra/Makefile                     |   5 +
 drivers/thermal/tegra/soctherm-fuse.c              | 169 +++++
 drivers/thermal/tegra/soctherm.c                   | 681 +++++++++++++++++++++
 drivers/thermal/tegra/soctherm.h                   | 123 ++++
 drivers/thermal/tegra/tegra124-soctherm.c          | 196 ++++++
 drivers/thermal/tegra/tegra210-soctherm.c          | 197 ++++++
 drivers/thermal/tegra_soctherm.c                   | 463 --------------
 include/dt-bindings/thermal/tegra124-soctherm.h    |   1 +
 include/linux/thermal.h                            |   1 +
 16 files changed, 1485 insertions(+), 474 deletions(-)
 create mode 100644 drivers/thermal/tegra/Kconfig
 create mode 100644 drivers/thermal/tegra/Makefile
 create mode 100644 drivers/thermal/tegra/soctherm-fuse.c
 create mode 100644 drivers/thermal/tegra/soctherm.c
 create mode 100644 drivers/thermal/tegra/soctherm.h
 create mode 100644 drivers/thermal/tegra/tegra124-soctherm.c
 create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
 delete mode 100644 drivers/thermal/tegra_soctherm.c

-- 
1.9.1
