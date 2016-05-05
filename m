From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v3 2/5] mfd: axp20x: Add a cell for the ac power_supply part of the axp20x PMICs
Date: Thu,  5 May 2016 12:35:05 +0200
Message-ID: <1462444508-9363-3-git-send-email-haas@computerlinguist.org>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:44950 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563AbcEEKfY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 06:35:24 -0400
In-Reply-To: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: hdegoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

As a counterpart to the usb power_supply cell, this commit adds an AC
power_supply cell to the axp20x driver.

Still missing are the RTC backup battery and the main battery charger
cells.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 drivers/mfd/axp20x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index a57d6e9..aa6ef08 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -128,6 +128,12 @@ static struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
+static struct resource axp20x_ac_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
+};
+
 static struct resource axp20x_pek_resources[] = {
 	{
 		.name	= "PEK_DBR",
@@ -436,6 +442,11 @@ static struct mfd_cell axp20x_cells[] = {
 	}, {
 		.name		= "axp20x-regulator",
 	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp202-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
+	}, {
 		.name		= "axp20x-usb-power-supply",
 		.of_compatible	= "x-powers,axp202-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
-- 
2.8.2

