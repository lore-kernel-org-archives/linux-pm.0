From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data
 structure at the beginning of probe
Date: Wed, 5 Dec 2018 23:38:25 +0100
Message-ID: <20181205223825.vkye6tgvan2laxlu@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="molrisa3iqg5uhvw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--molrisa3iqg5uhvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:28AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Check at91_shdwc before continuing with probe since we want only one inst=
ance of
> this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-power=
off:
> do not procede if at91_shdwc is allocated").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

This depends on patch 2, so I skipped this one.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index 48661e04a3de..e75d8f0f0526 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
>  	u32 ddr_type;
>  	int ret;
> =20
> +	if (at91_shdwc)
> +		return -EBUSY;
> +
>  	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL=
);
>  	if (!at91_shdwc)
>  		return -ENOMEM;
> --=20
> 2.7.4
>=20

--molrisa3iqg5uhvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIU2EACgkQ2O7X88g7
+prIDA//U8cbco0f57BpAw5fvYKg3OUiZ+k8pD1BhqrSsM/VfXF9PZm4uDQAP0EU
jcNmwCYrjV8jX0a9RA/ub29pj4Bl53608IN1cb9h4mnDuuyjVoX/T92gI6gbk+MT
dQow9HmkDB4ICCwefrthCd7IIwSXDlxf/COyMj8wZoSIih1/BtKnzjvnnw7ahPQX
btK/HrbGU/RLe1QgXq7X0VTnr6PPFB8XVbkoHr94yVO2jwKclbkB69wUK7NkHq5S
ahU/X3NPaFAEgH8xfZyw+jFMdxK8HVux5RsKOidIPJab9PE3sFb2VCgwIpMkNHQz
fIJiG9rL0JxUXKEa9mNl9pnGKG3LO0FmqGZqX9tuqs8EfvqmL9sI2B0+TKkqj41S
lm7N7O8gO4yRBCR8NmVDrCL+ZOxwqchKN0C4+RMBtiOxumtIyfX82h6RGI3vZW2n
n7QpoRPYeIlFByTd6yYGZPnsvDxs5thwpG0Wn4VmKlbGYO1ZzQjjK9aFuPSmRuGk
IqIsFH6TszJfQ00quVcxMBwrq9GxmJCXzwGeCLWq5ZRUm7iKLgf5R3664tdgLlnh
OddntHIGRcWF1q+/p2gAu1TSlB2vJZldgX/kHvHN8ARA3+i6ZMYeKYcobGOJP4yS
P0UR7v2GYyPT40XVNmpdycCrHxUsClOt862xMxbVBiBoTI7Babc=
=chEH
-----END PGP SIGNATURE-----

--molrisa3iqg5uhvw--
