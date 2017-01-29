From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: max14656: Export I2C and OF device ID as
 module aliases
Date: Sun, 29 Jan 2017 16:43:31 +0100
Message-ID: <20170129154331.3kq3ktenc5dmdkxa@earth>
References: <1485351535-21066-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzbz3b73z3thnsse"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485351535-21066-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--qzbz3b73z3thnsse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Jan 25, 2017 at 10:38:55AM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, I2C module alias information is not
> filled so the module won't be autoloaded. Export the I2C and OF devices
> ID to the module by using the MODULE_DEVICE_TABLE() macro.
>=20
> Before this patch:
>=20
> $ modinfo drivers/power/supply/max14656_charger_detector.ko | grep alias
> $
>=20
> After this patch:
>=20
> $ modinfo drivers/power/supply/max14656_charger_detector.ko | grep alias
> alias:          i2c:max14656
> alias:          of:N*T*Cmaxim,max14656C*
> alias:          of:N*T*Cmaxim,max14656
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, queued into power-supply's for-next.

-- Sebastian

--qzbz3b73z3thnsse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliODaMACgkQ2O7X88g7
+prJUg/9EMZvRjdAgqudiFJyhgtHsVUaHOCKEeFckRewV3SmZubOzpIlJYCLPkma
iRkBfkXamOSPPVZXn0Av7KC9jsxo/STpSxDtcyKKLrrN9AzrIkHIONqdUo1IXSUX
rUGmE3bkFCBCoGpmE9LApTdC4Jw9eZjaDZjhoBKIhGKQ1ekmiF1CZwplAxWUBgjK
DjzuS56J2Nqb/V5UjMamw2InTEjnBkTX3J7EBKYZ+Pj9TB2piAhRhUcZ7I5LASgF
nKGr+JJMv8lGwADkROvs+7eoS9TWnJdWCcBHjZkFBcUD/OCwOhNG/L7ezD51YuBd
+1XvQv/N0KI+zXHlLW/NWNa64HYN9CAJy4Sh05Bwxo/cR09d2mIY9VfSljze8t4H
8twRCWED8bq1wv1hQRtFZI+7Wjcq7EUQ4antxtV6nw/w1d5/uT7mS67FcLq/Ele8
SJ1gpKb4BvXAhxibM0la3UrIEip4MXXNh9bMfu2TE7SmBnRBMTHeI3+12Y0G0qyT
0pVCrBpqwj5EXdpI017agbjssO5IHuwSExvpayzflokaclxvbq1GIGNsNP4b6BPJ
48RGhCuY13mnfljiyZbAzHVHcfQjE/7jKtvAsZScnwS4eG/HbrhS2IrzOAI2WWk/
1oZPZR+lVeQuDULZM+e2vqyaXuJmmLTVXihqkxfDk6KftLpnP7U=
=Zy6G
-----END PGP SIGNATURE-----

--qzbz3b73z3thnsse--
