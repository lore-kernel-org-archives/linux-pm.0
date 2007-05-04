From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 23:53:11 +0200
Message-ID: <1178315591.7408.45.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<1178312930.7408.38.camel@johannes.berg>
	<20070504211519.GA24246@elf.ucw.cz>  <200705042353.52409.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0877085197549085809=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042353.52409.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0877085197549085809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5JYwldefVlQ4ZhULwsXn"


--=-5JYwldefVlQ4ZhULwsXn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 23:53 +0200, Rafael J. Wysocki wrote:
> > Plus, it may have some parts related to the communications with operati=
ng
> > system (*)... I guess we need to save those, and parts related to hw
> > state... where your suggestion makes sense.
>=20
> If they are accessible to us, then we can, but what if they aren't (eg. t=
he
> state information is stored in the embedded controller, can only be read =
with
> the help of some AML invocations and cannot be changed from the OS level)=
?

Well, in that case you also haven't overwritten/changed them during
restore so there's no room for mismatches and confusion.

johannes

--=-5JYwldefVlQ4ZhULwsXn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO6tG/ETPhpq3jKURAqYLAJ9tg0JRuNoPkrQVcxFy4PDFWVnGYACgjsQk
vaHE/ZLJB2mWZgrjSi76vTE=
=ayHi
-----END PGP SIGNATURE-----

--=-5JYwldefVlQ4ZhULwsXn--


--===============0877085197549085809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0877085197549085809==--
