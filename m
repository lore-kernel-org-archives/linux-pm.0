From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 0/3] thermal: add devm_ version of thermal_zone register and driver for max77620
Date: Fri, 4 Mar 2016 19:10:07 +0530
Message-ID: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, corbet@lwn.net
Cc: rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The series add the devm_ version of thermal_zone_of_sensor_register/unregister
and use this in new thermal driver for max77620.

The header file for max77620 is part of MFD patch
	https://lkml.org/lkml/2016/2/11/186

Laxman Dewangan (3):
  thermal: of-thermal: Add devm version of
    thermal_zone_of_sensor_register
  thermal: Add devm_thermal_zone_of_sensor_register() in managed devices
    list
  thermal: max77620: Add thermal driver for reporting junction temp

 Documentation/driver-model/devres.txt |   4 +
 drivers/thermal/Kconfig               |   9 ++
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/of-thermal.c          |  81 ++++++++++++++++++
 drivers/thermal/thermal-max77620.c    | 151 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h               |  18 ++++
 6 files changed, 264 insertions(+)
 create mode 100644 drivers/thermal/thermal-max77620.c

-- 
2.1.4
