From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v8 1/9] devicetree: power: Add battery.txt
Date: Wed, 15 Mar 2017 23:45:35 -0700
Message-ID: <CAKvHMgQujE4uYNt0vPkt6qUOtVqdvzXs0zXTkDVRq9YLNvunBQ@mail.gmail.com>
References: <20170227071117.18934-1-liam@networkimprov.net>
 <20170227071117.18934-2-liam@networkimprov.net> <20170302151449.j7i3ecpy2ipxu6tq@rob-hp-laptop>
 <CAKvHMgR6eVTUp6je3D_YDUMAksWiHx6JnJc8cRHSHp6tj30OPA@mail.gmail.com>
 <CAL_Jsq+8Y=GtyjVZA-suZLH+ySDshaoU9qh96BF+PeUYK3FZxg@mail.gmail.com>
 <CAKvHMgTpqdNKQoWUsChn4YWTtWaN5un_Vpqp+HtbMrxGV_D-ig@mail.gmail.com> <CAL_JsqJOFUSRY_KPzwNWrx4FF1_F6XNK8OfkqhqgBpxH9WrZeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJOFUSRY_KPzwNWrx4FF1_F6XNK8OfkqhqgBpxH9WrZeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 15, 2017 at 4:50 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Mar 15, 2017 at 5:04 PM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
>> On Wed, Mar 15, 2017 at 1:10 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Thu, Mar 2, 2017 at 12:31 PM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
>>>> Hi Rob,
>>>>
>>>> On Thu, Mar 2, 2017 at 7:14 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>>> On Sun, Feb 26, 2017 at 11:11:09PM -0800, Liam Breck wrote:
>>>>>> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>>>>>>
>>>>>> Documentation of static battery characteristics that can be defined
>>>>>> for batteries which cannot self-identify. This information is required
>>>>>> by fuel-gauge and charger chips for proper handling of the battery.
>>>>>>
>>>>>> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>>>>>> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>>>>>> ---
>>>>>>  .../devicetree/bindings/power/supply/battery.txt   | 42 ++++++++++++++++++++++
>>>>>>  1 file changed, 42 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..3d916bd
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>> @@ -0,0 +1,42 @@
>>>>>> +Battery Characteristics
>>>>>> +
>>>>>> +Required Properties:
>>>>>> + - compatible: Must be "fixed-battery"
>>>>>
>>>>> Still not liking this name, but I don't have a better suggestion. Please
>>>>> describe here what is and isn't a "fixed battery".
>>>>
>>>> Sebastian...?
>>>>
>>>>>> +
>>>>>> +Optional Properties:
>>>>>> + - voltage-min-design-microvolt: drained battery voltage
>>>>>> + - energy-full-design-microwatt-hours: battery design energy
>>>>>> + - charge-full-design-microamp-hours: battery design capacity
>>>>>> +
>>>>>> +Future Properties must be named for the corresponding elements in
>>>>>> +enum power_supply_property, defined in include/linux/power_supply.h.
>>>>>
>>>>> Um, no. That's exactly not how DT bindings should be done.
>>>>
>>>> Power supply components surface stats in sysfs using the names in enum
>>>> power_supply_property. For example,
>>>> /sys/class/power_supply/.../voltage_min_design. Matching input (DT)
>>>> and output (sysfs) names is sensible. The above comment is already
>>>> attached to struct power_supply_battery_info, which is the initial
>>>> destination for the above DT properties.
>>>>
>>>> Shall I mention sysfs in the above comment?
>>>
>>> Absolutely not. Bindings should not reference Linux.
>>>
>>> While sometimes things can align, there is no guarantee that they
>>> will. DT is h/w description. sysfs is user configuration.
>>
>> sysfs for power_supply also provides fixed hw characteristics.
>>
>> Sebastian proposed DT:battery specifically to be consumed by
>> power_supply_core. Allowing names in DT:battery and
>> power_supply_property to diverge would cause confusion and wasted
>> time, for no particular benefit. As there is no rationale to
>> reconsider the names of these fields for DT:battery, let's write that
>> into the docs.
>
> Write it into the Linux docs then. The DT docs need to stand on their
> own for the standalone DT tree[1] that other projects import.

We will document it on the Linux side. But referencing a Linux header
file as the origin of property names in DT;battery does not create a
Linux dependency for standalone DT. It merely clarifies the naming
scheme.

Also a huge number of DT bindings are Linux-specific, as they are
implemented by some kernel driver. Do you plan to rip those out of
devicetree-rebasing?

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
