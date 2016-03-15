From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking support
Date: Tue, 15 Mar 2016 13:19:17 -0700
Message-ID: <20160315201917.30639.2415@quark.deferred.io>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
 <56E85EEA.5000604@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34950 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbcCOUTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 16:19:21 -0400
Received: by mail-pf0-f178.google.com with SMTP id n5so42488244pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 13:19:21 -0700 (PDT)
In-Reply-To: <56E85EEA.5000604@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Quoting Dietmar Eggemann (2016-03-15 12:13:46)
> Hi Mike,
> 
> On 14/03/16 05:22, Michael Turquette wrote:
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > Implements cpufreq_scale_freq_capacity() to provide the scheduler with a
> > frequency scaling correction factor for more accurate load-tracking.
> > 
> > The factor is:
> > 
> >       current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)
> > 
> > In fact, freq_scale should be a struct cpufreq_policy data member. But
> > this would require that the scheduler hot path (__update_load_avg()) would
> > have to grab the cpufreq lock. This can be avoided by using per-cpu data
> > initialized to SCHED_CAPACITY_SCALE for freq_scale.
> > 
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
> > ---
> > I'm not as sure about patches 7 & 8, but I included them since I needed
> > frequency invariance while testing.
> > 
> > As mentioned by myself in 2014 and Rafael last month, the
> > arch_scale_freq_capacity hook is awkward, because this behavior may vary
> > within an architecture.
> > 
> > I re-introduce Dietmar's generic cpufreq implementation of the frequency
> > invariance hook in this patch,  and change the preprocessor magic in
> > sched.h to favor the cpufreq implementation over arch- or
> > platform-specific ones in the next patch.
> 
> Maybe it is worth mentioning that this patch is from EAS RFC5.2
> (linux-arm.org/linux-power.git energy_model_rfc_v5.2) which hasn't been
> posted to LKML. The last EAS RFCv5 has the Frequency Invariant Engine
> (FEI) based on the cpufreq notifier calls (cpufreq_callback,
> cpufreq_policy_callback) in the ARM arch code.

Oops, my apologies. I got a little mixed up while developing these
patches and I should have at least asked you about this one before
posting.

I'm really quite happy to drop #7 and #8 if they are too contentious or
if patch #7 is deemed as not-ready by you.

> 
> > If run-time selection of ops is needed them someone will need to write
> > that code.
> 
> Right now I see 3 different implementations of the FEI. 1) The X86
> aperf/mperf based one (https://lkml.org/lkml/2016/3/3/589), 2) This one
> in cpufreq.c and 3) the one based on cpufreq notifiers in ARCH (ARM,
> ARM64) code.
> 
> I guess with sched_util we do need a solution for all platforms
> (different archs, x86 w/ and w/o X86_FEATURE_APERFMPERF, ...).
> 
> > I think that this negates the need for the arm arch hooks[0-2], and
> > hopefully Morten and Dietmar can weigh in on this.
> 
> It's true that we tried to get rid of the usage of the cpufreq callbacks
> (cpufreq_callback, cpufreq_policy_callback) with this patch. Plus we
> didn't want to implement it twice (for ARM and ARM64).
> 
> But 2) would have to work for other ARCHs as well. Maybe as a fall-back
> for X86 w/o X86_FEATURE_APERFMPERF feature?

That's what I had in mind. I guess that some day there will be a need to
select implementations at run-time for both cpufreq (e.g. different
cpufreq drivers might implement arch_scale_freq_capacity) and for the
!CONFIG_CPU_FREQ case (e.g. different platforms might implement
arch_scale_freq_capcity within the same arch).

The cpufreq approach seems the most generic, hence patch #8 to make it
the default.

Regards,
Mike

> 
> [...]
