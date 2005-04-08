From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Fri, 8 Apr 2005 11:13:40 +0200
Message-ID: <200504081113.41044.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
	<200504072259.56759.rjw@sisk.pl> <20050408062010.GA1381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============024708191311795691=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050408062010.GA1381@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============024708191311795691==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 8 of April 2005 08:20, Pavel Machek wrote:
> Hi!
> 
]--snip--[
> 
> As we allow resume to be called from userland, other refrigerator is
> not really an option. We could insert mdelay before resume, or some
> equivalent trick...

I have an idea (provided we can disable/enable usermodehelper as in the
Dmitry's patch):

--- old/kernel/power/process.c	2005-04-06 08:30:47.000000000 +0200
+++ new/kernel/power/process.c	2005-04-08 11:11:23.000000000 +0200
@@ -62,6 +62,26 @@ int freeze_processes(void)
 	struct task_struct *g, *p;
 	
 	printk( "Stopping tasks: " );
+	usermodehelper_disable();
+	yield();
+	start_time = jiffies;
+	do {
+		todo = 0;
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p)
+			if (!(p->flags & PF_NOFREEZE) &&
+			    (p->state == TASK_UNINTERRUPTIBLE))
+				todo++;
+		while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+		yield();
+		if (time_after(jiffies, start_time + TIMEOUT)) {
+			printk( "\n" );
+			printk(KERN_ERR " stopping tasks faliled (%d unstoppable tasks)\n",
+					todo);
+			return todo;
+		}
+	} while(todo);
 	start_time = jiffies;
 	do {
 		todo = 0;
@@ -100,6 +120,7 @@ void thaw_processes(void)
 	struct task_struct *g, *p;
 
 	printk( "Restarting tasks..." );
+	usermodehelper_enable();
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		if (!freezeable(p))

It's not bullet-proof, but should be enough to handle the
"freeze-during-resume" case ...

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============024708191311795691==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============024708191311795691==--
