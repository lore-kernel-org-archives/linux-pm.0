From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v10 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Mon, 26 Oct 2015 20:56:37 +0800
Message-ID: <CAGS+omBt56EH2z_jj4ZOaJHqtBcst=EfAyxAK0nC71Ex3Q=55g@mail.gmail.com>
References: <1445441654-31778-1-git-send-email-tomeu.vizoso@collabora.com> <1445441654-31778-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35367 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbbJZM45 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2015 08:56:57 -0400
Received: by ykaz22 with SMTP id z22so183144779yka.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2015 05:56:56 -0700 (PDT)
In-Reply-To: <1445441654-31778-4-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>

Hi Tomeu,

On Wed, Oct 21, 2015 at 11:34 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> If a suitable prepare callback cannot be found for a given device and
> its driver has no PM callbacks at all, assume that it can go direct to
> complete when the system goes to sleep.
>
> The reason for this is that there's lots of devices in a system that do
> no PM at all and there's no reason for them to prevent their ancestors
> to do direct_complete if they can support it.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

[snip...]

> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index a70f8a5cdfd7..763eee24cb95 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -14,6 +14,8 @@
>  #include <linux/acpi.h>
>  #include <linux/pm_domain.h>
>
> +#include "power.h"
> +
>  /**
>   * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
>   * @dev: Device to handle.
> @@ -147,5 +149,6 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
>         WARN(device_is_bound(dev),
>              "PM domains can only be changed for unbound devices\n");
>         dev->pm_domain = pd;
> +       device_pm_check_callbacks(dev);

device_pm_check_callbacks(dev) grabs spin_lock_irq(&dev->power.lock);

But, one of the callers of dev_pm_domain_set() that you just added in
the previous patch "PM / Domains: add setter for dev.pm_domain" also
grabs this same spinlock:

--------------------
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c63d611..b75d02aa8d93 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1240,7 +1240,7 @@  static struct generic_pm_domain_data
*genpd_alloc_dev_data(struct device *dev,
  }

  dev->power.subsys_data->domain_data = &gpd_data->base;
- dev->pm_domain = &genpd->domain;
+ dev_pm_domain_set(dev, &genpd->domain);

  spin_unlock_irq(&dev->power.lock);
--------------------

At least on the board I am testing, this causes a deadlock on boot.

-Dan
