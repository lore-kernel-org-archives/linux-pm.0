From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Wed, 28 Jan 2015 13:23:37 -0800
Message-ID: <cover.1422478693.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com, jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, david.woodhouse@intel.com, jic23@kernel.org
List-Id: linux-pm@vger.kernel.org

New power_supply driver at driver/power which interfaces with the
axp20x mfd driver as a cell. Provides battery info, monitors for
changes, and generates alerts on temperature and capacity issues

Todd Brandt (3):
  mfd/axp20x: change battery cell name to fuel gauge
  mfd/axp20x: add support for fuel gauge cell
  X-Power AXP288 PMIC Fuel Gauge Driver

v1: 01/07/14
v2: 01/22/14
- replaced the const in axp20x_acpi_match declaration
- reformatted the commit text
- added IIO as driver dependency
- moved debug info to debugfs in file fuelgauge
- added HEALTH_COLD value to health calculation
- added better cleanup to remove call
        cancelling any delayed work calls
        unregistration of the power_supply
v3: 01/28/14
- moved debugs create and init config regs after error case
- freed the virqs in the remove function
- remove .owner field as it is populated automatically

 drivers/mfd/axp20x.c       |  8 ++++----
 drivers/power/Kconfig      |  9 +++++++++
 drivers/power/Makefile     |  1 +
 include/linux/mfd/axp20x.h | 43 +++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.1.0
