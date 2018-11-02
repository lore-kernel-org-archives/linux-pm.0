From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/2] ARM: cpuidle: Don't register the driver when
 back-end init returns -ENXIO
Date: Fri, 2 Nov 2018 12:26:52 +0100
Message-ID: <d7562a0b-393c-9caf-7afc-a196ca1888fd@linaro.org>
References: <20181101122238.4167-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181101122238.4167-1-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Lina Iyer <ilina@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/11/2018 13:22, Ulf Hansson wrote:
> There's no point to register the cpuidle driver for the current CPU, when
> the initialization of the arch specific back-end data fails by returning
> -ENXIO.
> 
> Instead, let's re-order the sequence to its original flow, by first trying
> to initialize the back-end part and then act accordingly on the returned
> error code. Additionally, let's print the error message, no matter of what
> error code that was returned.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: a0d46a3dfdc3 ("ARM: cpuidle: Register per cpuidle device")
> Cc: <stable@vger.kernel.org> # v4.19+

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v2:
> 	- Added a fixes and a stable tag.
> 
> ---
>  drivers/cpuidle/cpuidle-arm.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 073557f433eb..df564d783216 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -103,13 +103,6 @@ static int __init arm_idle_init_cpu(int cpu)
>  		goto out_kfree_drv;
>  	}
>  
> -	ret = cpuidle_register_driver(drv);
> -	if (ret) {
> -		if (ret != -EBUSY)
> -			pr_err("Failed to register cpuidle driver\n");
> -		goto out_kfree_drv;
> -	}
> -
>  	/*
>  	 * Call arch CPU operations in order to initialize
>  	 * idle states suspend back-end specific data
> @@ -117,15 +110,20 @@ static int __init arm_idle_init_cpu(int cpu)
>  	ret = arm_cpuidle_init(cpu);
>  
>  	/*
> -	 * Skip the cpuidle device initialization if the reported
> +	 * Allow the initialization to continue for other CPUs, if the reported
>  	 * failure is a HW misconfiguration/breakage (-ENXIO).
>  	 */
> -	if (ret == -ENXIO)
> -		return 0;
> -
>  	if (ret) {
>  		pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> -		goto out_unregister_drv;
> +		ret = ret == -ENXIO ? 0 : ret;
> +		goto out_kfree_drv;
> +	}
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		if (ret != -EBUSY)
> +			pr_err("Failed to register cpuidle driver\n");
> +		goto out_kfree_drv;
>  	}
>  
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
