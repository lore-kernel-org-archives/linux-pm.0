From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 03/10] arm64: Add new hcall HVC_CALL_FUNC
Date: Thu, 26 Nov 2015 17:32:41 +0000
Message-ID: <1448559168-8363-4-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46246 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbbKZReA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:34:00 -0500
In-Reply-To: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

From: Geoff Levand <geoff@infradead.org>

Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
During CPU reset the CPU must be brought to the exception level it had on
entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
needed for this exception level switch.

To allow the HVC_CALL_FUNC exception vector to work without a stack, which is
needed to support an hcall at CPU reset, this implementation uses register x18
to store the link register across the caller provided function.  This dictates
that the caller provided function must preserve the contents of register x18.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: James Morse <james.morse@arm.com>

---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 arch/arm64/kernel/hyp-stub.S  | 13 ++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index eb10368c329e..30700961f28c 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -45,6 +45,19 @@
 
 #define HVC_SET_VECTORS 2
 
+/*
+ * HVC_CALL_FUNC - Execute a function at EL2.
+ *
+ * @x0: Physical address of the function to be executed.
+ * @x1: Passed as the first argument to the function.
+ * @x2: Passed as the second argument to the function.
+ * @x3: Passed as the third argument to the function.
+ *
+ * The called function must preserve the contents of register x18.
+ */
+
+#define HVC_CALL_FUNC 3
+
 #define BOOT_CPU_MODE_EL1	(0xe11)
 #define BOOT_CPU_MODE_EL2	(0xe12)
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 017ab519aaf1..e8febe90c036 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -67,8 +67,19 @@ el1_sync:
 	b	2f
 
 1:	cmp	x18, #HVC_SET_VECTORS
-	b.ne	2f
+	b.ne	1f
 	msr	vbar_el2, x0
+	b	2f
+
+1:	cmp	x18, #HVC_CALL_FUNC
+	b.ne	2f
+	mov	x18, lr
+	mov	lr, x0
+	mov	x0, x1
+	mov	x1, x2
+	mov	x2, x3
+	blr	lr
+	mov	lr, x18
 
 2:	eret
 ENDPROC(el1_sync)
-- 
2.6.2

