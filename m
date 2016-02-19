From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Fri, 19 Feb 2016 08:09:17 +0000
Message-ID: <20160219080917.GE22643@pablo>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44377 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424890AbcBSIJa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 03:09:30 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Rafael,

On 18/02/16 21:22, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >

[...]

> 
> So if anyone has any issues with this one, please let me know.
> 

I'm repeating myself a bit, but I'll try to articulate my only concern
once again anyway. I run some tests on a couple of arm boxes and I
didn't notice any regression or improvements for ondemand and
conservative (FWIW this might also work as a tested-by), so I tend to
take this series as a way to replace governor timers, making further
cleanups and fixes possibile. I think you already confirmed this and I
understand why you'd like this series to go in as I also think that what
we have on top is beneficial.

However, I still don't quite get why we want to introduce an interface
for explicit passing of util and max if we are not using such parameters
yet. Also, I couldn't find any indication of how such parameters will be
used in the future. If what we need today is a periodic kick for cpufreq
governors that need it, we should simply do how we already do for RT and
DL, IMHO. Also because the places where the current hooks reside might
not be the correct and useful one once we'll start using the utilization
parameters. I could probably make a case for DL where we should place
hooks in admission control path (or somewhere else when more
sophisticated mechanisms we'll be in place) rather then in the periodic
tick.

> It has been in linux-next for a few days and seems to be doing well.
> 
> As I said previously, there is a metric ton of cpufreq improvements
> depending on it, so I'd rather not delay integrating it any more.
> 

As said. I'm not against these changes since they open up to further
substantial fixes. I'm only wondering if we are doing the right thing
defining an interface that nobody is using and without an indication of
how such thing we'll be used in the future.

Best,

- Juri
