From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
Date: Tue, 2 Jan 2018 12:37:32 -0200
Message-ID: <CAOMZO5Do-tyR0ruqfSeJm2FDP7_chNeroFStTF85GnSt_2g5Uw@mail.gmail.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com> <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41751 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeABOhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 09:37:34 -0500
In-Reply-To: <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dong Aisheng <aisheng.dong@nxp.com>, Ping Bai <ping.bai@nxp.com>, viresh kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, Russell King - ARM Linux <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>

Hi Anson,

On Tue, Jan 2, 2018 at 3:07 PM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d9b2c2d..cbda0cc 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -120,6 +120,10 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>                         clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>                 clk_set_parent(step_clk, secondary_sel_clk);
>                 clk_set_parent(pll1_sw_clk, step_clk);
> +               if (freq_hz > clk_get_rate(pll2_bus_clk)) {
> +                       clk_set_rate(pll1_sys_clk, new_freq * 1000);
> +                       clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +               }

This change should be part of a different patch.

Thanks
