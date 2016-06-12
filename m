From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: ARM: mxs: warnings on PM resume
Date: Sun, 12 Jun 2016 12:27:02 +0200 (CEST)
Message-ID: <908847370.85504.d47d66b7-356b-4e07-9e1d-807a299ea337.open-xchange@email.1und1.de>
References: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de>
 <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
 <2607020.0FcLMf1DX6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:57763 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbcFLK1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2016 06:27:45 -0400
In-Reply-To: <2607020.0FcLMf1DX6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Rafael,

> "Rafael J. Wysocki" <rjw@rjwysocki.net> hat am 11. Juni 2016 um 03:42
> geschrieben:
>=20
>=20
> On Saturday, June 11, 2016 03:01:31 AM Stefan Wahren wrote:
> > Hi,
> >=20
> > [add Rafael, J=C3=B6rg and J=C3=BCrgen to CC]
> >=20
> > > Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Juni 2016 um 22:=
51
> > > geschrieben:
> > >=20
> > >=20
> > > Hi,
> > >=20
> > > i'm currently working on standby support for MXS platform. If i t=
rigger
> > > the
> > > standby per sysfs everything works fine, but mostly on resume i g=
et a
> > > bunch of
> > > warnings (see below for full output):
> > >=20
> > > [   67.040000] Interrupts enabled before system core resume.
> > >=20
> > > My current working branch [1] based on Linux 4.5 ( cmdline has
> > > no_console_suspend=3D1 ). The test hardware is a i.MX23 board (
> > > iMX233-OLinuXino-MAXI ).
> > >=20
> > > How can i narrow down this issue to the relevant driver / interru=
pt ?
> > >=20
> > > What is the right way to fix this issue?
> > >=20
> >=20
> > any hints or ideas to narrow down this issue are very welcome.
>=20
> Interrupts should not be enabled before syscore_resume() is called, b=
ut they
> are, apparently by the platform code.

sure, but it isn't that simple. I can't reproduce the warning everytime=
=2E At
least i need 5 tries and more to reproduce it.

I place the following code in the suspend code, before the low level su=
spend
code in SRAM gets executed:

if (!irqs_disabled())
	pr_info("IRQs not disabled before suspend\n");

The info message above only get printed if the warning "Interrupts enab=
led
before system core resume." appears.

After that i dumped all enabled IRQs (at the same code place) from the =
interrupt
collector (irqchip) and compared them with cat /proc/interrupts. I noti=
ced that
the dump contains all interrupt from /proc/interrupts plus the IRQs fro=
m the 3
GPIO banks, which were not listed under PROC FS.

So i take a look at the GPIO driver gpio-mxs.c and noticed that it seem=
s to miss
the flag IRQCHIP_MASK_ON_SUSPEND compared to a driver gpio-mxc.c for ve=
ry
similiar hardware. Unfortunately adding the flag in the GPIO driver doe=
sn't fix
the issue.

So any hints about narrowing down the issue would be helpful.

Stefan
