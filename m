From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 22 Sep 2015 02:26:32 +0200
Message-ID: <2256962.SaUkYyVfIx@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509211031210.1713-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56427 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757062AbbIUX6Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 19:58:25 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509211031210.1713-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, September 21, 2015 10:34:54 AM Alan Stern wrote:
> On Mon, 21 Sep 2015, Thierry Reding wrote:
> 
> > > > Force-removing drivers that depend on a device that's being unbound
> > > > would be a possibility to solve the problem where consumers depend on a
> > > > device that could physically go away. It might also be the right thing
> > > > to do in any case. Presumably somebody unloading a module want to do
> > > > just that, and refusing to do so isn't playing very nice. Of course
> > > > allowing random modules to be removed even if a lot of consumers might
> > > > depend on it may not be friendly either. Consider if you unload a GPIO
> > > > driver that provides a pin that's used to enable power to an eMMC that
> > > > might have the root filesystem.
> > > >
> > > > Then again, if you unload a module you better know what you're doing
> > > > anyway, so maybe that's not something we need to be concerned about.
> > > 
> > > I think that it's better to fail module unloads in such cases by
> > > default (to prevent simple silly mistakes from having possibly severe
> > > consequences), but if a "force" option is used, we should regard that
> > > as "the user really means it" and do as requested.  That would be very
> > > much analogous to the hot-unplug situation from the software
> > > perspective.
> > 
> > Sounds very reasonable to me.
> 
> I'm not so sure about this.  For one thing, how are you going to 
> distinguish which module unloads are safe?

Ones that have no dependencies?

Very simple: If the driver being unloaded is explicitly depended on by
something (ie. there is a "device link" to it), we fail the unload with
-EBUSY unless the "force" option is used.

> For another, even if you do make this distinction, don't you think 
> people will get into the habit of always using the "force" option?  My 
> impression is that most module unloads end up causing some device to be 
> unbound from a driver, or even completely deregistered.
> 
> Right now the kernel uses the "You better know what you're doing when
> you unload a module" point of view, and I don't see any good reasons
> for changing.

Well, is that point of view appropriate from the users' perspective?

Thanks,
Rafael

