From: Johannes Berg <johannes@sipsolutions.net>
Subject: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 10:11:20 +0100
Message-ID: <1174468281.3769.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1171669471=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1171669471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YyWK0AHWznkrvI9Q6xRX"


--=-YyWK0AHWznkrvI9Q6xRX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Is that configuration possible? It seems not since I can't find any
compat code for the ioctl which shares pointers and structs, is there
any way to make it possible?

johannes

--=-YyWK0AHWznkrvI9Q6xRX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAPa4/ETPhpq3jKURAsneAKC5W5kkxtrsj3hBjmUzpfIxAYIrSQCfUMSy
wau3HCs5YcZY9M5IE+AI9Lo=
=gZ26
-----END PGP SIGNATURE-----

--=-YyWK0AHWznkrvI9Q6xRX--


--===============1171669471==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1171669471==--
