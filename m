From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during
	probe
Date: Mon, 4 Feb 2019 17:17:36 +0100
Message-ID: <20190204161736.GA25476@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
 <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
 <20190204110510.GA10412@ulmo>
 <f0bdcc21-efca-4d04-c7ec-953ec3d87031@gmail.com>
 <20190204140024.GJ10412@ulmo>
 <ef8cef12-12d5-4729-b603-9f0c6c0c0865@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0191161021315245876=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ef8cef12-12d5-4729-b603-9f0c6c0c0865@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, sharadg@nvidia.com, rlokhande@nvidia.com, mkumard@nvidia.com
List-Id: linux-pm@vger.kernel.org


--===============0191161021315245876==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 05:28:23PM +0300, Dmitry Osipenko wrote:
> 04.02.2019 17:00, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, Feb 04, 2019 at 03:03:49PM +0300, Dmitry Osipenko wrote:
> >> 04.02.2019 14:05, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Mon, Feb 04, 2019 at 09:53:32AM +0000, Jon Hunter wrote:
> >>>>
> >>>>
> >>>> On 04/02/2019 08:45, Thierry Reding wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>> The idea was, as I was saying below, to reuse dev_pm_ops even if
> >>>>> !CONFIG_PM. So pm_runtime_enable() could be something like this:
> >>>>>
> >>>>> 	pm_runtime_enable(dev)
> >>>>> 	{
> >>>>> 		if (!CONFIG_PM)
> >>>>> 			if (dev->pm_ops->resume)
> >>>>> 				dev->pm_ops->resume(dev);
> >>>>>
> >>>>> 		...
> >>>>> 	}
> >>>>>
> >>>>> But that's admittedly somewhat of a stretch. This could of course be
> >>>>> made somewhat nicer by adding an explicit variant, say:
> >>>>>
> >>>>> 	pm_runtime_enable_foo(dev)
> >>>>> 	{
> >>>>> 		if (!CONFIG_PM && dev->pm_ops->resume)
> >>>>> 			return dev->pm_ops->resume(dev);
> >>>>>
> >>>>> 		return 0;
> >>>>> 	}
> >>>>>
> >>>>> Maybe the fact that I couldn't come up with a good name is a good
> >>>>> indication that this is a bad idea...
> >>>>
> >>>> How about some new APIs called ...
> >>>>
> >>>> pm_runtime_enable_get()
> >>>> pm_runtime_enable_get_sync()
> >>>> pm_runtime_put_disable() (implies a put_sync)
> >>>>
> >>>> ... and in these APIs we add ...
> >>>>
> >>>> pm_runtime_enable_get(dev)
> >>>> {
> >>>> 	if (!CONFIG_PM && dev->pm_ops->resume)
> >>>> 		return dev->pm_ops->resume(dev);
> >>>>
> >>>> 	pm_runtime_enable(dev);
> >>>> 	return pm_runtime_get(dev);
> >>>> }
> >>>
> >>> Yeah, those sound sensible. I'm still a bit torn between this and just
> >>> enforcing PM. At least on the display side I think we already require=
 PM
> >>> and with all the power domain work that you did we'd be much better o=
ff
> >>> if we could just get rid of the !PM workarounds.
> >>>
> >>>>>>> This would be somewhat tricky because drivers
> >>>>>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops =
and
> >>>>>>> that would result in an empty structure if !CONFIG_PM, but we cou=
ld
> >>>>>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that w=
ould
> >>>>>>> never be compiled out for this kind of case. Or such drivers coul=
d even
> >>>>>>> manually set .runtime_suspend and .runtime_resume to make sure th=
ey're
> >>>>>>> always populated.
> >>>>>>>
> >>>>>>> Another way out of this would be to make sure we never run into t=
he case
> >>>>>>> where runtime PM is disabled. If we always "select PM" on Tegra, =
then PM
> >>>>>>> should always be available. But is it guaranteed that runtime PM =
for the
> >>>>>>> devices is functional in that case? From a cursory look at the co=
de it
> >>>>>>> would seem that way.
> >>>>>>
> >>>>>> If you select PM, then all of the requisite code should be there.
> >>>>>
> >>>>> We do this on 64-bit ARM, but there had been some pushback when we =
had
> >>>>> proposed to do the same thing on 32-bit ARM. I think there were two
> >>>>> concerns:
> >>>>>
> >>>>> 	1) select PM would force the setting for all platforms on multi-
> >>>>> 	   platforms builds
> >>>>>
> >>>>> 	2) prevents anyone from disabling PM for debugging purposes
> >>>>>
> >>>>> 1) no longer seems to be valid because Rockchip already selects PM
> >>>>> unconditionally. I'm not sure if 2) is valid anymore either. I have=
n't
> >>>>> run a build with !PM in a very long time and I wouldn't be surprise=
d if
> >>>>> that was completely broken.
> >>>>>
> >>>>> Maybe we need to try this again since a couple of years have elapse=
d and
> >>>>> runtime PM support on Tegra is much more mature at this point.
> >>>>>
> >>>>>> Alternatively, you can make the driver depend on PM.
> >>>>>
> >>>>> That's probably the easiest way out, but to be honest I think I'd p=
refer
> >>>>> to just enforce PM and keep things simple.
> >>>>>
> >>>>> Jon, any objections?
> >>>>
> >>>> None, but seems overkill just for this case.
> >>>
> >>> But that's precisely the point. It's not just about this case. We've
> >>> already got some drivers where we do a similar dance just to be able =
to
> >>> support the, let's admit it, exotic case where somebody turns off PM.=
 I
