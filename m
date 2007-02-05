From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/10] windfarm: dont die on suspend thread
	signal
Date: Mon, 05 Feb 2007 23:55:34 +0100
Message-ID: <1170716134.30959.15.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205145425.5f6ecbb0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1159011150=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205145425.5f6ecbb0.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1159011150==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-74l907ZxJkcCj5mB0+/n"


--=-74l907ZxJkcCj5mB0+/n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 14:54 -0800, Andrew Morton wrote:

> That sounds like a fairly irritating feature.  Should we backport this in=
to 2.6.20?

It'll apply just fine, but don't bother. No machine that actually uses
this windfarm infrastructure can suspend right now.

johannes

--=-74l907ZxJkcCj5mB0+/n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFx7Xm/ETPhpq3jKURAnddAJ4/EF3dXyMonTuo6eNrdt8JjTgSswCfe5jI
GRpjdHxk+YB7GjXOVOJ++J8=
=hOoM
-----END PGP SIGNATURE-----

--=-74l907ZxJkcCj5mB0+/n--


--===============1159011150==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1159011150==--
