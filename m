From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 0/6]  thermal: add devm_ version of thermal_zone register and driver for max77620
Date: Wed, 9 Mar 2016 18:40:04 +0530
Message-ID: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The series add the devm_ version of thermal_zone_of_sensor_register/
unregister, interface details, and use this in new thermal driver
for max77620.

The header file for max77620 is part of MFD patch
	https://lkml.org/lkml/2016/2/11/186

Changes from V1:
- Run checkpatch with --strict and fix all warnings.
- Added details of interfaces in spifs-api.txt
- Added DT binding doc.

Laxman Dewangan (6):
  thermal: doc: Add details of
    thermal_zone_of_sensor_{register,unregister}
  thermal: of-thermal: Add devm version of
    thermal_zone_of_sensor_register
  thermal: Add devm_thermal_zone_of_sensor_register() in managed devices
    list
  thermal: doc: Add details of
    devm_thermal_zone_of_sensor_{register,unregister}
  thermal: max77620: Add thermal driver for reporting junction temp
  thermal: Add DT binding doc for thermal of PMIC max77620

 .../bindings/thermal/thermal-max77620.txt          |  43 ++++++
 Documentation/driver-model/devres.txt              |   4 +
 Documentation/thermal/sysfs-api.txt                |  68 ++++++++++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/of-thermal.c                       |  81 +++++++++++
 drivers/thermal/thermal-max77620.c                 | 151 +++++++++++++++++++++
 include/linux/thermal.h                            |  18 +++
 8 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-max77620.txt
 create mode 100644 drivers/thermal/thermal-max77620.c

-- 
2.1.4
