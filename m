From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Date: Wed, 3 Jan 2018 12:08:37 -0800
Message-ID: <20180103200837.GP3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com>
 <6120485.xubBpvge6h@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6120485.xubBpvge6h-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

* Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> [171228 17:33]:
> So we are fine except for the race and we need the wakeirq field in wakeup
> sources to automatically arm the wakeup IRQs during suspend.
> 
> If I'm not mistaken, we only need something like the patch below (untested).

Yeah for your patch below works just fine for my
test cases so:

Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  drivers/base/power/wakeirq.c |    9 ++++-----
>  drivers/base/power/wakeup.c  |    2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/base/power/wakeirq.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeirq.c
> +++ linux-pm/drivers/base/power/wakeirq.c
> @@ -33,7 +33,6 @@ static int dev_pm_attach_wake_irq(struct
>  				  struct wake_irq *wirq)
>  {
>  	unsigned long flags;
> -	int err;
>  
>  	if (!dev || !wirq)
>  		return -EINVAL;
> @@ -45,12 +44,12 @@ static int dev_pm_attach_wake_irq(struct
>  		return -EEXIST;
>  	}
>  
> -	err = device_wakeup_attach_irq(dev, wirq);
> -	if (!err)
> -		dev->power.wakeirq = wirq;
> +	dev->power.wakeirq = wirq;
> +	if (dev->power.wakeup)
> +		device_wakeup_attach_irq(dev, wirq);
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
> -	return err;
> +	return 0;
>  }
>  
>  /**
> Index: linux-pm/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -303,7 +303,7 @@ int device_wakeup_attach_irq(struct devi
>  	}
>  
>  	if (ws->wakeirq)
> -		return -EEXIST;
> +		dev_err(dev, "Leftover wakeup IRQ found, overriding\n");
>  
>  	ws->wakeirq = wakeirq;
>  	return 0;
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
