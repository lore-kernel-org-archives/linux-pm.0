From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 08/12] arm64: Add support for ACPI based firmware tables
Date: Fri, 12 Jan 2018 18:59:16 -0600
Message-ID: <20180113005920.28658-9-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180113005920.28658-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

For arm64, if ACPI is enabled, determine the max number of cache
levels and populate them using the PPTT table if one is available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 380f2e2fbed5..0bf0a835122f 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cacheinfo.h>
 #include <linux/of.h>
 
@@ -46,7 +47,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 static int __init_cache_level(unsigned int cpu)
 {
-	unsigned int ctype, level, leaves, of_level;
+	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,15 +60,19 @@ static int __init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	of_level = of_find_last_cache_level(cpu);
-	if (level < of_level) {
+	if (acpi_disabled)
+		fw_level = of_find_last_cache_level(cpu);
+	else
+		fw_level = acpi_find_last_cache_level(cpu);
+
+	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
 		 * the information may be available in the device tree
 		 * only unified external caches are considered here
 		 */
-		leaves += (of_level - level);
-		level = of_level;
+		leaves += (fw_level - level);
+		level = fw_level;
 	}
 
 	this_cpu_ci->num_levels = level;
-- 
2.13.5
