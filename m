From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Allow an irq-safe parent to be runtime suspended
Date: Fri, 1 Dec 2017 08:35:50 +0100
Message-ID: <CAPDyKFq+5mAWyr+4y0F8WCevD5myZ-cbM=Np7rFvYWUPiViCug@mail.gmail.com>
References: <1510924566-16112-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:41680 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdLAHfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 02:35:51 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so1513917ita.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2017 23:35:51 -0800 (PST)
In-Reply-To: <1510924566-16112-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

On 17 November 2017 at 14:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When pm_runtime_irq_safe() is a called for a child device, it's assumed
> that the parent is never also irq-safe. Therefore, is the parent runtime
> resumed and the usage counter increased for it, as to avoid having an
> irq-safe child waiting for non-irq-safe parent.
>
> Improve this behaviour by taking into account that the parent could also be
> irq-safe. In such case let's allow it to be runtime suspended.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, I noticed you applied this for next, but I realized that I
have overlooked a couple of more things that needs to be taken care
of.

Can you please drop this version? I will re-spin a new version soon.

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index ec059750..d44f520 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1370,13 +1370,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
>   * Set the power.irq_safe flag, which tells the PM core that the
>   * ->runtime_suspend() and ->runtime_resume() callbacks for this device should
>   * always be invoked with the spinlock held and interrupts disabled.  It also
> - * causes the parent's usage counter to be permanently incremented, preventing
> - * the parent from runtime suspending -- otherwise an irq-safe child might have
> - * to wait for a non-irq-safe parent.
> + * causes the parent's usage counter to be permanently incremented, unless the
> + * parent is also irq-safe. This prevents the parent from runtime suspending,
> + * otherwise an irq-safe child might have to wait for a non-irq-safe parent.
>   */
>  void pm_runtime_irq_safe(struct device *dev)
>  {
> -       if (dev->parent)
> +       if (dev->parent && !pm_runtime_is_irq_safe(dev->parent))
>                 pm_runtime_get_sync(dev->parent);
>         spin_lock_irq(&dev->power.lock);
>         dev->power.irq_safe = 1;
> @@ -1507,7 +1507,7 @@ void pm_runtime_reinit(struct device *dev)
>                         spin_lock_irq(&dev->power.lock);
>                         dev->power.irq_safe = 0;
>                         spin_unlock_irq(&dev->power.lock);
> -                       if (dev->parent)
> +                       if (dev->parent && !pm_runtime_is_irq_safe(dev->parent))
>                                 pm_runtime_put(dev->parent);
>                 }
>         }
> --
> 2.7.4
>
