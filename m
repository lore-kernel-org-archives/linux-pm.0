From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] opp: Staticize __dev_pm_opp_remove()
Date: Wed, 10 Dec 2014 09:45:32 +0530
Message-ID: <ada2bd487383fe6a84001227ba7bd43d44146528.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33633 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaLJEQN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 23:16:13 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so1948610pde.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 20:16:13 -0800 (PST)
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Its a local routine and must not be accessible outside of opp.c.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index e1807268cbf2..fa065d6e1731 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -518,7 +518,8 @@ static void kfree_device_rcu(struct rcu_head *head)
 	kfree_rcu(device_opp, rcu_head);
 }
 
-void __dev_pm_opp_remove(struct device_opp *dev_opp, struct dev_pm_opp *opp)
+static void __dev_pm_opp_remove(struct device_opp *dev_opp,
+				struct dev_pm_opp *opp)
 {
 	/*
 	 * Notify the changes in the availability of the operable
-- 
2.2.0

