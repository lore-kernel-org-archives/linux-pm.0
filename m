From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: fix 64-bit build warning
Date: Thu, 12 Jan 2017 18:39:21 +0100
Message-ID: <20170112173921.frqgwhqzebs2inoj@earth>
References: <20170111145211.746189-1-arnd@arndb.de>
 <20170112025824.ifplt45l3syibjda@earth>
 <2151755.ZC9SDDZNPX@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="miaev4im5e32ququ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2151755.ZC9SDDZNPX@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen-Yu Tsai <wens@csie.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--miaev4im5e32ququ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Jan 12, 2017 at 09:32:26AM +0100, Arnd Bergmann wrote:
> On Thursday, January 12, 2017 3:58:24 AM CET Sebastian Reichel wrote:
> > On Wed, Jan 11, 2017 at 03:51:55PM +0100, Arnd Bergmann wrote:
> > > Casting a pointer to 'int' is not always valid:
> > >=20
> > > drivers/power/supply/axp20x_usb_power.c: In function 'axp20x_usb_powe=
r_probe':
> > > drivers/power/supply/axp20x_usb_power.c:297:21: error: cast from poin=
ter to integer of different size [-Werror=3Dpointer-to-int-cast]
> > >=20
> > > This makes the code use uintptr_t explicitly.
> > >=20
> > > Fixes: 0dcc70ca8644 ("power: supply: axp20x_usb_power: use of_device_=
id data field instead of device_is_compatible")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> > I queued Michal's patch instead:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git=
/commit/?h=3Dfor-next&id=3D15df6d98ec3b40775918fc6ef73d7f1c2d0cf870
>=20
> Hmm, that doesn't look right: You can't really rely on an 'enum' type to
> have a specific size, especially not the same size as a pointer, in porta=
ble
> code.
>=20
> IIRC on many architectures it defaults to 'int' rather than 'long', and
> it might also be 'short' on architectures that default to enums being
> the smallest integer type that fits.

gcc does not generate warnings as far as I can see and the precision
loss itself is not a problem in this case, since we only store the
enum values in the pointer anyways.

I don't mind adding the uintptr_t cast. But in that case it should
probably be added in a few other places, too:

$ git grep of_device_get_match_data | grep "(enum"
drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:		adv7511->type =3D (enum adv7=
511_type)of_device_get_match_data(dev);
drivers/i2c/busses/i2c-rcar.c:	priv->devtype =3D (enum rcar_i2c_type)of_dev=
ice_get_match_data(dev);
drivers/net/ethernet/renesas/ravb_main.c:	chip_id =3D (enum ravb_chip_id)of=
_device_get_match_data(&pdev->dev);
drivers/pci/host/pci-imx6.c:		(enum imx6_pcie_variants)of_device_get_match_=
data(dev);
drivers/power/supply/axp20x_usb_power.c:	power->axp20x_id =3D (enum axp20x_=
variants)of_device_get_match_data(
drivers/reset/hisilicon/hi6220_reset.c:	type =3D (enum hi6220_reset_ctrl_ty=
pe)of_device_get_match_data(dev);
drivers/usb/phy/phy-msm-usb.c:	pdata->phy_type =3D (enum msm_usb_phy_type)o=
f_device_get_match_data(&pdev->dev);

--Sebastian

--miaev4im5e32ququ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh3v0YACgkQ2O7X88g7
+prpJA//bwr93vgBYt7R8o+YgVSwi8GAM+TmiCQXc5yetRpx7Sb8FKtZjLVEj9VQ
7sID3k9W45nf+NYGXCJNeHHDBc5oNB8+hVw8nHYdZKIWQ33eTyPQqRB+uO4YA22g
gPpVLNqco3H37FX115HsKqg+XhnUynnmIoY6QXtGvlstuLh/to282dyxxD+lRPTl
dcNBdu9lNa6+/WR7EGLNzYulu2EVOMuBvdxqN++l2Xuw7a79Wtnr2AKKHI4Y/VJI
0WlE4xjwOwBDQsM1Dncvj+TYVUFcS5LJo4sR3I780RQavJ3x+442yXiIslx+ncKl
S5LFBvtRdPD2wr8g1jLoYkSor3QvkMeY7UeIHr4xL93bzGzkoSMI9fXUUhG/uQAO
R4vk+2tfgkuJ7ncugLoPDXRaUo7oD6cVr4GxDc94Iss7XDeNLa2t1ljBrBvv91oW
969NUrT88Rvmqb1ypDQvO7UFRUA+ISDmyU8g0Jo5NS/JSslVGJ4u5Blf+B76YjNT
RGU1vp/qrRl5wChoB1xYqCbdE6GiQz6UB9GeVSG4t2Y5KuSov35yY5MaK6Wdm8Lq
5iiWosVRyRQnLsNgjxs8PXr/xwxLzg7VJ4V54dzVWdOicI0Q6Owc4Q+p+ny0U3Br
hJ9jVkeq3mTjt7uuw9XAFOn5ntAOlBnLEgQoDuGyTbfCdady0uY=
=D7aB
-----END PGP SIGNATURE-----

--miaev4im5e32ququ--
