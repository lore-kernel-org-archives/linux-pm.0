From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 01/11] ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
Date: Mon, 14 Apr 2014 17:10:04 +0200
Message-ID: <1397488214-20685-2-git-send-email-gregory.clement@free-electrons.com>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Russell King <linux@arm.linux.org.uk>, Tawfik Bayouk <tawfik@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

PJ4B needs extra instructions for suspend and resume, so instead of
using the armv7 version, this commit introduces specific versions for
PJ4B.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mm/proc-v7.S | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 195731d3813b..b74ea60891d5 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -169,9 +169,31 @@ ENDPROC(cpu_pj4b_do_idle)
 	globl_equ	cpu_pj4b_do_idle,  	cpu_v7_do_idle
 #endif
 	globl_equ	cpu_pj4b_dcache_clean_area,	cpu_v7_dcache_clean_area
-	globl_equ	cpu_pj4b_do_suspend,	cpu_v7_do_suspend
-	globl_equ	cpu_pj4b_do_resume,	cpu_v7_do_resume
-	globl_equ	cpu_pj4b_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_ARM_CPU_SUSPEND
+ENTRY(cpu_pj4b_do_suspend)
+	stmfd	sp!, {r6 - r10}
+	mrc	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
+	mrc	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
+	mrc	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
+	mrc	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
+	mrc	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
+	stmia	r0!, {r6 - r10}
+	ldmfd	sp!, {r6 - r10}
+	b cpu_v7_do_suspend
+ENDPROC(cpu_pj4b_do_suspend)
+
+ENTRY(cpu_pj4b_do_resume)
+	ldmia	r0!, {r6 - r10}
+	mcr	p15, 1, r6, c15, c1, 0  @ save CP15 - extra features
+	mcr	p15, 1, r7, c15, c2, 0	@ save CP15 - Aux Func Modes Ctrl 0
+	mcr	p15, 1, r8, c15, c1, 2	@ save CP15 - Aux Debug Modes Ctrl 2
+	mcr	p15, 1, r9, c15, c1, 1  @ save CP15 - Aux Debug Modes Ctrl 1
+	mcr	p15, 0, r10, c9, c14, 0  @ save CP15 - PMC
+	b cpu_v7_do_resume
+ENDPROC(cpu_pj4b_do_resume)
+#endif
+.globl	cpu_pj4b_suspend_size
+.equ	cpu_pj4b_suspend_size, 4 * 14
 
 #endif
 
-- 
1.8.1.2
