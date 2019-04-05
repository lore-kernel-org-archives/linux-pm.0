From: sre <sre@kernel.org>
Subject: Re: [PATCH] power:ds2782:Fix description error
Date: Fri, 5 Apr 2019 17:58:50 +0200
Message-ID: <20190405155850.j3f35qiov7hg5pfo@earth.universe>
References: <tencent_408CB7922C1972D02ACDB8E48E4218092507@qq.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdhbftm6bszhjotw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <tencent_408CB7922C1972D02ACDB8E48E4218092507@qq.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5b2t57qi?= <elicec@foxmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--hdhbftm6bszhjotw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2019 at 04:32:29PM +0800, =E5=BD=AD=E7=BA=A2 wrote:
> After add support for ds2786 battery gas gauge=EF=BC=8Cthe description
> didn't update. fix it.
>=20
> Signed-off-by: HongPeng <elicec@foxmail.com>
> ---

The patch does not apply due to a spelling fix in the description
(Gauage -> Gauge). Also your name in From does not match the name
in the Signed-off-by (SoB) and the one from SoB seems to miss a
space.

-- Sebastian

>  drivers/power/supply/ds2782_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply=
/ds2782_battery.c
> index a1b7e0592245..924e99d1e69e 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver =3D {
>  module_i2c_driver(ds278x_battery_driver);
> =20
>  MODULE_AUTHOR("Ryan Mallon");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC drive=
r");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2782/DS2786 Stand-Alone Fuel Gauage I=
C driver");
>  MODULE_LICENSE("GPL");
> --=20
> 2.17.1

--hdhbftm6bszhjotw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynezoACgkQ2O7X88g7
+por0xAAhqSxQkhQqPwnHJq9mNddmBX/H6tS91EL0bhP4jIUTuXnZ9lEzlxdnnbP
IV6GfrDOI89JtwvfxhiWXTMqUrm9XK/A9eTPcin+li98pF05eQ0btM1/kL9b9Soe
KMiwW/ZElYr/oxkwQE+gB+uIdCQA0SpH9x/EPRKLGjSUSntytsyyR4kcnJYy8UW9
Jlg7KGB9e27KZKBnuDBg8XBKttdddVXjcotwupJXP7VnG/Sz1xuvpg03QOtsmB9d
ixL1fbWhbz6FJeg5BZgxLOaLkoz86BH68WjxPVhBqiggZHLvTil0MbIXyaluy/n4
ppDUdb5RKMpq13+EvD7LyxprLWqcanfAklm35Eo6lJ+fL+4M8JMptbMd8IPF2sPG
FIpn4+cGZErsF4j0TO9GQNZG6pnc+/ICbIyNvJLESyX1hOYetM3K81eC3MkAPpMV
AQJRrJMHFPlcJv/d5bXwhOiDlayUpVMlC/BE61TKH6fCfS1yA5i3wYECX7OucM/p
9MIeYO4Gx2UpUi+buCKWfHk6+s1C3UucdThRRZcNah438cp1h40QR1zwEkWcaiby
tRzV27LcCe/yMIUVYQSyIDvdh/R+6MtAAGIJcPyUxs7stZA96T7Q8yO5wQbh+Tsc
XJFhzKR1JZ8hlf+Nz6rViJzm5pCM0KYvlyjDlvVNYRGIC+Euc7w=
=lVby
-----END PGP SIGNATURE-----

--hdhbftm6bszhjotw--
