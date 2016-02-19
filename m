From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering utilization update callbacks
Date: Fri, 19 Feb 2016 23:35:15 +0100
Message-ID: <1797575.PjqbkdCLyN@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <1455900129.7375.231.camel@linux.intel.com> <56C750B7.6090701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61698 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751985AbcBSWdv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 17:33:51 -0500
In-Reply-To: <56C750B7.6090701@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Friday, February 19, 2016 09:28:23 AM Steve Muckle wrote:
> On 02/19/2016 08:42 AM, Srinivas Pandruvada wrote:
> > We did experiments using util/max in intel_pstate. For some benchmarks
> > there were regression of 4 to 5%, for some benchmarks it performed at
> > par with getting utilization from the processor. Further optimization
> > in the algorithm is possible and still in progress. Idea is that we can
> > change P-State fast enough and be more reactive. Once I have good data,
> > I will send to this list. The algorithm can be part of the cpufreq
> > governor too.
> 
> There has been a lot of work in the area of scheduler-driven CPU
> frequency selection by Linaro and ARM as well. It was posted most
> recently a couple months ago:
> 
> http://thread.gmane.org/gmane.linux.power-management.general/69176
> 
> It was also posted as part of the energy-aware scheduling series last
> July. There's a new RFC series forthcoming which I had hoped (and
> failed) to post prior to my business travel this week; it should be out
> next week. It will address the feedback received thus far along with
> locking and other things.
> 
> The scheduler hooks for utilization-based cpufreq operation deserve a
> lot more debate I think. They could quite possibly have different
> requirements than hooks which are chosen just to guarantee periodic
> callbacks into sampling-based governors.

Yes, they could.

The point here, though, is that even the sampling-based governors may 
benefit from using the numbers provided by the scheduler instead of trying
to come up with analogous numbers themselves.

> For my part I think it would be best if the util/max parameters are
> omitted

OK, so please see the patch I've just sent to Juri:

https://patchwork.kernel.org/patch/8364621/

> until it's clear whether these same hooks can be effectively
> used for architecture agnostic scheduler-guided (capacity driven) CPU
> frequency support.

Well, if they can't, then we'll need to move the hooks, but I'm not sure
how this is related to the arguments they take.

> My upcoming RFC will provide another opportunity to debate the hooks as
> well as how scheduler-guided CPU frequency should be structured.

OK, looking forward to seeing the RFC then. :-)

Thanks,
Rafael

