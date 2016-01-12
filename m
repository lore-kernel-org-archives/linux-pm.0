From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Tue, 12 Jan 2016 20:40:42 +0200
Message-ID: <569548AA.8090903@ti.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On 12/17/2015 12:48 PM, Jon Hunter wrote:
> Some IRQ chips may be located in a power domain outside of the CPU
> subsystem and hence will require device specific runtime power management.
> In order to support such IRQ chips, add a pointer for a device structure
> to the irq_chip structure, and if this pointer is populated by the IRQ
> chip driver and the flag CHIP_HAS_RPM is set, then the pm_runtime_get/put
> APIs for this chip will be called when an IRQ is requested/freed,
> respectively.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

I've tried to test these patches with OMAP GPIO and I see it works, in general.
"In general" - because OMAP GPIO has some code which is expected to be used
very late during suspend or when entering deep CPUIdle states, so I can't use
this approach "out-of-the-box" until i find the way to sort it out.

Hope some one else can try to test it with GPIO. Soren?

> ---
>   include/linux/irq.h    |  4 ++++
>   kernel/irq/internals.h | 24 ++++++++++++++++++++++++
>   kernel/irq/manage.c    |  7 +++++++
>   3 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 3c1c96786248..7a61a7f76177 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h

...

>   
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2a429b061171..8a96e4f1e985 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1116,6 +1116,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>   	if (!try_module_get(desc->owner))
>   		return -ENODEV;
>   
> +	ret = chip_pm_get(desc);
> +	if (ret < 0)
> +		return ret;
> +
>   	new->irq = irq;
>   
>   	/*
> @@ -1400,6 +1404,7 @@ out_thread:
>   		put_task_struct(t);
>   	}
>   out_mput:
> +	chip_pm_put(desc);
>   	module_put(desc->owner);
>   	return ret;
>   }

Here I still think, that for this solution to be complete It might be good to add additional
API to request/free chained IRQs. This is not usual case for GPIO drivers,
but with AGIC it seems possible. If no objection I can do rfc.


> @@ -1513,6 +1518,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>   		}
>   	}
>   
> +	chip_pm_put(desc);
>   	module_put(desc->owner);
>   	kfree(action->secondary);
>   	return action;
> @@ -1799,6 +1805,7 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
>   
>   	unregister_handler_proc(irq, action);
>   
> +	chip_pm_put(desc);
>   	module_put(desc->owner);
>   	return action;
>   
> 


-- 
regards,
-grygorii
