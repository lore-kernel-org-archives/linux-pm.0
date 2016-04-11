From: Rik van Riel <riel@redhat.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Mon, 11 Apr 2016 09:38:57 -0400
Message-ID: <1460381937.25336.8.camel@redhat.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <20160409110729.GS3448@twins.programming.kicks-ass.net>
	 <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
	 <1460302797.4383.44.camel@gmail.com> <1460319890.25336.2.camel@redhat.com>
	 <1460343894.3682.11.camel@gmail.com> <1460378295.25336.5.camel@redhat.com>
	 <CAJZ5v0i8saPhJ_WsyitJWi3BR4m5f94KV-UnHMmvAWUoLDWfPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-LBP1tVaS7JtBubHl4ZZn"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i8saPhJ_WsyitJWi3BR4m5f94KV-UnHMmvAWUoLDWfPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org


--=-LBP1tVaS7JtBubHl4ZZn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-04-11 at 15:21 +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 11, 2016 at 2:38 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=20
> > On Mon, 2016-04-11 at 05:04 +0200, Mike Galbraith wrote:
> > >=20
> > > On Sun, 2016-04-10 at 16:24 -0400, Rik van Riel wrote:
> > > >=20
> > > >=20
> > > > On Sun, 2016-04-10 at 17:39 +0200, Mike Galbraith wrote:
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Should the default idle state not then be governor
> > > > > dependent?=C2=A0=C2=A0When I
> > > > > set gov=3Dperformance, I'm expecting box to go just as fast as
> > > > > it
> > > > > can
> > > > > go
> > > > > without melting.=C2=A0=C2=A0Does polling risk CPU -> lava convers=
ion?
> > > > Current CPUs can only have some cores run at full speed
> > > > (turbo mode) if other cores are idling and/or running at
> > > > lower speeds.
> > > The real world is very unlikely to miss the prettier numbers I'm
> > > grieving over one tiny bit.=C2=A0=C2=A0Knowing that doesn't make givi=
ng
> > > them up
> > > any easier though.. byebye cycles (sniff) ;-)
> > I suspect your pipe benchmark could be very relevant to
> > network performance numbers, too.
> >=20
> > I would like to go into polling a little bit more aggressively
> > in a future kernel,
> Agreed, but ->
>=20
> >=20
> > and I think we can get away with it if we
> > teach the polling loop to exit after we have spent enough time
> > there that the menu governor will pick HLT after a few timed
> > out poll loops.
> -> my concern about this approach is that it would add an artificial
> point to the menu governor statistics at whatever the timeout is
> chosen to be.

I would set the threshold to at least the HLT target residency +
exit latency, so 3 poll timeouts in 8 wakeups would cause
us to fall back to HLT.

On the other hand, if the system is legitimately very busy,
and we break out of the HLT loop due to activities happening
before the timeout most of the time, we should automatically
pick polling.

Does that make sense?

Am I overlooking something?

--=20
All Rights Reversed.


--=-LBP1tVaS7JtBubHl4ZZn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC6jyAAoJEM553pKExN6D0bcH+wUZeXN1xtC0EuE7siQ5mzux
MinbV2jNdDQ9rkQcLwbLkWkr6J5IxnoimASsJprPLqZ7O/TI46gOxEprZsJRJkHf
9gLB3byBhySES5mrtZ9EtKJq87geYAcWN2M1MOaBOKDuEh3JK3fO1M0E5e0B/IVV
WJhkSoYD+0REJBzHvxaJaG2JboQg7tgngmybjgAc4k5goegwG5TzB6KvXaRE0xp+
Vq43qYbJPjm53qzq+IEmkUxxRV3eUW8n6J4QTzvFJE3ZRm2UtvjDfItyDpcpVqeZ
QAk0CgM8mEC54XvZxTYiaBb6MONWAHv+HftHGib5A8kCGCiQoP6Mv69/FeKYUCM=
=PB+y
-----END PGP SIGNATURE-----

--=-LBP1tVaS7JtBubHl4ZZn--
