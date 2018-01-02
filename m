From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeup: Drop redundant check from device_init_wakeup()
Date: Tue, 2 Jan 2018 14:44:57 +0100
Message-ID: <CAPDyKFo4ohMA9qabaE8cB2co_+GOpiSEZQc-fEqxcug7Qd8zLA@mail.gmail.com>
References: <17840720.nSOd29rnxo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17840720.nSOd29rnxo@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 January 2018 at 01:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since device_wakeup_disable() checks the device's power.can_wakeup
> flag, device_init_wakeup() doesn't need to do that before calling it,
> so drop that redundant check from device_init_wakeup().
>
> No intentional changes in functionality.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/wakeup.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Index: linux-pm/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -448,9 +448,7 @@ int device_init_wakeup(struct device *de
>                 device_set_wakeup_capable(dev, true);
>                 ret = device_wakeup_enable(dev);
>         } else {
> -               if (dev->power.can_wakeup)
> -                       device_wakeup_disable(dev);
> -
> +               device_wakeup_disable(dev);
>                 device_set_wakeup_capable(dev, false);
>         }
>
>
