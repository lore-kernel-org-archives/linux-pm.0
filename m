From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/3] drm/i915: Move on the new pm runtime interface
Date: Thu, 20 Dec 2018 23:03:28 +0100
Message-ID: <CAPDyKFqZfCoL1N_Ca12mR0sk_JR7EhxchXGR_R3=9dFXu6Qoyw@mail.gmail.com>
References: <1545315417-14483-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545315417-14483-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, jani.nikula@linux.intel.com, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Dec 2018 at 15:17, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Use the new pm runtime interface to get the accounted suspended time:
> pm_runtime_accounted_time_get()

pm_runtime_suspended_time()

This change also makes quite some nice cleanups to the code, which is
mostly because of converting to the new runtime PM API. I think the
changelog deserves to state that, in some simple way.

>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Other than the minor things above:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
>  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d6c8f8f..3f76f60 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/irq.h>
> +#include <linux/pm_runtime.h>
>  #include "i915_pmu.h"
>  #include "intel_ringbuffer.h"
>  #include "i915_drv.h"
> @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                  * counter value.
>                  */
>                 spin_lock_irqsave(&i915->pmu.lock, flags);
> -               spin_lock(&kdev->power.lock);
>
>                 /*
>                  * After the above branch intel_runtime_pm_get_if_in_use failed
> @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                  * suspended and if not we cannot do better than report the last
>                  * known RC6 value.
>                  */
> -               if (kdev->power.runtime_status == RPM_SUSPENDED) {
> -                       if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> -                               i915->pmu.suspended_jiffies_last =
> -                                                 kdev->power.suspended_jiffies;
> +               if (pm_runtime_status_suspended(kdev)) {
> +                       val = pm_runtime_suspended_time(kdev);
>
> -                       val = kdev->power.suspended_jiffies -
> -                             i915->pmu.suspended_jiffies_last;
> -                       val += jiffies - kdev->power.accounting_timestamp;
> +                       if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> +                               i915->pmu.suspended_time_last = val;
>
> -                       val = jiffies_to_nsecs(val);
> +                       val -= i915->pmu.suspended_time_last;
>                         val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>
>                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> @@ -510,7 +507,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                         val = i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>                 }
>
> -               spin_unlock(&kdev->power.lock);
>                 spin_unlock_irqrestore(&i915->pmu.lock, flags);
>         }
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> index 7f164ca..3dc2a30 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.h
> +++ b/drivers/gpu/drm/i915/i915_pmu.h
> @@ -95,9 +95,9 @@ struct i915_pmu {
>          */
>         struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
>         /**
> -        * @suspended_jiffies_last: Cached suspend time from PM core.
> +        * @suspended_time_last: Cached suspend time from PM core.
>          */
> -       unsigned long suspended_jiffies_last;
> +       u64 suspended_time_last;
>         /**
>          * @i915_attr: Memory block holding device attributes.
>          */
> --
> 2.7.4
>
