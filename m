From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Fri, 11 Nov 2016 00:09:10 +0100
Message-ID: <20161110230910.GT13978@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161107213954.GI1764@wotan.suse.de>
 <1853104.8E50f2PFSV@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1853104.8E50f2PFSV@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Lars-Peter Clausen <lars@metafoo.de>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 09:05:30AM +0200, Laurent Pinchart wrote:
> Hi Luis,
> 
> On Monday 07 Nov 2016 22:39:54 Luis R. Rodriguez wrote:
> > On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Currently, there is a problem with taking functional dependencies
> > > between devices into account.
> > > 
> > > What I mean by a "functional dependency" is when the driver of device
> > > B needs device A to be functional and (generally) its driver to be
> > > present in order to work properly.  This has certain consequences
> > > for power management (suspend/resume and runtime PM ordering) and
> > > shutdown ordering of these devices.  In general, it also implies that
> > > the driver of A needs to be working for B to be probed successfully
> > > and it cannot be unbound from the device before the B's driver.
> > > 
> > > Support for representing those functional dependencies between
> > > devices is added here to allow the driver core to track them and act
> > > on them in certain cases where applicable.
> > > 
> > > The argument for doing that in the driver core is that there are
> > > quite a few distinct use cases involving device dependencies, they
> > > are relatively hard to get right in a driver (if one wants to
> > > address all of them properly) and it only gets worse if multiplied
> > > by the number of drivers potentially needing to do it.
> > 
> > How many drivers actually *need this* today for suspend / resume ?
> 
> I don't think there's a list, but just speaking for Renesas R-Car platforms 
> such a dependency exists from all DMA bus masters to the system IOMMUs (we're 
> talking about dozens of devices here), as well as from the display, video 
> codec and video processing IP cores to transparent memory access IP cores that 
> handle burst access and compression/decompression.

This is very significant, thanks.

> > How many of these are because of ACPI firmware bugs rather than
> > some other reason ?
> 
> None from the list above, even with s/ACPI/DT/.
> 
> > Can ACPI somehow be used instead by these devices to address quirks?
> 
> Certainly not on ARM embedded platforms :-)

So this framework adds a generic way.

> > > Morever, at least one case (asynchronous system suspend/resume) cannot be
> > > handled in a single driver at all, because it requires the driver of A to
> > > wait for B to suspend (during system suspend) and the driver of B to
> > > wait for A to resume (during system resume).
> > 
> > Why is this all of a sudden a new issue?
> 
> It's not a new issue, we've just never addressed it properly so far. Various 
> workarounds existed, with various level of success (usually more for runtime 
> PM than system suspend/resume).

This helps a lot. I think there has at this point been enough effort to
try to inform as many folks who might have these workaround or their own
solution to voice their concerns, I tried to review some of the existing
solutions myself but its hard to get a quick grasp of them -- provided no one
else yells out I welcome then this change as a proper evolution.

I suppose the only last remaining concerns I had were aggregating on top of
deferred probe and the lack of a test driver to test complex topologies
using this framework to test order is never broken. For the first concern
it would seem that folks using this framework would actually test and ensure
device links works for their drivers, even if deferred probe is used. For
the later concern, a separate test driver could be added later.

  Luis
