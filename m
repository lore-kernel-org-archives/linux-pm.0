From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Crash introduced by commit b8b2c7d845d5 ("base/platform: assert
 that dev_pm_domain callbacks are called unconditionally")
Date: Tue, 19 Jan 2016 20:07:09 +0100
Message-ID: <20160119190709.GA3338@pengutronix.de>
References: <Pine.LNX.4.44L0.1601191312260.1312-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56900 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754824AbcASTHM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 14:07:12 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1601191312260.1312-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

Hello Alan,

On Tue, Jan 19, 2016 at 01:22:22PM -0500, Alan Stern wrote:
>=20
> Your commit causes my ASUS laptop to crash during early boot.  The=20
> problem occurs in platform_drv_probe(), affecting both the alarmtimer=
=20
> and the asus_laptop platform drivers (I can't tell which is the=20
> critical one).
>=20
> The old code would not call platform_drv_probe() at all, and probing
> would always succeed immediately because these drivers have no probe
> routine.  But with the new code, platform_drv_probe() does run.  The
> call to of_clk_set_defaults() returns -ENODEV, as does the call to
> dev_pm_domain_attach().  The call to drv->probe() gets skipped, of=20
> course.  The final return value is -ENODEV, and so probing fails.  Th=
is=20
> causes the kernel to crash: blank screen, NumLock LED blinking.
>=20
> The patch below fixes the problem, but I'm not sure that it's the bes=
t=20
> solution.  What is your advice?
You want

	http://mid.gmane.org/1449132704-9952-1-git-send-email-martin.wilck@ts.=
fujitsu.com

=2E

Greg, I'd welcome this fix in mainline and 4.4.x.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
