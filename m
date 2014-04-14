From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 06/11] ARM: mvebu: Low level function to disable HW
 coherency support
Date: Mon, 14 Apr 2014 17:10:09 +0200
Message-ID: <1397488214-20685-7-git-send-email-gregory.clement@free-electrons.com>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

When going to deep idle we need to disable the SoC snooping (aka
hardware coherency support). Playing with the coherency fabric
requires to use assembly code to be sure that the compiler doesn't
reorder the instructions nor do wrong optimization.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index f2e2e8677c4b..6828f9f157b0 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -102,6 +102,26 @@ ENTRY(ll_enable_coherency)
 	mov	pc, lr
 ENDPROC(ll_enable_coherency)
 
+ENTRY(ll_disable_coherency)
+	/*
+	 * r0 being untouched in ll_get_coherency_base and
+	 * ll_get_cpuid, we can use it to save lr modifing it with the
+	 * following bl
+	 */
+	mov r0, lr
+	bl	ll_get_coherency_base
+	bl	ll_get_cpuid
+	mov lr, r0
+	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
+1:
+	ldrex	r2, [r0]
+	bic	r2, r2, r3
+	strex	r1, r2, [r0]
+	cmp	r1, #0
+	bne	1b
+	dsb
+	mov	pc, lr
+ENDPROC(ll_disable_coherency)
 
 	.align 2
 3:
-- 
1.8.1.2
