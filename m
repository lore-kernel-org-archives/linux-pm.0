From: ahaslam@baylibre.com
Subject: [RFC v5 5/8] ARM: r8a7779: pm: Convert to multiple states
Date: Fri, 24 Apr 2015 19:35:21 +0200
Message-ID: <1429896924-21540-6-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34841 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966681AbbDXRfu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:50 -0400
Received: by widdi4 with SMTP id di4so30383268wid.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:49 -0700 (PDT)
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
 arch/arm/mach-shmobile/pm-r8a7779.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 44a74c4..2ecca87 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -79,6 +79,12 @@ static bool pd_active_wakeup(struct device *dev)
 	return true;
 }
 
+struct genpd_power_state r8a7779_genpd_states[] = {
+	{
+		.name = "OFF",
+	}
+};
+
 static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
@@ -88,6 +94,8 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
+	genpd->states = r8a7779_genpd_states;
+	genpd->state_count = ARRAY_SIZE(r8a7779_genpd_states);
 
 	if (pd_is_off(&r8a7779_pd->genpd))
 		pd_power_up(&r8a7779_pd->genpd);
-- 
1.9.1

