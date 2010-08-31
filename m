From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Bug 17571 - blk/ata-sff/unknown-boot-option related
	backtrace on resume with TuxOnIce
Date: Tue, 31 Aug 2010 21:40:41 +0200
Message-ID: <201008312140.51242.Martin__32723.8712845885$1283283731$gmane$org@lichtvoll.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7466839999036650210=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: tuxonice-devel@tuxonice.net
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============7466839999036650210==
Content-Type: multipart/signed;
  boundary="nextPart4451559.4buckCxIlP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4451559.4buckCxIlP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Nigel, hi Raphael, hi Linux-PM team,

I reported this in this in the mainline kernel bugzilla tough it may well=20
be a TuxOnIce bug for three reasons:=20

1) The backtrace looks pretty generic, no toi* symbols at least in the=20
last part shown on the screen.

2) bugzilla.tuxonice.net timed out. Okay, that not that good reason.

3) Raphaels interest in TuxOnIce bugs.

Linux-PM folks, feel free to ignore this unless Nigel thinks its not a=20
TuxOnIce problem.



Bug 17571 -  blk/ata-sff/unknown-boot-option related backtrace on resume=20
with TuxOnIce

I am testing 2.6.35.4 with TuxOnIce 3.2-rc1 on my ThinkPad T23.

After I few hibernation cycles I now got a backtrace on resume. I tried=20
twice before discarding the image.

I don't know yet, whether it happens regularily. I am attaching a=20
screenshot of the backtrace.

https://bugzilla.kernel.org/show_bug.cgi?id=3D17571

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart4451559.4buckCxIlP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkx9WroACgkQmRvqrKWZhMe2VwCfWRHBwYycaH7dASz9+zBoEA3r
zSwAnRxIhnST5kPOc/gqooAB/0EihnBF
=uaax
-----END PGP SIGNATURE-----

--nextPart4451559.4buckCxIlP--

--===============7466839999036650210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7466839999036650210==--
