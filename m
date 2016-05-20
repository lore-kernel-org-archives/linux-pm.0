From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Fri, 20 May 2016 11:22:19 +0200
Message-ID: <20160520092219.GA4580@amd>
References: <573C9F45.5090109@ti.com>
 <20160519091719.GL29844@pali>
 <573DDDE6.7070408@ti.com>
 <201605191744.07228@pali>
 <573DE04D.9050101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53633 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782AbcETJWW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 05:22:22 -0400
Content-Disposition: inline
In-Reply-To: <573DE04D.9050101@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Thu 2016-05-19 10:48:29, Andrew F. Davis wrote:
> On 05/19/2016 10:44 AM, Pali Roh=E1r wrote:
> > On Thursday 19 May 2016 17:38:14 Andrew F. Davis wrote:
> >> P.S. The code is still a bit strange, I'll probably go grab one of
> >> the N900s from our test farm and make sure my future cleanups don'=
t
> >> break this, but are we sure the *name* of a driver is an ABI?
> >=20
> > It is not name of driver, but directory name of sysfs path where de=
vice=20
> > is exported...
> >=20
>=20
> Which is named after the drivers name, so the same question remains. =
:/

We don't break userspace. And yes, phone software is somewhat more
tightly coupled than is usual in PC world.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
