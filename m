From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Mon, 5 Sep 2016 13:08:46 +0200
Message-ID: <20160905110846.5ersy47jbozzgldj@earth>
References: <20160902220953.28995-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u55bblpouhgzelxf"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160902220953.28995-1-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--u55bblpouhgzelxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, Sep 03, 2016 at 12:09:53AM +0200, Paul Kocialkowski wrote:
> This requests the status GPIO with initial input setup. it is required
> to read the GPIO status at probe time and thus correctly avoid sending
> i2c messages when AC is not plugged.
>=20
> When requesting the GPIO without initial input setup, it always reads 0
> which causes probe to fail as it assumes the charger is connected, sends
> i2c messages and fails.
>=20
> While at it, this switches the driver over to gpio consumer.
>=20
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> ---
>  drivers/power/supply/bq24735-charger.c | 44 +++++++++++++---------------=
------
>  include/linux/power/bq24735-charger.h  |  4 ----
>  2 files changed, 16 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c

[...]

> -	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client->dev.of_node)
> +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client->dev.of_node) {
>  		charger->pdata =3D bq24735_parse_dt_data(client);
> +		if (IS_ERR(charger->pdata))
> +			return PTR_ERR(charger->pdata);
> +	}

I queued your patch into power-supply's for-next branch, but dropped
this change, which is from an earlier revision of this patch and no
longer needed. Thanks for your patch.

-- Sebastian

--u55bblpouhgzelxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXzVI7AAoJENju1/PIO/qa7jQQAKPciYuk/TaKAtpENn0/8dID
QQpVWELmz1HpwdYvTXKXGjQbZgDp403oeK6ibki0Je4bq6tyMo2kvj49iMpCDVWw
FQbxw1b5p4iKvgR0B1RYNjLPRzO4BOaMsjLZnbBXQvVRxs6rofil1NnFGEbDBRxh
qJVH+EbKiKaoMMY3kWTZwjvZS6aAQp2bRMrzgJcPvfk2cxNP7nUXM7mHaE06V+0f
3tYux9bNUwdxkq7613kJc2FL9Vyg861kUH3J4MlkguJH/RoKdmVSBvolMGdpQNLn
5p2yc3uUIxGCxmfXZW8Oj9eGXpMWqT6BN9fJwTUEh7PipoEYr0k6/FEOTD2+rMc8
7wQnMgUqQwV9xS2FUSTiupPjQrkrKAJLtLTzuHTs8EkTQiVFse1MgoiFAH1uqFhK
lPpiZ0p2uOe/F/JAtGOt0+qvCKrlSpg+p/8afyWt8qLwImWhg+cEwvskIsxiKoy6
UlE2F/ntJ1OnGgJRL/3lBBpVlIWb87tKGzCXuOifM12D4CcP3+mjiHMPB6BccfWu
HsAQwQ/dZj9qWBpnQrPQAN8n+2p4XF61mgNgky4R2Bq0pgqdyals2wtJzFVLzZQr
DP8COkx7d0G3fBSRlR1JLxnI4/EfgRDqHjyo841YGn+uxv3VYBjvah6Qc5CfQA5e
bjwir2ZROgJSG/5adhnE
=xdIL
-----END PGP SIGNATURE-----

--u55bblpouhgzelxf--
