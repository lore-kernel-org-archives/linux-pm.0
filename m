From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: Re: freeze_processes questions
Date: Wed, 27 Apr 2005 17:30:41 +0800
Message-ID: <1114594241.12809.37.camel@sli10-desk.sh.intel.com>
References: <200504081323.51164.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26042315241258041=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504081323.51164.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============26042315241258041==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
Sorry for raising the problem again after a long time. I got some
reports about ' xxx not stopped' at suspend time. The general cause is
one task is waiting for another task which has been into refrigerator
first. Report an error and stop suspend can't solve the problem. After
the task's dependent task is released from refrigerator, the task itself
will soon go into refrigerator and will never be waked up. 
Nigel's refrigerator patch half solves the problem. It distinct kernel
tasks and user tasks, so can solve the dependence between kernel tasks
and user tasks, but can't solve the user tasks dependence. Right, Nigel?
Below is a proposal method to solve the issue. Assume task A depends on
task B. Task B is frozen first. When we find task A can't be frozen
after a long time, we thaw all tasks and let task A continue (task A has
gotten a freeze signal so it will soon go into refrigerator) and then we
freeze other tasks again. In theory, this can solve all task dependence
(sure can't solve the circled dependence) if the retry times are enough
big, but cost maybe too high. Looks it help my case (syslogd can't be
stopped because it's waitting for kjournald). Any idea?

Thanks,
Shaohua



---

 linux-2.6.11-root/kernel/power/process.c |   36 +++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff -puN kernel/power/process.c~freeze_process_order kernel/power/process.c
--- linux-2.6.11/kernel/power/process.c~freeze_process_order	2005-04-27 15:39:38.014090112 +0800
+++ linux-2.6.11-root/kernel/power/process.c	2005-04-27 17:02:37.884034808 +0800
@@ -16,7 +16,8 @@
 /* 
  * Timeout for stopping processes
  */
-#define TIMEOUT	(6 * HZ)
+#define TIMEOUT	(3 * HZ)
+#define RETRY (2)
 
 
 static inline int freezeable(struct task_struct * p)
@@ -54,12 +55,34 @@ void refrigerator(unsigned long flag)
 	current->state = save;
 }
 
+static void freeze_processes_failure(void)
+{
+	struct task_struct *g, *p;
+
+	/* thaw frozen processes and let process which received a frozen signal
+	 * but was waitting for other process go.
+	 */
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p))
+			continue;
+		if (p->flags & PF_FROZEN) {
+			p->flags &= ~PF_FROZEN;
+			wake_up_process(p);
+		}
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	yield();
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
        int todo;
        unsigned long start_time;
 	struct task_struct *g, *p;
+	int retry_times = 1;
 	
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
@@ -86,9 +109,14 @@ int freeze_processes(void)
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
 		if (time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			return todo;
+			if (retry_times >= RETRY) {
+				printk( "\n" );
+				printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+				return todo;
+			}
+			retry_times ++;
+			start_time = jiffies;
+ 			freeze_processes_failure();
 		}
 	} while(todo);
 	
_



--===============26042315241258041==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26042315241258041==--
