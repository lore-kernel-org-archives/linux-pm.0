From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers: cpuidle: Fix checkpatch error and warnings
Date: Thu, 07 Sep 2017 03:33:26 -0700
Message-ID: <1504780406.7546.19.camel@perches.com>
References: <20170907102325.GA6427@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907102325.GA6427@kernel>
Sender: linux-kernel-owner@vger.kernel.org
To: gaurav jindal <gauravjindal1104@gmail.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, toddpoynor@google.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-09-07 at 15:53 +0530, gaurav jindal wrote:
> This patch fixes the below checkpatch errors and warnings in
> drivers/cpuidle/cpuidle.c

If you are going to propose a checkpatch only patch,
please run your proposed patch through checkpatch.

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
[]
> 
> @@ -399,9 +400,12 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (cpuidle_curr_governor->enable &&
> -	    (ret = cpuidle_curr_governor->enable(drv, dev)))
> -		goto fail_sysfs;
> +	if (cpuidle_curr_governor->enable) {
> +
> +		ret = cpuidle_curr_governor->enable(drv, dev);
> +		if (ret)
> +			goto fail_sysfs;
> +	}

checkpatch should complain here about unnecessary
blank line after open brace
