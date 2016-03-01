From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] PM / Domains: Propagate start and restore errors during runtime resume
Date: Wed,  2 Mar 2016 01:20:38 +0200
Message-ID: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:45272 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcCAXUc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 18:20:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

During runtime resume the return values of the start and restore steps
are ignored. As a result drivers are not notified of runtime resume
failures and can't propagate them up. Fix it by returning an error if
either the start or restore step fails, and clean up properly in the
error path.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/base/power/domain.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

This fixes an issue I've noticed with my driver's .runtime_resume() handler
returning an error that was never propagated out of pm_runtime_get_sync().

A second issue then appeared. The device .runtime_error field is set to the
error code returned by my .runtime_resume() handler, but it never reset. Any
subsequent try to resume the device fails with -EINVAL. I'm not sure what the
right way to solve that is, advices are welcome.

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 301b785f9f56..8cfcb8d6179b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -485,8 +485,13 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (timed && runtime_pm)
 		time_start = ktime_get();
 
-	genpd_start_dev(genpd, dev);
-	genpd_restore_dev(genpd, dev);
+	ret = genpd_start_dev(genpd, dev);
+	if (ret)
+		goto err_poweroff;
+
+	ret = genpd_restore_dev(genpd, dev);
+	if (ret)
+		goto err_stop;
 
 	/* Update resume latency value if the measured time exceeds it. */
 	if (timed && runtime_pm) {
@@ -501,6 +506,17 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	}
 
 	return 0;
+
+err_stop:
+	genpd_stop_dev(genpd, dev);
+err_poweroff:
+	if (!dev->power.irq_safe) {
+		mutex_lock(&genpd->lock);
+		genpd_poweroff(genpd, 0);
+		mutex_unlock(&genpd->lock);
+	}
+
+	return ret;
 }
 
 static bool pd_ignore_unused;
-- 
Regards,

Laurent Pinchart

