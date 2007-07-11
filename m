From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 3/7] Freezer: Prevent new tasks from
	inheriting TIF_FREEZE set
Date: Thu, 12 Jul 2007 00:12:03 +0200
Message-ID: <200707120012.04747.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120006.50095.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Tasks should go to the refrigerator only if explicitly requested to do th=
at by
the freezer and not as a result of inheriting the TIF_FREEZE flag set fro=
m the
parent. =A0Make it happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/fork.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.22-rc6-mm1/kernel/fork.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/kernel/fork.c	2007-07-11 20:48:04.000000000=
 +0200
+++ linux-2.6.22-rc6-mm1/kernel/fork.c	2007-07-11 20:50:42.000000000 +020=
0
@@ -932,6 +932,7 @@ static inline void copy_flags(unsigned l
 	if (!(clone_flags & CLONE_PTRACE))
 		p->ptrace =3D 0;
 	p->flags =3D new_flags;
+	clear_freeze_flag(p);
 }
=20
 asmlinkage long sys_set_tid_address(int __user *tidptr)
