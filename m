From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 5/8] opp: replace kfree_rcu() with call_srcu() in opp_set_availability()
Date: Thu, 27 Nov 2014 08:54:07 +0530
Message-ID: <268325a89f657777924a52082749d8342e4ef79f.1417058376.git.viresh.kumar@linaro.org>
References: <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
 <9a64eb3d9d11ff7379b7eb6d9207625175f28e47.1417058376.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38532 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbaK0DYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 22:24:49 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so4059829pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 19:24:48 -0800 (PST)
In-Reply-To: <9a64eb3d9d11ff7379b7eb6d9207625175f28e47.1417058376.git.viresh.kumar@linaro.org>
In-Reply-To: <1407c1d67e546a09f5dd122de943de45bcd3c846.1417058376.git.viresh.kumar@linaro.org>
References: <1407c1d67e546a09f5dd122de943de45bcd3c846.1417058376.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stefan.wahren@i2se.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, paulmck@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>

This existed before we introduced call_srcu() in opp layer to synchronize with
srcu_notifier_call_chain() while removing OPPs. And is a potential bug which
wasn't noticed earlier.

Let fix it as well by using the right API to free OPP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 977474a..2d195f3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -641,7 +641,7 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 
 	list_replace_rcu(&opp->node, &new_opp->node);
 	mutex_unlock(&dev_opp_list_lock);
-	kfree_rcu(opp, rcu_head);
+	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)
-- 
2.0.3.693.g996b0fd

