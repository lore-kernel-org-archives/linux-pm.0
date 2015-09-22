From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Mon, 21 Sep 2015 21:22:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509212107460.4834-100000@netrider.rowland.org>
References: <2256962.SaUkYyVfIx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:46044 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757548AbbIVBWy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 21:22:54 -0400
In-Reply-To: <2256962.SaUkYyVfIx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 22 Sep 2015, Rafael J. Wysocki wrote:

> On Monday, September 21, 2015 10:34:54 AM Alan Stern wrote:
> > On Mon, 21 Sep 2015, Thierry Reding wrote:
> > 
> > > > > Force-removing drivers that depend on a device that's being unbound
> > > > > would be a possibility to solve the problem where consumers depend on a
> > > > > device that could physically go away. It might also be the right thing
> > > > > to do in any case. Presumably somebody unloading a module want to do
> > > > > just that, and refusing to do so isn't playing very nice. Of course
> > > > > allowing random modules to be removed even if a lot of consumers might
> > > > > depend on it may not be friendly either. Consider if you unload a GPIO
> > > > > driver that provides a pin that's used to enable power to an eMMC that
> > > > > might have the root filesystem.
> > > > >
> > > > > Then again, if you unload a module you better know what you're doing
> > > > > anyway, so maybe that's not something we need to be concerned about.
> > > > 
> > > > I think that it's better to fail module unloads in such cases by
> > > > default (to prevent simple silly mistakes from having possibly severe
> > > > consequences), but if a "force" option is used, we should regard that
> > > > as "the user really means it" and do as requested.  That would be very
> > > > much analogous to the hot-unplug situation from the software
> > > > perspective.
> > > 
> > > Sounds very reasonable to me.
> > 
> > I'm not so sure about this.  For one thing, how are you going to 
> > distinguish which module unloads are safe?
> 
> Ones that have no dependencies?

Does a parent-child relationship count as a dependency?  AFAIK, that's 
the only sort of dependency we have for mounted filesystems, in 
general.

> Very simple: If the driver being unloaded is explicitly depended on by
> something (ie. there is a "device link" to it), we fail the unload with
> -EBUSY unless the "force" option is used.

Hmmm.  In other words, you will iterate through all the drivers,
checking the ->owner field against the module being removed.  Then for
each matching driver, you will iterate through all the bound devices,
and all their descendants, looking for links of the appropriate type.  
And perhaps do the same thing for subsystems and classes.

Doable, I guess, even if it is inelegant.  Fortunately module unload
has no timing requirements.

> > For another, even if you do make this distinction, don't you think 
> > people will get into the habit of always using the "force" option?  My 
> > impression is that most module unloads end up causing some device to be 
> > unbound from a driver, or even completely deregistered.
> > 
> > Right now the kernel uses the "You better know what you're doing when
> > you unload a module" point of view, and I don't see any good reasons
> > for changing.
> 
> Well, is that point of view appropriate from the users' perspective?

I suspect people will find it more appropriate than the new point of
view you are proposing.  I don't know how often people unload modules,
but I suspect almost every time they do, it involves unregistering one
or more devices.  Goodness knows how many of those devices will be the
target of a dependency link, though.

Alan Stern

