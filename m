From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
Date: Mon, 12 Feb 2018 07:24:52 +0000
Message-ID: <AM3PR04MB1315A06F706CCB9EC0699C71F5F70@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
 <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <79baed40abbcc72920fd133bc43e378a@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:38171
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932396AbeBLHY5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Feb 2018 02:24:57 -0500
In-Reply-To: <79baed40abbcc72920fd133bc43e378a@agner.ch>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Fabio Estevam <festevam@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "max.oss.09@gmail.com" <max.oss.09@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>



Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Monday, February 12, 2018 12:18 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>; rjw@rjwysocki.net; viresh kumar
> <viresh.kumar@linaro.org>; linux-pm@vger.kernel.org; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; max.oss.09@gmail.com; linux-kernel
> <linux-kernel@vger.kernel.org>; Octavian Purdila <octavian.purdila@nxp.co=
m>;
> Fabio Estevam <fabio.estevam@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> i.MX6UL/ULL
>=20
> On 11.02.2018 02:42, Anson Huang wrote:
> > Anson Huang
> > Best Regards!
> >
> >
> >> -----Original Message-----
> >> From: Fabio Estevam [mailto:festevam@gmail.com]
> >> Sent: Sunday, February 11, 2018 12:26 AM
> >> To: Stefan Agner <stefan@agner.ch>; Anson Huang
> <anson.huang@nxp.com>
> >> Cc: rjw@rjwysocki.net; viresh kumar <viresh.kumar@linaro.org>;
> >> linux-pm@vger.kernel.org; Marcel Ziswiler
> >> <marcel.ziswiler@toradex.com>; max.oss.09@gmail.com; linux-kernel
> >> <linux-kernel@vger.kernel.org>; Octavian Purdila
> >> <octavian.purdila@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> >> Shawn Guo <shawnguo@kernel.org>; moderated list:ARM/FREESCALE IMX /
> >> MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>;
> >> dl-linux-imx <linux-imx@nxp.com>
> >> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> >> i.MX6UL/ULL
> >>
> >> Hi Anson,
> >>
> >> On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
> >> > Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> >> > Use PLL1 sys clock for all operating points higher than 528MHz.
> >> >
> >> > Note: For higher operating points VDD_SOC_IN needs to be 125mV
> >> > higher than the ARM set-point (see datasheet). Specifically, the
> >> > i.MX6UL/ULL EVK boards have an external DC regulator which needs
> >> > adjustment. The regulator adjustment is not covered with this change=
.
> >> >
> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> > ---
> >> >  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
> >> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> >> > b/drivers/cpufreq/imx6q-cpufreq.c index 628fe899cb48..840f6386c780
> >> > 100644
> >> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> >> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> >> > @@ -114,12 +114,14 @@ static int imx6q_set_target(struct
> >> > cpufreq_policy
> >> *policy, unsigned int index)
> >> >                  */
> >> >                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> >> >                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> >> > -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> >> > -                       clk_set_parent(secondary_sel_clk,
> pll2_bus_clk);
> >> > -               else
> >> > -                       clk_set_parent(secondary_sel_clk,
> >> pll2_pfd2_396m_clk);
> >> > -               clk_set_parent(step_clk, secondary_sel_clk);
> >> > -               clk_set_parent(pll1_sw_clk, step_clk);
> >> > +               if (freq_hz <=3D clk_get_rate(pll2_bus_clk)) {
> >> > +                       if (freq_hz >
> clk_get_rate(pll2_pfd2_396m_clk))
> >> > +                               clk_set_parent(secondary_sel_clk,
> >> pll2_bus_clk);
> >> > +                       else
> >> > +                               clk_set_parent(secondary_sel_clk,
> >> pll2_pfd2_396m_clk);
> >> > +                       clk_set_parent(step_clk, secondary_sel_clk);
> >> > +                       clk_set_parent(pll1_sw_clk, step_clk);
> >> > +               }
> >
> > For cpufreq > 528MHz, ARM PLL needs to be set_rate, I did NOT see
> > where sets ARM PLL rate?
>=20
> This is done unconditionally after the if statement:
>=20
> 	if (of_machine_is_compatible("fsl,imx6ul") ||
> 	    of_machine_is_compatible("fsl,imx6ull")) {
> 		/*
> 		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
> 		 * CPU may run at higher than 528MHz, this will lead to
> 		 * the system unstable if the voltage is lower than the
> 		 * voltage of 528MHz, so lower the CPU frequency to one
> 		 * half before changing CPU frequency.
> 		 */
> 		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> 		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> 		if (freq_hz <=3D clk_get_rate(pll2_bus_clk)) {
> 			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> 				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> 			else
> 				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> 			clk_set_parent(step_clk, secondary_sel_clk);
> 			clk_set_parent(pll1_sw_clk, step_clk);
> 		}
> 	} else {
> 		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> 		clk_set_parent(pll1_sw_clk, step_clk);
> 		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> 			clk_set_rate(pll1_sys_clk, new_freq * 1000);
> 			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> 		} else {
> 			/* pll1_sys needs to be enabled for divider rate change to work.
> */
> 			pll1_sys_temp_enabled =3D true;
> 			clk_prepare_enable(pll1_sys_clk);
> 		}
> 	}
>=20
> 	/* Ensure the arm clock divider is what we expect */
> 	ret =3D clk_set_rate(arm_clk, new_freq * 1000);
>=20
>=20
> --
> Stefan

Thanks, I see the CLK_SET_RATE_PARENT flag is set for arm clk.

Reviewed-by: Anson Huang <Anson.Huang@nxp.com>
=20
Anson.
>=20
>=20
>=20
> >
> > Anson.
> >
> >> >         } else {
> >> >                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> >> >                 clk_set_parent(pll1_sw_clk, step_clk);
> >>
> >> Could you please help reviewing this patch?
> >>
> >> Thanks
