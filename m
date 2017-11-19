From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] regulator: Update code examples in documentation
Date: Sun, 19 Nov 2017 06:09:07 +0100
Message-ID: <20171119050907.5043-2-j.neuschaefer@gmx.net>
References: <20171119050907.5043-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:50497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdKSFJr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Nov 2017 00:09:47 -0500
In-Reply-To: <20171119050907.5043-1-j.neuschaefer@gmx.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

This involves using the REGULATOR_SUPPLY initializer macro and
reindenting some of the code.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 Documentation/power/regulator/machine.txt | 36 ++++++++++++++-----------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/Documentation/power/regulator/machine.txt b/Documentation/power/regulator/machine.txt
index 757e3b53dc11..eff4dcaaa252 100644
--- a/Documentation/power/regulator/machine.txt
+++ b/Documentation/power/regulator/machine.txt
@@ -23,16 +23,12 @@ struct regulator_consumer_supply {
 e.g. for the machine above
 
 static struct regulator_consumer_supply regulator1_consumers[] = {
-{
-	.dev_name	= "dev_name(consumer B)",
-	.supply		= "Vcc",
-},};
+	REGULATOR_SUPPLY("Vcc", "consumer B"),
+};
 
 static struct regulator_consumer_supply regulator2_consumers[] = {
-{
-	.dev	= "dev_name(consumer A"),
-	.supply	= "Vcc",
-},};
+	REGULATOR_SUPPLY("Vcc", "consumer A"),
+};
 
 This maps Regulator-1 to the 'Vcc' supply for Consumer B and maps Regulator-2
 to the 'Vcc' supply for Consumer A.
@@ -78,20 +74,20 @@ static struct regulator_init_data regulator2_data = {
 Finally the regulator devices must be registered in the usual manner.
 
 static struct platform_device regulator_devices[] = {
-{
-	.name = "regulator",
-	.id = DCDC_1,
-	.dev = {
-		.platform_data = &regulator1_data,
+	{
+		.name = "regulator",
+		.id = DCDC_1,
+		.dev = {
+			.platform_data = &regulator1_data,
+		},
 	},
-},
-{
-	.name = "regulator",
-	.id = DCDC_2,
-	.dev = {
-		.platform_data = &regulator2_data,
+	{
+		.name = "regulator",
+		.id = DCDC_2,
+		.dev = {
+			.platform_data = &regulator2_data,
+		},
 	},
-},
 };
 /* register regulator 1 device */
 platform_device_register(&regulator_devices[0]);
-- 
2.11.0
