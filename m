From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeup: Drop redundant check from device_set_wakeup_enable()
Date: Tue, 2 Jan 2018 14:44:47 +0100
Message-ID: <CAPDyKFqJKQj8+1p=OHPwK=5SoBtZ+JtG1MgPctr2WzHL23ER7w@mail.gmail.com>
References: <2570001.kK8602TLGU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41080 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeABNos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:44:48 -0500
Received: by mail-io0-f193.google.com with SMTP id f6so12646803ioh.8
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 05:44:48 -0800 (PST)
In-Reply-To: <2570001.kK8602TLGU@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 26 December 2017 at 01:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since both device_wakeup_enable() and device_wakeup_disable() check
> if dev is not NULL and whether or not power.can_wakeup is set for it,
> device_set_wakeup_enable() doesn't have to do that, so drop that
> check from it.
>
> No intentional changes in functionality.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/wakeup.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> Index: linux-pm/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -464,9 +464,6 @@ EXPORT_SYMBOL_GPL(device_init_wakeup);
>   */
>  int device_set_wakeup_enable(struct device *dev, bool enable)
>  {
> -       if (!dev || !dev->power.can_wakeup)
> -               return -EINVAL;
> -
>         return enable ? device_wakeup_enable(dev) : device_wakeup_disable(dev);
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>
