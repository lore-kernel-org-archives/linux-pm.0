From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 03:18:17 +0200
Message-ID: <2849486.q7QWJNfWm1@vostro.rjw.lan>
References: <1441880343-30852-1-git-send-email-thierry.reding@gmail.com> <4817586.89LbLFPz9W@vostro.rjw.lan> <20150915155301.GB25966@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55907 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751480AbbIPAuS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 20:50:18 -0400
In-Reply-To: <20150915155301.GB25966@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, September 15, 2015 05:53:02 PM Thierry Reding wrote:
> On Sat, Sep 12, 2015 at 12:38:19AM +0200, Rafael J. Wysocki wrote:
> > On Friday, September 11, 2015 02:03:46 PM Thierry Reding wrote:
> > > On Fri, Sep 11, 2015 at 12:08:02AM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, September 10, 2015 12:19:03 PM Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >=3D20
> > > > > Deferred probe can lead to strange situations where a device that i=
> s a
> > > > > dependency for others will be moved to the end of the dpm_list. At =
> the
> > > > > same time the dependers may not be moved because at the time they w=
> ill
> > > > > be probed the dependee may already have been successfully reprobed =
> and
> > > > > they will not have to defer the probe themselves.
> > > >=3D20
> > > > So there's a bug in the implementation of deferred probing IMO.
> > >=20
> > > Well, yeah. The root problem here is that we don't have dependency
> > > information and deferred probing is supposed to fix that. It does so
> > > fairly well, but it breaks in this particular case.
> > >=20
> > > > > One example where this happens is the Jetson TK1 board (Tegra124). =
> The
> > > > > gpio-keys driver exposes the power key of the board as an input dev=
> ice
> > > > > that can also be used as a wakeup source. Commit 17cdddf0fb68 ("ARM:
> > > > > tegra: Add gpio-ranges property") results in the gpio-tegra driver
> > > > > deferring probe because one of its dependencies, the pinctrl-tegra
> > > > > driver, has not successfully completed probing. Currently the defer=
> red
> > > > > probe code will move the corresponding gpio-tegra device to the end=
>  of
> > > > > the dpm_list, but by the time the gpio-keys device, depending on the
> > > > > gpio-tegra device, is probed, gpio-tegra has already been reprobed,=
>  so
> > > > > the gpio-keys device is not moved to the end of dpm_list itself.
> >=20
> > At this point, when checking its dependencies, gpio-keys should also check
> > if their ordering with respect to it in dpm_list is correct and move itse=
> lf
> > to the end of it otherwise.
> >=20
> > There might be a helper for that I suppose.
> 
> But that's essentially the same thing as what this patch proposes,
> except that every driver now needs to call this helper, rather than
> having the core take care of it.

Well, not quite.  Not "every driver", but "every driver with dependencies
the driver core doesn't know about".  That's quite a difference in my view.
 
[...]

> > I'm always cautious about changes that make the core do something for eve=
> ry
> > device/driver, because they are very likely to step on corner cases that =
> we
> > don't need to worry about otherwise.
> 
> To me this seems more like a fundamental issue that should be fixed at
> the root rather than be fixed up case by case as we find them. Keeping
> the suspend/resume order the same as probe order sounds like the most
> logical thing to do. I grant you that there could be cases where this
> might break, but then I'd consider those cases to be broken rather than
> the other way around.

We have to disagree, then.

> With the current situation potentially every user of GPIOs (and the same
> is true for other types of resources) is broken, though we may not
> notice (immediately). In fact it was mostly by coincidence that I
> noticed in this case. The GPIO key works perfectly fine for regular use,
> it just doesn't work as a wakeup source anymore. That's not something
> that people test very frequently, hence could've gone unnoticed for much
> longer.
> 
> Of course reordering the dpm_list to follow the probe order has the
> potential to break other setups in similarily subtle ways, so I do
> understand your reluctance.
> 
> Perhaps it would help if we put this patch into some boot farm to get
> more coverage, maybe that would give us a better picture for how
> invasive the change is, or how bad the fallout could be?

I'd actually prefer to have a patch that I don't have to worry about
even in theory.

What about an opt-in mechanism for things that are likely to need this
stuff instead of imposing it on everybody unconditionally?

> I can of course go and come up with a more ad-hoc solution that fixes
> the issue for this particular use-case, but I'd like to avoid a
> situation where we end up having to patch up drivers one by one, when
> we could have a solution that works in the general case.
> 
> Also note that a recent commit (52cdbdd49853 "driver core: correct
> device's shutdown order") patch already made an equivalent change to the
> shutdown order. I'd expect that most devices would fail with that patch
> already if ordering is a real problem. Of course shutdown is a one-way
> ticket, so failure might not be as relevant as for suspend/resume.

Did you forget about the other Alan's concerns regarding probing devices
during suspend/resume?

> Grygorii, Greg: have you heard of any fallout caused by the above patch
> yet?

Did that patch manipulate dpm_list?

Thanks,
Rafael

