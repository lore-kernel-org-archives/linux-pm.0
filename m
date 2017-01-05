From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
Date: Thu, 5 Jan 2017 18:02:24 +0100
Message-ID: <20170105170224.wq45m3pg6sjnuhyh@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0172696973153841119=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, jic23@kernel.org, icenowy@aosc.xyz
List-Id: linux-pm@vger.kernel.org


--===============0172696973153841119==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ydonvtwzvx2n2jl"
Content-Disposition: inline


--4ydonvtwzvx2n2jl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 05:37:17PM +0100, Quentin Schulz wrote:
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives =B5V.
> +		 */
> +		val->intval *=3D 1000;

s/gives/wants/ ?

> +static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> +					  int val)
> +{
> +	switch (val) {
> +	case 4100000:
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_1V);
> +	case 4150000:
> +		if (axp20x_batt->axp_id =3D=3D AXP221_ID)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_15V);
> +	case 4200000:
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_2V);
> +	default:
> +		/*
> +		 * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
> +		 * can be set to 4.22V and 4.24V, but these voltages are too
> +		 * high for Lithium based batteries (AXP PMICs are supposed to
> +		 * be used with these kinds of battery).
> +		 */
> +		return -EINVAL;
> +	}

Since all your calls to regmap are the same, something like:

case 4100000:
	val =3D AXP20X_CHRG_CTRL1_TGT_4_1V;
	break;

case 4150000:
	val =3D AXP20X_CHRG_CTRL1_TGT_4_15V;
	break;

regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
		   AXP20X_CHRG_CTRL1_TGT_VOLT, val);


It would also get rid of your warnings in checkpatch.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--4ydonvtwzvx2n2jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbnwbAAoJEBx+YmzsjxAgjkYQALMF1anuaoZC9l++9J6su0Vh
FgfjsnT7qYWz+qzBFoF42u1ujZSsNrOhlqIKh5lXciCe69Cx6RBxXJgGAkYIxrlO
kXLcHttap+RU7RYQJ4S4YwKwgksffDw0jx8th5hxZOowBogqG7zDn5H5dz/3wSyf
qVcyBTwKilIAId6AbUy+T6ptWMMYVt1SPLZVK2bPnQKo+a1f+KScCJ92pfl228vM
8xGkgHVUgc73a6zePin3oF4d2oRmwYgTdJFiJCXduXwxlfIynwAonDPynu52hdGI
S7KPI7aIUKWR/fFIQYSU1jFBbBt0h1YXrQFIrGO2f9+Ow2f98vkU9j7Q7mzOOdyc
33F2VSeSTR3SJarhaQUOsPFScLUo8deNQVE7nv6uBKn8+EId6BvORQ2q3LMEfF2F
9RZaBBxZ48Qnp14BZrAemiAHccy8bczy465HGqfSVO3hyrHPsEdSL08rF09RaxcU
9fD56VopraViiomKLKVLYSrHWP8YLXbtAd/vcdDvJNleun1GEk4amLh6xHVI3zE1
/M6xm4a28vVWOnlW0D4s+PNG7vJp7+mXQ2hAu2ZvaUzhtPIkdHf6w9/y1ytBW2I9
Kf8CiwFr002dtf3tridrFzoePr9n4ZQvouUGBnMVp2K3cZtYUcxeKbdeH92ZRErw
cCw+Jgqy3HHTZnG3IoOe
=ThAR
-----END PGP SIGNATURE-----

--4ydonvtwzvx2n2jl--


--===============0172696973153841119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0172696973153841119==--
