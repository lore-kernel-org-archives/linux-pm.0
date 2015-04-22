From: ahaslam@baylibre.com
Subject: [RFC v4 7/8] ARM: ux500: pm: Convert to multiple states
Date: Wed, 22 Apr 2015 11:45:34 +0200
Message-ID: <1429695935-15815-8-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33612 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:38 -0400
Received: by wiax7 with SMTP id x7so125988052wia.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:37 -0700 (PDT)
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
 arch/arm/mach-ux500/pm_domains.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 4d71c90..7b685e3 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -41,8 +41,12 @@ static int pd_power_on(struct generic_pm_domain *domain)
 
 static struct generic_pm_domain ux500_pm_domain_vape = {
 	.name = "VAPE",
-	.power_off = pd_power_off,
-	.power_on = pd_power_on,
+	.states[0] = {
+		.power_off = pd_power_off,
+		.power_on = pd_power_on,
+		.name = "off",
+	},
+	.state_count = 1,
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
-- 
1.9.1

