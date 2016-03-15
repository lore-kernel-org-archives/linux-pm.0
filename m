From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking
 support
Date: Tue, 15 Mar 2016 19:13:46 +0000
Message-ID: <56E85EEA.5000604@arm.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38171 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965711AbcCOTNu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Mar 2016 15:13:50 -0400
In-Reply-To: <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Hi Mike,

On 14/03/16 05:22, Michael Turquette wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Implements cpufreq_scale_freq_capacity() to provide the scheduler with a
> frequency scaling correction factor for more accurate load-tracking.
> 
> The factor is:
> 
> 	current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)
> 
> In fact, freq_scale should be a struct cpufreq_policy data member. But
> this would require that the scheduler hot path (__update_load_avg()) would
> have to grab the cpufreq lock. This can be avoided by using per-cpu data
> initialized to SCHED_CAPACITY_SCALE for freq_scale.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
> ---
> I'm not as sure about patches 7 & 8, but I included them since I needed
> frequency invariance while testing.
> 
> As mentioned by myself in 2014 and Rafael last month, the
> arch_scale_freq_capacity hook is awkward, because this behavior may vary
> within an architecture.
> 
> I re-introduce Dietmar's generic cpufreq implementation of the frequency
> invariance hook in this patch,  and change the preprocessor magic in
> sched.h to favor the cpufreq implementation over arch- or
> platform-specific ones in the next patch.

Maybe it is worth mentioning that this patch is from EAS RFC5.2
(linux-arm.org/linux-power.git energy_model_rfc_v5.2) which hasn't been
posted to LKML. The last EAS RFCv5 has the Frequency Invariant Engine
(FEI) based on the cpufreq notifier calls (cpufreq_callback,
cpufreq_policy_callback) in the ARM arch code.

> If run-time selection of ops is needed them someone will need to write
> that code.

Right now I see 3 different implementations of the FEI. 1) The X86
aperf/mperf based one (https://lkml.org/lkml/2016/3/3/589), 2) This one
in cpufreq.c and 3) the one based on cpufreq notifiers in ARCH (ARM,
ARM64) code.

I guess with sched_util we do need a solution for all platforms
(different archs, x86 w/ and w/o X86_FEATURE_APERFMPERF, ...).

> I think that this negates the need for the arm arch hooks[0-2], and
> hopefully Morten and Dietmar can weigh in on this.

It's true that we tried to get rid of the usage of the cpufreq callbacks
(cpufreq_callback, cpufreq_policy_callback) with this patch. Plus we
didn't want to implement it twice (for ARM and ARM64).

But 2) would have to work for other ARCHs as well. Maybe as a fall-back
for X86 w/o X86_FEATURE_APERFMPERF feature?

[...]
