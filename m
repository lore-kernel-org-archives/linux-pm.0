From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v4 0/7] power: act8945a_charger: Improvements
Date: Mon, 8 Aug 2016 14:08:42 +0800
Message-ID: <1470636529-16387-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

This patch series is to improve the implementation of act8945a-charger
driver, such as improve the way to check the status, fix the power
supply type property, add the status change update, and add more
properties: capacity level property and max current property.

Changes in v4:
 - Use "interrupts" property, instead of "active-semi,lbo-gpios"
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

 .../devicetree/bindings/power/act8945a-charger.txt |  16 +-
 drivers/power/act8945a_charger.c                   | 373 ++++++++++++++++++---
 2 files changed, 348 insertions(+), 41 deletions(-)

-- 
2.7.4
