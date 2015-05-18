From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
Date: Mon, 18 May 2015 22:13:46 +0300
Message-ID: <555A39EA.1060608@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de> <5559ABAA.6040001@kapsi.fi> <20150518120944.GQ6325@pengutronix.de> <20150518184433.GS11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:37210 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760AbbERTOF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 15:14:05 -0400
In-Reply-To: <20150518184433.GS11598@ld-irv-0074>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 05/18/2015 09:44 PM, Brian Norris wrote:
> On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
>> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
>>> One interesting thing I noticed was that at least the bang-bang
>>> governor only acts if the temperature is properly smaller than (tri=
p
>>> temp - hysteresis). So perhaps we should specify the non-tripping
>>> range as [low, high)? Or we could change bang-bang.
>>
>> I wonder how we can protect against such off-by-one errors anyway.
>> Generally a hardware might operate on raw values rather than directl=
y
>> in temperature values in =B0C. This means a driver for this must hav=
e
>> celsius_to_raw and raw_to_celsius conversion functions. Now it can
>> happen that due to rounding errors celsius_to_raw(Tcrit) returns a r=
aw
>> value that when converted back to celsius is different from the
>> original value in =B0C. This would mean the hardware triggers an int=
errupt
>> for a trip point and the thermal core does not react because get_tem=
p
>> actually returns a different temperature than previously programmed =
as
>> interrupt trigger. This way we would lose hot (or cold) events.
>
> This also highlights another fact: there's a race between interrupt
> generation and temperature reading (->get_temp()). I would expect any
> hardware interrupt thermal sensor would also have a latched temperatu=
re
> reading to correspond with it, and there would be no guarantee that t=
his
> latched temperature will match the polled reading seen once you reach
> thermal_zone_device_update(). So a hardware driver might report a
> thermal update, but the temperature reported to the core won't
> necessarily match what interrupt was meant for.

Does this actually matter? The thermal core will reset trips and apply=20
cooling using the new - most recent - value. Using bang bang as example=
,=20
if the temperature has risen since the interrupt fired, the cooling=20
device will correctly not be switched off. If the temperature has=20
fallen, it will again be correctly switched off. The only issue is then=
=20
if the temperature is exactly 'trip temp - trip hyst' which will cause=20
set_trips to load the trip points below, but not cause bang bang to tur=
n=20
off the cooling device, and the next chance it will have will only be a=
t=20
the next below trip point. Well, this is still safe (at least until you=
=20
replace "cooling device" with "heating device"), so maybe it isn't that=
=20
big of an issue.

Please point out if there's a problem with my line of reasoning.

=46WIW - at least Tegra doesn't have a latched register like this. Ther=
e's=20
just a bit indicating that an interrupt was raised and a temperature=20
register that updates according to the sensor's input clock.

>
> I have a patch that adds a thermal_zone_device_update_temp() API, so
> drivers can report the temperature along with the interrupt
> notification. (Such a patch also helps so that the driver can choose =
to
> round down on cold events and up on hot events, resolving your roundi=
ng
> issue too.)
>
> Brian
>

Cheers,
Mikko

