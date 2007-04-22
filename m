From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Free more memory
Date: Mon, 23 Apr 2007 08:22:35 +1000
Message-ID: <1177280555.18406.71.camel@nigel.suspend2.net>
References: <200704220002.37083.rjw@sisk.pl> <200704220005.39942.rjw@sisk.pl>
	<1177198299.4036.8.camel@nigel.suspend2.net>
	<200704221137.34104.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1121980391390569433=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704221137.34104.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1121980391390569433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OBHJfzZbTny5ObRdQ+Dw"


--=-OBHJfzZbTny5ObRdQ+Dw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sun, 2007-04-22 at 11:37 +0200, Rafael J. Wysocki wrote:
> On Sunday, 22 April 2007 01:31, Nigel Cunningham wrote:
> > Hi.
> >=20
> > On Sun, 2007-04-22 at 00:05 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >=20
> > > Move the definition of PAGES_FOR_IO to kernel/power/power.h and intro=
duce
> > > SPARE_PAGES representing the number of pages that should be freed by =
the
> > > swsusp's memory shrinker in addition to PAGES_FOR_IO so that device d=
rivers can
> > > allocate some memory (up to 1 MB total) in their .suspend() routines =
without
> > > causing the suspend to fail.
> >=20
> > 1MB is not going to be enough for people with DRI. I have a cycle on my
> > machine recording 3510 extra pages (13 meg) allocated during the atomic
> > copy, and I know there are others with larger numbers.
>=20
> I know.  The other mechanism (ie. notifiers) is for them.
>=20
> The idea of this patch is to make it possible to _avoid_ using the notifi=
ers
> if you need only a limited amount of memory.

That's fine when the notifiers are actually used, but for the moment....

Regards,

Nigel

--=-OBHJfzZbTny5ObRdQ+Dw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGK+ArN0y+n1M3mo0RArEHAJ4n9/GEQOVpXzDBjIfl6gK/RnTLvgCdEPCX
CCxefA0QAm0hUB4uN3XcBtQ=
=9G/C
-----END PGP SIGNATURE-----

--=-OBHJfzZbTny5ObRdQ+Dw--


--===============1121980391390569433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1121980391390569433==--
