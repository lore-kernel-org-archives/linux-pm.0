From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
Date: Tue, 12 Feb 2019 17:20:52 +0100
Message-ID: <CAJZ5v0judv8gvK53Zidn=OEkbgms-5mgQL2URpdfKCrO2nkXoQ@mail.gmail.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <20190212140924.GA14444@kroah.com>
 <CAPDyKFoSGO5Y8wOF8Jd=b7DDSz6Lb2M4+pn7EXOJ4U_AFz+4gQ@mail.gmail.com> <20190212150618.GB19188@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212150618.GB19188@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 4:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 12, 2019 at 03:52:53PM +0100, Ulf Hansson wrote:
> > On Tue, 12 Feb 2019 at 15:09, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> > > > Hi Greg at al,
> > > >
> > > > These fix two issues on top of the recent device links material in
> > > > driver-core/driver-core-next.
> > > >
> > > > The first one fixes a race condition that may trigger when
> > > > __pm_runtime_set_status() is used incorrectly (that is, when it is
> > > > called with PM-runtime enabled for the target device and working).
> > > >
> > > > The second one fixes a supplier PM-runtime usage counter imbalance
> > > > resulting from adding and removing (e.g. in the error code path) a
> > > > stateless device link to it from within the consumer driver's probe
> > > > callback.
> > > >
> > > > Please refer to the patch changelogs for details.
> > >
> > > Looks good, all now queued up, thanks.
> >
> > Greg, please don't get me wrong, but ~1.5 hours isn't sufficient for
> > me to review/test submitted patches.
> >
> > I have been trying to collaborate (review/test) device links related
> > code with Rafael, but what's the point if you queue up the patches,
> > before I even got the change to look at them. Shall I interpret it as
> > you don't care about me reviewing this, then just tell me so I don't
> > have to waste my time.
>
> As they are just in my -testing branch, I can easily drop them now if
> you find problems.  I didn't realize that Rafael was wanting you to
> review this as they were marked as "fixes:" for previous patches.

Sorry for the confusion.

>From my perspective they fix issues on top of the previous commits as
indicated by the Fixes: tags and they work on my systems, but even
though *I* think that they are all good, there still may be problems
with them that I don't see.  As usual. :-)

I guess I should have sent them as RFC this time.

Cheers,
Rafael
