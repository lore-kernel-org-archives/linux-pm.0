From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/11] clk: tegra: Add DFLL DVCO reset control for
 Tegra210
Date: Fri, 22 Apr 2016 15:11:43 +0200
Message-ID: <20160422131143.GL9047@ulmo.ba.sec>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-4-git-send-email-pchiu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461321071-6431-4-git-send-email-pchiu@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Penny Chiu <pchiu@nvidia.com>
Cc: swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 06:31:03PM +0800, Penny Chiu wrote:
> The DVCO present in the DFLL IP block has a separate reset line,
> exposed via the CAR IP block.  This reset line is asserted upon SoC
> reset.  Unless something (such as the DFLL driver) deasserts this
> line, the DVCO will not oscillate, although reads and writes to the
> DFLL IP block will complete.
>=20
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c         | 68 ++++++++++++++++++++++++++=
++++++
>  include/dt-bindings/reset/tegra210-car.h | 12 ++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 include/dt-bindings/reset/tegra210-car.h
>=20
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-teg=
ra210.c
> index d3709b1..3d70b38 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/clk/tegra.h>
>  #include <dt-bindings/clock/tegra210-car.h>
> +#include <dt-bindings/reset/tegra210-car.h>
> =20
>  #include "clk.h"
>  #include "clk-id.h"
> @@ -39,6 +40,9 @@
>  #define CLK_SOURCE_CSITE 0x1d4
>  #define CLK_SOURCE_EMC 0x19c
> =20
> +#define RST_DFLL_DVCO 0x2f4
> +#define DVFS_DFLL_RESET_SHIFT 0

It'd be more idiomatic to make this:

	#define DVFS_DFLL_RESET (1 << 0)

and use that below instead of hard-coding the 1 << and shifting by the
define.

> +
>  #define PLLC_BASE 0x80
>  #define PLLC_OUT 0x84
>  #define PLLC_MISC0 0x88
> @@ -2781,6 +2785,68 @@ static void __init tegra210_clock_apply_init_table=
(void)
>  }
> =20
>  /**
> + * tegra210_car_barrier - wait for pending writes to the CAR to complete
> + *
> + * Wait for any outstanding writes to the CAR MMIO space from this CPU
> + * to complete before continuing execution.  No return value.
> + */
> +static void tegra210_car_barrier(void)
> +{
> +	readl_relaxed(clk_base + RST_DFLL_DVCO);
> +}

If you use the plain readl() and writel() functions, do you still need
the barrier? Or is there actually a requirement from the hardware to
flush writes by reading from any of the registers?

Thierry

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXGiMPAAoJEN0jrNd/PrOh5NEP/19hckFLcpMp+Mb8ZdrKCLAZ
PkyhHwk3NBfV0Scp9XFYaJ1GScjV2vq9szw+O1bVBjg9DpKmVIrS4K3XsZ7j2cYL
VBJ2bNCDCE8/c9IKpSAvyZ6uh14nXZB2jjR7xn3JpcLge5BXKdVLuXkVyKjtRj8t
BgZ79IdemSaTV22MACcXCusEAfAFZZzlfolvdkzUNkT+cL96usQBNBIPZ5v15GGG
RkLLyhldXzwldRkY4qvjeYNubSbk8GAmb5wfqEuUCpAWYPrjfr7PkQ7jhsKiv6Fr
JZOWSzqKc7UKyxvq97ziLJ2NKuD40uGvON7Z5+B8q9Z5+TUYyT1fOKU0vjrX7DFQ
eksAf+hSBqsjSq7TD6q9k2RB5zcgrQUK5M+HXvLs68I4T92ZPuyjbAUVw7KLBM/5
yjysiSVI8s+U9oxlFYdwVmvKdBW+5NSwSL65s/347IWZTJezSe697F8T92yyqk5c
M29XSL225/ZFKcrqgHiN2oH/UR0sg8Ms8LsJSPC+EnYRs6NaFrlQtx0+4hze+mWX
iFbiJqxkPBTQnVwg4n/Vs9hD1FVZL5mQH1PQ5sUA5fwePArVpYIuTqWk+RRYvlog
HJ/WDC0HZkXyd1r72RRcKPBR0qGbMqJycFAe3Tw6IoGd/QGPSyoOXZzjGjZOT+XP
i0+a2t2t15sOzz30B9mO
=nxyQ
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--
