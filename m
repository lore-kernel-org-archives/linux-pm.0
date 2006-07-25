From: David Brownell <david-b@pacbell.net>
Subject: bus.suspend_prepare()
Date: Tue, 25 Jul 2006 11:17:30 -0700
Message-ID: <200607251117.32105.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061527.29421.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hmm ... I just noticed that the swsusp code path (PM_SUSPEND_DISK)
is ignoring the new suspend_prepare() mechanism.

That doesn't seem like a good thing ... Linus, is there a reason you
did it that way?  Why is there no sibling resume_complete()?  ISTR
that Ben was the advocate of a suspend_prepare(), but the use cases
for this call are unclear to me ...

- Dave


This makes the prepare_suspend() phase apply to all suspend modes,
instead of ignoring it for swsusp.

Potential changes:

    -	Add a sibling bus.resume_complete() to allow cleanup.

    -	Remove the pm_message_t parameter bus.suspend_early() since there
	appears to be no useful way for it to be used with any value
	other than PMSG_SUSPEND ... and the intent of calling this while
	userspace and other tasks is still active seems to be to allow
	userspace notification about the desired state change.

    -	Provide a sys/power/sleep_state file so that userspace can know if
	the upcoming sleep state is "standby", STR/"mem", STD/"disk", or
	"on" (whenever it's not suspending).


Index: g26/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/kernel/power/main.c	2006-07-15 18:15:21.000000000 -0700
+++ g26/kernel/power/main.c	2006-07-25 10:59:38.000000000 -0700
@@ -54,13 +54,6 @@ static int suspend_prepare(suspend_state
 	int error =3D 0;
 	unsigned int free_pages;
 =

-	if (!pm_ops || !pm_ops->enter)
-		return -EPERM;
-
-	error =3D device_prepare_suspend(PMSG_SUSPEND);
-	if (error)
-		return error;
-
 	pm_prepare_console();
 =

 	disable_nonboot_cpus();
@@ -187,9 +180,20 @@ static int enter_state(suspend_state_t s
 =

 	if (!valid_state(state))
 		return -ENODEV;
+	if (state !=3D PM_SUSPEND_DISK && (!pm_ops || !pm_ops->enter))
+		return -EPERM;
+
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 =

+	error =3D device_prepare_suspend(PMSG_SUSPEND);
+	if (error) {
+		/* FIXME don't we need a bus.resume_complete() mechanism, if
+		 * only to reverse the effect of bus.suspend_prepare() ??
+		 */
+		goto Unlock;
+	}
+
 	if (state =3D=3D PM_SUSPEND_DISK) {
 		error =3D pm_suspend_disk();
 		goto Unlock;
