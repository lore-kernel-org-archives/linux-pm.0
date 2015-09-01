From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: about system time incorrect after changing cpu frequency
Date: Tue, 1 Sep 2015 13:12:05 +0530
Message-ID: <20150901074205.GC1456@linux>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
 <CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
 <CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
 <20150901060236.GB1456@linux>
 <CAOVJa8Hh0i05M7f39Pd9bXQmJA9n8tKTwNQoSmwAdUSSGtP_3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33532 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117AbbIAHmK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 03:42:10 -0400
Received: by paczk9 with SMTP id zk9so19987260pac.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2015 00:42:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOVJa8Hh0i05M7f39Pd9bXQmJA9n8tKTwNQoSmwAdUSSGtP_3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

On 01-09-15, 15:21, vichy wrote:
> and I add  PLAT_gt_change_freq in arm_global_timer.c like below:
>  PLAT_gt_change_freq calling() {
>     gt_clk_rate = get_periph_clk();
>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);

In earlier versions of kernel, this had a problem that it works only
for ONESHOT mode and simply returns in PERIODIC mode. I do see that
your's mode is ONESHOT only, and so it should have worked.

Anyway, few prints into that routine to see where we are reaching
might help.

>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);

AFAIR, there is a difference between how different mdelay/udelay are
implemented. One of them is using the loops_per_jiffie variable to
calculate the time, other uses clkevt device. I am not 100% sure about
the theory, but that's what I remember. So, have a look from that
perspective as well..

-- 
viresh
