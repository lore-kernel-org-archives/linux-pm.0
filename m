From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 5/6] bitops: Introduce BIT_ULL
Date: Fri,  4 Oct 2013 09:36:55 -0700
Message-ID: <1380904616-17519-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32822 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab3JDQhI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Oct 2013 12:37:08 -0400
In-Reply-To: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Adding BIT(x) equivalent for unsigned long long type, BIT_ULL(x). Also
added BIT_ULL_MASK and BIT_ULL_WORD.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/bitops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a3b6b82..5a1c8b7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,8 +4,11 @@
 
 #ifdef	__KERNEL__
 #define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
-- 
1.8.3.1

