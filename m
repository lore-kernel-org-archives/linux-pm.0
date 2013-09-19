From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 5/6] bitops: Introduce BIT_ULL
Date: Thu, 19 Sep 2013 09:00:34 -0700
Message-ID: <1379606435-15871-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Adding BIT(x) equivalent for unsigned long long type, BIT_ULL(x).

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a3b6b82..34e9e94 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,6 +4,7 @@
 
 #ifdef	__KERNEL__
 #define BIT(nr)			(1UL << (nr))
+#define BIT_ULL(nr)		(1ULL << (nr))
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BITS_PER_BYTE		8
-- 
1.8.3.1
