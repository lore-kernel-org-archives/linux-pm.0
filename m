From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 19 Jan 2017 13:27:44 +0100
Message-ID: <20170119122744.GG30182@ulmo.ba.sec>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <5877B088.5040007@nvidia.com>
 <20170112173513.GA22794@ulmo.ba.sec>
 <5877BE49.2010008@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5877BE49.2010008@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Sebastian Reichel <sre@kernel.org>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:05:05PM +0530, Laxman Dewangan wrote:
>=20
> On Thursday 12 January 2017 11:05 PM, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Thu, Jan 12, 2017 at 10:06:24PM +0530, Laxman Dewangan wrote:
> > > On Thursday 12 January 2017 09:45 PM, Thierry Reding wrote:
> > > >=20
> > > > +	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
> > > > +
> > > > +	system_power_controller =3D power;
> > > > +	pm_power_off =3D max77620_pm_power_off;
> > > > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > > > +	arm_pm_restart =3D max77620_pm_restart;
> > > What if we want to reset via the Tegra and not through PMIC?
> > In that case I assume we either don't have a PMIC, or we should not add
> > the system-power-controller device tree property to the PMIC node. In
> > the latter case this driver won't install any power off or restart
> > callbacks.
>=20
>=20
> We need reset from Tegra and power of from PMIC. Tegra does not support
> power OFF.

Can you explain in more details what exactly the combination is that we
need to support? Why can't the PMIC both be the reset and power off
controller? Are there any advantages to resetting with the SoC rather
than the PMIC?

Thierry

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliAsMAACgkQ3SOs138+
s6H8lA/8CRshXCiGcY799U5D4c+JHzmUy0dYPbUERYBpiHWG0j3+UXvN44rKuJhA
ZzREXyQejB4aRIU9ksf6wCNn9yBwIfZCABgSEu9FRpatEr6wG55pULS+3m+tFO0z
dEpBquuhFRX/kJS4FC0Eo+iKJYgxrCSmWjs9SvH/ct+aSR7W8xC9C3oyxM9iZNog
MSswaIjwk3xI9/KW5k/2CSbgINmNOiE0Es5H+0Lt7tm3ASfU7cSxTXtY9z3OE0uu
rYXy23CLKkbHxMs0nfBY9sd1aRCnMkrDzEfZjDoasndPUaWpyrWy7NsegXLbQpC1
X2PeSwNHARL0MFnejDF1DWKe7c9/34SiksHPOG032lFmctdoz+u9XDJ/oo3RCrrP
umY98AecRcsr7yf4Qx6spNYN1o1NNlKgbp/dveDDMsUjMHbRh2vv8/4zSILowI8c
5pK+FOIcuA1vyi3gkKHbTyKI9hzEXqAV4QDQffJst34ECX0FDFQhIj40TWKtQfDM
3HCzvtELY9tb3MO76IpdMv2zl5/3ZlMTzEWsWHJdphG9VtoINwxUz8K4wwVGu+kx
I/P6UASkEvfSZXyWZaK3u7NJ/Y/CvORrJhhhlWsGJO5cdJc9FeRDjdmPpr7/Cig4
eq9wc8FXXGRWoip8pDT3odCOEQMWP0hmGz+0n0LG2VQPlJQrDLE=
=u+5f
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