> >>> think supporting !PM might have made sense at a point where we had no
> >>> support for power management at all. But I think we've come a long way
> >>> since then, and while we may still have some ways to go in some areas,
> >>> we do fairly decent runtime PM most of the time, to the point where I=
 no
> >>> longer see any benefits in !PM.
> >>
> >> I'm requesting PM_DEBUG_ALWAYS_ON option then! Disabling PM is a
> >> useful debug feature, it can't just go away.=20
> >=20
> > What is it about disabling PM that you consider useful? I can understand
> > why you'd want that option if power management is broken, but as far as
> > I can tell, power management on Tegra is in pretty good state, and it's
> > more likely that !PM would actually be broken (though I haven't built a
> > configuration like that in a couple of years, so I'm speculating). We
> > already can't disable PM on 64-bit ARM, so I don't understand why 32-bit
> > ARM should be treated any differently.
>=20
> Yes, I want an option for debugging of a broken PM. It doesn't matter
> that there are no known PM-related issues on Tegra today, it could
> become a problem tomorrow. Probably a kernel boot parameter like
> pm_debug_always_on would suit even better here.=20
>=20
> Or maybe PM API already provides such debug options and I'm just not
> aware about them?

I'm not sure I understand what you're trying to do. If you want to use
!PM as a way to debug broken PM, how would that help? Presumably if you
disable !PM then the problem would be gone? In other words, in order to
reproduce a PM related issue don't you have to enable PM first?

I'm not aware of an alternate mechanism to force PM to off once built
into the kernel.

> Do you know what's the exact reason for ARM64 to not support !PM?

There's no reason per se not to support PM. It's just that at the time
we made the decision that we didn't want to. I vaguely remember that we
tried to do the same thing for 32-bit ARM, but at the time we would've
been the only platform to select PM, and that would've meant enabling
PM for all subarchitectures and therefore forcing PM in multi-platform
builds. Today if you build multi-platform kernels, at least Rockchip
will also forcibly enable PM for everyone.

I think you may also have objected at the time for similar reasons. But
this was a long time ago (at least 2 to 3 years I would guess) and much
has changed since then. Power management has gotten a lot better on
Tegra, to the point where we actually need it in order to properly
function. For example, Tegra DRM is not going to work with !PM because
we rely on runtime PM while disabling and enabling display pipelines.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxYZZwACgkQ3SOs138+
s6FTuhAAhyCFu0ue6O4zCqNUAElF0wTCKF2sMYOJwryfJTrqfKebbqbpggWyXlpM
rJLNEad2JyEsDv7p/FuZRlxvPHXHiHD2w1VDzK1sIoJ8EIXk2Opp6M4yHgvo6KLM
bZ1zZnmlTPyuVoXqV1w0tgOhWJrHxUCmmrxjdhwjvI06WxcdKrgB1KaBAqvfK2Nr
4Bebyx/L/3I0vssPbJenua9VEMkd5T4LU/y5/cJBY5OLVzDzeF4dGMhUImwwhvd6
Bfc667QxuxBqGO8D44ywXcxgJceUfBAhQvrDOgMHgWrSV0GuzYHlwBY40YUGDjPa
AfIcvFUKKjUFn/gk4tNS0GNxxA+aCprD7DU8P6fclqgCgLOnC6w1R0876r8bbixG
+LZFVScjY5YwJ3gGHL0wUl+2KH1sJJQ8dcLEAfjvq4ZslLR5NYqXOaStlbluVYZt
MfRnM13yacMaUG1CjMLmsE+bvQAgjPxK+NHtGT+ApRYI7wm6P+WIp8tDcq/1Zex0
oNolUG1SBg3WcmqFjV2ipe988vLLcGDKJ89f2g7E1mpjoLC8wEvfBhrbCQlf2iIg
1ddUr78IEw5rX1APtnBUvtJXIhT7N30crkUQH4TVnzkCussNhUg8xJve1DeTfexN
6lXnbh7/badq3h+pykmaerjBXHPB5101sOKBaNVJ7RZrEyrdNM8=
=UYr2
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============0191161021315245876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0191161021315245876==--
