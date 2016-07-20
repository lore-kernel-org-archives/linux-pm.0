From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
Date: Wed, 20 Jul 2016 17:23:40 +0200
Message-ID: <20160720152340.GA8337@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <1975118.iO8UCAENoH@vostro.rjw.lan>
 <20160720062450.GA8066@wunner.de>
 <3969169.CcnEsvYuly@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3969169.CcnEsvYuly@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 20, 2016 at 02:52:42PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 20, 2016 08:24:50 AM Lukas Wunner wrote:
> > On Wed, Jul 20, 2016 at 02:33:18AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, June 17, 2016 04:07:38 PM Lukas Wunner wrote:
> > > > On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> > > > > On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > > We also have such a functional dependency for Thunderbolt on Macs:
> > > > > > On resume from system sleep, the PCIe hotplug ports may not resume
> > > > > > before the thunderbolt driver has reestablished the PCI tunnels.
> > > > > > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > > > > > in drivers/pci/quirks.c. It would be good if we could represent
> > > > > > this dependency using something like Rafael's approach instead of
> > > > > > open coding it, however one detail in Rafael's patches is problematic:
> > > > > >
> > > > > > > New links are added by calling device_link_add() which may happen
> > > > > > > either before the consumer device is probed or when probing it, in
> > > > > > > which case the caller needs to ensure that the driver of the
> > > > > > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > > > > > flag should be passed to device_link_add() to reflect that.
> > > > > >
> > > > > > The thunderbolt driver cannot call device_link_add() before the
> > > > > > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > > > > > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > > > > > if the thunderbolt driver isn't loaded.
> > > > > >
> > > > > > It would therefore be beneficial if device_link_add() can be
> > > > > > called even *after* the consumer is bound.
> > > > > 
> > > > > I don't quite follow.
> > > > > 
> > > > > Who's the provider and who's the consumer here?
> > > > 
> > > > thunderbolt.ko is the supplier.
> > > 
> > > But it binds to the children of the ports that are supposed to be its
> > > consumers?
> > > 
> > > Why is that even expected to work?
> > 
> > No, the consumers are aunts (or uncles) of the supplier, if you will. :-)
> > 
> > The consumers are the hotplug ports (named "Downstream Bridge 1 / 2" in
> > the drawing below). The supplier is the NHI:
> > 
> >       (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> >                                          +-- Downstream Bridge 1 --
> >                                          +-- Downstream Bridge 2 --
> >                                          ...
> > 
> > We're calling pci_power_up() and pci_restore_state() from
> > pci_pm_resume_noirq(). And that will fail for devices below
> > the hotplug ports if the PCI tunnels haven't been re-established
> > yet by the NHI.
> 
> So the NHI is a PCIe device, right?
> 
> Does the Thunderbolt driver bind to that device?

The NHI is a PCI device but not a bridge. It has class 0x88000.
Yes, thunderbolt.ko binds to the NHI.

And portdrv binds to the upstream bridge and downstream bridges.
Those have class 0x60400.

Best regards,

Lukas
