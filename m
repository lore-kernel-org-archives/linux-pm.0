From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Power Mangement Interfaces
Date: Thu, 05 Apr 2007 10:02:50 +0200
Message-ID: <1175760170.7388.67.camel@johannes.berg>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200704041144.15300.david-b@pacbell.net>
	<1175723399.7388.47.camel@johannes.berg>
	<200704042205.28200.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0130842041=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704042205.28200.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============0130842041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9mOZ16l0UNAf9l1Vn22P"


--=-9mOZ16l0UNAf9l1Vn22P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-04 at 22:05 -0700, David Brownell wrote:

> > No, the thing is more: how would we represent the lid as a device in
> > sysfs?=20
>=20
> As a platform_device.

Ok. I think the bug in my original thinking is that all these things
should be related somehow, but there's no reason the user needs to know
that the lid and the power button are controlled by the same ASIC.

johannes

--=-9mOZ16l0UNAf9l1Vn22P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFK0q/ETPhpq3jKURAknpAJ99oz2x5MR254gH4c3fhL9h7EmLggCfVc6L
uQJgz72o+BYbq9K7PNfGXTU=
=2BAL
-----END PGP SIGNATURE-----

--=-9mOZ16l0UNAf9l1Vn22P--


--===============0130842041==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0130842041==--
