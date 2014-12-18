From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH] regulator: rt5033-regulator: Use regulator_nodes/of_match in
 the descriptor
Date: Thu, 18 Dec 2014 20:13:36 +0900
Message-ID: <1418901216-19030-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62199 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLRLNj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 06:13:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, beomho.seo@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

This patch is add regulator_nodes/of_match in the regulator descriptor
for using information from DT instead of sppecific codes.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/regulator/rt5033-regulator.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 870cc49..96d2c18 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -36,6 +36,8 @@ static struct regulator_ops rt5033_buck_ops = {
 static const struct regulator_desc rt5033_supported_regulators[] = {
 	[RT5033_BUCK] = {
 		.name		= "BUCK",
+		.of_match	= of_match_ptr("BUCK"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_BUCK,
 		.ops		= &rt5033_buck_ops,
 		.type		= REGULATOR_VOLTAGE,
@@ -50,6 +52,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 	},
 	[RT5033_LDO] = {
 		.name		= "LDO",
+		.of_match	= of_match_ptr("LDO"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_LDO,
 		.ops		= &rt5033_buck_ops,
 		.type		= REGULATOR_VOLTAGE,
@@ -64,6 +68,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 	},
 	[RT5033_SAFE_LDO] = {
 		.name		= "SAFE_LDO",
+		.of_match	= of_match_ptr("SAFE_LDO"),
+		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_SAFE_LDO,
 		.ops		= &rt5033_safe_ldo_ops,
 		.type		= REGULATOR_VOLTAGE,
@@ -81,7 +87,7 @@ static int rt5033_regulator_probe(struct platform_device *pdev)
 	int ret, i;
 	struct regulator_config config = {};
 
-	config.dev = &pdev->dev;
+	config.dev = rt5033->dev;
 	config.driver_data = rt5033;
 
 	for (i = 0; i < ARRAY_SIZE(rt5033_supported_regulators); i++) {
-- 
1.7.9.5

