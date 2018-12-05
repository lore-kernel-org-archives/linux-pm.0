From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/6] power: supply: charger-manager: Fix some misspelled
 words
Date: Wed, 5 Dec 2018 21:36:13 +0100
Message-ID: <20181205203613.e7yh6osdd45jy333@earth.universe>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <24406bab7e6b694c8eeb621c450ea7b039beb1d8.1542362262.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bq2cof3jepmsp6g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24406bab7e6b694c8eeb621c450ea7b039beb1d8.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org


--7bq2cof3jepmsp6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 07:01:09PM +0800, Baolin Wang wrote:
> Fix some misspelled words.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index a1b420a..bd6c450 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -363,7 +363,7 @@ static int try_charger_enable(struct charger_manager =
*cm, bool enable)
>  	int err =3D 0, i;
>  	struct charger_desc *desc =3D cm->desc;
> =20
> -	/* Ignore if it's redundent command */
> +	/* Ignore if it's redundant command */
>  	if (enable =3D=3D cm->charger_enabled)
>  		return 0;
> =20
> @@ -1799,7 +1799,7 @@ static int charger_manager_probe(struct platform_de=
vice *pdev)
> =20
>  	/*
>  	 * Charger-manager is capable of waking up the systme from sleep
> -	 * when event is happend through cm_notify_event()
> +	 * when event is happened through cm_notify_event()
>  	 */
>  	device_init_wakeup(&pdev->dev, true);
>  	device_set_wakeup_capable(&pdev->dev, false);
> @@ -2019,7 +2019,7 @@ static void __exit charger_manager_cleanup(void)
>   * cm_notify_event - charger driver notify Charger Manager of charger ev=
ent
>   * @psy: pointer to instance of charger's power_supply
>   * @type: type of charger event
> - * @msg: optional message passed to uevent_notify fuction
> + * @msg: optional message passed to uevent_notify function
>   */
>  void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
>  		     char *msg)
> --=20
> 1.7.9.5
>=20

--7bq2cof3jepmsp6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwINr0ACgkQ2O7X88g7
+pqtyg/+Ib6d3mzW/lvnhpDMQWuuan77lnvNut/qNgwDBKB/IvN/YlS0OERQvlM3
+ZYThQnQhINCqgVc89DArutGO2Wsj8q6Ziy0Ke1s6kTx+0MMYk123OJL/bpqtGgy
Yk++gftwtdAoNG46UqO+daMgZTiOsRwP2G7IsTUt12ulzlBH36O2ssuXUfBc43ev
aSF5b5ADD6Y5dT/I/Ryji2myKZhi9u39dx2ipv8xQkxqAIFUmkk9k5r4e8zIWA7b
oZElfkaQPVsbJgeBLpL10sSjvcYemAjLvgdmjDog11ylUpJsNTWFpQHIEW1GXmvO
aiacLSKJmiAUfB6QFJzCx7QkDurlM2ssCa2kiJryn2WzQUhwRbFhP/Ajw5mpUKWR
kkVt5eYw+mJeUinKtehgST96i7QyhcNU3iwufRZs+qsf6h/yQ9y/ic+b6kLJ5w25
wM9+uqC3t3iJ3axOegQvfRTmIya5Y0RCK1C7OCv7dsh++PX1jInjcvI155gcQVG4
NZ3jLoUynHOvVnHTD0Lv4zDUc5FArzuTu7kuuqnOA6KVPJECa+LmjNTDpCGDmpC/
VoO/ifPZN75eN+heMj2m4jYn6KLqPLcJRAQhTMaxR5Zm6Yy7AQorNbvQO4bxhfpT
VThPd25ePyUlNemLHx2N02uaHTwa48plMtRum+7fj7TEyZmpFas=
=XdUA
-----END PGP SIGNATURE-----

--7bq2cof3jepmsp6g--
