From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/9] POWERPC: pseries: cpuidle: use the common
 cpuidle_[un]register() routines
Date: Thu, 02 Jan 2014 11:12:29 +0530
Message-ID: <52C4FC45.3040805@linux.vnet.ibm.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1387565251-7051-4-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/21/2013 12:17 AM, Bartlomiej Zolnierkiewicz wrote:
> It is now possible to use the common cpuidle_[un]register() routines
> (instead of open-coding them) so do it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/processor_idle.c | 57 ++-----------------------
>  1 file changed, 3 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index 8aa8c40..94134a5 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -28,7 +28,6 @@ struct cpuidle_driver pseries_idle_driver = {
>  #define MAX_IDLE_STATE_COUNT	2
> 
>  static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
> -static struct cpuidle_device __percpu *pseries_cpuidle_devices;
>  static struct cpuidle_state *cpuidle_state_table;
> 
>  static inline void idle_loop_prolog(unsigned long *in_purr)
> @@ -191,7 +190,7 @@ static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
>  {
>  	int hotcpu = (unsigned long)hcpu;
>  	struct cpuidle_device *dev =
> -			per_cpu_ptr(pseries_cpuidle_devices, hotcpu);
> +			per_cpu_ptr(cpuidle_devices, hotcpu);
> 
>  	if (dev && cpuidle_get_driver()) {
>  		switch (action) {
> @@ -248,48 +247,6 @@ static int pseries_cpuidle_driver_init(void)
>  	return 0;
>  }
> 
> -/* pseries_idle_devices_uninit(void)
> - * unregister cpuidle devices and de-allocate memory
> - */
> -static void pseries_idle_devices_uninit(void)
> -{
> -	int i;
> -	struct cpuidle_device *dev;
> -
> -	for_each_possible_cpu(i) {
> -		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
> -		cpuidle_unregister_device(dev);
> -	}
> -
> -	free_percpu(pseries_cpuidle_devices);
> -	return;
> -}
> -
> -/* pseries_idle_devices_init()
> - * allocate, initialize and register cpuidle device
> - */
> -static int pseries_idle_devices_init(void)
> -{
> -	int i;
> -	struct cpuidle_device *dev;
> -
> -	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> -	if (pseries_cpuidle_devices == NULL)
> -		return -ENOMEM;
> -
> -	for_each_possible_cpu(i) {
> -		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
> -		dev->cpu = i;
> -		if (cpuidle_register_device(dev)) {
> -			printk(KERN_DEBUG \
> -				"cpuidle_register_device %d failed!\n", i);
> -			return -EIO;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * pseries_idle_probe()
>   * Choose state table for shared versus dedicated partition
> @@ -325,19 +282,12 @@ static int __init pseries_processor_idle_init(void)
>  		return retval;
> 
>  	pseries_cpuidle_driver_init();
> -	retval = cpuidle_register_driver(&pseries_idle_driver);
> +	retval = cpuidle_register(&pseries_idle_driver, NULL);
>  	if (retval) {
>  		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
>  		return retval;
>  	}
> 
> -	retval = pseries_idle_devices_init();
> -	if (retval) {
> -		pseries_idle_devices_uninit();
> -		cpuidle_unregister_driver(&pseries_idle_driver);
> -		return retval;
> -	}
> -
>  	register_cpu_notifier(&setup_hotplug_notifier);
>  	printk(KERN_DEBUG "pseries_idle_driver registered\n");
> 
> @@ -348,8 +298,7 @@ static void __exit pseries_processor_idle_exit(void)
>  {
> 
>  	unregister_cpu_notifier(&setup_hotplug_notifier);
> -	pseries_idle_devices_uninit();
> -	cpuidle_unregister_driver(&pseries_idle_driver);
> +	cpuidle_unregister(&pseries_idle_driver);
> 
>  	return;
>  }
> 
