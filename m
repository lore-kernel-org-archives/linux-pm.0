From: jean.pihet@newoldbits.com
Subject: [PATCH 6/6] OMAP3: powerdomain data: add wake-up latency
	figures
Date: Mon, 12 Dec 2011 17:18:21 +0100
Message-ID: <1323706701-6627-7-git-send-email-j-pihet__30589.4037745476$1323707213$gmane$org@ti.com>
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>
Cc: Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Figures are added to the power domains structs for RET and OFF modes.

Note: the latency figures for MPU, PER, CORE, NEON have been obtained
from actual measurements.
The latency figures for the other power domains are preliminary and
shall be added.

Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
for a detailed explanation on where are the numbers coming from.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c |   83 +++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 8ef26da..63a3afd 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -31,6 +31,19 @@
 
 /*
  * Powerdomains
+ *
+ * The wakeup_lat values are derived from HW and SW measurements on
+ * the actual target. For more details cf.
+ * http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement#Results_for_individual_power_domains
+ *
+ * Note: the latency figures for MPU, PER, CORE, NEON have been obtained
+ * from actual measurements.
+ * The latency figures for the other power domains are preliminary and
+ * shall be added.
+ *
+ * Note: only the SW restore timing values are taken into account.
+ * The HW impact of the sys_clkreq and sys_offmode signals is not taken
+ * into account - TDB
  */
 
 static struct powerdomain iva2_pwrdm = {
@@ -51,6 +64,13 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRSTS_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1100,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 350,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -67,6 +87,13 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1830,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 121,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -94,6 +121,13 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 3082,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 153,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -116,6 +150,13 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 3082,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 153,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -131,6 +172,13 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 70,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 20,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -152,6 +200,13 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -167,6 +222,13 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 850,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 35,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -182,6 +244,13 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 671,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 31,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
@@ -196,6 +265,13 @@ static struct powerdomain neon_pwrdm = {
 	.prcm_offs	  = OMAP3430_NEON_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 0,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 0,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "mpu_iva" },
 };
 
@@ -218,6 +294,13 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 800,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 150,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 	.voltdm           = { .name = "core" },
 };
 
-- 
1.7.5.4
