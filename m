From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 05/17] clk: tegra: Introduce ability for SoC-specific
 reset control callbacks
Date: Tue, 19 May 2015 16:59:23 +0200
Message-ID: <20150519145922.GA28018@ulmo>
References: <1431529131-16710-6-git-send-email-mikko.perttunen@kapsi.fi>
 <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432035567-19008-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, mturquette@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi
List-Id: linux-pm@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 02:39:27PM +0300, Mikko Perttunen wrote:
> This patch allows SoC-specific CAR initialization routines to register
> their own reset_assert and reset_deassert callbacks with the common Tegra
> CAR code. If defined, the common code will call these callbacks when a
> reset control with number >=3D num_periph_banks * 32 is attempted to be a=
sserted=20
> or deasserted respectively. Numbers greater than or equal to num_periph_b=
anks * 32
> are used to avoid clashes with low numbers that are automatically mapped =
to
> standard CAR reset lines.
>=20
> Each SoC with these special resets should specify the defined reset contr=
ol
> numbers in a device tree header file.

This is looking pretty good, but I think we can simplify a wee bit
more...

> Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> Acked-by: Michael Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/tegra/clk.c | 39 +++++++++++++++++++++++++++++++--------
>  drivers/clk/tegra/clk.h |  3 +++
>  2 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index 41cd87c..c093ed9 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -49,7 +49,6 @@
>  #define RST_DEVICES_L			0x004
>  #define RST_DEVICES_H			0x008
>  #define RST_DEVICES_U			0x00C
> -#define RST_DFLL_DVCO			0x2F4
>  #define RST_DEVICES_V			0x358
>  #define RST_DEVICES_W			0x35C
>  #define RST_DEVICES_X			0x28C
> @@ -79,6 +78,11 @@ static struct clk **clks;
>  static int clk_num;
>  static struct clk_onecell_data clk_data;
> =20
> +/* Handlers for SoC-specific reset lines */
> +static int (*special_reset_assert)(unsigned long);
> +static int (*special_reset_deassert)(unsigned long);
> +static int special_reset_num;

I think we can get rid of this if we...

> +
>  static struct tegra_clk_periph_regs periph_regs[] =3D {
>  	[0] =3D {
>  		.enb_reg =3D CLK_OUT_ENB_L,
> @@ -152,19 +156,29 @@ static int tegra_clk_rst_assert(struct reset_contro=
ller_dev *rcdev,
>  	 */
>  	tegra_read_chipid();
> =20
> -	writel_relaxed(BIT(id % 32),
> -			clk_base + periph_regs[id / 32].rst_set_reg);
> +	if (id < periph_banks * 32) {
> +		writel_relaxed(BIT(id % 32),
> +			       clk_base + periph_regs[id / 32].rst_set_reg);
> +		return 0;
> +	} else if (id < periph_banks * 32 + special_reset_num) {
> +		return special_reset_assert(id);
> +	}

=2E.. pass id - periph_banks * 32 into special_reset_assert(). Oh, but
then...

> @@ -286,10 +300,19 @@ void __init tegra_add_of_provider(struct device_nod=
e *np)
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> =20
>  	rst_ctlr.of_node =3D np;
> -	rst_ctlr.nr_resets =3D periph_banks * 32;
> +	rst_ctlr.nr_resets =3D periph_banks * 32 + special_reset_num;

=2E.. this is no longer going to work. We could keep special_reset_num,
though obviously it should be an unsigned int and renamed to
num_special_reset, yet still pass the relative ID into the SoC-specific
callbacks, after all that's what they care about and each implementation
would have to subtract periph_banks * 32 anyway.

>  	reset_controller_register(&rst_ctlr);
>  }
> =20
> +void __init tegra_init_special_resets(int num,
> +				      int (*assert)(unsigned long),
> +				      int (*deassert)(unsigned long))
> +{
> +	special_reset_num =3D num;
> +	special_reset_assert =3D assert;
> +	special_reset_deassert =3D deassert;
> +}
> +

I think we could possibly improve this interface somewhat by turning it
upside-down, that is, make SoC-specific drivers call this in a helper
fashion. But this is good enough for now, I can always take a stab at
refactoring if I get bored.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVW0/IAAoJEN0jrNd/PrOh/mQP/Rq8RTMaCSm24jid3BJ+QyO9
NRx4/AMZ6YWkNCVZr63O2O5BkFHJfEAlwhS9ML40aiV8/5MwFsGEADnCdv5QjyE4
JUn5ucLQZsFt5Az1AOnSH0AjZKcF0fpwaKbRqi/CqPl08xvKsSSH1hTum/laHH7x
0uaODc5sm6xSoJrxWpQcZMt2q9E6xjZ1N+8E8mFgsuUy2auP9m2SQqnoNouVXCXU
c8LV2LmDlkChxyeLbebhr72UdW+dePm3BrAZM0Jz7MG0PdViRe4sK2NdWTMUCT9M
/q3rgHbrlRvi8g/YAcGGfNXvNq4aCbTvnoab+ItEKId8jNssUhaBOxYnCMOzuCDu
ACLjdN2WnuDZ4RjsomlfI1fOGR2+FAjl5qBP/Xg9D0NB/rl63FQwzHY7MxmiwBpm
IGdNxZNxsujTcp9oAcTpTjPQq1nEreV5DzsfTjE33N3FSZI0ZInRk+hUOBj3I9H2
UJQeeg+rub3A2DDBSUHCE37/JkK4rCvLP/EI7bPKSvGFfEcNozUHeQoP8ABCY+tY
etxzJwlrfl/rG5IE4qCO6LTGv8UBmTrdORl1g5RaXRNDq3O0daBhOSg7sDsrjvZR
OTiMr6MxxWb634kVKdUIYMBqUu6mCV0xrx/gFVNHkElxUcIZ+nv0C/bRO8nYu0D+
gh2L76vQExuhGkw77rEX
=rOOV
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
