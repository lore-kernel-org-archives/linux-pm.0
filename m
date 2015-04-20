From: ahaslam@baylibre.com
Subject: [RFC v3 5/7] ARM: r8a7779: pm: Convert to multiple states
Date: Mon, 20 Apr 2015 17:02:06 +0200
Message-ID: <1429542128-21021-6-git-send-email-ahaslam@baylibre.com>
References: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33886 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbDTPCX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 11:02:23 -0400
Received: by wicmx19 with SMTP id mx19so42196754wic.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2015 08:02:22 -0700 (PDT)
In-Reply-To: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The generic power domain framework added structure changes
to support multiple intermediate states when powering off a domain.

These changes are needed to prevent compilation breaks with
the new structures.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-shmobile/pm-r8a7779.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 44a74c4..2f1d1e8 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -86,8 +86,10 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, NULL, false);
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
+	genpd->states[0].power_off = pd_power_down;
+	genpd->states[0].power_on = pd_power_up;
+	genpd->states[0].name = "off";
+	genpd->state_count = 1;
 
 	if (pd_is_off(&r8a7779_pd->genpd))
 		pd_power_up(&r8a7779_pd->genpd);
-- 
1.9.1

