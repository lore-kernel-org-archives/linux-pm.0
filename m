From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH revision 2] windfarm: dont die on suspend thread
	signal
Date: Mon, 05 Feb 2007 23:54:34 +0100
Message-ID: <1170716074.30959.13.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205224325.GA8453@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205224325.GA8453@lst.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

When the windfarm thread gets a suspend signal it will die instead of
freezing. This fixes it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Adresses Christoph's comment: This keeps the original try_to_freeze() in
place and just remove the code that kills the thread on a signal.

--- mb-wireless.orig/drivers/macintosh/windfarm_core.c	2007-02-05 16:07:10.=
524524763 +0100
+++ mb-wireless/drivers/macintosh/windfarm_core.c	2007-02-05 23:49:46.00452=
4763 +0100
@@ -117,12 +117,6 @@ static int wf_thread_func(void *data)
 		delay =3D next - jiffies;
 		if (delay <=3D HZ)
 			schedule_timeout_interruptible(delay);
-
-		/* there should be no signal, but oh well */
-		if (signal_pending(current)) {
-			printk(KERN_WARNING "windfarm: thread got sigl !\n");
-			break;
-		}
 	}
 =

 	DBG("wf: thread stopped\n");
