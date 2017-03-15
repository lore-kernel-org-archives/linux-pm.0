From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 1/9] devicetree: power: Add battery.txt
Date: Wed, 15 Mar 2017 15:10:18 -0500
Message-ID: <CAL_Jsq+8Y=GtyjVZA-suZLH+ySDshaoU9qh96BF+PeUYK3FZxg@mail.gmail.com>
References: <20170227071117.18934-1-liam@networkimprov.net>
 <20170227071117.18934-2-liam@networkimprov.net> <20170302151449.j7i3ecpy2ipxu6tq@rob-hp-laptop>
 <CAKvHMgR6eVTUp6je3D_YDUMAksWiHx6JnJc8cRHSHp6tj30OPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdCOUKn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 16:10:43 -0400
In-Reply-To: <CAKvHMgR6eVTUp6je3D_YDUMAksWiHx6JnJc8cRHSHp6tj30OPA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 2, 2017 at 12:31 PM, Liam Breck <liam@networkimprov.net> wrote:
> Hi Rob,
>
> On Thu, Mar 2, 2017 at 7:14 AM, Rob Herring <robh@kernel.org> wrote:
>> On Sun, Feb 26, 2017 at 11:11:09PM -0800, Liam Breck wrote:
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Documentation of static battery characteristics that can be defined
>>> for batteries which cannot self-identify. This information is required
>>> by fuel-gauge and charger chips for proper handling of the battery.
>>>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  .../devicetree/bindings/power/supply/battery.txt   | 42 ++++++++++++++++++++++
>>>  1 file changed, 42 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> new file mode 100644
>>> index 0000000..3d916bd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> @@ -0,0 +1,42 @@
>>> +Battery Characteristics
>>> +
>>> +Required Properties:
>>> + - compatible: Must be "fixed-battery"
>>
>> Still not liking this name, but I don't have a better suggestion. Please
>> describe here what is and isn't a "fixed battery".
>
> Sebastian...?
>
>>> +
>>> +Optional Properties:
>>> + - voltage-min-design-microvolt: drained battery voltage
>>> + - energy-full-design-microwatt-hours: battery design energy
>>> + - charge-full-design-microamp-hours: battery design capacity
>>> +
>>> +Future Properties must be named for the corresponding elements in
>>> +enum power_supply_property, defined in include/linux/power_supply.h.
>>
>> Um, no. That's exactly not how DT bindings should be done.
>
> Power supply components surface stats in sysfs using the names in enum
> power_supply_property. For example,
> /sys/class/power_supply/.../voltage_min_design. Matching input (DT)
> and output (sysfs) names is sensible. The above comment is already
> attached to struct power_supply_battery_info, which is the initial
> destination for the above DT properties.
>
> Shall I mention sysfs in the above comment?

Absolutely not. Bindings should not reference Linux.

While sometimes things can align, there is no guarantee that they
will. DT is h/w description. sysfs is user configuration.

Rob
