From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 09/11] arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
Date: Tue, 27 Oct 2015 17:29:18 +0000
Message-ID: <1445966960-31724-10-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57926 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbbJ0Rax (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:30:53 -0400
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

KERNEL_START and KERNEL_END are useful outside head.S, move them to a
header file.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/memory.h | 3 +++
 arch/arm64/kernel/head.S        | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6b4c3ad75a2a..1383491f3db4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -72,6 +72,9 @@
 #error Top of 64-bit user space clashes with start of module space
 #endif
 
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cf4e0bdf6533..537406273f96 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -55,9 +55,6 @@
 #define TABLE_SHIFT	PUD_SHIFT
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Initial memory map attributes.
  */
-- 
2.1.4

