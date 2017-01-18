From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] power/reset: at91-reset: add samx7 support
Date: Wed, 18 Jan 2017 05:48:24 +0100
Message-ID: <20170118044824.4inln4m2gj2xioob@earth>
References: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1870272987104954072=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: =?utf-8?B?U3plbXrFkSBBbmRyw6Fz?= <sza@esh.hu>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============1870272987104954072==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kviadeebh7bad6ha"
Content-Disposition: inline


--kviadeebh7bad6ha
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Wed, Jan 18, 2017 at 12:07:37AM +0100, Alexandre Belloni wrote:
> From: Szemz=C5=91 Andr=C3=A1s <sza@esh.hu>
>=20
> Add samx7 support. It is lacking a few bits and needs a new reset functio=
n.
>=20
> Signed-off-by: Szemz=C5=91 Andr=C3=A1s <sza@esh.hu>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-reset.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 568580cf0655..bb2588f0a4c7 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -134,6 +134,15 @@ static int sama5d3_restart(struct notifier_block *th=
is, unsigned long mode,
>  	return NOTIFY_DONE;
>  }
> =20
> +static int samx7_restart(struct notifier_block *this, unsigned long mode,
> +			 void *cmd)
> +{
> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PROCRST),
> +	       at91_rstc_base);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static void __init at91_reset_status(struct platform_device *pdev)
>  {
>  	u32 reg =3D readl(at91_rstc_base + AT91_RSTC_SR);
> @@ -173,6 +182,7 @@ static const struct of_device_id at91_reset_of_match[=
] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_resta=
rt },
>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_resta=
rt },
>  	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
> +	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, at91_reset_of_match);

Thanks, queued into power-supply's for-next branch.

-- Sebastian

--kviadeebh7bad6ha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh+85UACgkQ2O7X88g7
+po0Zw/9EXz1gJuoyQnsKSsJ3MjqbG8gIGUXZSGAJxjOmuFcZy1FdOA/Bm+WKS+L
Gd8hbevJvKhUlDZNzEWr8k20CHsrvm1qnrQEVoR4u42yBqnZmpLo2JDm5mkgA5+d
r1Pk4bYp4tNz6PzYMvvJ40kV7y0AWR6AZ39V/+sgX5A+4FCM8Ou5xGNxDUwk8Ftk
8EYBn9O6q2CRO2Wpo3qQA9nNYbgwk5IowrGlJg5lZbEWfFZ5B6rc+goxXaPPeETy
ydUChr9GunxkhwPHfTxwmxt/CDDHknnYWcRFVnjJGFfQoHtacGWhTWlQvKsj/Prl
TAzHxglvtGG/WXLg0dcONs0TG6BBuCr967vJ2IaIrkwWzufU+W6frLRnT8TTZDga
wHBJ1BHieOxuqDfzOEJDsPoUL1EItnsE95/YxxBBWPmZHotXAwWFpyP+oCxXzqZX
1vJtASJoKA0+1gCPn83s+D637tufRa37MRzDcUFcTkexlq0hJRWjA2fmJBm+Rwen
+xivLPAESpalrtYFL2BLi7eYIeEn47KMuvtZZA/+1fWb8HKeIMTvns4rsxLx3XHF
6sfI8pqBJlmzDQP1G/rsHoEWZ/rY26Sc4JNNIg+jYBcLYTA57N4+QVc8aCZBDbKd
64FNukuj3z+sLU6I4Y8OOad1upBtYFpE39BL1Azo7LeEpg4RZZU=
=V6xe
-----END PGP SIGNATURE-----

--kviadeebh7bad6ha--


--===============1870272987104954072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1870272987104954072==--
