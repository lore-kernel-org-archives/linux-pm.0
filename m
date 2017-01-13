From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/12] PM / OPP: Add 'struct kref' to struct dev_pm_opp
Date: Fri, 13 Jan 2017 00:52:59 -0800
Message-ID: <20170113085259.GS17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <1d5f61440dbfb640c330f77c9090e2ac23482ebc.1481106919.git.viresh.kumar@linaro.org>
 <20170109234427.GY17126@codeaurora.org>
 <20170110042632.GC6332@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdAMIxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 03:53:01 -0500
Content-Disposition: inline
In-Reply-To: <20170110042632.GC6332@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 01/10, Viresh Kumar wrote:
> On 09-01-17, 15:44, Stephen Boyd wrote:
> > On 12/07, Viresh Kumar wrote:
> > > Add kref to struct dev_pm_opp for easier accounting of the OPPs.
> > > 
> > > Note that the OPPs are freed under the opp_table->lock mutex only.
> > 
> > I'm lost. Why add another level of krefs?
> 
> Heh. The earlier krefs were for the OPP table itself, so that it gets freed once
> there are no more users of it.
> 
> The kref introduced now is for individual OPPs, so that they don't disappear
> while being used and gets freed once all are done.
> 
> Also note that the OPP table will get freed only after all the OPPs are freed,
> plus there are no more users left, like platform code which might have set
> suppoerted-hw property.
> 

What still doesn't make sense is how an individual OPP could go
away without the table that the OPP lives in also going away. If
an OPP is going away while a driver has a reference to it, then
the driver using that OPP should probably not be using it. TL;DR
letting drivers use OPP pointers outside of the OPP core feels
racy.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
