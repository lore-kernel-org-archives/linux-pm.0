From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] x86: remove duplicate turbo ratio limit MSRs
Date: Wed,  6 Jul 2016 16:07:57 -0700
Message-ID: <1467846477-13659-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Remove MSR_NHM_TURBO_RATIO_LIMIT and MSR_IVT_TURBO_RATIO_LIMIT as
they are duplicate.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 5a73a9c..56f4c66 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -64,8 +64,6 @@
 
 #define MSR_OFFCORE_RSP_0		0x000001a6
 #define MSR_OFFCORE_RSP_1		0x000001a7
-#define MSR_NHM_TURBO_RATIO_LIMIT	0x000001ad
-#define MSR_IVT_TURBO_RATIO_LIMIT	0x000001ae
 #define MSR_TURBO_RATIO_LIMIT		0x000001ad
 #define MSR_TURBO_RATIO_LIMIT1		0x000001ae
 #define MSR_TURBO_RATIO_LIMIT2		0x000001af
-- 
2.5.5
