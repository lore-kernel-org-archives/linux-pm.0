From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] cpufreq: Support for fast frequency switching
Date: Thu, 3 Mar 2016 22:12:16 +0100
Message-ID: <20160303211216.GV6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <26020775.9hJG2SHiH2@vostro.rjw.lan>
 <20160303111655.GL6356@twins.programming.kicks-ass.net>
 <CAJZ5v0gftV8fR9XQuFKPf-v6FzyFV5onRvyE64mc5kPXUVQqmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50058 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbcCCVMV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 16:12:21 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gftV8fR9XQuFKPf-v6FzyFV5onRvyE64mc5kPXUVQqmA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 03, 2016 at 09:56:40PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 3, 2016 at 12:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Mar 02, 2016 at 03:12:33AM +0100, Rafael J. Wysocki wrote:
> >> The most important change from the previous version is that the
> >> ->fast_switch() callback takes an additional "relation" argument
> >> and now the governor can use it to choose a selection method.
> >
> >> +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> >> +                                   unsigned int target_freq,
> >> +                                   unsigned int relation)
> >
> > Would it make sense to replace the {target_freq, relation} pair with
> > something like the CPPC {min_freq, max_freq} pair?
> 
> Yes, it would in general, but since I use __cpufreq_driver_target() in
> the "slow driver" case, that would need to be reworked too for
> consistency.  So I'd prefer to do that later.

OK, fair enough.
