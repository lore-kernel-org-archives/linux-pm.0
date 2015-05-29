From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH v7 0/3] Add support for Richtek RT9455 battery charger
Date: Fri, 29 May 2015 17:25:42 +0300
Message-ID: <1432909545-31895-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31373 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbbE2OWj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 May 2015 10:22:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

The next 3 patches do the following:
- first patch adds Richtek Technology Corporation in the vendor-prefixes list
- second patch adds device tree binding example for Richtek RT9455 battery charger
- third patch adds the driver for Richtek RT9455 battery charger

The reason why v6 did not contain any modification except for patch splitting, is that
I did not scroll down the e-mail and I thought the patch splitting was the only modification
I need to do. My bad.

Updates from v6:
- added interrupt-parent and interrupts as required properties in DT file rt9455_charger.txt.
- removed interrupt-gpio and reset-gpio from DT file rt9455_charger.txt.
- used IRQ_TYPE_LEVEL_LOW (for this charger, it works the same with IRQ_TYPE_EDGE_RISING and
  with IRQ_TYPE_LEVEL_LOW, but I prefer IRQ_TYPE_LEVEL_LOW) in interrupt specification, 
  in DT file rt9455_charger.txt.
- removed gpiod_irq and gpio_irq from rt9455_info structure.
- set boost voltage value without previously reading the existing value in the register.
- set voreg value without previously reading the existing value in the register.
- removed rt9455_setup_irq function. client->irq is set even without calling of_irq_get().
- used devm_power_supply_register() and removed power_supply_unregister() from rt9455_remove().

Anda-Maria Nicolae (3):
  of: Add vendor prefix for Richtek Technology Corporation
  Documentation: devicetree: Add Richtek RT9455 bindings
  power_supply: Add support for Richtek RT9455 battery charger

 .../devicetree/bindings/power/rt9455_charger.txt   |   46 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/rt9455_charger.c                     | 1751 ++++++++++++++++++++
 5 files changed, 1806 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
 create mode 100644 drivers/power/rt9455_charger.c

-- 
1.7.9.5

