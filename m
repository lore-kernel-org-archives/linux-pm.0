From: Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 0/6] Add support for Ettus Research E31x devices PMU
Date: Mon, 11 Feb 2019 19:01:37 -0600
Message-ID: <20190212010143.3729-1-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com, Virendra Kakade <virendra.kakade@ni.com>
List-Id: linux-pm@vger.kernel.org

E31x devices are embedded devices made by Ettus Research which have
a Zynq based FPGA architecture. This code adds driver support for the
charger and battery to enable query of properties like voltage,
temperature, charge and online status among others via the device tree
on addition of overlay.

The driver follows a MFD structure with a parent driver and two
sub-drivers.

* Patch 1 and 2: Add device bindings and E31x-PMU MFD device driver

* Patch 3 and 4: Add device bindings for the charger and the sub-driver
  for it. This driver shares the register map from its parent MFD
  driver.

* Patch 5 and 6: Add device bindings for the battery and the sub-driver
  for it. Register map is re-used.

Virendra Kakade (6):
  mfd: Support for Ettus Research E31x devices PMU
  mfd: Support for Ettus Research E31x devices PMU
  power: supply: Ettus Research E31x charger driver
  power: supply: Ettus Research E31x charger driver
  power: supply: Ettus Research E31x battery driver
  power: supply: Ettus Research E31x battery driver

 .../devicetree/bindings/mfd/e31x-pmu.txt      |  28 ++
 .../bindings/power/supply/e31x-battery.txt    |  14 +
 .../bindings/power/supply/e31x-charger.txt    |  14 +
 drivers/mfd/Kconfig                           |   7 +
 drivers/mfd/Makefile                          |   2 +-
 drivers/mfd/e31x-pmu.c                        |  89 +++++
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   2 +
 drivers/power/supply/e31x-battery.c           | 357 ++++++++++++++++++
 drivers/power/supply/e31x-charger.c           | 190 ++++++++++
 include/linux/mfd/e31x-pmu.h                  |  35 ++
 11 files changed, 749 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-charger.txt
 create mode 100644 drivers/mfd/e31x-pmu.c
 create mode 100644 drivers/power/supply/e31x-battery.c
 create mode 100644 drivers/power/supply/e31x-charger.c
 create mode 100644 include/linux/mfd/e31x-pmu.h

-- 
2.17.1
