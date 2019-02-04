From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Mon, 4 Feb 2019 12:05:10 +0100
Message-ID: <20190204110510.GA10412@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo>
 <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
 <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
>=20
>=20
> On 04/02/2019 08:45, Thierry Reding wrote:
>=20
> ...
>=20
> > The idea was, as I was saying below, to reuse dev_pm_ops even if
> > !CONFIG_PM. So pm_runtime_enable() could be something like this:
> >=20
> > 	pm_runtime_enable(dev)
> > 	{
> > 		if (!CONFIG_PM)
> > 			if (dev->pm_ops->resume)
> > 				dev->pm_ops->resume(dev);
> >=20
> > 		...
> > 	}
> >=20
> > But that's admittedly somewhat of a stretch. This could of course be
> > made somewhat nicer by adding an explicit variant, say:
> >=20
> > 	pm_runtime_enable_foo(dev)
> > 	{
> > 		if (!CONFIG_PM && dev->pm_ops->resume)
> > 			return dev->pm_ops->resume(dev);
> >=20
> > 		return 0;
> > 	}
> >=20
> > Maybe the fact that I couldn't come up with a good name is a good
> > indication that this is a bad idea...
>=20
> How about some new APIs called ...
>=20
> pm_runtime_enable_get()
> pm_runtime_enable_get_sync()
> pm_runtime_put_disable() (implies a put_sync)
>=20
> ... and in these APIs we add ...
>=20
> pm_runtime_enable_get(dev)
> {
> 	if (!CONFIG_PM && dev->pm_ops->resume)
> 		return dev->pm_ops->resume(dev);
>=20
> 	pm_runtime_enable(dev);
> 	return pm_runtime_get(dev);
> }

Yeah, those sound sensible. I'm still a bit torn between this and just
enforcing PM. At least on the display side I think we already require PM
and with all the power domain work that you did we'd be much better off
if we could just get rid of the !PM workarounds.

> >>> This would be somewhat tricky because drivers
> >>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
> >>> that would result in an empty structure if !CONFIG_PM, but we could
> >>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
> >>> never be compiled out for this kind of case. Or such drivers could ev=
en
> >>> manually set .runtime_suspend and .runtime_resume to make sure they're
> >>> always populated.
> >>>
> >>> Another way out of this would be to make sure we never run into the c=
ase
> >>> where runtime PM is disabled. If we always "select PM" on Tegra, then=
 PM
> >>> should always be available. But is it guaranteed that runtime PM for =
the
> >>> devices is functional in that case? From a cursory look at the code it
> >>> would seem that way.
> >>
> >> If you select PM, then all of the requisite code should be there.
> >=20
> > We do this on 64-bit ARM, but there had been some pushback when we had
> > proposed to do the same thing on 32-bit ARM. I think there were two
> > concerns:
> >=20
> > 	1) select PM would force the setting for all platforms on multi-
> > 	   platforms builds
> >=20
> > 	2) prevents anyone from disabling PM for debugging purposes
> >=20
> > 1) no longer seems to be valid because Rockchip already selects PM
> > unconditionally. I'm not sure if 2) is valid anymore either. I haven't
> > run a build with !PM in a very long time and I wouldn't be surprised if
> > that was completely broken.
> >=20
> > Maybe we need to try this again since a couple of years have elapsed and
> > runtime PM support on Tegra is much more mature at this point.
> >=20
> >> Alternatively, you can make the driver depend on PM.
> >=20
> > That's probably the easiest way out, but to be honest I think I'd prefer
> > to just enforce PM and keep things simple.
> >=20
> > Jon, any objections?
>=20
> None, but seems overkill just for this case.

But that's precisely the point. It's not just about this case. We've
already got some drivers where we do a similar dance just to be able to
support the, let's admit it, exotic case where somebody turns off PM. I
think supporting !PM might have made sense at a point where we had no
support for power management at all. But I think we've come a long way
since then, and while we may still have some ways to go in some areas,
we do fairly decent runtime PM most of the time, to the point where I no
longer see any benefits in !PM.

Thierry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYHGMACgkQ3SOs138+
s6Gx3w//XJu+ERF3qvtbn607pHgfD4SfNiWNCog4IPuO8zYEdQQ0YdGjDusNOUBV
m3tMjat2semb69xdMr4/H7DiINvFVLw/s/WBvkKVw8/XH3C3jP23zD0lkgODn/f1
HKLdxeAWrQ8BgJmoyoOl1pQ8jfKsM161C+dRI/4eDgvwxvyLYWAOt/oVgKQbeHwl
ySRh2tfcit7yb2YwJFsUgyXAtipZNXmSeNfKg/ozSUaMlYfxUAAwiPZRa053LLsm
L41MRflToeqrRfA5mNKRR7xz6pASP60V+MGPh8BSZIYvlwBLnk2qxP29ovG6br20
Yz3YjoKU0QyqgqdxLWbdrVYLGhr0vGH4MnHnW82wjd4HbRdyesUVgszGyRPWVmj5
/NstNMPwjMhtzQZu38x0xY7KttUeADGePgcs/qiysXxLeYX9vjLAiSzMF9PjgDMf
zltaMxogr7nVN0PDZ8J5nTVhP92zqCFskA5VsnVp1/Fq+6Tq9GVINB5FKjfDQiaK
wO/LtvjSIhHBJGePNFyakwh7NCdsaj49P0PGP81T+N5XC2V8+i0ObY15Ur1HsRvH
EYdlr+dcCeu2x9PXvkrXgVpSZ5kpewUc/3mlMo/ndNlZzX3zrXYCXP4B7E1jDuwX
kEnZ/O+1yTAKYSCdT3yBveUBiOmxml+2+/h0UIRHkKyvk5i2KeQ=
=oPAV
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
