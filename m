From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Date: Thu, 10 Jan 2019 12:31:27 +0530
Message-ID: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-01-19, 21:05, Paweł Chmiel wrote:
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 33 +++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index f51697f1e0b3..2d0e4dc7ede7 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -594,6 +594,26 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  	 * this whole driver as soon as S5PV210 gets migrated to use
>  	 * cpufreq-dt driver.
>  	 */
> +	arm_regulator = regulator_get(NULL, "vddarm");
> +	if (PTR_ERR(arm_regulator) == -EPROBE_DEFER) {
> +		pr_dbg("vddarm regulator not ready, defer\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(arm_regulator)) {
> +		pr_err("failed to get regulator vddarm\n");
> +		return PTR_ERR(arm_regulator);
> +	}

The only difference between the two cases is pr_dbg vs pr_err, its
ugly that we have to add special code for that :(

Maybe write it as:

        if (IS_ERR(arm_regulator)) {
                if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
                        pr_dbg...
                else
                        pr_err
                return PTR_ERR(arm_regulator);
        }

> +
> +	int_regulator = regulator_get(NULL, "vddint");
> +	if (PTR_ERR(int_regulator == -EPROBE_DEFER) {

Does this even compile ?

> +		regulator_put(arm_regulator);
> +		pr_dbg("vddint regulator not ready, defer\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(int_regulator)) {
> +		regulator_put(arm_regulator);
> +		pr_err("failed to get regulator vddint\n");
> +		return PTR_ERR(int_regulator);
> +	}
> +
>  	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
>  	if (!np) {
>  		pr_err("%s: failed to find clock controller DT node\n",
> @@ -633,19 +653,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	arm_regulator = regulator_get(NULL, "vddarm");
> -	if (IS_ERR(arm_regulator)) {
> -		pr_err("failed to get regulator vddarm\n");
> -		return PTR_ERR(arm_regulator);
> -	}
> -
> -	int_regulator = regulator_get(NULL, "vddint");
> -	if (IS_ERR(int_regulator)) {
> -		pr_err("failed to get regulator vddint\n");
> -		regulator_put(arm_regulator);
> -		return PTR_ERR(int_regulator);
> -	}
> -
>  	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
>  
>  	return cpufreq_register_driver(&s5pv210_driver);
> -- 
> 2.17.1

-- 
viresh
