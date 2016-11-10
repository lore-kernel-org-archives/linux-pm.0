From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Thu, 10 Nov 2016 23:40:54 +0100
Message-ID: <20161110224054.GA10575@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com>
 <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
 <2305706.WydXUuMppH@avalon>
 <20161110220407.GQ13978@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110220407.GQ13978@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 11:04:07PM +0100, Luis R. Rodriguez wrote:
> This is more forward looking, but -- if we had an annotation in Kconfig/turned
> to a mod info section, or to start off with just a driver MODULE_SUGGESTS() macro
> to start off with it might suffice for the driver core to request_module()
> annotated dependencies, such requests could be explicitly suggested as
> synchronous so init + probe do run together (as-is today), after which it
> could know that all possible drivers that needed to be loaded should now be
> loaded. If this sounds plausible to help, do we have drivers where we can
> test this on? For instance, since the functional dependency framework
> annotates functional dependencies for consumers/providers for suspend/resume
> and un time PM could such MODULE_SUGGESTS() annotations be considered on the
> consumers to suggest the provider drivers so their own probe yields to their
> providers to try first ?

No.

Stop.

First off, the "driver core" NEVER can "know" if "all possible drivers
that should be loaded, are loaded.  That way lies madness and
impossibility.

Secondly, yet-another-section isn't going to help anything here, we
alredy "suggest" to userspace a bunch of stuff, so we get the needed
modules loaded, at sometime in the future, if they are around, and
userspace feels like it.  That's the best we can ever do.

Don't try to make this more difficult than it is please. DEFER works
today really really well, and it's really really simple.
Inter-dependancy of modules and devices connected to each other are two
different things, be careful about this.

thanks,

greg k-h
