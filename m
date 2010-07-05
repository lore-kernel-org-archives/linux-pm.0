From: Valdis.Kletnieks@vt.edu
Subject: mmotm 2010-07-01 pm_get_wakeup_count() declaration
Date: Mon, 05 Jul 2010 16:35:36 -0400
Message-ID: <74766.1278362136__18400.067909579$1278362320$gmane$org@localhost>
References: <201007011948.o61JmnT2022795@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7887194883585351199=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Thu, 01 Jul 2010 12:19:51 PDT."
	<201007011948.o61JmnT2022795@imap1.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============7887194883585351199==
Content-Type: multipart/signed; boundary="==_Exmh_1278362136_4495P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1278362136_4495P
Content-Type: text/plain; charset=us-ascii

On Thu, 01 Jul 2010 12:19:51 PDT, akpm@linux-foundation.org said:
> The mm-of-the-moment snapshot 2010-07-01-12-19 has been uploaded to

Not sure who to blame for the commit, it was in the linux-next.patch and I'm
too lazy to pull down the git tree and dig it out.

  CC      kernel/power/main.o
kernel/power/main.c: In function 'wakeup_count_show':
kernel/power/main.c:241: error: implicit declaration of function 'pm_get_wakeup_count'
kernel/power/main.c: In function 'wakeup_count_store':
kernel/power/main.c:251: error: implicit declaration of function 'pm_save_wakeup_count'
make[2]: *** [kernel/power/main.o] Error 1

Problem is that declaration in include/linux/suspend.h is wrapped in
a #ifdef CONFIG_PM_SLEEP, but the usage in kernel/power/main.c isn't. So
it dies a horrid death if your config doesn't include PM_SLEEP.

--==_Exmh_1278362136_4495P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMMkIYcC3lWbTT17ARAiK5AKCFH+wKqddKak0q92FzUIvIrk/rrwCgqGLf
nPAv8+nNsZ/iUjxjvKKh/j8=
=Ubv5
-----END PGP SIGNATURE-----

--==_Exmh_1278362136_4495P--


--===============7887194883585351199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7887194883585351199==--
