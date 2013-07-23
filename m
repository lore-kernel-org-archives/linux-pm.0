From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] cpuidle: fix cpu idle driver as a module can not remove
Date: Tue, 23 Jul 2013 23:32:53 +0200
Message-ID: <8766398.Myt5gdDlbY@vostro.rjw.lan>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36407 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567Ab3GWVWu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 17:22:50 -0400
In-Reply-To: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tuesday, July 23, 2013 05:28:00 PM Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> The module can not be removed when execute "rmmod". rmmod not use
> "--force".
> 
> Log:
> root:~# rmmod cpuidle-e500
> incs[9], decs[1]
> rmmod: can't unload 'cpuidle_e500': Resource temporarily unavailable
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

Can you please check the current linux-next branch of the linux-pm.git tree
and see if that doesn't conflict with the material in there?

Also please explain in the changelog how your changes help to fix the problem.

Thanks,
Rafael


> ---
> Branch: pm-cpuidle
> 
>  drivers/cpuidle/cpuidle.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index fdc432f..534320a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -386,6 +386,9 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
>  		goto err_coupled;
>  
>  	dev->registered = 1;
> +
> +	module_put(drv->owner);
> +
>  	return 0;
>  
>  err_coupled:
> @@ -432,8 +435,6 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
>   */
>  void cpuidle_unregister_device(struct cpuidle_device *dev)
>  {
> -	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> -
>  	if (dev->registered == 0)
>  		return;
>  
> @@ -448,8 +449,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
>  	cpuidle_coupled_unregister_device(dev);
>  
>  	cpuidle_resume_and_unlock();
> -
> -	module_put(drv->owner);
>  }
>  
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
