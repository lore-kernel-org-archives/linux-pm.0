From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
Date: Sun, 10 Mar 2013 16:58:19 +0100
Message-ID: <513CAD9B.908@gmail.com>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux@arm.linux.org.uk, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, devicetree-discuss@lists.ozlabs.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,
On 03/07/2013 06:14 PM, Viresh Kumar wrote:
> big LITTLE is ARM's new Architecture focussing power/performance needs of modern
> world. More information about big LITTLE can be found here:
> 
> http://www.arm.com/products/processors/technologies/biglittleprocessing.php
> http://lwn.net/Articles/481055/
> 
> In order to keep cpufreq support for all big LITTLE platforms simple/generic,
> this patch tries to add a generic cpufreq driver layer for all big LITTLE
> platforms.
> 
> The driver is divided into two parts:
> - Core driver: Generic and shared across all big LITTLE SoC's
> - Glue drivers: Per platform drivers providing ops to the core driver
> 
> This patch adds in a generic glue driver which would extract information from
> Device Tree.
> 
> Future SoC's can either reuse the DT glue or write their own depending on the
> need.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[...]
> +void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
> +{
> +	if (arm_bL_ops != ops) {
> +		pr_info("%s: Registered with: %s, can't unregister, exiting\n",
> +				__func__, arm_bL_ops->name);
> +	}

The code is not doing what the info message says.

> +
> +	cpufreq_unregister_driver(&bL_cpufreq_driver);
> +	pr_info("%s: Un-registered platform driver: %s\n", __func__,
> +			arm_bL_ops->name);
> +	arm_bL_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);

--
Francesco
