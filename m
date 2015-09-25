From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
Date: Fri, 25 Sep 2015 15:56:48 +0200
Message-ID: <1660650.dn5zct2eoN@vostro.rjw.lan>
References: <1439172686-16360-1-git-send-email-yu.c.chen@intel.com> <1921486.iFXFBYijSj@vostro.rjw.lan> <36DF59CE26D8EE47B0655C516E9CE64026586EF4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60193 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756131AbbIYN2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 09:28:35 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026586EF4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, September 25, 2015 06:42:41 AM Chen, Yu C wrote:
> Hi,Rafael, thanks a lot for your review, will resend v2 version.
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Friday, September 25, 2015 9:24 AM
> > To: Chen, Yu C
> > Cc: Wysocki, Rafael J; jiang.liu@linux.intel.com; Zhang, Rui; Brown, Len; linux-
> > kernel@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: [PATCH][RFC] ACPI / PM: Fix incorrect wakeup irq setting before
> > suspend-to-idle
> > 
> > On Monday, August 10, 2015 10:11:26 AM Chen Yu wrote:
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > 
> > That would only really matter if GPE devices were used, but I've never seen a
> > system using them in practice, so this is more of a theoretical issue.
> > 
> I haven't encountered this problem,  just find this suspicious 
> when I was doing some other debugging.

In fact what I said was incorrect.  You might encounter this problem if the
ACPI interrupt has been remapped and not when GPE devices are used.

> > > ---
> > >  drivers/acpi/osl.c   |  5 ++++-
> > >  drivers/acpi/sleep.c | 20 ++++++++++++++++++--  drivers/acpi/sleep.h
> > > |  5 +++++
> > >  3 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c index
> > > 3b8963f..8e1420a 100644
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -850,7 +851,9 @@ acpi_os_install_interrupt_handler(u32 gsi,
> > acpi_osd_handler handler,
> > >  		       gsi);
> > >  		return AE_OK;
> > >  	}
> > > -
> > > +#ifdef CONFIG_SUSPEND
> > > +	set_wake_irq_freeze(irq);
> > > +#endif
> > 
> > Please don't use #ifdefs in function bodies.  You can use IS_ENABLED() for
> > that.
> > 
> OK, will do.

Alternatively, you can define an empty static inline stub of set_wake_irq_freeze()
for CONFIG_SUSPEND and avoid using IS_ENABLED() even.

But I'd rather define a global acpi_irq variable, store irq in it and access it
directly from acpi_freeze_prepare().  And it doesn't have to depend on CONFIG_SUSPEND
as it is just the IRQ number actually used by ACPI.

BTW, I wonder if there are other places using acpi_gbl_FADT.sci_interrupt directly
which they shouldn't do?

> > >  	acpi_irq_handler = handler;
> > >  	acpi_irq_context = context;
> > >  	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c index
> > > 2f0d4db..9e7b54e 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -620,6 +620,22 @@ static const struct platform_suspend_ops
> > acpi_suspend_ops_old = {
> > >  	.end = acpi_pm_end,
> > >  	.recover = acpi_pm_finish,
> > >  };
> > > +static int wake_irq_freeze = -EINVAL;
> > 
> > There may be more than one of these in theory.
> > 
> Oh, do you mean the naming for this variable is un-suitable? OK, I'll change it to
> acpi_freeze_wake_irq 

No.  What I mean is that in theory there may be multiple ACPI interrupts.

But you need not care about this case because of the

	if (gsi != acpi_gbl_FADT.sci_interrupt)
		return AE_BAD_PARAMETER;

check in acpi_os_install_interrupt_handler().

Thanks,
Rafael

