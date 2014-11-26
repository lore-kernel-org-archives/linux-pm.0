From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Wed, 26 Nov 2014 14:47:47 +0530
Message-ID: <CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
	<f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
	<20141125162434.GC5050@linux.vnet.ibm.com>
	<CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
	<20141125173943.GG5050@linux.vnet.ibm.com>
	<CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53827 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaKZJRs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 04:17:48 -0500
Received: by mail-ob0-f172.google.com with SMTP id wn1so1874923obc.17
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 01:17:47 -0800 (PST)
In-Reply-To: <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On 26 November 2014 at 11:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Also it looks like I should use call_srcu() with kfree_rcu() for
> opp_set_availability() case as well to avoid any corner cases.

This is the diff I would be adding to this patch:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index f9d80e6..3f728cd 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -506,7 +506,7 @@ static void kfree_opp_rcu(struct rcu_head *head)
        struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp,
rcu_head);

        pr_info("%s: opp:%p, dynamic:%d\n", __func__, opp, opp->dynamic);
-       kfree(opp);
+       kfree_rcu(opp);
 }

 static void kfree_device_rcu(struct rcu_head *head)
@@ -644,7 +644,7 @@ static int opp_set_availability(struct device
*dev, unsigned long freq,

        list_replace_rcu(&opp->node, &new_opp->node);
        mutex_unlock(&dev_opp_list_lock);
-       kfree_rcu(opp, rcu_head);
+       call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);

        /* Notify the change of the OPP availability */
        if (availability_req)
