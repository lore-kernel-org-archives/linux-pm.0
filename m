From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: ARM: locomo: Drop suspend and resume bus type callbacks
Date: Tue, 3 Oct 2017 10:09:21 +0200
Message-ID: <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
References: <2826985.0zUqx1lpzM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2826985.0zUqx1lpzM@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <linux@armlinux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 September 2017 at 22:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> None of the locomo drivers in the tree implements the suspend and
> resume callbacks from struct locomo_driver, so drop them and drop
> the corresponding callbacks from locomo_bus_type.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Do you also plan to convert the locomo_device_driver (platform_driver)
to be converted to the modern PM callbacks for suspend/resume?

Kind regards
Uffe

> ---
>  arch/arm/common/locomo.c               |   24 ------------------------
>  arch/arm/include/asm/hardware/locomo.h |    2 --
>  2 files changed, 26 deletions(-)
>
> Index: linux-pm/arch/arm/include/asm/hardware/locomo.h
> ===================================================================
> --- linux-pm.orig/arch/arm/include/asm/hardware/locomo.h
> +++ linux-pm/arch/arm/include/asm/hardware/locomo.h
> @@ -189,8 +189,6 @@ struct locomo_driver {
>         unsigned int            devid;
>         int (*probe)(struct locomo_dev *);
>         int (*remove)(struct locomo_dev *);
> -       int (*suspend)(struct locomo_dev *, pm_message_t);
> -       int (*resume)(struct locomo_dev *);
>  };
>
>  #define LOCOMO_DRV(_d) container_of((_d), struct locomo_driver, drv)
> Index: linux-pm/arch/arm/common/locomo.c
> ===================================================================
> --- linux-pm.orig/arch/arm/common/locomo.c
> +++ linux-pm/arch/arm/common/locomo.c
> @@ -826,28 +826,6 @@ static int locomo_match(struct device *_
>         return dev->devid == drv->devid;
>  }
>
> -static int locomo_bus_suspend(struct device *dev, pm_message_t state)
> -{
> -       struct locomo_dev *ldev = LOCOMO_DEV(dev);
> -       struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
> -       int ret = 0;
> -
> -       if (drv && drv->suspend)
> -               ret = drv->suspend(ldev, state);
> -       return ret;
> -}
> -
> -static int locomo_bus_resume(struct device *dev)
> -{
> -       struct locomo_dev *ldev = LOCOMO_DEV(dev);
> -       struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
> -       int ret = 0;
> -
> -       if (drv && drv->resume)
> -               ret = drv->resume(ldev);
> -       return ret;
> -}
> -
>  static int locomo_bus_probe(struct device *dev)
>  {
>         struct locomo_dev *ldev = LOCOMO_DEV(dev);
> @@ -875,8 +853,6 @@ struct bus_type locomo_bus_type = {
>         .match          = locomo_match,
>         .probe          = locomo_bus_probe,
>         .remove         = locomo_bus_remove,
> -       .suspend        = locomo_bus_suspend,
> -       .resume         = locomo_bus_resume,
>  };
>
>  int locomo_driver_register(struct locomo_driver *driver)
>
