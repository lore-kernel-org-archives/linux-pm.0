From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 3/4] intel_pstate: support scheduler cpufreq callbacks
 on remote CPUs
Date: Mon, 25 Apr 2016 23:34:51 +0200
Message-ID: <CAJZ5v0hPK+gfZPRTiQTXJOaC02V6r38W6O+AN+mhBmKE8Ut0Gw@mail.gmail.com>
References: <1461119969-10371-1-git-send-email-smuckle@linaro.org>
	<1461119969-10371-3-git-send-email-smuckle@linaro.org>
	<48732338.GBX16FRDRa@vostro.rjw.lan>
	<20160421022015.GA10028@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34120 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbcDYVex (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 17:34:53 -0400
In-Reply-To: <20160421022015.GA10028@sky.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Thu, Apr 21, 2016 at 4:20 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Wed, Apr 20, 2016 at 02:37:18PM +0200, Rafael J. Wysocki wrote:
> ...
>> > @@ -1173,20 +1179,88 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
>> >             get_avg_frequency(cpu));
>> >  }
>> >
>> > +static void _intel_pstate_update_util(struct cpudata *cpu, u64 time)
>>
>> What about calling this intel_pstate_update_cpu()?
>
> Sure will change.
>
> ...
>> >  static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>> >                                  unsigned long util, unsigned long max)
>> >  {
>> >     struct cpudata *cpu = container_of(data, struct cpudata, update_util);
>> > -   u64 delta_ns = time - cpu->sample.time;
>> > +   s64 delta_ns = time - cpu->sample.time;
>> >
>> > -   if ((s64)delta_ns >= pid_params.sample_rate_ns) {
>> > -           bool sample_taken = intel_pstate_sample(cpu, time);
>> > +   if (delta_ns < pid_params.sample_rate_ns)
>>
>> Why don't you check cpu->ipi_in_progress here too and bail out if it is set?
>>
>> That would allow you to avoid checking the time again below, woulnd't it?
>
> Yeah I think that should work. I can't recall why I thought I needed
> to check the time first, then ipi_in_progress, then the time. As long
> as ipi_in_progress is checked prior to the time, it should be fine.

I actually think that we can just skip all cross-CPU updates in
intel_pstate instead of adding complexity to it.

The governor algorithm here uses feedback registers to estimate
utilization and I don't think it will react to the corss-CPU updates
the way you want plus it is likely to skip them anyway due to the rate
limit.
