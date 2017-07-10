From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant load-tracking support
Date: Mon, 10 Jul 2017 14:46:38 +0200
Message-ID: <4673356.gkeX7KYvlb@aspire.rjw.lan>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com> <12829054.TWIodSo4bb@aspire.rjw.lan> <20170710065443.GG2928@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61671 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753245AbdGJMyT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 08:54:19 -0400
In-Reply-To: <20170710065443.GG2928@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Monday, July 10, 2017 12:24:43 PM Viresh Kumar wrote:
> On 08-07-17, 14:09, Rafael J. Wysocki wrote:
> > I'm sort of wondering how many is "a lot" really.  For instance, do you really
> > want all of the existing ARM platforms to use the new stuff even though
> > it may regress things there in principle?
> 
> That's a valid question and we must (maybe we already have) have a policy for
> such changes.

I don't think it is a matter of policy, as it tends to vary from case to case.

What really matters is the reason to make the changes in this particular case.

If the reason if to help new systems to work better in the first place and the
old ones are affected just by the way, it may be better to avoid affecting them.

On the other hand, if the reason is to improve things for all the new and old
systems altogether, then sure let's do it this way.

> I thought that such changes (which are so closely bound to the
> scheduler) must be at least done at the architecture level and not really at
> platform level. And so doing it widely (like done in this patch) maybe the right
> thing to do.

This particular change is about a new feature, so making it in the core is OK
in two cases IMO: (a) when you actively want everyone to be affected by it and
(b) when the effect of it on the old systems should not be noticeable.

Thanks,
Rafael
