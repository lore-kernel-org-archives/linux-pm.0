From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/7] tools/power turbostat: decode BXT TSC frequency via CPUID
Date: Wed,  6 Apr 2016 17:15:57 -0400
Message-ID: <5f95473a060f563a684519f5d17ec6c86f5b9886.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36561 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:44 -0400
Received: by mail-yw0-f194.google.com with SMTP id p65so8580944ywb.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:44 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Hard-code BXT ART to 19200MHz, so turbostat --debug
can fully enumerate TSC:

CPUID(0x15): eax_crystal: 3 ebx_tsc: 186 ecx_crystal_hz: 0
TSC: 1190 MHz (19200000 Hz * 186 / 3 / 1000000)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1561ac5..751bbcb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3278,7 +3278,10 @@ void process_cpuid()
 				switch(model) {
 				case 0x4E:	/* SKL */
 				case 0x5E:	/* SKL */
-					crystal_hz = 24000000;	/* 24 MHz */
+					crystal_hz = 24000000;	/* 24.0 MHz */
+					break;
+				case 0x5C:	/* BXT */
+					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
 					crystal_hz = 0;
-- 
2.8.0.rc4.16.g56331f8

