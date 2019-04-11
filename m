From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH v3 0/2] Amazon's Annapurna Labs Thermal Sensor Driver
Date: Thu, 11 Apr 2019 13:22:46 +0300
Message-ID: <1554978168-17369-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: talel@amazon.com, robh@kernel.org, edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com, rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Thermal Sensor
based on a new simple MMIO thermal driver. This driver is intended to be
used by other devices as well, which require just a simple MMIO access to
read temperature. 

Changes since v2:
=================
- dt-binding: changed node name from "thermal_z0" to "thermal-z0"
- dt-binding: changed node name from thermalz0_crit to "critical"

Changes since v1:
==================
- removed the "thermal_mmio" compatible string. With v2 version, only
  specific hardware can bound
- add initialization function that is mapped based on the specific binding
  string
- removed thermal_mmio_readl and thermal_readw, but kept mmio reads in
  callback function. Left only thermal_mmio_reab which is used by
  al-thermal
- removed divider, bias, width which are not needed for al-thermal.



Talel Shenhar (2):
  dt-bindings: thermal: al-thermal: Add binding documentation
  thermal: Introduce Amazon's Annapurna Labs Thermal Driver

 .../bindings/thermal/amazon,al-thermal.txt         |  33 ++++++
 MAINTAINERS                                        |   6 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/thermal_mmio.c                     | 129 +++++++++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
 create mode 100644 drivers/thermal/thermal_mmio.c

-- 
2.7.4
