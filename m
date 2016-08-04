From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC][PATCH 7/7] cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Wed, 3 Aug 2016 23:53:23 -0700
Message-ID: <001b01d1ee1c$e6a6a170$b3f3e450$@net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1572483.RZjvRFdxPx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:41176 "EHLO cmta18.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbcHDGxa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Aug 2016 02:53:30 -0400
In-Reply-To: 
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On 2016.08.03 21:19 Doug Smythies wrote:

Re-sending without the previously attached graph.

Hi Rafael,

Hope this feedback and test results help.

On 2016.07.31 16:49 Rafael J. Wysocki wrote:

> The PID-base P-state selection algorithm used by intel_pstate for
> Core processors is based on very weak foundations.

Agree, very very much.

...[cut]...

> Consequently, the only viable way to fix that is to replace the
> erroneous algorithm entirely with a better one.

Agree, very very much.

> To that end, notice that setting the P-state proportional to the
> actual CPU utilization (measured with the help of MPERF and TSC)
> generally leads to reasonable behavior, but it does not reflect
> the "performance boosting" nature of the current P-state
> selection algorithm. It may be made more similar to that
> algorithm, though, by adding iowait boosting to it.

Which is good and does help a lot for the IO case, but issues
remain for the compute case.

...[cut]...

> +static inline int32_t get_target_pstate_default(struct cpudata *cpu)
> +{
> +	struct sample *sample = &cpu->sample;
> +	int32_t busy_frac;
> +	int pstate;
> +
> +	busy_frac = div_fp(sample->mperf, sample->tsc);
> +	sample->busy_scaled = busy_frac * 100;
> +
> +	if (busy_frac < cpu->iowait_boost)
> +		busy_frac = cpu->iowait_boost;
> +
> +	cpu->iowait_boost >>= 1;
> +
> +	pstate = cpu->pstate.turbo_pstate;
> +	return fp_toint((pstate + (pstate >> 2)) * busy_frac);
> +}
> +

The response curve is not normalized on the lower end to the minimum
pstate for the processor, meaning the overall response will vary
between processors as a function of minimum pstate.

The clamping at maximum pstate at about 80% load seems at little high
to me. Work I have done in various attempts to bring back the use of actual load
has always ended up achieving maximum pstate before 80% load for best results.
Even the get_target_pstate_cpu_load people reach the max pstate faster, and they
are more about energy than performance.
What was the criteria for the decision here? Are test results available for review
and/or duplication by others?


Several tests were done with this patch set.
The patch set would not apply to kernel 4.7, but did apply fine to a 4.7+ kernel
(I did as of 7a66ecf) from a few days ago.

Test 1: Phoronix ffmpeg test (less time is better):
Reason: Because it suffers from rotating amongst CPUs in an odd way, challenging for CPU frequency scaling drivers.
This test tends to be an indicator of potential troubles with some games.
Criteria: (Dirk Brandewie): Must match or better acpi_cpufreq - ondemand.
With patch set: 15.8 Seconds average and 24.51 package watts.
Without patch set: 11.61 Seconds average and 27.59 watts.
Conclusion: Significant reduction in performance with proposed patch set.

Tests 2, 3, 4: Phoronix apache, kernel compile, and postmark tests.
Conclusion: All were similar with and without the patch set, with perhaps a slight
improvement in power consumption for the postmark test with the patch set.

Test 5: Random reads within a largish (50 gigabytes) file.
Reason: Because it was a test I used to use with other include or not include IOWAIT work.
Conclusion: no difference with and without the patch set, likely due to domination by 
long seek times (the file is on a normal disk, not an SSD).

Test 6: Sequential read of a largish (50 gigabytes) file.
Reason: Because it was a test I used to use with other include or not include IOWAIT work.
With patch set: 288.38 Seconds; 177.544 MB/Sec; 6.83 Watts.
Without patch set: 292.38 Seconds; 174.99 MB/Sec; 7.08 Watts.
Conclusion: Better performance and better power with the patch set.

Test 7: Compile the kernel 9 times.
Reason: Just because it was a very revealing test during the
"intel_pstate: Increase hold-off time before busyness is scaled"
discussion / thread(s).
Conclusion: no difference with and without the patch set.

Test 8: pipe-test between cores.
Reason: Just because it was so useful during the
"cross core scheduling frequency drop bisected to 0c313cb20732"
discussion / thread(s).
With patch set: 73.166 Sec; 3.6576 usec/loop; 2278.53 Joules.
Without Patch set: 74.444 Sec; 3.7205 usec/loop; 2338.79 Joules.
Conclusion: Slightly better performance and better energy with the patch set.

Test 9: Dougs_specpower simulator (20% load):
Time is fixed, less energy is better.
Reason: During the long
"[intel-pstate driver regression] processor frequency very high even if in idle"
and subsequent https://bugzilla.kernel.org/show_bug.cgi?id=115771
discussion / thread(s), some sort of test was needed to try to mimic what Srinivas
was getting on his fancy SpecPower test platform. So far at least, this test does that.
Only the 20% load case was created, because that was the biggest problem case back then.
With patch set: 4 tests at an average of 7197 Joules per test, relatively high CPU frequencies.
Without the patch set: 4 tests at an average of 5956 Joules per test, relatively low CPU frequencies.
Conclusion: 21% energy regression with the patch set.
Note: Newer processors might do better than my older i7-2600K.

Test 10: measure the frequency response curve, fixed work packet method,
75 hertz work / sleep frequency (all CPU, no IOWAIT):
Reason: To compare to some older data and observe overall.
png graph attached - might get stripped from the distribution lists.
Conclusions: Tends to oscillate, suggesting some sort of damping is needed.
However, any filtering tends to increase the step function load rise time
(see test 11 below, I think there is some wiggle room here).
See also graph which has: with and without patch set; performance mode (for reference);
Philippe Longepe's cpu_load method also with setpoint 40 (for reference); one of my previous
attempts at a load related patch set from quite sometime ago (for reference).

Test 11: Look at the step function load response. From no load to 100% on one CPU (CPU load only, no IO).
While there is a graph, it is not attached:
Conclusion: The step function response is greatly improved (virtually one sample time max).
It would probably be O.K. to slow it down a little with a filter so as to reduce the
tendency to oscillate under periodic load conditions (to a point, at least. A low enough frequency will
always oscillate) (see the graph for test10).
 
Questions:
Is there a migration plan? i.e. will there be an attempt to merge the current cpu_load method
and this method into one method? Then possibly the PID controller could be eliminated.

... Doug


