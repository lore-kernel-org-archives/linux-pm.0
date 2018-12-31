From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 2/3] drm/i915: Move on the new pm runtime
 interface
Date: Mon, 31 Dec 2018 12:32:26 +0000
Message-ID: <d15e49e3-8d86-9c25-6412-a8534f1790d4@linux.intel.com>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
 <ae85c6d4-5482-1376-7573-8ece9f78bc61@linux.intel.com>
 <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtDx8u_TnZQnQNmn+=A5A78CPVSWKvMdOVD0UEw4m4s1iQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org


On 21/12/2018 13:26, Vincent Guittot wrote:
> On Fri, 21 Dec 2018 at 12:33, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> Hi,
>>
>> On 21/12/2018 10:33, Vincent Guittot wrote:
>>> Use the new pm runtime interface to get the accounted suspended time:
>>> pm_runtime_suspended_time().
>>> This new interface helps to simplify and cleanup the code that computes
>>> __I915_SAMPLE_RC6_ESTIMATED and to remove direct access to internals of
>>> PM runtime.
>>>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
>>>    drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>>>    2 files changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
>>> index d6c8f8f..3f76f60 100644
>>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>>> @@ -5,6 +5,7 @@
>>>     */
>>>
>>>    #include <linux/irq.h>
>>> +#include <linux/pm_runtime.h>
>>>    #include "i915_pmu.h"
>>>    #include "intel_ringbuffer.h"
>>>    #include "i915_drv.h"
>>> @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>>>                 * counter value.
>>>                 */
>>>                spin_lock_irqsave(&i915->pmu.lock, flags);
>>> -             spin_lock(&kdev->power.lock);
>>>
>>>                /*
>>>                 * After the above branch intel_runtime_pm_get_if_in_use failed
>>> @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
>>>                 * suspended and if not we cannot do better than report the last
>>>                 * known RC6 value.
>>>                 */
>>> -             if (kdev->power.runtime_status == RPM_SUSPENDED) {
>>> -                     if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
>>> -                             i915->pmu.suspended_jiffies_last =
>>> -                                               kdev->power.suspended_jiffies;
>>> +             if (pm_runtime_status_suspended(kdev)) {
>>> +                     val = pm_runtime_suspended_time(kdev);
>>
>> There is a race condition between the status check and timestamp access
>> which the existing code solves by holding the power.lock over it. But I
>> don't exactly remember how this issue was manifesting. Is
>> kdev->power.suspended_jiffies perhaps reset on exit from runtime
>> suspend, which was then underflowing the val, not sure.
>>
>> Anyways, is the new way of doing this safe with regards to this race? In
> 
> AFAICT it is safe.
> The current version does:
> 1-take lock,
> 2-test if dev is suspended
> 3-read some internals field to computed an up-to-date suspended time
> 4-update __I915_SAMPLE_RC6_ESTIMATED
> 5-release lock
> 
> The new version does:
> 1-test if dev is suspended
> 2-get an up-to-date  suspended time with pm_runtime_suspended_time.
> This is atomic and monotonic
> 3-update __I915_SAMPLE_RC6_ESTIMATED
> 
> A change from suspended to another states that happens just before
> step 1 is ok for both as we will run the else if
> No change of the state can happen after step 1 in current code and the
> estimated suspended time will be the time up to step2. In parallel,
> Any state change will have to wait step5 to continue
> If a change from suspended to another state happens after step 1 in
> new code, the suspended time return by PM core will be the time up to
> this change. So I would say you don't delay state transition and you
> get a more accurate estimated suspended time (even if the difference
> should be small).
> If a change from suspended to another state happens after step 2 in
> new code, the suspended time return by PM core will be the time up to
> step 2 so there is no changes
> 
> 
>> other words is the value pm_runtime_suspended_time always monotonic,
>> even when not suspended? If not we have to handle the race somehow.
> 
> Yes pm_runtime_suspended_time is monotonic and stays unchanged when
> not suspended
> 
>>
>> If it is always monotonic, then worst case we report one wrong sample,
>> which I guess is still not ideal since someone could be querying the PMU
>> with quite low frequency.
>>
>> There are tests which probably can hit this, but to run them
>> automatically your patches would need to be rebased on drm-tip and maybe
>> sent to our trybot. I can do that after the holiday break if you are
>> okay with having the series waiting until then.
> 
> yes looks good to me

Looks good to me as well. And our CI agrees with it. So:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I assume you will take the patch through some power related tree and we 
will eventually pull it back to drm-tip.

Regards,

Tvrtko
