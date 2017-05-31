From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 0/9] WCOVE chained IRQ fix
Date: Tue, 30 May 2017 22:19:49 -0700
Message-ID: <cover.1496206507.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Following patch set fixes the chained IRQ issue observed in WCOVE PMIC driver.

Changes since v3:
 * Added fix for typec wcove driver.

Kuppuswamy Sathyanarayanan (9):
  mfd: intel_soc_pmic_bxtwc: fix TMU interrupt index
  mfd: intel_soc_pmic_bxtwc: remove thermal second level irqs
  thermal: intel_bxt_pmic_thermal: use first level PMIC thermal irq
  mfd: intel_soc_pmic_bxtwc: remove second level irq for gpio device
  gpio: gpio-wcove: use first level PMIC GPIO irq
  mfd: intel_soc_pmic_bxtwc: utilize devm_* functions in driver probe
  mfd: intel_soc_pmic_bxtwc: use chained irqs for second level irq chips
  platform: x86: intel_bxtwc_tmu: remove first level irq unmask
  usb: typec: typec_wcove: Use charger irq chip to get usbc virq

 drivers/gpio/gpio-wcove.c                |  14 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c       | 234 ++++++++++++++++++++-----------
 drivers/platform/x86/intel_bxtwc_tmu.c   |   4 -
 drivers/thermal/intel_bxt_pmic_thermal.c |   2 +-
 drivers/usb/typec/typec_wcove.c          |   2 +-
 include/linux/mfd/intel_soc_pmic.h       |   5 +-
 6 files changed, 175 insertions(+), 86 deletions(-)

-- 
2.7.4
