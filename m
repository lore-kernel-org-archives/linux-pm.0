From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 00/11] power: act8945a_charger: Improvements
Date: Thu, 25 Aug 2016 15:19:48 +0800
Message-ID: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:59080 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbcHYHU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 03:20:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch series is to improve the implementation of act8945a-charger
driver, such as regard the act8945-charger as a sub-device, improve
the way to check the status, fix the power supply type property,
add the status change update, and add more properties: capacity level
property and max current property.

Changes in v8:
 - Achieve "interrupts" property from its own node directly.
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "lbo-gpios".
 - Add missing return -EPROBE_DEFER  for "lbo-gpios".
 - As the act8945a_charger is regarded as a sub-device, all
   properties can be achieved from its own device node,
   use devm_gpiod_get() properly as well to get "chglev-gpios".
 - Add missing return -EPROBE_DEFER  for "chglev-gpios".
 - Since the act8945a-charger is regarded as a sub-device, update
   the compatible decription and examples.
 - Add 4 new patches: 1/11, 2/11, 9/11, and 11/11.

Changes in v7:
 - Fix the missing negation sign.
 - Add a prompt information if the charger suspended.
 - Fix the wrong using devm_request_irq() with with parent
   device as *dev.
 - For "lbo-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "lbo-gpios".
 - Use dev_info() to print log if the lbo irq request failed.
 - Remove unneeded semicolon.
 - Add depends on GPIOLIB for use gpiod.
 - For "chglev-gpios", use gpiod_get() to fix devm_gpiod_get() wrong use
   with parent device as *dev argument.
 - Add the handle -EPROBE_DEFER returned from gpiod_get "chglev-gpio".
 - Remove unneeded semicolon.

Changes in v6:
 - Add .remove callback function.
 - Fix the 'dev' argument of devm_request_irq() to pdev->dev.parent.
 - For "lbo-gpios", use gpiod API instead of old gpio API to handle.
 - For "chglev-gpios", use gpiod API instead of old gpio API to handle.

Changes in v5:
 - Add Acked-by tag.

Changes in v4:
 - Use "interrupts" property, instead of "active-semi,irq-gpios"
   for irq.
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".
 - Fix wrong gpio assignment for chglev_pin.
 - Update the doc/binding for using "interrupts" property.

Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

Wenyou Yang (11):
  mfd: act8945a: Add .of_compatible for act8945a-charger
  power: act8945a_charger: Achieve properties from its node
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: mfd: act8945a: Update the example
  doc: bindings: power: act8945a-charger: Update properties.
  ARM: at91/dt: sama5d2_xplained: Add act8945a-charger node.

 Documentation/devicetree/bindings/mfd/act8945a.txt |  22 +-
 .../bindings/power/supply/act8945a-charger.txt     |  31 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  23 +-
 drivers/mfd/act8945a.c                             |   1 +
 drivers/power/supply/Kconfig                       |   2 +-
 drivers/power/supply/act8945a_charger.c            | 401 ++++++++++++++++++---
 6 files changed, 409 insertions(+), 71 deletions(-)

-- 
2.7.4

