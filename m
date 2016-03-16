From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Wed, 16 Mar 2016 01:32:19 +0100
Message-ID: <2600831.Qfymhh5Hpv@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com> <1458007395.8898.19.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1755101.E5AgEk4gnK"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54061 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965138AbcCPAaY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 20:30:24 -0400
In-Reply-To: <1458007395.8898.19.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--nextPart1755101.E5AgEk4gnK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, March 14, 2016 10:03:15 PM Rik van Riel wrote:
> On Mon, 2016-03-14 at 23:55 +0100, Rafael J. Wysocki wrote:
> > On Mon, Mar 14, 2016 at 6:45 PM, Rik van Riel <riel@redhat.com>
> > wrote:
> > >=20
> > > A lot of the logic (especially the load correction) in
> > > menu.c was last fine tuned before several bugs in the
> > > corresponding measuring code were fixed.
> > >=20
> > > I don't understand your patch well enough to object to
> > > it, but the "start the loop at poll instead of HLT"
> > > logic is becoming rather convoluted...
> >=20
> > That logic has been there for quite a while, though.
> >=20
> > Really, the choice is between a simple revert of commit
> > a9ceb78bc75ca47972096372ff3d48 and doing something in addition to i=
t
> > to mitigate the "C1 is hopelessly slow" issue.
>=20
> That is fair.  I suspect your patch will be better than
> a revert on systems where C1 is really slow, and just as
> good as a revert on systems where C1 is fast.
>=20
> We can worry about the choices between deeper C states
> in a future version, but for 4.5 your patch would be the
> way to go.

OK, so here it goes again with a changelog etc.

=2D--
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: menu:=20

Commit a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable
polling) modified the condition to decide if C1 should be used as
the fallback state instead of polling to check the value of
interactivity_req rather than the time to the next timer event.
That turned out to cause polling to be used as the fallback state
most of the time, though, so idle state residencies dropped
significantly even on systems with relatively low C1 exit latencies
which resulted in increased energy consumption.

That was not the intention of commit a9ceb78bc75c, so restore the
time to the next timer event check replaced by it, but in order
to mitigate the original problem it attempted to address, add an
extra C1 exit latency check to the condition in question, so C1
is not used as the fallback state if its exit latency is too high.

Fixes: a9ceb78bc75c (cpuidle,menu: use interactivity_req to disable pol=
ling)
Reported-and-tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpuidle/governors/menu.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -327,11 +327,13 @@ static int menu_select(struct cpuidle_dr
 =09=09data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START - 1;
 =09=09/*
 =09=09 * We want to default to C1 (hlt), not to busy polling
=2D=09=09 * unless the timer is happening really really soon.
+=09=09 * unless the timer is happening really really soon.  Still, if
+=09=09 * the exit latency of C1 is too high, we need to poll anyway.
 =09=09 */
=2D=09=09if (interactivity_req > 20 &&
+=09=09if (data->next_timer_us > 20 &&
+=09=09    drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency <=3D 2 =
&&
 =09=09    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
=2D=09=09=09dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable =3D=3D =
0)
+=09=09    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 =09=09=09data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START;
 =09} else {
 =09=09data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START;

--nextPart1755101.E5AgEk4gnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJW6KmZAAoJEILEb/54YlRxH/wP/3zRrCQb6MD3/EMnsxXP/Pvo
VURReKK/Q2towagzMshzC82z01RKL4eh6zEfAQwRVDsZVEpALMOEOGZjcFHTBKCE
ADuABTeV4CO8n0AGGtta7dCXTKnSOTAifFvo7EF3rJse4r6dG1sireUboSePPVPG
SeV/x3z9vZy3K7A0jyGClym7njy9/mRmOH88w4c71LBVQkm9ebNPNB5NSPvL3IhR
qyRPnJDf5gxLPWfp4Y+6eq/TsAu6gB8TlbLEJAKwS885yEYKltjZCBdrilQzOKHz
5aU4oNMM2JzyzVeJw55wei4Vwdm+tXQzrYDxrU/zw2tZfhu1A0phmc+RwI1X0eFp
Aup3nZGQqpitk8Kaw4ySJRayU4XssFAVv4LmXKLjPwEjbG8QDFVPZ37Z6EFqpnGs
2zYE7WHYgzy8iteweCjXgY7gJr3fG4j4F/kd232h3WRmAvx7ImvzkobA5UqTMd7B
ZeM8TWlWBfJWZS9+ONJVZ3mxBemD+qUaUC2VHbojLs4QfqyvzeT52nK7tkcvAI/T
SocLZ/2kBv/CS24Q43MI1UMGTOmkHHnC+21+u8QIYqZsKRe6fTpIcieGH5O61HGW
fKssn7fqvTylv3OrL+FOTylTRabDCacSuYyJTOboWhu5cASgrIefK2d4LTtTfOeH
7muPB44MgtdYhcWZOcng
=QhTR
-----END PGP SIGNATURE-----

--nextPart1755101.E5AgEk4gnK--

