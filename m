From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 0/7] cpufreq / sched: cpufreq_update_util() flags and iowait boosting
Date: Mon, 01 Aug 2016 18:30:27 +0200
Message-ID: <2815658.F6xEHcjr3t@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <000001d1ec09$254ed840$6fec88c0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000001d1ec09$254ed840$6fec88c0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Steve Muckle' <steve.muckle@linaro.org>, 'Juri Lelli' <juri.lelli@arm.com>, 'Ingo Molnar' <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 01, 2016 08:26:54 AM Doug Smythies wrote:
> On 2016.07.31 16:32 Rafael J. Wysocki wrote:
> 
> > Hi,
> >
> > Admittedly, this hasn't been tested yet, so no promises and you have been
> > warned.  It builds, though (on x86-64 at least).
> 
> It would not build for me until I changed the kernel configuration file like so:
> 
> $ scripts/diffconfig .config .config_rjw_b_2
>  CPU_FREQ_GOV_SCHEDUTIL m -> y
> 
> (the above is actually backwards, it is "y" that works.)
> 
> Otherwise I got:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#86)
>   MODPOST 3318 modules
> ERROR: "dl_bw_cpus" [kernel/sched/cpufreq_schedutil.ko] undefined!
> ERROR: "dl_bw_of" [kernel/sched/cpufreq_schedutil.ko] undefined!
> ERROR: "runqueues" [kernel/sched/cpufreq_schedutil.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[4]: *** [__modpost] Error 1
> Makefile:1186: recipe for target 'modules' failed

There are some export_symbol declarations missing, I'll fix that up.

Thanks,
Rafael
