From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 0/8] mfd: intel_soc_pmic_bxtwc: Add chained IRQ support
Date: Wed, 31 May 2017 15:37:08 -0700
Message-ID: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20170531070225.bymdhhpclidwwtpt@dell>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170531070225.bymdhhpclidwwtpt@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, lee.jones@linaro.org, andy@infradead.org
Cc: linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Following patch set adds chained IRQ support to WCOVE PMIC driver.

Changes since v3:
 * Added fix for typec wcove driver.

Changes since v4:
 * Squashed following two commits, to keep the patch set bisectable.
   usb: typec: typec_wcove: Use charger irq chip to get usbc virq
   mfd: intel_soc_pmic_bxtwc: use chained irqs for second level irq chips

Kuppuswamy Sathyanarayanan (8):
  mfd: intel_soc_pmic_bxtwc: Fix TMU interrupt index
  mfd: intel_soc_pmic_bxtwc: Remove thermal second level irqs
  thermal: intel_bxt_pmic_thermal: Use first level PMIC thermal irq
  mfd: intel_soc_pmic_bxtwc: Remove second level irq for gpio device
  gpio: gpio-wcove: Use first level PMIC GPIO irq
  mfd: intel_soc_pmic_bxtwc: Utilize devm_* functions in driver probe
  mfd: intel_soc_pmic_bxtwc: Use chained irqs for second level irq chips
  platform/x86: intel_bxtwc_tmu: Remove first level irq unmask

 drivers/gpio/gpio-wcove.c                |  14 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c       | 234 ++++++++++++++++++++-----------
 drivers/platform/x86/intel_bxtwc_tmu.c   |   4 -
 drivers/thermal/intel_bxt_pmic_thermal.c |   2 +-
 drivers/usb/typec/typec_wcove.c          |   2 +-
 include/linux/mfd/intel_soc_pmic.h       |   5 +-
 6 files changed, 175 insertions(+), 86 deletions(-)

-- 
2.7.4

