From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
Date: Tue, 19 May 2015 16:05:46 +0200
Message-ID: <20150519140546.GE26575@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
 <5559ABAA.6040001@kapsi.fi>
 <20150518120944.GQ6325@pengutronix.de>
 <20150518184433.GS11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45945 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbbESOFv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 10:05:51 -0400
Content-Disposition: inline
In-Reply-To: <20150518184433.GS11598@ld-irv-0074>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, May 18, 2015 at 11:44:33AM -0700, Brian Norris wrote:
> On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
> > On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
> > > One interesting thing I noticed was that at least the bang-bang
> > > governor only acts if the temperature is properly smaller than (t=
rip
> > > temp - hysteresis). So perhaps we should specify the non-tripping
> > > range as [low, high)? Or we could change bang-bang.
> >=20
> > I wonder how we can protect against such off-by-one errors anyway.
> > Generally a hardware might operate on raw values rather than direct=
ly
> > in temperature values in =B0C. This means a driver for this must ha=
ve
> > celsius_to_raw and raw_to_celsius conversion functions. Now it can
> > happen that due to rounding errors celsius_to_raw(Tcrit) returns a =
raw
> > value that when converted back to celsius is different from the
> > original value in =B0C. This would mean the hardware triggers an in=
terrupt
> > for a trip point and the thermal core does not react because get_te=
mp
> > actually returns a different temperature than previously programmed=
 as
> > interrupt trigger. This way we would lose hot (or cold) events.
>=20
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
>=20
> I have a patch that adds a thermal_zone_device_update_temp() API, so
> drivers can report the temperature along with the interrupt
> notification. (Such a patch also helps so that the driver can choose =
to
> round down on cold events and up on hot events, resolving your roundi=
ng
> issue too.)

Could you send me that patch? Thinking about it this might indeed work.
The only thing that a driver needs to make sure then is that it actuall=
y
at least one time reports a temperature beyond the currently programmed
thresholds. With the patch you describe a driver could simply do that b=
y
ignoring the current ADC values and simply reporting the previously
desired values.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
