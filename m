From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: msm: Clarify restart and poweroff
Date: Tue, 9 Jan 2018 17:20:09 +0100
Message-ID: <20180109162009.nphafbo2rk6osenz@earth.universe>
References: <20180108033313.13538-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="puz6l5fmd7dyhiqw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108033313.13538-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--puz6l5fmd7dyhiqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 07, 2018 at 07:33:13PM -0800, Bjorn Andersson wrote:
> When PSHOLD in a Qualcomm platform is deasserted the PMIC will perform
> either a power off or a restart of the system. The action to take is
> configured in the PON block, which is controlled by a separate driver.
>=20
> As the configuration logic was added to the pm8941-pwrkey driver the
> comment in do_msm_poweroff() is no longer valid and the name
> do_msm_restart() is misleading. Update the naming and drop the comment.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/msm-poweroff.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm=
-poweroff.c
> index 4702efdfe466..01b8c71697cb 100644
> --- a/drivers/power/reset/msm-poweroff.c
> +++ b/drivers/power/reset/msm-poweroff.c
> @@ -23,7 +23,7 @@
>  #include <linux/pm.h>
> =20
>  static void __iomem *msm_ps_hold;
> -static int do_msm_restart(struct notifier_block *nb, unsigned long actio=
n,
> +static int deassert_pshold(struct notifier_block *nb, unsigned long acti=
on,
>  			   void *data)
>  {
>  	writel(0, msm_ps_hold);
> @@ -33,14 +33,13 @@ static int do_msm_restart(struct notifier_block *nb, =
unsigned long action,
>  }
> =20
>  static struct notifier_block restart_nb =3D {
> -	.notifier_call =3D do_msm_restart,
> +	.notifier_call =3D deassert_pshold,
>  	.priority =3D 128,
>  };
> =20
>  static void do_msm_poweroff(void)
>  {
> -	/* TODO: Add poweroff capability */
> -	do_msm_restart(&restart_nb, 0, NULL);
> +	deassert_pshold(&restart_nb, 0, NULL);
>  }
> =20
>  static int msm_restart_probe(struct platform_device *pdev)
> --=20
> 2.15.0
>=20

--puz6l5fmd7dyhiqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU67MACgkQ2O7X88g7
+pp+pQ//Wj3l//EaFxrmONoOTGzBLn9AkJCRT+mj/KxDjTMldevCI43UCnqOF1h6
Dw9vnnWJKlkwFItfQJNLVh86nw/uSdcAwPWL5+JMoZsr1GWwuVao2DP/VyMkmvxT
o8XVKAy8goS+CzRCMuwBNiwB90Ck8IYetYZuixqO16x6GtxMQn9hG1Vdp7yGhva2
VT/uJy5SORnon7E/zW+qObFHXm1hOdLmNqZD5kf3OAJGw9SLt7sSt6X35RrevSYj
AsUfM1qcsAJJvTWEE5euQaXVhjNgfWs1qyqwUs+yREX+znWy7gk3AqON+IoBMwV3
MeYms27J88Oiffg5FAqw9fYKJ+HGC2MGMXEbKoxSkwZK8CXpfc6QvgZUcgvAKIWZ
ZTQiluGFSS3ui9WpHMGvQ466gxFZt/2VZTUXB7JWG633rZHnMO3ENODzdpF0lbX3
vo1tqvuf+7clCijpBxKWzBRhwFr9CG8Yyhp1Jer42okMfJ+NVQyXjyin41ULjIQl
Q3zST5Yg0XU6RjMBcze7m9+qr9VXVECKHpC9awV5jTxXrfnC8NS6yHQ9+hdc9kvf
ij+GdO8qBsqo77IMwqEDLlgFON/MTLJfmMBpaylawUM1zYdqdT+O7hWFSAy6+ppM
PX+e9HWS2ILOFYV07J7/EaDXqMp8d13i8f2RjX6ij49uj+WFDwg=
=MIaa
-----END PGP SIGNATURE-----

--puz6l5fmd7dyhiqw--
