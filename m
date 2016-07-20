From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking support
Date: Wed, 20 Jul 2016 02:33:18 +0200
Message-ID: <1975118.iO8UCAENoH@vostro.rjw.lan>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com> <CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com> <20160617140738.GA1809@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51443 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752304AbcGTA20 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 20:28:26 -0400
In-Reply-To: <20160617140738.GA1809@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org

On Friday, June 17, 2016 04:07:38 PM Lukas Wunner wrote:
> On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > We also have such a functional dependency for Thunderbolt on Macs:
> > > On resume from system sleep, the PCIe hotplug ports may not resume
> > > before the thunderbolt driver has reestablished the PCI tunnels.
> > > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > > in drivers/pci/quirks.c. It would be good if we could represent
> > > this dependency using something like Rafael's approach instead of
> > > open coding it, however one detail in Rafael's patches is problematic:
> > >
> > > > New links are added by calling device_link_add() which may happen
> > > > either before the consumer device is probed or when probing it, in
> > > > which case the caller needs to ensure that the driver of the
> > > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > > flag should be passed to device_link_add() to reflect that.
> > >
> > > The thunderbolt driver cannot call device_link_add() before the
> > > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > > if the thunderbolt driver isn't loaded.
> > >
> > > It would therefore be beneficial if device_link_add() can be
> > > called even *after* the consumer is bound.
> > 
> > I don't quite follow.
> > 
> > Who's the provider and who's the consumer here?
> 
> thunderbolt.ko is the supplier.

But it binds to the children of the ports that are supposed to be its
consumers?

Why is that even expected to work?

Thanks,
Rafael

