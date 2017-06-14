From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: constify psy_tcd_ops.
Date: Wed, 14 Jun 2017 22:12:46 +0200
Message-ID: <20170614201245.amwprdmnq4vso2xh@earth>
References: <52491fb24dcf85b8e5624a9582d68784e762656c.1497330213.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cq6tfav7erfpe7nq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52491fb24dcf85b8e5624a9582d68784e762656c.1497330213.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--cq6tfav7erfpe7nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2017 at 10:39:43AM +0530, Arvind Yadav wrote:
> File size before:
> text	data	bss	dec   hex filename
> 4240	 200	 80	4520 11a8 drivers/power/supply/power_supply_core.o
>=20
> File size After adding 'const':
> text	data	bss	dec   hex filename
> 4296	 136	 80	4512 11a0 drivers/power/supply/power_supply_core.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/power_supply_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 7ec7c7c..2cc64b8 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -669,7 +669,7 @@ static int ps_set_cur_charge_cntl_limit(struct therma=
l_cooling_device *tcd,
>  	return ret;
>  }
> =20
> -static struct thermal_cooling_device_ops psy_tcd_ops =3D {
> +static const struct thermal_cooling_device_ops psy_tcd_ops =3D {
>  	.get_max_state =3D ps_get_max_charge_cntl_limit,
>  	.get_cur_state =3D ps_get_cur_chrage_cntl_limit,
>  	.set_cur_state =3D ps_set_cur_charge_cntl_limit,
> --=20
> 1.9.1
>=20

--cq6tfav7erfpe7nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllBmL0ACgkQ2O7X88g7
+prJJA/9EIJ/SZZe/eZ5naSthI95yRqMhXT0ANN5YqtbpHR27XlvjpRjiYeogqb/
9KgalB/q+A7/o0gUuCtbBae+wOtyxuW5OocPy+mMeREdbTHnLqVJ9KTXBwYkr+w2
NpR8GnahO2mVgz2rYbmA+lgdWM1YlhdGCBV7ehWwikcBqtU9xXof5IT2HdFHagRo
pWBgzzU8n764BkLbdHgdWfPL6d3XhYAY36t4tR7CbenikgFFpaMcbO1wb8Vio6nB
ha67ypv31rlNGIfb0DX2IIZtG4zKhUycc6u4hUX1m8U7HdQwCDP7k+/oSXokOxLv
gT+qe06db+k0UALutkcpfuFEZ9KuMK7FjeSWf4eadpKKDSsFnXMAWQPJ8TKgRVVF
c6ZLybVwfSgOcxwNBz7gHchAZJnNQ8Wadt+5xWDbHnyz5PLWrzK48RhrQedU4n0g
wKhGvCdtZM4mp3nTpeUfzf5YzJHbuwhnOizxcjwPhwwJeg3UGT9H3TPHB+7GRV7A
pfpRhSPL76pZNTG7bDR26nLSzNEqDIyJVZQLDIbwWuNF7p5TpWJ9vsApguDJqSQi
3aB/vPehfczTrsoRVkpkG/pUpv5eW8lpCrLv8xGAxreHNzYU4UY0GDrNJH4dyW4O
c0wdN+3xx38BEDBHWDA0ug2u82ISyk1DrCmFqag5N8sVRtSH5p4=
=i7x0
-----END PGP SIGNATURE-----

--cq6tfav7erfpe7nq--
