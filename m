From: Rik van Riel <riel@redhat.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sun, 10 Apr 2016 16:24:50 -0400
Message-ID: <1460319890.25336.2.camel@redhat.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <20160409110729.GS3448@twins.programming.kicks-ass.net>
	 <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
	 <1460302797.4383.44.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-gvuGWzP62NibU80pxy57"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460302797.4383.44.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org


--=-gvuGWzP62NibU80pxy57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2016-04-10 at 17:39 +0200, Mike Galbraith wrote:
> On Sat, 2016-04-09 at 14:31 +0200, Rafael J. Wysocki wrote:
> >=20
> > On Sat, Apr 9, 2016 at 1:07 PM, Peter Zijlstra <peterz@infradead.or
> > g>
> > wrote:
> > >=20
> > > On Fri, Apr 08, 2016 at 10:59:59PM +0200, Rafael J. Wysocki
> > > wrote:
> > > >=20
> > > > On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
> > > > >=20
> > > > > On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
> > > > >=20
> > > > > >=20
> > > > > > Cute, I thought you used governor=3Dperformance for your
> > > > > > runs?
> > > > > I do, and those numbers are with it thus set.
> > > > Well, this is a trade-off.
> > > >=20
> > > > 4.5 introduced a power regression here so this one goes back to
> > > > the previous
> > > > state of things.
> > > Just for my elucidation; how can gov=3Dperformance have a 'power'
> > > regression?
> > Because of what is used as the "default" idle state most of the
> > time.
> >=20
> > C1 was used before 4.5 and that changed to polling in 4.5.
> Should the default idle state not then be governor dependent?=C2=A0=C2=A0=
When I
> set gov=3Dperformance, I'm expecting box to go just as fast as it can
> go
> without melting.=C2=A0=C2=A0Does polling risk CPU -> lava conversion?

Current CPUs can only have some cores run at full speed
(turbo mode) if other cores are idling and/or running at
lower speeds.

It may be time to stop pretending that gov=3Dperformance
actually results in better performance on current CPUs,
since it may inhibit entire levels of turbo mode.

--=20
All Rights Reversed.


--=-gvuGWzP62NibU80pxy57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXCraTAAoJEM553pKExN6DxagIAJQBthceCqIpGjtaZjCINSft
TB8HaHautTi7fE0xsLyU1znsvdBn8lar+OvY/xMl0y7O3hGZZzIuPZB1bghd8B+Q
MwTReARBb76vFHSwMN6xXqpUNY9vBVJemNWiMUecPSIMndq+blQWRC5C9Rs2YboV
wSTeWF4uKbvwq67KGLXjaqR/CKJAjuTYBD3IrYwHylDCwxvCPWcl8zGaLse3rax4
Bv4mP4YOiDcZDAuzkzOp2MJ7P5TO6no8p+tnezkm7ddF6Fqia07g5Ky/C24njFho
oy+PfWcZ1upW4dHFsoc2PJVkkp3Evsp1rOV7Fi2+wWFaiN6/T/OkxSErgKCLarc=
=yPcK
-----END PGP SIGNATURE-----

--=-gvuGWzP62NibU80pxy57--
