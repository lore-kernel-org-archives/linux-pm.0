From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 6/9] OMAP4: powerdomain data: add wake-up
	latency figures
Date: Fri, 24 Jun 2011 16:38:03 +0200
Message-ID: <1308926286-30445-7-git-send-email-j-pihet__26530.5982124575$1308926440$gmane$org@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lis>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Vishwanath BS <vishwanath.bs@ti.com>

This patch adds wake up latency numbers for OMAP4. Note that these are
preliminary numbers and need to be relooked.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

The INACTIVE state is added as unsupported.

Tested on OMAP4 Pandaboard in RET/OFF using wake-up latency constraints on
MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   85 +++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4222c7..9b90d88 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -54,6 +54,13 @@ static struct powerdomain core_44xx_pwrdm = {
 		[4] = PWRSTS_ON,	/* ducati_unicache */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -71,6 +78,13 @@ static struct powerdomain gfx_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* gfx_mem */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* abe_44xx_pwrdm: Audio back end power domain */
@@ -91,6 +105,13 @@ static struct powerdomain abe_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* periphmem */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* dss_44xx_pwrdm: Display subsystem power domain */
@@ -109,6 +130,13 @@ static struct powerdomain dss_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* dss_mem */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* tesla_44xx_pwrdm: Tesla processor power domain */
@@ -131,6 +159,13 @@ static struct powerdomain tesla_44xx_pwrdm = {
 		[2] = PWRSTS_ON,	/* tesla_l2 */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* wkup_44xx_pwrdm: Wake-up power domain */
@@ -164,6 +199,13 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* cpu0_l1 */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* cpu1_44xx_pwrdm: MPU1 processor and Neon coprocessor power domain */
@@ -181,6 +223,13 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* cpu1_l1 */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* emu_44xx_pwrdm: Emulation power domain */
@@ -218,6 +267,13 @@ static struct powerdomain mpu_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* mpu_l2 */
 		[2] = PWRSTS_ON,	/* mpu_ram */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* ivahd_44xx_pwrdm: IVA-HD power domain */
@@ -242,6 +298,13 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 		[3] = PWRSTS_ON,	/* tcm2_mem */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* cam_44xx_pwrdm: Camera subsystem power domain */
@@ -259,6 +322,13 @@ static struct powerdomain cam_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* cam_mem */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
@@ -277,6 +347,13 @@ static struct powerdomain l3init_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* l3init_bank1 */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* l4per_44xx_pwrdm: Target peripherals power domain */
@@ -297,6 +374,13 @@ static struct powerdomain l4per_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* retained_bank */
 	},
 	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
@@ -353,3 +437,4 @@ void __init omap44xx_powerdomains_init(void)
 {
 	pwrdm_init(powerdomains_omap44xx, &omap4_pwrdm_operations);
 }
+
-- 
1.7.4.1
