From: Anchal Agarwal <anchalag@amazon.com>
Subject: [RFC PATCH 10/12] xen/events: add xen_shutdown_pirqs helper function
Date: Tue, 12 Jun 2018 20:56:17 +0000
Message-ID: <20180612205619.28156-11-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Cc: boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, netdev@vger.kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kamatam@amazon.com, anchalag@amazon.com, fllinden@amazon.com, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Add a simple helper function to "shutdown" active PIRQs, which actually
closes event channels but keeps related IRQ structures intact. PM
suspend/hibernation code will rely on this.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/xen/events/events_base.c | 12 ++++++++++++
 include/xen/events.h             |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 762378f..88137c8 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1581,6 +1581,18 @@ void xen_irq_resume(void)
 	restore_pirqs();
 }
 
+void xen_shutdown_pirqs(void)
+{
+	struct irq_info *info;
+
+	list_for_each_entry(info, &xen_irq_list_head, list) {
+		if (info->type != IRQT_PIRQ || !VALID_EVTCHN(info->evtchn))
+			continue;
+
+		shutdown_pirq(irq_get_irq_data(info->irq));
+	}
+}
+
 static struct irq_chip xen_dynamic_chip __read_mostly = {
 	.name			= "xen-dyn",
 
diff --git a/include/xen/events.h b/include/xen/events.h
index c3e6bc6..e4d5ccb 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -70,6 +70,7 @@ static inline void notify_remote_via_evtchn(int port)
 void notify_remote_via_irq(int irq);
 
 void xen_irq_resume(void);
+void xen_shutdown_pirqs(void);
 
 /* Clear an irq's pending state, in preparation for polling on it */
 void xen_clear_irq_pending(int irq);
-- 
2.7.4
