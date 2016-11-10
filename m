From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Thu, 10 Nov 2016 23:04:07 +0100
Message-ID: <20161110220407.GQ13978@wotan.suse.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com>
 <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
 <2305706.WydXUuMppH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48693 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934051AbcKJWEN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Nov 2016 17:04:13 -0500
Content-Disposition: inline
In-Reply-To: <2305706.WydXUuMppH@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Nov 10, 2016 at 09:14:32AM +0200, Laurent Pinchart wrote:
> Hi Luis,
> 
> On Wednesday 09 Nov 2016 16:59:30 Luis R. Rodriguez wrote:
> > On Wed, Nov 9, 2016 at 4:43 PM, Rafael J. Wysocki wrote:
> > > On Mon, Nov 7, 2016 at 10:22 PM, Luis R. Rodriguez wrote:
> > >> On Thu, Oct 27, 2016 at 05:25:51PM +0200, Greg Kroah-Hartman wrote:
> > >>> On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
> > >>>> Hi Rafael,
> > >>>> 
> > >>>> sorry for not responding to v5 of your series earlier, just sending
> > >>>> this out now in the hope that it reaches you before your travels.
> > >>>> 
> > >>>> On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> > >>>>> - Modify device_links_check_suppliers(),
> > >>>>> device_links_driver_bound(),
> > >>>>> 
> > >>>>>   device_links_no_driver(), device_links_driver_cleanup(),
> > >>>>>   device_links_busy(), and device_links_unbind_consumers() to walk
> > >>>>>   link lists under device_links_lock (to make the new "driver
> > >>>>>   presence tracking" mechanism work reliably).
> > >>>>
> > >>>> This change might increase boot time if drivers return -EPROBE_DEFER.
> > >>> 
> > >>> "might"?  Please verify this before guessing....
> > >>> 
> > >>> And don't make this more complex than needed before actually determining
> > >>> a real issue.
> > >> 
> > >> As clarified by Rafael at Plumbers, this functional dependencies
> > >> framework assumes your driver / subsystem supports deferred probe,
> > > 
> > > It isn't particularly clear what you mean by "support" here.
> > 
> > I noted some folks had reported issues, and you acknowledged that if
> > deferred probe was used in some drivers and if this created an issue
> > the same issue would be seen with this framework. AFAICT there are two
> > possible issues to consider:
> > 
> > 1) the one Geert Uytterhoeven noted. Again I'll note what he had mentioned
> > [0].
> > 
> >   "Some drivers / subsystems don’t support deferred probe yet, such failures
> > usually don’t blow up, but cause subtle malfunctioning. Example, an
> > Ethernet phy could not get its interrupt as the primary IRQ chip had not
> > been probed yet, it reverted to polling though. Sub-optimal." [0]
> > 
> > [0]
> > https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003
> > 425.html
> > 
> > Geert can you provide more details?
> 
> This is a more global issue. In many cases drivers depend on optional 
> resources. They are able to operate in a degraded mode (reduced feature set, 
> reduced performances, ...) when those resources are not present. They can 
> easily determine at probe time whether those resources are present, but have 
> no way to know, in case they're absent, whether they will be present at some 
> point in the near future (due to another driver probing the device providing 
> the resource for instance) or if they will never be present (for instance 
> because the required driver is missing).

I see thanks, so -EPROBE_DEFER assumes a late_initcall() would suffice to load
all necessary requirements.

> In the first case it would make sense  to defer probe,

So if the assumption is correct then it -EPROBE_DEFER should work.

> in the latter case deferring probe forever for missing 
> optional resources would prevent the device from being probed successfully at 
> all.

Right I see. And the driver core has no way to know what things *may* be
needed.

> The functional dependencies tracking patch series isn't meant to address this 
> issue.

Right, however it does track functional dependencies for suspend/run time PM
and we were certainly in hope this could help with probe ordering *later* in
the future. This is a separate topic. But more on point, the issue here is that
this framework relies on -EPROBE_DEFER -- so the issues discussed with it still
exist and should be properly documented.

> I can imagine a framework that would notify drivers of optional 
> resource availability after probe time, but it would come at a high cost for 
> drivers as switching between modes of operation at runtime based on the 
> availability of such resources would be way more complex than a mechanism 
> based on probe deferral.

Right, I see.

This is more forward looking, but -- if we had an annotation in Kconfig/turned
to a mod info section, or to start off with just a driver MODULE_SUGGESTS() macro
to start off with it might suffice for the driver core to request_module()
annotated dependencies, such requests could be explicitly suggested as
synchronous so init + probe do run together (as-is today), after which it
could know that all possible drivers that needed to be loaded should now be
loaded. If this sounds plausible to help, do we have drivers where we can
test this on? For instance, since the functional dependency framework
annotates functional dependencies for consumers/providers for suspend/resume
and un time PM could such MODULE_SUGGESTS() annotations be considered on the
consumers to suggest the provider drivers so their own probe yields to their
providers to try first ?

  Luis

> > 2) Since deferred probe relies on late_initcall() if your driver must
> > load earlier than this deferred probe can create an issue. Andrzej had
> > you identified a driver that ran into this and had issues ? If not
> > this seems like a semantics thing we should consider in extending the
> > documentation for drivers so that driver writers are aware of this
> > limitation. I would suppose candidates for this would be anything not
> > using module_init() or late_initcall() on their inits and have a
> > probe.
> > 
> > >> if it does not support its not clear what will happen....
> > > 
> > > I don't see any problems here, but if you see any, please just say
> > > what they are.
> > > 
> > >> We have no explicit semantics to check if a driver / subsystem
> > >> supports deferred probe.
> > > 
> > > That's correct, but then do we need it?
> > 
> > We can determine this by reviewing the two items above.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
