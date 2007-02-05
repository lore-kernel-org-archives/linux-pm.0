From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 02/10] windfarm: dont die on suspend thread signal
Date: Mon, 05 Feb 2007 19:30:29 +0100
Message-ID: <20070205185835.700233000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline; filename=windfarm-dont-die-on-signals.patch
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

When the windfarm thread gets a suspend signal it will die instead of
freezing. This fixes it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Please apply to -mm.

--- mb-wireless.orig/drivers/macintosh/windfarm_core.c	2007-02-05 14:24:06.344526864 +0100
+++ mb-wireless/drivers/macintosh/windfarm_core.c	2007-02-05 14:24:38.264526864 +0100
@@ -94,8 +94,6 @@ static int wf_thread_func(void *data)
 	DBG("wf: thread started\n");
 
 	while(!kthread_should_stop()) {
-		try_to_freeze();
-
 		if (time_after_eq(jiffies, next)) {
 			wf_notify(WF_EVENT_TICK, NULL);
 			if (wf_overtemp) {
@@ -118,8 +116,8 @@ static int wf_thread_func(void *data)
 		if (delay <= HZ)
 			schedule_timeout_interruptible(delay);
 
-		/* there should be no signal, but oh well */
-		if (signal_pending(current)) {
+		/* there should be no non-suspend signal, but oh well */
+		if (signal_pending(current) && !try_to_freeze()) {
 			printk(KERN_WARNING "windfarm: thread got sigl !\n");
 			break;
 		}

--
