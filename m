From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Wed, 7 Dec 2016 13:13:43 -0800
Message-ID: <20161207211343.GA5423@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org>
 <20161207032555.GE31255@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbcLGVYe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 16:24:34 -0500
Content-Disposition: inline
In-Reply-To: <20161207032555.GE31255@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> On 06-12-16, 17:17, Stephen Boyd wrote:
> > On 12/06, Viresh Kumar wrote:
> > > The code adding static OPPs for V2 bindings already does so. Make the V1
> > > bindings specific code behave the same.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > 
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > It looks like that goes back to the original DT OPP binding
> > support written by Shawn Guo. Any idea why we kept trying to add
> > more OPPs if it failed to add one? Best effort or something?
> 
> Not sure, maybe for handling duplicate OPPs.
> 

So perhaps we should Cc Shawn Guo who wrote the original code
then?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
