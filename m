From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Wed, 26 Nov 2014 09:44:39 +0530
Message-ID: <CAKohpo=8NU_CyJ-ZQrfFtov3TMGT=HzcuH8F_fnyw4dv4+dvmw@mail.gmail.com>
References: <546D26AE.50601@free.fr>
	<CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
	<546DF891.2050401@free.fr>
	<CAKohpomzxnCy7X+cPsVdDvi0cMRMp2Am1O-S5BeQtTr1CqBhEw@mail.gmail.com>
	<54747DFA.3040802@free.fr>
	<CAKohponats3ZNqaRq+2ff4Vd=iMZHVy17Vs1K+Zmc_D47Br2+A@mail.gmail.com>
	<5474FA1F.50603@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5474FA1F.50603@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 26 November 2014 at 03:22, Mason <mpeg.blue@free.fr> wrote:
> If I remember correctly (please correct me if I am mistaken),
> the kernel keeps a list of timers, ordered by deadline, and
> dynamically configures the system timer to fire at the next
> deadline.

Yes.

>> Look for: /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
>> this is the rate at which cpufreq core checks if cpu's freq require revisiting.
>
> I think setting the sampling rate to 50 ms should make the
> system reactive enough to load swings?

Depends on the kind of load system is under. If load changes quite frequently
then 50 ms can be a very big value. If it doesn't then 50 ms might be good.
But it has to be tuned properly based on how much load the system has
and how much power it consumes.

Some information about that tuning can be found here:
https://www.youtube.com/watch?v=he1UO__K9ao

This is an presentation given by Mathieu Poirier (Linaro) about the work
done on ARM's big LITTLE architecture.

Slides: http://events.linuxfoundation.org/images/stories/slides/elc2013_poirier.pdf

>>> This 'struct clk' is an elusive beast.
>>> Where is it defined? I only run into forward declarations.
>>
>> Its architecture specific. What's the architecture you are working on?
>> You may implement your own routine instead of cpufreq_generic_get().
>
> The SoC is made by Sigma Designs. It is based on the ARM Cortex-A9.

Okay, life should be easy then. Normally there will be few programmable
PLLs on your platform. You need to write a clock driver for them similar
to the ones present here: drivers/clk/

And then you can reuse cpufreq-dt.c cpufreq driver, which is generic enough
for everybody :)

>> Yes. Documentation/clk.txt.
>
> Oh boy! platform, device tree, cpu-freq, cpuidle, clk, ... so much
> to learn, so few hours in a day.

:)
