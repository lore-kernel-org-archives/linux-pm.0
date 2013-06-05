From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Wed, 5 Jun 2013 18:17:03 +0200
Message-ID: <20130605161703.GA29958@pd.tnic>
References: <51AF60D5.3080605@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51AF60D5.3080605@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 05, 2013 at 07:01:25PM +0300, Stratos Karafotis wrote:
> Ondemand calculates load in terms of frequency and increases it only
> if the load_freq is greater than up_threshold multiplied by current
> or average frequency. This seems to produce oscillations of frequency
> between min and max because, for example, a relatively small load can
> easily saturate minimum frequency and lead the CPU to max. Then, the
> CPU will decrease back to min due to a small load_freq.

Right, and I think this is how we want it, no?

The thing is, the faster you finish your work, the faster you can become
idle and save power.

If you switch frequencies in a staircase-like manner, you're going to
take longer to finish, in certain cases, and burn more power while doing
so.

Btw, racing to idle is also a good example for why you want boosting:
you want to go max out the core but stay within power limits so that you
can finish sooner.

> This patch changes the calculation method of load and target frequency
> considering 2 points:
> - Load computation should be independent from current or average
> measured frequency. For example an absolute load 80% at 100MHz is not
> necessarily equivalent to 8% at 1000MHz in the next sampling interval.
> - Target frequency should be increased to any value of frequency table
> proportional to absolute load, instead to only the max. Thus:
> 
> Target frequency = C * load
> 
> where C = policy->cpuinfo.max_freq / 100
> 
> Tested on Intel i7-3770 CPU @ 3.40GHz and on Quad core 1500MHz Krait.
> Phoronix benchmark of Linux Kernel Compilation 3.1 test shows an
> increase ~1.5% in performance. cpufreq_stats (time_in_state) shows
> that middle frequencies are used more, with this patch. Highest
> and lowest frequencies were used less by ~9%

I read this as "the workload takes longer to complete" which means
higher power consumption and longer execution times which means less
time spent in idle. And I don't think we want that.

Yes, no?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
