From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/24] PM / Domains: Remove redundant check for CONFIG_PM
Date: Tue, 10 Jun 2014 12:51:23 +0200
Message-ID: <1402397497-26737-11-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:64886 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbaFJKw3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:29 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so3705793lbv.25
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:27 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

CONFIG_PM_GENERIC_DOMAINS depends on CONFIG_PM, thus there are no need
to check explicity for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a2ebc77..0362360 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -67,8 +67,6 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 	return genpd;
 }
 
-#ifdef CONFIG_PM
-
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev->pm_domain))
@@ -282,8 +280,6 @@ int pm_genpd_name_poweron(const char *domain_name)
 	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
 }
 
-#endif /* CONFIG_PM */
-
 #ifdef CONFIG_PM_RUNTIME
 
 static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
-- 
1.7.9.5

