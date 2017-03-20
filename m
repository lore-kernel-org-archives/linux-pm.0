From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Mon, 20 Mar 2017 19:01:15 +0100
Message-ID: <f1d03393-ff94-aef8-b999-9d4438a0c7b3@redhat.com>
References: <20170318071019.4561-1-liam@networkimprov.net>
 <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
 <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
 <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
 <f7b3fda0-eeff-b6ab-4908-86c4180bda8a@redhat.com>
 <12321f48-def6-33cb-1df5-853ecc8f1061@redhat.com>
 <20170320052715.hrgaxsxwdrv7ynbu@earth>
 <6de63319-f30f-cae7-6d7a-0df2edd12859@redhat.com>
 <5e7becad-44e4-8cc8-aabb-cc678b03098b@redhat.com>
 <CAKvHMgTLcgtPCbaTAAbEL+deQpnF-mhszBvQW57jH5AXt5o3iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756037AbdCTSCP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 14:02:15 -0400
In-Reply-To: <CAKvHMgTLcgtPCbaTAAbEL+deQpnF-mhszBvQW57jH5AXt5o3iQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 20-03-17 18:51, Liam Breck wrote:
> On Mon, Mar 20, 2017 at 10:04 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 20-03-17 14:54, Hans de Goede wrote:
>>>
>>> Hi,
>>>
>>> On 20-03-17 06:27, Sebastian Reichel wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Sun, Mar 19, 2017 at 10:42:00AM +0100, Hans de Goede wrote:
>>>
>>>
>>> <snip>
>>>
>>>>> We want one driver which is solidly in control of the charger
>>>>> since getting that wrong is quite bad and we want to extend
>>>>> the information it is exporting to userspace in the form of
>>>>> power_supply properties with some extra info.
>>>>>
>>>>> So taking that as a starting point and generalizing that,
>>>>> I think that if we want we can make something more generic then
>>>>> my original patch for this. My idea is to introduce something
>>>>> called a power_supply_properties_provider, with an API
>>>>> like this:
>>>>
>>>>
>>>> Thanks for thinking about this. From what I can see it should
>>>> be enough to just avoid exposing a battery device at all in
>>>> the charger driver, though. It does not really provide useful
>>>> information anyways.
>>>
>>>
>>> Interesting suggestion, 2 remarks / questions:
>>>
>>> 1) Given that we do not want to break existing setups
>>> which may depend on the existing battery interface on the bq24190
>>> driver and add a flag to not register it, or are you suggesting
>>> to simply remove it all together? Removing it all together would
>>> be better from a maintenance pov. Liam, you indicated that you
>>> are the main user of the bq24190 driver currently, do you need
>>> the battery power_supply interface for your use case ?
>>>
>>> 2) Not using the battery interface of the bq24190 driver at all
>>> means that the fuelgauge driver needs to grow some extra
>>> properties, specifically it will need to start reporting status,
>>> something which the bq24190 driver really has a better idea
>>> of the the fuel gauge.
>
> Our userspace looks at bq24190-battery & -charger. If your userspace
> can work with /sys/class/power_supply/whisky_cove-battery/* can't you
> leave .bq24190-battery as is?

No, my userspace is a generic distro which uses upower, which as I
explained before will look at *all* battery type power_supply devices
and will consider each of them being a separate battery. There *must*
be only one battery type power_supply per physical battery, that is
simply how the userspace ABI works.

> bq24190-battery's properties could move to -charger, tho health &
> online would have to change name, replace same in -charger, or be
> dropped.

That is one option, I can also simply make the registration dependent
on a device-property, then you do not need to change your userspace.

In that case I would prefer for the behavior to be to not register
the battery power_supply device unless the boolean device(tree)-property
named "linux,register-battery-power-supply" is present. But if you
need things to keep working the same with older dtb files which
will not contain that property, we can also go for:
"linux,disable-battery-power-supply"

Regards,

Hans
