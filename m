From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: Replace mdelay() with
 msleep() in gpio_poweroff_do_poweroff()
Date: Thu, 30 Aug 2018 00:44:09 +0200
Message-ID: <20180829224409.buwhrlaxxwtenqh6@earth.universe>
References: <20180730134614.9016-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d24bfuwqavo4azyo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180730134614.9016-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--d24bfuwqavo4azyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 30, 2018 at 09:46:14PM +0800, Jia-Ju Bai wrote:
> gpio_poweroff_do_poweroff() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
>=20
> This is found by a static analysis tool named DCNS written by myself.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---

Please self-review the results from your tool before sending.
This is a shutdown driver.

-- Sebastian

>  drivers/power/reset/gpio-poweroff.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index 6273ad3b411d..bbe55cfa87d0 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -33,16 +33,16 @@ static void gpio_poweroff_do_poweroff(void)
> =20
>  	/* drive it active, also inactive->active edge */
>  	gpiod_direction_output(reset_gpio, 1);
> -	mdelay(100);
> +	msleep(100);
>  	/* drive inactive, also active->inactive edge */
>  	gpiod_set_value(reset_gpio, 0);
> -	mdelay(100);
> +	msleep(100);
> =20
>  	/* drive it active, also inactive->active edge */
>  	gpiod_set_value(reset_gpio, 1);
> =20
>  	/* give it some time */
> -	mdelay(timeout);
> +	msleep(timeout);
> =20
>  	WARN_ON(1);
>  }
> --=20
> 2.17.0
>=20

--d24bfuwqavo4azyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHIbkACgkQ2O7X88g7
+pqGYw/9HaMKnSUSSWlu/+BT3IKRIzJoiYBLcYT9k/Jkfglz8U4mvVuSV9U6SYc2
c/FBt3598DPiXCa+SL5Ux2op+MSj0yPiKgDo/+ICvItwxVHv6nLp7prOj74AiWil
Ib4xPNDtJNhJtnlaz2g14BmtRbFfv8mbG5PxBfh8Pyssp8Asu3pf3PALGJL2R3nG
eZ6Fi3ovJ4zJp/czxMv898y7aKqMBpBPV+/eRK94v8AUnNfRwkt12+Ctz5OlWWvc
LJ+viv65nOtyntmV52h03iSW1DfiohwbQEmCLN2Rgypl7AEHlbrM+wd6/ZS+RJDd
gPZBYOh/d7xLOYwDmQwQCvUVsTu8luMH8TPFTZ449U18x0CL9Cxyh4eRaVWZeNeB
K+4Oa2H9kFxW3DJAtXwFLpNLqH9NIoWD0EYkpKiQL8844KoCLWAJ+PPGJKetRL55
ajLAnJuuF+Lq/kQzhGREAEIs9RoajyaEuxE5pWnFS1YQVdutFdJuPMxwzAiVkMmO
zm2l1pixR1iMdPsj/mBX7F8lMKw/10UdpayGrNNUpgzahC57rvfQdlnlLla6J3a/
z1R6N2OgcP5I1mqoITD9MMo9tLSBFivmWnUQJI7G5Ju/J5KsRVTuy2wNI8YnS9Fw
9jFlds4sBdiA+OWGjh3tIwew+1+0Ak/J13YW1pKPrKSH3QMN0js=
=u4Qt
-----END PGP SIGNATURE-----

--d24bfuwqavo4azyo--
