From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Mon, 05 Sep 2016 01:54:40 +0200
Message-ID: <21373989.WOAuNhKX1x@vostro.rjw.lan>
References: <000401d206c4$ad0db8c0$07292a40$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57427 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754156AbcIDXsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Sep 2016 19:48:46 -0400
In-Reply-To: <000401d206c4$ad0db8c0$07292a40$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>, 'Morten Rasmussen' <morten.rasmussen@arm.com>, 'Juri Lelli' <Juri.Lelli@arm.com>, 'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steve Muckle' <smuckle@linaro.org>, 'Doug Smythies' <doug.smythies@gmail.com>

On Sunday, September 04, 2016 08:54:49 AM Doug Smythies wrote:
> Hi Rafael,
> 
> On 2016.09.02 17:57 Rafael J. Wysocki wrote:
> 
> > This is a new version of the "iowait boost" series I posted a few weeks
> > ago.  Since the first two patches from that series have been reworked and
> > are in linux-next now, I've rebased this series on top of my linux-next
> > branch.
> >
> > In addition to that I took the Doug's feedback into account in the
> > intel_pstate patches [2-3/4].
> 
> You got ahead of me a little.
> Recall the suggestion for the addition of some filtering was based
> on energy savings. And further that it might make sense to use
> average pstate as input to the filter (your new patch 3 of 4).
> In my testing (of the old patch set) I have been finding that some
> of those energy savings are being given back by the average pstate
> method, putting its value added into question.
> 
> Switching to the new patch set, I made two kernels (based on 4.8-rc4
> + your pre-requisite 2 patches):
> rfc4: has all 4 patches.
> rfc2: has patches 1, 2, 4. (does not have the average pstate change)
> 
> Using my SpecPower simulator test at 20% load I get:
> 
> Unpatched (reference): ~5905 Joules
> rfc4: ~ 6232 Joules (+5.5%)
> rfc2: ~ 6075 Joules (+2.9%)
> Old rfc, no filter (restated): ~7197 Joules (+21.9%)
> Old rfc + old iir filter V2: ~5967 Joules (+1%)
> Old rfc + old ave pstate method: ~6275 Joules (+6.3%)
> 
> Srinivas was getting considerably different, but still
> encouraging, numbers on the real SpecPower test beds.
> 
> I would like to suggest/ask that those real SpecPower tests be done
> first so as to decide a preferred way forward. I'll also re-do my
> simulator tests over a longer time period and at some other loads
> (currently 20% is hard coded).

The reason I made patch [3/4] separate was to make it easier to test without
that change.  That is, apply [1-2/4] and see what difference it makes.

I'd like to see the results from that if poss.

Thanks,
Rafael

