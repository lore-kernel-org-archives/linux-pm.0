From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: imx6q: add return value check for voltage scale
Date: Mon, 5 Nov 2018 08:01:52 +0530
Message-ID: <20181105023152.pldy2i7rvsysijha@vireshk-i7>
References: <1541379270-30149-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541379270-30149-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 05-11-18, 00:59, Anson Huang wrote:
> Add return value check for voltage scale when ARM clock
> rate change fail.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 8cfee0a..d8c3595 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -160,8 +160,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	/* Ensure the arm clock divider is what we expect */
>  	ret = clk_set_rate(clks[ARM].clk, new_freq * 1000);
>  	if (ret) {
> +		int ret1;
> +
>  		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
> -		regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +		ret1 = regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +		if (ret1)
> +			dev_warn(cpu_dev,
> +				 "failed to restore vddarm voltage: %d\n", ret1);
>  		return ret;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
