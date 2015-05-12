From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Tue, 12 May 2015 20:16:09 +0530
Message-ID: <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
References: <55520F0F.5010906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35624 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791AbbELOqK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 10:46:10 -0400
Received: by obcus9 with SMTP id us9so7258347obc.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2015 07:46:10 -0700 (PDT)
In-Reply-To: <55520F0F.5010906@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

CC'ing Daniel..

On 12 May 2015 at 20:02, Mason <slash.tmp@free.fr> wrote:
> Hello,
>
> I'm working on a Cortex A9 based platform.
>
> I have a basic clock tree, and a very basic cpufreq driver using
> mostly generic driver glue:
>
> static struct cpufreq_driver tangox_cpufreq_driver = {
>         .name           = "tangox-cpufreq",
>         .init           = tangox_cpu_init,
>         .verify         = cpufreq_generic_frequency_table_verify,
>         .target_index   = tangox_target,
>         .get            = cpufreq_generic_get,
>         .exit           = cpufreq_generic_exit,
>         .attr           = cpufreq_generic_attr,
> };
>
> My target_index function is trivial:
>
> static int tangox_target(struct cpufreq_policy *policy, unsigned int idx)
> {
>         return clk_set_rate(policy->clk, freq_table[idx].frequency * 1000);
> }
>
> I was testing an unrelated driver at low frequencies, with the nominal
> frequency (999 MHz) divided by 54 (i.e. freq = 18.5 MHz) and I noticed
> that when the driver calls
>
>     schedule_timeout(HZ);
>
> the thread sleeps 54 seconds instead of 1.
>
> [ 1107.827279] Sleep for 300 jiffies.
> [ 1161.838513] Done sleeping.
>
> (I have HZ set to 300)
>
> I enabled DEBUG in the generic cpufreq driver to see what happens
> when I request a frequency change:
>
> # cd /sys/devices/system/cpu/cpu0/cpufreq
> # cat scaling_governor
> performance
> # cat scaling_available_frequencies
> 999000 499500 333000 199800 111000 18500
> # echo 18500 > scaling_max_freq
> [   19.597257] cpufreq: setting new policy for CPU 0: 18500 - 18500 kHz
> [   19.604017] cpufreq: new min and max freqs are 18500 - 18500 kHz
> [   19.610345] cpufreq: governor: change or update limits
> [   19.615596] cpufreq: __cpufreq_governor for CPU 0, event 3
> [   19.621186] cpufreq: target for CPU 0: 18500 kHz, relation 1, requested 18500 kHz
> [   19.628783] cpufreq: __cpufreq_driver_target: cpu: 0, oldfreq: 999000, new freq: 18500
> [   19.636818] cpufreq: notification 0 of frequency transition to 18500 kHz
> [   19.643625] cpufreq: notification 0 of frequency transition to 18500 kHz
> [   19.650454] NEW RATE=9250000
> [   19.653644] NEW RATE=9250000
> [   19.657091] cpufreq: notification 1 of frequency transition to 18500 kHz
> [   19.664176] cpufreq: FREQ: 18500 - CPU: 0
> [   19.668412] cpufreq: notification 1 of frequency transition to 18500 kHz
> [   19.675648] cpufreq: FREQ: 18500 - CPU: 1
>
> The "NEW RATE" traces are ones I added in smp_twd.c:twd_update_frequency()
> (my clockevent source) to check whether the CPU frequency change propagated
> to smp_twd.
>
> I must have made an obvious mistake. Could someone point it out to me?
> (I have attached the output of /proc/timer_list to this message)
>
> Looking more closely at schedule_timeout(), I suppose the work happens
> in __mod_timer()... Hmm, that one is over my head.
>
> What am I missing?

A Broadcast device ? So you have two CPUs with a local timer each, whose
expires-next is set to KTIME_MAX (infinite).... So you will get interrupted
once the counter has overflown, probably that's what 54 seconds is all about..

Probably your CPUs are going into idle and no one is waking them up and that's
why you need a broadcast device, i.e. another global timer on your SoC, outside
of the CPU subsystem.

It doesn't have anything to do with cpufreq AFAICT ..

--
viresh
