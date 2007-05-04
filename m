From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 23:54:27 +0200
Message-ID: <1178315667.7408.47.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<200705042311.23557.rjw@sisk.pl>
	<1178313830.7408.43.camel@johannes.berg>
	<200705042355.19145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5471854676410739099=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042355.19145.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============5471854676410739099==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9aHpuG5s54sglv7TUAci"


--=-9aHpuG5s54sglv7TUAci
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 23:55 +0200, Rafael J. Wysocki wrote:
> On Friday, 4 May 2007 23:23, Johannes Berg wrote:
> > On Fri, 2007-05-04 at 23:11 +0200, Rafael J. Wysocki wrote:
> >=20
> > > Actually, prethaw is to prevent drivers loaded before the image is re=
stored
> > > from doing unreasonable things.  It doesn't have any effect on the dr=
ivers'
> > > .resume() routines.
> >=20
> > Oh, but it can, you could have a flag in your driver saying "the next
> > resume is after restore" and you set that flag in prethaw.
>=20
> No, you should have set that flag in .suspend(), really. :-)

Yeah, whatever. You can fix the problem but it's ugly. Let's come up
with a good way to do the 6 callbacks mentioned in some other thread
earlier.

johannes

--=-9aHpuG5s54sglv7TUAci
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO6uT/ETPhpq3jKURAkDSAKCUbCFvrStXPdI3Te278nMVD6mYKgCfdqo1
jp+pxObh2QNobY6QQRHFjU4=
=781G
-----END PGP SIGNATURE-----

--=-9aHpuG5s54sglv7TUAci--


--===============5471854676410739099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5471854676410739099==--
