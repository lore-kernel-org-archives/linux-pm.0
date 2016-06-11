From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ARM: mxs: warnings on PM resume
Date: Sat, 11 Jun 2016 03:42:01 +0200
Message-ID: <2607020.0FcLMf1DX6@vostro.rjw.lan>
References: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de> <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44506 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750753AbcFKBh6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 21:37:58 -0400
In-Reply-To: <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, joerg.krause@embedded.rocks, Juergen Borleis <jbe@pengutronix.de>

On Saturday, June 11, 2016 03:01:31 AM Stefan Wahren wrote:
> Hi,
>=20
> [add Rafael, J=C3=B6rg and J=C3=BCrgen to CC]
>=20
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Juni 2016 um 22:51
> > geschrieben:
> >=20
> >=20
> > Hi,
> >=20
> > i'm currently working on standby support for MXS platform. If i tri=
gger the
> > standby per sysfs everything works fine, but mostly on resume i get=
 a bunch of
> > warnings (see below for full output):
> >=20
> > [   67.040000] Interrupts enabled before system core resume.
> >=20
> > My current working branch [1] based on Linux 4.5 ( cmdline has
> > no_console_suspend=3D1 ). The test hardware is a i.MX23 board (
> > iMX233-OLinuXino-MAXI ).
> >=20
> > How can i narrow down this issue to the relevant driver / interrupt=
 ?
> >=20
> > What is the right way to fix this issue?
> >=20
> > I have the suspicion it's triggered by clocksource/mxs-timer.c beca=
use the
> > vendor kernel 2.6.35 had a function call [2] to suspend the timers.=
=20
> >=20
> > [1] - https://github.com/lategoodbye/linux-mxs-power/tree/rebase-4.=
5
> > [2] -
> > http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/ar=
ch/arm/mach-mx23/pm.c?h=3Dimx_2.6.35_maintain#n284
> >=20
> > Full output in error case:
> >=20
> > # echo standby > /sys/power/state
> > [   65.820000] PM: Syncing filesystems ... done.
> > [   66.890000] Freezing user space processes ... (elapsed 0.018 sec=
onds) done.
> > [   66.920000] Freezing remaining freezable tasks ... (elapsed 0.00=
4 seconds)
> > done.
> > [   66.960000] smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
> > [   66.990000] PM: suspend of devices complete after 56.500 msecs
> > [   67.010000] PM: late suspend of devices complete after 11.906 ms=
ecs
> > [   67.030000] PM: noirq suspend of devices complete after 12.250 m=
secs
> > [   67.040000] ------------[ cut here ]------------
> > [   67.040000] WARNING: CPU: 0 PID: 271 at drivers/base/syscore.c:9=
9
> > syscore_resume+0x14c/0x1bc()
> > [   67.040000] Interrupts enabled before system core resume.
> > [   67.040000] Modules linked in: mxs_lradc(C) industrialio_trigger=
ed_buffer
> > [   67.040000] CPU: 0 PID: 271 Comm: bash Tainted: G         C
> >      4.5.0-g8b79a7d-dirty #86
> > [   67.040000] Hardware name: Freescale MXS (Device Tree)
> > [   67.040000] [<c000fdc4>] (unwind_backtrace) from [<c000de80>]
> > (show_stack+0x10/0x14)
> > [   67.040000] [<c000de80>] (show_stack) from [<c001d094>]
> > (warn_slowpath_common+0x7c/0xb4)
> > [   67.040000] [<c001d094>] (warn_slowpath_common) from [<c001d160>=
]
> > (warn_slowpath_fmt+0x30/0x40)
> > [   67.040000] [<c001d160>] (warn_slowpath_fmt) from [<c035c6b8>]
> > (syscore_resume+0x14c/0x1bc)
> > [   67.040000] [<c035c6b8>] (syscore_resume) from [<c005d37c>]
> > (suspend_devices_and_enter+0x480/0x770)
> > [   67.040000] [<c005d37c>] (suspend_devices_and_enter) from [<c005=
dad4>]
> > (pm_suspend+0x468/0x4e4)
> > [   67.040000] [<c005dad4>] (pm_suspend) from [<c005c324>]
> > (state_store+0x80/0xcc)
> > [   67.040000] [<c005c324>] (state_store) from [<c02dc0d8>]
> > (kobj_attr_store+0x18/0x1c)
> > [   67.040000] [<c02dc0d8>] (kobj_attr_store) from [<c0181988>]
> > (sysfs_kf_write+0x48/0x4c)
> > [   67.040000] [<c0181988>] (sysfs_kf_write) from [<c0180b34>]
> > (kernfs_fop_write+0xe0/0x1a0)
> > [   67.040000] [<c0180b34>] (kernfs_fop_write) from [<c0114b08>]
> > (__vfs_write+0x2c/0xe8)
> > [   67.040000] [<c0114b08>] (__vfs_write) from [<c0114c6c>]
> > (vfs_write+0xa8/0x198)
> > [   67.040000] [<c0114c6c>] (vfs_write) from [<c0114e30>]
> > (SyS_write+0x44/0x88)
> > [   67.040000] [<c0114e30>] (SyS_write) from [<c000a280>]
> > (ret_fast_syscall+0x0/0x1c)
> > [   67.040000] ---[ end trace 22f59f91777b0ede ]---
>=20
> any hints or ideas to narrow down this issue are very welcome.

Interrupts should not be enabled before syscore_resume() is called, but=
 they
are, apparently by the platform code.

Thanks,
Rafael

