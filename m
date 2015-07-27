From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/10] opp: Add OPP sharing information to OPP library
Date: Mon, 27 Jul 2015 08:50:58 +0530
Message-ID: <20150727032058.GI19944@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
 <55A986DD.3010104@codeaurora.org>
 <20150718063304.GD11802@linux>
 <55AD33F3.4000302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34340 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbbG0DVC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 23:21:02 -0400
Received: by pacan13 with SMTP id an13so44576176pac.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 20:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55AD33F3.4000302@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, thomas.petazzoni@free-electrons.com, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, khilman@linaro.org, linux-pm@vger.kernel.org, viswanath.puttagunta@linaro.org, santosh.shilimkar@oracle.com, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de

On 20-07-15, 10:46, Stephen Boyd wrote:
> >+static struct device_opp *_managed_opp(const struct device_node *np)
> >+{
> >+	struct device_opp *dev_opp;
> >+
> >+	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
> >+		if (dev_opp->np == np) {
> >+			/*
> >+			 * Multiple devices can point to the same OPP table and
> >+			 * so will have same node-pointer, np.
> >+			 *
> >+			 * But the OPPs will be considered as shared only if the
> >+			 * OPP table contains a "opp-shared" property.
> >+			 */
> >+			if (dev_opp->shared_opp)
> >+				return dev_opp;
> >+			else
> >+				return NULL;
> >+		
> 
> The janitors will probably find this and say that it could be
> simplified to an if () and a return without the else.

And I am trying to make the janitors happy with this:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index eb920e3f115b..8c81784fe473 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -168,7 +168,7 @@ static struct device_opp *_managed_opp(const struct device_node *np)
 {
        struct device_opp *dev_opp;
 
-       list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
+       list_for_each_entry_rcu(dev_opp, &dev_opp_list, node) {
                if (dev_opp->np == np) {
                        /*
                         * Multiple devices can point to the same OPP table and
@@ -177,11 +177,9 @@ static struct device_opp *_managed_opp(const struct device_node *np)
                         * But the OPPs will be considered as shared only if the
                         * OPP table contains a "opp-shared" property.
                         */
-                       if (dev_opp->shared_opp)
-                               return dev_opp;
-                       else
-                               return NULL;
+                       return dev_opp->shared_opp ? dev_opp : NULL;
                }
+       }
 
        return NULL;
 }

-- 
viresh
