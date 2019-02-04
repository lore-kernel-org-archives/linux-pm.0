From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Mon, 4 Feb 2019 09:45:55 +0100
Message-ID: <20190204084555.GF19087@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo>
 <2034694.JE9CgBysmF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2034694.JE9CgBysmF@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 12:24:31AM +0100, Rafael J. Wysocki wrote:
> On Thursday, January 31, 2019 3:30:24 PM CET Thierry Reding wrote:
> >=20
> > --Pk/CTwBz1VvfPIDp
> > Content-Type: text/plain; charset=3Dus-ascii
> > Content-Disposition: inline
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Thu, 31 Jan 2019 12:46:54 +0100,
> > > > Rafael J. Wysocki wrote:
> > > > >
> > > > > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wro=
te:
> > > > > >
> > > > > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > > > > Thierry Reding wrote:
> > > > > > >
> > > > > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> > > > >
> > > > > [cut]
> > > > >
> > > > > > > > If I understand correctly the code, the pm domain is alread=
y ac=3D
> > tivated
> > > > > > > > at calling driver's probe callback.
> > > > > > >
> > > > > > > As far as I can tell, the domain will also be powered off aga=
in a=3D
> > fter
> > > > > > > probe finished, unless the device grabs a runtime PM referenc=
e. T=3D
> > his is
> > > > > > > what happens via the dev->pm_domain->sync() call after succes=
sful=3D
> >  probe
> > > > > > > of a driver.
> > > > > >
> > > > > > Ah, a good point.  This can be a problem with a probe work like=
 this
> > > > > > case.
> > > > > >
> > > > > > > It seems to me like it's not a very well defined case what to=
 do =3D
> > when a
> > > > > > > device needs to be powered up but runtime PM is not enabled.
> > > > > > >
> > > > > > > Adding Rafael and linux-pm, maybe they can provide some guida=
nce =3D
> > on what
> > > > > > > to do in these situations.
> > > > > > >
> > > > > > > To summarize, what we're debating here is how to handle power=
ing =3D
> > up a
> > > > > > > device if the pm_runtime infrastructure doesn't take care of =
it. =3D
> > Jon's
> > > > > > > proposal here was, and we use this elsewhere, to do something=
 lik=3D
> > e this:
> > > > > > >
> > > > > > >       pm_runtime_enable(dev);
> > > > > > >       if (!pm_runtime_enabled(dev)) {
> > > > > > >               err =3D3D foo_runtime_resume(dev);
> > > > > > >               if (err < 0)
> > > > > > >                       goto fail;
> > > > > > >       }
> > > > > > >
> > > > > > > So basically when runtime PM is not available, we explicitly =
"res=3D
> > ume"
> > > > > > > the device to power it up.
> > > > > > >
> > > > > > > It seems to me like that's a fairly common problem, so I'm wo=
nder=3D
> > ing if
> > > > > > > there's something that the runtime PM core could do to help w=
ith =3D
> > this.
> > > > > > > Or perhaps there's already a way to achieve this that we're a=
ll
> > > > > > > overlooking?
> > > > > > >
> > > > > > > Rafael, any suggestions?
> > > > > >
> > > > > > If any, a common helper would be appreciated, indeed.
> > > > >
> > > > > I'm not sure that I understand the problem correctly, so let me
> > > > > restate it the way I understand it.
> > > > >
> > > > > What we're talking about is a driver ->probe() callback.  Runtime=
 PM
> > > > > is disabled initially and the device is off.  It needs to be powe=
red
> > > > > up, but the way to do that depends on some configuration of the b=
oard
> > > > > etc., so ideally
> > > > >
> > > > > pm_runtime_enable(dev);
> > > > > ret =3D3D pm_runtime_resume(dev);
> > > > >
> > > > > should just work, but the question is what to do if runtime PM do=
esn't
> > > > > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or somet=
hing
> > > > > else?
> > > >
> > > > Yes, the question is how to write the code for both with and without
> > > > CONFIG_PM (or CONFIG_PM_RUNTIME).
> > >=3D20
> > > This basically is about setup, because after that point all should
> > > just work in both cases.
> > >=3D20
> > > Personally, I would do
> > >=3D20
> > > if (IS_ENABLED(CONFIG_PM)) {
> > >   do setup based on pm-runtime
> > > } else {
> > >   do manual setup
> > > }
> > >=3D20
> > > > Right now, we have a code like below, pushing the initialization in=
 an
