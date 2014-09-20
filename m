From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
Date: Sat, 20 Sep 2014 14:23:19 +0200
Message-ID: <20140920122318.GC3850@katana>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411151264-16245-7-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov@gmail>
List-Id: linux-pm@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> Previously only the ACPI PM domain was supported by the i2c bus.
>=20
> Let's convert to the common attach/detach functions for PM domains,
> which currently means we are extending the support to include the
> generic PM domain as well.
>=20
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Looks good to me, but I'd like to give Mika a chance to look at it,
since he does ACPI with I2C. Adding to CC.

> ---
>  drivers/i2c/i2c-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 632057a..3cd8f11 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -279,10 +279,13 @@ static int i2c_device_probe(struct device *dev)
>  	if (status < 0)
>  		return status;
> =20
> -	acpi_dev_pm_attach(&client->dev, true);
> -	status =3D driver->probe(client, i2c_match_id(driver->id_table, client)=
);
> -	if (status)
> -		acpi_dev_pm_detach(&client->dev, true);
> +	status =3D dev_pm_domain_attach(&client->dev, true);
> +	if (status !=3D -EPROBE_DEFER) {
> +		status =3D driver->probe(client, i2c_match_id(driver->id_table,
> +					client));

Very minor: I think it is more readable to keep this in one line.

> +		if (status)
> +			dev_pm_domain_detach(&client->dev, true);
> +	}
> =20
>  	return status;
>  }
> @@ -302,7 +305,7 @@ static int i2c_device_remove(struct device *dev)
>  		status =3D driver->remove(client);
>  	}
> =20
> -	acpi_dev_pm_detach(&client->dev, true);
> +	dev_pm_domain_detach(&client->dev, true);
>  	return status;
>  }
> =20
> --=20
> 1.9.1
>=20

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXG2AAoJEBQN5MwUoCm2E7EP/1ykOCTRgrozlYwdbXxO9X8Z
b6ad23VambrSiQJTZcYheydiVW9qrXIsn8TQf1flWChXtkD06odQRy8tGN8Vw3MQ
MTdhyB19x1Z0TMkdmcrbhohsRchjsaeMgcpCNklW8ul8nASuDjY9KUdhVfUaY07q
O1zyZxrA5ykPCq/xP2gakHTTOrB6pj0zwOlDe4yQOd1hJcWrhX0/EBxY4DgvvQIr
o05w2rdr+s6qCCgV3WSY9EJ0JBOqNhvvGpGnpZe6tms8e1RmrEnSil3piBC1nhHP
LPeZr/ZHdoRbEgUPNnr/otLhufVeE5uMLu7FFhmZi3DTVXXVb+kMjE17C6XYc3mM
DIumY2ubMBInCIZDjFZa0BvwuodKqkWrG5cmgimDw8VywhDfmCXm7Q1immbKZ0rw
p9R4YHkBl5ii0KCyTSrf5M4+ksV80iplb4jmIwfmU0kKnOIan1fgkmyHXR/WN67M
d6sZUpMsuCUNTRj7Axe6LdKuuQe/EbO9GC66umjxtckJIesM/BSHHgGAGqnxQolQ
q/NnP2JBTVz6sSjoBRb+EMw5cri2Yb2M1Ak24nw+uoveiqBGGMuFFQGoHyV9UXVP
zA0MaUKKESiwO1RIaqhYe5lRwIwFSUktD5s/yYQqKbSF0zGAeRn79O+U2ei7xI9a
gv2ABkxPmYxBPoSf9y1B
=izqF
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
