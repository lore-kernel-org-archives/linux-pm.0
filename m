From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] tools/power turbostat: decode MSR_IA32_MISC_ENABLE only on Intel
Date: Sat, 24 Jun 2017 20:13:00 -0700
Message-ID: <f26b151977447be3b86f92c91e1caedc9b5eb8bf.1498359826.git.len.brown@intel.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36361 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFYDNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id v31so5948086qtb.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:11 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
References: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

otherwise, turbostat bails on on AMD Opteron boxes:

turbostat: cpu26: msr offset 0x1a0 read failed: Input/output error

Reported-by: Kamil Kolakowski <kkolakow@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1a3a5b4..33992a9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3943,6 +3943,9 @@ void decode_misc_enable_msr(void)
 {
 	unsigned long long msr;
 
+	if (!genuine_intel)
+		return;
+
 	if (!get_msr(base_cpu, MSR_IA32_MISC_ENABLE, &msr))
 		fprintf(outf, "cpu%d: MSR_IA32_MISC_ENABLE: 0x%08llx (%sTCC %sEIST %sMWAIT %sPREFETCH %sTURBO)\n",
 			base_cpu, msr,
-- 
2.7.4
