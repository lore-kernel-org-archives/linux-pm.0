From: ahaslam@baylibre.com
Subject: [RFC v5 6/8] ARM: rmobile: pm: Convert to multiple states
Date: Fri, 24 Apr 2015 19:35:22 +0200
Message-ID: <1429896924-21540-7-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36635 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966672AbbDXRfw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:52 -0400
Received: by wizk4 with SMTP id k4so30408562wiz.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:51 -0700 (PDT)
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
 arch/arm/mach-shmobile/pm-rmobile.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 9501820..038376c 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -148,6 +148,12 @@ static void rmobile_pd_detach_dev(struct generic_pm_domain *domain,
 	pm_clk_destroy(dev);
 }
 
+struct genpd_power_state rmobile_genpd_states[] = {
+	{
+		.name = "OFF",
+	}
+};
+
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
@@ -158,6 +164,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
+	genpd->states = rmobile_genpd_states;
+	genpd->state_count = ARRAY_SIZE(rmobile_genpd_states);
 	genpd->attach_dev		= rmobile_pd_attach_dev;
 	genpd->detach_dev		= rmobile_pd_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
-- 
1.9.1

