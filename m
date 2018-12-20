From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/3] PM/runtime: Add a new interface to get accounted time
Date: Thu, 20 Dec 2018 23:03:18 +0100
Message-ID: <CAPDyKFo9GedhCVF4sRxvYzgWCiXK7aPzKnDXPWX5YT+vopAV5g@mail.gmail.com>
References: <1545315385-14384-1-git-send-email-vincent.guittot@linaro.org> <1545315385-14384-2-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545315385-14384-2-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, jani.nikula@linux.intel.com, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Dec 2018 at 15:16, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Some drivers (like i915/drm) needs to get the accounted suspended time.
> pm_runtime_suspended_time() will return the suspended accounted time
> in ns unit.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c | 16 ++++++++++++++++
>  include/linux/pm_runtime.h   |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index beb85c3..e695544 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -86,6 +86,22 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
>         dev->power.runtime_status = status;
>  }
>
> +u64 pm_runtime_suspended_time(struct device *dev)
> +{
> +       unsigned long flags, time;
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +       update_pm_runtime_accounting(dev);
> +
> +       time = dev->power.suspended_jiffies;
> +
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       return jiffies_to_nsecs(time);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> +
>  /**
>   * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index f0fc470..d479707 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
>         return dev->power.irq_safe;
>  }
>
> +extern u64 pm_runtime_suspended_time(struct device *dev);
> +
>  #else /* !CONFIG_PM */
>
>  static inline bool queue_pm_work(struct work_struct *work) { return false; }
> --
> 2.7.4
>
