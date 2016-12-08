From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Thu, 8 Dec 2016 14:39:19 +0800
Message-ID: <20161208063918.GG2749@dragon>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org>
 <20161207032555.GE31255@vireshk-i7>
 <20161207211343.GA5423@codeaurora.org>
 <20161208033059.GA24152@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbcLHGkJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Dec 2016 01:40:09 -0500
Content-Disposition: inline
In-Reply-To: <20161208033059.GA24152@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, Dec 08, 2016 at 09:00:59AM +0530, Viresh Kumar wrote:
> Hi Shawn,
> 
> On 07-12-16, 13:13, Stephen Boyd wrote:
> > On 12/07, Viresh Kumar wrote:
> > > On 06-12-16, 17:17, Stephen Boyd wrote:
> > > > On 12/06, Viresh Kumar wrote:
> > > > > The code adding static OPPs for V2 bindings already does so. Make the V1
> > > > > bindings specific code behave the same.
> > > > > 
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > 
> > > > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > 
> > > > It looks like that goes back to the original DT OPP binding
> > > > support written by Shawn Guo. Any idea why we kept trying to add
> > > > more OPPs if it failed to add one? Best effort or something?
> 
> Can you please answer this question from Stephen?

Yes, it's the best effort.  For example, a duplicated OPP shouldn't be a
stopper for the driver.

Shawn
