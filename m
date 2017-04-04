From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/5] cpufreq: imx6q: Fix handling EPROBE_DEFER from
 regulator
Date: Tue, 04 Apr 2017 11:48:02 +0200
Message-ID: <1491299282.2367.13.camel@pengutronix.de>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
         <36c230773c14d37037dbe8cadf4f99b0d875e679.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37299 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751130AbdDDJsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 05:48:12 -0400
In-Reply-To: <36c230773c14d37037dbe8cadf4f99b0d875e679.1490987945.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> From: Irina Tirdea <irina.tirdea@nxp.com>
> 
> If there are any errors in getting the cpu0 regulators, the driver returns
> -ENOENT. In case the regulators are not yet available, the devm_regulator_get
> calls will return -EPROBE_DEFER, so that the driver can be probed later.
> If we return -ENOENT, the driver will fail its initialization and will
> not try to probe again (when the regulators become available).
> 
> Return the actual error received from regulator_get in probe. Print a
> differentiated message in case we need to probe the device later and
> in case we actually failed. Also add a message to inform when the
> driver has been successfully registered.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 7719b02..be90ee3 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -222,6 +222,13 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	arm_reg = regulator_get(cpu_dev, "arm");
>  	pu_reg = regulator_get_optional(cpu_dev, "pu");
>  	soc_reg = regulator_get(cpu_dev, "soc");
> +	if (PTR_ERR(arm_reg) == -EPROBE_DEFER ||
> +			PTR_ERR(soc_reg) == -EPROBE_DEFER ||
> +			PTR_ERR(pu_reg) == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		dev_dbg(cpu_dev, "regulators not ready, defer\n");
> +		goto put_reg;
> +	}
>  	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
>  		dev_err(cpu_dev, "failed to get regulators\n");
>  		ret = -ENOENT;
