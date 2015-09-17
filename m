From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V11] Report interrupt that caused system wakeup
Date: Thu, 17 Sep 2015 02:32:49 +0200
Message-ID: <4056041.FR0q97Cc7G@vostro.rjw.lan>
References: <1442338366-16911-1-git-send-email-alexandra.yates@linux.intel.com> <17197937.G4AcryW2hF@vostro.rjw.lan> <55F9B1A7.3080508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50738 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753147AbbIQAEs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 20:04:48 -0400
In-Reply-To: <55F9B1A7.3080508@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-pm@vger.kernel.org, tglx@linutronix.de, kristen.c.accardi@intel.com

On Wednesday, September 16, 2015 11:15:03 AM Alexandra Yates wrote:
> Hi Rafael,
> 
> On 09/15/2015 07:40 PM, Rafael J. Wysocki wrote:
> > On Tuesday, September 15, 2015 10:32:46 AM Alexandra Yates wrote:
> >> Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ
> >> number of the first wakeup interrupt (that is, the first interrupt
> >> from an IRQ line armed for system wakeup) seen by the kernel during
> >> the most recent system suspend/resume cycle.
> >>
> >> This feature will be useful for system wakeup diagnostics of
> >> spurious wakeup interrupts.
> >>
> >> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> > I've applied this, but I needed to fix it up due to build problems.
> >
> > I'd rather not to that again for any of your future patches.
> I'm sorry you encountered this issue.  But, I built the patch before I 
> sent it
> against linux-pm with release 2.5 and the latest as of yesterday.
> 
> I'm wondering if I'm using the wrong tree/branch?  I would appreciate 
> you help me
> understand what went wrong so that this doesn't happen again for future 
> patches.

The global wakeup_irq variable was defined under a CONFIG option and used
outside of it, so build would break when that option was not set.  Also,
the name of the variable conflicted with another one defined already
elsewhere.

Moreover, a static inline stub in the header file was missing the argument
name (which is why it is a good idea to always use arg names and not just
data types in function headers).

Thanks,
Rafael

