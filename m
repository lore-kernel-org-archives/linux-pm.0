From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return an error code
Date: Tue, 28 Oct 2014 15:38:10 +0100
Message-ID: <1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:50195 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbaJ1Oic (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 10:38:32 -0400
Received: by mail-lb0-f175.google.com with SMTP id b6so710533lbj.20
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 07:38:30 -0700 (PDT)
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Typically an ->attach_dev() callback would fetch some PM resourses.

Those operations, like for example clk_get() may fail with different
errors, including -EPROBE_DEFER. Instead of ignoring these errors and
potentially only print an error message, let's propagate them to give
callers the option to handle them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 11 +++++++++--
 include/linux/pm_domain.h   |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4e5fcd7..da40769 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1394,12 +1394,19 @@ static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
 	if (ret)
 		goto err_data;
 
-	if (genpd->attach_dev)
-		genpd->attach_dev(dev);
+	if (genpd->attach_dev) {
+		ret = genpd->attach_dev(dev);
+		if (ret)
+			goto err_attach;
+	}
 
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 	return 0;
 
+ err_attach:
+	spin_lock_irq(&dev->power.lock);
+	dev->power.subsys_data->domain_data = NULL;
+	spin_unlock_irq(&dev->power.lock);
  err_data:
 	kfree(gpd_data);
  err_alloc:
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e4edde1..70a3bc3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -72,7 +72,7 @@ struct generic_pm_domain {
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	struct gpd_cpuidle_data *cpuidle_data;
-	void (*attach_dev)(struct device *dev);
+	int (*attach_dev)(struct device *dev);
 	void (*detach_dev)(struct device *dev);
 };
 
-- 
1.9.1

