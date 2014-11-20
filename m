From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Thu, 20 Nov 2014 14:43:29 +0530
Message-ID: <CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
References: <546D26AE.50601@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <546D26AE.50601@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 20, 2014 at 4:54 AM, Mason <mpeg.blue@free.fr> wrote:
> Hello everyone,

Hi,

The right list is linux-pm and try to cc maintainers from MAINTAINERS
file as they can respond quickly then.

> I'm running kernel 3.14 on an ARM Cortex-A9 based SoC.
> The baseline frequency for the ARM CPU is 999 MHz.
>
> The SoC provides a way to dynamically change the CPU frequency,
> dividing it by N/16 (N=32..4095) [Actually, I think there are
> also ways to divide by 1.x, but I need to read the docs again.]
>
> I'm writing the platform-specific cpufreq driver.
> I could expose hundreds of frequencies to cpufreq, but I don't
> think that would be very productive. Correct?
> (Note: I can't offer ANY frequency.)
>
> My question is: how many frequencies should I expose for "optimal"
> behavior of cpufreq?

You can specify as many number of frequencies as you want. The framework
doesn't have any upper cap on that. But there is no point specifying
500 MHz and 510 MHz, you wouldn't save much power with 500 :)

So, just gap them smartly. Normally people gap them to 100 MHz. But
if there is a voltage change required at some specific freq, suppose 550 MHz,
then its better you specific that as well..

> I'm thinking I would only expose div={2,3,5} meaning the available
> scaled frequencies would be {500,333,200} MHz. Are these enough?

I thought you can goto 1 GHz.. Why not the upper ones then?

> Should there be more? Should I go lower than 200 MHz?

If that really saves power.

> I'm also wondering about the cpuinfo_transition_latency variable.
> It seems to be a constant. On my SoC, the latency depends on the
> "width" of the frequency jump. Specifically, the CPU will change
> frequency at 15 MHz/us. So if we're jumping from 1000 to 500 MHz,
> it will take 33 us. From 500 to 333 will take 11 us.
>
> Should I document the max latency? (i.e. for the "widest" jump)

Yes.

> Can the governor request to jump from cpuinfo_min_freq to
> cpuinfo_max_freq directly, skipping intermediate frequencies?

Yes, its a normal case for ondemand governor.

> If so, should I just program
>
> cpuinfo_transition_latency =
>   (((cpuinfo_max_freq - cpuinfo_min_freq) / 1000) / 15) * 1000
>
> = (cpuinfo_max_freq - cpuinfo_min_freq) / 15 (in ns)
> = 53280 ns in my example
>
> Since governors.txt suggests a sampling rate of 10 ms, I suppose
> a transition_latency of 50 us is acceptable?

Yes.
