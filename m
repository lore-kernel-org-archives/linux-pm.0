From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Tue, 8 Nov 2016 21:58:24 +0100
Message-ID: <20161108205824.GA13978@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
 <20161108064541.GA13024@kroah.com>
 <20161108192103.GN1764@wotan.suse.de>
 <20161108194335.GA22680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbcKHU62 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Nov 2016 15:58:28 -0500
Content-Disposition: inline
In-Reply-To: <20161108194335.GA22680@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Nov 08, 2016 at 08:43:35PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 08, 2016 at 08:21:04PM +0100, Luis R. Rodriguez wrote:
> > On Tue, Nov 08, 2016 at 07:45:41AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 07, 2016 at 10:22:50PM +0100, Luis R. Rodriguez wrote:
> > > > We have no explicit semantics to check if a driver / subsystem
> > > > supports deferred probe.
> > > 
> > > Why would we need such a thing?
> > 
> > It depends on the impact of a driver/subsystem not properly supporting
> > deffered probe, if this is no-op then such a need is not critical but
> > would be good to proactively inform developers / users so they avoid 
> > its use, if this will cause issues its perhaps best to make this a
> > no-op through a check. AFAICT reviewing implications of not supporting
> > deferred probe on drivers/subsytsems for this framework is not clearly
> > spelled out, if we start considering re-using this framework for probe
> > ordering I'd hate to see issues come up without this corner case being
> > concretely considered.
> 
> It should not matter to the driver core if a subsystem, or a driver,
> supports or does not support deferred probe.

That was my impression as well -- however Rafael noted this as an area
worth highlighting. So perhaps he can elaborate.

But at least as per my notes I do have here Geert Uytterhoeven reminding
us that:

  "Some drivers / subsystems don’t support deferred probe yet, such failures
   usually don’t blow up, but cause subtle malfunctioning. Example, an Ethernet
   phy could not get its interrupt as the primary IRQ chip had not been probed
   yet, it reverted to polling though. Sub-optimal." [0]

[0] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003425.html

This sounds more like the existing deffered probe solution has detrimental
unexpected effects on some drivers / subsystems -- its not clear *why*, but
its worth reviewing if there are other drivers and seeing if we need this
annotation.

> It's a quick and simple solution to a complex problem that works well.

We all agree. The recent discussions over probe ordering are simply
optimization considerations -- should the time incurred to use deferred
probe be X and the time incurred when using an alternative is Y and we
determine the time Y is < X we have a winning alternative. Part of my
own big issue with deferred probe is a) its extremely non-deterministic,
b) it seems some folks have thought about similar problems and we might
really be able to do better. I'm not convinced that the functional
dependencies patches are the panacea for probe ordering, and while it
was not intended for that, some folks are assuming it could be. To really
vet this prospect we must really consider what other subsystem have done
and review other alternatives efforts.

> Yes, you can iterate a
> lot of times, but that's fine, we have time at boot to do that (and
> really, it is fast.)

Deferred probe is left for late_initcall() [1] -- this *assumes* that the
driver/subsystem can be loaded so late, and as per Andrzej this solution
isunacceptable/undesirable. So it would be unfair and incorrect to categorize
all drivers in the same boat, in fact given this lone fact it may be
worth revisiting the idea I mentioned about a capability aspect to support
a late deferred probe later. We tend to assume its fine, however it does
not seem to be the case.

[1] drivers/base/dd.c:late_initcall(deferred_probe_initcall);

> > Furthermore -- how does this framework compare to Andrzej's resource tracking
> > solution? I confess I have not had a chance yet to review yet but in light of
> > this question it would be good to know if Andrzej's framework also requires
> > deferred probe as similar concerns would exist there as well.
> 
> I have no idea what "framework" you are talking about here, do you have
> a pointer to patches?

I'm surprised given Andrzej did both Cc you on his patches [2] *and* chimed
in on Rafael's patches to indicate that we likely can integrate PM concerns
into his own "framework" [3]. There was no resolution to this discussion, however
its not IMHO sufficient to brush off Andrzej's points in particular because
Andrzej *is* indicating that his framework:

- Eliminates deferred probe and resulting late_initcall(), consumer registers
callbacks informing when given resources (clock, regulator, etc) becomes
available
- Properly handle resource disappearance (driver unbind, hotplug)
- Track resources which are not vital to the device, but can influence behavior
- Offers simplified resource allocation
- Can be easily expanded to help with power management

Granted I have not reviewed this yet but it at least was on my radar, and
I do believe its worth reviewing this further given the generally expressed
interest to see if we can have a common framework to address both ordering
problems, suspend and probe. At a quick glance the "ghost provider" idea
seems like a rather crazy idea but hey, there may be some goods in there.

It was sad both Andrzej and yourself could not attend the complex dependencies
tracks -- I think it would have been useful. I don't expect us to address a
resolution to probe ordering immediately -- but I am in the hopes we at least
can keep an open mind about the similarity of the problems and see if we can
aim for a clean elegant solution that might help both.

[2] https://lwn.net/Articles/625454/
[3] http://thread.gmane.org/gmane.linux.kernel/2087152

  Luis
