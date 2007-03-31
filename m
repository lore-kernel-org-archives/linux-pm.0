From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 02:21:30 +0200
Message-ID: <1175300491.23438.40.camel@johannes.berg>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1336961554=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175300283.23438.38.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org


--===============1336961554==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gcT86/1Q4vviHgw/2LP7"


--=-gcT86/1Q4vviHgw/2LP7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-03-31 at 02:18 +0200, Johannes Berg wrote:

> > I am now turning my attention to handling wakeup events - in particular=
,
> > events that we can set at run-time.  My thoughts on the matter are=20
> > detailed here:
> >=20
> > http://wiki.laptop.org/go/Power_Management_Interface

Hm, another thing. The RTC alarm wakeup event, wouldn't that require
programming the time too? And if so, should that be done through the
power interface to it?

johannes

--=-gcT86/1Q4vviHgw/2LP7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGDamK/ETPhpq3jKURAnEYAJ4t1KdfPs5WTC/POvwrhgl/njDceQCbBx7d
U+D0mODmC7xJFe0DIrfqclc=
=7JuQ
-----END PGP SIGNATURE-----

--=-gcT86/1Q4vviHgw/2LP7--


--===============1336961554==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1336961554==--
