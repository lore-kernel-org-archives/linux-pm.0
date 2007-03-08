From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re:	Remove page flags for software suspend)
Date: Thu, 08 Mar 2007 16:09:03 +0100
Message-ID: <1173366543.3248.1.camel@johannes.berg>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<45E6EEC5.4060902@yahoo.com.au> <200703011633.54625.rjw@sisk.pl>
	<200703041450.02178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0099494036=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703041450.02178.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0099494036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tg6Y6JTKtqyyHRYuNFvM"


--=-tg6Y6JTKtqyyHRYuNFvM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Okay, the next three messages contain patches that should do the trick.
>=20
> They have been tested on x86_64, but not very thoroughly.

Works on my powerbook as well. Never mind that usb is broken again with
suspend to disk. And my own patches break both str and std right now.

But these (on top of wireless-dev which is currently about 2.6.21-rc2)
work fine as long as I assume they don't break usb ;)

johannes

--=-tg6Y6JTKtqyyHRYuNFvM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF8CcP/ETPhpq3jKURArA5AKCxPQpBgmSav9hwcHE+NRb4WAWJYQCfW6Cl
zASVP9lneXImRQUyn+hlQOc=
=s9WX
-----END PGP SIGNATURE-----

--=-tg6Y6JTKtqyyHRYuNFvM--


--===============0099494036==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0099494036==--
