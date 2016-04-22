From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 04/11] clk: tegra: Add Tegra210 support in DFLL driver
Date: Fri, 22 Apr 2016 15:16:37 +0200
Message-ID: <20160422131637.GM9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-5-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M2Pxvdb9QxnGd/3e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461321071-6431-5-git-send-email-pchiu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Penny Chiu <pchiu@nvidia.com>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--M2Pxvdb9QxnGd/3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 06:31:04PM +0800, Penny Chiu wrote:
> Add Tegra210 support and related CVB table in tegra124 DFLL driver,
> and also update the binding document.
>=20
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt        |  4 +-
>  drivers/clk/tegra/Makefile                         |  4 +-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         | 55 ++++++++++++++++=
++++++
>  3 files changed, 61 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll=
=2Etxt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index 84080a8..42a1fe6 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -11,7 +11,9 @@ communicating with an off-chip PMIC either via an I2C b=
us or via PWM signals.
>  Currently only the I2C mode is supported by these bindings.
> =20
>  Required properties:
> -- compatible : should be "nvidia,tegra124-dfll"
> +- compatible : should be one of following:
> +  - "nvidia,tegra124-dfll" for the Tegra124 SoC
> +  - "nvidia,tegra210-dfll" for the Tegra210 SoC
>  - reg : Defines the following set of registers, in the order listed:
>          - registers for the DFLL control logic.
>          - registers for the I2C output logic.
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 97984c5..9b8e9de 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -17,7 +17,9 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         +=3D clk-tegra2=
0.o
>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         +=3D clk-tegra30.o
>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D clk-tegra114.o
>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124.o
> -obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124-dfll-fcpu.o
> +ifneq ($(filter y, $(CONFIG_ARCH_TEGRA_124_SOC) $(CONFIG_ARCH_TEGRA_210_=
SOC)),)
> +obj-y					+=3D clk-tegra124-dfll-fcpu.o
> +endif

This is better written as:

	obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124-dfll-fcpu.o
	obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D clk-tegra124-dfll-fcpu.o

This works because obj-* variables are sorted using make's $(sort)
function, which lexically sorts and removes duplicates.

