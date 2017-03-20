From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Respect errors from genpd's ->power_off() callback
Date: Mon, 20 Mar 2017 11:19:22 +0100
Message-ID: <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34593 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbdCTKUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 06:20:23 -0400
Received: by mail-lf0-f47.google.com with SMTP id z15so53400534lfd.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 03:19:38 -0700 (PDT)
In-Reply-To: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

The current code in genpd_sync_power_off(), doesn't care about potential
errors being returned from genpd's ->power_off() callback.

Obviously this behaviour could lead to problems, such as incorrectly
setting the genpd's status to GPD_STATE_POWER_OFF, but also to incorrectly
decrease the subdomain count for the masters, which potentially allows them
to be powered off in the next recursive call to genpd_sync_power_off().

Let's fix this behaviour by bailing out when the ->power_off() callback
returns an error code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e63712d..8a2bfc8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -767,7 +767,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	_genpd_power_off(genpd, false);
+	if (_genpd_power_off(genpd, false))
+		return;
 
 	genpd->status = GPD_STATE_POWER_OFF;
 
-- 
2.7.4
