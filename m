From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 08/11] arm64: kernel: Include _AC definition in page.h
Date: Tue, 27 Oct 2015 17:29:17 +0000
Message-ID: <1445966960-31724-9-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57917 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbbJ0Ras (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:30:48 -0400
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
linux/const.h where this is defined. This produces build warnings when only
asm/page.h is included by asm code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/page.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 7d9c7e4a424b..74f67d049a63 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PAGE_H
 #define __ASM_PAGE_H
 
+#include <linux/const.h>
+
 /* PAGE_SHIFT determines the page size */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PAGE_SHIFT		16
-- 
2.1.4

