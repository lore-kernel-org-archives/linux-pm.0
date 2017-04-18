From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 18 Apr 2017 08:23:45 +0100
Message-ID: <d7c42f4b-2247-0ba7-c199-01788fb1b959@arm.com>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
 <20170417175150.GB10447@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbdDRHXt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 03:23:49 -0400
In-Reply-To: <20170417175150.GB10447@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hey,

I am sorry for delay, it was a holiday period for me.

On 17/04/17 18:51, Eduardo Valentin wrote:
> Hey,
>
> On Mon, Apr 17, 2017 at 10:34:34AM -0700, Eduardo Valentin wrote:
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
>>
>> Or is it more of a optimization in terms of data structures and how
>> things are computed?
>>
>>
>>>
>>> I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
>>> pushed them for 0-day build bot and kernel CI testing as well. We should
>>> know if something is broken with these.
>>
>> Nice. What governors did you try? Have you checked "power_allocator" by
>> any chance?
>>
>>>
>>> @Javi: It would be good if you can give them a test, specially because
>>> of your work on the "power" specific bits in the driver.
>>>
>>
>>
>> @Javi, are you still around? This needs to be validated in terms of how
>> the cdev states and power models are computed. Just to make sure we are
>> in one piece. Copying the ARM folks too, Punit?.
>>
>> I will see if I have some time later this week to check if IPA is in one
>> piece after this series.
>
> Now adding the ARM folks for real.
>
> Lukasz, can you please give it a shot on this series to check if IPA is
> in one piece?
I will run it on my Juno board.
I don't know the changes yet, but I will go through them today.
>
>>
>>> Pushed here as well:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cooling
>>>
>>> V1->V2:
>>> - Name cpufreq cooling dev as cpufreq_cdev everywhere (Eduardo).
>>
>> That was just very minor stuff. Overall, I do not see major issues, but
>> I want to spend some more time on this before acking on my side.

Regards,
Lukasz Luba
