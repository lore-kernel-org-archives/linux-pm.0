From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/06] sh: Add support for multiple hwblk counters
Date: Fri, 10 Jul 2009 00:19:44 +0900
Message-ID: <20090709151944.8385.62628.sendpatchset__20044.4423164756$1247153078$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
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
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Extend the SuperH hwblk code to support more than one counter.
This is needed by the Runtime PM prototype implementation.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/hwblk.h            |   13 +++++-
 arch/sh/kernel/cpu/hwblk.c             |   69 +++++++++++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c |    4 -
 3 files changed, 60 insertions(+), 26 deletions(-)

--- 0001/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2009-07-09 18:38:04.000000000 +0900
@@ -4,6 +4,9 @@
 #include <asm/clock.h>
 #include <asm/io.h>
 
+#define HWBLK_CNT_USAGE 0
+#define HWBLK_CNT_NR 1
+
 #define HWBLK_AREA_FLAG_PARENT (1 << 0) /* valid parent */
 
 #define HWBLK_AREA(_flags, _parent)		\
@@ -13,7 +16,7 @@
 }
 
 struct hwblk_area {
-	unsigned long cnt;
+	int cnt[HWBLK_CNT_NR];
 	unsigned char parent;
 	unsigned char flags;
 };
@@ -29,7 +32,7 @@ struct hwblk {
 	void __iomem *mstp;
 	unsigned char bit;
 	unsigned char area;
-	unsigned long cnt;
+	int cnt[HWBLK_CNT_NR];
 };
 
 struct hwblk_info {
@@ -46,6 +49,12 @@ int arch_hwblk_sleep_mode(void);
 int hwblk_register(struct hwblk_info *info);
 int hwblk_init(void);
 
+void hwblk_enable(struct hwblk_info *info, int hwblk);
+void hwblk_disable(struct hwblk_info *info, int hwblk);
+
+void hwblk_cnt_inc(struct hwblk_info *info, int hwblk, int cnt);
+void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int cnt);
+
 /* allow clocks to enable and disable hardware blocks */
 #define SH_HWBLK_CLK(_name, _id, _parent, _hwblk, _flags)	\
 {							\
--- 0001/arch/sh/kernel/cpu/hwblk.c
+++ work/arch/sh/kernel/cpu/hwblk.c	2009-07-09 18:34:46.000000000 +0900
@@ -9,38 +9,64 @@
 
 static DEFINE_SPINLOCK(hwblk_lock);
 
-static void hwblk_area_inc(struct hwblk_info *info, int area)
+static void hwblk_area_mod_cnt(struct hwblk_info *info,
+			       int area, int counter, int value, int goal)
 {
 	struct hwblk_area *hap = info->areas + area;
 
-	hap->cnt++;
-	if (hap->cnt == 1)
-		if (hap->flags & HWBLK_AREA_FLAG_PARENT)
-			hwblk_area_inc(info, hap->parent);
+	hap->cnt[counter] += value;
+
+	if (hap->cnt[counter] != goal)
+		return;
+
+	if (hap->flags & HWBLK_AREA_FLAG_PARENT)
+		hwblk_area_mod_cnt(info, hap->parent, counter, value, goal);
 }
 
-static void hwblk_area_dec(struct hwblk_info *info, int area)
+
+static int __hwblk_mod_cnt(struct hwblk_info *info, int hwblk,
+			  int counter, int value, int goal)
 {
-	struct hwblk_area *hap = info->areas + area;
+	struct hwblk *hp = info->hwblks + hwblk;
+
+	hp->cnt[counter] += value;
+	if (hp->cnt[counter] == goal)
+		hwblk_area_mod_cnt(info, hp->area, counter, value, goal);
 
-	if (hap->cnt == 1)
-		if (hap->flags & HWBLK_AREA_FLAG_PARENT)
-			hwblk_area_dec(info, hap->parent);
-	hap->cnt--;
+	return hp->cnt[counter];
 }
 
-static void hwblk_enable(struct hwblk_info *info, int hwblk)
+static void hwblk_mod_cnt(struct hwblk_info *info, int hwblk,
+			  int counter, int value, int goal)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwblk_lock, flags);
+	__hwblk_mod_cnt(info, hwblk, counter, value, goal);
+	spin_unlock_irqrestore(&hwblk_lock, flags);
+}
+
+void hwblk_cnt_inc(struct hwblk_info *info, int hwblk, int counter)
+{
+	hwblk_mod_cnt(info, hwblk, counter, 1, 1);
+}
+
+void hwblk_cnt_dec(struct hwblk_info *info, int hwblk, int counter)
+{
+	hwblk_mod_cnt(info, hwblk, counter, -1, 0);
+}
+
+void hwblk_enable(struct hwblk_info *info, int hwblk)
 {
 	struct hwblk *hp = info->hwblks + hwblk;
 	unsigned long tmp;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&hwblk_lock, flags);
 
-	hp->cnt++;
-	if (hp->cnt == 1) {
-		hwblk_area_inc(info, hp->area);
-
+	ret = __hwblk_mod_cnt(info, hwblk, HWBLK_CNT_USAGE, 1, 1);
+	if (ret == 1) {
 		tmp = __raw_readl(hp->mstp);
 		tmp &= ~(1 << hp->bit);
 		__raw_writel(tmp, hp->mstp);
@@ -49,27 +75,26 @@ static void hwblk_enable(struct hwblk_in
 	spin_unlock_irqrestore(&hwblk_lock, flags);
 }
 
-static void hwblk_disable(struct hwblk_info *info, int hwblk)
+void hwblk_disable(struct hwblk_info *info, int hwblk)
 {
 	struct hwblk *hp = info->hwblks + hwblk;
 	unsigned long tmp;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&hwblk_lock, flags);
 
-	if (hp->cnt == 1) {
-		hwblk_area_dec(info, hp->area);
-
+	ret = __hwblk_mod_cnt(info, hwblk, HWBLK_CNT_USAGE, -1, 0);
+	if (ret == 0) {
 		tmp = __raw_readl(hp->mstp);
 		tmp |= 1 << hp->bit;
 		__raw_writel(tmp, hp->mstp);
 	}
-	hp->cnt--;
 
 	spin_unlock_irqrestore(&hwblk_lock, flags);
 }
 
-static struct hwblk_info *hwblk_info;
+struct hwblk_info *hwblk_info;
 
 int __init hwblk_register(struct hwblk_info *info)
 {
--- 0001/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/hwblk-sh7722.c	2009-07-09 18:38:48.000000000 +0900
@@ -91,10 +91,10 @@ static struct hwblk_info sh7722_hwblk_in
 
 int arch_hwblk_sleep_mode(void)
 {
-	if (!sh7722_hwblk_area[CORE_AREA].cnt)
+	if (!sh7722_hwblk_area[CORE_AREA].cnt[HWBLK_CNT_USAGE])
 		return SUSP_SH_STANDBY | SUSP_SH_SF;
 
-	if (!sh7722_hwblk_area[CORE_AREA_BM].cnt)
+	if (!sh7722_hwblk_area[CORE_AREA_BM].cnt[HWBLK_CNT_USAGE])
 		return SUSP_SH_SLEEP | SUSP_SH_SF;
 
 	return SUSP_SH_SLEEP;
