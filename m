From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 6/6] mfd: da9150: Use DEFINE_RES_IRQ_NAMED() help macro for
 IRQ resource
Date: Tue, 7 Jul 2015 17:34:25 +0100
Message-ID: <a1175fd84a1f803b5ea3d9d3e5541fd59fd569b0.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.118]:8884 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757995AbbGGQei (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 12:34:38 -0400
In-Reply-To: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

Changes in v3:
 - Initial version.

Changes in v2:
 - N/A

 drivers/mfd/da9150-core.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index fccd4d5..dd4cb9b 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -355,39 +355,14 @@ static const struct regmap_irq_chip da9150_regmap_irq_chip = {
 };

 static struct resource da9150_gpadc_resources[] = {
-	{
-		.name = "GPADC",
-		.start = DA9150_IRQ_GPADC,
-		.end = DA9150_IRQ_GPADC,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_GPADC, "GPADC"),
 };

 static struct resource da9150_charger_resources[] = {
-	{
-		.name = "CHG_STATUS",
-		.start = DA9150_IRQ_CHG,
-		.end = DA9150_IRQ_CHG,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "CHG_TJUNC",
-		.start = DA9150_IRQ_TJUNC,
-		.end = DA9150_IRQ_TJUNC,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "CHG_VFAULT",
-		.start = DA9150_IRQ_VFAULT,
-		.end = DA9150_IRQ_VFAULT,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name = "CHG_VBUS",
-		.start = DA9150_IRQ_VBUS,
-		.end = DA9150_IRQ_VBUS,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_CHG, "CHG_STATUS"),
+	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_TJUNC, "CHG_TJUNC"),
+	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VFAULT, "CHG_VFAULT"),
+	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VBUS, "CHG_VBUS"),
 };

 static struct resource da9150_fg_resources[] = {
--
1.9.3

