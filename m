From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] cpufreq: dt: fix potential double put of cpu OF node
Date: Fri, 26 Sep 2014 15:33:46 +0200
Message-ID: <1411738426-18375-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45800 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbaIZNdt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:33:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

If cpufreq_generic_init() fails we jump into the resource
cleanup path which contains a of_node_put() call. Another
instance of this has already been called at that time
resulting a double decrement of the refcount.

Fix this by calling of_node_put() only after we are sure
that nothing has gone wrong.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/cpufreq/cpufreq-dt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e00265066a75..6bbb8b913446 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -259,7 +259,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		else
 			priv->cdev = cdev;
 	}
-	of_node_put(np);
 
 	priv->cpu_dev = cpu_dev;
 	priv->cpu_reg = cpu_reg;
@@ -270,6 +269,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto out_cooling_unregister;
 
+	of_node_put(np);
+
 	return 0;
 
 out_cooling_unregister:
-- 
2.1.0

