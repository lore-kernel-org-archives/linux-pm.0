From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] power: bq24257: Fix use of uninitialized pointer
 bq->charger
Date: Mon, 19 Sep 2016 20:57:55 +0200
Message-ID: <20160919185754.sezcbv7wv4n7xajk@earth>
References: <20160908013815.9904-1-savoundg@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpnv5trh2pfb4agl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbcISS6E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 14:58:04 -0400
Content-Disposition: inline
In-Reply-To: <20160908013815.9904-1-savoundg@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Georges Savoundararadj <savoundg@gmail.com>
Cc: linux-pm@vger.kernel.org, Aurelien Chanot <chanot.a@gmail.com>, Andreas Dannenberg <dannenberg@ti.com>, David Woodhouse <dwmw2@infradead.org>


--hpnv5trh2pfb4agl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2016 at 06:38:15PM -0700, Georges Savoundararadj wrote:
> bq->charger is initialized in bq24257_power_supply_init.
> Therefore, bq24257_power_supply_init should be called before the
> registration of the IRQ handler bq24257_irq_handler_thread that calls
> power_supply_changed(bq->charger).
>=20
> Signed-off-by: Georges Savoundararadj <savoundg@gmail.com>
> Cc: Aurelien Chanot <chanot.a@gmail.com>
> Cc: Andreas Dannenberg <dannenberg@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> ---
>  drivers/power/bq24257_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_char=
ger.c
> index 1fea2c7..6fc31bd 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -1068,6 +1068,12 @@ static int bq24257_probe(struct i2c_client *client,
>  		return ret;
>  	}
> =20
> +	ret =3D bq24257_power_supply_init(bq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		return ret;
> +	}
> +
>  	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>  					bq24257_irq_handler_thread,
>  					IRQF_TRIGGER_FALLING |
> @@ -1078,12 +1084,6 @@ static int bq24257_probe(struct i2c_client *client,
>  		return ret;
>  	}
> =20
> -	ret =3D bq24257_power_supply_init(bq);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to register power supply\n");
> -		return ret;
> -	}
> -
>  	ret =3D sysfs_create_group(&bq->charger->dev.kobj, &bq24257_attr_group);
>  	if (ret < 0) {
>  		dev_err(dev, "Can't create sysfs entries\n");

Thanks, queued.

-- Sebastian

--hpnv5trh2pfb4agl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4DUwAAoJENju1/PIO/qaqeIQAKZm2BF4FNPqbg8aOhONpzXP
tgyG04iJ5HkIGukkxZDSCnUYRZ1laFA0mI3cRGvO7nvCW52rUJjwamNqKxcmMWdZ
+cl/HsVk08rJIpHYai08gwo3hLySgjDUXHQ7y9jGll4XoWMF5Ug3cYxezPKpq8C5
2VHgvPok6KLp3PEjJJ/tWeIY5qFll5RNIaZ5BmXeBOvQFC6tR7OgnCLcQxWaNlDx
2Daah06m4+v0BcsPJf+Te0r+m7Z5TXAdR9eHnUh0aRfb8oGAc0rablU0p1KzrCRa
swPMBLpiI1Pk/OZsQrlphZu4A4vzOMBhoc2pFo2hrj7ZMJXVDZPiKnsUEO3HqnuM
Qe3MIFjniTCqcgAvT9CnQGCOYfBt78kygwlKwNPfsxFElcsnawyZsTI4HgJ12wHB
888I9sVonyc0qOJO2TyviBh9tHzc7T+aUrzY2q7+MaU+EsM1z7xkOBaaAR1+SaJ+
7g9hTffKGgm1UhzOM23MOYCsnqHgue0ZgJc2Esi+kjyCkFTOlUyfsTsWmc1yJCxz
h7cThl5A58J7cek0l0BvDGfxI9LvrnIS3VevK+aWMjNxHMW1FQf2OAUI8fYTWxro
mhFO6DmzzjRy2554ILX2e1bc2RCFULTr2lqMWpWHMe7tX3cmF0Au1j63gjQwkrlj
DPktU+5y2qa9/+VL+kue
=GSXb
-----END PGP SIGNATURE-----

--hpnv5trh2pfb4agl--
