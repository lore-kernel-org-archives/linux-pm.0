From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/4] PCI / ACPI PM: Platform support for
	PCI PME wake-up
Date: Mon, 14 Sep 2009 01:08:08 +0200
Message-ID: <200909140108.08579.rjw__29342.2265480787$1252883278$gmane$org@sisk.pl>
References: <200909132320.05077.rjw@sisk.pl> <200909140053.05779.rjw@sisk.pl>
	<20090913225518.GA31787@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090913225518.GA31787@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 14 September 2009, Matthew Garrett wrote:
> On Mon, Sep 14, 2009 at 12:53:05AM +0200, Rafael J. Wysocki wrote:
> > On Monday 14 September 2009, Matthew Garrett wrote:
> > > On Sun, Sep 13, 2009 at 11:24:03PM +0200, Rafael J. Wysocki wrote:
> > > > +	} else if (!dev->wakeup.flags.run_wake) {
> > > > +		acpi_set_gpe_type(dev->wakeup.gpe_device,
> > > > +					dev->wakeup.gpe_number,
> > > > +					ACPI_GPE_TYPE_WAKE);
> > > 
> > > Is this going to work for cases where we have multiple devices attached 
> > > to the same GPE? The common one is EHCI, where both EHCI HCDs will be 
> > > one a single GPE. If we wake one, that'll then disable the GPE for the 
> > > other. Further wakeup events will then be lost.
> > 
> > You're right, I overlooked that.  Some kind of refcounting is needed here.
> 
> I've sent patches to implement this at the GPE level, which also change 
> the API for requesting them. I'm waiting on feedback from Bob Moore.
> 
> > > > +	if (device->wakeup.flags.valid)
> > > > +		acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
> > > > +						pci_acpi_device_wakeup,
> > > > +						&dev->dev);
> > > > +
> > > 
> > > I think this will fail for the root bridge if acpiphp has already 
> > > grabbed it to check for hotplug events.
> > 
> > The root bridge is not a struct pci_dev and this is called only for these.
> 
> Are you sure?

Yup.  ACPI associates the root bridge handle with the struct device created by
pci_create_bus() as the bridge of the root bus.

> When I did this I saw conflicts with acpiphp. I may have my terminology
> confused. I sent another patch that abstract that out.

I'll have a look at acpihp, then.

Thanks,
Rafael
