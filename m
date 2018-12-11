From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: imx6q: remove unused code
Date: Tue, 11 Dec 2018 11:49:13 +0100
Message-ID: <3624116.FYVZqeVW1R@aspire.rjw.lan>
References: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543200853-10029-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Monday, November 26, 2018 3:59:45 AM CET Anson Huang wrote:
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
> 

Both this one and the [2/2] applied with ACKs from Viresh.

Thanks!
