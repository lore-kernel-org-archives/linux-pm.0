From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
Date: Fri, 31 Jul 2015 10:31:30 +0200
Message-ID: <55BB3262.5000403@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
 <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
 <20150731083541.5f2c683a@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150731083541.5f2c683a-I2t2yFIzmohO7ya8xxV06g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 31-07-15 08:35, Bruno Pr=C3=A9mont wrote:
> On Fri, 31 Jul 2015 14:14:28 +0800 Chen-Yu Tsai wrote:
>> On Fri, Jul 31, 2015 at 1:51 PM, Bruno Pr=C3=A9mont wrote:
>>> Hi ChenYu,
>>>
>>> On Fri, 31 Jul 2015 13:31:53 +0800 Chen-Yu Tsai wrote:
>>>> Hi Hans,
>>>>
>>>> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede wrote:
>>>>> Add a node representing the usb power supply part of the axp209 p=
mic, note
>>>>> that the usb power supply and the (to be added later) ac power su=
pply will
>>>>> each have their own child-node, so that they can be separately sp=
ecified
>>>>> as power-supply for other nodes using a power-supply property wit=
h a
>>>>> phandle pointing to the right axp209 child-node.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>> ---
>>>>>   arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/ax=
p209.dtsi
>>>>> index 24c935c..051ab3b 100644
>>>>> --- a/arch/arm/boot/dts/axp209.dtsi
>>>>> +++ b/arch/arm/boot/dts/axp209.dtsi
>>>>> @@ -89,4 +89,9 @@
>>>>>                          regulator-name =3D "ldo5";
>>>>>                  };
>>>>>          };
>>>>> +
>>>>> +       usb_power_supply: usb_power_supply {
>>>>> +               compatible =3D "x-powers,axp202-usb-power-supply"=
;
>>>>> +               status =3D "disabled";
>>>>
>>>> Is there any reason to have this disabled by default?
>>>> AFAIK this is not something configurable in hardware,
>>>> and the driver just gives readouts and status updates.
>>>
>>> There are some devices that only have 'AC-IN' instead of usb/otg po=
wer
>>> (set-top boxes) so having the devices tell what power sources they
>>> have makes sense (otherwise those that have ac-in instead of otg wo=
uld
>>> have to disable usb_power_supply) and avoids confusion by explicitl=
y
>>> stating presence in device dts.
>>
>> That's true. But this is a bit of hardware inside the AXP.
>> If it's power isn't routed, it should report it, shouldn't it?
>
> If the device does not use the input there are two cases:
> - ac-in and usb/otg in short-circuited (there is a bit in AXP registe=
rs
>    to provide this indication)
> - the unused one is just not connected/connectable
>
> In either case the voltage of the unused/unusable branch is not reall=
y
> useful, nor is it useful to have it show up in sysfs.

Exactly my thinking on this, +1 .

>> And normal users would probably expect to read the input
>> voltage/current/status through sysfs (or maybe hwmon?),
>> instead of not finding the device and having to look through
>> the DTS.
>
> Only those supplies effectively present (in-use or with connectors
> to eventually use them) should be visible in sysfs.
> Having more of them will just confuse the users, they would be search=
ing
> how they can connect the supply while there is no means to do so
> except soldering to the tiny AXP pins.

+1

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
