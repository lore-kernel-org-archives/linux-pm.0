From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Fri, 8 Apr 2005 13:23:50 +0200
Message-ID: <200504081323.51164.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
	<200504072303.15502.rjw@sisk.pl> <20050408062306.GB1381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19380496109541312=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050408062306.GB1381@elf.ucw.cz>
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

--===============19380496109541312==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j38BNgs3007373

Hi,

On Friday, 8 of April 2005 08:23, Pavel Machek wrote:
> On =C4=8Ct 07-04-05 23:03:15, Rafael J. Wysocki wrote:
> > Hi,
> >=20
> > On Thursday, 7 of April 2005 22:00, Alan Stern wrote:
> > > On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
> > ]--snip--[=20
> > > > > If that means waiting more than 10 seconds or so, you should ju=
st give up. =20
> > > > > Return an error and put a message in the log saying something l=
ike "Can't
> > > > > suspend because process XXX is busy".
> > > >=20
> > > > OK, that's what we do now.  Except that IMO we should clear the P=
F_FREEZE flag
> > > > for this process and do recalc_sigpending() for it after we give =
up, because
> > > > otherwise it will enter the refrigerator sooner or later and it w=
ill stay there.
> > > > Alternatively, we can disable the "freezing loop" in refrigerator=
() as soon as
> > > > thaw_processes() is started.  Also, we can avoid setting PF_FREEZ=
E for
> > > > processes in TASK_UNINTERRUPTIBLE, but count them as "freezable".=
  Etc.
> > >=20
> > > Yes, all the necessary cleanup steps should be taken.
> >=20
> > Pavel, which approach do you like most?
>=20
> Clearing PF_FREEZE when we fail to stop some process sounds okay to
> me. It would be nice if the patch was actually tested ;-).

The patch (against 2.6.12-rc2) follows.  It has been tested, but of cours=
e it's difficult to
recreate every possible scenario. :-)

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>=20

--- old/kernel/power/process.c	2005-04-08 13:12:55.000000000 +0200
+++ new/kernel/power/process.c	2005-04-08 13:15:23.000000000 +0200
@@ -60,6 +60,7 @@ int freeze_processes(void)
        int todo;
        unsigned long start_time;
 	struct task_struct *g, *p;
+	unsigned long flags;
 =09
 	printk( "Stopping tasks: " );
 	start_time =3D jiffies;
@@ -67,7 +68,6 @@ int freeze_processes(void)
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
-			unsigned long flags;
 			if (!freezeable(p))
 				continue;
 			if ((p->flags & PF_FROZEN) ||
@@ -85,13 +85,28 @@ int freeze_processes(void)
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		yield();			/* Yield is okay here */
-		if (time_after(jiffies, start_time + TIMEOUT)) {
+		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
 			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo=
 );
-			return todo;
+			break;
 		}
 	} while(todo);
 =09
+	if (todo) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p)
+			if (p->flags & PF_FREEZE) {
+				pr_debug("  clean up: %s\n", p->comm);
+				p->flags &=3D ~PF_FREEZE;
+				spin_lock_irqsave(&p->sighand->siglock, flags);
+				recalc_sigpending_tsk(p);
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			}
+		while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+		return todo;
+	}
+	=09
 	printk( "|\n" );
 	BUG_ON(in_atomic());
 	return 0;

--=20
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


--===============19380496109541312==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============19380496109541312==--
