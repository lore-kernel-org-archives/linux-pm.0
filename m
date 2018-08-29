From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH][V2] power: supply: cros_usbpd: remove unused pointer
 'dev'
Date: Thu, 30 Aug 2018 00:34:34 +0200
Message-ID: <20180829223434.bzxjrmkkbrywhzsc@earth.universe>
References: <20180829145106.9847-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jax4wz6scaqxy76c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829145106.9847-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--jax4wz6scaqxy76c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 29, 2018 at 03:51:06PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Pointer 'dev' is being assigned but is never used hence it is
> redundant and can be removed.
>=20
> Cleans up clang warning:
> variable 'dev' set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>=20
> V2: change subject to include 'cros_usbpd' and also send to Sameer.
>=20
> ---

Thanks, queued with 'Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>'
Please don't forget to carrier over previously received Rb Tags!

-- Sebastian

>  drivers/power/supply/cros_usbpd-charger.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 688a16bacfbb..f2b8de502b82 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -378,12 +378,10 @@ static int cros_usbpd_charger_ec_event(struct notif=
ier_block *nb,
>  {
>  	struct cros_ec_device *ec_device;
>  	struct charger_data *charger;
> -	struct device *dev;
>  	u32 host_event;
> =20
>  	charger =3D container_of(nb, struct charger_data, notifier);
>  	ec_device =3D charger->ec_device;
> -	dev =3D charger->dev;
> =20
>  	host_event =3D cros_ec_get_host_event(ec_device);
>  	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> --=20
> 2.17.1
>=20

--jax4wz6scaqxy76c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHH3oACgkQ2O7X88g7
+ppU+Q/+PO4BfHE1T9MHy7GVhb5SKruKyYRothvpPsYM8qPbljTRUXqRjD1h90Qq
0k90IgH6/srdHVlgGVUjeWTTWW55AXFeoM90KpjZbjo5DaUVfwKBF48H7fJqQgSC
sPTvNeQQs5Ysct2C8TFiFbYQKBae7/hU1JGj1d+z6f++QmUZsVF+yTKG2yh+CWw9
VenmbF8HBMpHqWa9nx74QSSbLPPK8CONLyxFoKCCpqoKp5lyXj6nnqeFPVEqPsWE
/5BZmYDnXZClxo94Bg+zr/SgbTzAdD03iNhYsZsHm2NwqW3p1pteZlpnl3N/URYJ
zLPbCrl8Ci/DdVpW7fqvn9vrQG+onnnvoJbZGKTMhg29T3EiO5HO05JIUp85SIDU
HxXV59vV4UeL4xhakqWIzEMrjzc3/c7Lrd0LYypi3laARcPJqi/GtoHnR/OkfSpu
7CC94zcaqXjxIxTSII6jganFI4YfvnAqQJ4e1dD1FisrleB7lbXrKIG/sFgzZuU4
hpmPUQpzk9FvEAcKD8ddVpDR+Wps7DU1Yy9IheCwpsOLdxzgNCWqevsEqDp70mAp
Qq0yPziwdyZnxzTYvf9wyYCBvyAxg2QvyBLFxYyHhrHs9PN7n+z3iBhqyhAfgjuB
ZT5WEgUyuFA/vqO5E+VY9Y4irWgYYzx5uh/XUrqXK4F+FkfUYsk=
=Bmj6
-----END PGP SIGNATURE-----

--jax4wz6scaqxy76c--
