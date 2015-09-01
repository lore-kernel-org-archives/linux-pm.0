From: vichy <vichy.kuo@gmail.com>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 13:36:54 +0800
Message-ID: <CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
	<CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34447 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbIAFgz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 01:36:55 -0400
In-Reply-To: <CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

hi Viresh:


2015-09-01 11:57 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On Mon, Aug 31, 2015 at 7:33 PM, vichy <vichy.kuo@gmail.com> wrote:
>> hi all:
>> My platform is like below:
>> 1. single core Cortex A9
>> 2. use global timer for system timer
>>
>> after I porting cpu frequency driver based on snow ball, the cpu
>> frequency did change as I expected.
>> But the system time is incorrect( since pherial clk is got from cpu frequency)
>>
>> for example:
>> a) cpu 1G (pherial clk = 250M) --> sleep 1 sec (OK)
>> b) cpu 500M  (pherial clk = 125M) --> sleep 1 sec (will be measured as 2 sec)
>>
>> I try to call below 2 functions to change the frequency of clocksource
>> and clockevent, but the above b) sleep time is still incorrect when
>> cpu runs in 500Mhz.
>>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
>>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
>>
>> in Arm cortex A9 single core system with Global timer as system timer,
>> is there any kernel api to change system timer period when cpu/pherial
>> frequency change?
>>
>> appreciate your kind help in advance,
>
> The list cpufreq@vger.kernel.org is the wrong list for posting cpufreq queries
> as we have moved to Linux PM list <linux-pm@vger.kernel.org> list now.
>
> Try unsetting CPUFREQ_CONST_LOOPS flag in your driver, if you have it
> set.

I DIDN'T set the CPUFREQ_CONST_LOOPS when I register my cpufreq driver
I pasted my cpufreq driver declariation as below:

static struct cpufreq_driver plat_cpufreq_driver = {
    .flags  = CPUFREQ_STICKY,
    .verify = plat_cpufreq_verify_speed,
    .target = plat_cpufreq_target,
    .get    = plat_cpufreq_getspeed,
    .init   = plat_cpufreq_init,
    .name   = "plat-cpufreq",
    .attr   = plat_cpufreq_attr,
};


I have traced the kernel code
if I guess correctly, the sleep accurate is based on jiffies and
tick_handle_periodic will periodically update the next event interval

void tick_handle_periodic
-->
  for (;;) {
          if (!clockevents_program_event(dev, next, false))
              return;
          /*
           * Have to be careful here. If we're in oneshot mode,
           * before we call tick_periodic() in a loop, we need
           * to be sure we're using a real hardware clocksource.
           * Otherwise we could get trapped in an infinite
           * loop, as the tick_periodic() increments jiffies,
           * when then will increment time, posibly causing
           * the loop to trigger again and again.
           */
          if (timekeeping_valid_for_hres())
              tick_periodic(cpu);
          next = ktime_add(next, tick_period);
      }

and in clockevents_program_event, we will use mult, shift to calculate
the cycles need for global timer triggering next interrupt event.

    clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
    rc = dev->set_next_event((unsigned long) clc, dev);

belwo is my tick device information in /proc/timer_list
and multi did change to 1/2 when I change cpu freq from 1G to 500Mhz.
when cpu run 1GHz

except multi and shift, is there any place I need to take care for
system timer accurate?
appreciate your kind help,

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: arm_global_timer
 max_delta_ns:   17043521021
 min_delta_ns:   1000
 mult:           541165879
 shift:          31
 mode:           3
 next_event:     2176344000000 nsecs
 set_next_event: gt_clockevent_set_next_event
 set_mode:       gt_clockevent_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

when cpu run in 500Mhz
Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: arm_global_timer
 max_delta_ns:   34087041979
 min_delta_ns:   1000
 mult:           270582940
 shift:          31
 mode:           3
 next_event:     2230100000000 nsecs
 set_next_event: gt_clockevent_set_next_event
 set_mode:       gt_clockevent_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0
