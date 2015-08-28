From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/3] cpuidle/coupled: Add sanity check for safe_state_index
Date: Fri, 28 Aug 2015 16:04:56 +0200
Message-ID: <1492539.aTp0xzx2ya@vostro.rjw.lan>
References: <1438667337-16903-1-git-send-email-xlpang@126.com> <1438667337-16903-3-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49132 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751841AbbH1NhW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 09:37:22 -0400
In-Reply-To: <1438667337-16903-3-git-send-email-xlpang@126.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

On Tuesday, August 04, 2015 01:48:57 PM Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> Since we're using cpuidle_driver::safe_state_index directly as the
> target state index, it's better to add the sanity check at the point
> of registering the driver.
> 
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  drivers/cpuidle/driver.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 5db1478..def299e 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -223,10 +223,23 @@ static void poll_idle_init(struct cpuidle_driver *drv) {}
>  static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
>  	int ret;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +	int i;
> +#endif
>  
>  	if (!drv || !drv->state_count)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +	for (i = drv->state_count - 1; i >= 0; i--) {
> +		if (cpuidle_state_is_coupled(drv, i) &&
> +		    (drv->safe_state_index == i ||
> +		     drv->safe_state_index < 0 ||
> +		     drv->safe_state_index >= drv->state_count))
> +			return -EINVAL;
> +	}
> +#endif

Please move this code to a separate function depending on
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED, define a "return 0" stub of it for
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED unset and call it from here.

Generally, please try to avoid using #ifdef and similar in function bodies
if possible.

> +
>  	if (cpuidle_disabled())
>  		return -ENODEV;
>  
> 

Thanks,
Rafael

