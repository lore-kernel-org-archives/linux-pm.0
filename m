From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 20:48:34 +1000
Message-ID: <200606282048.38746.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1741657168=="
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Mime-version: 1.0
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

--===============1741657168==
Content-Type: multipart/signed; boundary="nextPart1420535.EvX7lUtGpV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1420535.EvX7lUtGpV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

I received a report of problems with CONFIG_REGPARM and suspending, that le=
d=20
me to recheck asm calls and declarations. Not being a guru on these things,=
 I=20
want to ask advice from those who know more.

Along the way I noticed that current git has:

extern asmlinkage int swsusp_arch_suspend(void);
extern asmlinkage int swsusp_arch_resume(void);

This is right for x86, but for x86_64, we actually call a C routine in=20
arch/x86_64/kernel/suspend.c, which calls restore_image in=20
arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c as=
=20

extern int restore_image(void);

should it be:

extern asmlinkage int restore_image(void);

Having swsusp_arch_resume declared as asmlinkage doesn't matter, does it?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1420535.EvX7lUtGpV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEol6GN0y+n1M3mo0RAheSAKCzlOA4dWc0hw1vQR+Gsq9I1u2tzQCgo3dK
9abTdhPjYny1S4EbYXjHTag=
=xGWS
-----END PGP SIGNATURE-----

--nextPart1420535.EvX7lUtGpV--


--===============1741657168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Suspend2-devel mailing list
Suspend2-devel@lists.suspend2.net
http://lists.suspend2.net/mailman/listinfo/suspend2-devel

--===============1741657168==--
