From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 16/27] ARM: cpuidle: Record the next wakeup event of the CPU
Date: Tue, 24 Nov 2015 10:29:19 -0800
Message-ID: <7hr3jfntds.fsf@deeprootsystems.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-17-git-send-email-lina.iyer@linaro.org>
	<7hwptdsgto.fsf@deeprootsystems.com>
	<20151120162835.GC30342@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20151120162835.GC30342@linaro.org> (Lina Iyer's message of "Fri,
	20 Nov 2015 09:28:35 -0700")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Thu, Nov 19 2015 at 16:35 -0700, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> Reading the next wakeup of the CPU can only be realiably done only from
>>> that CPU. In the idle enter path record the next wake up of the CPU. The
>>> information is useful to determine the sleep time left for the CPU.
>>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>>  drivers/cpuidle/cpuidle-arm.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>>> index 8e72a23..b3133ef 100644
>>> --- a/drivers/cpuidle/cpuidle-arm.c
>>> +++ b/drivers/cpuidle/cpuidle-arm.c
>>> @@ -18,9 +18,11 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>> +#include <linux/pm_domain.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/rcupdate.h>
>>> +#include <linux/tick.h>
>>>
>>>  #include <asm/cpuidle.h>
>>>
>>> @@ -49,7 +51,9 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>>  	ret = cpu_pm_enter();
>>>  	if (!ret) {
>>>  		struct device *cpu_dev = get_cpu_device(dev->cpu);
>>> +		struct generic_pm_domain_data *gpd = dev_gpd_data(cpu_dev);
>>>
>>> +		gpd->td.next_wakeup = tick_nohz_get_next_wakeup();
>>>  		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
>>
>>Maybe set this back to zero atomicaly, after wakeup?
>>
>>Checking for non-zero that might be another way for the domain goveror that there
>>haven't been any CPU wakeups since the CPUs have gone idle.
>>
> I set it to 0 below.

Oops, you're right.  Not sure how I missed that.

> The reference counting by the GET_PUT tells the domain if a device is
> suspended. I see that as a redudant information. May be I am not getting
> your point.

It's redundant, but may be helpful in detecting races.  e.g. domain is
being powered off and CPU wakes up and sets this zero, but runtime PM
layers haven't been called yet so dev->power->usage_count is still zero.

Kevin
