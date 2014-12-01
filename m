From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
Date: Mon, 01 Dec 2014 16:56:08 +0000
Message-ID: <547C9DA8.3080403@arm.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org> <23115535.r6kXsReHU2@wuerfel> <547C8423.2090300@arm.com> <2342930.0NFoS1nEgv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46872 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbaLAQ4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 11:56:13 -0500
In-Reply-To: <2342930.0NFoS1nEgv@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, santosh



On 01/12/14 16:03, Arnd Bergmann wrote:
> On Monday 01 December 2014 15:07:15 Sudeep Holla wrote:
>> On 01/12/14 14:11, Arnd Bergmann wrote:
>>> On Monday 01 December 2014 13:35:25 Sudeep Holla wrote:
>>>> On 01/12/14 13:29, Viresh Kumar wrote:
>>>>> On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>> Thanks a lot for working on this, we really need to figure it out one day!
>>>>>
>>>>>
>>>>>
>>>>>> Your patches seem well-implemented, so if everybody thinks the general
>>>>>> approach is the best solution, we should do that. From my point of view,
>>>>>> there are two things I would do differently:
>>>>>>
>>>>>> - In the DT binding, I would strongly prefer anything but the root compatible
>>>>>>      property as the key for the new platforms. Clearly we have to keep using
>>>>>>      it for the backwards-compatibility case, as you do, but I think there
>>>>>>      are more appropriate places to put it. Sorting from most favorite to least
>>>>>>      favorite, my list would be:
>>>>>>            1. a new property in /cpus/
>>>>>>            2. a new property each /cpus/cpu@... node.
>>>>>
>>>>> I did it this way earlier and named it dvfs-method but probably putting this
>>>>> into the /cpus/ node is far better. But then Sudeep asked to utilize
>>>>> compatible property only..
>>>>>
>>>>> Are you fine with the name here? "dvfs-method"
>>>>>
>>>>
>>>> That's right, I don't like driver specific method in the cpu node as you
>>>> initially did. But if it's a property in the chosen node (where we
>>>> usually put the Linux specific properties), I am fine with
>>>> that as Arnd has illustrated in his patch.
>>>
>>> I would prefer the /cpus node over the /chosen node because the former
>>> describes the hardware while the latter is supposed to be user-settable
>>> (on real open-firmware at least). But I think either one is better than
>>> using the / node compatible string.
>>>
>>
>> Agreed, the main reason for objection was that in the initial proposal
>> it was more a Linux configuration rather than hardware property.
>>
>> <dvfs-method> = "cpufreq-dt";
>>
>> I don't see anything hardware feature presented with that. On the other
>> hand, we could represent the some thing like whether the cpu share
>> clock or are they independently clocked as a hardware property in the
>> cpu nodes.
>
> My interpretation of the dvfs-method property is that the string states
> how dvfs works. In particular, it would be used to tell the difference
> between machines that just rely on the clocks and regulators properties
> of the CPU nodes as defined in bindings/cpufreq/cpufreq-dt.txt compared
> to those that need platform-specific properties beyond that. The value
> of the string should indeed not be "cpufreq-dt", as that would be a linux
> implementation detail and inappropriate here.
>

May be I misunderstood, but from Viresh's initial proposal my
understanding was that the value of the property would indicate that it
should use the cpufreq-dt driver and that sounded like Linux specific.

If it's not going to be used in that manner and is what have explained
above, I am fine with that as that's exactly what I am trying to convey
in this thread(though I now realize that I have not been so clear :( )

Regards,
Sudeep

