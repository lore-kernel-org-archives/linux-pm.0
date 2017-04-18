From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 18 Apr 2017 15:40:15 +0100
Message-ID: <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
 <20170418103818.GQ28191@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdDROkT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 10:40:19 -0400
In-Reply-To: <20170418103818.GQ28191@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

I have checkout your branch at newest commit:
908063832c268f8add94
I have built it and run it on my Juno r2.
I have some python tests for IPA and I run one of them.

I seen a few issues so I have created a patch just
to be able to run IPA.
My next email will have the patch so you can see the changes.

IPA does not work with this patch set.
I have tested two source codes from your repo:
1. your change 908063832c268f8add94
2. your base 8f506e0faf4e2a4a0bde9f9b1

In case 1. IPA does not work - temperature rises to 83degC
in case 2. works - temperature is limited to 65degC.

On Monday I can allocate more time for it.

Regards,
Lukasz


On 18/04/17 11:38, Viresh Kumar wrote:
> On 17-04-17, 10:34, Eduardo Valentin wrote:
>> Hey,
>>
>> On Mon, Apr 17, 2017 at 11:31:45AM +0530, Viresh Kumar wrote:
>>> Hi Guys,
>>>
>>> The cpu_cooling driver is designed to use CPU frequency scaling to avoid
>>> high thermal states for a platform. But it wasn't glued really well with
>>> cpufreq core.
>>>
>>> This series tries to improve interactions between cpufreq core and
>>> cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
>>> driver.
>>
>>
>> Can you please be more specific of what exactly is not gluing
>> properly/really well? I like refactoring, as long as well justified.
>>
>> Do you see anything broken currently?
>
> It wasn't broken really but the same information is scattered around
> and it wasn't clear on which one is the best one refer. For example,
> clipped-cpus is copied from the policy structure, but the policy->cpus
> thing can get updated later on, while the clipped-cpus never got
> updated. It makes more sense to get rid of the copies we are keeping
> and reuse the real fields, i.e. use the cpufreq policy directly in
> cpu_cooling.
>
> And then it caused lots of cleanups as well..
>
>>> I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
>>> pushed them for 0-day build bot and kernel CI testing as well. We should
>>> know if something is broken with these.
>>
>> Nice. What governors did you try? Have you checked "power_allocator" by
>> any chance?
>
> I tried setting all the governors including power_allocator on my
> exynos board, and didn't see anything broken. My branch also got
> tested by kernel CI bot for build and boot tests on a wide range of
> ARM boards and I didn't see any bad reports due to this set. So it
> should be okay.
>
>>>
>>> @Javi: It would be good if you can give them a test, specially because
>>> of your work on the "power" specific bits in the driver.
>>>
>>
>>
>> @Javi, are you still around? This needs to be validated in terms of how
>> the cdev states and power models are computed. Just to make sure we are
>> in one piece. Copying the ARM folks too, Punit?.
>
> And yes, I specifically wanted Javi (or some other ARM guy) to test
> this stuff out. Looks like Lukasz will help out now.
>
> Thanks to all of you :)
>
