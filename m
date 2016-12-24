From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/17] tools/power/turbostat: Add Denverton support
Date: Sat, 24 Dec 2016 15:53:35 -0500
Message-ID: <2c48c990ea330ae8079488fdf1d156620c6f9d0c.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35918 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbcLXU4I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:08 -0500
Received: by mail-qk0-f194.google.com with SMTP id h201so21014863qke.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:08 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Denverton is an Atom based micro server which shares the same
Goldmont architecture as Broxton. The available C-states on
Denverton is a subset of Broxton with only C1, C1e, and C6.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3a80f949e5ba..16ccada7e439 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2204,6 +2204,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case 0x5C:	/* BXT */
+	case 0x5F:	/* DNV */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
 	default:
@@ -3301,6 +3302,7 @@ void process_cpuid()
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case 0x5C:	/* BXT */
+				case 0x5F:	/* DNV */
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
2.11.0.161.g6610af872

