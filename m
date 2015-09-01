From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 11:32:36 +0530
Message-ID: <20150901060236.GB1456@linux>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
 <CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
 <CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01-09-15, 13:36, vichy wrote:
> >> I try to call below 2 functions to change the frequency of clocksource
> >> and clockevent, but the above b) sleep time is still incorrect when
> >> cpu runs in 500Mhz.
> >>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
> >>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);

How and when were you calling them? What kernel version is it ?

> Clock Event Device: arm_global_timer

This driver doesn't have support to update clkevt device's freq. You
may need to modify that based on how arch/arm/kernel/smp_twd.c is
updated. look for: clockevents_update_freq().

-- 
viresh
