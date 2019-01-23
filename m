From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Date: Wed, 23 Jan 2019 19:34:43 +0100
Message-ID: <20190123183443.ppxdfstmau2xtodi@earth.universe>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2081345286039022973=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============2081345286039022973==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fsyxtax7c7p3uw4j"
Content-Disposition: inline


--fsyxtax7c7p3uw4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
> Add support for additional reset causes and the proper compatibility
> string for sam9x60 SoC. The restart function is the same as the samx7.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  drivers/power/reset/at91-reset.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index f44a9ffcc2ab..44ca983a49a1 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -44,6 +44,9 @@ enum reset_type {
>  	RESET_TYPE_WATCHDOG	=3D 2,
>  	RESET_TYPE_SOFTWARE	=3D 3,
>  	RESET_TYPE_USER		=3D 4,
> +	RESET_TYPE_CPU_FAIL	=3D 6,
> +	RESET_TYPE_XTAL_FAIL	=3D 7,
> +	RESET_TYPE_ULP2		=3D 8,

what happened to 5? :)

>  };
> =20
>  static void __iomem *at91_ramc_base[2], *at91_rstc_base;
> @@ -164,6 +167,15 @@ static void __init at91_reset_status(struct platform=
_device *pdev)
>  	case RESET_TYPE_USER:
>  		reason =3D "user reset";
>  		break;
> +	case RESET_TYPE_CPU_FAIL:
> +		reason =3D "CPU clock failure detection";
> +		break;
> +	case RESET_TYPE_XTAL_FAIL:
> +		reason =3D "32.768 kHz crystal failure detection";
> +		break;
> +	case RESET_TYPE_ULP2:
> +		reason =3D "ULP2 reset";
> +		break;
>  	default:
>  		reason =3D "unknown reset";
>  		break;
> @@ -183,6 +195,7 @@ static const struct of_device_id at91_reset_of_match[=
] =3D {
>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_resta=
rt },
>  	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
>  	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, at91_reset_of_match);

Patch looks fine to me. But I will wait a bit with merging, so that
Alexandre or Ludovic have a chance to provide feedback.

-- Sebastian

--fsyxtax7c7p3uw4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxIs8MACgkQ2O7X88g7
+ppfqg//W5G0xWAA5Nh0Nt4eBrn2o6Gnz1Uqb7Wcx4MXDnz7P7J6AFci+0gzhcXh
KEdebzlE/w4uJK2qQc0DKDZ3I0DCUL97dzQM3zkzkBokaRkj+WkrsIzc3JUxB60d
gPva6cyCWAM6Hq+FvrTlueofDTbKfrLmBEnMv1Is6MXElfzmVUmaa/AG4gqfEbwM
8n44j068IKrfLTxzwCFGzLrS6O8+LWDb8bo1PjfU8JBXYBHKIOBSyXpePFyqQ5/3
lTVDhTl4ApueS/qwX5KeLsT75ryZb0zNomYt2LZx11DI6T/8SnoJDkcgh8HS+E8q
W+7Ea5ZW1Xi8VaWl4kjfFCgPZfzIug63WqVf8I2cWgBlyT7PbTAsrd3WLVSaGZYK
te6mkVNrQSvOBwrt+jhqI66QEB58AJkO+P4BHWhtFWL2+BUGu/ATPEd1de58a+qc
0dKUTBBF2Yy1cWd/CfvBsBH8zzS5vcOuMx0BVzOaOodQK4PJ3BzcvyV5PbNPQ5OO
l+YwoJ/UhKH/Sfvc/PNvBIYCf0Rz1YnsHQGKINMLrY6qh7d2BzYTZKlMamen7e6R
ysvOG2jM4fkuJbGoqfUp3mPKlwvRPJH0drJdkYP8zb1LOhKbKt3JOFBnbwwDN7Xi
Xwrv8ggoRFAUH9bYF5Dv3+aiYr1ApP/9d18+3wYeQnX4roUkhH8=
=AsFe
-----END PGP SIGNATURE-----

--fsyxtax7c7p3uw4j--


--===============2081345286039022973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2081345286039022973==--
