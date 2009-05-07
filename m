From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] genirq: update irq_chip struct comment for
	irq_chip->disable hook
Date: Wed,  6 May 2009 17:17:47 -0700
Message-ID: <1241655468-5750-1-git-send-email-khilman__22247.2623260275$1241655942$gmane$org@deeprootsystems.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

The irq_chip disable hook no longer defaults to a irq_chip->unmask.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 include/linux/irq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b7cbeed..3674046 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -88,7 +88,7 @@ struct msi_desc;
  * @startup:		start up the interrupt (defaults to ->enable if NULL)
  * @shutdown:		shut down the interrupt (defaults to ->disable if NULL)
  * @enable:		enable the interrupt (defaults to chip->unmask if NULL)
- * @disable:		disable the interrupt (defaults to chip->mask if NULL)
+ * @disable:		disable the interrupt
  * @ack:		start of a new interrupt
  * @mask:		mask an interrupt source
  * @mask_ack:		ack and mask an interrupt source
-- 
1.6.2.2
