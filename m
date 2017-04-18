From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] power: bq24190_charger: Deprecate battery class
 and replicate its features in charger
Date: Tue, 18 Apr 2017 13:49:03 +0200
Message-ID: <d143be31-1aaf-5007-baa3-c01b4818c626@redhat.com>
References: <20170416230626.30022-1-liam@networkimprov.net>
 <aaf8c54b-aac8-9ccd-cd17-4b318f4520c2@redhat.com>
 <CAKvHMgQGWur8JgYjJ1uh12_JHPTSRAPo8EcwBPgvygWBFjceNw@mail.gmail.com>
 <c02691e1-cbcc-078b-5e12-bcef0e19d98a@redhat.com>
 <CAKvHMgRRyAUvWdYvFMoNNDF6hAx1KqKoSLr+-_cW+3ZT7z3PGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdDRLtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 07:49:06 -0400
In-Reply-To: <CAKvHMgRRyAUvWdYvFMoNNDF6hAx1KqKoSLr+-_cW+3ZT7z3PGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 18-04-17 12:27, Liam Breck wrote:
> On Tue, Apr 18, 2017 at 3:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 18-04-17 11:42, Liam Breck wrote:
>>>
>>> Hi Hans,
>>>
>>> On Tue, Apr 18, 2017 at 1:05 AM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi Liam,
>>>>
>>>> On 17-04-17 01:06, Liam Breck wrote:
>>>>>
>>>>>
>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>
>>>>> The driver was registering two classes, bq24190-battery & -charger.
>>>>> Because the power supply framework cannot surface features from multiple
>>>>> drivers in a single class, a fuel gauge driver would create a third
>>>>> class,
>>>>> which some power management utilities cannot see.
>>>>>
>>>>> Deprecate the -battery class for future removal and replicate its
>>>>> features
>>>>> in -charger. Set /sys/class...-charger/online = pg_stat &&
>>>>> !batfet_disable.
>>>>> If device_property "omit-battery-class" is set, don't register -battery.
>>>>>
>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>
>>>>
>>>>
>>>> Thank you for writing this patch.
>>>
>>>
>>> Glad to help!
>>>
>>>> The patch looks good to me:
>>>
>>>
>>> Darn, I was hoping you'd see *something* amiss in all that clutter :-)
>>
>>
>> Wel, I did not find the forward declaration of bq24190_battery_set_online
>> and friends pretty, but I can understand why you did this and we can
>> clean that up when we remove the battery interface altogether later.
>
> Blame the C standards crew for that mess :-)
>
>>> Do you think charger-powered and battery-connected is the right
>>> definition of power_supply_prop_online?
>>
>>
>> Now that you specifically ask I've been thinking a bit more this,
>> but I still can't find anything wrong with that as definition :)
>
> The power_supply_class docs really should tell us how to define this.
>
>>> Sebastian had suggested surfacing the batfet as a regulator, but altho
>>> user settable, it's a binary widget.
>>
>>
>> Turning off the batfet typically will turn off the entire system,
>> I believe it is more of an emergency break style switch which gets
>> thrown by the charger under certain (very bad) conditions then
>> something which we would actually ever want to use / control from
>> within the kernel.
>
> It's supposed to be disabled at the factory prior to shipping to avoid
> depleting the battery before product reaches buyer. The same should
> also be done for storage. So it can be an end-user switch.

True.

Regards,

Hans
