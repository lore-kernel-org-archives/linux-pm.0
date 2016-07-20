From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
	support
Date: Wed, 20 Jul 2016 08:24:50 +0200
Message-ID: <20160720062450.GA8066@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
	<CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com>
	<20160617140738.GA1809@wunner.de>
	<1975118.iO8UCAENoH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1975118.iO8UCAENoH-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 20, 2016 at 02:33:18AM +0200, Rafael J. Wysocki wrote:
> On Friday, June 17, 2016 04:07:38 PM Lukas Wunner wrote:
> > On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> > > > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > > We also have such a functional dependency for Thunderbolt on Macs:
> > > > On resume from system sleep, the PCIe hotplug ports may not resume
> > > > before the thunderbolt driver has reestablished the PCI tunnels.
> > > > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > > > in drivers/pci/quirks.c. It would be good if we could represent
> > > > this dependency using something like Rafael's approach instead of
> > > > open coding it, however one detail in Rafael's patches is problematic:
> > > >
> > > > > New links are added by calling device_link_add() which may happen
> > > > > either before the consumer device is probed or when probing it, in
> > > > > which case the caller needs to ensure that the driver of the
> > > > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > > > flag should be passed to device_link_add() to reflect that.
> > > >
> > > > The thunderbolt driver cannot call device_link_add() before the
> > > > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > > > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > > > if the thunderbolt driver isn't loaded.
> > > >
> > > > It would therefore be beneficial if device_link_add() can be
> > > > called even *after* the consumer is bound.
> > > 
> > > I don't quite follow.
> > > 
> > > Who's the provider and who's the consumer here?
> > 
> > thunderbolt.ko is the supplier.
> 
> But it binds to the children of the ports that are supposed to be its
> consumers?
> 
> Why is that even expected to work?

No, the consumers are aunts (or uncles) of the supplier, if you will. :-)

The consumers are the hotplug ports (named "Downstream Bridge 1 / 2" in
the drawing below). The supplier is the NHI:

      (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
                                         +-- Downstream Bridge 1 --
                                         +-- Downstream Bridge 2 --
                                         ...

We're calling pci_power_up() and pci_restore_state() from
pci_pm_resume_noirq(). And that will fail for devices below
the hotplug ports if the PCI tunnels haven't been re-established
yet by the NHI.

Currently we achieve that via quirk_apple_wait_for_thunderbolt() in
drivers/pci/quirks.c. It would be more elegant if we could make this
relationship explicit with "device links" and let the core handle it.

Or am I mistaken and this particular use case is not what "device links"
are intended for?

Thanks,

Lukas
