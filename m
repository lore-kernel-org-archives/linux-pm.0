From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: supply: add battery charge voltage/current
Date: Thu, 1 Jun 2017 00:01:00 -0700
Message-ID: <CAKvHMgQWT-V=vt6bkR7QoCRM8W0MeyfY0hjNL-q0FmfPfNhtfA@mail.gmail.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
 <CAKvHMgTvUkJENP=Y_rdge6Oqq-La341nYW5prB=BpXWo7rF-0A@mail.gmail.com> <CAFqH_50+58swMjGOK1oyP0152ap=5Ng1m86q5sdq2Enc08Ui5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33433 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFAHBC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 03:01:02 -0400
In-Reply-To: <CAFqH_50+58swMjGOK1oyP0152ap=5Ng1m86q5sdq2Enc08Ui5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Breck <kernel@networkimprov.net>

Hi Enric,

On Sat, May 27, 2017 at 1:11 PM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hi Liam,
>
> 2017-05-26 23:20 GMT+02:00 Liam Breck <liam@networkimprov.net>:
>> Hi Enric,
>>
>> On Fri, May 26, 2017 at 4:04 AM, Enric Balletbo i Serra
>> <enric.balletbo@collabora.com> wrote:
>>> Add charging voltage and current characteristics to the battery DT for
>>> proper handling of the battery by fuel-gauge and charger chips.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>> Changes since v2:
>>>  - Requested by Sebastian Reichel
>>>    - Move to its own patch and apply to simple-battery framework.
>>> Changes since v1:
>>>  - Requested by Rob Herring
>>>    - Rename ti,charge-* to charge-* to be standard properties.
>>>    - Use unit suffixes as per bindings/property-units.txt
>>>
>>>  Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> index 63a7028..c87a439 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> @@ -12,6 +12,8 @@ Optional Properties:
>>>   - voltage-min-design-microvolt: drained battery voltage
>>>   - energy-full-design-microwatt-hours: battery design energy
>>>   - charge-full-design-microamp-hours: battery design capacity
>>> + - charge-voltage-microvolt: battery charging voltage
>>> + - charge-current-microamp: battery charging current
>>
>> I think you mean constant-charge-* which is how you surface these
>> properties in your tps65217_charger patch.
>>
>
> Yes, to be strict this is constant-charge-*

The DT battery node should carry static battery characteristics. So on
reflection, I think you want

constant-charge-current-max-microamp
constant-charge-voltage-max-microvolt

The charger or the user could then safely apply any value <= those.

Thoughts?

>> I'll add these to v14 of my patchset which adds simple-battery
>> support. Rob requested a single patch for this file.
>>
>
> Ok, I'll send the tps charger series without this patch, so please,
> include this patch in your series.
>
>> I've been waiting for feedback on v13.2 from Sebastian. If I don't
>> hear from him within a few days, I'll post v14.
>>
>>>  Batteries must be referenced by chargers and/or fuel-gauges
>>>  using a phandle. The phandle's property should be named
>>> @@ -24,6 +26,8 @@ Example:
>>>                 voltage-min-design-microvolt = <3200000>;
>>>                 energy-full-design-microwatt-hours = <5290000>;
>>>                 charge-full-design-microamp-hours = <1430000>;
>>> +               charge-voltage-microvolt = <4100000>;
>>> +               charge-current-microamp = <300000>;
>>>         };
>>>
>>>         charger: charger@11 {
>>> --
>>> 2.9.3
>>>
