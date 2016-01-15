From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for the bq27xxx
 driver.
Date: Fri, 15 Jan 2016 15:24:10 +0100
Message-ID: <20160115142410.GA11560@pali>
References: <1451500541-2442-1-git-send-email-afd@ti.com>
 <201512311940.04886@pali>
 <20151231210638.GA11763@earth>
 <201512312211.32570@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35468 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcAOOYM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 09:24:12 -0500
Content-Disposition: inline
In-Reply-To: <201512312211.32570@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 31 December 2015 22:11:32 Pali Roh=C3=A1r wrote:
> On Thursday 31 December 2015 22:06:38 Sebastian Reichel wrote:
> > Hi,
> >=20
> > I think it would make sense to have it like this:
> >=20
> > NOKIA N900 POWER SUPPLY DRIVERS
> > +R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > -M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > -S:	Maintained
> > F:	include/linux/power/bq2415x_charger.h
> > F:	include/linux/power/bq27xxx_battery.h
> > F:	include/linux/power/isp1704_charger.h
> > F:	drivers/power/bq2415x_charger.c
> > F:	drivers/power/bq27xxx_battery.c
> > F:	drivers/power/isp1704_charger.c
> > F:	drivers/power/rx51_battery.c
> >=20
> > +TI BQ27XXX POWER SUPPLY DRIVER
> > +R:	Andrew F. Davis <afd@ti.com>
> > +F:	include/linux/power/bq27xxx_battery.h
> > +F:	drivers/power/bq27xxx_battery.c
> > +F:	drivers/power/bq27xxx_battery_i2c.c
> > +
> > POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
> > M:	Sebastian Reichel <sre@kernel.org>
> > M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > M:	David Woodhouse <dwmw2@infradead.org>
> > L:	linux-pm@vger.kernel.org
> > T:	git git://git.infradead.org/battery-2.6.git
> > S:	Maintained
> > F:	include/linux/power_supply.h
> > F:	drivers/power/
> > X:	drivers/power/avs/
> >=20
> > This would result in the following get_maintainer.pl output
> > for the bq27xxx driver.
> >=20
> > sre@earth ~/src/linux [n950] % ./scripts/get_maintainer.pl -f
> > drivers/power/bq27xxx_battery.c "Andrew F. Davis" <afd@ti.com>
> > (reviewer:TI BQ27XXX POWER SUPPLY DRIVER) "Pali Roh=C3=A1r"
> > <pali.rohar@gmail.com> (reviewer:NOKIA N900 POWER SUPPLY DRIVERS)
> > Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY
> > CLASS/SUBSYSTEM and DRIVERS) Dmitry Eremin-Solenikov
> > <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY CLASS/SUBSYSTEM and
> > DRIVERS) David Woodhouse <dwmw2@infradead.org> (maintainer:POWER
> > SUPPLY CLASS/SUBSYSTEM and DRIVERS) linux-pm@vger.kernel.org (open
> > list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS)
> > linux-kernel@vger.kernel.org (open list)
> >=20
> > Pali, what do you think about the reviewer/maintainer change?
> > I think it makes it more clear, that the patches are queued in
> > the battery tree. If you think its a downgrade I don't mind not
> > changing it, though.
> >=20
> > -- Sebastian
>=20
> Change is OK for me.
>=20

Sebastian, one one minor change to your patch:

Add bq27xxx_battery_i2c.c file into NOKIA N900 POWER SUPPLY DRIVERS
section as now bq27200 code is split into two files...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
