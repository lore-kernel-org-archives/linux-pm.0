From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM-runtime: fix deadlock when canceling hrtimer
Date: Thu, 21 Feb 2019 10:35:30 +0100
Message-ID: <CAJZ5v0jEF2=etp=gLY4dchhB5pRjf8NAUnUt4oyC63pCsd1jqQ@mail.gmail.com>
References: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550735942-3569-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Zhaosheng Sun <sunzhaosheng@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 21, 2019 at 8:59 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> When rpm_resume() desactivates the autosuspend timer, it should only try
> to cancel hrtimer but not wait for the handler to finish because both
> rpm_resume() and pm_suspend_timer_fn() are taking the power.lock.
> We can have the deadlock sequence:
> CPU0                              CPU1
> rpm_resume()
>   spin_lock_irqsave
>                                   pm_suspend_timer_fn()
>                                     spin_lock_irqsave
>   pm_runtime_deactivate_timer()
>     hrtimer_cancel()

Everybody has missed this, not good.

> hrtimer_try_to_cancel() is enough because dev->power.timer_expires is also
> set to 0.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Sunzhaosheng Sun(Zhaosheng) <sunzhaosheng@hisilicon.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 04407d9..78937c4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
>  static void pm_runtime_deactivate_timer(struct device *dev)
>  {
>         if (dev->power.timer_expires > 0) {
> -               hrtimer_cancel(&dev->power.suspend_timer);
> +               hrtimer_try_to_cancel(&dev->power.suspend_timer);
>                 dev->power.timer_expires = 0;
>         }
>  }
> --

Applied with some changelog modifications, thanks!
