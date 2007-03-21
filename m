From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 14:12:53 +0100
Message-ID: <1174482773.4230.19.camel@johannes.berg>
References: <1174468981.3769.8.camel@johannes.berg>
	<20070321122954.GO4520@elf.ucw.cz>
	<1174480375.4230.12.camel@johannes.berg>
	<20070321131128.GB4523@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0344972802=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070321131128.GB4523@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0344972802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WNWu9RD4DnQzimHdu2yO"


--=-WNWu9RD4DnQzimHdu2yO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 14:11 +0100, Pavel Machek wrote:
> On Wed 2007-03-21 13:32:55, Johannes Berg wrote:
> > On Wed, 2007-03-21 at 13:29 +0100, Pavel Machek wrote:
> >=20
> > > Does it really need to be this complex? Maybe we can disply change
> > > /sys/power/disk format? Is the change required at all?
> >=20
> > Dunno. Does anything ever read it? Maybe the whole change isn't
> > necessary since this thing exists only as a hack for ACPI anyway, but i=
f
> > anybody starts using it with an actual choice being able to see the
> > choices would imho be useful.
>=20
> I believe we can just show the list of choices, without changing the
> name.

Ok, I can simplify the patch down to that, the only thing about that is
that it breaks userspace ABI. Dunno how people react to that with
suspend though :)

johannes

--=-WNWu9RD4DnQzimHdu2yO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAS9V/ETPhpq3jKURAmBdAKCduThb3W52ezwq0nr8jj21CoJGmQCgrR9W
l1Sc3/aC7WML9YFpTtREWuU=
=Q4r4
-----END PGP SIGNATURE-----

--=-WNWu9RD4DnQzimHdu2yO--


--===============0344972802==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0344972802==--
