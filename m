From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [lkp] [sched/fair] 41e0d37f7a: divide error: 0000 [#1] SMP
Date: Fri, 06 May 2016 14:29:35 +0200
Message-ID: <3547943.XdEfRmCVLV@vostro.rjw.lan>
References: <87mvo8gd44.fsf@yhuang-dev.intel.com> <2986116.vKjD9YH9EZ@vostro.rjw.lan> <CANRm+Cw9mFGBttgWUHrbZ_n3NvGswh6T-Ws9g31HDxCEf5--Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57381 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757596AbcEFM0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 08:26:22 -0400
In-Reply-To: <CANRm+Cw9mFGBttgWUHrbZ_n3NvGswh6T-Ws9g31HDxCEf5--Cg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, kernel test robot <ying.huang@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, lkp@01.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Mike Galbraith <efault@gmx.de>, Michael Turquette <mturquette@baylibre.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Friday, May 06, 2016 03:06:44 PM Wanpeng Li wrote:
> 2016-05-05 21:46 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Thursday, May 05, 2016 01:05:41 PM Wanpeng Li wrote:
> >> 2016-05-03 23:10 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> >> > On Tuesday, May 03, 2016 03:53:12 PM Rafael J. Wysocki wrote:

[cut]

> >>
> >> I can reproduce the bug and your patch fix it.
> >>
> >> Tested-by: Wanpeng Li <wanpeng.li@hotmail.com>
> >
> > Thanks!
> >
> > Please also try this one:
> >
> > https://patchwork.kernel.org/patch/9012861/
> >
> > which is the final fix for this bug.
> 
> The warning disappear.
> 
> Tested-by: Wanpeng Li <wanpeng.li@hotmail.com>

Thank you!

