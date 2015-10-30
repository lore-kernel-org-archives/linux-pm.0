From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Fri, 30 Oct 2015 15:04:50 +0300
Message-ID: <20151030120450.GH7289@mwanda>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 30, 2015 at 05:26:06PM +0530, Viresh Kumar wrote:
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -124,12 +124,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  	struct device *dev;
>  	int cpu, ret = 0;
>  
> -	rcu_read_lock();
> +	mutex_lock(&dev_opp_list_lock);
>  
>  	dev_opp = _find_device_opp(cpu_dev);
>  	if (IS_ERR(dev_opp)) {
>  		ret = -EINVAL;
> -		goto out_rcu_read_unlock;
> +		goto unlock;
>  	}
>  
>  	for_each_cpu(cpu, cpumask) {
> @@ -150,8 +150,8 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  			continue;
>  		}
>  	}
> -out_rcu_read_unlock:
> -	rcu_read_unlock();
> +unlock:
> +	mutex_unlock(&dev_opp_list_lock);
>  
>  	return 0;

Not introduced by your patch, but this should be "return ret;"

regards,
dan carpenter
