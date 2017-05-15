From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 4/9] power: supply: axp20x_usb_power: Drop unnecessary
 static
Date: Mon, 15 May 2017 15:25:19 +0200
Message-ID: <20170515132519.ebpj4f6it5uosokq@earth>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrovo7hu6q2rue63"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60448 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933582AbdEONZ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2017 09:25:26 -0400
Content-Disposition: inline
In-Reply-To: <1493928654-18768-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--rrovo7hu6q2rue63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Thu, May 04, 2017 at 10:10:49PM +0200, Julia Lawall wrote:
> Drop static on a local variable, when the variable is either first
> initialized or never used, on every possible execution path through the
> function.  The static has no benefit, and dropping it reduces the code
> size.
>=20
> [...]
>=20
> before:
>    text    data     bss     dec     hex filename
>    2865     252       8    3125     c35 drivers/power/supply/axp20x_usb_p=
ower.o
>=20
> after:
>    text    data     bss     dec     hex filename
>    2822     252       0    3074     c02 drivers/power/supply/axp20x_usb_p=
ower.o

Thanks, queued.

-- Sebastian

> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/power/supply/axp20x_usb_power.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 2397c48..44f70dc 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -339,7 +339,7 @@ static int axp20x_usb_power_probe(struct platform_dev=
ice *pdev)
>  		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
>  	static const char * const axp22x_irq_names[] =3D {
>  		"VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
> -	static const char * const *irq_names;
> +	const char * const *irq_names;
>  	const struct power_supply_desc *usb_power_desc;
>  	int i, irq, ret;
> =20
>=20

--rrovo7hu6q2rue63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkZrD8ACgkQ2O7X88g7
+po2eg/9FNbU+HJAl40byIlXC4D2Usq2YjzYoulSH11Qt4BJGRCRcH5Qh/M6kDpD
n+nq/Df8hVGygZI0HxoHGxO/SYJGauncArTgihCnY5G7FKbFUAu9/KhmpWPu0nvP
U2n/6bdQ7voVpNf1jDvaLXsWbB0jR5rNkUZqd9hCEUIDNmLZ6iUN61ZqOX8F691S
Z32h+KnR2aTpcgz2lxrRQtxAoRxa1R4GsO8HBYiGgv+EWPp3gEhp5CbKdCJiATjJ
JqKMR0HzeuCe9B2nNdUb3QLK5iJrvm3N68TjaSNLd5P1ueLT7orYzlnOMnnMp4N4
ICw0V40yQzBiKDg4kH8EDWODMaLAmaa9gZtFXEqVRbNqQaqht4U2CCAIU71KbDdU
jOR3miuqEdFWjE5g9rLckUjiLMUxGYqQ6wxB1a/OGthgV9t/LLxO2JOcGBwtsLDL
643/Iz2fzpriVb/prMa7ktuKi4bLwC+Xo2d7kxzS6u0DdEvgqP7kuzyA+KshGet1
9iP2C6Gyv4Vb3uLLWTgtRZLCl4QPv/4OI4dVaWOg5ghPhGVmHjuhCYjla7Ez450M
Bj0J8F+2AQgeQYVujx4T2n556LZbzHhZF4JRhhiNJiNCnHB6Ks1+jzKF285rUxIK
sabvzCMdGP9gdxsLOggVs8qaqyZ6gQumrU9rGVNQ+1wa4CCaRkc=
=9/RA
-----END PGP SIGNATURE-----

--rrovo7hu6q2rue63--
