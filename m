From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: core: fix typo in function to get current
 charge control limit
Date: Mon, 15 Apr 2019 21:44:03 +0200
Message-ID: <20190415194403.hj23wvbw7brb7qkv@earth.universe>
References: <20190415142918.4383-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fg2cu7rwq4kf52ih"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415142918.4383-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--fg2cu7rwq4kf52ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 15, 2019 at 04:29:18PM +0200, Enric Balletbo i Serra wrote:
> There is a spelling mistake in ps_get_cur_charge_cntl_limit function so
> replace 'chrage' for 'charge'.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>=20
>  drivers/power/supply/power_supply_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index c917a8b43b2b..ef2aecfe2cd2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -899,7 +899,7 @@ static int ps_get_max_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
>  	return ret;
>  }
> =20
> -static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *t=
cd,
> +static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *t=
cd,
>  					unsigned long *state)
>  {
>  	struct power_supply *psy;
> @@ -934,7 +934,7 @@ static int ps_set_cur_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
> =20
>  static const struct thermal_cooling_device_ops psy_tcd_ops =3D {
>  	.get_max_state =3D ps_get_max_charge_cntl_limit,
> -	.get_cur_state =3D ps_get_cur_chrage_cntl_limit,
> +	.get_cur_state =3D ps_get_cur_charge_cntl_limit,
>  	.set_cur_state =3D ps_set_cur_charge_cntl_limit,
>  };
> =20
> --=20
> 2.20.1
>=20

--fg2cu7rwq4kf52ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly03wMACgkQ2O7X88g7
+poyMg/7BnuoQ9N1OqyZiZUWLhmzxNOLKnkFon4ANsgpqbmPCR2MiS5eCwcrAbjY
9MMqxRsSFODTtppsKPpBGJVltJzOk0jpViRBtMo5PwKSap3hasJ9GM19cdIJEPlb
SW/Blm/WSL2vhEItFtC02iST++9RThJmxAVIkQHwUsPKZ46kw/sFqRy8kRkfQue2
pbspFiMENO2rvdwt/aQjKsx4nNkempTLaZC+Rb2OZgRbyxVpo5AxMQeVPkEBVRqR
z2ntaM/pf783Ec0mXXTvxGV1Q3LZpPJZvy1ETzU47CvF+GdcH82hZhHGjzaJVH5W
RcShIrIm7hXPEcHsuOY3sox0ImcoY6+XiHCL8V97TngkB51bw+qac0lojVFtHyAq
+QSl+whSr8MUGGW+D3w0S9gyplkJWWOYZ7vY6DJBOi5by8GZLMw0IYOhgEYpFoiR
/Ls3gyV4/vZ6NgSW3EjRmD8H1amGJdWJV9WM/TgFR/1iz+CH8phVouwR1Kvk/0mK
QWwvRiZLdh0+Ft1Sv91YDU05MGrg+x2BHiMNtzB6lpvilEk84wLy+3pSNzTga4jD
l0MuRVAAk15ZCUzqpEdvRDynyBC5dPl5OHcH8pp8D7uIzrzxUoqH6aKIUJj0FDwM
JgTD/hg4yCh8n8meuDI1Wf70Y22uO/rhc/CmgFeTegjIT0n4Cyc=
=Zq+n
-----END PGP SIGNATURE-----

--fg2cu7rwq4kf52ih--
