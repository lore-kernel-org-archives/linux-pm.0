From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Date: Wed, 04 Jul 2018 17:32:10 +0900
Message-ID: <5B3C860A.8060404@samsung.com>
References: <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcas1p2.samsung.com>
        <20180703132931.14389-1-enric.balletbo@collabora.com>
        <5B3C1DA6.7040507@samsung.com>
        <7fcd3fa4-4f57-9013-b6ff-808600eeb612@collabora.com>
        <5B3C84CC.2030207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5B3C84CC.2030207@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Enric,

Please send this patch to stable-kernel mailing list.

Regards,
Chanwoo Choi

On 2018년 07월 04일 17:26, Chanwoo Choi wrote:
> Hi Enric,
> 
> On 2018년 07월 04일 17:16, Enric Balletbo i Serra wrote:
>> Hi Chanwoo,
>>
>> On 04/07/18 03:06, Chanwoo Choi wrote:
>>> Hi Enric,
>>>
>>> On 2018년 07월 03일 22:29, Enric Balletbo i Serra wrote:
>>>> When the devfreq driver and the governor driver are built as modules,
>>>> the call to devfreq_add_device() or governor_store() fails because the
>>>> governor driver is not loaded at the time the devfreq driver loads. The
>>>> devfreq driver has a build dependency on the governor but also should
>>>> have a runtime dependency. We need to make sure that the governor driver
>>>> is loaded before the devfreq driver.
>>>>
>>>> This patch fixes this bug by adding a try_then_request_governor()
>>>> function. First tries to find the governor, and then, if it is not found,
>>>> it requests the module and tries again.
>>>>
>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>>>>   the unlock of governor_store(). Requested by MyungJoo Ham.
>>>>
>>>> Changes in v3:
>>>> - Remove unneded change in dev_err message.
>>>> - Fix err returned value in case to not find the governor.
>>>>
>>>> Changes in v2:
>>>> - Add a new function to request the module and call that function from
>>>>   devfreq_add_device and governor_store.
>>>>
>>>>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 47 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 0b5b3abe054e..4ea6b19879a1 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -11,6 +11,7 @@
>>>>   */
>>>>  
>>>>  #include <linux/kernel.h>
>>>> +#include <linux/kmod.h>
>>>>  #include <linux/sched.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/err.h>
>>>> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>>>  	return ERR_PTR(-ENODEV);
>>>>  }
>>>>  
>>>> +/**
>>>> + * try_then_request_governor() - Try to find the governor and request the
>>>> + *                               module if is not found.
>>>> + * @name:	name of the governor
>>>
>>> Usually, devfreq used 'governor_name' indicating the name of governor.
>>> you better to use 'governor_name' instead of 'name' for more readability.
>>>
>>
>> I don't mind to change if you want. But let me try to convince you first. I used
>> name for two reasons:
>> 1. I saw that you are using governor_name sometimes, but find_devfreq_governor
>> uses name not governor_name. IMHO the function name in these two specific cases
>> 'try_then_request_governor(name)' is enough readable.
> 
> OK. skip the my comment of changing the variable name. Thanks.
> 
>> 2. If we want to use governor_name and then do not have the line exceeding the
>> 80 characters I need to split the function in two lines. For me the readability
>> is better when you have all in one line.
>>
>> If I did not convince you, just let me now and I'll change for governor_name :)
>>
> 
> (snip)
> 
