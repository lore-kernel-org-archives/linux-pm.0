From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
Date: Tue, 19 May 2015 15:43:59 +0300
Message-ID: <555B300F.8030305@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de> <5559ABAA.6040001@kapsi.fi> <20150518120944.GQ6325@pengutronix.de> <20150518184433.GS11598@ld-irv-0074> <555A39EA.1060608@kapsi.fi> <20150518202848.GT11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52040 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651AbbESMoq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 May 2015 08:44:46 -0400
In-Reply-To: <20150518202848.GT11598@ld-irv-0074>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 05/18/15 23:28, Brian Norris wrote:
> On Mon, May 18, 2015 at 10:13:46PM +0300, Mikko Perttunen wrote:
>> On 05/18/2015 09:44 PM, Brian Norris wrote:
>>> On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
>>>> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
>>>>> One interesting thing I noticed was that at least the bang-bang
>>>>> governor only acts if the temperature is properly smaller than (t=
rip
>>>>> temp - hysteresis). So perhaps we should specify the non-tripping
>>>>> range as [low, high)? Or we could change bang-bang.
>>>>
>>>> I wonder how we can protect against such off-by-one errors anyway.
>>>> Generally a hardware might operate on raw values rather than direc=
tly
>>>> in temperature values in =B0C. This means a driver for this must h=
ave
>>>> celsius_to_raw and raw_to_celsius conversion functions. Now it can
>>>> happen that due to rounding errors celsius_to_raw(Tcrit) returns a=
 raw
>>>> value that when converted back to celsius is different from the
>>>> original value in =B0C. This would mean the hardware triggers an i=
nterrupt
>>>> for a trip point and the thermal core does not react because get_t=
emp
>>>> actually returns a different temperature than previously programme=
d as
>>>> interrupt trigger. This way we would lose hot (or cold) events.
>>>
>>> This also highlights another fact: there's a race between interrupt
>>> generation and temperature reading (->get_temp()). I would expect a=
ny
>>> hardware interrupt thermal sensor would also have a latched tempera=
ture
>>> reading to correspond with it, and there would be no guarantee that=
 this
>>> latched temperature will match the polled reading seen once you rea=
ch
>>> thermal_zone_device_update(). So a hardware driver might report a
>>> thermal update, but the temperature reported to the core won't
>>> necessarily match what interrupt was meant for.
>>
>> Does this actually matter? The thermal core will reset trips and
>> apply cooling using the new - most recent - value. Using bang bang
>> as example, if the temperature has risen since the interrupt fired,
>> the cooling device will correctly not be switched off. If the
>> temperature has fallen, it will again be correctly switched off. The
>> only issue is then if the temperature is exactly 'trip temp - trip
>> hyst' which will cause set_trips to load the trip points below, but
>> not cause bang bang to turn off the cooling device, and the next
>> chance it will have will only be at the next below trip point. Well,
>> this is still safe (at least until you replace "cooling device" with
>> "heating device"), so maybe it isn't that big of an issue.
>>
>> Please point out if there's a problem with my line of reasoning.
>
> I'm not sure I followed exactly the reason for the low-temp/hyst corn=
er
> case, but otherwise I guess that makes sense. The only problem IMO, i=
s
> that you're encouraging the generation of spurious notifications; if =
the
> temperature is constantly changing right around 'trip temp', but it
> never settles above 'trip temp' long enough for the core to re-captur=
e
> the high temperature scenario, you'll just keep making useless calls =
to
> thermal_zone_device_update(). This kind of defeats the purpose of the
> hysteresis, right?

The corner case with bang bang is as follows:
- Say we have trip points as 50C and 80C, both with 5C hysteresis, and=20
these are programmed into hardware. So the actual hardware trip points=20
are 45C and 80C.
- Currently the temperature is, say, 60C and the fan is turned on.
- Temperature drops to 45C, the lower trip point is triggered.
- 45C >=3D 50C - 5C, so the fan is not turned off.

If we said that the hysteresis was 0C, then bang bang is certainly=20
correct in that if the trip point was at 50C, it shouldn't turn the fan=
=20
off, since that is greater than or equal to the requested temperature=20
for cooling.

The function you describe would certainly be useful for eliminating=20
possible superfluous interrupts due to temperature wobble, though I'm=20
not sure how much of a problem that even would be.

>
> I'd really rather have a high temperature interrupt generate exactly =
one
> notification to the core framework, and that the sensor driver can re=
ly
> on that one interrupt being handled as a high temperature situation,
> allowing it to disable the high-temp interrupt.
>
> One of my biggest problems with the thermal subsystem so far is that
> thermal_zone_device_update() doesn't actually seem to have any specif=
ic
> semantic meaning. It just means that there was some reason to update
> something. So then, you have to reason about a particular thermal
> governor (bang bang) in order to make something sensible. If I want t=
o
> use a different sort of user-space governor, then I have to reevaluat=
e
> all these same assumptions, and it seems like I end up with a sub-par
> solution.

Yeah, though I'm not sure if you can ever be sure that the governor is=20
fine not getting regular temperature updates, so I imagine you might=20
always end up needing to pick your governors with that in mind. In=20
practice, this might not be so horrible.

>
> As a side note: I have patches to extend some of the uevent informati=
on
> passed by the user-space governor too, to accomplish what I'm suggest=
ing
> above. Perhaps that would be a better way to discuss what I'm thinkin=
g.
>
>> FWIW - at least Tegra doesn't have a latched register like this.
>> There's just a bit indicating that an interrupt was raised and a
>> temperature register that updates according to the sensor's input
>> clock.
>
> A sensor for Broadcom's BCM7xxx has a latched register. If I get the
> time, I'll post my driver soon.
>
> Brian
>

