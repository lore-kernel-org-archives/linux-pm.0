From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 14/24] PM / Domains: Add late_initcall to disable unused domains
Date: Tue, 10 Jun 2014 12:51:27 +0200
Message-ID: <1402397497-26737-15-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:53047 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaFJKwj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:39 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3853188lab.17
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:38 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

As default behavior let genpd at late init try to disable the unused
domains.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 825e81d..095a4fa4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -722,6 +722,13 @@ void pm_genpd_poweroff_unused(void)
 	mutex_unlock(&gpd_list_lock);
 }
 
+static int __init genpd_poweroff_unused(void)
+{
+	pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(genpd_poweroff_unused);
+
 #else
 
 static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
-- 
1.7.9.5

