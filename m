From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Wed, 7 May 2008 14:21:18 +0200
Message-ID: <200805071421.19788.rjw__45620.3437912793$1210163082$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl> <200805062344.31117.rjw@sisk.pl>
	<20080507092931.GD13858@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080507092931.GD13858@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of May 2008, Pavel Machek wrote:
> Hi!
> > ---
> >  Documentation/kernel-parameters.txt |    5 
> >  drivers/acpi/sleep/main.c           |  301 +++++++++++++++++++++---------------
> >  drivers/base/power/main.c           |   15 +
> >  include/linux/pm.h                  |    2 
> >  4 files changed, 201 insertions(+), 122 deletions(-)
> > 
> > Index: linux-2.6/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > +++ linux-2.6/Documentation/kernel-parameters.txt
> > @@ -170,6 +170,11 @@ and is between 256 and 4096 characters. 
> >  	acpi_irq_isa=	[HW,ACPI] If irq_balance, mark listed IRQs used by ISA
> >  			Format: <irq>,<irq>...
> >  
> > +       acpi_old_suspend_ordering [HW,ACPI]
> > +                       Enforce the ACPI 1.0 ordering of the _PTS control
> > +                       method wrt putting devices into low power states
> > +                       default: ACPI 2.0 ordering of _PTS
> > +
> 
> Space vs. tabs issue here, not too important...
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static u32 acpi_target_sleep_state = ACPI_STATE_S0;
> > +
> > +static int init_8259A_after_S1;
> 
> 8259A after S1 init is workaround for bug in toshiba 4030cdt. We can
> probably remove it now.
> 
> > +#ifdef CONFIG_X86
> > +	if (acpi_state == ACPI_STATE_S1 && init_8259A_after_S1) {
> > +		printk("Broken toshiba laptop -> kicking interrupts\n");
> > +		init_8259A(0);
> > +	}
> > +#endif
> 
> This can die. I believe I've removed it already, but apparently not.

Yes, but I'm going to add some analogous code for machines that are known to
need the "old" suspend ordering, so I've left that as a template. ;-)
 
> > +/*
> > + * The following callbacks are used if the pre-ACPI 2.0 suspend ordering has
> > + * been requested.
> > + */
> > +static struct platform_hibernation_ops acpi_hibernation_ops_old = {
> > +	.begin = acpi_hibernation_begin_old,
> > +	.end = acpi_pm_end,
> > +	.pre_snapshot = acpi_pm_disable_gpes,
> > +	.finish = acpi_pm_finish,
> > +	.prepare = acpi_pm_disable_gpes,
> >  	.enter = acpi_hibernation_enter,
> >  	.leave = acpi_hibernation_leave,
> > -	.pre_restore = acpi_hibernation_pre_restore,
> > -	.restore_cleanup = acpi_hibernation_restore_cleanup,
> > +	.pre_restore = acpi_pm_disable_gpes,
> > +	.restore_cleanup = acpi_pm_enable_gpes,
> >  };
> > -#endif				/* CONFIG_HIBERNATION */
> > +#endif /* CONFIG_HIBERNATION */
> 
> ...
> 
> >  /*
> > + * Some platforms (most importantly ACPI) may need to be prepared for
> > + * resuming devices in case of a failure to suspend them.  They should set
> > + * this pointer to the routine that will always be called just prior to resuming
> > + * devices.
> > + */
> > +void (*platform_pm_recover)(void);
> 
> Should this be moved to acpi_suspend/hibernation ops? We already have
> nice structures...

The catch here is that if device_suspend() fails, it doesn't return to the
caller, but invokes device_resume() directly.  While that could be changed, I'm
not sure if the final result would be much nicer (this is a workaround hack
this way or another).

Thanks,
Rafael
