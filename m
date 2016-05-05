From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 5/5] ARM: dts: axp209: Enable
 usb_power_supply by default
Date: Thu, 5 May 2016 19:24:43 +0200
Message-ID: <cc4707a1-4530-69f2-8907-8b5129f1469a@redhat.com>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
 <1462444508-9363-6-git-send-email-haas@computerlinguist.org>
 <f672f0c7-495c-de63-6115-68d57500d874@redhat.com>
 <3512867a-a82c-6be7-35ff-a4f6fb48a259@computerlinguist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3512867a-a82c-6be7-35ff-a4f6fb48a259-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 05-05-16 12:46, Michael Haas wrote:
> Hi Hans,
>
> On 05/05/2016 12:39 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 05-05-16 12:35, Michael Haas wrote:
>>> This node should be enabled by default. A device is likely to have an
>>> USB power
>>> connection. If USB power is indeed absent, the USB power driver
>>> will simply report the power input as offline.
>>
>> Nack, as Maxime already said we do not want to enable any optional
>> features by default. Many top set boxes do not use the usb power supply,
>> and we don't want some userspace power control panel applet showing
>> the supply as offline, we want the supply to simply not be there.
>
> it was my understanding that Maxime [0] and ChenYu [1] indicated they
> would prefer it to be enabled globally.

I believe you're misreading what Maxime is saying, let me
pair things up as I believe they are meant to be interpreted:

You say: "do you have any preference for this being in the AXP209 dtsi? ..."

Maxime says: "Yes, I'd prefer that a lot :)"


You say: "I've been thinking about it and it makes sense to enable the power
supply nodes for all devices using the AXP209."

Maxime says: "It avoids enabling it on all the boards."

IOW having the "status = disabled" in the dtsi avoids enabling it on all
the boards".

I'm pretty sure this is what Maxime's intentions are.


It seems that Chen-Yu does agree with you:

"I see no reason why we shouldn't just enable it by default.
It is almost always going to be used. Same for the VBUS power supply."

Chen-Yu, I disagree with this, IIRC we've had this discussion multiple
times, and so far the rule has always been that we do not want negatives
in the per board dts files. IOW we do not want people to have to add
status = "disabled" to dts files when the usb or ac power supply is not
used, since they are likely to forgot and it just makes the dts files
harder to read in general.

And boards without usb-power (many A10 / A20 / A31 set-top boxes), or
without ac-power (quite a few tablets) are more common then you think.

Regards,

Hans





>
> Best,
>
> Michael
>
> [0] https://groups.google.com/d/msg/linux-sunxi/cHAlhoIw74g/CbBeoX23AAAJ
> [1] https://groups.google.com/d/msg/linux-sunxi/Ee7i8DVI4F8/0b0TBrRkAAAJ
>
>>>
>>> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
>>> ---
>>>  arch/arm/boot/dts/axp209.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/axp209.dtsi
>>> b/arch/arm/boot/dts/axp209.dtsi
>>> index 7deb7d9..4f16be0 100644
>>> --- a/arch/arm/boot/dts/axp209.dtsi
>>> +++ b/arch/arm/boot/dts/axp209.dtsi
>>> @@ -97,7 +97,7 @@
>>>
>>>      usb_power_supply: usb_power_supply {
>>>          compatible = "x-powers,axp202-usb-power-supply";
>>> -        status = "disabled";
>>> +        status = "okay";
>>>      };
>>>
>>>  };
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
