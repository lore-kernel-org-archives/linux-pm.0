From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on architectures that require it
Date: Tue, 27 Oct 2015 17:29:19 +0000
Message-ID: <1445966960-31724-11-git-send-email-james.morse@arm.com>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57937 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555AbbJ0RbB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Oct 2015 13:31:01 -0400
In-Reply-To: <1445966960-31724-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>

Some architectures require code written to memory as if it were data to be
'cleaned' from any data caches so that the processor can fetch them as new
instructions.

During resume from hibernate, the snapshot code copies some pages directly,
meaning these architectures do not get a chance to perform their cache
maintenance. Add a call to flush_icache_range(), which is provided by
architectures that require it, to perform the maintenance.

This mirrors the kernel's behaviour when loading kernel modules and when
mapping executable pages to user space.

Signed-off-by: James Morse <james.morse@arm.com>
---
 kernel/power/snapshot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4e1e2f..139fc449ad75 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -31,6 +31,7 @@
 #include <linux/ktime.h>
 
 #include <asm/uaccess.h>
+#include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
 static inline void do_copy_page(long *dst, long *src)
 {
 	int n;
+	unsigned long __maybe_unused start = (unsigned long)dst;
 
 	for (n = PAGE_SIZE / sizeof(long); n; n--)
 		*dst++ = *src++;
+
+	flush_icache_range(start, start+PAGE_SIZE);
 }
 
 
-- 
2.1.4

