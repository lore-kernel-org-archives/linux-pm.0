From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH v3 3/9] power: supply: axp20x_usb_power:
 allow disabling input current limiting
Date: Mon, 25 Mar 2019 09:58:12 +0100
Message-ID: <3a896485-d7d4-e221-6e66-34bbdb0c0f6e@redhat.com>
References: <20190321084850.20769-1-wens@kernel.org>
 <20190321084850.20769-4-wens@kernel.org>
 <20190321093012.kg72voxs5kw5xtzu@flea>
 <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA@mail.gmail.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBJVQ4LSAKGQE7A6TNVI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v66bh0UXcjScHRL5U4f_mBALDN6Vckt=9sjziz09qygcxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 25-03-19 03:45, Chen-Yu Tsai wrote:
> On Thu, Mar 21, 2019 at 5:30 PM Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
>>
>> Hi,
>>
>> The rest of the series is
>> Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>>
>> On Thu, Mar 21, 2019 at 04:48:44PM +0800, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>>
>>> The AXP PMICs allow the user to disable current limiting on the VBUS
>>> input. While read-out of this setting was already supported by the
>>> driver, it did not allow the user to configure the PMIC to disable
>>> current limiting.
>>>
>>> Add support for this.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>
>> Do we really want to do that though? That could have some pretty bad
>> consequences.
> 
> If I understand the manual correctly, the PMIC has two mode of operation
> with regards to VBUS. Normal operation means the PMIC will try to limit
> the current draw to maintain VBUS above the set V_hold (defaults to 4.4V).
> This is in addition to the current limit set in this patch.
> 
> The other mode of operation is bypass, where it ignores the voltage limit.
> Not sure if it also ignores the current limit, but probably not. In any
> case we don't support this mode in the driver.
> 
> So I can think of a few cases where this might be bad:
> 
> 1. High current draw results in excessive voltage drop and heating over
>     line / traces due to insufficient conductor area. This should be covered
>     by the voltage holding mechanism.
> 
> 2. Over taxing the external power supply. This should also result in some
>     voltage drop for simple power bricks. Advanced ones would either have
>     current limiting or over-current protection.
> 
> What bad consequences are you thinking of?

Lets say you use a typical 5v / 2A charger-plug, lets also say that at full
load this brick has an efficiency of 90%. At full load it delivers 10W of
power, while consuming 11.1W dissipating 1.1W of losses as heat.

Now lets say we disable current-limiting and rely only on the V_hold
mechanism, lets say that we end up with 4.5 volts at 2.4 amps because of
this and since we are now operating in overload conditions the
efficiency has fallen to 80% (approx. 4.5/5.0 * 90%) so now at full load
it delivers 10.8W of power, while consuming 13.5W dissipating 2.7W of
losses as heat. Chances are the the small plastic enclosure of your
typical charger-plug cannot dissipate this much and will start warming
up, until it bursts into flames.

Disabling current limit protection is a very bad idea because you will
end up in an equilibrium between the Vhold from the charger-ic and the
over-current protection from the power-brick where you are over the
design limit of the power-brick.

I actually like what the TI charger-ics are doing here a lot more then
what the AXP series is doing, with TI charger-ics if you set a current
limit > 500mA and the power-brick's voltages drops too much because of
this (or because of a bad cable) it automatically falls back to 500mA.
Where as at least with the AXP288, it simply starts drawing 1.5A at 4.5V
with a bad cable, but in this case the dissipation at least is happening
inside the cable rather then inside the charger-plug, which typically
already gets quite hot under normal operation conditions.

Disabling the current limit is basically the same as what bad USB-A
to USB-C cables which have a Rp-3.0 resistor in the C plug do, these tell
the device with the Type-C plug it can safely draw 3A from the A-port the
A plug is plugged into. The web is full of stories about this causing
damage to machines, e.g.:

"Bohn's Nexus 6P drew too much power from his MacBook Air while using a third-party cord, frying the machine and making the USB Type-C ports work only intermittently."

From: https://www.laptopmag.com/articles/how-to-find-safe-usb-type-c-cables

Another good link about the problems caused by these bad Rp resistor
values in Type-C to Type-A cables (which also effectively disable the
current-limit on the device charging on the C-end of the cable):
https://plus.google.com/102617628172847077584/posts/HakwCMmd346

Note this second link is going away in 6 days as google is retiring
google+.

Anyways TL;DR: Disabling the current-limit is a bad idea and really
nothing good can come from this.

Regards,

Hans
