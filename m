From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
Date: Fri, 12 Dec 2014 12:04:16 -0800
Message-ID: <7ha92sk533.fsf@deeprootsystems.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
	<7h8uiemce7.fsf@deeprootsystems.com>
	<CAPDyKFo6zH4__Odm+RiJCbvXquAQqaLyCAiXrSN6s3KfQhok=A@mail.gmail.com>
	<1576771.dIVCOxU0se@vostro.rjw.lan>
	<CAAFQd5B28WiWUqmbmROJUa3H25R=Y774NuemTZDvkoa=CvZUsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50588 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbaLLUET (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Dec 2014 15:04:19 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so7724151pdb.19
        for <linux-pm@vger.kernel.org>; Fri, 12 Dec 2014 12:04:19 -0800 (PST)
In-Reply-To: <CAAFQd5B28WiWUqmbmROJUa3H25R=Y774NuemTZDvkoa=CvZUsw@mail.gmail.com>
	(Tomasz Figa's message of "Fri, 12 Dec 2014 13:15:51 +0900")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Kurtz <djkurtz@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Tomasz Figa <tfiga@chromium.org> writes:

[...]

> We have a power domain, which contains an IOMMU and an IP block, which
> can do bus transactions through that IOMMU. Of course the IP block is
> not aware of the IOMMU, because this is just an integration detail and
> on other platforms using the same IP block the IOMMU might not be
> there. This implies that the driver for this IP block should not be
> aware of the IOMMU either, which, on the buffer allocation and mapping
> side, is achieved by DMA mapping subsystem. We would also want the
> IOMMU to be fully transparent to that driver on PM side.

An even more exciting problem exists when a CPU is in the same domain as
other peripherals, those peripherals are all idle and the power domain
is gated. :)

> Now, for PM related details, they are located in the same power
> domain, which means that whenever the power domain is turned off, the
> CPU can't access their registers and all the hardware state is gone.
> To make the case more interesting, there is no point in programming
> the IOMMU unless the device using it is powered on. Similarly, there
> is no point in powering the domain on to just access the IOMMU. This
> implies that the power domain should be fully controlled by the
> stand-alone IP block, while the peripheral IOMMU shouldn't affect its
> state and its driver only respond to operations performed by driver of
> that stand-alone IP block.

Which implies that the IOMMU driver should have it's own set of
runtime_suspend/runtime_resume callbacks to properly save/restore state
as well.

> A solution like below could work for the above:
>
> - There is a per-device list of peripheral devices, which need to be
> powered on for this device to work.
> - Whenever the IOMMU subsystem/driver binds an IOMMU to a device, it
> adds the IOMMU device to the list of peripheral devices of that device
> (and similarly for removal).
> - A runtime PM operation on a device will also perform the same
> operation on all its peripheral devices.

Yes, that is exactly what we need.

I'd rather use the term "dependent" devices rather than peripheral
devices, but otherwise it sounds like the right approach to me.

Kevin

> Another way would be to extend what the PM runtime core does with
> parent-child relations to handle the whole list of peripheral devices
> instead of just the parent.

