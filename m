From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Sun, 27 Sep 2015 15:30:16 +0200
Message-ID: <14896395.L30bH9BMzP@vostro.rjw.lan>
References: <1439172686-16360-1-git-send-email-yu.c.chen@intel.com> <1660650.dn5zct2eoN@vostro.rjw.lan> <36DF59CE26D8EE47B0655C516E9CE64026587434@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64063 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755806AbbI0NB7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2015 09:01:59 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026587434@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Saturday, September 26, 2015 02:37:19 PM Chen, Yu C wrote:
> Hi, Rafael,
> 
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Friday, September 25, 2015 9:57 PM
> > To: Chen, Yu C
> > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui; Brown, Len; linux-
> > kernel@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before
> > suspend-to-idle
> > 
> > On Friday, September 25, 2015 06:42:41 AM Chen, Yu C wrote:
> > > Hi,Rafael, thanks a lot for your review, will resend v2 version.
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: Friday, September 25, 2015 9:24 AM
> > > > To: Chen, Yu C
> > > > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui; Brown,
> > > > Len; linux- kernel@vger.kernel.org; linux-pm@vger.kernel.org
> > > > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq
> > > > setting before suspend-to-idle
> > > >
> > > > On Monday, August 10, 2015 10:11:26 AM Chen Yu wrote:
> > > > > +#ifdef CONFIG_SUSPEND
> > > > > +	set_wake_irq_freeze(irq);
> > > > > +#endif
> > 
> > Alternatively, you can define an empty static inline stub of
> > set_wake_irq_freeze() for CONFIG_SUSPEND and avoid using IS_ENABLED()
> > even.
> > 
> > But I'd rather define a global acpi_irq variable, store irq in it and access it
> > directly from acpi_freeze_prepare().  And it doesn't have to depend on
> > CONFIG_SUSPEND as it is just the IRQ number actually used by ACPI.
> > 
> OK, I've convert it to a global variable acpi_inuse_irq.

Why do you need the "inuse" part?  Why is acpi_irq not sufficient?

> > BTW, I wonder if there are other places using acpi_gbl_FADT.sci_interrupt
> > directly which they shouldn't do?
> > 
> I searched the code and found there are two other potential misuse of 
> acpi_gbl_FADT.sci_interrupt, they are in acpi_os_remove_interrupt_handler
> and acpi_os_wait_events_complete, so I sent out a version 2 patch
> for them.

OK, thanks!

Rafael

