From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] PM: make freezer optional for suspend
Date: Mon, 19 Nov 2007 15:40:46 +0100
Message-ID: <1195483246.8642.3.camel@johannes.berg>
References: <1194980670.6695.1.camel@johannes.berg>
	<200711142230.14662.rjw@sisk.pl>
	<1195145246.13846.68.camel@johannes.berg>
	<200711152124.25136.rjw@sisk.pl>
	<1195228712.8147.151.camel@johannes.berg>
	<20071118182107.GA5474@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5882338273477296702=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071118182107.GA5474@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============5882338273477296702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iLeagh0IXNMuQHGEtU8G"


--=-iLeagh0IXNMuQHGEtU8G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Sun, 2007-11-18 at 18:21 +0000, Pavel Machek wrote:
> Hi!
>=20
> > > > It can't really. Things break. Ben and Paul just don't want to hear
> > > > about it. I made it depend on BROKEN so people can take it out and =
see
> > > > what breaks (to possibly fix it), and depend on ADB_PMU so they can=
 have
> > > > their favourite setting without enabling BROKEN.
> > >=20
> > > I understand that, but it's a bit confusing to put ADB_PMU, which is =
specific
> > > to powerpc, into the generic configuration file.
> >=20
> > Alright, I'll give it some thought and repost later. Maybe
> > ARCH_DOESNT_WANT_FREEZER ;)
>=20
> What about just=20
>=20
> a) reverse the logic, so that it is C_SUSPEND_NO_FREEZER
>=20
> b) hardcode it in ppc-specific config?

I also wanted people interested in debugging things w/o the freezer to
use it.

johannes

--=-iLeagh0IXNMuQHGEtU8G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0GgbaVg1VMiehFYAQKXRRAAk6RFaSiJvkbrmVFxQ+wWqcKjT/wAm02L
g7S2FiEorkWXB5eH5tK6kqks3pgxcz4D4Xlis9MRrfDjbvX6MtVH2M/QpS02xLhF
XPg0f7wJU5BOoKGvueQsiFhGdYT9fFwQn3X6+maJ3bcOqB2mhA71o9AzPOf+JQ8U
jzBf5Lb3+n5PWde/HPZquXmKTiLBtAxkhmdDONjLweab54lGSAh/wiHcZwS82xUV
DXOprhibF/d6t9JxxnH+afq/4is+UaVCvj4ZMiUbVTGi5obAZ4AQPI7mM4dcRR/8
ZG6qCSuB86kn5kr+Y+xrkk2Aoh+HUF2X0YP0kPThHhG6nmMW1ehMAQ2lzInjE2GI
4iKyirk8+IxLHdAbA8TM7aBPRckzZeG2+Fyp5FFHPgXX8qE8TDIsEmx/XRJL2Lbt
KA/uVV+tbzxRqSwIHf54/D0OQn3jVPC+fhXOw7XRNYGVnp2gpMlaOmHc0OTLVQfT
RJH0VLD+IK9aRjglPq0Dr2nptoGqX+ImmwGR84kgs9kJ0u/17VK2F37W4kmov4eW
ct5kD2j3N04nmT97R1ZpAADSRbIFEyKjEz8CSftAJ44zFcwJu8JjQ2r92TNg2Gqr
FZpchBmVTErS3AbCHn9sUikmdjieLgic/E+EAU9JCfBTfdDK7sr4XyG3BZpxmlqH
huyMqD5n1hI=
=vgP8
-----END PGP SIGNATURE-----

--=-iLeagh0IXNMuQHGEtU8G--


--===============5882338273477296702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5882338273477296702==--
