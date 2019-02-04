From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
Date: Mon, 4 Feb 2019 12:45:20 +0100
Message-ID: <CAJZ5v0jOVLZDoW5BAy9obp7AptTYzKikFo7Qd15kNt5Y9=vXRQ@mail.gmail.com>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan> <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
 <CAJZ5v0g0BC900-u1wivAWqq=XomPgpfpz7s=sWgvCML+2MwLgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g0BC900-u1wivAWqq=XomPgpfpz7s=sWgvCML+2MwLgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 4, 2019 at 12:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Feb 1, 2019 at 4:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi Greg at al,
> > >
> > > This is a combination of the two device links series I have posted
> > > recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> > > and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> > > on top of your driver-core-next branch.
> > >
> > > Recently I have been looking at the device links code because of the
> > > recent discussion on possibly using them in the DRM subsystem (see for
> > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > found a few issues in that code which should be addressed by this patch
> > > series.  Please refer to the patch changelogs for details.
> > >
> > > None of the problems addressed here should be manifesting themselves in
> > > mainline kernel today, but if there are more device links users in the
> > > future, they most likely will be encountered sooner or later.  Also they
> > > need to be fixed for the DRM use case to be supported IMO.
> > >
> > > On top of this the series makes device links support the "composite device"
> > > use case in the DRM subsystem mentioned above (essentially, the last patch
> > > in the series is for that purpose).
> > >
> >
> > Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.
> >
> > If not too late, feel free to add for the first 7 patches:
> >
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks!
>
> > Although, I want to point out one problem that I have found when using
> > device links. I believe it's already there, even before this series,
> > but just wanted to described it for your consideration.
> >
> > This is what happens:
> > I have a platform driver is being probed. During ->probe() the driver
> > adds a device link like this:
> >
> > link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
> > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> >
> > At some point later in ->probe(), the driver realizes that it must
> > remove the device link, either because it encountered an error or
> > simply because it doesn't need the device link to be there anymore.
> > Thus it calls:
> >
> > device_link_del(link);
> >
> > When probe finished of the driver, the runtime PM usage count for the
> > supplier-dev remains increased to 1 and thus it never becomes runtime
> > suspended.
>
> OK, so this is a tricky one.
>
> With this series applied, if the link actually goes away after the
> cleanup device_link_del(), device_link_free() should take care of
> dropping the PM-runtime count of the supplier.  If it doesn't do that,
> there is a mistake in the code that needs to be fixed.
>
> However, if the link doesn't go away after the cleanup
> device_link_del(), the supplier's PM-runtime count will not be
> dropped, because the core doesn't know whether or not the
> device_link_del() has been called by the same entity that caused the
> supplier's PM-runtime count to be incremented.  For example, if the
> consumer device is suspended after the device_link_add() that
> incremented the supplier's PM-runtime count and then suspended again,

I was distracted while writing this, sorry for the confusion.

So let me rephrase:

For example, if the consumer device is suspended after the
device_link_add() that incremented the supplier's PM-runtime count and
then resumed again, the rpm_active refcount will be greater than one
because of the last resume and not because of the initial link
creation.  In that case, dropping the supplier's PM-runtime count on
link deletion may not work as expected.

> Arguably, device_link_del() could be made automatically drop the
> supplier's PM-runtime count by one if the link's rpm_active refcount
> is not one, but there will be failing scenarios in that case too
> AFAICS.
