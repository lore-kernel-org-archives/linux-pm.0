From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: PM / OPP: Add clock-latency-ns support
Date: Tue, 11 Aug 2015 11:54:21 -0700
Message-ID: <20150811185421.GM2839@codeaurora.org>
References: <20150810163804.GA10496@mwanda>
 <20150811081228.GC5509@linux>
 <20150811135122.GL5096@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56364 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbHKSyX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 14:54:23 -0400
Content-Disposition: inline
In-Reply-To: <20150811135122.GL5096@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On 08/11, Dan Carpenter wrote:
> On Tue, Aug 11, 2015 at 01:42:28PM +0530, Viresh Kumar wrote:
> > 
> > The problem is that the value here is of type 'unsigned long' which is
> > 32/64 bit on 32/64 bit machines.
> 
> Yep.  It won't work on 64 bit big endian machines as described earlier.
> 
> > 
> > So, I looked at how other places in code has done it, and that's what
> > I found.
> 
> It's not portable.  Sometimes we don't care about that because we know
> we don't care about 64 bit big endian systems.  Hence, my email.
> 

Making it portable should be simple enough by having a temporary
variable of type u32 though.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---8<---
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 51b220e615d3..022715d1894c 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -919,6 +919,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	struct dev_pm_opp *new_opp;
 	u64 rate;
 	int ret;
+	u32 val;
 
 	/* Hold our list modification lock here */
 	mutex_lock(&dev_opp_list_lock);
@@ -946,14 +947,15 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	new_opp->np = np;
 	new_opp->dynamic = false;
 	new_opp->available = true;
-	of_property_read_u32(np, "clock-latency-ns",
-			     (u32 *)&new_opp->clock_latency_ns);
+	of_property_read_u32(np, "clock-latency-ns", &val);
+	new_opp->clock_latency_ns = val;
 
 	ret = opp_get_microvolt(new_opp, dev);
 	if (ret)
 		goto free_opp;
 
-	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
+	of_property_read_u32(np, "opp-microamp", &val);
+	new_opp->u_amp = val;
 
 	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
