From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 09/14] cpufreq: cpu0: Move per-cluster initialization
 code to ->init()
Date: Wed, 02 Jul 2014 17:43:04 -0700
Message-ID: <53B4A718.3050702@codeaurora.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <b26946cc4573904cd1ef0212ad053a983b547c23.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <b26946cc4573904cd1ef0212ad053a983b547c23.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, shawn.guo@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On 07/01/14 09:32, Viresh Kumar wrote:
> +static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	struct thermal_cooling_device *cdev;

This..

> +	struct device_node *np;
> +	struct private_data *priv;
> +	
[...]
> ing them.
> @@ -223,28 +242,92 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  				"running cpufreq without cooling device: %ld\n",
>  				PTR_ERR(cdev));
>  	}
> -
>  	of_node_put(np);
> +
> +	priv->cdev = cdev;

Causes a build warning:

drivers/cpufreq/cpufreq-generic.c:313:13: warning: 'cdev' may be used
uninitialized in this function [-Wmaybe-uninitialized]

So I guess we should initialize it to NULL?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
