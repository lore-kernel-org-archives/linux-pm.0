From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 0/2] Thermal MMIO Driver
Date: Sun, 3 Mar 2019 10:49:24 +0200
Message-ID: <1551602966-2334-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, ronenk@amazon.com, hanochu@amazon.com
List-Id: linux-pm@vger.kernel.org

This series introduces the generic thermal MMIO driver that will use
memory mapped reads to get the temperature.  Any HW/System that
allows temperature reading by a single memory-mapped reading, be it
register or shared memory, is a potential candidate to work with this
driver.

This driver is most suitable for cases such as the following:
- The entire thermal HW setup is done by another SW entity (e.g.
  bootloader) and all that is left is to read the current temperature from
  a register.
- The thermal HW setup is done via an external CPU (e.g. micro-controller)
  and that CPU has is using shared memory that can be memory-mapped to this
  driver.
- The thermal HW setup and reading is done via CPLD, which exports the
  current temperature to the system via a register.
- The thermal HW is working out-of-the-box and only reports temperature via
  a single register access.



Talel Shenhar (2):
  dt-bindings: thermal: thermal_mmio: Add binding documentation
  thermal: Introduce thermal MMIO

 .../devicetree/bindings/thermal/thermal_mmio.txt   | 173 +++++++++++++++++
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/thermal_mmio.c                     | 214 +++++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal_mmio.txt
 create mode 100644 drivers/thermal/thermal_mmio.c

-- 
2.7.4
