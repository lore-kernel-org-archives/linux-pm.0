From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Thu, 31 Jan 2019 15:30:24 +0100
Message-ID: <20190131143024.GO23438@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo>
 <s5htvhpax8s.wl-tiwai@suse.de>
 <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
 <s5hh8dpavhw.wl-tiwai@suse.de>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pk/CTwBz1VvfPIDp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--Pk/CTwBz1VvfPIDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 31 Jan 2019 12:46:54 +0100,
> > Rafael J. Wysocki wrote:
> > >
> > > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > > Thierry Reding wrote:
> > > > >
> > > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> > >
> > > [cut]
> > >
> > > > > > If I understand correctly the code, the pm domain is already ac=
tivated
> > > > > > at calling driver's probe callback.
> > > > >
> > > > > As far as I can tell, the domain will also be powered off again a=
fter
> > > > > probe finished, unless the device grabs a runtime PM reference. T=
his is
> > > > > what happens via the dev->pm_domain->sync() call after successful=
 probe
> > > > > of a driver.
> > > >
> > > > Ah, a good point.  This can be a problem with a probe work like this
> > > > case.
> > > >
> > > > > It seems to me like it's not a very well defined case what to do =
when a
> > > > > device needs to be powered up but runtime PM is not enabled.
> > > > >
> > > > > Adding Rafael and linux-pm, maybe they can provide some guidance =
on what
> > > > > to do in these situations.
> > > > >
> > > > > To summarize, what we're debating here is how to handle powering =
up a
> > > > > device if the pm_runtime infrastructure doesn't take care of it. =
Jon's
> > > > > proposal here was, and we use this elsewhere, to do something lik=
e this:
> > > > >
> > > > >       pm_runtime_enable(dev);
> > > > >       if (!pm_runtime_enabled(dev)) {
> > > > >               err =3D foo_runtime_resume(dev);
> > > > >               if (err < 0)
> > > > >                       goto fail;
> > > > >       }
> > > > >
> > > > > So basically when runtime PM is not available, we explicitly "res=
ume"
> > > > > the device to power it up.
> > > > >
> > > > > It seems to me like that's a fairly common problem, so I'm wonder=
ing if
> > > > > there's something that the runtime PM core could do to help with =
this.
> > > > > Or perhaps there's already a way to achieve this that we're all
> > > > > overlooking?
> > > > >
> > > > > Rafael, any suggestions?
> > > >
> > > > If any, a common helper would be appreciated, indeed.
> > >
> > > I'm not sure that I understand the problem correctly, so let me
> > > restate it the way I understand it.
> > >
> > > What we're talking about is a driver ->probe() callback.  Runtime PM
> > > is disabled initially and the device is off.  It needs to be powered
> > > up, but the way to do that depends on some configuration of the board
> > > etc., so ideally
> > >
> > > pm_runtime_enable(dev);
> > > ret =3D pm_runtime_resume(dev);
> > >
> > > should just work, but the question is what to do if runtime PM doesn't
> > > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
> > > else?
> >
> > Yes, the question is how to write the code for both with and without
> > CONFIG_PM (or CONFIG_PM_RUNTIME).
>=20
> This basically is about setup, because after that point all should
> just work in both cases.
>=20
> Personally, I would do
>=20
> if (IS_ENABLED(CONFIG_PM)) {
>   do setup based on pm-runtime
> } else {
>   do manual setup
> }
>=20
> > Right now, we have a code like below, pushing the initialization in an
> > async work and let the probe returning quickly.
> >
> >         hda_tegra_probe() {
> >                 ....
>=20
> So why don't you do
>=20
> if (!IS_ENABLED(CONFIG_PM)) {
>   do manual clock setup
> }
>=20
> here?

I think that's exactly what Jon and Sameer were proposing, although the
discussion started primarily because of the way it was done.

So basically the idea was to do:

	pm_runtime_enable()
	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
		hda_runtime_resume()

So we're not calling pm_runtime_resume() but rather the driver's
implementation of it. This is to avoid duplicating the code, which under
some circumstances can be fairly long. Duplicating is also error prone
because both instances may not always be in sync.

My understanding is that Takashi had reservations about using this kind
of construct because, well, frankly, it looks a little weird. We'd also
likely want to have a similar construct again in the ->remove() callback
to make sure we properly power off the device when it is no longer
needed. I'm just wondering if perhaps there should be a mechanism in the
core to take care of this, because this is basically something that we'd
need to do for every single driver.

For example, if !CONFIG_PM couldn't the pm_runtime_enable() function be
modified to do the above? This would be somewhat tricky because drivers
usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
that would result in an empty structure if !CONFIG_PM, but we could
probably work around that by adding a __SET_RUNTIME_PM_OPS that would
never be compiled out for this kind of case. Or such drivers could even
manually set .runtime_suspend and .runtime_resume to make sure they're
always populated.

Another way out of this would be to make sure we never run into the case
where runtime PM is disabled. If we always "select PM" on Tegra, then PM
should always be available. But is it guaranteed that runtime PM for the
devices is functional in that case? From a cursory look at the code it
would seem that way.

Thierry

--Pk/CTwBz1VvfPIDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxTBn4ACgkQ3SOs138+
s6G4XA/+LliVo6vuvnFmCZ1Afg8ldDBnoTyh5vSoDAOAnpFTyPBGeIzbLz7nTKJ1
xanF3oFKTYkpQcrJ1mndXpt60MsUul33ZfOGfMNzL7GrBzNLpWS+qBfliPnsXNIv
tnqgk7LXgaHhqtIABpqcdoAvMVh+HdC1V6WrYYmnfLP/PiJsLL+wYBcwVcNzpkCv
iEq9XvbCotjuMiWEK1r5WcM20pl6Prspw2gfiOYj1DXaELWEpb6Ky6xTEM9NYMv+
L7hHO4uwvYBoUB1gz8zbpZeaPFWwFzva1/YUBXidthKmSHh/0IO85Ab7izcwTtq+
f4O0svexTB/my3lia+MHWkLnwKTowb7oi/owliXtPU4HIE3YCUzROtnCC9Dz8toO
HWu6xH9IjVgU/0Jb7gDWA2k9drw2kNlvZPrGL8Me+IwmWZJZGzMMCL/IeqJuKOMl
fI6gOoM3iWX8kUN0wiIuMTKUUoaR5guIyfdSa77X4ThqGdFm5oaRw0YbHNcyPiFZ
/xWnlnlwHsArCi1rC9NaJpOV3PmAZwRjrZlB9CV9YtbdDOgfkF356c2W3IfPdWPq
mORoFoqU0EoPbhrDcdprcNgDH80LqRZ5S6+D7SxuFjJ2SrkFmlazkyrYrZZIOBn+
wfdq3iZa1uhAGnhScfcMPO06TZjU/zDhrmPaTZbrNPC9QWQR/mw=
=zXax
-----END PGP SIGNATURE-----

--Pk/CTwBz1VvfPIDp--
