From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/3] tools/power/turbostat: add denverton support
Date: Thu, 16 Jun 2016 09:48:21 -0700
Message-ID: <1466095702-5537-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Denverton is an Atom based micro server which shares the same
Goldmont architecture as Broxton. The available C-states on
Denverton is a subset of Broxton with only C1, C1e, and C6.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 26566e6..d219c4f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2218,6 +2218,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case 0x5C:	/* BXT */
+	case 0x5F:	/* DNV */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
 	default:
@@ -3315,6 +3316,7 @@ void process_cpuid()
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case 0x5C:	/* BXT */
+				case 0x5F:	/* DNV */
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
1.9.1
