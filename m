From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
Date: Thu, 10 Dec 2015 18:01:59 +0000
Message-ID: <20151210180159.GF14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
 <566988E8.3010308@arm.com>
 <20151210155940.GN5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56814 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbbLJSBa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 13:01:30 -0500
Content-Disposition: inline
In-Reply-To: <20151210155940.GN5727@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com

Hi,

On 10/12/15 15:59, Mark Brown wrote:
> On Thu, Dec 10, 2015 at 02:15:04PM +0000, Dietmar Eggemann wrote:
> > On 23/11/15 14:28, Juri Lelli wrote:
> 
> > > The new attribute shows up as:
> 
> > >  /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> > This sysfs interface is not really needed for arm or arm64. People can
> > build the dt blob if they want to change the values. Less code to carry
> > ... Let's focus on the core functionality, which is parsing cpu capacity
> > from dt file to task scheduler for heterogeneous systems.
> 
> That does make the tuning process much more cumbersome - users have to
> rebuild and reboot to tweak the numbers rather than just tweaking the
> numbers and rerunning the benchmark (which seems like something people
> would want to automate).

IMHO, this is not a tuning interface. It is an alternative interface,
w.r.t. DTs, that we could use to provide default capacity values to the
kernel. I'm proposing both here as they make both sense to me. Then we
might dedice for which one to go (or if we need some other way) or to
keep both for flexibility.

Best,

- Juri
