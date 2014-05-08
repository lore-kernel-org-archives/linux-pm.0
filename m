From: dirk.brandewie@gmail.com
Subject: [PATCH 3/5] intel_pstate: Fix fixed point rounding macro
Date: Thu,  8 May 2014 12:57:25 -0700
Message-ID: <1399579047-5792-4-git-send-email-dirk.j.brandewie@intel.com>
References: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Change the FP_ROUNDUP macro to add 0.5 in fixed point representation
instead of 1.0

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eab8ccf..bb20881 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -43,7 +43,7 @@
 #define FRAC_BITS 6
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
-#define FP_ROUNDUP(X) ((X) += 1 << FRAC_BITS)
+#define FP_ROUNDUP(X) ((X) += 1 << (FRAC_BITS-1))
 
 static inline int32_t mul_fp(int32_t x, int32_t y)
 {
-- 
1.9.0
