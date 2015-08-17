From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 00/21] ARM: pxa: magician: Rework HTC Magician support
Date: Mon, 17 Aug 2015 23:55:07 +0200
Message-ID: <55D2583B.8040602@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:49387 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbHQVwR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:52:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patchset will clean, fix and finally add multiple PXA devices
to HTC Magician machine. Also it adds leds-pasic3 driver to LED subsystem.
This driver require changes into htc-pasic3 structures, which are used
exclusively by magician.c code.

Petr Cvek (21):
  ARM: pxa: magician: Fix Kconfig for magician to always include
    htc-egpio
  ARM: pxa: magician: Fix indentation and whitespaces
  ARM: pxa: magician: Fix comments, debug functions and print strings
  ARM: pxa: magician: Add, fix and init (new) GPIOs
  ARM: pxa: magician: Add support for ADS7846 touchscreen
  ARM: pxa: magician: Add normal and power I2C definition
  ARM: pxa: magician: Fix IrDA pdata and redundant GPIO request
  ARM: pxa: magician: Add StrataFlash Vpp GPIO and alternative driver
  ARM: pxa: magician: Add OV9640 camera support
  ARM: pxa: magician: Add UDA1380 sound support
  ARM: pxa: magician: Add MAX1586 Vcore regulator support
  ARM: pxa: magician: Add PXA27x UDC support
  ARM: pxa: magician: Fix charging source and add NiCd backup charging
  ARM: pxa: magician: Fix PXA USB OHCI port enable flags
  ARM: pxa: magician: Fix PWM backlight regulator
  ARM: pxa: magician: Add support for alternative LCD backlight
  ARM: pxa: magician: Remove (temporarily) pasic3 LED support
  mfd: htc-pasic3: Prepare driver for leds-pasic3
  leds: leds-pasic3: Add support for PASIC3 LED controller
  ARM: pxa: magician: Re-add pdata for new leds-pasic3 driver
  ARM: pxa: magician: Move platform_add_devices() to the end of
    magician_init()

 arch/arm/mach-pxa/Kconfig                 |    1 +
 arch/arm/mach-pxa/include/mach/magician.h |   39 +-
 arch/arm/mach-pxa/magician.c              | 1153 ++++++++++++++++++++++-------
 drivers/leds/Kconfig                      |    9 +
 drivers/leds/Makefile                     |    1 +
 drivers/leds/leds-pasic3.c                |  232 ++++++
 drivers/mfd/htc-pasic3.c                  |   54 +-
 include/linux/mfd/htc-pasic3.h            |   85 ++-
 8 files changed, 1255 insertions(+), 319 deletions(-)
 create mode 100644 drivers/leds/leds-pasic3.c

-- 
1.7.12.1

