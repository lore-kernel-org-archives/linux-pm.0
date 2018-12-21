From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime
 interface
Date: Fri, 21 Dec 2018 11:33:07 +0000
Message-ID: <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: ulf.hansson@linaro.org
List-Id: linux-pm@vger.kernel.org


Hi,

On 21/12/2018 10:33, Vincent Guittot wrote:
> Use the new pm runtime interface to get the accounted suspended time:
> pm_runtime_suspended_time().
> This new interface helps to simplify and cleanup the code that computes
> __I915_SAMPLE_RC6_ESTIMATED and to remove direct access to internals of
> PM runtime.
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
>   drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>   2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d6c8f8f..3f76f60 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/irq.h>
> +#include <linux/pm_runtime.h>
>   #include "i915_pmu.h"
>   #include "intel_ringbuffer.h"
>   #include "i915_drv.h"
> @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>   		 * counter value.
>   		 */
>   		spin_lock_irqsave(&i915->pmu.lock, flags);
> -		spin_lock(&kdev->power.lock);
>   
>   		/*
>   		 * After the above branch intel_runtime_pm_get_if_in_use failed
> @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
>   		 * suspended and if not we cannot do better than report the last
>   		 * known RC6 value.
>   		 */
> -		if (kdev->power.runtime_status == RPM_SUSPENDED) {
> -			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> -				i915->pmu.suspended_jiffies_last =
> -						  kdev->power.suspended_jiffies;
> +		if (pm_runtime_status_suspended(kdev)) {
> +			val = pm_runtime_suspended_time(kdev);

There is a race condition between the status check and timestamp access 
which the existing code solves by holding the power.lock over it. But I 
don't exactly remember how this issue was manifesting. Is 
kdev->power.suspended_jiffies perhaps reset on exit from runtime 
suspend, which was then underflowing the val, not sure.

Anyways, is the new way of doing this safe with regards to this race? In 
other words is the value pm_runtime_suspended_time always monotonic, 
even when not suspended? If not we have to handle the race somehow.

If it is always monotonic, then worst case we report one wrong sample, 
which I guess is still not ideal since someone could be querying the PMU 
with quite low frequency.

There are tests which probably can hit this, but to run them 
automatically your patches would need to be rebased on drm-tip and maybe 
sent to our trybot. I can do that after the holiday break if you are 
okay with having the series waiting until then.

Regards,

Tvrtko

>   
> -			val = kdev->power.suspended_jiffies -
> -			      i915->pmu.suspended_jiffies_last;
> -			val += jiffies - kdev->power.accounting_timestamp;
> +			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> +				i915->pmu.suspended_time_last = val;
>   
> -			val = jiffies_to_nsecs(val);
> +			val -= i915->pmu.suspended_time_last;
>   			val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>   
>   			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> @@ -510,7 +507,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>   			val = i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>   		}
>   
> -		spin_unlock(&kdev->power.lock);
>   		spin_unlock_irqrestore(&i915->pmu.lock, flags);
>   	}
>   
> diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> index 7f164ca..3dc2a30 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.h
> +++ b/drivers/gpu/drm/i915/i915_pmu.h
> @@ -95,9 +95,9 @@ struct i915_pmu {
>   	 */
>   	struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
>   	/**
> -	 * @suspended_jiffies_last: Cached suspend time from PM core.
> +	 * @suspended_time_last: Cached suspend time from PM core.
>   	 */
> -	unsigned long suspended_jiffies_last;
> +	u64 suspended_time_last;
>   	/**
>   	 * @i915_attr: Memory block holding device attributes.
>   	 */
> 
