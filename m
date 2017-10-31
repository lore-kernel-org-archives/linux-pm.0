From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/5] [RFC] soc: rockchip: power-domain: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Tue, 31 Oct 2017 19:11:33 +0100
Message-ID: <1509473494-19740-5-git-send-email-geert+renesas@glider.be>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:41718 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdJaSLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2017 14:11:44 -0400
In-Reply-To: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own flag-based callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before "PM / Domain: Enable genpd users to
specify default active wakeup behavior" has landed upstream, hence the
"RFC".

Compile-tested only.

v2:
  - New.
---
 drivers/soc/rockchip/pm_domains.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 40b75748835f552c..5c342167b9db7a16 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -358,17 +358,6 @@ static void rockchip_pd_detach_dev(struct generic_pm_domain *genpd,
 	pm_clk_destroy(dev);
 }
 
-static bool rockchip_active_wakeup(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-	struct rockchip_pm_domain *pd;
-
-	genpd = pd_to_genpd(dev->pm_domain);
-	pd = container_of(genpd, struct rockchip_pm_domain, genpd);
-
-	return pd->info->active_wakeup;
-}
-
 static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 				      struct device_node *node)
 {
@@ -489,8 +478,9 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;
 	pd->genpd.detach_dev = rockchip_pd_detach_dev;
-	pd->genpd.dev_ops.active_wakeup = rockchip_active_wakeup;
 	pd->genpd.flags = GENPD_FLAG_PM_CLK;
+	if (pd_info->active_wakeup)
+		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	pm_genpd_init(&pd->genpd, NULL, false);
 
 	pmu->genpd_data.domains[id] = &pd->genpd;
-- 
2.7.4
