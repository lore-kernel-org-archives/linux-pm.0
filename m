From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
Date: Mon, 18 May 2015 11:44:33 -0700
Message-ID: <20150518184433.GS11598@ld-irv-0074>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
 <5559ABAA.6040001@kapsi.fi>
 <20150518120944.GQ6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36825 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbbERSoi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 14:44:38 -0400
Content-Disposition: inline
In-Reply-To: <20150518120944.GQ6325@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
> > One interesting thing I noticed was that at least the bang-bang
> > governor only acts if the temperature is properly smaller than (tri=
p
> > temp - hysteresis). So perhaps we should specify the non-tripping
> > range as [low, high)? Or we could change bang-bang.
>=20
> I wonder how we can protect against such off-by-one errors anyway.
> Generally a hardware might operate on raw values rather than directly
> in temperature values in =B0C. This means a driver for this must have
> celsius_to_raw and raw_to_celsius conversion functions. Now it can
> happen that due to rounding errors celsius_to_raw(Tcrit) returns a ra=
w
> value that when converted back to celsius is different from the
> original value in =B0C. This would mean the hardware triggers an inte=
rrupt
> for a trip point and the thermal core does not react because get_temp
> actually returns a different temperature than previously programmed a=
s
> interrupt trigger. This way we would lose hot (or cold) events.

This also highlights another fact: there's a race between interrupt
generation and temperature reading (->get_temp()). I would expect any
hardware interrupt thermal sensor would also have a latched temperature
reading to correspond with it, and there would be no guarantee that thi=
s
latched temperature will match the polled reading seen once you reach
thermal_zone_device_update(). So a hardware driver might report a
thermal update, but the temperature reported to the core won't
necessarily match what interrupt was meant for.

I have a patch that adds a thermal_zone_device_update_temp() API, so
drivers can report the temperature along with the interrupt
notification. (Such a patch also helps so that the driver can choose to
round down on cold events and up on hot events, resolving your rounding
issue too.)

Brian
