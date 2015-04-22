From: ahaslam@baylibre.com
Subject: [RFC v4 6/8] ARM: rmobile: pm: Convert to multiple states
Date: Wed, 22 Apr 2015 11:45:33 +0200
Message-ID: <1429695935-15815-7-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36586 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:37 -0400
Received: by wizk4 with SMTP id k4so170772641wiz.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:36 -0700 (PDT)
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
 arch/arm/mach-shmobile/pm-rmobile.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 9501820..8badaae 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -156,8 +156,10 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
-	genpd->power_off		= rmobile_pd_power_down;
-	genpd->power_on			= rmobile_pd_power_up;
+	genpd->states[0].power_off	= rmobile_pd_power_down;
+	genpd->states[0].power_on	= rmobile_pd_power_up;
+	genpd->states[0].name		= "off";
+	genpd->state_count		= 1;
 	genpd->attach_dev		= rmobile_pd_attach_dev;
 	genpd->detach_dev		= rmobile_pd_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
-- 
1.9.1

