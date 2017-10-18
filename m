From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 02/25] thermal/drivers/hisi: Remove the multiple sensors
 support
Date: Wed, 18 Oct 2017 18:23:30 +0200
Message-ID: <e169f500-2a70-e946-8704-5cb94b4a90ae@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
 <1507658570-32675-2-git-send-email-daniel.lezcano@linaro.org>
 <20171017035409.GA23821@localhost.localdomain>
 <62584345-11d7-1b23-2711-2b663972161b@linaro.org>
 <20171017182547.GA1773@localhost.localdomain>
 <789b9c73-40fa-bc5c-5dd2-9f718beac175@linaro.org>
 <20171017210706.GA3772@localhost.localdomain>
 <20171018014821.GE19504@leoy-ThinkPad-T440>
 <20171018155104.GA23447@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018155104.GA23447@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Leo Yan <leo.yan@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

On 18/10/2017 17:51, Eduardo Valentin wrote:
> On Wed, Oct 18, 2017 at 09:48:21AM +0800, Leo Yan wrote:
>> On Tue, Oct 17, 2017 at 02:07:08PM -0700, Eduardo Valentin wrote:
>>> On Tue, Oct 17, 2017 at 09:03:40PM +0200, Daniel Lezcano wrote:
>>>> On 17/10/2017 20:25, Eduardo Valentin wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue, Oct 17, 2017 at 02:28:27PM +0200, Daniel Lezcano wrote:
>>>>>> On 17/10/2017 05:54, Eduardo Valentin wrote:
>>>>>>> On Tue, Oct 10, 2017 at 08:02:27PM +0200, Daniel Lezcano wrote:
>>>>>>>> By essence, the tsensor does not really support multiple sensor at the same
>>>>>>>> time. It allows to set a sensor and use it to get the temperature, another
>>>>>>>> sensor could be switched but with a delay of 3-5ms. It is difficult to read
>>>>>>>> simultaneously several sensors without a big delay.
>>>>>>>>
>>>>>>>
>>>>>>> Is 3-5 ms enough to loose an event? Is this really a problem?
>>>>>>
>>>>>> There are several aspects:
>>>>>>
>>>>>>  - the multiple sensors is not needed here
>>>>>
>>>>> Well, that is debatable, I cannot really agree or disagree with the
>>>>> above statement without understanding the use cases and most important,
>>>>> the location of each sensor. What is the location of each sensor?
>>>>>
>>>>>>
>>>>>>  - the temperature controller is not designed to read several sensors at
>>>>>> the same time, we switch the sensor and that clears some internal
>>>>>> buffers and re-init the controller
>>>>>
>>>>> Which is still very helpful in case you have multiple hotspots that you
>>>>> want to track and they are exposed on different workloads. Sacrificing
>>>>> the availability of sensors is something needs a better justification
>>>>> other than "current code uses only one".
>>>>>
>>>>>
>>>>>>
>>>>>>  - some boards can take 40°C in 1 sec, the temperature increase is
>>>>>> insanely fast and reading several sensors add an extra 15ms.
>>>>>>
>>>>>
>>>>>
>>>>> Ok... What is the difference in update rate with and without the switch
>>>>> of sensors? With the above worst case, you have about 4/6 mC/ms. Can
>>>>> your tsensor support that resolution for a single sensor? What is the
>>>>> maximum resolution a tsensor can support? What is the penalty added with
>>>>> switch?
>>>>>
>>>>> Based on this data, and the above 3-5ms, that  means you would miss about
>>>>> ~ 3 - 4 mC while switching ( assuming tsensor can really achieve the
>>>>> above rate of change: 5ms * 4/6 mC /ms). Are you sure that is
>>>>> enough justification to drop three extra sensors?
>>>>
>>>> Ok if I refer to the documentation the rate is 0.768 ms with the current
>>>> configuration.
>>>>
>>>> The driver is currently bogus: register overwritten, bouncing interrupt,
>>>> unneeded lock, ... So the proposition was to remove the multiple sensors
>>>> support, clean the driver, and re-introduce it if there is a need.
>>>>
>>>> If I remember correctly Leo, author of the driver, agreed on this. Leo ?
>>>>
>>>> Note, I'm not strongly against multiple sensors support in the driver if
>>>> you think it is convenient but it is much simpler to remove the current
>>>> code as it is not used and put it back on top of a sane foundation
>>>> instead of circumventing that on the existing code.
>>>>
>>>>
>>>
>>> I am also fine with the above strategy, as long as you are sure you are
>>> not breaking anyone (specially userspace). Also, it would be good to get
>>> a reviewed-by from hisilicon just to confirm (Leo?).
>>
>> Sorry I missed to reply this patch. And yes, I have tested and
>> reviewed it at my side:
>>
>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>>
>> P.s. I am working for Linaro; I am continously co-working with
>> Hisilicon to maintain this driver due it's important for Hikey/Hikey960
>> two boards stability; this driver also is important for our daily
>> profiling for power and performance. Eduardo, so please let us know if
>> you still need ack from Hisilicon engineer.
> 
> 
> Yeah, I think adding your Reviewed-by and Kevin's is enough for this
> series to go through. As I asked Daniel already, only few minor stuff
> needs to be fixed along with the addition of the reviewed-by's.

The different warnings you reported are fixed and the reviewed-by's /
acked-by's added. I think the patches 19-25 may need an extra look, so I
will resend all the other patches meanwhile.

Does it sound good?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
