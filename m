From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 04/10] PM / OPP: Error out on failing to add static OPPs
 for v1 bindings
Date: Thu, 8 Dec 2016 22:27:08 +0800
Message-ID: <20161208142706.GH2749@dragon>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1f876a6d176784f9ab901aea7ff521d53522682d.1481015522.git.viresh.kumar@linaro.org>
 <20161207011722.GJ4388@codeaurora.org>
 <20161207032555.GE31255@vireshk-i7>
 <20161207211343.GA5423@codeaurora.org>
 <20161208033059.GA24152@vireshk-i7>
 <20161208063918.GG2749@dragon>
 <20161208064513.GC31711@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbcLHO15 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Dec 2016 09:27:57 -0500
Content-Disposition: inline
In-Reply-To: <20161208064513.GC31711@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, Dec 08, 2016 at 12:15:13PM +0530, Viresh Kumar wrote:
> On 08-12-16, 14:39, Shawn Guo wrote:
> > Yes, it's the best effort.
> 
> That may get a risky IMO. What if we fail to add all OPPs except the last one,
> which selects the highest frequency?

That's the same case when Performance governor is selected, and should
be guaranteed safe, shouldn't it?

> We will surely overheat most of the SoCs
> and burn them out.

IMO, the problem is on OPP table.  Every entry in the table should be
safe for running for any time.

Shawn
