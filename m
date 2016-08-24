From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Ksummit-discuss] Self nomination
Date: Wed, 24 Aug 2016 19:32:24 +0200
Message-ID: <7252702.7DyMkgPBEW@vostro.rjw.lan>
References: <20160726223054.GA30993@dtor-ws> <2095093.rkXOZ187BN@vostro.rjw.lan> <243fdf0c-22c1-e56e-ab01-b2a44bc91da2@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49989 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754291AbcHXR07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2016 13:26:59 -0400
In-Reply-To: <243fdf0c-22c1-e56e-ab01-b2a44bc91da2@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, August 24, 2016 02:12:18 PM Marek Szyprowski wrote:
> Hi Rafael,
> 
> 
> On 2016-08-06 02:20, Rafael J. Wysocki wrote:
> > On Wednesday, August 03, 2016 10:12:00 AM Marek Szyprowski wrote:
> >> Dear All,
> >>
> >>
> >> On 2016-08-03 01:00, Rafael J. Wysocki wrote:
> >>> On Tuesday, August 02, 2016 10:09:17 AM Linus Walleij wrote:
> >>>> On Thu, Jul 28, 2016 at 12:14 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>>>> On 26/07/16 23:30, Dmitry Torokhov wrote:
> >>>>>> - I would like to sync up with people and discuss [lack of] progress
> >>>>>>     on topic of device probe ordering (including handling of deferred
> >>>>>>     probes, asynchronous probes, etc).
> >>>>> I'm extremely interested in discussing this.
> >>>> I've also tried to pitch in on it in the past but I just feel stupid
> >>>> whenever we try to come up with something better than what
> >>>> we have :(
> >>>>
> >>>>> It has wide reaching consequences as (with my irqchip maintainer hat on)
> >>>>> we've had to pretend that some bits of HW (timers, interrupt
> >>>>> controllers) are not "devices". Not a massive issue for most, except
> >>>>> when your interrupt controller has requirements that are very similar to
> >>>>> the DMA mapping API (which you cannot use because "not a device"). Other
> >>>>> problems are introduced by things like wire-MSI bridges, and most people
> >>>>> end-up resorting to hacks like ad-hoc initcalls and sprinkling deferred
> >>>>> probes in specific drivers.
> >>>> Same feeling here. I'm accepting patches for random initcall
> >>>> reordering because there is nothing else I can do, people need to
> >>>> have their systems running. But it feels really fragile.
> >>>>
> >>>> Deferred probe alleviated the problem, but I remember saying at
> >>>> the time that what we really need to do is build a dependency
> >>>> graph and resolve it the same way e.g. systemd does. (Someone
> >>>> may have called me BS on that, either for being wrong about everything
> >>>> as usual or because of mentioning systemd, I don't know which one.)
> >>>>
> >>>> The latest proposal I saw came from Rafael and he had a scratch
> >>>> idea for a dependency graph that I really liked, but I guess he's been
> >>>> sidetracked since. Rafael, what happened with that?
> >>> I got distracted, but Marek Szyprowski has revived it recently.
> >>>
> >>> It needs to be cleaned up somewhat, but other than that I think it's in
> >>> a good enough shape to make some progress in that direction, at least in
> >>> principle.
> >> I really like the idea of pm dependencies between device and the patches
> >> prepared by Rafael. They are exactly what we need for our case (PM for
> >> Exynos IOMMU), but they will also help solving PM issues with complex
> >> devices (like DRM for SoCs and ASoC audio).
> >>
> >> Rafael: do you plan to do any update on them?
> > Yes, I do, but to make some cosmetic changes rather.
> >
> >> Some time ago you wrote, that you had such plan, but real life proved
> >> something else.
> > Well, I was working on other things in the meantime, but I still had that
> > plan. :-)
> >
> >> If needed I can continue works on them, but I need some directions what has
> >> to be improved and fixed.
> > Thanks so much!
> >
> > First off, the networking people claimed the "devlink" term in the meantime
> > and it's better to avoid confusion here, so I'd change it to "devdep" or
> > similar in the patches.
> >
> > In addition to that Tomeu Vizoso complained that the supplier_links and
> > consumer_links list heads in struct device were confusing and I see why that
> > could be the case, so I'd change them to something more direct, like maybe
> > links_to_suppliers and links_to_consumers.
> >
> > Please let me know what you think.
> 
> I think that both name changes (devlink -> devdep and adding "_to_") 
> make sense
> and such change will make the code easier to understand.
> 
> I've also managed to find what is the source of the problem with reboot 
> hang that
> Tobias reported. It was my fault of incorrect use of device links. 
> Adding a link
> to not-yet-fully-registered device results in trashing devices_kset and 
> dpm lists.
> I will check if it is possible to a warning or proper support for such case
> (iommu support for given device is initialized before given device's 
> struct device
> is added to the system by device_add() function).
> 
> Do you want me to resend the patches with the above mentioned name 
> changes or do
> you want to do it on your own and then I will send my updated patches?

I'd like to post new versions myself and then let you rebase on top of
them if that's not a problem.

I'll get to that when I get back home from the current travels.

Thanks,
Rafael

