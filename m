From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
Date: Fri, 1 Feb 2019 01:12:31 +0100
Message-ID: <20190201001231.GA4886@kroah.com>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
 <CAJZ5v0geMbgNKBFT104o4Jf38q7yo46ha+qFbd+9Mbr+P8n--A@mail.gmail.com>
 <20190131182407.GA6191@kroah.com>
 <2779542.Q4bG6sN7hf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2779542.Q4bG6sN7hf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 12:50:58AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 31, 2019 7:24:07 PM CET Greg Kroah-Hartman wrote:
> > On Thu, Jan 31, 2019 at 05:02:05PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 2:24 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > > >
> > > > > > > Hi Greg at al,
> > > > > > >
> > > > > > > Recently I have been looking at the device links code because of the
> > > > > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > > > > found a few issues in that code which should be addressed by this patch
> > > > > > > series.  Please refer to the patch changelogs for details.
> > > > > > >
> > > > > > > None of the problems addressed here should be manifesting themselves in
> > > > > > > mainline kernel today, but if there are more device links users in the
> > > > > > > future, they most likely will be encountered sooner or later.  Also they
> > > > > > > need to be fixed for the DRM use case to be supported IMO.
> > > > > > >
> > > > > > > This series does not fix all issues in device links that have become
> > > > > > > apparent (generally speaking, the idea of returning an existing link
> > > > > > > in case there is one already for the given consumer-supplier pair
> > > > > > > doesn't play well with stateful links and their flags), so there will
> > > > > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > > > > a reason to sit on these fixes while working on the other patches, so
> > > > > > > here they go.
> > > > > >
> > > > > > Any concerns regarding this lot?
> > > > > >
> > > > > > [Please note that patch 5 in the series was replaced with the v2 at
> > > > > > https://patchwork.kernel.org/patch/10781205/]
> > > > > >
> > > > > > If not, and if you don't mind, I would like to queue it up next week,
> > > > > > possibly along with the follow-up material posted on Monday
> > > > > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > > > > that is not problematic, so it gets some linux-next coverage before
> > > > > > the next merge window.
> > > > >
> > > > > Can I queue it up in my tree, given that I have a number of other driver
> > > > > core patches in there, and I don't know how the merge issues will be if
> > > > > we start to diverge.
> > > > >
> > > > > Or do you need this for some other work?
> > > >
> > > > To make this clearer, I have no objection to take this through my tree
> > > > now, along with your second set of patches.  Is that ok?
> > > 
> > > Yes, it is, AFAICS.  Thank you!
> > > 
> > > Do you need me to resend all of this as one series?
> > 
> > Yes, can you please do that.  Also, can you rebase it against my
> > driver-core-next branch as right now, patch 1/6 has conflicts due to
> > other patches that are in my tree :(
> 
> So commit 0fe6f7874d467 in your driver-core-next branch, which is the source
> of this conflict and I can't recall seeing that patch, if missing a Fixes: tag.

It was sent on the 1st, and seems to have come from this thread:
	https://lore.kernel.org/lkml/1546318276-18993-3-git-send-email-yong.wu@mediatek.com/

I'll gladly revert it if you do not think it is correct.

Hm, in looking at that closer, it does feel odd that the reference count
is being ignored, that doesn't seem right, and might be a driver bug...

Let me look at it again in the morning...

greg k-h
