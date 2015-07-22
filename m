From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: cpufreq/ondemand: unpinning an unpinned lock.
Date: Wed, 22 Jul 2015 11:02:56 +0200
Message-ID: <20150722090256.GP25159@twins.programming.kicks-ass.net>
References: <20150715220422.GA13789@codemonkey.org.uk>
 <3682267.1lcDzeZuDs@vostro.rjw.lan>
 <20150716051150.GA15404@linux>
 <20150716124241.GA20320@codemonkey.org.uk>
 <55AEE7D8.3000507@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59739 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932731AbbGVJDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 05:03:08 -0400
Content-Disposition: inline
In-Reply-To: <55AEE7D8.3000507@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Tue, Jul 21, 2015 at 05:46:16PM -0700, Stephen Boyd wrote:
> On 07/16/2015 05:42 AM, Dave Jones wrote:
> >On Thu, Jul 16, 2015 at 10:41:50AM +0530, Viresh Kumar wrote:
> >
> >  > > > WARNING: CPU: 1 PID: 29529 at kernel/locking/lockdep.c:3497 lock_unpin_lock+0x109/0x110()
> >  > > > unpinning an unpinned lock
> >  > > > Call Trace:

> >  > > >  [<ffffffffae0d0ec9>] lock_unpin_lock+0x109/0x110
> >  > > >  [<ffffffffae7f93cc>] __schedule+0x3ac/0xb60
> >  > > >  [<ffffffffae7f9c41>] schedule+0x41/0x90
> >  > > >  [<ffffffffae7f9ff8>] schedule_preempt_disabled+0x18/0x30

> Lock pinning is new in v4.2-rc1. Adding Peter just in case there's some
> insight.

Hmm, weird. I've not seen it happen before.

There's potentially 3 unpin's in __schedule():

  - the obvious one in the prev == next case,
  - the on in context_switch(),
  - the on in try_to_wake_up_local().

All 3 appear to be balanced; the first and second against the pin_lock()
at the start of __schedule() and the third against that and it repins
the lock against the first two.

Most curious.
