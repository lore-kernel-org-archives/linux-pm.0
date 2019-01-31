From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
Date: Thu, 31 Jan 2019 17:03:11 +0100
Message-ID: <CAPDyKFr6gehF1iXq6BnUmfg3duDmCtXpQg97euAvH_dyJ785gg@mail.gmail.com>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
 <20190131132247.GA6837@kroah.com> <20190131132409.GA16084@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131132409.GA16084@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Jan 2019 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi Greg at al,
> > > >
> > > > Recently I have been looking at the device links code because of the
> > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > found a few issues in that code which should be addressed by this patch
> > > > series.  Please refer to the patch changelogs for details.
> > > >
> > > > None of the problems addressed here should be manifesting themselves in
> > > > mainline kernel today, but if there are more device links users in the
> > > > future, they most likely will be encountered sooner or later.  Also they
> > > > need to be fixed for the DRM use case to be supported IMO.
> > > >
> > > > This series does not fix all issues in device links that have become
> > > > apparent (generally speaking, the idea of returning an existing link
> > > > in case there is one already for the given consumer-supplier pair
> > > > doesn't play well with stateful links and their flags), so there will
> > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > a reason to sit on these fixes while working on the other patches, so
> > > > here they go.
> > >
> > > Any concerns regarding this lot?
> > >
> > > [Please note that patch 5 in the series was replaced with the v2 at
> > > https://patchwork.kernel.org/patch/10781205/]
> > >
> > > If not, and if you don't mind, I would like to queue it up next week,
> > > possibly along with the follow-up material posted on Monday
> > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > that is not problematic, so it gets some linux-next coverage before
> > > the next merge window.
> >
> > Can I queue it up in my tree, given that I have a number of other driver
> > core patches in there, and I don't know how the merge issues will be if
> > we start to diverge.
> >
> > Or do you need this for some other work?
>
> To make this clearer, I have no objection to take this through my tree
> now, along with your second set of patches.  Is that ok?
>

Greg, Rafael,

FWIW, I intend to review these patches during tomorrow, or at latest
on Monday as I have been a bit busy lately.

Kind regards
Uffe
