From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] PM / OPP: using kfree_rcu() to simplify the code
Date: Fri, 26 Oct 2012 22:57:41 +0800
Message-ID: <CAPgLHd_HvceXF4pNhnrKH3px8h59S7zTwToAjAZzjCBm3AEmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54206 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2JZO5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Oct 2012 10:57:42 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1353428qcr.19
        for <linux-pm@vger.kernel.org>; Fri, 26 Oct 2012 07:57:41 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org
Cc: yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The callback function of call_rcu() just calls a kfree(), so we
can use kfree_rcu() instead of call_rcu() + callback function.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/base/power/opp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index c8a908b..50b2831 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -461,17 +461,6 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 }
 
 /**
- * opp_free_rcu() - helper to clear the struct opp when grace period has
- * elapsed without blocking the the caller of opp_set_availability
- */
-static void opp_free_rcu(struct rcu_head *head)
-{
-	struct opp *opp = container_of(head, struct opp, head);
-
-	kfree(opp);
-}
-
-/**
  * opp_set_availability() - helper to set the availability of an opp
  * @dev:		device for which we do this operation
  * @freq:		OPP frequency to modify availability
@@ -542,7 +531,7 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 
 	list_replace_rcu(&opp->node, &new_opp->node);
 	mutex_unlock(&dev_opp_list_lock);
-	call_rcu(&opp->head, opp_free_rcu);
+	kfree_rcu(opp, head);
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)

