From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 1/1] cpufreq: New governor using utilization data from the scheduler
Date: Wed, 24 Feb 2016 02:38:08 +0100
Message-ID: <2117447.HrQEXp4Ryh@vostro.rjw.lan>
References: <5059413.77KZsd2lep@vostro.rjw.lan> <CAJZ5v0j7jScr8TStyVHPDgd5qHaFDzUO3KnfxtEoYjrfc8gOQA@mail.gmail.com> <56CC0841.1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57166 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752835AbcBXBgg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2016 20:36:36 -0500
In-Reply-To: <56CC0841.1@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On Monday, February 22, 2016 11:20:33 PM Steve Muckle wrote:
> On 02/22/2016 03:02 PM, Rafael J. Wysocki wrote:
> >> I guess the first (macro) question is why did you decide to go with a
> >> complete new governor, where new here is w.r.t. the sched-freq solution.
> > 
> > Probably the most comprehensive answer to this question is my intro
> > message: http://marc.info/?l=linux-pm&m=145609673008122&w=2
> > 
> > The executive summary is probably that this was the most
> > straightforward way to use the scheduler-provided numbers in cpufreq
> > that I could think about.
> > 
> >> AFAICT, it is true that your solution directly builds on top of the
> >> latest changes to cpufreq core and governor, but it also seems to have
> >> more than a few points in common with sched-freq,
> > 
> > That surely isn't a drawback, is it?
> >
> > If two people come to the same conclusions in different ways, that's
> > an indication that the conclusions may actually be correct.
> > 
> >> and sched-freq has been discussed and evaluated for already quite some time.
> > 
> > Yes, it has.
> > 
> > Does this mean that no one is allowed to try any alternatives to it now?
> 
> As mentioned above they are rather similar so it doesn't really seem
> like an alternative per se, more like a reimplementation.

If that is the case, I don't quite see where or what the problem is.

I posted this mostly because you and Juri were complaining that I wasn't
telling anyone about how I was going to use util and max going forward.

So this is how I'd like to use them, more or less.  If that is in alignment
with the changes you want to make, all should be fine.

> Why do you feel a new starting point for this problem is needed? Are
> there specific technical concerns?

Well, let me comment the patches you've sent (although not today maybe as I'm
quite tired already and I'm afraid that my comments may not be much to the
point).

That aside, this was rather an attempt to see what could be done on top of
recent fixes in the core and how complicated it would be.

> I see you started looking over the
> latest schedfreq RFC, thank you for your comments thus far. We'd really
> appreciate your continued feedback and the chance to collaborate on it
> to move it forward. I and others have put a fair bit of effort into it
> over the last year or so and will happily and earnestly work to address
> any shortcomings you raise.
> 
> I will review your RFC in the next day or so as well.
> 
> ...
> > My goal, that may be quite different from yours, is to reduce the
> > cpufreq's overhead as much as I possibly can.  If I have to change the
> > way it drives the CPU frequency selection to achieve that goal, I will
> > do that, but if that can stay the way it is, that's fine too.
> 
> Our primary goal has been simply to achieve functional scheduler-driven
> CPU frequency control with equivalent or better power and performance
> than what is available today. Reduction of cpufreq overhead fits within
> this goal (and may be required) so no conflict here.

Good.

Thanks,
Rafael

