From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Fri, 28 Jul 2017 10:58:43 +0530
Message-ID: <20170728052843.GT352@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
 <1500983686.30745.28.camel@nxp.com>
 <20170726060634.GY352@vireshk-i7>
 <1501174453.7957.30.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501174453.7957.30.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

+ IMX maintainers.

On 27-07-17, 19:54, Leonard Crestez wrote:
> On Wed, 2017-07-26 at 11:36 +0530, Viresh Kumar wrote:

> > - Find how much time does it really take to change the frequency of
> >   the CPU. I don't really thing 109 us is the right transition
> >   latency. Use attached patch for that and look for the print message.
> 
> Your patch measures latencies of around 2.5ms, but it can vary between
> 1.6 ms to 3ms from boot-to-boot. This is a lot more than what the
> driver reports. Most transitions seem to be faster.

Wow !!

I was pretty sure all these figures are just made up by some coder :)

> I did a little digging and it seems that a majority of time is always
> spent inside clk_pllv3_wait_lock which spins on a HW bit while doing
> usleep_range(50, 500). I originally thought it was because of
> regulators but the delays involved in that are smaller.
> 
> Measuring wall time on a process that can sleep seems dubious, isn't
> this vulnerable to random delays because of other tasks?

I am not sure I understood that, sorry.

> > Without this patch the sampling rate of ondemand governor will be 109
> > ms. And after this patch it would be capped at 10 ms. Why would that
> > screw up anyone's setup ? I don't have an answer to that right now.
> 
> On a closer look it seems that most of the time is actually spent at
> low cpufreq though (90%+).
> 
> Your change makes it so that even something like "sleep 1; cat
> scaling_cur_freq" raises the frequency to the maximum.

Why?

> This happens
> enough that even if you do it in a loop you will never see the minimum
> frequency. It seems there is enough internal bookkeeping on such a
> wakeup that it takes more than 10ms and enough for a reevaluation of
> cpufreq until cat returns the value?!

At this point I really feel that this is a hardware specific problem
and it was working by chance until now. And I am not sure if we
shouldn't be stopping this patch from getting merged just because of
that.

At least you can teach your distribution to go increase the sampling
rate from userspace to make it all work.

Can you try one more thing? Try using schedutil governor and see how
it behaves ?

> I found this by enabling the power:cpu_frequency tracepoint event and
> checking for deltas with a script. Enabling CPU_FREQ_STAT show this:
> 
> time_in_state:
> 
> 396000 1609

So we still stay at the lowest frequency most of the time.

> 792000 71
> 996000 54
> 
> trans_table:
> 
>    From  :    To
>          :    396000    792000    996000 
>    396000:         0        10         7 
>    792000:        16         0        12 
>    996000:         1        18         0 

What is it that you are trying to point out here? I still see that we
are coming back to 396 MHz quite often.

Maybe can you compare these values with and without this patch to let
us know?

> This is very unexpected but not necessarily wrong.

I haven't understood the problem completely yet :(

-- 
viresh
