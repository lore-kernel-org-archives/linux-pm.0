From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: imx6q: remove unused code
Date: Mon, 26 Nov 2018 11:34:43 +0530
Message-ID: <20181126060443.augwfzdlpc26cvxb@vireshk-i7>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 26-11-18, 02:59, Anson Huang wrote:
> In voltage scale down path, the return value is NOT
> used at all, remove them to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d8c3595..8cb9683 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -177,22 +177,16 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	/* scaling down?  scale voltage after frequency */
>  	if (new_freq < old_freq) {
>  		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev,
>  				 "failed to scale vddarm down: %d\n", ret);
> -			ret = 0;
> -		}
>  		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
> -		if (ret) {
> +		if (ret)
>  			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
> -			ret = 0;
> -		}
>  		if (!IS_ERR(pu_reg)) {
>  			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> -			if (ret) {
> +			if (ret)
>  				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
> -				ret = 0;
> -			}
>  		}
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
