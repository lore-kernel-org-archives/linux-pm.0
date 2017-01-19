From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 19 Jan 2017 13:23:57 +0100
Message-ID: <20170119122357.GF30182@ulmo.ba.sec>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170113034425.7ttvc73aewtbitrk@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 04:44:25AM +0100, Sebastian Reichel wrote:
> On Thu, Jan 12, 2017 at 05:15:07PM +0100, Thierry Reding wrote:
[...]
> > +	if (!of_property_read_bool(np, "system-power-controller"))
> > +		return 0;
> > +
> > +	power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> > +	if (!power)
> > +		return -ENOMEM;
> > +
> > +	power->regmap =3D max77620->rmap;
> > +	power->dev =3D &pdev->dev;
> > +
> > +	err =3D regmap_read(power->regmap, MAX77620_REG_NVERC, &value);
> > +	if (err < 0) {
> > +		dev_err(power->dev, "failed to read event recorder: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	dev_dbg(&pdev->dev, "event recorder: %#x\n", value);
> > +
> > +	system_power_controller =3D power;
> > +	pm_power_off =3D max77620_pm_power_off;
>=20
> > +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > +	arm_pm_restart =3D max77620_pm_restart;
> > +#endif
>=20
> Please use register_restart_handler() instead. It has support for
> priorities, is not arm specific and properly supports unregistering
> (some handler with lower priority will take over). You can check
> gpio-restart as an example for the API.
>=20
> If you have some other arm_pm_restart handler (those are tried first)
> I suggest to convert that to the restart handler framework. Actually
> it may be a good idea to convert all of them and drop arm_pm_restart,
> since there are only 4 left:
>=20
> $ git grep "arm_pm_restart =3D"
> drivers/firmware/psci.c:        arm_pm_restart =3D psci_sys_reset;
> arch/arm/mach-prima2/rstc.c:    arm_pm_restart =3D sirfsoc_restart;
> arch/arm/xen/enlighten.c:       arm_pm_restart =3D xen_restart;
> arch/arm/kernel/setup.c:                arm_pm_restart =3D mdesc->restart;
>=20
> The first 3 should be easy to update and the last one could
> be solved by registering a wrapper function as restart handler,
> which calls mdesc->restart().

I remember this not being the first time that this confuses me. And from
looking around a little it seems like I'm not the only one.

Do you know if there's ever been any attempts to formalize all of this
by adding some sort of framework for this? That way some of the
confusion may be removed and architecture-specific bits could be
eliminated more easily.

Thierry

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliAr9sACgkQ3SOs138+
s6FU4BAAhK6/BpadZHrwSHeAWvARhNjvuKBrqA0OrJzIbFHyiXajo8CMfvUam2qD
wjXHvvTIH8N3jZ1ufhljFPIQnf9tZ7LYKk3noQkWN5/rJ4+wmlQt/6CIMZischti
i7C3qGKBYOW4RzwyZz7YhydO/vnOEANcQYkWjIqWq9mJJCYGwhtDH+5Aw5LEkdS5
xxPDwZ9rXCtJkrE6rxF+9W3EQ0x+O/ulsMVkPXV2EX4x++wKwVPutnNYAnyfStJI
niOfQU8NhnpvagvGZIoH9E1VU85VKdXRVi8q7/e2b8AQtDwkDzqBdHT7Sl+VcLkJ
OHX+YmeYd2igwgEKulDLG0jc2S9DqMIOsM++XZR3NP00Ewv6EMq4MukX/fSDGgQK
n/T+YkJKZeBhGkFwajjn8hlaHqV8O+u2hLByck+hqqpIHi+IaovGvOQI5ItAxkG7
LM7KW9u9zbq2k4D4Hh87xX+iZcY2BNXaGeU5FWFsensjAdmnz7f32kbZjiwDgOxe
oOchPiS/gLmGkbcOlXcBVUzNKNKDuR9xsuX/Z/s+bPK3bmg/XfTkSTpbdm2iuJsh
zITxOEHKYiQYKwpVsRljqODCNNfIZFK7Ci64mV2hy8bRfbCXYiQ6+PLAA16HQUtj
94f8Mom0MhpqZGdfYZ5nPr22CZXEL0yFcVzR7pnB13CDnARnonM=
=eCFl
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
