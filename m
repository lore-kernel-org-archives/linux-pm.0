From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 11:44:12 +0200
Message-ID: <1175852652.3489.67.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049179102=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704061141.31677.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1049179102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eLvYzeHdR8rmYYCXy9yR"


--=-eLvYzeHdR8rmYYCXy9yR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 11:41 +0200, Rafael J. Wysocki wrote:

> Frankly, I'm not sure.
>=20
> For practical purposes the BUG_ON() assertions will suffice, so I think y=
ou
> can keep the two handlers.  I'd change the names, though, to something
> like quiesce() and activate(), for example.

Sure.

> [Hm, it feels more appropriate to define them for all platforms and make =
them
> call local_irq_save() on the platforms that don't need to do anything mor=
e.]

Is there much point in that? It seems to make implementing new pm_ops a
bit more complex seeing that nobody but us seems to require such a thing
yet.

> BTW, please remember to update the SNAPSHOT_S2RAM ioctl accordingly (well=
,
> I think we should move the common code to a separate function).

Good point. I'll take a look.

johannes

--=-eLvYzeHdR8rmYYCXy9yR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFhZs/ETPhpq3jKURArdUAJ9O2WuP6+brfCVYXuFaMMsotDbJbwCeOkSB
r+CX6+Po/ivIRoFgJTCNrUs=
=v+2a
-----END PGP SIGNATURE-----

--=-eLvYzeHdR8rmYYCXy9yR--


--===============1049179102==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1049179102==--
