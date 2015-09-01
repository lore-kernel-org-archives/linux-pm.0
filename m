From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 09:27:13 +0530
Message-ID: <CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34028 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbIAD5O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 23:57:14 -0400
In-Reply-To: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

On Mon, Aug 31, 2015 at 7:33 PM, vichy <vichy.kuo@gmail.com> wrote:
> hi all:
> My platform is like below:
> 1. single core Cortex A9
> 2. use global timer for system timer
>
> after I porting cpu frequency driver based on snow ball, the cpu
> frequency did change as I expected.
> But the system time is incorrect( since pherial clk is got from cpu frequency)
>
> for example:
> a) cpu 1G (pherial clk = 250M) --> sleep 1 sec (OK)
> b) cpu 500M  (pherial clk = 125M) --> sleep 1 sec (will be measured as 2 sec)
>
> I try to call below 2 functions to change the frequency of clocksource
> and clockevent, but the above b) sleep time is still incorrect when
> cpu runs in 500Mhz.
>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);
>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);
>
> in Arm cortex A9 single core system with Global timer as system timer,
> is there any kernel api to change system timer period when cpu/pherial
> frequency change?
>
> appreciate your kind help in advance,

The list cpufreq@vger.kernel.org is the wrong list for posting cpufreq queries
as we have moved to Linux PM list <linux-pm@vger.kernel.org> list now.

Try unsetting CPUFREQ_CONST_LOOPS flag in your driver, if you have it
set.
