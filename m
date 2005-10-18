From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] Threads shouldn't inherit PF_NOFREEZE
Date: Tue, 18 Oct 2005 15:29:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510181515450.4518-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750823AbVJRT3r@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

The PF_NOFREEZE process flag should not be inherited when a thread is 
forked.  This patch (as585) removes the flag from the child.

This problem is starting to show up more and more as drivers turn to the
kthread API instead of using kernel_thread().  As a result, their kernel
threads are now children of the kthread worker instead of modprobe, and
they inherit the PF_NOFREEZE flag.  This can cause problems during system
suspend; the kernel threads are not getting frozen as they ought to be.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

What I said above may not be quite true.  For all I know, there may be
threads which rely on inheriting PF_NOFREEZE from their parent.  But it
should not be inherited by default.

Index: usb-2.6/kernel/fork.c
===================================================================
--- usb-2.6.orig/kernel/fork.c
+++ usb-2.6/kernel/fork.c
@@ -848,7 +848,7 @@ static inline void copy_flags(unsigned l
 {
 	unsigned long new_flags = p->flags;
 
-	new_flags &= ~PF_SUPERPRIV;
+	new_flags &= ~(PF_SUPERPRIV | PF_NOFREEZE);
 	new_flags |= PF_FORKNOEXEC;
 	if (!(clone_flags & CLONE_PTRACE))
 		p->ptrace = 0;
