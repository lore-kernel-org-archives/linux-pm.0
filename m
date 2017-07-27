From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Thu, 27 Jul 2017 19:54:13 +0300
Message-ID: <1501174453.7957.30.camel@nxp.com>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
         <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
         <1500983686.30745.28.camel@nxp.com> <20170726060634.GY352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726060634.GY352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-07-26 at 11:36 +0530, Viresh Kumar wrote:
> On 25-07-17, 14:54, Leonard Crestez wrote:

> > This patch made it's way into linux-next and it seems to cause imx socs
> > to almost always hang around their max frequency with the ondemand
> > governor, even when almost completely idle. The lowest frequency is
> > never reached. This seems wrong?

> > This driver calculates transition_latency at probe time, the value is
> > not terribly accurate but it reaches values like latency = 109 us, so

> So this is the value that is stored in the global variable
> "transition_latency" in the imx6q-cpufreq.c file? i.e.
> transition_latency = 109000 (ns) to be exact ?

Yes.

> - Don't use this patch and try to change ondemand's sampling rate from
>   sysfs. Try setting it to 10000 and see if the behavior is identical
>   to after this patch.

Yes, it seems to be. Also setting 100000 explicitly fixes this.

I also tried to switch from HZ=100 to HZ=1000 but that did not make a
difference.

> - Find how much time does it really take to change the frequency of
>   the CPU. I don't really thing 109 us is the right transition
>   latency. Use attached patch for that and look for the print message.

Your patch measures latencies of around 2.5ms, but it can vary between
1.6 ms to 3ms from boot-to-boot. This is a lot more than what the
driver reports. Most transitions seem to be faster.

I did a little digging and it seems that a majority of time is always
spent inside clk_pllv3_wait_lock which spins on a HW bit while doing
usleep_range(50, 500). I originally thought it was because of
regulators but the delays involved in that are smaller.

Measuring wall time on a process that can sleep seems dubious, isn't
this vulnerable to random delays because of other tasks?

> Without this patch the sampling rate of ondemand governor will be 109
> ms. And after this patch it would be capped at 10 ms. Why would that
> screw up anyone's setup ? I don't have an answer to that right now.

On a closer look it seems that most of the time is actually spent at
low cpufreq though (90%+).

Your change makes it so that even something like "sleep 1; cat
scaling_cur_freq" raises the frequency to the maximum. This happens
enough that even if you do it in a loop you will never see the minimum
frequency. It seems there is enough internal bookkeeping on such a
wakeup that it takes more than 10ms and enough for a reevaluation of
cpufreq until cat returns the value?!
 
I found this by enabling the power:cpu_frequency tracepoint event and
checking for deltas with a script. Enabling CPU_FREQ_STAT show this:

time_in_state:

396000 1609
792000 71
996000 54

trans_table:

   From  :    To
         :    396000    792000    996000 
   396000:         0        10         7 
   792000:        16         0        12 
   996000:         1        18         0 

This is very unexpected but not necessarily wrong.

--
Regards,
Leonard
