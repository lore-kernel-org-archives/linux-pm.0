From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 08:41:54 +0200
Message-ID: <200504060841.54490.rjw@sisk.pl>
References: <200504051120.44496.rjw@sisk.pl> <20050405225751.GA1353@elf.ucw.cz>
	<1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67247148441319382=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112742641.3757.58.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============67247148441319382==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 6 of April 2005 01:10, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2005-04-06 at 08:57, Pavel Machek wrote:
> > Hi!
> > 
> > > > > 2) We can try to force uninterruptible tasks to get their "signals" anyway using
> > > > > wake_up_state() directly on them (which I don't like as much).
> > > > 
> > > > They are probably uninterruptible for a reason...
> > > > 
> > > > If something is staying in UNINTERRUPTIBLE for more than 1 second, it
> > > > is going to cause problems elsewhere, anyway. Do you see that happening?
> > > 
> > > Probably.  Please see, for example, this message sent to l-k:
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=111268969510393&w=2
> > 
> > ...hmm, perhaps kseriod needs suspend/resume support, or something;

It seems that anything compiled in (ie not as a module) which ends up in
call_usermodehelper() during boot is likely to need this kind of handling.

> > but that does not mean we should handle *all* uninterruptible tasks
> > that way.
> > 
> > > I can easily trigger a similar behavior with an uninterruptible task and I
> > > have some problems with freezing tasks on SMP that smell like this too.
> > > 
> > > If we are going to ignore uninterruptible tasks, I'd propose to set PF_FREEZE
> > > and TIF_SIGPENDING for them without counting them as "todo" in
> > 
> > You can't just ignore uninterruptible tasks, sorry.
> 
> I don't think Rafael is suggesting ignoring them.

Words, words ... ;-)

> He's suggesting what I'm already doing:
> - Signal so they enter the freezer if they leave the state;
> - Don't count them when deciding whether freezing failed;
> - Handle the case where they don't leave the state until post resume (I
> let them enter the refrigerator, but have code in there to check whether
> the freezer is still on).

Yup.  Actaully, I think of something like this (tested once):

--- old/kernel/power/process.c	2005-04-06 08:30:47.000000000 +0200
+++ new/kernel/power/process.c	2005-04-06 08:31:31.000000000 +0200
@@ -18,6 +18,7 @@
  */
 #define TIMEOUT	(6 * HZ)
 
+static int refrigerator_disabled;
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -47,9 +48,12 @@ void refrigerator(unsigned long flag)
 	recalc_sigpending(); /* We sent fake signal, clean it up */
 	spin_unlock_irq(&current->sighand->siglock);
 
-	current->flags |= PF_FROZEN;
-	while (current->flags & PF_FROZEN)
-		schedule();
+	if (!refrigerator_disabled) {
+		current->flags |= PF_FROZEN;
+		while (current->flags & PF_FROZEN)
+			schedule();
+	}
+
 	pr_debug("%s left refrigerator\n", current->comm);
 	current->state = save;
 }
@@ -62,6 +66,7 @@ int freeze_processes(void)
 	struct task_struct *g, *p;
 	
 	printk( "Stopping tasks: " );
+	refrigerator_disabled = 0;
 	start_time = jiffies;
 	do {
 		todo = 0;
@@ -72,6 +77,9 @@ int freeze_processes(void)
 				continue;
 			if (p->flags & PF_FROZEN)
 				continue;
+			if ((p->flags & PF_FREEZE) &&
+			    (p->state == TASK_UNINTERRUPTIBLE))
+			    	continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
@@ -100,6 +108,7 @@ void thaw_processes(void)
 	struct task_struct *g, *p;
 
 	printk( "Restarting tasks..." );
+	refrigerator_disabled = 1;
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		if (!freezeable(p))

>
> In this way, I handle kseriod and anything else uninterruptible without
> any problems.

Exactly. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============67247148441319382==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67247148441319382==--
