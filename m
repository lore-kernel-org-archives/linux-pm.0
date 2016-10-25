From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/8] PM / OPP: Pass struct dev_pm_opp_supply to
 _set_opp_voltage()
Date: Tue, 25 Oct 2016 13:26:00 -0700
Message-ID: <20161025202600.GX26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
 <20161024231453.GS26139@codeaurora.org>
 <20161025034554.GB9162@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcJYU0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 16:26:02 -0400
Content-Disposition: inline
In-Reply-To: <20161025034554.GB9162@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 10/25, Viresh Kumar wrote:
> On 24-10-16, 16:14, Stephen Boyd wrote:
> > On 10/20, Viresh Kumar wrote:
> > > Pass the entire supply structure instead of all of its fields.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > 
> > This patch should be combined with the previous one.
> 
> I think it is a fair to do this separately as this is a completely different
> logical change.

Let's agree to disagree.

> 
> > I'm still
> > not sure if it even makes sense to do this though.
> 
> :)
> 
> > Do we really
> > have to make duplicate "OPP snapshot" structures just because of
> > how OPPs use RCU?
> 
> I agree. With RCU, yes this change is probably required. But I am not sure if
> RCU fits that well to OPP core anymore. A rw-lock may be much easier to help.
> 

For things like AVS we'll probably want to do that, although it's
sort of funny because replacing RCU with rw-locks is the opposite
direction most people go. With AVS we would be updating the
voltage(s) in use for the current OPP, and we would want that
update to block any OPP transition until the voltage is adjusted.
I don't know how we would do that with RCU very well. Plus, RCU
is for reader heavy things, but we mostly have one or two
readers.

I guess it's ok for now to do all this copying, but it feels like
we'll need to undo a large portion of it later with things like
AVS. Or at least we'll be doing copies for almost no reason
because we'll want to hold the read lock across the whole OPP
transition. I was going to suggest we pass around information
about what we want to grab from the RCU protected data
structures, think index of regulator, etc. and then have small
RCU read-side critical sections to grab that info during the OPP
transition but I'm not sure that's any better. It might be worse
because the OPP could change during the OPP transition and we
could be using half of the old and half of the new data.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
