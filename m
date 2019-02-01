From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
Date: Fri, 1 Feb 2019 16:17:23 +0100
Message-ID: <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Greg at al,
>
> This is a combination of the two device links series I have posted
> recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> on top of your driver-core-next branch.
>
> Recently I have been looking at the device links code because of the
> recent discussion on possibly using them in the DRM subsystem (see for
> example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> found a few issues in that code which should be addressed by this patch
> series.  Please refer to the patch changelogs for details.
>
> None of the problems addressed here should be manifesting themselves in
> mainline kernel today, but if there are more device links users in the
> future, they most likely will be encountered sooner or later.  Also they
> need to be fixed for the DRM use case to be supported IMO.
>
> On top of this the series makes device links support the "composite device"
> use case in the DRM subsystem mentioned above (essentially, the last patch
> in the series is for that purpose).
>

Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.

If not too late, feel free to add for the first 7 patches:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Although, I want to point out one problem that I have found when using
device links. I believe it's already there, even before this series,
but just wanted to described it for your consideration.

This is what happens:
I have a platform driver is being probed. During ->probe() the driver
adds a device link like this:

link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

At some point later in ->probe(), the driver realizes that it must
remove the device link, either because it encountered an error or
simply because it doesn't need the device link to be there anymore.
Thus it calls:

device_link_del(link);

When probe finished of the driver, the runtime PM usage count for the
supplier-dev remains increased to 1 and thus it never becomes runtime
suspended.

I haven't thought more in detail of how to address this problem, just
wanted to describe it for you, briefly. The test I have done is by
using a my local RPM testdriver and my local PM domain testdriver, so
no real bug has been reported, at least as far as I know.

Kind regards
Uffe
