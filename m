From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/4] PM / Domains: Take WAKEUP_PATH driver flag into account in genpd
Date: Fri, 29 Dec 2017 12:37:02 +0100
Message-ID: <1514547423-18965-4-git-send-email-ulf.hansson@linaro.org>
References: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44300 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbdL2LhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Dec 2017 06:37:22 -0500
Received: by mail-lf0-f67.google.com with SMTP id g63so25812599lfl.11
        for <linux-pm@vger.kernel.org>; Fri, 29 Dec 2017 03:37:22 -0800 (PST)
In-Reply-To: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

In case the WAKEUP_PATH flag has been set in a later phase than from the
->suspend() callback, the PM core don't set the ->power.wakeup_path status
flag for the device. Therefore, let's be safe and check it explicitly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f9dcc98..32b4ba7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1038,7 +1038,9 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if ((dev->power.wakeup_path ||
+	    dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH)) &&
+	    genpd_is_active_wakeup(genpd))
 		return 0;
 
 	if (poweroff)
@@ -1093,7 +1095,9 @@ static int genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+	if ((dev->power.wakeup_path ||
+	    dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH)) &&
+	    genpd_is_active_wakeup(genpd))
 		return 0;
 
 	genpd_lock(genpd);
-- 
2.7.4
