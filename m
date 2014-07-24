From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 2/7] ARM: mvebu: extend PMSU code to support dynamic
 frequency scaling
Date: Thu, 24 Jul 2014 07:11:00 -0400
Message-ID: <20140724111100.GR23220@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140723235026.6419.93364@quantum>
 <20140724082902.0e64d454@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508AbaGXLLP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 07:11:15 -0400
Content-Disposition: inline
In-Reply-To: <20140724082902.0e64d454@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Thu, Jul 24, 2014 at 08:29:02AM +0200, Thomas Petazzoni wrote:
> Dear Mike Turquette,
> 
> On Wed, 23 Jul 2014 16:50:26 -0700, Mike Turquette wrote:
> 
> > >  * registers the frequency operating points supported by the CPU;
> > > 
> > >  * registers a clock notifier of the CPU clocks. The notifier function
> > 
> > Where does this code register a clock notifier callback?
> > 
> > >    listens to the newly introduced APPLY_RATE_CHANGE event, and uses
> > 
> > I don't see APPLY_RATE_CHANGE referenced.
> 
> Yes, this is a mistake of the commit log, due to remains of the v2 of
> the patch series. Back in the v2, there was indeed a new clock notifier
> being used. But Stephen Boyd argued against that, and instead suggested
> to use a direct function call, which this v3 implements, as stated in
> the cover letter:
> 
>  - As suggested by Stephen Boyd, instead of using a new clock notifier
>    that somewhat "hides" the dependency of the clk-cpu clock driver on
>    the PMSU, use a direct call from the clk-cpu driver to the PMSU
>    driver.
> 
> The commit log of this commit was not adjusted consequently, and this
> is my fault. Jason, is it still time to change this commit log?

If there are no code changes, I'd prefer not to.  We're rather late in
the game.

Even though it's not ideal, the commit in question does have a Link: tag
pointing at the patch email on which this conversation is based.  So a
frustrated future developer won't be frustrated long. :)

thx,

Jason.
