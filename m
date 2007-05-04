From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 23:23:50 +0200
Message-ID: <1178313830.7408.43.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<200705042250.29760.rjw@sisk.pl>
	<1178311750.7408.34.camel@johannes.berg>
	<200705042311.23557.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4660299324670861987=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042311.23557.rjw@sisk.pl>
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


--===============4660299324670861987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kSXRS5xPiI8UPJ6dOuFt"


--=-kSXRS5xPiI8UPJ6dOuFt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 23:11 +0200, Rafael J. Wysocki wrote:

> Actually, prethaw is to prevent drivers loaded before the image is restor=
ed
> from doing unreasonable things.  It doesn't have any effect on the driver=
s'
> .resume() routines.

Oh, but it can, you could have a flag in your driver saying "the next
resume is after restore" and you set that flag in prethaw.

johannes

--=-kSXRS5xPiI8UPJ6dOuFt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO6Rl/ETPhpq3jKURAngjAKCCS6qNcnBBgxtsXEAMkxfRNRE35QCgqhTl
0Cp1rbszTDrTh/GSuPk6ugY=
=f6rH
-----END PGP SIGNATURE-----

--=-kSXRS5xPiI8UPJ6dOuFt--


--===============4660299324670861987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4660299324670861987==--
