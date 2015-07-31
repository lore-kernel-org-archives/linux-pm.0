From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
Date: Fri, 31 Jul 2015 11:14:04 +0200
Message-ID: <55BB3C5C.8090905@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
 <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
 <20150731083541.5f2c683a@pluto.restena.lu> <55BB3262.5000403@redhat.com>
 <CAGb2v66+CZe0v=CuYOLfnNwkX70kwPOP28Nya2Y8xw8yrg4-8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGb2v66+CZe0v=CuYOLfnNwkX70kwPOP28Nya2Y8xw8yrg4-8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 31-07-15 11:00, Chen-Yu Tsai wrote:
> On Fri, Jul 31, 2015 at 4:31 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =
wrote:
>> Hi,
>>
>>
>> On 31-07-15 08:35, Bruno Pr=C3=A9mont wrote:
>>>
>>> On Fri, 31 Jul 2015 14:14:28 +0800 Chen-Yu Tsai wrote:
>>>>
>>>> On Fri, Jul 31, 2015 at 1:51 PM, Bruno Pr=C3=A9mont wrote:
>>>>>
>>>>> Hi ChenYu,
>>>>>
>>>>> On Fri, 31 Jul 2015 13:31:53 +0800 Chen-Yu Tsai wrote:
>>>>>>
>>>>>> Hi Hans,
>>>>>>
>>>>>> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede wrote:
>>>>>>>
>>>>>>> Add a node representing the usb power supply part of the axp209=
 pmic,
>>>>>>> note
>>>>>>> that the usb power supply and the (to be added later) ac power =
supply
>>>>>>> will
>>>>>>> each have their own child-node, so that they can be separately
>>>>>>> specified
>>>>>>> as power-supply for other nodes using a power-supply property w=
ith a
>>>>>>> phandle pointing to the right axp209 child-node.
>>>>>>>
>>>>>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>>>> ---
>>>>>>>    arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>>>>>>    1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/axp209.dtsi
>>>>>>> b/arch/arm/boot/dts/axp209.dtsi
>>>>>>> index 24c935c..051ab3b 100644
>>>>>>> --- a/arch/arm/boot/dts/axp209.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/axp209.dtsi
>>>>>>> @@ -89,4 +89,9 @@
>>>>>>>                           regulator-name =3D "ldo5";
>>>>>>>                   };
>>>>>>>           };
>>>>>>> +
>>>>>>> +       usb_power_supply: usb_power_supply {
>>>>>>> +               compatible =3D "x-powers,axp202-usb-power-suppl=
y";
>>>>>>> +               status =3D "disabled";
>>>>>>
>>>>>>
>>>>>> Is there any reason to have this disabled by default?
>>>>>> AFAIK this is not something configurable in hardware,
>>>>>> and the driver just gives readouts and status updates.
>>>>>
>>>>>
>>>>> There are some devices that only have 'AC-IN' instead of usb/otg =
power
>>>>> (set-top boxes) so having the devices tell what power sources the=
y
>>>>> have makes sense (otherwise those that have ac-in instead of otg =
would
>>>>> have to disable usb_power_supply) and avoids confusion by explici=
tly
>>>>> stating presence in device dts.
>>>>
>>>>
>>>> That's true. But this is a bit of hardware inside the AXP.
>>>> If it's power isn't routed, it should report it, shouldn't it?
>>>
>>>
>>> If the device does not use the input there are two cases:
>>> - ac-in and usb/otg in short-circuited (there is a bit in AXP regis=
ters
>>>     to provide this indication)
>>> - the unused one is just not connected/connectable
>>>
>>> In either case the voltage of the unused/unusable branch is not rea=
lly
>>> useful, nor is it useful to have it show up in sysfs.
>>
>>
>> Exactly my thinking on this, +1 .
>>
>>>> And normal users would probably expect to read the input
>>>> voltage/current/status through sysfs (or maybe hwmon?),
>>>> instead of not finding the device and having to look through
>>>> the DTS.
>>>
>>>
>>> Only those supplies effectively present (in-use or with connectors
>>> to eventually use them) should be visible in sysfs.
>>> Having more of them will just confuse the users, they would be sear=
ching
>>> how they can connect the supply while there is no means to do so
>>> except soldering to the tiny AXP pins.
>>
>>
>> +1
>
> OK. So mostly tablets and dev boards would benefit from having both
> power supplies. Is there a preference for usb-power-supply over
> vbus-det-gpio if both are available? Or just list them both and
> let the driver sort it out?

p.s.

Note that the driver can even deal with not having a vbus-det at
all. It will then simulate a vbus drop for long enough to terminate
the current session when ever the id pin changes. This is necessary
for the original cubieboard which has its vbus wired hard to 5V.

This MUST only be used on boards woth broken vbus-det though, having
vbus-det is important to avoid feeding power to the outside when
a charger is plugged in (a charge cable should never pull the id
pin low, but you never know).

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
