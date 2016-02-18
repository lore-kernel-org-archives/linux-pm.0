From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness
 is scaled
Date: Fri, 19 Feb 2016 00:33:45 +0100
Message-ID: <CAJZ5v0gd7cMUWnG4OEH7cKb1ZGQVE3mJ1hTq2_5faoGJeE72hw@mail.gmail.com>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
	<CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
	<1455838105.7375.206.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36120 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947533AbcBRXdr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 18:33:47 -0500
In-Reply-To: <1455838105.7375.206.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "rafael@kernel.org" <rafael@kernel.org>, "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>, "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Brandewie, Dirk J" <dirk.j.brandewie@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "umgwanakikbuti@gmail.com" <umgwanakikbuti@gmail.com>

On Fri, Feb 19, 2016 at 12:29 AM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> On Thu, 2016-02-18 at 20:43 +0100, Rafael J. Wysocki wrote:
>> Hi Mel,
>>
>> On Thu, Feb 18, 2016 at 12:11 PM, Mel Gorman
>> <mgorman@techsingularity.net> wrote:
>>
>> [cut]
>>
>> >
>> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> > ---
>> >  drivers/cpufreq/intel_pstate.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/cpufreq/intel_pstate.c
>> > b/drivers/cpufreq/intel_pstate.c
>> > index cd83d477e32d..54250084174a 100644
>> > --- a/drivers/cpufreq/intel_pstate.c
>> > +++ b/drivers/cpufreq/intel_pstate.c
>> > @@ -999,7 +999,7 @@ static inline int32_t
>> > get_target_pstate_use_performance(struct cpudata *cpu)
>> >         sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
>> >         duration_us = ktime_us_delta(cpu->sample.time,
>> >                                      cpu->last_sample_time);
>> > -       if (duration_us > sample_time * 3) {
>> > +       if (duration_us > sample_time * 12) {
>> >                 sample_ratio = div_fp(int_tofp(sample_time),
>> >                                       int_tofp(duration_us));
>> >                 core_busy = mul_fp(core_busy, sample_ratio);
>> > --
>>
>> I've been considering making a change like this, but I wasn't quite
>> sure how much greater the multiplier should be, so I've queued this
>> one up for 4.6.
>>
> We need to test power impact on different server workloads. So please
> hold on.
> We have server folks complaining that we already consume too much
> power.

I'll drop the commit if it turns out to cause too much energy to be consumed.

Thanks,
Rafael
