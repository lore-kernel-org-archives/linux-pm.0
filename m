From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 2/3] windfarm: dont die on suspend thread signal
Date: Tue, 12 Dec 2006 00:02:10 +0100
Message-ID: <28551.7943128527$1165922040@news.gmane.org>
References: <20061211230208.526233000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=windfarm-dont-die-on-signals.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: Torrance <torrance123@gmail.com>, Michael Hanselmann <linux-kernel@hansmi.ch>, linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>
List-Id: linux-pm@vger.kernel.org

When the windfarm thread gets a suspend signal it will die instead of
freezing. This fixes it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6-git.orig/drivers/macintosh/windfarm_core.c	2006-12-11 23:34:4=
7.082716759 +0100
+++ linux-2.6-git/drivers/macintosh/windfarm_core.c	2006-12-11 23:37:58.181=
716759 +0100
@@ -93,8 +93,6 @@ static int wf_thread_func(void *data)
 	DBG("wf: thread started\n");
 =

 	while(!kthread_should_stop()) {
-		try_to_freeze();
-
 		if (time_after_eq(jiffies, next)) {
 			wf_notify(WF_EVENT_TICK, NULL);
 			if (wf_overtemp) {
@@ -117,8 +115,8 @@ static int wf_thread_func(void *data)
 		if (delay <=3D HZ)
 			schedule_timeout_interruptible(delay);
 =

-		/* there should be no signal, but oh well */
-		if (signal_pending(current)) {
+		/* there should be no non-suspend signal, but oh well */
+		if (signal_pending(current) && !try_to_freeze()) {
 			printk(KERN_WARNING "windfarm: thread got sigl !\n");
 			break;
 		}

--
