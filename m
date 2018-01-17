From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 5/5] power: supply: gpio-charger: LM3658 support
Date: Wed, 17 Jan 2018 21:33:02 +0100
Message-ID: <20180117203302.GF8774@lenoch>
References: <20180117202701.GA8774@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:33078 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeAQUdE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 15:33:04 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994692AbeAQUdDnk2TE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 21:33:03 +0100
Content-Disposition: inline
In-Reply-To: <20180117202701.GA8774@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Just a proof of concept...

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/gpio-charger.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 463e0abe975b..1628ac1e84d1 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -441,6 +441,21 @@ struct gpio_charger_mapping chrg_fault_mapping[] = {
 	},
 };
 
+struct gpio_charger_mapping stat12_mapping[] = {
+	{
+		POWER_SUPPLY_PROP_STATUS,
+		POWER_SUPPLY_STATUS_NOT_CHARGING,
+		MAP(0x03,
+		{ 0x01, POWER_SUPPLY_STATUS_CHARGING },
+		{ 0x02, POWER_SUPPLY_STATUS_FULL }),
+	}, {
+		POWER_SUPPLY_PROP_HEALTH,
+		POWER_SUPPLY_HEALTH_GOOD,
+		MAP(0x03,
+		{ 0x03, POWER_SUPPLY_HEALTH_DEAD }),
+	},
+};
+
 static const struct gpio_charger_config ltc3651_cfg = {
 	MAPPING(chrg_fault_mapping),
 	{
@@ -451,12 +466,25 @@ static const struct gpio_charger_config ltc3651_cfg = {
 	},
 };
 
+static const struct gpio_charger_config lm3658_cfg = {
+	MAPPING(stat12_mapping),
+	{
+		{ "ti,stat1", 0 },
+		{ "ti,stat2", 0 },
+		{ NULL, 0 },
+	},
+};
+
 static const struct of_device_id gpio_charger_match[] = {
 	{	.compatible = "gpio-charger" },
 	{
 		.compatible = "lltc,ltc3651-charger",
 		.data = (void *) &ltc3651_cfg,
 	},
+	{
+		.compatible = "ti,lm3658",
+		.data = (void *) &lm3658_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gpio_charger_match);
-- 
2.15.1
