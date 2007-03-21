From: sukadev@us.ibm.com
Subject: Re: [linux-pm] 2.6.21-rc4-mm1: freezing of processes broken
Date: Wed, 21 Mar 2007 11:07:13 -0700
Message-ID: <20070321180713.GA27575@us.ibm.com>
References: <20070319205623.299d0378.akpm@linux-foundation.org> <1174446834.6665.3.camel@nigel.suspend2.net> <20070321142350.GB78@tv-sign.ru> <200703211545.17919.rjw@sisk.pl> <20070321082029.2a38e09f.akpm@linux-foundation.org> <20070321165534.GA476@tv-sign.ru> <20070321090824.38d67ce3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751876AbXCUSHV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070321090824.38d67ce3.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Chinner <dgc@sgi.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@nigel.suspend2.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Andrew Morton [akpm@linux-foundation.org] wrote:
| On Wed, 21 Mar 2007 19:55:34 +0300 Oleg Nesterov <oleg@tv-sign.ru> wrote:
| 
| > On 03/21, Andrew Morton wrote:
| > >
| > > On Wed, 21 Mar 2007 15:45:16 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
| > > 
| > > > On Wednesday, 21 March 2007 15:23, Oleg Nesterov wrote:
| > > > > > 
| > > > > > Could the freezer code be trying to freeze the idle thread as a result?
| > > > > 
| > > > > Yes. remove-the-likelypid-check-in-copy_process.patch make idle threads
| > > > > visible to for_each_process/do_each_thread. Note also that idle threads
| > > > > have ->mm != NULL. freezer, oom_kill, move_task_off_dead_cpu, etc, should
| > > > > not see idle threads, but they do now.
| > > > 
| > > > Well, I think this is a good enough reason for asking Andrew to drop this
| > > > patch.
| > > 
| > > Or we change the freezer to skip pid==0 tasks.
| > 
| > I strongly disagree. In that case we should audit all users of for_each_process.
| > Imho, this change is too dangerous. Actually, I personally think it is very good
| > that idle threads are special and not visible, imho we should not change this.
| 
| OK, I'll tentatively drop remove-the-likelypid-check-in-copy_process.patch

Yes. Pls drop it for now. Here is the slightly modified 

	use-task_pgrp-task_session-in-copy_process.patch

This applies cleanly with remove-the-likelypid-check-in-copy_process.patch
removed.
---
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Subject: [PATCH] Use task_pgrp() task_session() in copy_process().

Use task_pgrp() and task_session() in copy_process(), and
avoid find_pid() call when attaching the task to its process
group and session.

Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>
---
 kernel/fork.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: lx26-21-rc3-mm2/kernel/fork.c
===================================================================
--- lx26-21-rc3-mm2.orig/kernel/fork.c	2007-03-21 10:51:44.000000000 -0700
+++ lx26-21-rc3-mm2/kernel/fork.c	2007-03-21 10:53:48.000000000 -0700
@@ -1253,14 +1253,11 @@ static struct task_struct *copy_process(
 		tracehook_init_task(p);
 
 		if (thread_group_leader(p)) {
-			pid_t pgid = process_group(current);
-			pid_t sid = process_session(current);
-
 			p->signal->tty = current->signal->tty;
-			p->signal->pgrp = pgid;
+			p->signal->pgrp = process_group(current);
 			set_signal_session(p->signal, process_session(current));
-			attach_pid(p, PIDTYPE_PGID, find_pid(pgid));
-			attach_pid(p, PIDTYPE_SID, find_pid(sid));
+			attach_pid(p, PIDTYPE_PGID, task_pgrp(current));
+			attach_pid(p, PIDTYPE_SID, task_session(current));
 
 			list_add_tail_rcu(&p->tasks, &init_task.tasks);
 			__get_cpu_var(process_counts)++;
