From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 8/8] OMAP3: update cpuidle latency and threshold
	figures
Date: Fri,  2 Sep 2011 15:13:24 +0200
Message-ID: <1314969204-21704-9-git-send-email-j-pihet__40522.9182252244$1314969294$gmane$org@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Update the data from the measurements performed at HW and SW levels.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers magically coming from.

ToDo:
- Measure the wake-up latencies for all power domains for OMAP3
- Correct some numbers when sys_clkreq and sys_offmode are supported

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index b43d1d2..3f37e89 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -45,19 +45,19 @@
  */
 static struct cpuidle_params cpuidle_params_table[] = {
 	/* C1 . MPU WFI + Core active */
-	{2 + 2, 5, 1},
+	{73 + 78, 152, 1},
 	/* C2 . MPU WFI + Core inactive */
-	{10 + 10, 30, 1},
+	{165 + 88, 345, 1},
 	/* C3 . MPU CSWR + Core inactive */
-	{50 + 50, 300, 1},
+	{163 + 182, 345, 1},
 	/* C4 . MPU OFF + Core inactive */
-	{1500 + 1800, 4000, 1},
+	{2852 + 605, 150000, 1},
 	/* C5 . MPU RET + Core RET */
-	{2500 + 7500, 12000, 1},
+	{800 + 366, 2120, 1},
 	/* C6 . MPU OFF + Core RET */
-	{3000 + 8500, 15000, 1},
+	{4080 + 801, 215000, 1},
 	/* C7 . MPU OFF + Core OFF */
-	{10000 + 30000, 300000, 1},
+	{4300 + 13000, 215000, 1},
 };
 #define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
 
-- 
1.7.4.1
