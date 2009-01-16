From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Fri, 16 Jan 2009 22:11:56 +0100
Message-ID: <200901162211.57506.rjw__43605.8659143329$1232140582$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901162154.44045.rjw@sisk.pl>
	<200901161259.56586.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901161259.56586.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux PCI <linux-pci@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 16 January 2009, Jesse Barnes wrote:
> On Friday, January 16, 2009 12:54 pm Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PCI PM: Restore standard config registers of all devices early
> >
> > There is a problem in our handling of suspend-resume of PCI devices
> > that many of them have their standard config registers restored with
> > interrupts enabled and they are put into the full power state with
> > interrupts enabled as well.  This may lead to the following scenario:
> > * an interrupt vector is shared between two or more devices
> > * one device is resumed earlier and generates an interrupt
> > * the interrupt handler of another device tries to handle it and
> >   attempts to access the device the config space of which hasn't
> >   been restored yet and/or which still is in a low power state
> > * the system crashes as a result
> >
> > To prevent this from happening we should restore the standard
> > configuration registers of all devices with interrupts disabled and
> > we should put them into the D0 power state right after that.
> > Unfortunately, this cannot be done using the existing
> > pci_set_power_state(), because it can sleep.  Also, to do it we have
> > to make sure that the config spaces of all devices were actually
> > saved during suspend.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Thanks Rafael, I stuffed this one into my for-linus branch.

Thanks!

> I'd like it to go through a linux-next cycle before pushing it to Linus,

Me too.

> but if he's impatient to get it into -rc2 he can always pull sooner (there's
> only one other small fix in there atm).

Well, -rc2 is upon us already.

Thanks,
Rafael
