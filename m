From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: ARM: locomo: Drop suspend and resume bus type callbacks
Date: Tue, 3 Oct 2017 02:43:25 +0200
Message-ID: <CAJZ5v0irUmtpR9UCt4xR=utXTYW4griiPFPVnD-v0Kpjnh+hgQ@mail.gmail.com>
References: <2826985.0zUqx1lpzM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35954 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdJCAn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2017 20:43:26 -0400
In-Reply-To: <2826985.0zUqx1lpzM@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>
Cc: Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

On Tue, Sep 26, 2017 at 10:45 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> None of the locomo drivers in the tree implements the suspend and
> resume callbacks from struct locomo_driver, so drop them and drop
> the corresponding callbacks from locomo_bus_type.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Any concerns here?

If not, I'd like to queue this up for 4.15.

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
