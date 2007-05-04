From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 22:21:21 +0200
Message-ID: <1178310082.7408.33.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705042220.24518.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3525472632096776419=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042220.24518.rjw@sisk.pl>
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


--===============3525472632096776419==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SdUhKHGczZhKNFSUQJbd"


--=-SdUhKHGczZhKNFSUQJbd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 22:20 +0200, Rafael J. Wysocki wrote:

> > On the other hand, steps 6 and 7 aren't really needed for hibernation. =
=20
> > You _could_ shut the system off completely (ACPI S5).  Automatic wakeup
> > wouldn't work, but the next time the user turned the computer on manual=
ly
> > it would still resume from hibernation.
>=20
> That's correct, with the exception that the user may find the system not =
fully
> functional after the resume in that case.

Why is that anyway? Is it just a matter of the acpi code getting
confused about the acpi bios state? How can the acpi bios possibly be
screwed up after what it must see as a fresh boot? Does the acpi code
poke it in ways it's not supposed to be poked after a fresh boot?

johannes

--=-SdUhKHGczZhKNFSUQJbd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO5XB/ETPhpq3jKURAgqlAKCxq9pZxs4hdlv/AvEi5nwaHJVvWACffwRe
3MgXaJJ/4vOSCC7cjeMir0o=
=QQHb
-----END PGP SIGNATURE-----

--=-SdUhKHGczZhKNFSUQJbd--


--===============3525472632096776419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3525472632096776419==--
