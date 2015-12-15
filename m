From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Add new helper for conditional usage count incrementation
Date: Tue, 15 Dec 2015 15:28:54 +0100
Message-ID: <CAPDyKFo-X766DAZ2yr2L5=KQxXRojGG7tJ6iWHgJiA0==mTvkA@mail.gmail.com>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com>
	<1449949245.2815.20.camel@intel.com>
	<20151212194956.GA2407@nuc-i3427.alporthouse.com>
	<32970649.AWpGt5zezN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36616 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933333AbbLOO2z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 09:28:55 -0500
Received: by mail-qk0-f172.google.com with SMTP id t125so14684953qkh.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 06:28:54 -0800 (PST)
In-Reply-To: <32970649.AWpGt5zezN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Imre Deak <imre.deak@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 14 December 2015 at 23:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce a new runtime PM function, pm_runtime_get_if_in_use(),

As we already have pm_runtime_set_active() and pm_runtime_active(),
changing the new function name to "pm_runtime_get_if_active" may be
better!?

> that will increment the device's runtime PM usage counter and
> return 'true' if its status is RPM_ACTIVE and its usage counter
> is greater than 0 at the same time ('false' will be returned
> otherwise).
>
> This is useful for things that should only be done if the device
> is active (from the runtime PM perspective) and used by somebody
> (as indicated by the usage counter) already and they are not worth
> bothering otherwise.
>
> Requested-by: Imre Deak <imre.deak@intel.com>
> Acked-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/power/runtime_pm.txt |    5 +++++
>  drivers/base/power/runtime.c       |   21 +++++++++++++++++++++
>  include/linux/pm_runtime.h         |    5 +++++
>  3 files changed, 31 insertions(+)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -966,6 +966,27 @@ int __pm_runtime_resume(struct device *d
>  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>
>  /**
> + * pm_runtime_get_if_in_use - Conditionally bump up the device's usage counter.
> + * @dev: Device to handle.
> + *
> + * Increment the device's runtime PM usage counter and return 'true' if its
> + * runtime PM status is RPM_ACTIVE and its usage counter is already different
> + * from zero at the same time.  Otherwise, return 'false'.
> + */
> +bool pm_runtime_get_if_in_use(struct device *dev)
> +{
> +       unsigned long flags;
> +       bool retval;
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +       retval = dev->power.runtime_status == RPM_ACTIVE
> +               && atomic_inc_not_zero(&dev->power.usage_count);

Don't we also need to check that runtime PM is enabled (&&
!dev->power.disable_depth), or the user of this function don't care
about that?

> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +       return retval;
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
> +

[...]

Kind regards
Uffe
