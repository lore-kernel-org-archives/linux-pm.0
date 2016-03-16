From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking
 support
Date: Wed, 16 Mar 2016 18:33:55 +0000
Message-ID: <56E9A713.4030007@arm.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EEA.5000604@arm.com> <20160315201917.30639.2415@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44243 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934609AbcCPSd7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 14:33:59 -0400
In-Reply-To: <20160315201917.30639.2415@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On 15/03/16 20:19, Michael Turquette wrote:
> Quoting Dietmar Eggemann (2016-03-15 12:13:46)
>> Hi Mike,
>>
>> On 14/03/16 05:22, Michael Turquette wrote:
>>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>>

[...]

>> Maybe it is worth mentioning that this patch is from EAS RFC5.2
>> (linux-arm.org/linux-power.git energy_model_rfc_v5.2) which hasn't been
>> posted to LKML. The last EAS RFCv5 has the Frequency Invariant Engine
>> (FEI) based on the cpufreq notifier calls (cpufreq_callback,
>> cpufreq_policy_callback) in the ARM arch code.
> 
> Oops, my apologies. I got a little mixed up while developing these
> patches and I should have at least asked you about this one before
> posting.

No need to apologize, just wanted to set the context right for people
following the EAS stuff.

> I'm really quite happy to drop #7 and #8 if they are too contentious or
> if patch #7 is deemed as not-ready by you.

If people think that driving frequency invariance from within cpufreq.c
is the right thing to so then this patch can stay.

That said, I'm not sure if we can do a better job of integrating
freq_scale into existing cpufreq data structures.


>>> If run-time selection of ops is needed them someone will need to write
>>> that code.
>>
>> Right now I see 3 different implementations of the FEI. 1) The X86
>> aperf/mperf based one (https://lkml.org/lkml/2016/3/3/589), 2) This one
>> in cpufreq.c and 3) the one based on cpufreq notifiers in ARCH (ARM,
>> ARM64) code.

I rechecked the functionality of this implementation (2) versus (1) and
(3) by running them all together on an X86 system w/
X86_FEATURE_APERFMPERF and acpi-cpufreq (i5 CPU M520) w/o actually doing
the wiring towards arch_scale_freq_capacity and they all behave similar
or equal. The update of (1) happens much more often obviously since its
driven from the scheduler tick.

...
arch_scale_freq_tick: APERF/MPERF: aperf=5864236223 mperf=6009442434
acnt=200073 mcnt=362360 arch_cpu_freq=565
arch_scale_freq_tick: APERF/MPERF: aperf=5864261886 mperf=6009474724
acnt=25663 mcnt=32290 arch_cpu_freq=813
scale_freq_capacity: CPUFREQ.C: cpu=1 freq_scale=910
cpufreq_callback: NOTIFIER: cpu=1 curr_freq=2133000 max_freq=2400000
freq_scale=910
arch_scale_freq_tick: APERF/MPERF: aperf=5864524610 mperf=6009802492
acnt=262724 mcnt=327768 arch_cpu_freq=820
arch_scale_freq_tick: APERF/MPERF: aperf=5864581063 mperf=6009862268
acnt=56453 mcnt=59776 arch_cpu_freq=967
...

[...]
