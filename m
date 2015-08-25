From: pang.xunlei@zte.com.cn
Subject: Re: [PATCH v2 1/3] cpuidle/coupled: Remove cpuidle_device::safe_state_index
Date: Tue, 25 Aug 2015 22:29:20 +0800
Message-ID: <OFBF1C88E5.E5176BB3-ON48257EAC.004F7105-48257EAC.004FA3A8@zte.com.cn>
References: <1438667337-16903-1-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438667337-16903-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-pm@vger.kernel.org

Ping

Xunlei Pang <xlpang@126.com>  wrote 2015-08-04 PM 01:48:55:
> [PATCH v2 1/3] cpuidle/coupled: Remove cpuidle_device::safe_state_index
> 
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> cpuidle_device::safe_state_index need to be initialized before
> use, it should be the same as cpuidle_driver::safe_state_index.
> 
> We tackled this issue by removing the safe_state_index from the
> cpuidle_device structure and use the one in the cpuidle_driver
> structure instead.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
> ---
>  drivers/cpuidle/coupled.c | 4 ++--
>  include/linux/cpuidle.h   | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index 7936dce..6493e40 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -473,7 +473,7 @@ int cpuidle_enter_state_coupled(struct 
> cpuidle_device *dev,
>           return entered_state;
>        }
>        entered_state = cpuidle_enter_state(dev, drv,
> -         dev->safe_state_index);
> +         drv->safe_state_index);
>        local_irq_disable();
>     }
> 
> @@ -521,7 +521,7 @@ retry:
>        }
> 
>        entered_state = cpuidle_enter_state(dev, drv,
> -         dev->safe_state_index);
> +         drv->safe_state_index);
>        local_irq_disable();
>     }
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index d075d34..786ad32 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -84,7 +84,6 @@ struct cpuidle_device {
>     struct list_head    device_list;
> 
>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> -   int         safe_state_index;
>     cpumask_t      coupled_cpus;
>     struct cpuidle_coupled   *coupled;
>  #endif
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (and any attachment transmitted herewith) is privileged and confidential and is intended for the exclusive use of the addressee(s).  If you are not an intended recipient, any disclosure, reproduction, distribution or other dissemination or use of the information contained is strictly prohibited.  If you have received this mail in error, please delete it and notify us immediately.
