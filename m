From: Rik van Riel <riel@redhat.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Mon, 11 Apr 2016 08:38:15 -0400
Message-ID: <1460378295.25336.5.camel@redhat.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <20160409110729.GS3448@twins.programming.kicks-ass.net>
	 <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
	 <1460302797.4383.44.camel@gmail.com> <1460319890.25336.2.camel@redhat.com>
	 <1460343894.3682.11.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2yhfBHSLyspRvLXXLps0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41884 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbcDKMiT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Apr 2016 08:38:19 -0400
In-Reply-To: <1460343894.3682.11.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>


--=-2yhfBHSLyspRvLXXLps0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-04-11 at 05:04 +0200, Mike Galbraith wrote:
> On Sun, 2016-04-10 at 16:24 -0400, Rik van Riel wrote:
> >=20
> > On Sun, 2016-04-10 at 17:39 +0200, Mike Galbraith wrote:
> >=20
> > >=20
> > > Should the default idle state not then be governor
> > > dependent?=C2=A0=C2=A0When I
> > > set gov=3Dperformance, I'm expecting box to go just as fast as it
> > > can
> > > go
> > > without melting.=C2=A0=C2=A0Does polling risk CPU -> lava conversion?
> > Current CPUs can only have some cores run at full speed
> > (turbo mode) if other cores are idling and/or running at
> > lower speeds.
> The real world is very unlikely to miss the prettier numbers I'm
> grieving over one tiny bit.=C2=A0=C2=A0Knowing that doesn't make giving t=
hem up
> any easier though.. byebye cycles (sniff) ;-)

I suspect your pipe benchmark could be very relevant to
network performance numbers, too.

I would like to go into polling a little bit more aggressively
in a future kernel, and I think we can get away with it if we
teach the polling loop to exit after we have spent enough time
there that the menu governor will pick HLT after a few timed
out poll loops.

That way while we run a workload that actually benefits from
polling, we will get polling, but once we run a workload that
actually sleeps longer than the HLT threshold, we will quickly
fall back to HLT.

With 10Gbps network traffic, it could make a real difference
whether or not the CPU can wake up immediately, or takes a
microsecond to wake up...

--=20
All Rights Reversed.


--=-2yhfBHSLyspRvLXXLps0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC5q3AAoJEM553pKExN6DMdUIAJv8ddCouEs6FDFNHR3cxjbK
bLmJHupjLFylhSmLIKbIWQkyobgpUje0048kW9LlCQ4S8Mp31x0Z0NJHJ+mvm+go
4p//nFPlgTIjDhG7/u6/Rl0XZ6b+nNEs/U5eUfT2l3CD1/+1nm7kkq8emIpB+rfh
A2c+zrlvJDMzdXsr2rpP0Hm46qck/YRZ0h4UxQtNkHbG2u0Vs0Vp1oyxnmgqCnc1
gVQjthfFUCxiAezs5JLPMDsC2pYu9muBWyMYJErLa/Sm33HlA+pQcyeE/se8bqV2
rLq+ligPk7WTSI/Ki43g6X4JY8tv/RO1cPPGDU1S0RlQdF5r8lXKVZdHB3b+GX4=
=wuqi
-----END PGP SIGNATURE-----

--=-2yhfBHSLyspRvLXXLps0--

