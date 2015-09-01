From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 14:39:23 +0800
Message-ID: <20150901143923.11b075b5@xhacker>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
	<CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
	<CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
	<20150901060236.GB1456@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20150901060236.GB1456@linux>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vichy <vichy.kuo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Sep 2015 11:32:36 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 01-09-15, 13:36, vichy wrote:
> > >> I try to call below 2 functions to change the frequency of clocksource
> > >> and clockevent, but the above b) sleep time is still incorrect when
> > >> cpu runs in 500Mhz.
> > >>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
> > >>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
> 
> How and when were you calling them? What kernel version is it ?
> 
> > Clock Event Device: arm_global_timer
> 
> This driver doesn't have support to update clkevt device's freq. You
> may need to modify that based on how arch/arm/kernel/smp_twd.c is
> updated. look for: clockevents_update_freq().
> 

This can only help the clockevent. Even with this cpufreq notifier
update, the globaltimer clocksource still can't hold correct/accurate time.

I think the arm global timer is not suitable for clocksource if cpufreq is
enabled.

