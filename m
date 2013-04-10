From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 15/18] ARM: calxeda: cpuidle: use init/exit common routine
Date: Wed, 10 Apr 2013 09:31:27 -0500
Message-ID: <516577BF.1010809@gmail.com>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-16-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:45250 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759088Ab3DJOba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:31:30 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so303482qaj.20
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:31:30 -0700 (PDT)
In-Reply-To: <1365603743-5618-16-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/10/2013 09:22 AM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-calxeda.c |   52 +------------------------------------
>  1 file changed, 1 insertion(+), 51 deletions(-)

For this and patch #5:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> 
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index a3b56f5..e344b56 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -35,8 +35,6 @@
>  extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
>  extern void *scu_base_addr;
>  
> -static struct cpuidle_device __percpu *calxeda_idle_cpuidle_devices;
> -
>  static inline unsigned int get_auxcr(void)
>  {
>  	unsigned int val;
> @@ -85,19 +83,6 @@ static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> -static void calxeda_idle_cpuidle_devices_uninit(void)
> -{
> -	int i;
> -	struct cpuidle_device *dev;
> -
> -	for_each_possible_cpu(i) {
> -		dev = per_cpu_ptr(calxeda_idle_cpuidle_devices, i);
> -		cpuidle_unregister_device(dev);
> -	}
> -
> -	free_percpu(calxeda_idle_cpuidle_devices);
> -}
> -
>  static struct cpuidle_driver calxeda_idle_driver = {
>  	.name = "calxeda_idle",
>  	.states = {
> @@ -117,44 +102,9 @@ static struct cpuidle_driver calxeda_idle_driver = {
>  
>  static int __init calxeda_cpuidle_init(void)
>  {
> -	int cpu_id;
> -	int ret;
> -	struct cpuidle_device *dev;
> -	struct cpuidle_driver *drv = &calxeda_idle_driver;
> -
>  	if (!of_machine_is_compatible("calxeda,highbank"))
>  		return -ENODEV;
>  
> -	ret = cpuidle_register_driver(drv);
> -	if (ret)
> -		return ret;
> -
> -	calxeda_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> -	if (calxeda_idle_cpuidle_devices == NULL) {
> -		ret = -ENOMEM;
> -		goto unregister_drv;
> -	}
> -
> -	/* initialize state data for each cpuidle_device */
> -	for_each_possible_cpu(cpu_id) {
> -		dev = per_cpu_ptr(calxeda_idle_cpuidle_devices, cpu_id);
> -		dev->cpu = cpu_id;
> -		dev->state_count = drv->state_count;
> -
> -		ret = cpuidle_register_device(dev);
> -		if (ret) {
> -			pr_err("Failed to register cpu %u, error: %d\n",
> -			       cpu_id, ret);
> -			goto uninit;
> -		}
> -	}
> -
> -	return 0;
> -
> -uninit:
> -	calxeda_idle_cpuidle_devices_uninit();
> -unregister_drv:
> -	cpuidle_unregister_driver(drv);
> -	return ret;
> +	return cpuidle_register(&calxeda_idle_driver, NULL);
>  }
>  module_init(calxeda_cpuidle_init);
> 

