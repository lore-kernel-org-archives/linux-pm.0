From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as maintainer of Nokia N900 power
 supply drivers
Date: Tue, 21 Apr 2015 15:37:00 +0200
Message-ID: <20150421133700.GR6515@pali>
References: <1427636154-20874-1-git-send-email-pali.rohar@gmail.com>
 <201504072259.45809@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35423 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbDUNhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 09:37:04 -0400
Content-Disposition: inline
In-Reply-To: <201504072259.45809@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>

Hi Sebastian & others. Is this change ok? Can you include it?

On Tuesday 07 April 2015 22:59:45 Pali Roh=C3=A1r wrote:
> Forgot to mention reason in commit message:
>=20
> I'm author of two of those drivers (bq2415x and rx51) and I added=20
> more patches for other twos. Also I fished (proper) open source=20
> power management software for Nokia N900 and those kernel drivers=20
> are part of it.
>=20
> On Sunday 29 March 2015 15:35:54 Pali Roh=C3=A1r wrote:
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > ---
> >  MAINTAINERS |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 72a08ef..50df61e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6917,6 +6917,17 @@ T:	git
> > git://git.rocketboards.org/linux-socfpga-next.git
> > S:	Maintained
> >  F:	arch/nios2/
> >=20
> > +NOKIA N900 POWER SUPPLY DRIVERS
> > +M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > +S:	Maintained
> > +F:	include/linux/power/bq2415x_charger.h
> > +F:	include/linux/power/bq27x00_battery.h
> > +F:	include/linux/power/isp1704_charger.h
> > +F:	drivers/power/bq2415x_charger.c
> > +F:	drivers/power/bq27x00_battery.c
> > +F:	drivers/power/isp1704_charger.c
> > +F:	drivers/power/rx51_battery.c
> > +
> >  NTB DRIVER
> >  M:	Jon Mason <jdmason@kudzu.us>
> >  M:	Dave Jiang <dave.jiang@intel.com>
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
