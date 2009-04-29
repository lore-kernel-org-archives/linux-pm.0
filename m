From: Greg KH <gregkh@suse.de>
Subject: [patch 29/58] sched: do not count frozen tasks toward
	load
Date: Wed, 29 Apr 2009 15:07:28 -0700
Message-ID: <20090429220927.416887820__22172.6127704189$1241043852$gmane$org@mini.kroah.org>
References: <20090429220659.339950874@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=0060-sched-do-not-count-frozen-tasks-toward-load.patch
In-Reply-To: <20090429221657.GA11765@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, alan@lxorguk.ukuu.org.uk, Eugene Teo <eteo@redhat.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Nathan Lynch <ntl@pobox.com>, linux-pm@lists.linux-foundation.org, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>, Chuck Wolber <chuckw@quantumlinux.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Jake Edge <jake@lwn.net>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Theodore Ts'o <tytso@mit.edu>, containers@lists.linux-foundation.org, Chuck Ebbert <cebbert@redhat.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>
List-Id: linux-pm@vger.kernel.org

2.6.27-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Nathan Lynch <ntl@pobox.com>

upstream commit: e3c8ca8336707062f3f7cb1cd7e6b3c753baccdd

Freezing tasks via the cgroup freezer causes the load average to climb
because the freezer's current implementation puts frozen tasks in
uninterruptible sleep (D state).

Some applications which perform job-scheduling functions consult the
load average when making decisions.  If a cgroup is frozen, the load
average does not provide a useful measure of the system's utilization
to such applications.  This is especially inconvenient if the job
scheduler employs the cgroup freezer as a mechanism for preempting low
priority jobs.  Contrast this with using SIGSTOP for the same purpose:
the stopped tasks do not count toward system load.

Change task_contributes_to_load() to return false if the task is
frozen.  This results in /proc/loadavg behavior that better meets
users' expectations.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Tested-by: Nigel Cunningham <nigel@tuxonice.net>
Cc: containers@lists.linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org
Cc: Matt Helsley <matthltc@us.ibm.com>
LKML-Reference: <20090408194512.47a99b95@manatee.lan>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/sched.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -201,7 +201,8 @@ extern unsigned long long time_sync_thre
 #define task_is_stopped_or_traced(task)	\
 			((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 #define task_contributes_to_load(task)	\
-				((task->state & TASK_UNINTERRUPTIBLE) != 0)
+				((task->state & TASK_UNINTERRUPTIBLE) != 0 && \
+				 (task->flags & PF_FROZEN) == 0)
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
