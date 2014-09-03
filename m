From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/15] ARM: shmobile: Drop dev_irq_safe from R-mobile genpd config
Date: Wed,  3 Sep 2014 12:52:21 +0200
Message-ID: <1409741551-16437-6-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:65391 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbaICKxH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 06:53:07 -0400
Received: by mail-we0-f179.google.com with SMTP id t60so8316316wes.38
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 03:53:01 -0700 (PDT)
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

The dev_irq_safe configuration is redundant, genpd don't have any
special treatmeant for handling it. Let's remove it.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index ebdd16e..818de2f 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -111,7 +111,6 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.stop		= pm_clk_suspend;
 	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
-	genpd->dev_irq_safe		= true;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
 	__rmobile_pd_power_up(rmobile_pd, false);
-- 
1.9.1

