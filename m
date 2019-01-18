From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
Date: Fri, 18 Jan 2019 04:04:53 -0800
Message-ID: <03a594f1-d6bb-2e29-aac7-034cd2d9af45@roeck-us.net>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net> <20190118104215.GA13168@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118104215.GA13168@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, ulf.hansson@linaro.org
List-Id: linux-pm@vger.kernel.org

On 1/18/19 2:42 AM, Vincent Guittot wrote:
> Hi Guenter,
> 
> Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
>> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
>>> From: Thara Gopinath <thara.gopinath@linaro.org>
>>>
>>> This patch replaces jiffies based accounting for runtime_active_time
>>> and runtime_suspended_time with ktime base accounting. This makes the
>>> runtime debug counters inline with genpd and other pm subsytems which
>>> uses ktime based accounting.
>>>
>>> timekeeping is initialized before pm_runtime_init() so ktime_get() will
>>> be ready before first call. In fact, timekeeping_init() is called early
>>> in start_kernel() which is way before driver_init() (and that's when
>>> devices can start to be initialized) called from rest_init() via
>>> kernel_init_freeable() and do_basic_setup().
>>>
>> This is not (always) correct. My qemu "collie" boot test fails with this
>> patch applied. Reverting the patch fixes the problem. Bisect log attached.
>>
> 
> Can you try the patch below ?
> ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
> it can be used at early_init.
> 
Yes, that works.

Guenter

> ---
>   drivers/base/power/runtime.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index ae1c728..118c7f6 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
>    */
>   void update_pm_runtime_accounting(struct device *dev)
>   {
> -	u64 now = ktime_to_ns(ktime_get());
> +	u64 now = ktime_get_mono_fast_ns();
>   	u64 delta;
>   
>   	delta = now - dev->power.accounting_timestamp;
> @@ -1507,7 +1507,7 @@ void pm_runtime_init(struct device *dev)
>   	dev->power.request_pending = false;
>   	dev->power.request = RPM_REQ_NONE;
>   	dev->power.deferred_resume = false;
> -	dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> +	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>   	INIT_WORK(&dev->power.work, pm_runtime_work);
>   
>   	dev->power.timer_expires = 0;
> 
