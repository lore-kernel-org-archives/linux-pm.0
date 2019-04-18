From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date: Thu, 18 Apr 2019 15:57:00 +0200
Message-ID: <4392665.MNVv1Oa0lS@kreacher>
References: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohan Kumar <mohankumar718@gmail.com>
Cc: daniel.lezcano@linaro.org, benh@kernel.crashing.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 17, 2019 4:52:34 PM CEST Mohan Kumar wrote:
> Use pr_debug instead of printk
> 
> WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
> dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe..7cf9835 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
>  	powernv_cpuidle_driver_init();
>  	retval = cpuidle_register(&powernv_idle_driver, NULL);
>  	if (retval) {
> -		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
> +		pr_debug("Registration of powernv driver failed.\n");
>  		return retval;
>  	}
>  
> @@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
>  					   "cpuidle/powernv:dead", NULL,
>  					   powernv_cpuidle_cpu_dead);
>  	WARN_ON(retval < 0);
> -	printk(KERN_DEBUG "powernv_idle_driver registered\n");
> +	pr_debug("powernv_idle_driver registered\n");
>  	return 0;
>  }
>  
> 

Recently, you've sent two different patches against two different drivers with the same subject.

IMO it is fair enough to call that "confusing".

Moreover, pr_debug() is not a direct replacement for printk(KERN_DEBUG ) as the latter does
not require dynamic debug to be enabled and I'm not really sure if you are aware of that
difference.
