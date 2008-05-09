From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Fri, 9 May 2008 19:20:26 +0200
Message-ID: <200805091920.27756.rjw__12709.0056463659$1210353983$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl>
	<20080507092931.GD13858@elf.ucw.cz>
	<200805071421.19788.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805071421.19788.rjw@sisk.pl>
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

On Wednesday, 7 of May 2008, Rafael J. Wysocki wrote:
> On Wednesday, 7 of May 2008, Pavel Machek wrote:
> > Hi!
> > > ---
> > >  Documentation/kernel-parameters.txt |    5 
> > >  drivers/acpi/sleep/main.c           |  301 +++++++++++++++++++++---------------
> > >  drivers/base/power/main.c           |   15 +
> > >  include/linux/pm.h                  |    2 
> > >  4 files changed, 201 insertions(+), 122 deletions(-)
> > > 
> > > Index: linux-2.6/Documentation/kernel-parameters.txt
> > > ===================================================================
> > > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > > +++ linux-2.6/Documentation/kernel-parameters.txt
> > > @@ -170,6 +170,11 @@ and is between 256 and 4096 characters. 
> > >  	acpi_irq_isa=	[HW,ACPI] If irq_balance, mark listed IRQs used by ISA
> > >  			Format: <irq>,<irq>...
> > >  
> > > +       acpi_old_suspend_ordering [HW,ACPI]
> > > +                       Enforce the ACPI 1.0 ordering of the _PTS control
> > > +                       method wrt putting devices into low power states
> > > +                       default: ACPI 2.0 ordering of _PTS
> > > +
> > 
> > Space vs. tabs issue here, not too important...
> > 
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static u32 acpi_target_sleep_state = ACPI_STATE_S0;
> > > +
> > > +static int init_8259A_after_S1;
> > 
> > 8259A after S1 init is workaround for bug in toshiba 4030cdt. We can
> > probably remove it now.
> > 
> > > +#ifdef CONFIG_X86
> > > +	if (acpi_state == ACPI_STATE_S1 && init_8259A_after_S1) {
> > > +		printk("Broken toshiba laptop -> kicking interrupts\n");
> > > +		init_8259A(0);
> > > +	}
> > > +#endif
> > 
> > This can die. I believe I've removed it already, but apparently not.
> 
> Yes, but I'm going to add some analogous code for machines that are known to
> need the "old" suspend ordering, so I've left that as a template. ;-)

Okay, I guess we the $subject patch can be replaced with the two following
ones.

The first of them removes the Toshiba hook.

The second one adds a suspend sequence workaround by midifying the high-level
code and introducing new "recover" callbacks for the platform.

Then have only been compilation tested.

Please have a look.

Thanks,
Rafael
