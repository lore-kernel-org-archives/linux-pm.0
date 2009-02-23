From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during	suspend-resume
Date: Mon, 23 Feb 2009 13:28:32 +0100
Message-ID: <20090223122832.GB31427__45167.405907023$1235392395$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<20090223083645.GA9582@elte.hu> <200902231229.58743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902231229.58743.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > > Index: linux-2.6/arch/x86/kernel/apm_32.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86/kernel/apm_32.c
> > > +++ linux-2.6/arch/x86/kernel/apm_32.c
> > 
> > > +
> > > +	suspend_device_irqs();
> > >  	device_power_down(PMSG_SUSPEND);
> > > +
> > > +	local_irq_disable();
> > 
> > hm, this is a very repetitive pattern, all around the various 
> > suspend/resume variants. Might make sense to make:
> > 
> >   	device_power_down(PMSG_SUSPEND);
> > 
> > do the irq line disabling plus the local irq disabling 
> > automatically. That also means it cannot be forgotten. The 
> > symmetric action should happen for PMSG_RESUME.
> > 
> > Is there ever a case where we want a different pattern?
> 
> Even if there's no such case, I prefer to call 
> local_irq_disable() explicitly in here, so that it's clearly 
> known where it happens to anyone reading this code.

That property can be implied in the function name:

   	device_power_down_irq_disable(PMSG_SUSPEND);

Open-coding it, if it looks the same in all the cases just 
increases the chances that someone somewhere copies them 
incorrectly.

	Ingo
