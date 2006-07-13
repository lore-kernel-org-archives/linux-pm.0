From: Nigel Cunningham <nigel@suspend2.net>
Subject: [PATCH] Rt-tester makes freezing processes fail.
Date: Fri, 14 Jul 2006 09:18:43 +1000
Message-ID: <200607140918.49040.nigel@suspend2.net>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1519839.1496W9ZNkl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161044AbWGMXSs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@timesys.com>, Linux-pm list <linux-pm@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--nextPart1519839.1496W9ZNkl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Compiling in the rt-tester currently makes freezing processes fail.
I don't think there's anything wrong with it running during
suspending, so adding PF_NOFREEZE to the flags set seems to be the
right solution.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 rtmutex-tester.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c 9971-rt-tester.=
patch-new/kernel/rtmutex-tester.c
=2D-- 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07 10:27:46.=
000000000 +1000
+++ 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14 07:48:01.00=
0000000 +1000
@@ -259,7 +259,7 @@ static int test_func(void *data)
 	struct test_thread_data *td =3D data;
 	int ret;
=20
=2D	current->flags |=3D PF_MUTEX_TESTER;
+	current->flags |=3D PF_MUTEX_TESTER | PF_NOFREEZE;
 	allow_signal(SIGHUP);
=20
 	for(;;) {


--nextPart1519839.1496W9ZNkl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEttTYN0y+n1M3mo0RAjGRAJwL5ubwjpA0odnoeTXhk6r8Vmb4oACglwTR
JmR0MHTeNk+dSS3M0jh2YYI=
=TpOi
-----END PGP SIGNATURE-----

--nextPart1519839.1496W9ZNkl--
