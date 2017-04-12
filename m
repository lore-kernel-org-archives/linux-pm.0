From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Wed, 12 Apr 2017 10:01:07 +0100
Message-ID: <20170412090107.GE21398@e106622-lin>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan>
 <CAJZ5v0hoPZM_dmfs-6jjN857K9M-RNPKN5Oen3ri7z=g-jeMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753240AbdDLJBD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 05:01:03 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoPZM_dmfs-6jjN857K9M-RNPKN5Oen3ri7z=g-jeMow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>

Hi Rafael,

On 11/04/17 23:23, Rafael J. Wysocki wrote:
> On Thu, Mar 30, 2017 at 11:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The schedutil governor reduces frequencies too fast in some
> > situations which cases undesirable performance drops to
> > appear.
> >
> > To address that issue, make schedutil reduce the frequency slower by
> > setting it to the average of the value chosen during the previous
> > iteration of governor computations and the new one coming from its
> > frequency selection formula.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
> > Reported-by: John <john.ettedgui@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This addresses a practical issue, but one in the "responsiveness" or
> > "interactivity" category which is quite hard to represent quantitatively.
> >
> > As reported by John in BZ194963, schedutil does not ramp up P-states quickly
> > enough which causes audio issues to appear in his gaming setup.  At least it
> > evidently is worse than ondemand in this respect and the patch below helps.
> >
> > The patch essentially repeats the trick added some time ago to the load-based
> > P-state selection algorithm in intel_pstate, which allowed us to make it viable
> > for performance-oriented users, and which is to reduce frequencies at a slower
> > pace.
> >
> > The reason why I chose the average is because it is computationally cheap
> > and pretty much the max reasonable slowdown and the idea is that in case
> > there's something about to run that we don't know about yet, it is better to
> > stay at a higher level for a while more to avoid having to get up from the floor
> > every time.
> >
> > But technically speaking it is a filter. :-)
> >
> > So among other things I'm wondering if that leads to substantial increases in
> > energy consumption anywhere.
> 
> I haven't seen any numbers indicating that, so since the issue
> addressed by this patch is real, I'd like to go ahead with it for
> 4.12.
> 

Sorry, it took a bit of time to get results.

I didn't see big power/perf regressions on interactive type of workloads
running on Pixel phones. Youtube only showed a +~2% energy increase, but
I can't say for certain that is not in the noise.

My experiments also have your other two patches [1] applied.

So, yeah. I guess we could go ahead with this and see if we can improve
further in the future.

Thanks,

- Juri

[1] https://marc.info/?l=linux-kernel&m=149178351728004&w=2 
