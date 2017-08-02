From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 2/5] power: generic-adc-battery: Parse more
 properties from DT
Date: Wed, 2 Aug 2017 13:56:10 +0200
Message-ID: <20170802115610.GC2765@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52098 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753018AbdHBL4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 07:56:12 -0400
Content-Disposition: inline
In-Reply-To: <1501620926-22669-3-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: sre@kernel.org, robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek.belisko@gmail.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +#ifdef CONFIG_OF
> +static struct gab_platform_data *gab_dt_probe(struct platform_device *pd=
ev)
> +{
> +	struct gab_platform_data *pdata;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	const char *name;
> +	u32 val;
> +	int err;
> +
> +	pdata =3D devm_kzalloc(&pdev->dev,
> +			sizeof(struct gab_platform_data),
> +			GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->gpio_charge_finished  =3D of_get_gpio(np, 0);
> +
> +	/* parse and fill power_supply_info struct */
> +	err =3D of_property_read_u32(np, "technology", &val);
> +	if (err) {
> +		dev_info(&pdev->dev, "Battery technology unknown\n");
> +		val =3D 0;
> +	}
> +	pdata->battery_info.technology =3D val;
> +
> +	err =3D of_property_read_string(np, "battery-name", &name);
> +	if (err) {
> +		dev_info(&pdev->dev, "Battery name empty, setting default\n");
> +	}
> +	pdata->battery_info.name =3D name;

Actually ... looking at this once more. These are new properties,
right?

They'll need to be documented:

pavel@duo:/data/l/linux$ grep -ri battery-name Documentation/devicetree/

shows empty.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmBvdoACgkQMOfwapXb+vLevgCgrUvu5WEVqxk8FF6jmjjRKPKy
9JsAnA5Ye1WJuZRv9lYwpsloqZ25Y5Eh
=GkGz
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
