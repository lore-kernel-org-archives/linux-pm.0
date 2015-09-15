From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 01/10] dt: power: bq24257-charger: Cover additional devices
Date: Tue, 15 Sep 2015 21:51:25 +0900
Message-ID: <CAJKOXPcTiPKbWuRN+s1ndQ2M2awc9M8BOJ=k3u6vMJ3x7XHObQ@mail.gmail.com>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
	<1442003202-1430-2-git-send-email-dannenberg@ti.com>
	<55F66514.1080909@samsung.com>
	<20150914135430.GA21442@borg>
	<55F7CF44.3010102@samsung.com>
	<20150915090537.GB3166@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150915090537.GB3166@lpalcu-desk>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

2015-09-15 18:05 GMT+09:00 Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> On Tue, Sep 15, 2015 at 04:56:52PM +0900, Krzysztof Kozlowski wrote:
>> On 14.09.2015 22:54, Andreas Dannenberg wrote:
>> > On Mon, Sep 14, 2015 at 03:11:32PM +0900, Krzysztof Kozlowski wrote:
>> >>
>> >> Now I spotted the difference in this binding from previous emails.
>> >> Previously you made it as a boolean property. Now it is a integer
>> >> property for a boolean value. It is unusual. If you expect a need (or a
>> >> possibility of need) of:
>> >> 1. extending,
>> >> 2. overriding,
>> >> 3. using similar (extended) property in different drivers,
>> >> then it should be a real value, like:
>> >>
>> >> 1. ti,safety-timer: integer, in seconds
>> >
>> > Hi Krzysztof,
>> >
>> > I thought about this as well because the device actually allows
>> > configuring different safety timer intervals (currently not exposed) and
>> > it appears that the "2x enable" could be factored in there however it's
>> > not as easy as it seems.  The "2x enable" is a dedicated HW feature
>> > that's only being used in some states of the devices and with that does
>> > not generally extend the safety timer under all conditions.
>>
>> Right, I read also the datasheet which explains it.
>>
>> >
>> >> 2. ti,safety-timer-ratio/multiplier: integer, supported values are: 0
>> >> (use default) or 2 (slow down by factor of 2)
>> >>
>> >> It is unusual and not obvious to use a integer value for boolean strict
>> >> property. With current solution you can actually only override it.
>> >
>> > Yes that was the sole reason behind using integer instead of boolean.
>> > The boolean "character" of this property was left intact because of the
>> > direct mapping to a device HW feature (see below).
>>
>> DT serves a purpose of providing information allowing the kernel to use
>> and configure the hardware. DT binding does not have to map device
>> property. In the same time having a device property does not mean you
>> create a DT binding.
>>
>> If such requirement of mapping property to a HW feature was valid then
>> each driver would expose each register in DT. Sometimes platform data
>> did this... but DT is not pdata.
>> You're using such argument also below but this argument is not sufficient.
>>
>> Sufficient argument would be: this property is necessary to configure
>> the hardware in different board configurations (so on different boards
>> it will have different values).
>>
>> Example of device features not matching to DeviceTree:
>>  - configuration changing over time:
>> /sys/class/power/ds2760-battery.*/charge_full
>>
>>  - various timers:
>> /sys/class/power_supply/max14577-charger/device/fast_charge_timer
>>
>>  - various thresholds:
>> /sys/class/power_supply/max77693-charger/device/top_off_threshold_current
>>
>> These are strictly HW features (they map to a bit in register) but they
>> are not related to configuring device for specific board. They serve for
>> user-space to use the devices in different ways.
>>
>> In this case - the 2XTMR_EN - I assume that for certain batteries or
>> boards you want to extend the time of charging in case of special
>> conditions?
>
> FWIW, I don't see any real benefit in manually changing the 2X timer at
> all. The default setting is decent enough. The chip will automatically
> switch to 2X timer in certain conditions: for example, when the
> temperature threshold is exceeded and the charge current is
> automatically lowered. This makes sense since it'll take the battery
> more time to charge at a lower current.
>
> It would probably make more sense to add a DT property to change the
> 'Safety Timer Time Limit' device property (which can be 0.75hrs, 6hrs,
> 9hrs or totally disabled) than the 2XTMR.
>
> I omitted both when I originally added support for this chip since the
> 6hrs default safety timer seemed more than enough to charge a nowadays
> battery, even at 500mA (provided by a standard USB port). But, future
> batteries might (and probably will) have higher capacities and will take
> longer to charge.

>From my past mistakes I found that if binding is not necessary and it
is not used (e.g. every DTS have the same value) then it will be
easier not to add it. Bindings mean ABI so if you make a mistake then
you will have to leave with it. Usually it is easier to add new
bindings when they are needed.

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
