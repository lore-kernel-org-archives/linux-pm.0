From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Check ignore_children in pm_runtime_need_not_resume()
Date: Mon, 15 Jan 2018 16:05:55 +0100
Message-ID: <CAPDyKFrV2VXJbT1ye8dc10VBp=nzu5vF_j_zbj_Q_=5pA+e34A@mail.gmail.com>
References: <3700531.tJUn8czj9X@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:39398 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbeAOPF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 10:05:56 -0500
Received: by mail-io0-f195.google.com with SMTP id b198so10678326iof.6
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2018 07:05:56 -0800 (PST)
In-Reply-To: <3700531.tJUn8czj9X@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On 15 January 2018 at 01:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Modify pm_runtime_need_not_resume() to make it avoid taking
> power.child_count for devices with power.ignore_children which
> is consistent with the runtime PM usage of these fields.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -1616,7 +1616,8 @@ void pm_runtime_drop_link(struct device
>  static bool pm_runtime_need_not_resume(struct device *dev)
>  {
>         return atomic_read(&dev->power.usage_count) <= 1 &&
> -               atomic_read(&dev->power.child_count) == 0;
> +               (atomic_read(&dev->power.child_count) == 0 ||
> +                dev->power.ignore_children);
>  }
>
>  /**
>
