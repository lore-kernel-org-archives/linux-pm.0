From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
Date: Sun, 20 Jan 2019 22:23:26 +0100
Message-ID: <20190120212326.6kk4tcpzs6ytlvho@earth.universe>
References: <20181122142551.25367-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ovmzsfkld3ku7wlo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122142551.25367-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: hdegoede@redhat.com, wens@csie.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ovmzsfkld3ku7wlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2018 at 09:25:51AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Thanks, queued to power-supply-next. Sorry for the delay, I missed
this when I collected patches for the 5.0 kernel.

-- Sebastian

>  drivers/power/supply/axp288_fuel_gauge.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/sup=
ply/axp288_fuel_gauge.c
> index 084c8ba9749d..9ff2461820d8 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -307,22 +307,12 @@ static int fuel_gauge_debug_show(struct seq_file *s=
, void *data)
>  	return 0;
>  }
> =20
> -static int debug_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, fuel_gauge_debug_show, inode->i_private);
> -}
> -
> -static const struct file_operations fg_debug_fops =3D {
> -	.open       =3D debug_open,
> -	.read       =3D seq_read,
> -	.llseek     =3D seq_lseek,
> -	.release    =3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(fuel_gauge_debug);
> =20
>  static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
>  {
>  	info->debug_file =3D debugfs_create_file("fuelgauge", 0666, NULL,
> -		info, &fg_debug_fops);
> +		info, &fuel_gauge_debug_fops);
>  }
> =20
>  static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
> --=20
> 2.17.0
>=20

--ovmzsfkld3ku7wlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE5ssACgkQ2O7X88g7
+ppAWA//Wxt0SzuHUUfk6z2Z1e/IO5kyxalrUCImNkjSTgb1aNxc779EHweTgpKu
pGUdSiBlpPcOa8CgtozABrKlHjmmRFYWRcfVxGogZyCQBt2mQwgW/TbS3pHUN8Sr
VnQrAv+cf0g3M5c6WnPguvOVvLao/zwwymvQqqDPNvoYDrrS4oOP0InlE4uhSIfP
LyPToq0PkWaImWHB/mr5Y7iy79b4qkKe744nJtDlbroVSvESmktGIdQ4vaiJhc10
yvLppZMm0CmU2IrjQtNQYgnWssTRUrfZ/JJ0a8t1lT3W69n0J05X9vZrC5kGaTyD
ovyixjLt8Fwcw9EZC+YlKunMoUYiUc7mD5U3ftbuxSxWbAnCds3tqiNf2XoqIkUr
JYa4azZy+S9Gm1io6ySja3HSjgG0NBrkVitjSC5nqKD9S3bQY8eaUkA5iib3n5oZ
UEv/0eRlfHngl+FVIBjeM1RNeRSLY/70hwON9skYG7RuA6GnYPNpxXVW0Z1WAYeO
8S+Omo01WNdu1pBwN/qqVVa8AFBH6BUXxCHObo7z6Ef0AGwZS3B0tpboe1UZuTwn
F3x32rPyYG0DHVEcr5uH0FKXwfo6n9hnADoXsVFhbVdN+si3PUXvOV/EDSaksN1L
Wvkcu4u+QT60Wda/tTNA542Rrhw0WFW3/4nsdWciaGZJGdznd8w=
=uac3
-----END PGP SIGNATURE-----

--ovmzsfkld3ku7wlo--
