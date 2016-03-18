From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 18:28:59 -0400
Message-ID: <1458340139.14723.50.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com>
	 <1458337969.14723.44.camel@redhat.com> <1596370.PSmUAlHJf5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/jqvhnvAvuGPdMcHYbwV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbcCRW3C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 18:29:02 -0400
In-Reply-To: <1596370.PSmUAlHJf5@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-/jqvhnvAvuGPdMcHYbwV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2016-03-18 at 23:09 +0100, Rafael J. Wysocki wrote:
> On Friday, March 18, 2016 05:52:49 PM Rik van Riel wrote:
> >=20
> > On Fri, 2016-03-18 at 22:48 +0100, Rafael J. Wysocki wrote:
> > >=20
> > > On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
> > > wrote:
> > > >=20
> > > >=20
> > > > On Fri, 18 Mar 2016 11:32:28 -0700
> > > > "Doug Smythies" <dsmythies@telus.net> wrote:
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Energy:
> > > > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > > > >=20
> > > > > Trace data (very crude summary):
> > > > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU
> > > > > load
> > > > > (idle state 0)
> > > > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but
> > > > > less,
> > > > > CPU load (not all idle state 0)
> > > > This is a bit of a big hammer, but since the polling loop
> > > > already
> > > > uses
> > > > full CPU power anyway, this could be harmless, and solve your
> > > > problem.
> > > Yes, it would be good to test this.
> > >=20
> > > No, I don't like it.
> > >=20
> > > If we are to break out of the polling loop after a specific time,
> > > we
> > > shouldn't be using polling at all in the first place.
> > >=20
> > > So I very much prefer to compare data->next_timer_us with the
> > > target
> > > residency of C1 instead of doing this.
> > The problem is that data->next_timer_us does not tell us
> > when the next network packet is about to arrive, though.
> >=20
> > This could cause issues when dealing with a fast stream
> > of network traffic, which get_typical_interval() would
> > be able to deal with.
> If it predicted things correctly for small intervals, that is.
>=20
> It doesn't seem to be able to do that, however.

It appears to get it right the vast majority of the
time, it is just that when it gets wrong in a tiny
minority of the cases, the penalty for polling is
really high.

> You seem to want to trade energy consumption for performance with a
> very narrow
> use case in mind and that by changing bahavior that's been there
> pretty much
> forever, so by now it really has become the expected one.
>=20
> Needless to say I'm not a fan of changes like that.

I am not sure it is a narrow use case, and I suspect
cases with over half a million wakeups a second are
not going to be all that unusual.

The same thing applies not just to network traffic,
but also to tasks ping-ponging info between CPUs,
eg. because some tasks are pinned, or because we
are dealing with a controller thread and a larger
number of workers.

--=20
All Rights Reversed.


--=-/jqvhnvAvuGPdMcHYbwV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7IErAAoJEM553pKExN6Dh5sH/26nro4pZaHYypS/P4iW+KLi
QemI1x9gjSp4ERG2XxyDSJs/3gP4gofSa+ynwqYYFtF7QxHQ30SnjuPni3UemCzX
vuPaQweyJMN3CDIaurK5N5yRkot6ctwNlKyZDXGJG/dnkuXoS1dOWOhQ1M+WbThu
HocjcefnX/hFcZEryMS2UV22SQUUKWJ0TNBRMWleQBm5QBE6Obj9fMbjlZIDMA0O
WYvcEtIvq9lFthPWlgQAiQ2sQrOGOR4vAinJS/KFvaQm88ZAKs0nB5HPcxgwVAI9
0eC3RCziMWiVrISjjbORG06EhZjj6UCFSlGhS5g0rAiNmABf68XDSYcZ2DWWPNk=
=cfZ0
-----END PGP SIGNATURE-----

--=-/jqvhnvAvuGPdMcHYbwV--

