From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] apm-emulation: implement notify/ack for
	/sys/power/state events
Date: Sun, 16 Dec 2007 19:59:11 +0100
Message-ID: <1197831551.6769.13.camel@johannes.berg>
References: <1197827906.6769.7.camel@johannes.berg>
	<200712162015.59963.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3974633288887994786=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712162015.59963.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Jamey Hicks <jamey@crl.dec.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org


--===============3974633288887994786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8NwyiXd0r4x65Qs0M0II"


--=-8NwyiXd0r4x65Qs0M0II
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Yes, I think it should go through the suspend tree, so that we can avoid =
adding
> this export.  It would be confusing otherwise.

Yes, but I think it's a fix for a regression on 2.6.24, so benh may want
to get it in there.

> > +		 * FIXME: is the suspends_pending =3D=3D 1 test racy?
>=20
> Make suspends_pending atomic?  Then, you'd not need the locking around it=
.

Yeah, I guess that's the best way to handle it. I'll send an updated
patch.

johannes

--=-8NwyiXd0r4x65Qs0M0II
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2V1fqVg1VMiehFYAQLprxAArGNk3dEcXAEkP4TF372W4yG+iz+6CODw
nMP/K0aN1GqcsJRTaU1A4860dv5ZjKBAJdnQr+sXYtgYmSAqWKtz7GaH77nOuoEQ
J+sgb5WIqWHaCMl6E4DqPwV8WCkfBg7TyzkLpcCN7KR4S29V1QYPWO2u0+04TTDO
gK40hAXMbCY2GfMp2a6I0Zhvi2YDOrvc5yL4V/DQaU4VvmskOvz6qOfmxi/tYB8v
YvvgHQoJUFM1eA0CKlnqWoLqlVUkdyGtUS2zCgS/QzzDLzikOPEgL3/yCzxdKWwv
80UyQnfTVH62LdrAgzdlQM8SoFcwsHjXS/9fhia9LdCLgx6AEN+WScPUTgAE+YBp
PgD5DOy9gM+xHBEySXc/vsnloCcTTbtgGZj+Mq9TJszMxiJPwgabEsEv88GohqUj
AN/Z/nLfWPLPEiIA5gUY8cV2a4CfPTpr/i/NermzbJwY+cepD2eAiaSkCCkkZruy
s9taP+hi6yRrcKuF09jfGgVGAQl6I6OZsQeefwSNheW9KJkGF0WVCIyKs4loUmhZ
r6VRjEXHyiGYQWEW3XALOwnKtVZVhMa/+0WA+ebJjM4KivMyIBGOd30ysBENuK8z
nu89CxFygtO36dKQLDeXJVQTEDE9Aiov5bOH2DFKPfXkLXMr6Q4GKm0TIeD9+isz
yIGna9dN/TU=
=WfRd
-----END PGP SIGNATURE-----

--=-8NwyiXd0r4x65Qs0M0II--


--===============3974633288887994786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3974633288887994786==--
