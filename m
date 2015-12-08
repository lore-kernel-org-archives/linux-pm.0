From: James Morse <james.morse@arm.com>
Subject: [PATCH] fixup! arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Tue,  8 Dec 2015 11:48:20 +0000
Message-ID: <1449575300-9612-1-git-send-email-james.morse@arm.com>
References: <1448559168-8363-11-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42973 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbLHLt0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 06:49:26 -0500
In-Reply-To: <1448559168-8363-11-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

additional includes should go after the #ifdef guards

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/suspend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e75ad7aa268c..6682178783eb 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -1,8 +1,8 @@
-#include <linux/suspend.h>
-
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
+#include <linux/suspend.h>
+
 #define NR_CTX_REGS 10
 #define NR_CALLEE_SAVED_REGS 12
 
-- 
2.6.2

