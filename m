From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] tools/power turbostat: IVB Xeon: fix --debug regression
Date: Sat, 26 Sep 2015 01:05:13 -0400
Message-ID: <756357b8e4b072fd5ee86421f794e071a348802b.1443243089.git.len.brown@intel.com>
References: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443243915-6696-1-git-send-email-lenb@kernel.org>
In-Reply-To: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
References: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Staring in Linux-4.3-rc1,
commit 6fb3143b561c ("tools/power turbostat: dump CONFIG_TDP")
touches MSR 0x648, which is not supported on IVB-Xeon.
This results in "turbostat --debug" exiting on those systems:

turbostat: /dev/cpu/2/msr offset 0x648 read failed: Input/output error

Remove IVB-Xeon from the list of machines supporting with that MSR.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9655cb4..e05d3033 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1926,8 +1926,6 @@ int has_config_tdp(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case 0x3A:	/* IVB */
-	case 0x3E:	/* IVB Xeon */
-
 	case 0x3C:	/* HSW */
 	case 0x3F:	/* HSX */
 	case 0x45:	/* HSW */
-- 
2.6.0.rc1
