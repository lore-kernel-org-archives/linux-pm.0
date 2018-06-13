From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
Date: Wed, 13 Jun 2018 10:28:11 +0200
Message-ID: <CAPDyKFqEKAfCC3Zp9v4f8xKJ64qt6vvtnzC+jia5SGTEg3x9tg@mail.gmail.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <1692795.7GA92aXxMT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1692795.7GA92aXxMT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

[...]

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>
> If a device link is added via device_link_add() by the driver of the
> link's consumer device, the supplier's runtime PM usage counter is
> going to be dropped by the pm_runtime_put_suppliers() call in
> driver_probe_device().  However, in that case it is not incremented
> unless the supplier driver is already present and the link is not
> stateless.  That leads to a runtime PM usage counter imbalance for
> the supplier device in a few cases.
>
> To prevent that from happening, bump up the supplier runtime
> PM usage counter in device_link_add() for all links with the
> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
> time.  Use pm_runtime_get_noresume() for that as the callers of
> device_link_add() who want the supplier to be resumed by it are
> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
> additionally resume the supplier if the link is added during
> consumer driver probe to retain the existing behavior for the
> callers depending on it.
>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/core.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
>                         link->rpm_active = true;
>                 }
>                 pm_runtime_new_link(consumer);
> +               /*
> +                * If the link is being added by the consumer driver at probe
> +                * time, balance the decrementation of the supplier's runtime PM
> +                * usage counter after consumer probe in driver_probe_device().
> +                */
> +               if (consumer->links.status == DL_DEV_PROBING)
> +                       pm_runtime_get_noresume(supplier);
>         }
>         get_device(supplier);
>         link->supplier = supplier;
> @@ -235,12 +242,12 @@ struct device_link *device_link_add(stru
>                         switch (consumer->links.status) {
>                         case DL_DEV_PROBING:
>                                 /*
> -                                * Balance the decrementation of the supplier's
> -                                * runtime PM usage counter after consumer probe
> -                                * in driver_probe_device().
> +                                * Some callers expect the link creation during
> +                                * consumer driver probe to resume the supplier
> +                                * even without DL_FLAG_RPM_ACTIVE.
>                                  */
>                                 if (flags & DL_FLAG_PM_RUNTIME)
> -                                       pm_runtime_get_sync(supplier);
> +                                       pm_runtime_resume(supplier);
>
>                                 link->status = DL_STATE_CONSUMER_PROBE;
>                                 break;
>
