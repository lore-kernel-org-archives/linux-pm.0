From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 02/25] thermal/drivers/hisi: Remove the multiple sensors
 support
Date: Tue, 17 Oct 2017 23:10:27 +0200
Message-ID: <ea9784aa-7667-8e76-b970-1542b4ff8aba@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
 <1507658570-32675-2-git-send-email-daniel.lezcano@linaro.org>
 <20171017035409.GA23821@localhost.localdomain>
 <62584345-11d7-1b23-2711-2b663972161b@linaro.org>
 <20171017182547.GA1773@localhost.localdomain>
 <789b9c73-40fa-bc5c-5dd2-9f718beac175@linaro.org>
 <20171017210706.GA3772@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:53900 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760987AbdJQVKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 17:10:33 -0400
Received: by mail-wr0-f176.google.com with SMTP id y44so3040232wry.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2017 14:10:32 -0700 (PDT)
In-Reply-To: <20171017210706.GA3772@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Leo Yan <leo.yan@linaro.org>

On 17/10/2017 23:07, Eduardo Valentin wrote:
> On Tue, Oct 17, 2017 at 09:03:40PM +0200, Daniel Lezcano wrote:
>> On 17/10/2017 20:25, Eduardo Valentin wrote:
>>> Hello,
>>>
>>> On Tue, Oct 17, 2017 at 02:28:27PM +0200, Daniel Lezcano wrote:
>>>> On 17/10/2017 05:54, Eduardo Valentin wrote:
>>>>> On Tue, Oct 10, 2017 at 08:02:27PM +0200, Daniel Lezcano wrote:
>>>>>> By essence, the tsensor does not really support multiple sensor at the same
>>>>>> time. It allows to set a sensor and use it to get the temperature, another
>>>>>> sensor could be switched but with a delay of 3-5ms. It is difficult to read
>>>>>> simultaneously several sensors without a big delay.
>>>>>>
>>>>>
>>>>> Is 3-5 ms enough to loose an event? Is this really a problem?
>>>>
>>>> There are several aspects:
>>>>
>>>>  - the multiple sensors is not needed here
>>>
>>> Well, that is debatable, I cannot really agree or disagree with the
>>> above statement without understanding the use cases and most important,
>>> the location of each sensor. What is the location of each sensor?
>>>
>>>>
>>>>  - the temperature controller is not designed to read several sensors at
>>>> the same time, we switch the sensor and that clears some internal
>>>> buffers and re-init the controller
>>>
>>> Which is still very helpful in case you have multiple hotspots that you
>>> want to track and they are exposed on different workloads. Sacrificing
>>> the availability of sensors is something needs a better justification
>>> other than "current code uses only one".
>>>
>>>
>>>>
>>>>  - some boards can take 40°C in 1 sec, the temperature increase is
>>>> insanely fast and reading several sensors add an extra 15ms.
>>>>
>>>
>>>
>>> Ok... What is the difference in update rate with and without the switch
>>> of sensors? With the above worst case, you have about 4/6 mC/ms. Can
>>> your tsensor support that resolution for a single sensor? What is the
>>> maximum resolution a tsensor can support? What is the penalty added with
>>> switch?
>>>
>>> Based on this data, and the above 3-5ms, that  means you would miss about
>>> ~ 3 - 4 mC while switching ( assuming tsensor can really achieve the
>>> above rate of change: 5ms * 4/6 mC /ms). Are you sure that is
>>> enough justification to drop three extra sensors?
>>
>> Ok if I refer to the documentation the rate is 0.768 ms with the current
>> configuration.
>>
>> The driver is currently bogus: register overwritten, bouncing interrupt,
>> unneeded lock, ... So the proposition was to remove the multiple sensors
>> support, clean the driver, and re-introduce it if there is a need.
>>
>> If I remember correctly Leo, author of the driver, agreed on this. Leo ?
>>
>> Note, I'm not strongly against multiple sensors support in the driver if
>> you think it is convenient but it is much simpler to remove the current
>> code as it is not used and put it back on top of a sane foundation
>> instead of circumventing that on the existing code.
>>
>>
> 
> I am also fine with the above strategy, as long as you are sure you are
> not breaking anyone (specially userspace). Also, it would be good to get
> a reviewed-by from hisilicon just to confirm (Leo?).
> 
> Besides, once you get his reviewed-by, and add it to the patches,
> can you please resend the series with the minor issues I
> mentioned (a few minor checkpatch issues and one compilation warn that
> is added to the driver after the series is applied).

Yes, sure. I'm on it.

I will send it tomorrow.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
