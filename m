From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in intel_pstate and schedutil
Date: Sun, 4 Sep 2016 08:54:49 -0700
Message-ID: <000401d206c4$ad0db8c0$07292a40$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: fzIkbye3fIF3xfzInbIYuf
In-Reply-To: fzIkbye3fIF3xfzInbIYuf
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM list' <linux-pm@vger.kernel.org>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>, 'Morten Rasmussen' <morten.rasmussen@arm.com>, 'Juri Lelli' <Juri.Lelli@arm.com>, 'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steve Muckle' <smuckle@linaro.org>, 'Doug Smythies' <doug.smythies@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2016.09.02 17:57 Rafael J. Wysocki wrote:

> This is a new version of the "iowait boost" series I posted a few weeks
> ago.  Since the first two patches from that series have been reworked and
> are in linux-next now, I've rebased this series on top of my linux-next
> branch.
>
> In addition to that I took the Doug's feedback into account in the
> intel_pstate patches [2-3/4].

You got ahead of me a little.
Recall the suggestion for the addition of some filtering was based
on energy savings. And further that it might make sense to use
average pstate as input to the filter (your new patch 3 of 4).
In my testing (of the old patch set) I have been finding that some
of those energy savings are being given back by the average pstate
method, putting its value added into question.

Switching to the new patch set, I made two kernels (based on 4.8-rc4
+ your pre-requisite 2 patches):
rfc4: has all 4 patches.
rfc2: has patches 1, 2, 4. (does not have the average pstate change)

Using my SpecPower simulator test at 20% load I get:

Unpatched (reference): ~5905 Joules
rfc4: ~ 6232 Joules (+5.5%)
rfc2: ~ 6075 Joules (+2.9%)
Old rfc, no filter (restated): ~7197 Joules (+21.9%)
Old rfc + old iir filter V2: ~5967 Joules (+1%)
Old rfc + old ave pstate method: ~6275 Joules (+6.3%)

Srinivas was getting considerably different, but still
encouraging, numbers on the real SpecPower test beds.

I would like to suggest/ask that those real SpecPower tests be done
first so as to decide a preferred way forward. I'll also re-do my
simulator tests over a longer time period and at some other loads
(currently 20% is hard coded).

... Doug
