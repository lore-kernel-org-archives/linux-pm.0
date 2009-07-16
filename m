From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] [suspend] pci_raw_set_power_state: replace
	msleep by udelay in resuming procedure
Date: Thu, 16 Jul 2009 23:43:27 +0800
Message-ID: <1247759007-27411-1-git-send-email-wuzhangjin__47441.2696589299$1247762834$gmane$org@gmail.com>
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
Cc: len.brown@intel.com, yanh@lemote.com, linux-kernel@vger.kernel.org, wuzj@lemote.com, zhangfx@lemote.com
List-Id: linux-pm@vger.kernel.org

we can not call msleep() when resuming from STR/Standby: if the
current_state of the pci device is PCI_D3hot, means we are in the
procedure of resuming, in this procedure, we can not re-schedule,
otherwise, there will be a deadlock.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/pci/pci.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 440f4fb..3d9a4e2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -497,8 +497,18 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+
+	/* we can not call msleep() when resume:
+	 *
+	 *   if the current_state is PCI_D3hot, means we are in the procedure
+	 *   of resuming, in this procedure, we can not re-schedule, otherwise,
+	 *   there will be a deadlock.
+	 */
+
+	if (state == PCI_D3hot)
 		msleep(pci_pm_d3_delay);
+	else if (dev->current_state == PCI_D3hot)
+		udelay(pci_pm_d3_delay);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
-- 
1.6.2.1
