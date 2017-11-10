From: WANG Chao <chao.wang@ucloud.cn>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Fri, 10 Nov 2017 12:11:35 +0800
Message-ID: <20171110041135.GA28293@WANG-Chaos-MacBook-Pro.local>
References: <20171109103814.70688-1-chao.wang@ucloud.cn>
 <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
 <CAJZ5v0hdJhuoX2j=X4C5Rq+GT9_qKtMwgc-P6OJMfQ_36uLaKg@mail.gmail.com>
 <3847477.0JmeHoyQ5e@aspire.rjw.lan>
 <20171110040400.GA97163@WANG-Chaos-MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m97136.mail.qiye.163.com ([220.181.97.136]:6899 "EHLO
        m97136.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbdKJES1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 23:18:27 -0500
Content-Disposition: inline
In-Reply-To: <20171110040400.GA97163@WANG-Chaos-MacBook-Pro.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 11/10/17 at 12:04P, WANG Chao wrote:
> On 11/10/17 at 01:06P, Rafael J. Wysocki wrote:
> > On Thursday, November 9, 2017 11:30:54 PM CET Rafael J. Wysocki wrote:
> > > On Thu, Nov 9, 2017 at 5:06 PM, Rafael J. Wysocki
> > > <rafael.j.wysocki@intel.com> wrote:
> > > > Hi Linus,
> > > >
> > > > On 11/9/2017 11:38 AM, WANG Chao wrote:
> > > >>
> > > >> Commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo) caused
> > > >> a serious performance issue when reading from /proc/cpuinfo on system
> > > >> with aperfmperf.
> > > >>
> > > >> For each cpu, arch_freq_get_on_cpu() sleeps 20ms to get its frequency.
> > > >> On a system with 64 cpus, it takes 1.5s to finish running `cat
> > > >> /proc/cpuinfo`, while it previously was done in 15ms.
> > > >
> > > > Honestly, I'm not sure what to do to address this ATM.
> > > >
> > > > The last requested frequency is only available in the non-HWP case, so it
> > > > cannot be used universally.
> > > 
> > > OK, here's an idea.
> > > 
> > > c_start() can run aperfmperf_snapshot_khz() on all CPUs upfront (say
> > > in parallel), then wait for a while (say 5 ms; the current 20 ms wait
> > > is overkill) and then aperfmperf_snapshot_khz() can be run once on
> > > each CPU in show_cpuinfo() without taking the "stale cache" threshold
> > > into account.
> > > 
> > > I'm going to try that and see how far I can get with it.
> > 
> > Below is what I have.
> > 
> > I ended up using APERFMPERF_REFRESH_DELAY_MS for the delay in
> > aperfmperf_snapshot_all(), because 5 ms tended to add too much
> > variation to the results on my test box.
> > 
> > I think it may be reduced to 10 ms, though.
> > 
> > Chao, can you please try this one and report back?
> 
> Hi, Rafael
> 
> Thanks for the patch. But it doesn't work for me. lscpu takes 1.5s to
> finish on a 64 cpus AMD box with aperfmperf.
> 
> You missed the fact that c_start() will also be called by c_next().
> 
> But I don't think the overall idea is good enough. I think /proc/cpuinfo
> is too general for usespace too be delayed, no matter it's 10ms or 20ms.
> 
> My point is cpu MHz is best to use a cached value for quick access. If
> people are looking for reliable and accurate cpu frequency,
> /proc/cpuinfo is probably a bad idae.
> 
> What do you think?

Could you also explain 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in
/proc/cpuinfo) please? The commit message is not clear for me.

Are there any upstream disscutions? I wasn't following this change in
upstream. Now I can't find any.

Thanks,
WANG Chao
