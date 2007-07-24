From: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Subject: [PATCH 2.6.23-rc1] PM: fix compiler error of PPC
	dart_iommu
Date: Tue, 24 Jul 2007 20:20:56 +0900
Message-ID: <200707241120.AA00211@paprika.lab.ntt.co.jp>
Reply-To: ryusuke@osrg.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: moriai.satoshi@lab.ntt.co.jp, Andrew Morton <akpm@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

A dummy inline function of register_nosave_region_late was accidentally
removed by the recent PM patch that introduced suspend notifiers.
This elimination causes the following compiler error on PPC machines.

  CC      arch/powerpc/sysdev/dart_iommu.o
arch/powerpc/sysdev/dart_iommu.c: In function 'iommu_init_late_dart':
arch/powerpc/sysdev/dart_iommu.c:376: error: implicit declaration of function 
'register_nosave_region_late'
make[1]: *** [arch/powerpc/sysdev/dart_iommu.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

This patch fixes the problem.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
---
 include/linux/suspend.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index e8e6da3..618f93c 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -125,6 +125,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline void register_nosave_region(unsigned long b, unsigned long e)
 {
 }
+static inline void register_nosave_region_late(unsigned long b, unsigned long e)
+{
+}
 #endif
 
 #endif /* _LINUX_SWSUSP_H */
