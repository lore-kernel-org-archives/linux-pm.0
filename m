From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Wed, 13 Jun 2018 22:35:03 +0200
Message-ID: <55e8799f-9af2-f311-72fd-3f52439b5b97@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <1528905257.48473.4.camel@intel.com>
 <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
 <1528920447.48473.11.camel@intel.com>
 <ac38f5d9-80d1-09f2-6f8e-c58085f9a32a@linaro.org>
 <1528921968.48473.15.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528921968.48473.15.camel@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "andrea.parri@amarulasolutions.com" <andrea.parri@amarulasolutions.com>, "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "javi.merino@kernel.org" <javi.merino@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13/06/2018 22:32, Pandruvada, Srinivas wrote:
> On Wed, 2018-06-13 at 22:19 +0200, Daniel Lezcano wrote:
>> On 13/06/2018 22:07, Pandruvada, Srinivas wrote:
>>> On Wed, 2018-06-13 at 22:00 +0200, Daniel Lezcano wrote:
>>>> On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
>>>>> On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
>>>>>> Initially, the cpu_cooling device for ARM was changed by
>>>>>> adding a
>>>>>> new
>>>>>> policy inserting idle cycles. The intel_powerclamp driver
>>>>>> does a
>>>>>> similar action.
>>>>>>
>>>>>> Instead of implementing idle injections privately in the
>>>>>> cpu_cooling
>>>>>> device, move the idle injection code in a dedicated framework
>>>>>> and
>>>>>> give
>>>>>> the opportunity to other frameworks to make use of it.
>>>>>>
>>>>>> The framework relies on the smpboot kthreads which handles
>>>>>> via
>>>>>> its
>>>>>> main loop the common code for hotplugging and [un]parking.
>>>>>>
>>>>>> This code was previously tested with the cpu cooling device
>>>>>> and
>>>>>> went
>>>>>> through several iterations. It results now in split code and
>>>>>> API
>>>>>> exported in the header file. It was tested with the cpu
>>>>>> cooling
>>>>>> device
>>>>>> with success.
>>>>>>
>>>>>
>>>>> May be I have missed, but I don't see any use of powercap
>>>>> sysfs.
>>>>>
>>>>> We created powercap sys that user space is presented a common
>>>>> interface
>>>>> for power capping. The RAPL driver was also submitted as
>>>>> cooling
>>>>> device
>>>>> before, but suggestion was to create this powercap.
>>>>>
>>>>> So if powercap interface is not enough then may be we should
>>>>> enhance
>>>>> that.
>>>>
>>>> We are creating a framework for idle injection. This framework
>>>> can
>>>> then
>>>> be used by the cpu_cooling device, the power_clamp and in
>>>> addition a
>>>> power capping for ARM (if it makes sense).
>>>
>>> But in this case, why in drivers/powercap folder as this is another
>>> framework?
>>
>> I presented at OSPM 2nd the cpu idle cooling device. It is ARM
>> specific
>> but has some similarities with the power clamp driver.
>>
>> Some board come with power numbers defined in their DT and from there
>> we
>> are able to compute a targeted power by injecting idle cycles.
>>
>> As the idle injection allows to do also power capping, Rafael told me
>> to
>> move that to a framework (may be better say a component with exported
>> services or library) and put it in drivers/powercap.
> So Rafael wants it to be in powercap.

That is what I understood.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
