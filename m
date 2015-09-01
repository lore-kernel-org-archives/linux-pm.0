From: vichy <vichy.kuo@gmail.com>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 15:21:40 +0800
Message-ID: <CAOVJa8Hh0i05M7f39Pd9bXQmJA9n8tKTwNQoSmwAdUSSGtP_3w@mail.gmail.com>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
	<CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
	<CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
	<20150901060236.GB1456@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35226 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbbIAHVk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 03:21:40 -0400
In-Reply-To: <20150901060236.GB1456@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

hi Viresh:

2015-09-01 14:02 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 01-09-15, 13:36, vichy wrote:
>> >> I try to call below 2 functions to change the frequency of clocksource
>> >> and clockevent, but the above b) sleep time is still incorrect when
>> >> cpu runs in 500Mhz.
>> >>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
>> >>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
>
> How and when were you calling them? What kernel version is it ?
Belwo is what I did in my cpufreq driver and my kernel version is 3.0.33.
plat_cpufreq_target()
{
........
    cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
    PLAT_Mpll(freqs.new / 1000);
    PLAT_gt_change_freq();
    /* post change notification */
    cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
....
}

and I add  PLAT_gt_change_freq in arm_global_timer.c like below:
 PLAT_gt_change_freq calling() {
    gt_clk_rate = get_periph_clk();
    clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
    __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
}


I also do another experiment that DIDN'T change any REAL HW setting
but change mult/shift to the half value like below:
(But I measure out the "sleep 1" --> still 1secs, even I modify mult/shift)
(in my opinion, the "seep 1" I measured should be 500ms, since HW NO
change but mult/shift change)
plat_cpufreq_target()
{
........
    cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
   //    PLAT_Mpll(freqs.new / 1000); //NO HW FREQ change
     PLAT_gt_change_freq();
    /* post change notification */
    cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
....
}

PLAT_gt_change_freq in arm_global_timer.c like below:
 PLAT_gt_change_freq calling() {
    gt_clk_rate = get_periph_clk()/2; //purposely chage 1/2
    clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
    __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
}

>
>> Clock Event Device: arm_global_timer
>
> This driver doesn't have support to update clkevt device's freq. You
> may need to modify that based on how arch/arm/kernel/smp_twd.c is
> updated. look for: clockevents_update_freq().
I have check the latest kernel about arch/arm/kernel/smp_twd.c
it almost do the same thing like I did, except it use cpufreq notifier
for calling clockevents_update_freq like below:
(the final target of them is the same --> clling
clockevents_update_freq to change mult/shift.

static void twd_update_frequency(void *data)
{
    twd_timer_rate = clk_get_rate(twd_clk);

    clockevents_update_freq(raw_cpu_ptr(twd_evt), twd_timer_rate);
}

I know so far arm global timer seems not support cpu frequcy chage flow.
But like my experiment above to fake change gt_clk_rate, the sleep
should be 1/2 of the original.

if smp_twd call twd_update_frequency to change multi/shift can work,
why purposely adding  clockevents_update_freq in global timer not
working?

or there is something else except Mult/shift need to be modify when
gt_clk_rate changed?

appreciate your help in advance,
>
> --
> viresh
