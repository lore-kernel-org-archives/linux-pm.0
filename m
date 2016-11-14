From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Mon, 14 Nov 2016 15:50:53 +0100
Message-ID: <20161114145053.GY13978@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <20161110220407.GQ13978@wotan.suse.de>
 <20161110224054.GA10575@kroah.com>
 <3465624.0TqEj8I9ee@avalon>
 <20161113105942.GE8388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58871 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbcKNOu7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 09:50:59 -0500
Content-Disposition: inline
In-Reply-To: <20161113105942.GE8388@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sun, Nov 13, 2016 at 11:59:42AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 11, 2016 at 02:08:35AM +0200, Laurent Pinchart wrote:
> > Hi Greg,
> > 
> > On Thursday 10 Nov 2016 23:40:54 Greg Kroah-Hartman wrote:
> > > On Thu, Nov 10, 2016 at 11:04:07PM +0100, Luis R. Rodriguez wrote:
> > > > This is more forward looking, but -- if we had an annotation in
> > > > Kconfig/turned to a mod info section, or to start off with just a driver
> > > > MODULE_SUGGESTS() macro to start off with it might suffice for the driver
> > > > core to request_module() annotated dependencies, such requests could be
> > > > explicitly suggested as synchronous so init + probe do run together
> > > > (as-is today), after which it could know that all possible drivers that
> > > > needed to be loaded should now be loaded. If this sounds plausible to
> > > > help, do we have drivers where we can test this on? For instance, since
> > > > the functional dependency framework annotates functional dependencies for
> > > > consumers/providers for suspend/resume and un time PM could such
> > > > MODULE_SUGGESTS() annotations be considered on the consumers to suggest
> > > > the provider drivers so their own probe yields to their providers to try
> > > > first ?
> > > 
> > > No.
> > > 
> > > Stop.
> > > 
> > > First off, the "driver core" NEVER can "know" if "all possible drivers
> > > that should be loaded, are loaded.  That way lies madness and
> > > impossibility.

At first I had discarded the generic driver problem as a slightly unrelated
topic however its clear now its not. In terms of functional dependencies I
agree that not providing strict order is *sometimes* desirable to help with
simplicity. The generic driver problem can be described graph-wise: on a DAG,
we're considering a topology with where nodes have optional superior
alternatives, and what you seem to be advocating is a transition to an
alternative is better and much simpler than forcing order from the start. That
can only work so long as some intermediary dependencies are (for lack of a
better term) soft-nodes -- where transitions to better alternatives are
possible and can such transitions can be handled in software. You may have
(again for lack of a better term) hard-nodes though where an entry in the DAG
is required as a hard requirement immediately prior to letting another entry
proceed. An example here is the x86 IOMMU drivers and dependent GPU DRM
drivers, currently only link order asserts proper order given we have run out
of semantics in between to ensure proper order is correct.

> > > Secondly, yet-another-section isn't going to help anything here, we
> > > alredy "suggest" to userspace a bunch of stuff, so we get the needed
> > > modules loaded, at sometime in the future, if they are around, and
> > > userspace feels like it.  That's the best we can ever do.

For some cases this is sufficient, for hard-nodes (term used above) though
if you get the incorrect order you may in the worst case oops.

> > > Don't try to make this more difficult than it is please. DEFER works
> > > today really really well, and it's really really simple.

It seems many disagree. What is clear is its simplicity outweighs the
complexity by alternatives which have been historically considered. This is
reasonable. Part of the reason probe ordering, as an optimization
consideration, came up while function dependencies for runtime PM and suspend
are being discussed is as we've determined this is a related problem and
at least for hard-nodes this is critical to resolve. For now we have enough
tools to work around problems for hard-nodes, but it would be silly for us
not to start thinking about ways to improve upon this for the future.

> > > Inter-dependancy of modules and devices connected to each other are two
> > > different things, be careful about this.

This is a *very* fair warning :)

> > One issue we don't address today is handling of optional dependencies. A 
> > simple example is an SPI controller that can use a DMA engine or work in PIO 
> > mode. At probe time the driver will request a DMA channel if the platform 
> > (ACPI, DT, platform data) specifies that DMA is available. This can fail for 
> > various reasons, one of them being that the DMA engine driver hasn't probed 
> > the DMA device yet. In that case the SPI controller driver will continue in 
> > PIO mode, ignoring the DMA engine that will later be probed. We can't defer 
> > probing of the SPI controller as the DMA engine driver might never get loaded, 
> > which would result in the SPI controller probe being deferred forever.
> > 
> > One solution for this type of dependency issue would be to notify the SPI 
> > controller driver after probe that the DMA channel is now available. I'd like 
> > to avoid that though, as it would drastically increase the complexity of lots 
> > of drivers and create lots of race conditions.
> > 
> > There are certain configurations that we could possibly consider as invalid. 
> > For instance if the SPI controller driver is built-in and the DMA engine 
> > driver built as a module, the user clearly shot themselves in the foot and the 
> > kernel can't be blamed.
> > 
> > For resources that can't be built as a module (IOMMUs for instance) we thus 
> > only have to consider the case where both drivers are built-in, as the 
> > resource built-in and consumer as a module should work properly from an 
> > ordering point of view (at least as long as we don't allow asynchronous 
> > probing of built-in drivers to be delayed enough for modules to be loaded...). 
> > In this case, if the resource driver isn't available when the consumer is 
> > probed, if will never be available at the consumer can safely proceed in a 
> > degraded mode. We would thus only need to solve the probe ordering issue.
> > 
> > I'm not sure how far these simple(r) solutions that consider certain cases as 
> > invalid would scale though, and whether we won't need a more generic solution 
> > at some point anyway.
> 
> I would love to see a generic solution that works for all of these
> complex cases, as I agree with you, it's complex :)
> 
> But I have yet to see any such patches that implement this.

The generic driver topic is related but it certainly only part of the
picture. It seems there were enough folks interested in that topic though
so perhaps patches will be eventually produced for it.

> As always,
> I am very glad to review anything that people create, but I don't have
> the time to work on such a solution myself at the moment.

Part of what we tried to discuss during the complex dependencies topics at
Plumbers was evaluating if some of the existing solutions for run time PM and
suspend could help with probe ordering, it seems we had agreement on it, what
we found though was that for many cases the use of struct device for link
association is too late. Alternatives mechanisms will be considered in the
future, and it seems that one path forward will be to consider expanding upon
this simple functional device dependency framework.

So let's see more patches!

  Luis
