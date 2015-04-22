From: ahaslam@baylibre.com
Subject: [RFC v4 5/8] ARM: r8a7779: pm: Convert to multiple states
Date: Wed, 22 Apr 2015 11:45:32 +0200
Message-ID: <1429695935-15815-6-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36487 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:35 -0400
Received: by wgen6 with SMTP id n6so25749666wge.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:34 -0700 (PDT)
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

