From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/8] Driver core: wakeup the parent device before
 trying probe
Date: Mon, 15 Jun 2015 13:50:34 +0200
Message-ID: <CAJZ5v0h4s4SVxFGcV-hce=UiSZXA2uMiuaRb09vfSLGkd0sKQQ@mail.gmail.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1434362256-239992-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33169 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbFOLug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:50:36 -0400
In-Reply-To: <1434362256-239992-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Mon, Jun 15, 2015 at 11:57 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> If the parent is still suspended when driver probe is
> attempted, the result may be failure.
>
> For example, if the parent is a PCI MFD device that has been
> suspended when we try to probe our device, any register
> reads will return 0xffffffff.
>
> To fix the problem, making sure the parent is always awake
> before attempting driver probe.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>

Please use my Intel sign-off with this one:

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e843fdb..c4c1eaf 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
>   *
>   * This function must be called with @dev lock held.  When called for a
>   * USB interface, @dev->parent lock must be held as well.
> + *
> + * If the device has a parent, runtime-resume the parent before driver probing.
>   */
>  int driver_probe_device(struct device_driver *drv, struct device *dev)
>  {
> @@ -410,10 +412,16 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>         pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>                  drv->bus->name, __func__, dev_name(dev), drv->name);
>
> +       if (dev->parent)
> +               pm_runtime_get_sync(dev->parent);
> +
>         pm_runtime_barrier(dev);
>         ret = really_probe(dev, drv);
>         pm_request_idle(dev);
>
> +       if (dev->parent)
> +               pm_runtime_put(dev->parent);
> +
>         return ret;
>  }
>
> @@ -459,8 +467,14 @@ int device_attach(struct device *dev)
>                         ret = 0;
>                 }
>         } else {
> +               if (dev->parent)
> +                       pm_runtime_get_sync(dev->parent);
> +
>                 ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
>                 pm_request_idle(dev);
> +
> +               if (dev->parent)
> +                       pm_runtime_put(dev->parent);
>         }
>  out_unlock:
>         device_unlock(dev);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
