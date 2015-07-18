From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/10] OPP: Add support for opp-suspend
Date: Sat, 18 Jul 2015 12:02:53 +0530
Message-ID: <20150718063253.GC11802@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <6a4a0da974d5944a111af6f0b57bcba63a91fe40.1434369079.git.viresh.kumar@linaro.org>
 <55A95603.4070607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36073 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbGRGc5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2015 02:32:57 -0400
Received: by pachj5 with SMTP id hj5so71934199pac.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2015 23:32:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55A95603.4070607@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, thomas.petazzoni@free-electrons.com, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, khilman@linaro.org, linux-pm@vger.kernel.org, viswanath.puttagunta@linaro.org, santosh.shilimkar@oracle.com, broonie@kernel.org, mike.turquette@linaro.org, Sudeep.Holla@arm.com, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de

On 17-07-15, 12:22, Stephen Boyd wrote:
> On 06/15/2015 04:57 AM, Viresh Kumar wrote:
> >diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> >index 6b554e417b1f..0022453e4b60 100644
> >--- a/drivers/base/power/opp.c
> >+++ b/drivers/base/power/opp.c
> >@@ -1218,6 +1219,8 @@ static int _of_init_opp_table_v2(struct device *dev,
> >  		goto put_opp_np;
> >  	if (!ret) {
> >+		const phandle *handle;
> >+
> >  		if (!dev_opp) {
> >  			dev_opp = _find_device_opp(dev);
> >  			if (WARN_ON(!dev_opp))
> >@@ -1227,6 +1230,25 @@ static int _of_init_opp_table_v2(struct device *dev,
> >  		dev_opp->np = opp_np;
> >  		if (of_get_property(opp_np, "opp-shared", NULL))
> >  			dev_opp->shared_opp = true;
> >+
> >+		/* OPP to select on device suspend */
> >+		handle = of_get_property(opp_np, "opp-suspend", NULL);
> >+		if (handle) {
> >+			struct device_node *suspend_opp_np;
> >+			struct dev_pm_opp *opp;
> >+
> >+			suspend_opp_np = of_find_node_by_phandle(be32_to_cpup(handle));
> 
> Couldn't this be done with of_parse_phandle() instead? Otherwise the
> patch looks ok.

Yeah, it could have been. Over that, this patch requires certain
modifications as the bindings changed this property before merging.
Its now part of individual OPPs and so no phandles.

I will reiterate the patches soon with updates.

-- 
viresh
