From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 5/5] ACPI GPE based wakeup event detection
Date: Wed, 22 Oct 2008 14:12:18 +0200
Message-ID: <200810221412.19156.rjw__41401.4456830502$1224677401$gmane$org@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<200810192239.47710.rjw@sisk.pl>
	<20081022065101.GE15271@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081022065101.GE15271@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 22 of October 2008, Shaohua Li wrote:
> On Mon, Oct 20, 2008 at 04:39:47AM +0800, Rafael J. Wysocki wrote:
> > On Thursday, 11 of September 2008, Shaohua Li wrote:
> > > In ACPI platform, if native PME isn't enabled, GPE is used to report wakeup event.
> > 
> > Add more details here, please.
> > 
> > > ---
> > >  drivers/acpi/Kconfig        |    9 ++++++
> > >  drivers/acpi/bus.c          |   15 +++++++++++
> > >  drivers/acpi/sleep/wakeup.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/acpi/acpi_bus.h     |    4 ++
> > >  4 files changed, 88 insertions(+)
> > >
> > > Index: linux/drivers/acpi/Kconfig
> > > ===================================================================
> > > --- linux.orig/drivers/acpi/Kconfig   2008-09-11 10:56:25.000000000 +0800
> > > +++ linux/drivers/acpi/Kconfig        2008-09-11 10:56:47.000000000 +0800
> > > @@ -45,6 +45,15 @@ config ACPI_SLEEP
> > >       depends on PM_SLEEP
> > >       default y
> > >
> > > +config ACPI_GPE_WAKEUP
> > 
> > I'd call it ACPI_RUNTIME_WAKEUP
> ok
> 
> > > +void unregister_acpi_bus_notifier(struct notifier_block *nb)
> > > +{
> > > +     blocking_notifier_chain_unregister(&acpi_bus_notify_list, nb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
> > > +
> > 
> > We were talking about removing the notifier last time.  Please do that.
> Did you see my comments on the issue last time? ACPI test tree already introduces
> the mechanism for other purpose, and we can just use it.
> 
> > > --- linux.orig/include/acpi/acpi_bus.h        2008-09-11 10:56:25.000000000 +0800
> > > +++ linux/include/acpi/acpi_bus.h     2008-09-11 10:56:47.000000000 +0800
> > > @@ -327,6 +327,10 @@ int acpi_bus_get_private_data(acpi_handl
> > >  extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
> > >  extern int register_acpi_notifier(struct notifier_block *);
> > >  extern int unregister_acpi_notifier(struct notifier_block *);
> > > +
> > > +extern int register_acpi_bus_notifier(struct notifier_block *nb);
> > > +extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
> > > +
> > >  /*
> > >   * External Functions
> > >   */
> > >
> > 
> > I understand from the above that devices having their own wake-up GPEs will be
> > handled.  However, it still is completely unclear to me what happens with
> > devices that can generate PME# and for which there are no specific GPEs, like
> > any devices on add-in cards.
> As we discussed last time, pci bus for add-in cards will invoke a gpe, and
> this new implementation will check all pci devices under a bridge to try to find
> a device generating PME. This should work for add-in cards.

Well, can you please describe this mechanism to me or point me to
documents/code where I can read about it?

The question is how we can learn which GPE will be used for signalling the PME#
events.

Thanks,
Rafael
