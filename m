From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/50] tools turbostat: recognize and run properly on IVB
Date: Tue, 17 Jan 2012 07:20:53 -0500
Message-ID: <553575f1ae048aa44682b46b3c51929a0b3ad337.1326802228.git.len.brown@intel.com>
References: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1326802902-21583-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8b2d37b..4b05b44 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -809,6 +809,8 @@ int has_nehalem_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case 0x2C:	/* Westmere EP - Gulftown */
 	case 0x2A:	/* SNB */
 	case 0x2D:	/* SNB Xeon */
+	case 0x3A:	/* IVB */
+	case 0x3D:	/* IVB Xeon */
 		return 1;
 	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
 	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
-- 
1.7.9.rc1

