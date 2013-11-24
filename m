From: Pavel Machek <pavel@ucw.cz>
Subject: Re: IRQF_RESUME_EARLY and errors in dpm_suspend_noirq
Date: Sun, 24 Nov 2013 11:41:24 +0100
Message-ID: <20131124104124.GA22947@amd.pavel.ucw.cz>
References: <201311201020.08158.heiko@sntech.de>
 <528C86C2.1070206@nvidia.com>
 <201311232225.48973.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55899 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab3KXKlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Nov 2013 05:41:25 -0500
Content-Disposition: inline
In-Reply-To: <201311232225.48973.heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Ian Campbell <ian.campbell@citrix.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat 2013-11-23 22:25:48, Heiko St=FCbner wrote:
> Hi Laxman,
>=20
> Am Mittwoch, 20. November 2013, 10:54:10 schrieb Laxman Dewangan:
> > > I may be blind, but where get the early-irqs resumed in the error
> > > path of dpm_suspend_noirq?
> > >=20
> > > When a suspend_noirq callback returns an error, dpm_resume_noirq =
gets
> > > called, which only calls resume_device_irqs while the
> > > suspend_device_irqs call in dpm_suspend_noirq suspends all irqs. =
So it
> > > does not seem that the early-irqs get resumed at all in this case=
=2E
> >=20
> > I also faced same issue in our suspend failure path and posted fix
> > sometime ago as
> > https://lkml.org/lkml/2013/8/13/373
> >=20
> > It is still under review.

If it helps, you can add my

Reviewed-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
