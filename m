Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC23BED43
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775827722; cv=none; b=kvkPdGvBARFgpiiDzQVXBkbpvGesZOiSptK5eLsNGCdaIKMzU/eGL7EB548vrrnjnEimKCv6wPfCRd8DV3IRztoLW1cU4ySHUqpewLlE0GAqPqJW9iG3hlmwBTCaF0UMENGN53C3S2jL+t4Rr0cupXdUpJW02nNz0RlJbNAeuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775827722; c=relaxed/simple;
	bh=+FSvMlXCsHDQipnZyJaEgAi1gP3AgzcNgncDkccgCOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/ca/TbzRD4ckfeYY/R8qePqLjeNun9XFhnRz3hVTBNbaEneuaSilOnjQHajZt4w6k4AjVPWnzxdJd07lIbMVAmCpt8EvN5F9/aJ83W286G1sTNUdEo1I5o34GnRr9puMnlfCblVNUFY+AiMYa7epQSat3lXnI/2ux1QdtCCHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO49Vwv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO49Vwv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B939CC19421;
	Fri, 10 Apr 2026 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775827722;
	bh=+FSvMlXCsHDQipnZyJaEgAi1gP3AgzcNgncDkccgCOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=qO49Vwv6IyLi4hWy3PLkvgNMCnzutkBfrlkxRB/OenZZrfyQjVKQ2UBEPG32WohWp
	 B7L3z9U2tyE3weUxGnxEa+rpykn4TGOOkhxvUGs9DSF+TgPwd8i1L7SJfbwM63EIhn
	 Da9G+aCvJaXcVZRi8QSU1c77BPfYDH1UGWbk2o4YLNuVVBMntUxf6oPR6xIbqGLUbg
	 j7L/LbTNMLn1WMD60igEY8F+wk6qVA5QVSS/rkGq4O2bl2hv3Sv+CrFaz21KxT43IR
	 IAq3hKDyhmeY4Z4DQXzfi6nXLzBsjKgyOLJpQNuFNruthhnJ5BwgaP9a1wA9zVsZNX
	 uHYJ4thLgY+2A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Serhii Pievniev <spevnev16@gmail.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 4/9] tools/power/turbostat: Fix microcode patch level output for AMD/Hygon
Date: Fri, 10 Apr 2026 09:25:09 -0400
Message-ID: <a444083286434ec1fd127c5da11a3091e6013008.1775827309.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
References: <57d2371d52be1d574b33382bfbf8052485b99d8b.1775827309.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Serhii Pievniev <spevnev16@gmail.com>

turbostat always used the same logic to read the microcode patch level,
which is correct for Intel but not for AMD/Hygon.
While Intel stores the patch level in the upper 32 bits of MSR, AMD
stores it in the lower 32 bits, which causes turbostat to report the
microcode version as 0x0 on AMD/Hygon.

Fix by shifting right by 32 for non-AMD/Hygon, preserving the existing
behavior for Intel and unknown vendors.

Fixes: 3e4048466c39 ("tools/power turbostat: Add --no-msr option")
Signed-off-by: Serhii Pievniev <spevnev16@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 14021a6ed717..b985bce69142 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9121,10 +9121,13 @@ void process_cpuid()
 	cpuid_has_hv = ecx_flags & (1 << 31);
 
 	if (!no_msr) {
-		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
+		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {
 			warnx("get_msr(UCODE)");
-		else
+		} else {
 			ucode_patch_valid = true;
+			if (!authentic_amd && !hygon_genuine)
+				ucode_patch >>= 32;
+		}
 	}
 
 	/*
@@ -9138,7 +9141,7 @@ void process_cpuid()
 	if (!quiet) {
 		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)", family, model, stepping, family, model, stepping);
 		if (ucode_patch_valid)
-			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+			fprintf(outf, " microcode 0x%x", (unsigned int)ucode_patch);
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-- 
2.45.2

