From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/7] tools/power turbostat: SGX state should print only if --debug
Date: Wed,  6 Apr 2016 17:15:54 -0400
Message-ID: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35727 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:41 -0400
Received: by mail-yw0-f193.google.com with SMTP id k197so4285058ywe.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:40 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The CPUID.SGX bit was printed, even if --debug was used

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 20a257a..f7616f3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3187,7 +3187,7 @@ void process_cpuid()
 	if (debug)
 		decode_misc_enable_msr();
 
-	if (max_level >= 0x7) {
+	if (max_level >= 0x7 && debug) {
 		int has_sgx;
 
 		ecx = 0;
-- 
2.8.0.rc4.16.g56331f8

