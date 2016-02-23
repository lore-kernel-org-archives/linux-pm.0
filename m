From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness
 is scaled
Date: Tue, 23 Feb 2016 14:04:59 +0000
Message-ID: <20160223140459.GA2854@techsingularity.net>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
 <CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
 <001101d16a90$a7a26e10$f6e74a30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001101d16a90$a7a26e10$f6e74a30$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Rafael Wysocki' <rjw@rjwysocki.net>, 'Ingo Molnar' <mingo@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Matt Fleming' <matt@codeblueprint.co.uk>, 'Mike Galbraith' <umgwanakikbuti@gmail.com>, 'Linux-PM' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2016 at 01:09:26PM -0800, Doug Smythies wrote:
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -999,7 +999,7 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
> >>         sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
> >>         duration_us = ktime_us_delta(cpu->sample.time,
> >>                                      cpu->last_sample_time);
> >> -       if (duration_us > sample_time * 3) {
> >> +       if (duration_us > sample_time * 12) {
> >>                 sample_ratio = div_fp(int_tofp(sample_time),
> >>                                       int_tofp(duration_us));
> >>                 core_busy = mul_fp(core_busy, sample_ratio);
> >> --
> 
> The immediately preceding comment needs to be changed also.
> Note that with duration related scaling only coming in at such a high
> ratio it might be worth saving the divide and just setting it to 0.
> 

I tried this and FWIW, the performance is generally comparable as is the
power usage as reported by turbostat. On occasion, depending on the
machine, the system CPU usage is noticably lower.

-- 
Mel Gorman
SUSE Labs
