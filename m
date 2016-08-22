From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v7 0/7] power: act8945a_charger: Improvements
Date: Mon, 22 Aug 2016 14:49:10 +0800
Message-ID: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:3687 "EHLO
        ussmtp01.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751284AbcHVGtg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 02:49:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch series is to improve the implementation of act8945a-charger
driver, such as improve the way to check the status, fix the power
supply type property, add the status change update, and add more
properties: capacity level property and max current property.

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
 - Add the handle -EPROBE_DEFER returned from gpiod_get "chglev_gpio".
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

Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../bindings/power/supply/act8945a-charger.txt     |  16 +-
 drivers/power/supply/Kconfig                       |   2 +-
 drivers/power/supply/act8945a_charger.c            | 418 ++++++++++++++++++---
 3 files changed, 386 insertions(+), 50 deletions(-)

-- 
2.7.4

