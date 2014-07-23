From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 0/7] cpufreq support for Marvell Armada XP
Date: Wed, 23 Jul 2014 07:39:45 -0400
Message-ID: <20140723113945.GB23220@titan.lakedaemon.net>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140723131930.46dcbc2e@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12124 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756434AbaGWLkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 07:40:01 -0400
Content-Disposition: inline
In-Reply-To: <20140723131930.46dcbc2e@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Thomas,

On Wed, Jul 23, 2014 at 01:19:30PM +0200, Thomas Petazzoni wrote:
> Viresh, Jason,
> 
> So, what do we do with this patch series, which depends on the
> cpufreq-generic driver? Has there been any solution found for 3.17 ?
> 
> Jason, in any case, I'd like the following patches to be merged for
> 3.17, regardless of what happens with the cpufreq driver:
> 
>  ARM: mvebu: ensure CPU clocks are enabled
>  ARM: mvebu: extend PMSU code to support dynamic frequency scaling
>  clk: mvebu: extend clk-cpu for dynamic frequency scaling

I just sent the pull for these three yesterday.

> One patch should be split:
> 
>  ARM: mvebu: update Armada XP DT for dynamic frequency scaling
> 
>  -> In this patch, the addition of clock-latency is related to the
>     cpufreq generic DT binding, so I think we shouldn't merge that. But
>     on the other hand, this patch also adds the new registers for the
>     Armada XP CPU clock, which is used by "clk: mvebu: extend clk-cpu
>     for dynamic frequency scaling".

This was a part of one of the previous DT pull requests and is already
in arm-soc.

> The patch:
> 
>  ARM: mvebu: allow enabling of cpufreq on Armada XP
> 
> can be dropped, since ARCH_HAS_CPUFREQ has been removed.

Yup, did that when Paul raised the issue.

> The other patches are defconfig changes, which are meaningless without
> the cpufreq-generic driver.

Already pushed to arm-soc.

> Jason, what do you think about me sending a new version of the patch
> series, which will have two clearly separated set of patches:
> 
>  1/ A first set of patches that can be applied regardless of what
>     happens on the cpufreq driver side. Getting it merged will not
>     bring cpufreq support, but it will add the foundations needed to
>     support it.
> 
>  2/ A second set of patches that use the cpufreq-generic driver, which
>     might get applied of the cpufreq maintainers find a solution in
>     time for 3.17. If not, then I'll re-adapt them for 3.18.

It sounds like the only patch in group 2 would be the DT change, which
has already been taken.

> What do you think?

Let's wait and see what -rc1 looks like and take action based on that.

thx,

Jason.
