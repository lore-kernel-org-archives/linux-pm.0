From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Crash introduced by commit b8b2c7d845d5 ("base/platform: assert
 that dev_pm_domain callbacks are called unconditionally")
Date: Tue, 19 Jan 2016 15:06:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1601191504470.1312-100000@iolanthe.rowland.org>
References: <20160119190709.GA3338@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34265 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757440AbcASUGL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 15:06:11 -0500
In-Reply-To: <20160119190709.GA3338@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, 19 Jan 2016, Uwe [iso-8859-1] Kleine-K=F6nig wrote:

> Hello Alan,
>=20
> On Tue, Jan 19, 2016 at 01:22:22PM -0500, Alan Stern wrote:
> >=20
> > Your commit causes my ASUS laptop to crash during early boot.  The=20
> > problem occurs in platform_drv_probe(), affecting both the alarmtim=
er=20
> > and the asus_laptop platform drivers (I can't tell which is the=20
> > critical one).
> >=20
> > The old code would not call platform_drv_probe() at all, and probin=
g
> > would always succeed immediately because these drivers have no prob=
e
> > routine.  But with the new code, platform_drv_probe() does run.  Th=
e
> > call to of_clk_set_defaults() returns -ENODEV, as does the call to
> > dev_pm_domain_attach().  The call to drv->probe() gets skipped, of=20
> > course.  The final return value is -ENODEV, and so probing fails.  =
This=20
> > causes the kernel to crash: blank screen, NumLock LED blinking.
> >=20
> > The patch below fixes the problem, but I'm not sure that it's the b=
est=20
> > solution.  What is your advice?
> You want
>=20
> 	http://mid.gmane.org/1449132704-9952-1-git-send-email-martin.wilck@t=
s.fujitsu.com
>=20
> .
>=20
> Greg, I'd welcome this fix in mainline and 4.4.x.

Yep, that fixed it, thank you.  This definitely needs to get into 4.4.x
as soon as possible.

Alan Stern

