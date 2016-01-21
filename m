From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Thu, 21 Jan 2016 11:54:11 +0100
Message-ID: <20160121105411.GA32212@ulmo>
References: <1453362746-9310-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453362746-9310-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Tyler Baker <tyler.baker@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 08:52:26AM +0100, Tomeu Vizoso wrote:
> As per the documentation of the devfreq_dev_profile.target callback, set
> the freq argument to the new frequency before returning.
>=20
> This caused endless messages like this after recent changes in the core:
>=20
> devfreq 6000c800.actmon: Couldn't update frequency transition information.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reported-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  drivers/devfreq/tegra-devfreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devf=
req.c
> index 848b93ee930f..fe9dce0245bf 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -500,6 +500,8 @@ static int tegra_devfreq_target(struct device *dev, u=
nsigned long *freq,
>  	clk_set_min_rate(tegra->emc_clock, rate);
>  	clk_set_rate(tegra->emc_clock, 0);
> =20
> +	*freq =3D rate;
> +
>  	return 0;
>  }
> =20

I had noticed it recently but hadn't got around to look into it, thanks
for fixing it.

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWoLjQAAoJEN0jrNd/PrOh3VEQAIdcEc8HUjfJ7jxeB5tj0e8y
u8vnimklWFNtCfG2zTYrVs658UKJph9nwllI9LoUMp5bNusuNAKP+ELfzqQchKzJ
I5VNoyowmU5U0Ogw3ifpw++4XKNt2pMGXOhXU/XNgbWTm0t3ryFb7/MRj78KwoBg
fpKEllR6c8g05asdTeIuQq7zJPXxlYTGngjl/Ure3ybOpebkly8HmFSn0eOzwUWr
rSYWu76peA46LoYSoqsZMhlVQMcl7WkDHieZdePIHoswSF2bXbyAOD6Ix6GFmpLf
KOavWm0p972z+8WkwB/KrCbpqo4OTzV5IIzbFobPHsFKsDalWyUHz4Q8e2gcZQd7
S68m2x3dfM+PrSvjkwIWpJJe32Sauk+P0AVk+OsInWJXZRvgc5lrtCTfc7aW1H3P
R90f88RUCNwUDhs5KH2OouEUTqDbW8NM8JKA5xFBFrYpV5j90aJqskHQ4/vD20W1
sGfhri1oYc8nfESl8FkZ/mdC9rKEszQu9ez7TUK9gZH0MUswRzmV58mAnV7G8Bot
alHox2YhQ3L5hgjodxv01eA1OLmqcR3wJOkPWewcaOVqr/EQxEkXR1iviufSAAgf
08kr63+JB+qTB9lj7Z/HAFNyNdgHVLem10HSwKhTFtsgOyLpTxkN97UJqmARpGjD
F88cTQ5t8hmGwvqkxRN2
=SDMw
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
