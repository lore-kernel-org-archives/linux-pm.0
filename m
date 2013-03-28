From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH V2 01/12] mfd: db8500: Add IO force function
Date: Thu, 28 Mar 2013 17:11:27 +0100
Message-ID: <1364487098-10319-2-git-send-email-rickard.andersson@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hongbo.zhang@linaro.org, ulf.hansson@linaro.org, khilman@linaro.org, linus.walleij@stericsson.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com
List-Id: linux-pm@vger.kernel.org

The IO force signal needs to be controlled when
the system enters/exits the sleep state ApSleep.
This hardware signal tells the system that some
pins could be driven by GPIO settings instead of
directly from the hardware block.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 drivers/mfd/db8500-prcmu.c       | 9 +++++++++
 include/linux/mfd/db8500-prcmu.h | 1 +
 include/linux/mfd/dbx500-prcmu.h | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 268f45d..7f32575 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -879,6 +879,15 @@ bool db8500_prcmu_pending_irq(void)
 	return false;
 }
 
+void db8500_prcmu_set_ioforce(bool enable)
+{
+	u32 val = readl(PRCM_IOCR) & ~PRCM_IOCR_IOFORCE;
+
+	if (enable)
+		val |= PRCM_IOCR_IOFORCE;
+	writel(val, PRCM_IOCR);
+}
+
 /*
  * This function checks if the specified cpu is in in WFI. It's usage
  * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 6ee4247..21660f6 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -547,6 +547,7 @@ int db8500_prcmu_gic_recouple(void);
 int db8500_prcmu_copy_gic_settings(void);
 bool db8500_prcmu_gic_pending_irq(void);
 bool db8500_prcmu_pending_irq(void);
+void db8500_prcmu_set_ioforce(bool enable);
 bool db8500_prcmu_is_cpu_in_wfi(int cpu);
 void db8500_prcmu_enable_wakeups(u32 wakeups);
 int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index c202d6c..2909546 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -267,6 +267,11 @@ static inline bool prcmu_pending_irq(void)
 	return db8500_prcmu_pending_irq();
 }
 
+static inline void prcmu_set_ioforce(bool force)
+{
+	return db8500_prcmu_set_ioforce(force);
+}
+
 static inline int prcmu_set_epod(u16 epod_id, u8 epod_state)
 {
 	return db8500_prcmu_set_epod(epod_id, epod_state);
-- 
1.8.2
