From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: of_property_count_u32_elems() can return errors
Date: Sat, 19 Sep 2015 15:22:19 -0700
Message-ID: <20150919222219.GE23081@codeaurora.org>
References: <46a47430b8d65f509d47fe3ad1264c6b23086d61.1442508974.git.viresh.kumar@linaro.org>
 <20150917181328.GQ23081@codeaurora.org>
 <20150919032113.GA24314@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58881 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbISWWV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Sep 2015 18:22:21 -0400
Content-Disposition: inline
In-Reply-To: <20150919032113.GA24314@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 09/18, Viresh Kumar wrote:
> On 17-09-15, 11:13, Stephen Boyd wrote:
> > > +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> > > +	if (count < 0) {
> > 
> > We can't test count for -EINVAL to detect the missing property
> > because -EINVAL is also returned on a non-multiple of u32 length
> > property? Maybe we shouldn't worry about that case and turn
> > -EINVAL into 0.
> 
> So you are saying that we go ahead without regulators if a incorrect
> values are present in opp-microvolt? i.e. even if the length property
> was invalid, we return 0 from this function.
> 
> The problem here is that we will try changing the frequency without
> changing the regulator in that case, and it might not be safe for the
> platform, isn't it?
> 

Do we care if a platform has changed the length of the property
to something that isn't a multiple of u32? That sounds very rare,
that's all. I agree it's a bug.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
