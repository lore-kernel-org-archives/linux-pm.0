From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: imx_thermal: add module device table
Date: Wed, 18 Dec 2013 10:47:35 -0400
Message-ID: <52B1B587.3050106@ti.com>
References: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9157536177390970224=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Sascha Hauer <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============9157536177390970224==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l57v44BAC6BStowmvBUomih239IaRB6ff"

--l57v44BAC6BStowmvBUomih239IaRB6ff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16-12-2013 17:50, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
>=20
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/imx_thermal.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
> index 1d6c801c1eb9..230864886775 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -522,6 +522,7 @@ static const struct of_device_id of_imx_thermal_mat=
ch[] =3D {
>  	{ .compatible =3D "fsl,imx6q-tempmon", },
>  	{ /* end */ }
>  };
> +MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
> =20
>  static struct platform_driver imx_thermal =3D {
>  	.driver =3D {
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--l57v44BAC6BStowmvBUomih239IaRB6ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKxtYwACgkQCXcVR3XQvP1zfAD/eJLpC9cHs4VciTUQHcp8vGIL
W3Cgxe9XrGaaQkK4Qd4BAJF3gvZD8ffL1+yBQ4KciZEm+Wgs7hfxNv8lmKiBRAyl
=INvJ
-----END PGP SIGNATURE-----

--l57v44BAC6BStowmvBUomih239IaRB6ff--


--===============9157536177390970224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9157536177390970224==--
