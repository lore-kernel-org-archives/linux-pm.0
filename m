From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v5 0/2] power: act8945a: add charger driver for the sub-device of ACT8945A MFD
Date: Wed, 20 Jan 2016 15:04:23 +0800
Message-ID: <1453273465-24060-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:31301 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758237AbcATHHn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 02:07:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Peter Korsgaard <jacmet@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400534.html

Changes in v5:
 - remove spare spaces after #define.
 - add OF match table.
 - collect Reviewed-by from Krzysztof.

Changes in v4:
 - use spaces after #define, not tabs.
 - use BIT(n) macros to substitute (0x01 << x).
 - change dt properties with more legible name.
 - change the properties with more legible name, clearer description.

Changes in v3:
 - update the file header with short version license and author line.
 - remove unused member of struct act8945a_charger, dev.
 - action due to removing the member of stuct act8945a_dev, dev.
 - remove the unnecessary print out.
 - remove the unnecessary act8945a_charger_remove().
 - fix align of the code-style.

Changes in v2:
 1./ Substitute of_property_read_bool() for of_get_property().
 2./ Substitute devm_power_supply_register() for power_supply_register().
 3./ Use module_platform_driver(), instead of subsys_initcall().
 4./ Substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").

Wenyou Yang (2):
  power: act8945a: add charger driver for ACT8945A
  power: add documentation for ACT8945A's charger DT bindings

 .../devicetree/bindings/power/act8945a-charger.txt |   33 ++
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/act8945a_charger.c                   |  375 ++++++++++++++++++++
 4 files changed, 416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
 create mode 100644 drivers/power/act8945a_charger.c

-- 
1.7.9.5

