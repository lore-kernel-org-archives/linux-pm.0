From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 12:47:17 +0100
Message-ID: <20060201114717.GA1768@elf.ucw.cz>
References: <200602010141.53974.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495318944709406=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602010141.53974.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============2495318944709406==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is an experimantal patch aimed at the "unable to freeze processes under
> load" problem.
> 
> On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> "dd if=/dev/hda of=/dev/null" test.
> 
> Please have a look.

It makes it better (well, I used my own, simpler variant, but that
should not matter; patch is attached). I now can't reproduce hangs
with simple stress testing, but running kernel make alongside that
makes it hang sometimes. Example of non-frozen gcc:

gcc           D EEE06A70     0  1750   1749  1751
(NOTLB)
df85df38 00000046 bf878130 eee06a70 00004111 eee06a70 eee06a70
003d0900
       00000000 c0137cf5 df85c000 00000000 c058ada2 c012503e ef2c915c
ef2c9030
       c1c0b480 7c3b8500 003d0927 df85c000 00000a98 7c3b8500 003d0927
c0770800
Call Trace:
 [<c0137cf5>] attach_pid+0x25/0xb0
 [<c058ada2>] _write_unlock_irq+0x12/0x30
 [<c012503e>] copy_process+0xe5e/0x11b0
 [<c0588f74>] wait_for_completion+0x94/0xd0
 [<c0121690>] default_wake_function+0x0/0x10
 [<c01254d9>] do_fork+0x149/0x210
 [<c0101218>] sys_vfork+0x28/0x30
 [<c0103231>] syscall_call+0x7/0xb

...maybe solving this would solve journalling problems, too? It is
similar AFAICT.
								Pavel

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index e24446f..90d6c1a 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -87,7 +87,6 @@ static int prepare_processes(void)
 	int error;
 
 	pm_prepare_console();
-	sys_sync();
 	disable_nonboot_cpus();
 
 	if (freeze_processes()) {
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 02a1b3a..bd16e44 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -16,7 +16,7 @@
 /* 
  * Timeout for stopping processes
  */
-#define TIMEOUT	(6 * HZ)
+#define TIMEOUT	(60 * HZ)
 
 
 static inline int freezeable(struct task_struct * p)
@@ -54,32 +54,53 @@ void refrigerator(void)
 	current->state = save;
 }
 
+static void freeze_process(struct task_struct *p)
+{
+       unsigned long flags;
+
+       freeze(p);
+       spin_lock_irqsave(&p->sighand->siglock, flags);
+       signal_wake_up(p, 0);
+       spin_unlock_irqrestore(&p->sighand->siglock, flags);
+}
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
-	int todo;
+	int todo, user_frozen, nr_user;
 	unsigned long start_time;
 	struct task_struct *g, *p;
 	unsigned long flags;
 
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
+	user_frozen = 0;
 	do {
-		todo = 0;
+		nr_user = todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (!freezeable(p))
 				continue;
 			if (frozen(p))
 				continue;
-
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
+			if (p->mm) {
+				/* The task is a user-space one. Freeze it */
+				freeze_process(p);
+				todo++;
+				nr_user++;
+			} else {
+				/* Freeze only if the user space is frozen */
+				if (user_frozen)
+					freeze_process(p);
+				todo++;
+			}
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
+		if (!user_frozen && !nr_user) {
+			printk("sync");
+			sys_sync();
+		}
+		user_frozen = !nr_user;
 		yield();			/* Yield is okay here */
 		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 41f6636..c9c293f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -80,7 +80,7 @@ static int save_highmem_zone(struct zone
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
 
-		if (!(pfn%1000))
+		if (!(pfn%10000))
 			printk(".");
 		if (!pfn_valid(pfn))
 			continue;
@@ -121,13 +121,14 @@ int save_highmem(void)
 	struct zone *zone;
 	int res = 0;
 
-	pr_debug("swsusp: Saving Highmem\n");
+	pr_debug("swsusp: Saving Highmem");
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			res = save_highmem_zone(zone);
 		if (res)
 			return res;
 	}
+	printk("\n");
 	return 0;
 }
 

-- 
Thanks, Sharp!

--===============2495318944709406==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2495318944709406==--
