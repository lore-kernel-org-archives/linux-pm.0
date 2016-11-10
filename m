From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 10:13:55 -0800
Message-ID: <CAKdAkRRWUWmGUFaD=95Zd=wZfqXcs47YXL335Y4A+VmhtdJFTA@mail.gmail.com>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 10:07 AM, Brian Norris <briannorris@chromium.org> wrote:
> It's important that user space can figure out what device woke the
> system from suspend -- e.g., for debugging, or for implementing
> conditional wake behavior. Dedicated wakeup IRQs don't currently do
> that.
>
> Let's report the event (pm_wakeup_event()) and also allow drivers to
> synchronize with these events in their resume path (hence, disable_irq()
> instead of disable_irq_nosync()).

Hmm, dev_pm_disable_wake_irq() is called from
rpm_suspend()/rpm_resume() that take dev->power.lock spinlock and
disable interrupts. Dropping _nosync() feels dangerous.

>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/base/power/wakeirq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 0d77cd6fd8d1..c35b2db1194c 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -139,6 +139,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>         struct wake_irq *wirq = _wirq;
>         int res;
>
> +       pm_wakeup_event(wirq->dev, 0);
> +
>         /* We don't want RPM_ASYNC or RPM_NOWAIT here */
>         res = pm_runtime_resume(wirq->dev);
>         if (res < 0)
> @@ -240,7 +242,7 @@ void dev_pm_disable_wake_irq(struct device *dev)
>         struct wake_irq *wirq = dev->power.wakeirq;
>
>         if (wirq && wirq->dedicated_irq)
> -               disable_irq_nosync(wirq->irq);
> +               disable_irq(wirq->irq);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);
>
> --
> 2.8.0.rc3.226.g39d4020
>



-- 
Dmitry
