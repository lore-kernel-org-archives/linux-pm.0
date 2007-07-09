From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 4/6] Freezer: Prevent new tasks from
	inheriting TIF_FREEZE set
Date: Mon, 9 Jul 2007 22:34:54 +0200
Message-ID: <200707092234.55437.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707092229.08898.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Tasks should go to the refrigerator only if explicitly requested to do that by
the freezer and not as a result of inheriting the TIF_FREEZE flag set from the
parent.  Make it happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/fork.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.22-rc6-mm1/kernel/fork.c
===================================================================
--- linux-2.6.22-rc6-mm1.orig/kernel/fork.c
+++ linux-2.6.22-rc6-mm1/kernel/fork.c
@@ -932,6 +932,7 @@ static inline void copy_flags(unsigned l
 	if (!(clone_flags & CLONE_PTRACE))
 		p->ptrace = 0;
 	p->flags = new_flags;
+	clear_freeze_flag(p);
 }
 
 asmlinkage long sys_set_tid_address(int __user *tidptr)
