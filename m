From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: power_supply_read_temp only if use_cnt > 0
Date: Sat, 4 Jun 2016 15:30:23 +0200
Message-ID: <20160604133022.GA31801@earth>
References: <1464985850-12365-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464985850-12365-1-git-send-email-rklein@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rhyland,

Thanks for the patch.

On Fri, Jun 03, 2016 at 04:30:50PM -0400, Rhyland Klein wrote:
> Add check to power_supply_read_temp() to only use the power_supply
> get_property() callback if the use_cnt is > 0. The use_cnt will
> be incremented at the end of __power_supply_register, so this will
> block to case where get_property can be called before the supply
> is fully registered. This fixes the issue show in the stack below:
>=20
> [    1.452598] power_supply_read_temp+0x78/0x80
> [    1.458680] thermal_zone_get_temp+0x5c/0x11c
> [    1.464765] thermal_zone_device_update+0x34/0xb4
> [    1.471195] thermal_zone_device_register+0x87c/0x8cc
> [    1.477974] __power_supply_register+0x364/0x424
> [    1.484317] power_supply_register_no_ws+0x10/0x18
> [    1.490833] bq27xxx_battery_setup+0x10c/0x164
> [    1.497003] bq27xxx_battery_i2c_probe+0xd0/0x1b0
> [    1.503435] i2c_device_probe+0x174/0x240
> [    1.509172] driver_probe_device+0x1fc/0x29c
> [    1.515167] __driver_attach+0xa4/0xa8
> [    1.520643] bus_for_each_dev+0x58/0x98
> [    1.526204] driver_attach+0x20/0x28
> [    1.531505] bus_add_driver+0x1c8/0x22c
> [    1.537067] driver_register+0x68/0x108
> [    1.542630] i2c_register_driver+0x38/0x7c
> [    1.548457] bq27xxx_battery_i2c_driver_init+0x18/0x20
> [    1.555321] do_one_initcall+0x38/0x12c
> [    1.560886] kernel_init_freeable+0x148/0x1ec
> [    1.566972] kernel_init+0x10/0xfc
> [    1.572101] ret_from_fork+0x10/0x40

So I guess this should be backported to stable kernels.

> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> ---
>  drivers/power/power_supply_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supp=
ly_core.c
> index 456987c88baa..070fec621d66 100644
> --- a/drivers/power/power_supply_core.c
> +++ b/drivers/power/power_supply_core.c
> @@ -561,11 +561,16 @@ static int power_supply_read_temp(struct thermal_zo=
ne_device *tzd,
>  {
>  	struct power_supply *psy;
>  	union power_supply_propval val;
> -	int ret;
> +	int ret =3D 0;

ret should probably be initialized to -EAGAIN to avoid val being
interpreted without get_property() having been called at all?

>  	WARN_ON(tzd =3D=3D NULL);
> +
>  	psy =3D tzd->devdata;
> -	ret =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
> +	WARN_ON(atomic_read(&psy->use_cnt) =3D=3D 0);

I guess the warning can be dropped if error code is properly reported?

> +	if (atomic_read(&psy->use_cnt) > 0)
> +		ret =3D psy->desc->get_property(psy, POWER_SUPPLY_PROP_TEMP,
> +					      &val);
> =20
>  	/* Convert tenths of degree Celsius to milli degree Celsius. */
>  	if (!ret)

-- Sebastian

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUtfsAAoJENju1/PIO/qa1FQP/iArftuGwfoaEbNK8jiTeUc8
edF5ItILIxci2mQyKXQ21c0c1Tve8RWdcT1LP13hjJxskhSp/zj4AH2m2a4co210
+2r4FJyBxyvq9F/We9ki92mXC/4mdX0dASymhEoP95KVRRH69E7TfdicgedYl9e0
XfylgqFKj02v0bHziwJhJougN3fi0mBS9DSeSZ31Zbbo7+yYvqSoLW+jJll6F6/Z
IofV5qkQEOO1pKOiu0ZJZQUCKyvLF7PTD+7OrJ0L94kHC6acIVCR0ZtpNNT1181r
KVhaw/Uf4xgB3fxjP4QQVxizJ+Rw7tN9II8Al4xC1s50sQucq/7xo6jvWrRCzAVK
YNgny/FfyFhEgdMaXMim/f+VDdWE3JNim2JyADY9G9rSt3oQFa0Eec9WOau92CvB
vjHeAv47V9TAmcOCUO0PFY0Jap5JBftDB6p+lOk7hE1n7HhqBHpMbe1+ER6FyMrV
hTDmT97U+6tv1Iav7JoamKn17v0TCkVZ2pIABUoVJXLPoqlfLFz1Xf6qi7YUAiCA
uY/4Jb2Im0RY+qoFKq7tgcsp4NM/J+evLQbxnety0Sbea9L/mARJ8bfvVeLqkAy5
cPFiydeKF7jGb5ktnOJkJ2fszdQD1HZL1/atyCgHFaWoUKgcKQSL5JD1n6l8JdQ0
Yfaf7xkcLAKbBz+n1b7q
=idYM
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
