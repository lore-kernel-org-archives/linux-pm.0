From: ahaslam@baylibre.com
Subject: [RFC v5 3/8] ARM: s3c64xx: pm: Convert to multiple states
Date: Fri, 24 Apr 2015 19:35:19 +0200
Message-ID: <1429896924-21540-4-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35799 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966672AbbDXRfq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:46 -0400
Received: by widdi4 with SMTP id di4so30381544wid.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:45 -0700 (PDT)
In-Reply-To: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The generic power domain framework added structure changes
to support multiple intermediate states when powering off a domain.

These changes are needed to prevent compilation breaks with
the new structures.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-s3c64xx/pm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index aaf7bea..446c5bd 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -85,12 +85,20 @@ static int s3c64xx_pd_on(struct generic_pm_domain *domain)
 	return 0;
 }
 
+struct genpd_power_state s3c64xx_pm_states[] = {
+	{
+		.name = "OFF",
+	}
+};
+
 static struct s3c64xx_pm_domain s3c64xx_pm_irom = {
 	.name = "IROM",
 	.ena = S3C64XX_NORMALCFG_IROM_ON,
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -101,6 +109,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_etm = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -111,6 +121,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_s = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -121,6 +133,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_f = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -131,6 +145,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_p = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -141,6 +157,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_i = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -150,6 +168,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_g = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
@@ -160,6 +180,8 @@ static struct s3c64xx_pm_domain s3c64xx_pm_v = {
 	.pd = {
 		.power_off = s3c64xx_pd_off,
 		.power_on = s3c64xx_pd_on,
+		.states = s3c64xx_pm_states,
+		.state_count = ARRAY_SIZE(s3c64xx_pm_states),
 	},
 };
 
-- 
1.9.1

