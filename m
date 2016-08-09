From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Tue, 9 Aug 2016 10:16:56 -0700
Message-ID: <000801d1f261$d69fc740$83df55c0$@net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1572483.RZjvRFdxPx@vostro.rjw.lan> <001b01d1ee1c$e6a6a170$b3f3e450$@net> <10156236.RI1knH5Wfs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:57673 "EHLO cmta19.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbcHIRRC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Aug 2016 13:17:02 -0400
In-Reply-To: <10156236.RI1knH5Wfs@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On 2016.08.05 17:02 Rafael J. Wysocki wrote:
> On 2016.08.03 21:19 Doug Smythies wrote:
>> On 2016.07.31 16:49 Rafael J. Wysocki wrote:
>>
>> 
>>> +static inline int32_t get_target_pstate_default(struct cpudata *cpu)
>>> +{
>>> +	struct sample *sample = &cpu->sample;
>>> +	int32_t busy_frac;
>>> +	int pstate;
>>> +
>>> +	busy_frac = div_fp(sample->mperf, sample->tsc);
>>> +	sample->busy_scaled = busy_frac * 100;
>>> +
>>> +	if (busy_frac < cpu->iowait_boost)
>>> +		busy_frac = cpu->iowait_boost;
>>> +
>>> +	cpu->iowait_boost >>= 1;
>>> +
>>> +	pstate = cpu->pstate.turbo_pstate;
>>> +	return fp_toint((pstate + (pstate >> 2)) * busy_frac);
>>> +}
>>> +
>> 
>> The response curve is not normalized on the lower end to the minimum
>> pstate for the processor, meaning the overall response will vary
>> between processors as a function of minimum pstate.

> But that's OK IMO.
>
> Mapping busy_frac = 0 to the minimum P-state would over-provision workloads
> with small values of busy_frac.

Agreed, mapping busy_frac = 0 to the minimum Pstate would be a bad thing to do.

However, that is not what I meant. I meant that the mapping of busy-frac = N to
the minimum pstate for the processor should give the same "N" (within granularity),
regardless of the processor.

Example, my processor, i7-2600K: max pstate = 38; min pstate = 16.
Load before going to pstate, 17:  17 = (38 + 38/4) * load
Load = N = 35.8 %

Example, something like, i5-3337U (I think, I don't actually have one):
max pstate = 27; min pstate = 8.
Load before going to pstate, 9: 9 = (27 + 27/4) * load
Load =  N = 26.7 %

It was a couple of years ago, so I should re-do the sensitivity
analysis/testing, but I concluded that the performance / energy tradeoff
was somewhat sensitive to "N".
 
I am suggesting that the response curve, or transfer function,
needs to be normalized, for any processor, to:

  Max pstate |              __________
             |             /
             |            /
             |           /
             |          /
             |         /
   Min pstate| _______/
             |__________________________
              |       |     |          |
              0%      N     M         100%
                      CPU load

Currently M ~= 80%

One time (not re-based since kernel 4.3) I did have a proposed solution [1],
but it was expensive in terms of extra multiplies and divides.

[1]: http://marc.info/?l=linux-pm&m=142881187323474&w=2

>> The clamping at maximum pstate at about 80% load seems at little high
>> to me. Work I have done in various attempts to bring back the use of actual load
>> has always ended up achieving maximum pstate before 80% load for best results.
>> Even the get_target_pstate_cpu_load people reach the max pstate faster, and they
>> are more about energy than performance.
>> What was the criteria for the decision here? Are test results available for review
>> and/or duplication by others?

> This follows the coefficient used by the schedutil governor, but then the
> metric is different, so quite possibly a different value may work better here.
> 
> We'll test other values before applying this for sure. :-)

I am now testing this change to the code (for M ~= 67%; N ~= 30% (my CPU); N ~= 22% (i5-3337U)):

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8b2bdb7..909d441 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1313,7 +1313,7 @@ static inline int32_t get_target_pstate_default(struct cpudata *cpu)
        cpu->iowait_boost >>= 1;

        pstate = cpu->pstate.turbo_pstate;
-       return fp_toint((pstate + (pstate >> 2)) * busy_frac);
+       return fp_toint((pstate + (pstate >> 1)) * busy_frac);
 }

 static inline void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)

> 
> Several tests were done with this patch set.
...[cut]...

>> Questions:
>> Is there a migration plan?
>
> Not yet.  We have quite a lot of testing to do first.
>
>> i.e. will there be an attempt to merge the current cpu_load method
>> and this method into one method?
>
> Quite possibly if the results are good enough.
>
>> Then possibly the PID controller could be eliminated.
>
> Right.

I think this change is important, and I'll help with it as best as I can.

... Doug

A related CPU frequency Vs. Load graph will be sent to Rafael and Srinivas off-list.


