From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Sun, 13 Nov 2016 11:59:42 +0100
Message-ID: <20161113105942.GE8388@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <20161110220407.GQ13978@wotan.suse.de>
 <20161110224054.GA10575@kroah.com>
 <3465624.0TqEj8I9ee@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933121AbcKMK7b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 05:59:31 -0500
Content-Disposition: inline
In-Reply-To: <3465624.0TqEj8I9ee@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, Christoph

On Fri, Nov 11, 2016 at 02:08:35AM +0200, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Thursday 10 Nov 2016 23:40:54 Greg Kroah-Hartman wrote:
> > On Thu, Nov 10, 2016 at 11:04:07PM +0100, Luis R. Rodriguez wrote:
> > > This is more forward looking, but -- if we had an annotation in
> > > Kconfig/turned to a mod info section, or to start off with just a driver
> > > MODULE_SUGGESTS() macro to start off with it might suffice for the driver
> > > core to request_module() annotated dependencies, such requests could be
> > > explicitly suggested as synchronous so init + probe do run together
> > > (as-is today), after which it could know that all possible drivers that
> > > needed to be loaded should now be loaded. If this sounds plausible to
> > > help, do we have drivers where we can test this on? For instance, since
> > > the functional dependency framework annotates functional dependencies for
> > > consumers/providers for suspend/resume and un time PM could such
> > > MODULE_SUGGESTS() annotations be considered on the consumers to suggest
> > > the provider drivers so their own probe yields to their providers to try
> > > first ?
> > 
> > No.
> > 
> > Stop.
> > 
> > First off, the "driver core" NEVER can "know" if "all possible drivers
> > that should be loaded, are loaded.  That way lies madness and
> > impossibility.
> > 
> > Secondly, yet-another-section isn't going to help anything here, we
> > alredy "suggest" to userspace a bunch of stuff, so we get the needed
> > modules loaded, at sometime in the future, if they are around, and
> > userspace feels like it.  That's the best we can ever do.
> > 
> > Don't try to make this more difficult than it is please. DEFER works
> > today really really well, and it's really really simple.
> > Inter-dependancy of modules and devices connected to each other are two
> > different things, be careful about this.
> 
> One issue we don't address today is handling of optional dependencies. A 
> simple example is an SPI controller that can use a DMA engine or work in PIO 
> mode. At probe time the driver will request a DMA channel if the platform 
> (ACPI, DT, platform data) specifies that DMA is available. This can fail for 
> various reasons, one of them being that the DMA engine driver hasn't probed 
> the DMA device yet. In that case the SPI controller driver will continue in 
> PIO mode, ignoring the DMA engine that will later be probed. We can't defer 
> probing of the SPI controller as the DMA engine driver might never get loaded, 
> which would result in the SPI controller probe being deferred forever.
> 
> One solution for this type of dependency issue would be to notify the SPI 
> controller driver after probe that the DMA channel is now available. I'd like 
> to avoid that though, as it would drastically increase the complexity of lots 
> of drivers and create lots of race conditions.
> 
> There are certain configurations that we could possibly consider as invalid. 
> For instance if the SPI controller driver is built-in and the DMA engine 
> driver built as a module, the user clearly shot themselves in the foot and the 
> kernel can't be blamed.
> 
> For resources that can't be built as a module (IOMMUs for instance) we thus 
> only have to consider the case where both drivers are built-in, as the 
> resource built-in and consumer as a module should work properly from an 
> ordering point of view (at least as long as we don't allow asynchronous 
> probing of built-in drivers to be delayed enough for modules to be loaded...). 
> In this case, if the resource driver isn't available when the consumer is 
> probed, if will never be available at the consumer can safely proceed in a 
> degraded mode. We would thus only need to solve the probe ordering issue.
> 
> I'm not sure how far these simple(r) solutions that consider certain cases as 
> invalid would scale though, and whether we won't need a more generic solution 
> at some point anyway.

I would love to see a generic solution that works for all of these
complex cases, as I agree with you, it's complex :)

But I have yet to see any such patches that implement this.  As always,
I am very glad to review anything that people create, but I don't have
the time to work on such a solution myself at the moment.

thanks,

greg k-h
