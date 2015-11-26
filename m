From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 08/10] arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
Date: Thu, 26 Nov 2015 17:32:46 +0000
Message-ID: <1448559168-8363-9-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46293 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbbKZReT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:34:19 -0500
In-Reply-To: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

KERNEL_START and KERNEL_END are useful outside head.S, move them to a
header file.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/memory.h | 3 +++
 arch/arm64/kernel/head.S        | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 853953cd1f08..5773a6629f10 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -70,6 +70,9 @@
 
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
 
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7cec62a76f50..c58ede3398db 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -48,9 +48,6 @@
 #error TEXT_OFFSET must be less than 2MB
 #endif
 
-#define KERNEL_START	_text
-#define KERNEL_END	_end
-
 /*
  * Kernel startup entry point.
  * ---------------------------
-- 
2.6.2