> +static const unsigned long tegra210_cpu_max_freq_table[] =3D {
> +	[0] =3D 1912500000UL,
> +	[1] =3D 1912500000UL,
> +};
> +
>  static const struct cvb_table tegra124_cpu_cvb_tables[] =3D {
>  	{
>  		.speedo_id =3D -1,
> @@ -87,6 +92,45 @@ static const struct cvb_table tegra124_cpu_cvb_tables[=
] =3D {
>  	},
>  };
> =20
> +static const struct cvb_table tegra210_cpu_cvb_tables[] =3D {
> +	{
> +		.speedo_id =3D -1,
> +		.process_id =3D -1,
> +		.min_millivolts =3D 850,
> +		.max_millivolts =3D 1170,
> +		.speedo_scale =3D 100,
> +		.voltage_scale =3D 1000,
> +		.cvb_table =3D {
> +			{51000000UL,    {1007452, -23865, 370} },
> +			{102000000UL,   {1007452, -23865, 370} },
> +			{204000000UL,   {1007452, -23865, 370} },
> +			{306000000UL,   {1052709, -24875, 370} },
> +			{408000000UL,   {1099069, -25895, 370} },
> +			{510000000UL,   {1146534, -26905, 370} },
> +			{612000000UL,   {1195102, -27915, 370} },
> +			{714000000UL,   {1244773, -28925, 370} },
> +			{816000000UL,   {1295549, -29935, 370} },
> +			{918000000UL,   {1347428, -30955, 370} },
> +			{1020000000UL,  {1400411, -31965, 370} },
> +			{1122000000UL,  {1454497, -32975, 370} },
> +			{1224000000UL,  {1509687, -33985, 370} },
> +			{1326000000UL,  {1565981, -35005, 370} },
> +			{1428000000UL,  {1623379, -36015, 370} },
> +			{1530000000UL,  {1681880, -37025, 370} },
> +			{1632000000UL,  {1741485, -38035, 370} },
> +			{1734000000UL,  {1802194, -39055, 370} },
> +			{1836000000UL,  {1864006, -40065, 370} },
> +			{1912500000UL,  {1910780, -40815, 370} },
> +			{0,             {      0,      0,   0} },
> +		},
> +		.cpu_dfll_data =3D {
> +			.tune0_low =3D 0xffead0ff,
> +			.tune0_high =3D 0xffead0ff,
> +			.tune1 =3D 0x20091d9,
> +		}
> +	},
> +};
> +
>  static const struct dfll_fcpu_data tegra124_dfll_fcpu_data =3D {
>  	.cpu_max_freq_table =3D tegra124_cpu_max_freq_table,
>  	.cpu_max_freq_table_size =3D ARRAY_SIZE(tegra124_cpu_max_freq_table),
> @@ -94,11 +138,22 @@ static const struct dfll_fcpu_data tegra124_dfll_fcp=
u_data =3D {
>  	.cpu_cvb_tables_size =3D ARRAY_SIZE(tegra124_cpu_cvb_tables)
>  };
> =20
> +static const struct dfll_fcpu_data tegra210_dfll_fcpu_data =3D {
> +	.cpu_max_freq_table =3D tegra210_cpu_max_freq_table,
> +	.cpu_max_freq_table_size =3D ARRAY_SIZE(tegra210_cpu_max_freq_table),
> +	.cpu_cvb_tables =3D tegra210_cpu_cvb_tables,
> +	.cpu_cvb_tables_size =3D ARRAY_SIZE(tegra210_cpu_cvb_tables)
> +};

I think it would be better to keep all Tegra124 and Tegra210 data
together, so you should first list the Tegra124 maximum frequencies,
followed by the Tegra124 CVB table and the Tegra124 DFLL FCPU data,
then the same for Tegra210 data. That way we can make sure all new
appears in one hunk in a patch, which makes review and maintenance a
lot easier.

Thierry

--M2Pxvdb9QxnGd/3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGiQ1AAoJEN0jrNd/PrOhuFUP/j5wlskiABisA7sC9RtmrGKq
oohiPTfqGQiapgpiTnB5Tc+7XwOwlr4RslFlwGl8Ngpk9G4XuuQz9rgF0qKvnrfT
CNdUJMx9WNDsOxIjXq4rrIQFQtg8MvO9XOPMNhB9wdpSYUIbkxiBKBqbpaU6NQau
M/u7m38+Hx4XWlmx/zsrKOaCsQBsJR+HE5bjE6CqWrhLnry7FxYD1oe6JouBtl5V
uJgvOA0OJPxbMFYKjIzTdca1JWt11ukpWWc//6QyfJ4arfdlEGEjAOCqwxtw4jE0
UGDMo3w8PtDpxGF8HjBo2huXK3NN1fSkOoAxoKo1Zu5GzxBCwobNxiWXyvlXgzpc
hbLdgno68/K5QpPw9EUFQuiXmJ5jig1xc7WJ3SGMhHSJVqyg3p9osUMKlMSdbMQS
UdTaKzymSn5a/9Nw/qE4yUxyvrPSEuCNU87ZCSuR8w10MRXBVccxo0dcBv6waOLS
EEz1O1uYi6QR22FLGWGWJ++Kqvyhx1mgGnzvZuLoN0aUa2/wZjbFRelR0kpU3Zph
UjuDpCKct27RgDrQtwK3OFMRTnIA3AzHLkmqgZbdTQq61Jm1GIZ+y2ntyyuzLVrM
VmNrN77lMq9/DMtr6Q55YPDb/nAdICHXi00xSjod842cL/cgEaa/VOxZdWs2ZY5t
b4zIv5ZOAns4ih/R6TlO
=iKJV
-----END PGP SIGNATURE-----

--M2Pxvdb9QxnGd/3e--
