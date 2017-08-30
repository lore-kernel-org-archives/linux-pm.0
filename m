From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH] cpufreq: imx6q: Fix imx6sx low frequency support
Date: Wed, 30 Aug 2017 15:26:43 +0000
Message-ID: <AM3PR04MB306B15744B7A42B55A69C8A809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <4304e578a343c9acaed46b7e205d49bb63323f80.1503918257.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4304e578a343c9acaed46b7e205d49bb63323f80.1503918257.git.leonard.crestez@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Leonard Crestez [mailto:leonard.crestez@nxp.com]
> Sent: Monday, August 28, 2017 7:05 PM
> To: Shawn Guo; Viresh Kumar; Rafael J. Wysocki
> Cc: Anson Huang; Fabio Estevam; A.s. Dong; Lucas Stach; Jacky Bai;
> kernel@pengutronix.de; linux-pm@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] cpufreq: imx6q: Fix imx6sx low frequency support
>=20
> This patch contains the minimal changes required to support imx6sx OPP of
> 198 Mhz. Without this patch cpufreq still reports success but the
> frequency is not changed, the "arm" clock will still be at 396000000 in
> clk_summary.
>=20
> In order to do this PLL1 needs to be still kept enabled while changing th=
e
> ARM clock. This is a hardware requirement: when ARM_PODF is changed in CC=
M
> we need to check the busy bit of CCM_CDHIPR bit 16 arm_podf_busy, and thi=
s
> bit is sync with PLL1 clock, so if PLL1 NOT enabled, this bit will never
> get clear.
>=20
> Keep pll1_sys explicitly enabled until after the rate is change to deal
> with this. Otherwise from the clk framework perspective pll1_sys is unuse=
d
> and gets turned off.
>=20

Seems like a clever method to me.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> Changes since v1:
>  - Link: https://lkml.org/lkml/2017/7/19/302
>  - Only keep pll1_sys enabled until after ARM rate is changed.
>  - Incorporate more elaborate explanation from Anson
>  - Do not add new clocks or bypass PLL1. Just let it get disabled.
>=20
>  drivers/cpufreq/imx6q-cpufreq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-
> cpufreq.c index b6edd3c..14466a9 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -47,6 +47,7 @@ static int imx6q_set_target(struct cpufreq_policy
> *policy, unsigned int index)
>  	struct dev_pm_opp *opp;
>  	unsigned long freq_hz, volt, volt_old;
>  	unsigned int old_freq, new_freq;
> +	bool pll1_sys_temp_enabled =3D false;
>  	int ret;
>=20
>  	new_freq =3D freq_table[index].frequency; @@ -124,6 +125,10 @@ static
> int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
>  			clk_set_rate(pll1_sys_clk, new_freq * 1000);
>  			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +		} else {
> +			/* pll1_sys needs to be enabled for divider rate change
> to work. */
> +			pll1_sys_temp_enabled =3D true;
> +			clk_prepare_enable(pll1_sys_clk);
>  		}
>  	}
>=20
> @@ -135,6 +140,10 @@ static int imx6q_set_target(struct cpufreq_policy
> *policy, unsigned int index)
>  		return ret;
>  	}
>=20
> +	/* PLL1 is only needed until after ARM-PODF is set. */
> +	if (pll1_sys_temp_enabled)
> +		clk_disable_unprepare(pll1_sys_clk);
> +
>  	/* scaling down?  scale voltage after frequency */
>  	if (new_freq < old_freq) {
>  		ret =3D regulator_set_voltage_tol(arm_reg, volt, 0);
> --
> 2.7.4