> > > > async work and let the probe returning quickly.
> > > >
> > > >         hda_tegra_probe() {
> > > >                 ....
> > >=3D20
> > > So why don't you do
> > >=3D20
> > > if (!IS_ENABLED(CONFIG_PM)) {
> > >   do manual clock setup
> > > }
> > >=3D20
> > > here?
> >=20
> > I think that's exactly what Jon and Sameer were proposing, although the
> > discussion started primarily because of the way it was done.
> >=20
> > So basically the idea was to do:
> >=20
> > 	pm_runtime_enable()
> > 	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
>=20
> But why is it any better than checking !IS_ENABLED(CONFIG_PM) directly?

I guess the intention here was to avoid the conditional. This may also
have been cargo-culted from a time when we didn't have IS_ENABLED, and
the ifdefery required would've made this a lot worse.

> > 		hda_runtime_resume()
> >=20
> > So we're not calling pm_runtime_resume() but rather the driver's
> > implementation of it. This is to avoid duplicating the code, which under
> > some circumstances can be fairly long. Duplicating is also error prone
> > because both instances may not always be in sync.
> >=20
> > My understanding is that Takashi had reservations about using this kind
> > of construct because, well, frankly, it looks a little weird.
>=20
> Yes, the way it was originally written above was weird, but is checking
> IS_ENABLED(CONFIG_PM) directly really so weird?
>=20
> > We'd also likely want to have a similar construct again in the ->remove=
()
> > callback to make sure we properly power off the device when it is no lo=
nger
> > needed.
>=20
> Sure.  Again, why don't you make it conditional on IS_ENABLED(CONFIG_PM)?
>=20
> > I'm just wondering if perhaps there should be a mechanism in the
> > core to take care of this,
>=20
> How exactly?  How's the core going to know what to do when CONFIG_PM is
> disabled?
>=20
> > because this is basically something that we'd need to do for every sing=
le
> > driver.
>=20
> That is not true.  If the device is alwyas "on" to start with, you don't
> need to do anything.  That's the case on many systems.
>=20
> > For example, if !CONFIG_PM couldn't the pm_runtime_enable() function be
> > modified to do the above?
>=20
> But you'd need to pass a pointer to your hda_runtime_resume() to it at le=
ast
> and how's that simpler than using a simple conditional directly?

The idea was, as I was saying below, to reuse dev_pm_ops even if
!CONFIG_PM. So pm_runtime_enable() could be something like this:

	pm_runtime_enable(dev)
	{
		if (!CONFIG_PM)
			if (dev->pm_ops->resume)
				dev->pm_ops->resume(dev);

		...
	}

But that's admittedly somewhat of a stretch. This could of course be
made somewhat nicer by adding an explicit variant, say:

	pm_runtime_enable_foo(dev)
	{
		if (!CONFIG_PM && dev->pm_ops->resume)
			return dev->pm_ops->resume(dev);

		return 0;
	}

Maybe the fact that I couldn't come up with a good name is a good
indication that this is a bad idea...

> > This would be somewhat tricky because drivers
> > usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
> > that would result in an empty structure if !CONFIG_PM, but we could
> > probably work around that by adding a __SET_RUNTIME_PM_OPS that would
> > never be compiled out for this kind of case. Or such drivers could even
> > manually set .runtime_suspend and .runtime_resume to make sure they're
> > always populated.
> >=20
> > Another way out of this would be to make sure we never run into the case
> > where runtime PM is disabled. If we always "select PM" on Tegra, then PM
> > should always be available. But is it guaranteed that runtime PM for the
> > devices is functional in that case? From a cursory look at the code it
> > would seem that way.
>=20
> If you select PM, then all of the requisite code should be there.

We do this on 64-bit ARM, but there had been some pushback when we had
proposed to do the same thing on 32-bit ARM. I think there were two
concerns:

	1) select PM would force the setting for all platforms on multi-
	   platforms builds

	2) prevents anyone from disabling PM for debugging purposes

1) no longer seems to be valid because Rockchip already selects PM
unconditionally. I'm not sure if 2) is valid anymore either. I haven't
run a build with !PM in a very long time and I wouldn't be surprised if
that was completely broken.

Maybe we need to try this again since a couple of years have elapsed and
runtime PM support on Tegra is much more mature at this point.

> Alternatively, you can make the driver depend on PM.

That's probably the easiest way out, but to be honest I think I'd prefer
to just enforce PM and keep things simple.

Jon, any objections?

Thierry

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxX+8AACgkQ3SOs138+
s6Hmcg//aAGlZp00ItN97iK27JGEOIsaZDdLDUoJGlhiJTLTVGdrdzmytEzcfBdE
xpafPtu8cvUzY5W+6ML4d7/CySJBmwbumiCYzKxnGxO8mMzfo0fleb4VRRP6RXRg
Q2PXiUrnqeNQ91j6a8N+VWps6r7v7/YSBQDdv9BtmaDq8eX2+gVCdwrSCVcwUuos
k1ksAGMXqrOj+Ed3J2QDRHdyIKJV1auYhnX0qEvIQJPWAiO26Nk5O25X90tjFdBq
kNTOd/F073aYfE5Dz4n0HdSvtKLNbeJ3z5QqUAElDTTjTO++qWrw/CnITDe5aIpU
68hksAl5LqvGze5IKO97+OAfXGe0LXgRruYXl2Yy0F/eicFMMKhnqBSdWSksCrOA
asPDMX7X7gddh4Yx7JRZfsA18+UnFBGPQFsHs0l8dsimzQYWEeBq3647xAfAsSgf
u3syTLSEPcUoRQrotgtILJIFB2hGZijMzeQSHtd5FXKtEBZcnQhi6wiDkDhLM9FY
01ijS2Xcsz4b/sZ1IeHtCJfSZdKxSlC+QxcWV1K7p7bVQOXPcV7QwPJS5RaALFXB
IQPqFaGdJewPourlbdi/WzN79muOzLvJbEO3LuzGpkt9UmQRql7q0/3a2RoXbvO8
nyOHaGcJl4vB4zrTW+mwOrGU7SYXk/5ae/f7IR6vw4Cp4MQhjTs=
=wK8m
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
