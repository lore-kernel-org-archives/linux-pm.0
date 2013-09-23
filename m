From: Hongbo Zhang <hongbo.zhang@freescale.com>
Subject: Re: [PATCH 05/21] cpuidle: make __cpuidle_driver_init() return void
Date: Mon, 23 Sep 2013 17:58:39 +0800
Message-ID: <524010CF.6030605@freescale.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <70ae3eb991bded7c9768ae7934973943c2a1bf05.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:37164 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753411Ab3IWJ6x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2013 05:58:53 -0400
In-Reply-To: <70ae3eb991bded7c9768ae7934973943c2a1bf05.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org

On 09/22/2013 09:20 AM, Viresh Kumar wrote:
> __cpuidle_driver_init() doesn't return anything except zero and so doesn't
> really need a return type other than void.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpuidle/driver.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 25455e8..8df66c8 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -152,7 +152,7 @@ static void cpuidle_setup_broadcast_timer(void *arg)
>    *
>    * Returns 0 on success, a negative error code otherwise.
If you want to make it return void, you should also update the above 
comment.
>    */
> -static int __cpuidle_driver_init(struct cpuidle_driver *drv)
> +static void __cpuidle_driver_init(struct cpuidle_driver *drv)
>   {
>   	int i;
>   
> @@ -179,8 +179,6 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>   		drv->bctimer = 1;
>   		break;
>   	}
> -
> -	return 0;
>   }
>   
>   /**
> @@ -206,9 +204,7 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>   	if (cpuidle_disabled())
>   		return -ENODEV;
>   
> -	ret = __cpuidle_driver_init(drv);
> -	if (ret)
> -		return ret;
> +	__cpuidle_driver_init(drv);
>   
>   	ret = __cpuidle_set_driver(drv);
>   	if (ret)



