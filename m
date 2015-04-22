From: ahaslam@baylibre.com
Subject: [RFC v4 3/8] ARM: s3c64xx: pm: Convert to multiple states
Date: Wed, 22 Apr 2015 11:45:30 +0200
Message-ID: <1429695935-15815-4-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34556 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:31 -0400
Received: by wgso17 with SMTP id o17so240776215wgs.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:30 -0700 (PDT)
In-Reply-To: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The generic power domain framework added structure changes
to support multiple intermediate states when powering off a domain.

These changes are needed to prevent compilation breaks with
the new structures.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-s3c64xx/pm.c | 57 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index aaf7bea..8536d14 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -89,8 +89,12 @@ static struct s3c64xx_pm_domain s3c64xx_pm_irom = {
 	.name = "IROM",
 	.ena = S3C64XX_NORMALCFG_IROM_ON,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		},
+		.state_count = 1,
 	},
 };
 
@@ -99,8 +103,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_etm = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_ETM_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_ETM,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -109,8 +116,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_s = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_S_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_S,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -119,8 +129,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_f = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_F_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_F,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -129,8 +142,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_p = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_P_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_P,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -139,8 +155,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_i = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_I_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_I,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -148,8 +167,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_g = {
 	.name = "G",
 	.ena = S3C64XX_NORMALCFG_DOMAIN_G_ON,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
@@ -158,8 +180,11 @@ static struct s3c64xx_pm_domain s3c64xx_pm_v = {
 	.ena = S3C64XX_NORMALCFG_DOMAIN_V_ON,
 	.pwr_stat = S3C64XX_BLKPWRSTAT_V,
 	.pd = {
-		.power_off = s3c64xx_pd_off,
-		.power_on = s3c64xx_pd_on,
+		.states[0] = {
+			.name = "off",
+			.power_off = s3c64xx_pd_off,
+			.power_on = s3c64xx_pd_on,
+		}
 	},
 };
 
-- 
1.9.1

