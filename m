From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: reset: zx-reboot: add missing
 MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri, 1 Dec 2017 16:28:25 +0100
Message-ID: <20171201152825.qedjiscaihhiovww@earth>
References: <20171120205827.88610-1-jc@linux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brcg7mrw4r5y272a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171120205827.88610-1-jc@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Chan <jc@linux.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--brcg7mrw4r5y272a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 20, 2017 at 12:58:27PM -0800, Jesse Chan wrote:
> This change resolves a new compile-time warning
> when built as a loadable module:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-rebo=
ot.o
> see include/linux/module.h for more information
>=20
> This adds the license as "GPL v2", which matches the header of the file.
>=20
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.
>=20
> Signed-off-by: Jesse Chan <jc@linux.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/zx-reboot.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reb=
oot.c
> index 7549c7f74a3c..c03e96e6a041 100644
> --- a/drivers/power/reset/zx-reboot.c
> +++ b/drivers/power/reset/zx-reboot.c
> @@ -82,3 +82,7 @@ static struct platform_driver zx_reboot_driver =3D {
>  	},
>  };
>  module_platform_driver(zx_reboot_driver);
> +
> +MODULE_DESCRIPTION("ZTE SoCs reset driver");
> +MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.14.1
>=20

--brcg7mrw4r5y272a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohdRkACgkQ2O7X88g7
+ppf6g//YI2/xnERMLUw+OD+sO6gQUFi1gs186udUIh2tRWJTu7Y1waik/q2vj3/
g1T6/49jhQMgoY43vAMbeYqgQXdwu1GroHhoLgpnMkBsbV8gWCEztu90uX3tbMgq
NDKabD4pkXLjvD7huTc2diwjJQ14e5zeKY1wF0FhNN1SaWHR5Z89eXwpiYbyzYc6
lw/4q05U7T1RGLkjjgIIz6+5mxgecrzAVGb+h3XOy1F+9DlpQUEPMr3ouerjYyO2
4XiGxNxE/w2pD4KJtalteTA2MiiF+uQOoRL9jm4qhK6OloMNHSAeOvuXX9EWPBe9
Qj9OcXn6xJHNcrYkRfXj1eL8OfJws3i9WkUaKtgXGdWbMdjpNHrnnr3MPIYFlgOr
cVTrMLkuERaHjB4G3lmVFl+iPiYX0l/YbTtwQkEdDFUhQxYEFNcx1zzw9U8CuzxX
3ifu0vqw0aD2AfhQ9ASVfEoh9UiZ67bLfhzWhiPJ5mjGHqdQKZc0UOt9QB7LJCa9
UHoFpQqKZpDMqI+1dDLB08wGNtYo6JtiWNmDNI/hCvVNdtRvUIkvpB6IpFEm6qMk
/0+5onxjNsWL+LgW3XuhEejWkIl7VyJcNT/OBPTQ+fB4ZewCtqBzcmeSG0cwsAUQ
Qp0nq8Ugic6npJ5Y76HG74W9eQjUWoEu6jsest6oPnGhIZt/DPY=
=1OSe
-----END PGP SIGNATURE-----

--brcg7mrw4r5y272a--
