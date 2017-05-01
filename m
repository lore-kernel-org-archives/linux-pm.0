From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 14/14] power: max77693_charger: Add supplied_to info
 to power_supply_config
Date: Mon, 1 May 2017 14:19:56 +0200
Message-ID: <20170501121956.2hs25fogp5eeuubh@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6tv32s3yagqaazi6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57811 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968802AbdEAMUA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 08:20:00 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-14-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--6tv32s3yagqaazi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:59PM +0200, Hans de Goede wrote:
> On the exynos4412-trats2 the max77693 is used together with a
> max17047 fuel-gauge.

exynos4412-trats2 is DT based, so it should use the method
described in Documentation/devicetree/bindings/power/supply/power_supply.txt
to describe the supply chain.

-- Sebastian

> Add supplied_to info containing "main-battery",
> so that the get_status code in the max17042_battery driver can use
> power_supply_am_i_supplied and can properly let userspace know
> if the battery is being charged or not.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/power/supply/max77693_charger.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supp=
ly/max77693_charger.c
> index 6c78884..1eeed26 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -254,6 +254,10 @@ static int max77693_charger_get_property(struct powe=
r_supply *psy,
>  	return ret;
>  }
> =20
> +static char *max77693_charger_supplied_to[] =3D {
> +	"main-battery",
> +};
> +
>  static const struct power_supply_desc max77693_charger_desc =3D {
>  	.name		=3D MAX77693_CHARGER_NAME,
>  	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> @@ -697,6 +701,8 @@ static int max77693_charger_probe(struct platform_dev=
ice *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	psy_cfg.supplied_to =3D max77693_charger_supplied_to;
> +	psy_cfg.num_supplicants =3D ARRAY_SIZE(max77693_charger_supplied_to),
>  	psy_cfg.drv_data =3D chg;
> =20
>  	ret =3D device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);

--6tv32s3yagqaazi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHJ+kACgkQ2O7X88g7
+pq8rBAAjHci8zNA8m/hWbz9o7giYrNhspx9CXIskuSo6526k/+8YLLxcxcAwPaq
4YimsbuG2DX7U+a8hyNltWsZRsomSBPXIsWzUzJ9bptscAPrNmrdP7BSz1TV2PWY
jTEvn4TbR7IhL2c1oV3YB7JB5WmrhUrt5HPA57TCCc3kfZQAQuNcFe7EpMJePRjr
BPObRYc2McQGqHr2JwTT23ALr4kbZUNrrQMxyujQAgdAz9KDVhmfSLb++fCp+uEa
PPh4bhCXb5hgoXWkjT+eSTkslWlw0GdS4FVxMn3MnnFsJK1is6Hk+3SCduy3aLbG
kii22vPtskLjts7CrlY81dxFPnP5hNUhKoxVhGJjwL2X00oo+eV6VNbjxDFCvZC+
qjA84u6Af4aFe0L6IlDHSZaoQCWJlSsh9sBWoBNwCldUzqWjm2m2USX0yu4ypO7i
GKexWjego+zkYXQKNYOOdnLNp4wm1H0NNzCSen/IKxiT1S9dooYQd0JfLB903pUC
xs0vhd0x0Mu+JR6iSG3KUgJ8ajOpvQ4zB9WfTmpLddZ9V5WBxmqdimLCI8ybjk9m
u+MSjjUJKG4Ph3h6o9gbuWvxvdpwBtFT4pvMwZgZsNiyZeSMV4FAtncxEQFJ1pHO
ITl7kqp3HWjjgzTn1SxPV9W9H/yv+ChZfJ4UtPBOdFXuwmHi48Y=
=R9wu
-----END PGP SIGNATURE-----

--6tv32s3yagqaazi6--
