From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: ab8500_fg: fix spelling mistake:
 "Disharge" -> "Discharge"
Date: Wed, 25 Apr 2018 23:46:47 +0200
Message-ID: <20180425214647.j3tdfp7laldwmvjg@earth.universe>
References: <20180328224850.27833-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqieznofvqczycrd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328224850.27833-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--nqieznofvqczycrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 28, 2018 at 11:48:50PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in dev_dbg message text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index c569f82a0071..993898d1712f 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -1408,7 +1408,7 @@ static void ab8500_fg_charge_state_to(struct ab8500=
_fg *di,
>  static void ab8500_fg_discharge_state_to(struct ab8500_fg *di,
>  	enum ab8500_fg_discharge_state new_state)
>  {
> -	dev_dbg(di->dev, "Disharge state from %d [%s] to %d [%s]\n",
> +	dev_dbg(di->dev, "Discharge state from %d [%s] to %d [%s]\n",
>  		di->discharge_state,
>  		discharge_state[di->discharge_state],
>  		new_state,
> --=20
> 2.15.1
>=20

--nqieznofvqczycrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrg90cACgkQ2O7X88g7
+poyXQ/8CXKowDm6+l8mBUMC8euFuirokrsyYJeRSiVILoIa7OKR+4h4oAe7HDmA
1Wzdj8N25l0qAN+RTcF9FfqVRjUWSXnpi/amnLSrXXxtoCMtuaSXl7XwL4BJoeTk
XKfdk3s93N1mi+5L1FDvjzo6zgqw3LgWeRqo5XC6f95AA5E+G5WbhTDle2bo1r7J
HYHPGExrhDm/YSruxh2KqPm2ty2pqSI72mxsBRnudhBIey9b3T91KEcYQz9cZ2Wi
dQPWx39W6gvDovk6whnOMMF7Il0MvD0UzXoQskUdgkXGBs+REvm3SiVSgkkx6Qui
Ze7kMC/ARKbczHEjP/s8akmOrvfuAykyuEd92NKQqgGofxwfQfXqN0DMqzI/rK+B
wtRplb9jiy/2/zcFTCrCjH5R/mTF62N0dEyuFR5rMUNkpXkv88TD0CVV3JyjWU34
DLU2cfgm+xCyPODdQkVKqx2XOogYBvYNHDoPDBDjDC2J9ugcxEGN1AQVgPcznZiS
5netb80ejQAAAumyw58TuvhRPbY82bhMIsYaDY5gttwQ2/GqEuWAwmXeoAJj/kdw
9Qd4nzVDKDVcmat6UVbhrPmbMhumMsoETeQVvI1jNDUq1qSY4jX8jvwVxoGzRNLs
B5Q77bT1r2T6cMs3PCj+1Alc65G1ok4Ci14K1jHbe8DGRzCU7Aw=
=wJue
-----END PGP SIGNATURE-----

--nqieznofvqczycrd--
