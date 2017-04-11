From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/4] cpufreq: imx6q: Set max suspend_freq to avoid
 changes during suspend
Date: Tue, 11 Apr 2017 14:57:42 +0530
Message-ID: <20170411092742.GB13627@vireshk-i7>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
 <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35082 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbdDKJ1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 05:27:46 -0400
Received: by mail-pf0-f173.google.com with SMTP id i5so46197255pfc.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2017 02:27:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 04-04-17, 20:04, Leonard Crestez wrote:
> If the cpufreq driver tries to modify voltage/freq during suspend/resume
> it might need to control an external PMIC via I2C or SPI but those
> devices might be already suspended. This issue is likely to happen
> whenever the LDOs have their vin-supply set.
> 
> To avoid this scenario we just increase cpufreq to the maximum before
> suspend.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index be90ee3..786122e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -161,8 +161,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	int ret;
> +
>  	policy->clk = arm_clk;
> -	return cpufreq_generic_init(policy, freq_table, transition_latency);
> +	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
> +	policy->suspend_freq = policy->max;
> +
> +	return ret;
>  }
>  
>  static struct cpufreq_driver imx6q_cpufreq_driver = {
> @@ -173,6 +178,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>  	.init = imx6q_cpufreq_init,
>  	.name = "imx6q-cpufreq",
>  	.attr = cpufreq_generic_attr,
> +	.suspend = cpufreq_generic_suspend,
>  };
>  
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
