From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: Remove unnecessary MODULE_ALIAS() for I2C drivers
Date: Mon, 31 Aug 2015 10:35:46 +0200
Message-ID: <20150831083546.GD14484@pali>
References: <1440976715-23588-1-git-send-email-javier@osg.samsung.com>
 <20150831071710.GA14484@pali>
 <55E40D87.8030405@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33748 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbHaIft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 04:35:49 -0400
Content-Disposition: inline
In-Reply-To: <55E40D87.8030405@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

On Monday 31 August 2015 10:17:11 Javier Martinez Canillas wrote:
> [adding cc list again]
>=20
> Hello Pali,
>=20
> On 08/31/2015 09:17 AM, Pali Roh=C3=A1r wrote:
> > On Monday 31 August 2015 01:18:35 Javier Martinez Canillas wrote:
> >> These drivers already have an I2C device id table that is used to =
create
> >> module aliases and the used MODULE_ALIAS() was either already in t=
he I2C
> >> table so it was redundant or wasn't a valid I2C id so it was never=
 used.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >>
> >> ---
> >>
> >> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x=
00_battery.c
> >> index 8287261fd978..d0b2f3b47b8f 100644
> >> --- a/drivers/power/bq27x00_battery.c
> >> +++ b/drivers/power/bq27x00_battery.c
> >> @@ -1120,10 +1120,6 @@ module_exit(bq27x00_battery_exit);
> >>  MODULE_ALIAS("platform:bq27000-battery");
> >>  #endif
> >> =20
> >> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
> >> -MODULE_ALIAS("i2c:bq27000-battery");
> >> -#endif
> >> -
> >>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
> >>  MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
> >>  MODULE_LICENSE("GPL");
> >=20
> > Hi! This part of patch is already in queue list. So then your patch=
 will
> > conflict with other pending patches...
> >
>=20
> Sorry, with which patch it will conflict? It applies cleanly on top o=
f
> the power supply git tree next branch:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.g=
it/log/?h=3Dnext
>=20
> Best regards,

There are bq27x00 patches waiting on mailing list...

v1: https://lkml.org/lkml/2015/7/22/705
v2: https://lkml.org/lkml/2015/7/28/929
v3: https://lkml.org/lkml/2015/8/5/597

Your patch will conflict with this (v2) patch:
https://lkml.org/lkml/2015/7/28/923

Some of v1 patches are already merged into tree, some v2 are Acked by
me, but not merged yet... Probably Sebastian (maintainer) did not have
time to review all patches yet.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
