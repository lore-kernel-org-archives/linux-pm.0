From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Tue, 05 Feb 2019 12:52:17 +0100
Message-ID: <2224002.YA0vJHJrjz@aspire.rjw.lan>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com> <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com> <20190204110510.GA10412@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204110510.GA10412@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 4, 2019 12:05:10 PM CET Thierry Reding wrote:
> 
> --FCuugMFkClbJLl1L
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
> >=20
> >=20
> > On 04/02/2019 08:45, Thierry Reding wrote:
> >=20
> > ...
> >=20
> > > The idea was, as I was saying below, to reuse dev_pm_ops even if
> > > !CONFIG_PM. So pm_runtime_enable() could be something like this:
> > >=20
> > > 	pm_runtime_enable(dev)
> > > 	{
> > > 		if (!CONFIG_PM)
> > > 			if (dev->pm_ops->resume)
> > > 				dev->pm_ops->resume(dev);
> > >=20
> > > 		...
> > > 	}
> > >=20
> > > But that's admittedly somewhat of a stretch. This could of course be
> > > made somewhat nicer by adding an explicit variant, say:
> > >=20
> > > 	pm_runtime_enable_foo(dev)
> > > 	{
> > > 		if (!CONFIG_PM && dev->pm_ops->resume)
> > > 			return dev->pm_ops->resume(dev);
> > >=20
> > > 		return 0;
> > > 	}
> > >=20
> > > Maybe the fact that I couldn't come up with a good name is a good
> > > indication that this is a bad idea...
> >=20
> > How about some new APIs called ...
> >=20
> > pm_runtime_enable_get()
> > pm_runtime_enable_get_sync()
> > pm_runtime_put_disable() (implies a put_sync)
> >=20
> > ... and in these APIs we add ...
> >=20
> > pm_runtime_enable_get(dev)
> > {
> > 	if (!CONFIG_PM && dev->pm_ops->resume)
> > 		return dev->pm_ops->resume(dev);

No, we're not adding this to the core.

While in principle you could provide a set of pointers to the routines
you want to be called when CONFIG_PM is unset, IMO it is just cleaner
and more straightforward (and fewer lines of code for that matter) to add
a simple conditional to each ->probe() and ->remove().

[cut]

> > None, but seems overkill just for this case.
> 
> But that's precisely the point. It's not just about this case. We've
> already got some drivers where we do a similar dance just to be able to
> support the, let's admit it, exotic case where somebody turns off PM. I
> think supporting !PM might have made sense at a point where we had no
> support for power management at all. But I think we've come a long way
> since then, and while we may still have some ways to go in some areas,
> we do fairly decent runtime PM most of the time, to the point where I no
> longer see any benefits in !PM.

This IMO is an excellent point.

Trying to handle the !CONFIG_PM case only really makes sense if you know
what to do to turn the device on without relying on things like PM domains
etc which are not even available if CONFIG_PM is not set.

IOW, if any of the platforms your driver is expected to work with require
something like genpd to even make the device functional, I wouldn't bother.

Thanks,
Rafael
