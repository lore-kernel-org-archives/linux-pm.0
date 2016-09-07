From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH 2/4]  cpufreq: intel_pstate: Change P-state selection algorithm for Core
Date: Wed, 7 Sep 2016 08:26:05 -0700
Message-ID: <005401d2091c$2885fe50$7991faf0$@net>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan> fzJYbhOgVcv8ifzJabBXDd
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:39268 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757869AbcIGP0M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Sep 2016 11:26:12 -0400
In-Reply-To: fzJYbhOgVcv8ifzJabBXDd
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM list' <linux-pm@vger.kernel.org>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>, 'Morten Rasmussen' <morten.rasmussen@arm.com>, 'Juri Lelli' <Juri.Lelli@arm.com>, 'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steve Muckle' <smuckle@linaro.org>

On 2016.09.02 18:02 Rafael J. Wysocki wrote:

...[cut]...

> This includes an IIR filter on top of the load-based P-state selection,
> but the filter is applied to the non-boosted case only (otherwise it
> defeats the point of the boost) and I used a slightly different raw gain
> value.

The different gain value, 12.5% instead 10%, does come at a cost of some
energy. Although we are finding inconsistencies in the test results.
(I estimated about 2.2% energy cost, for my 20% SpecPower simulator test,
and scaling off of a simple graph I did of energy vs gain with the previous
version).

...[cut]...
> +	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> +	target = clamp_val(target, int_tofp(min_perf), int_tofp(max_perf));
> +	sample->target = fp_toint(target + (1 << (FRAC_BITS-1)));
> +	return sample->target;
> +}
> +

In my earlier proposed versions, it was very much on purpose that it
was keeping the pseudo floating point filtered target. Excerpt:

+	cpu->sample.target = div_u64((int_tofp(100) - scaled_gain) *
+			cpu->sample.target + scaled_gain *
+			unfiltered_target, int_tofp(100));
+	/*
+	 * Clamp the filtered value.
+	 */
+	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
+	if (cpu->sample.target < int_tofp(min_perf))
+		cpu->sample.target = int_tofp(min_perf);
+	if (cpu->sample.target > int_tofp(max_perf))
+		cpu->sample.target = int_tofp(max_perf);
+
+	return fp_toint(cpu->sample.target + (1 << (FRAC_BITS-1)));

Why? To prevent a lock up scenario where, depending on the processor
and the gain settings, the target pstate would never kick over to the
next value. i.e. if it only increased 1/3 of a pstate per iteration
as the filter approached its steady state value. While this condition
did occur in my older proposed implementations, with my processor it
doesn't seem to with this implementation. I didn't theoretically check
other processors.

Another side effect of this change is effectively a further increase
in the gain setting, and thus more energy being given back. This was
determined by looking at step function load response times, as opposed
to math analysis. (I can make pretty graphs if you want.)

The purpose of this e-mail just to make us aware of the tradeoffs,
not to imply it should change.

... Doug


