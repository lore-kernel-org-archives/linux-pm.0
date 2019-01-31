From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Thu, 31 Jan 2019 12:05:30 +0100
Message-ID: <20190131110530.GA23438@ulmo>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ha7jicd4l.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jon Hunter <jonathanh@nvidia.com>, pierre-louis.bossart@linux.intel.com, Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, alsa-devel@alsa-project.org, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> On Wed, 30 Jan 2019 13:45:49 +0100,
> Jon Hunter wrote:
> >=20
> >=20
> > On 25/01/2019 11:06, Sameer Pujar wrote:
> > > If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
> > > will not be ON. This could cause issue during probe, where hda init
> > > setup is done. This patch enables clocks unconditionally during probe.
> > >=20
> > > Along with above, follwoing changes are done.
> > >   * enable runtime PM before exiting from probe work. This helps to a=
void
> > >     usage of pm_runtime_get_sync/pm_runtime_put() in probe work.
> > >   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
> > >   * runtime PM callbacks moved out of CONFIG_PM check
> > >=20
> > > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > > Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  sound/pci/hda/hda_tegra.c | 26 +++++++++++++++++---------
> > >  1 file changed, 17 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> > > index c8d18dc..ba6175f 100644
> > > --- a/sound/pci/hda/hda_tegra.c
> > > +++ b/sound/pci/hda/hda_tegra.c
> > > @@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_teg=
ra *data)
> > >  	return rc;
> > >  }
> > > =20
> > > -#ifdef CONFIG_PM_SLEEP
> > >  static void hda_tegra_disable_clocks(struct hda_tegra *data)
> > >  {
> > >  	clk_disable_unprepare(data->hda2hdmi_clk);
> > > @@ -227,6 +226,7 @@ static void hda_tegra_disable_clocks(struct hda_t=
egra *data)
> > >  	clk_disable_unprepare(data->hda_clk);
> > >  }
> > > =20
> > > +#ifdef CONFIG_PM_SLEEP
> > >  /*
> > >   * power management
> > >   */
> > > @@ -257,7 +257,6 @@ static int hda_tegra_resume(struct device *dev)
> > >  }
> > >  #endif /* CONFIG_PM_SLEEP */
> > > =20
> > > -#ifdef CONFIG_PM
> > >  static int hda_tegra_runtime_suspend(struct device *dev)
> > >  {
> > >  	struct snd_card *card =3D dev_get_drvdata(dev);
> > > @@ -283,7 +282,7 @@ static int hda_tegra_runtime_resume(struct device=
 *dev)
> > >  	int rc;
> > > =20
> > >  	rc =3D hda_tegra_enable_clocks(hda);
> > > -	if (rc !=3D 0)
> > > +	if (rc)
> > >  		return rc;
> > >  	if (chip && chip->running) {
> > >  		hda_tegra_init(hda);
> > > @@ -292,7 +291,6 @@ static int hda_tegra_runtime_resume(struct device=
 *dev)
> > > =20
> > >  	return 0;
> > >  }
> > > -#endif /* CONFIG_PM */
> > > =20
> > >  static const struct dev_pm_ops hda_tegra_pm =3D {
> > >  	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
> > > @@ -551,9 +549,9 @@ static int hda_tegra_probe(struct platform_device=
 *pdev)
> > > =20
> > >  	dev_set_drvdata(&pdev->dev, card);
> > > =20
> > > -	pm_runtime_enable(hda->dev);
> > > -	if (!azx_has_pm_runtime(chip))
> > > -		pm_runtime_forbid(hda->dev);
> > > +	err =3D hda_tegra_enable_clocks(hda);
> > > +	if (err)
> > > +		goto out_free;
> >=20
> > We also need to think about power-domains here. Enabling the clocks
> > might not be enough as the appropriate power-domain needs to be enabled.
> > For 64-bit Tegra runtime-pm will handle the power-domains (assuming they
> > are populated in device-tree). So I still think it is better we call
> > pm_runtime_get_sync() at some point rather than just replying on
> > enabling the clocks.
>=20
> If I understand correctly the code, the pm domain is already activated
> at calling driver's probe callback.

As far as I can tell, the domain will also be powered off again after
probe finished, unless the device grabs a runtime PM reference. This is
what happens via the dev->pm_domain->sync() call after successful probe
of a driver.

It seems to me like it's not a very well defined case what to do when a
device needs to be powered up but runtime PM is not enabled.

Adding Rafael and linux-pm, maybe they can provide some guidance on what
to do in these situations.

To summarize, what we're debating here is how to handle powering up a
device if the pm_runtime infrastructure doesn't take care of it. Jon's
proposal here was, and we use this elsewhere, to do something like this:

	pm_runtime_enable(dev);
	if (!pm_runtime_enabled(dev)) {
		err =3D foo_runtime_resume(dev);
		if (err < 0)
			goto fail;
	}

So basically when runtime PM is not available, we explicitly "resume"
the device to power it up.

It seems to me like that's a fairly common problem, so I'm wondering if
there's something that the runtime PM core could do to help with this.
Or perhaps there's already a way to achieve this that we're all
overlooking?

Rafael, any suggestions?

Thanks,
Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS1ngACgkQ3SOs138+
s6E8rBAAjzQAb31XTYdEsyXIwYmUXSryCimpXWKM58O4tV5wB8ulcFJDv5t87O4Z
EfnmuVlQCFdXx1nbx6YIAHgOalzCjnhW16DUHOr7JDagX9xAjwqV0DRpBXfhp4/S
fDb0zmeB3/Ecub3Oquh3dd2Fu/6AuULZR49XKszlbpoxk20q8VaeV6DI0U6VkudY
isXcsjw6cPg1E1JpiZNYRYX5VEMvVRVYpz6zcVsz8RxkUWHgVuk0OI8izlJ6CbXK
87bCjWty7fgW7Iz7tgJzSPo+pHo/9Jlns4zZkHTkX2+y7CE2jYpM+FwaiVVovcu3
7mRapuI6np7t4YSRii/zdaPff39K1vtWo/NUJToufL7bI81MyNXTKkjC5n4+p9un
xr8Mx+biAKFszOa1FU2WwkjOWZeeuQkPpo5mVOgXzPD1ObPGzsPqvdmUtmSao+31
/s51KWvTsA0qpc80WM9xcq8Yu/VPQJvHOj4Al6fuBTXhfGL1sQKduMuKztYgZM6m
C+KIFp3i4ddtb/VbwR1S4vw5ccI7Y1baw1k5F6ozpEpaFsie4VYuZuN5QXLgWw4Q
texUkRLnZdZw32yKxyg0+e2co6ZbImRasciw/y8kYHc+Alxmhkl3RMWgEqyb36f7
gyyD5Xf1EgPDCq2l9GDQGDAajPJr4v8wVtuEdcyZd4XEHLhQHno=
=lotk
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
