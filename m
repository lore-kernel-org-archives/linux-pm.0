From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/5] opp: replace kfree with kfree_rcu while freeing 'struct device_opp'
Date: Wed, 10 Dec 2014 09:45:31 +0530
Message-ID: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46031 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaLJEQJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 23:16:09 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so1934863pdb.19
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 20:16:09 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Somehow one of the instance of freeing resources failed to use kfree_rcu() and
used kfree() instead. This might cause problems as the node might be referenced
by readers under rcu locks and we must wait for the rcu grace period as well.

While we are at it, also update comment over 'struct device_opp' to mention why
we are waiting for both rcu and srcu grace periods.

Fixes: 129eec55df6a ("PM / OPP Introduce APIs to remove OPPs")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

Few more updates for the opp layer. First one is a potential bug fix and rest
are cleanups.

 drivers/base/power/opp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1bbef8e838e7..e1807268cbf2 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -84,7 +84,11 @@ struct dev_pm_opp {
  *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
- * meant for book keeping and private to OPP library
+ * meant for book keeping and private to OPP library.
+ *
+ * Because the opp structures can be used from both rcu and srcu readers, we
+ * need to wait for the grace period of both of them before freeing any
+ * resources. And so we have used kfree_rcu() from within call_srcu() handlers.
  */
 struct device_opp {
 	struct list_head node;
@@ -511,7 +515,7 @@ static void kfree_device_rcu(struct rcu_head *head)
 {
 	struct device_opp *device_opp = container_of(head, struct device_opp, rcu_head);
 
-	kfree(device_opp);
+	kfree_rcu(device_opp, rcu_head);
 }
 
 void __dev_pm_opp_remove(struct device_opp *dev_opp, struct dev_pm_opp *opp)
-- 
2.2.0

