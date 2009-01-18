From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
	PCI host controllers
Date: Sun, 18 Jan 2009 15:36:46 +0100
Message-ID: <200901181536.47336.rjw__24775.9898579263$1232289684$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
	<200901180130.02933.rjw@sisk.pl>
	<1232243254.23611.40.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1232243254.23611.40.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 18 January 2009, Benjamin Herrenschmidt wrote:
> On Sun, 2009-01-18 at 01:30 +0100, Rafael J. Wysocki wrote:
> 
> > On PCs we have to restore the config spaces before calling pci_enable_device(),
> > because otherwise we have a problem with unconfigured devices being enabled
> > during resume.
> > 
> > Recently it's turned out that in fact we need to call pci_restore_state() with
> > interrupts off and power up the device using the PCI PM native mechanism or we
> > have a problem with shared interrupts.  A patch for that was sent yesterday.
> > 
> > At the same time we can't call pci_enable_device() with interrupts off.
> > 
> > If there are systems on which the standard config spaces of PCI devices are not
> > accessible during resume, they are broken at the moment and quite frankly I
> > don't know what to do to fix them.  I haven't seen any reports of this type of
> > breakage yet, though.
> 
> Well, it's all a bit fishy...
> 
> Part of the problem is that pci_enable_device() is the only chance the
> platform gets to do things like turn power or clocks on for devices that
> aren't strictly following PCI D states.

That's true and not particularly fortunate. :-)
 
> For PowerMac, we get away with it I think mostly because all devices
> that are in this case also have explicit calls to the platform code to
> turn things on.
> 
> But I can very well see embedded systems having trouble in that area.
> 
> I suppose when it happens, it would be a matter of having the right arch
> hook inside pci_restore_state() itself.

Yes, I thought about the same thing.

That said, the only platform implementing the PCI PM hooks we have at the
moment is ACPI ...

> As for the problem with interrupts, maybe the right option here is to
> have the PCI core always restore the state early ? 

Yes, that's what we're going to implement shortly.

Thanks,
Rafael
