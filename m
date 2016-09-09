From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V4 3/4] ARM: bcm2835: add thermal node to device-tree of bcm283x
Date: Fri, 9 Sep 2016 20:12:28 +0200
Message-ID: <185DA6B2-AFC0-4199-A361-0164381AD317@martin.sperl.org>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org> <1473407397-29395-4-git-send-email-kernel@martin.sperl.org> <19cc8fbf-6ceb-995e-850d-9d82bdaff8d0@i2se.com> <8876586A-98F8-4AAF-AD90-86EB12C22FDC@martin.sperl.org> <2117811305.32861.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2117811305.32861.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 09.09.2016, at 17:36, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> 
> 
>> Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> hat am 9. September 2016 um 16:58
>> geschrieben:
>> 
>> 
>> 
>>>> On 09.09.2016, at 16:25, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
>>>> 
>>>> Am 09.09.2016 um 09:49 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
>>>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>> 
>>>> Add the node for the thermal sensor of the bcm2835-soc
>>>> to the device tree.
>>>> 
>>>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>> Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>>> ---
>>>> arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>>>> 1 file changed, 6 insertions(+)
>>>> 
>>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi
>>>> b/arch/arm/boot/dts/bcm283x.dtsi
>>>> index b982522..e2e3a46 100644
>>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>>>> @@ -186,6 +186,12 @@
>>>>           interrupts = <2 14>; /* pwa1 */
>>>>       };
>>>> 
>>>> +        thermal: thermal@0x7e212000 {
>>>> +            compatible = "brcm,bcm2835-thermal";
>>>> +            reg = <0x7e212000 0x8>;
>>>> +            clocks = <&clocks BCM2835_CLOCK_TSENS>;
>>>> +        };
>>>> +
>>> 
>>> Since the driver handles 3 different SoC (2835, 2836, 2837). This node
>>> should be defined in the SoC specific dtsi files, because the BCM2836
>>> includes bcm283x.dtsi too.
>>> 
>>> Be aware the patch for bcm2837 must go to ARM64.
>> 
>> I can not really follow:
>> * the node is defined in the dtsi included by all 3 soc,
>>   and it is available on all so it sits where for example
>>   spi0 or uart0 is located
>> * as for arm64: this describes the registers that are
>>   identical for arm and arm64 and the bcm2837.dtsi
>>   is also including ../../../../arm/boot/dts/bcm283x.dtsi
>> 
>> So what is the problem?
> 
> The thermal driver specifies 3 different compatibles with partially different
> settings.
> If this patch is applied, all SoC (bcm2835, bcm2836, bcm2837) would use the
> bcm2835 settings.
> I can't believe this is intended.
> 
> Why does the binding contains 3 different compatibles if only one is used?

Now I understand - did not think of that: good catch!

To minimize the patch: what about setting it to 2837 by default (in 283x.dtsi)
and only change compatible in 2835.dtsi and 2836.dtsi - that is 3 files
changed instead of 4 or 5...

Or any other ideas how to detect which Soc we run on during runtime?
I.e: query the root compatible string in the device-tree?

Just before I create a new patch set to fix that.

Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
