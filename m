From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Wed, 16 Mar 2016 19:44:33 +0000
Message-ID: <56E9B7A1.5030806@arm.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EF6.5040005@arm.com> <20160315204630.30639.60702@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44543 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335AbcCPToh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 15:44:37 -0400
In-Reply-To: <20160315204630.30639.60702@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On 15/03/16 20:46, Michael Turquette wrote:
> Quoting Dietmar Eggemann (2016-03-15 12:13:58)
>> On 14/03/16 05:22, Michael Turquette wrote:

[...]

>> For me this independence of the scheduler code towards the actual
>> implementation of the Frequency Invariant Engine (FEI) was actually a
>> feature.
> 
> I do not agree that it is a strength; I think it is confusing. My
> opinion is that cpufreq drivers should implement
> arch_scale_freq_capacity. Having a sane fallback
> (cpufreq_scale_freq_capacity) simply means that you can remove the
> boilerplate from the arm32 and arm64 code, which is a win.
> 
> Furthermore, if we have multiple competing implementations of
> arch_scale_freq_invariance, wouldn't it be better for all of them to
> live in cpufreq drivers? This means we would only need to implement a
> single run-time "selector".
> 
> On the other hand, if the implementation lives in arch code and we have
> various implementations of arch_scale_freq_capacity within an
> architecture, then each arch would need to implement this selector
> function. Even worse then if we have a split where some implementations
> live in drivers/cpufreq (e.g. intel_pstate) and others in arch/arm and
> others in arch/arm64 ... now we have three selectors.

OK, now I see your point. What I don't understand is the fact why you
want different foo_scale_freq_capacity() implementations per cpufreq
drivers. IMHO we want to do the cpufreq.c based implementation to
abstract from that (at least for target_index() cpufreq drivers).

intel_pstate (setpolicy()) is an exception but my humble guess is that
systems with intel_pstate driver have X86_FEATURE_APERFMPERF support.

> Note that this has nothing to do with cpu microarch invariance. I'm
> happy for that to stay in arch code because we can have heterogeneous
> cpus that do not scale frequency, and thus would not enable cpufreq.
> But if your platform scales cpu frequency, then really cpufreq should be
> in the loop.

Agreed.

> 
>>
>> In EAS RFC5.2 (linux-arm.org/linux-power.git energy_model_rfc_v5.2 ,
>> which hasn't been posted to LKML) we establish the link in the ARCH code
>> (arch/arm64/include/asm/topology.h).
> 
> Right, sorry again about preemptively posting the patch. Total brainfart
> on my part.
> 
>>
>> #ifdef CONFIG_CPU_FREQ
>> #define arch_scale_freq_capacity cpufreq_scale_freq_capacity
>> ...
>> +#endif
> 
> The above is no longer necessary with this patch. Same question as
> above: why insist on the arch boilerplate?

OK.

[...]
