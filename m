From: ahaslam@baylibre.com
Subject: [RFC v5 7/8] ARM: ux500: pm: Convert to multiple states
Date: Fri, 24 Apr 2015 19:35:23 +0200
Message-ID: <1429896924-21540-8-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36764 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966672AbbDXRfy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:54 -0400
Received: by wgen6 with SMTP id n6so57897701wge.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:53 -0700 (PDT)
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
 arch/arm/mach-ux500/pm_domains.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 4d71c90..c155eaa 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -39,10 +39,18 @@ static int pd_power_on(struct generic_pm_domain *domain)
 	return 0;
 }
 
+struct genpd_power_state ux500_genpd_states[] = {
+	{
+		.name = "OFF",
+	}
+};
+
 static struct generic_pm_domain ux500_pm_domain_vape = {
 	.name = "VAPE",
 	.power_off = pd_power_off,
 	.power_on = pd_power_on,
+	.states = ux500_genpd_states,
+	.state_count = ARRAY_SIZE(ux500_genpd_states),
 };
 
 static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
-- 
1.9.1

