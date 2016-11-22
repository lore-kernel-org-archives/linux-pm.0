From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: use fixed device name
Date: Tue, 22 Nov 2016 16:23:48 +0100
Message-ID: <20161122152348.ip3gz3mea4fgrejl@earth>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-2-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdiunlqrmlj3n3hx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933052AbcKVPXz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 10:23:55 -0500
Content-Disposition: inline
In-Reply-To: <1479751491-8849-2-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--mdiunlqrmlj3n3hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 21, 2016 at 07:04:50PM +0100, Nicola Saenz Julienne wrote:
> The current device name for sbs-battery is derived from it's i2c address.
> This is not acceptable if we want to be able to trigger the
> "external_power_changed()" routine from a charger driver.
>=20
> Signed-off-by: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
> ---
>  drivers/power/supply/sbs-battery.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 8bb2eb3..9565c696 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -740,6 +740,7 @@ static void sbs_delayed_work(struct work_struct *work)
>  }
> =20
>  static const struct power_supply_desc sbs_default_desc =3D {
> +	.name =3D "sbs-battery",
>  	.type =3D POWER_SUPPLY_TYPE_BATTERY,
>  	.properties =3D sbs_properties,
>  	.num_properties =3D ARRAY_SIZE(sbs_properties),
> @@ -762,11 +763,6 @@ static int sbs_probe(struct i2c_client *client,
>  	if (!sbs_desc)
>  		return -ENOMEM;
> =20
> -	sbs_desc->name =3D devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
> -			dev_name(&client->dev));
> -	if (!sbs_desc->name)
> -		return -ENOMEM;
> -
>  	chip =3D devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL=
);
>  	if (!chip)
>  		return -ENOMEM;

NAK. This is not ok for systems using multiple sbs-batteries.
Also please read:

Documentation/devicetree/bindings/power/supply/power_supply.txt

-- Sebastian

--mdiunlqrmlj3n3hx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0YvwACgkQ2O7X88g7
+poeORAAhtw/xJvqINf2fhMqrUqH6KrY/Uy7d97TlIWkbfrtIn5MxnC6PCiXARBD
PdN8kQVy4hN7TLwzcWGLfN6RUULC4APRtSSLPA0ssBmRjeLZ4Ha28JwqwYAT6jR7
aFQ6TxMHdKZ/ct42TKNmAATgF5/xtgqBkf6pJqbTSjDmfWEu4BPTA5KL6vHoacPO
ka06235BL9YQSIejLMu4V0pnCFQYvDE+iK64IgOf9T8bvjVytQrnNXB5Ku80BfXj
XpLxg+/kF6Wv5VwXQh508ld//dwBLkSfNcBz3AtrE/OJfxH+yyImmWnZ++RNBTRf
jN2ccdlzF/vfh6A5FvYZjwEEQsBFKdxxn/Df+8C2Ss3pPfNTzhaicxRk1aTE2PYh
9E2yiLnUESGVlmAMr6W8/UNXExz3EFAuPd5R82SQIMYfejK2saVry64na3fL4FrP
T/4+Gd7rj9LugbLqHORm1ymabU70uQnqz4oX0bmcp+69Ic7Aa9ypWrb9g3z+NXH4
6s5hNKHGHmgHBBsbANEarc9kDeDsWW5XK54e+TJ81C0c2egG1HnVKAvyiiygWhfq
+fA1wyi+nuifrW7Ebt2bQkRYMBssPelVjCiKY/uOjKrJJViyrnQF43rFf8Va4t4o
ZsXjU6C4Or4xwlA6T4E86MFHkMSz3YIwZGx50aYRRLBL1Ch+nmA=
=KDkP
-----END PGP SIGNATURE-----

--mdiunlqrmlj3n3hx--
