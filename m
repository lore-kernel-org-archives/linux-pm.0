From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of
 qcom_cpufreq_kryo_probe()
Date: Wed, 27 Feb 2019 13:22:22 +0530
Message-ID: <20190227075222.ib7qg6ycrwyztms5@vireshk-i7>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20-02-19, 16:44, Viresh Kumar wrote:
> With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> 256"), we have started getting following compilation warning:
> 
> qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Fix that by dynamically allocating opp_tables and freeing it later.
> 
> Compile tested only.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 1c8583cc06a2..6888cb6db2ef 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
> -	struct opp_table *opp_tables[NR_CPUS] = {0};
> +	struct opp_table **opp_tables;
>  	enum _msm8996_version msm8996_version;
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
> @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  	}
>  	kfree(speedbin);
>  
> +	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> +	if (!opp_tables)
> +		return -ENOMEM;
> +
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);
>  		if (NULL == cpu_dev) {
> @@ -149,6 +153,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	kfree(opp_tables);
> +
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>  							  NULL, 0);
>  	if (!IS_ERR(cpufreq_dt_pdev))

We can fail here and then we will try to use opp_tables which is already freed.

I wonder how this stupid patch made it through the reviews :)

> @@ -163,6 +169,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  			break;
>  		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
>  	}
> +	kfree(opp_tables);
>  
>  	return ret;
>  }

Having said that, there is another problem which I just noticed in the remove()
path where we don't call dev_pm_opp_put_supported_hw(). That will create
problems if we try to remove module of this driver and then reinstall it as the
OPP table was never freed. The fix for that problem needs to go into stable
kernels past 4.18 and so I will abandon this patch and send a new fix which will
fix the issues of $subject patch as well.

-- 
viresh
