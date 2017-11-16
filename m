From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86 / CPU: Always show current CPU frequency in /proc/cpuinfo
Date: Thu, 16 Nov 2017 14:54:53 +0100
Message-ID: <3850698.eZd1pxJPHX@aspire.rjw.lan>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <8646127.yoBvgp8gpO@aspire.rjw.lan> <20171116095036.GB28750@WANG-Chaos-MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54841 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757682AbdKPNzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 08:55:10 -0500
In-Reply-To: <20171116095036.GB28750@WANG-Chaos-MacBook-Pro.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: WANG Chao <chao.wang@ucloud.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thursday, November 16, 2017 10:50:36 AM CET WANG Chao wrote:
> On 11/16/17 at 01:24P, Rafael J. Wysocki wrote:
> > On Wednesday, November 15, 2017 10:33:47 AM CET WANG Chao wrote:
> > > On 11/15/17 at 02:13P, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > After commit 890da9cf0983 (Revert "x86: do not use cpufreq_quick_get()
> > > > for /proc/cpuinfo "cpu MHz"") the "cpu MHz" number in /proc/cpuinfo
> > > > on x86 can be either the nominal CPU frequency (which is constant)
> > > > or the frequency most recently requested by a scaling governor in
> > > > cpufreq, depending on the cpufreq configuration.  That is somewhat
> > > > inconsistent and is different from what it was before 4.13, so in
> > > > order to restore the previous behavior, make it report the current
> > > > CPU frequency like the scaling_cur_freq sysfs file in cpufreq.
> > > > 
> > > > To that end, modify the /proc/cpuinfo implementation on x86 to use
> > > > aperfmperf_snapshot_khz() to snapshot the APERF and MPERF feedback
> > > > registers, if available, and use their values to compute the CPU
> > > > frequency to be reported as "cpu MHz".
> > > > 
> > > > However, do that carefully enough to avoid accumulating delays that
> > > > lead to unacceptable access times for /proc/cpuinfo on systems with
> > > > many CPUs.  Run aperfmperf_snapshot_khz() once on all CPUs
> > > > asynchronously at the /proc/cpuinfo open time, add a single delay
> > > > upfront (if necessary) at that point and simply compute the current
> > > > frequency while running show_cpuinfo() for each individual CPU.
> > > 
> > > Hi, Rafael
> > > 
> > > I tested your patch. It's much faster.
> > > 
> > > But from what I got, calling aperfmperf_snapshot_khz() asynchronously
> > > with 10ms sleep takes much longer than calling aperfmperf_snapshot_khz()
> > > synchronously.
> > > 
> > > Here's my result on 64 CPUs:
> > > 
> > >  - async aperfmperf_snapshot_khz() w/ 10ms sleep:
> > > 
> > > # time cat /proc/cpuinfo > /dev/null
> > > real    0m0.014s
> > > user    0m0.000s
> > > sys     0m0.002s
> > > 
> > >  - sync aperfmperf_snapshot_khz() w/o any sleep:
> > > 
> > > # time cat /proc/cpuinfo > /dev/null
> > > real    0m0.002s
> > > user    0m0.000s
> > > sys     0m0.002s
> > 
> > Sure, but the delay is there, because without it the computed frequency
> > may be way off for at least one of the CPUs.
> 
> Thanks, I understand now. In this case, The 10ms delay turns out to be
> the interval of measuring aperf and mperf and computing their deltas.
> 
> Last question though, is 10ms best practice or can we make it shorter,
> say 5ms?

Experimentally, I found 5 ms to be slightly too short.  It all depends on
how accurate the numbers are expected to be, however, so there is some room
for adjustments.

Regardless, I'd prefer to start with 10 ms as that is what has been used in
intel_pstate for quite a long time at least and adjust later if need be.

Thanks,
Rafael
