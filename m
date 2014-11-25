From: Mason <mpeg.blue@free.fr>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Tue, 25 Nov 2014 22:52:31 +0100
Message-ID: <5474FA1F.50603@free.fr>
References: <546D26AE.50601@free.fr>
	<CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
	<546DF891.2050401@free.fr>
	<CAKohpomzxnCy7X+cPsVdDvi0cMRMp2Am1O-S5BeQtTr1CqBhEw@mail.gmail.com>
	<54747DFA.3040802@free.fr>
	<CAKohponats3ZNqaRq+2ff4Vd=iMZHVy17Vs1K+Zmc_D47Br2+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponats3ZNqaRq+2ff4Vd=iMZHVy17Vs1K+Zmc_D47Br2+A@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 25/11/2014 16:19, Viresh Kumar wrote:

> On 25 November 2014 at 18:32, Mason <mpeg.blue@free.fr> wrote:
>
>> As far as I can tell, on my SoC, the timer runs at 27 MHz.
>> But I have no idea how often it fires an interrupt.
> 
> 27 MHz is the freq it runs at, but we get interrupt based on the value
> programmed in the timer counter.
> 
> Look for CONFIG_HZ in your .config, that will tell you number of ticks
> you are getting per second.
> 
> But cpufreq works in another level and so it doesn't depend on both
> these.

If I remember correctly (please correct me if I am mistaken),
the kernel keeps a list of timers, ordered by deadline, and
dynamically configures the system timer to fire at the next
deadline.

> Look for: /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
> this is the rate at which cpufreq core checks if cpu's freq require revisiting.

I think setting the sampling rate to 50 ms should make the
system reactive enough to load swings?

>> This 'struct clk' is an elusive beast.
>> Where is it defined? I only run into forward declarations.
> 
> Its architecture specific. What's the architecture you are working on?
> You may implement your own routine instead of cpufreq_generic_get().

The SoC is made by Sigma Designs. It is based on the ARM Cortex-A9.

> Yes. Documentation/clk.txt.

Oh boy! platform, device tree, cpu-freq, cpuidle, clk, ... so much
to learn, so few hours in a day.

> Yeah. You should be able to get some call from your architecture.

OK, I have to fix that function along with the cpufreq update.

Regards.
