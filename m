From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] PM: suspend_device_irqs(): don't disable wakeup
	IRQs
Date: Mon,  4 May 2009 17:27:04 -0700
Message-ID: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Interrupts that are flagged as wakeup sources via set_irq_wake()
should not be disabled for suspend.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 kernel/irq/pm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 638d8be..99113bd 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -28,6 +28,9 @@ void suspend_device_irqs(void)
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 
+		if (desc->status & IRQ_WAKEUP)
+			continue;
+
 		spin_lock_irqsave(&desc->lock, flags);
 		__disable_irq(desc, irq, true);
 		spin_unlock_irqrestore(&desc->lock, flags);
-- 
1.6.2.2
