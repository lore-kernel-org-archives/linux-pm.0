From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/38] pm: chsc subchannel driver power
	management callbacks
Date: Thu, 04 Jun 2009 18:18:57 +0200
Message-ID: <20090604161901.823428795__7074.56862223825$1244142334$gmane$org@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pm_chsc_sch.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/cio/chsc_sch.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/cio/chsc_sch.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/chsc_sch.c
+++ linux-2.6/drivers/s390/cio/chsc_sch.c
@@ -1,7 +1,8 @@
 /*
  * Driver for s390 chsc subchannels
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2009
+ *
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  */
@@ -112,6 +113,31 @@ static void chsc_subchannel_shutdown(str
 	cio_disable_subchannel(sch);
 }
 
+static int chsc_subchannel_prepare(struct subchannel *sch)
+{
+	int cc;
+	struct schib schib;
+	/*
+	 * Don't allow suspend while the subchannel is not idle
+	 * since we don't have a way to clear the subchannel and
+	 * cannot disable it with a request running.
+	 */
+	cc = stsch(sch->schid, &schib);
+	if (!cc && scsw_stctl(&schib.scsw))
+		return -EAGAIN;
+	return 0;
+}
+
+static int chsc_subchannel_freeze(struct subchannel *sch)
+{
+	return cio_disable_subchannel(sch);
+}
+
+static int chsc_subchannel_restore(struct subchannel *sch)
+{
+	return cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+}
+
 static struct css_device_id chsc_subchannel_ids[] = {
 	{ .match_flags = 0x1, .type =SUBCHANNEL_TYPE_CHSC, },
 	{ /* end of list */ },
@@ -125,6 +151,10 @@ static struct css_driver chsc_subchannel
 	.probe = chsc_subchannel_probe,
 	.remove = chsc_subchannel_remove,
 	.shutdown = chsc_subchannel_shutdown,
+	.prepare = chsc_subchannel_prepare,
+	.freeze = chsc_subchannel_freeze,
+	.thaw = chsc_subchannel_restore,
+	.restore = chsc_subchannel_restore,
 	.name = "chsc_subchannel",
 };
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
