Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422189;
	b=ZdfMw4bAYh1RDHcBw/VQukNLtKlLPzrIbbjjlSaLkzqDtaHdfeNQ/a1AYmueQdlb8aQm
	 xk3bR9kQ3h0dbyoygXP/a+QuZ5OJLOumopo+v2s5g4ooUku/LWueGKa4vqUOzuZAGUOCy
	 d3Z0C9LCdLdxpaFyg8OeLtYaEjo+5t9xmPFx1WwsJx5VVBTbSzDJXw24+rDa/PwJAyf/3
	 P47UMo+xjTCidgDdQ69s1251XzYeyZXqIOPdEJCYOHBRlkce6Jiy8yj6+uEnZlGHWkyvy
	 8XQMzrxz2Q2fFDEpZae9t8LLczDrC6L9lrViqYHV849NgflNxpfcnlIudWlA8idAO8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422189;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=tTkONO151232em5VDf3vTzgtyFbTNxi7eJIgeTZmlZk=;
	b=fSp/Jy9VOr+kxiA2975r6Ds0J+bAo4IxuGIpShXK12SZTNa3KOlwmdH8tb8lj2SObr4V
	 ZTp2gzsiH1/252WinPsupWIpnBfnCbn4Ymj44NYOLtUtQQRIe6FCJa4oBF4tVlwRafuAP
	 +Ro9hIQe4Xelws3/fKo4ARGlSxRTDI8V1+dWq8rqxI9YZbZ4AmN1NWHxgkFkhaa94Krvn
	 Q4FO3mskaPiFZXaIBxjRx4oz8RkHN7zlYjNiDhhQW7GsNlQuXSkK04q9j/nkkkr0m6gkY
	 co1Rg/PpA1QCGpqGwa/JJEKYanO6UcNJmkGOcTEc50Q/uuZpYDTBEh04OfrWfmo2aBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqsh99vQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1C607D34F
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqsh99vQ
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5E6513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422189; cv=none; b=m8tBHwfnL754uJuj2/IplKSXyceuFQp3eT0SETvLWRw86/sezZ4FAMpv/Z3Nfy2+hyvnf6tKOdXnBMKjY/2cOwBlaYYND2d41GaTTIACcqd140El5QPvxw/5Zhw/7DTfcET+tto0ymeo7zscbkEsoghC5dEJVjddFEiUTW9T2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422189; c=relaxed/simple;
	bh=qN+G42k60iGhb20MyXT0JaVEL3+9rEEXGElTih5LvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k75rSyJdSkhYlw7ovaBqtJyYNipPPUHZN9q3EecSfkIqg0H2aL7pqybEw87FzzYVBpKOraUgKcd40Hz3Ld8ggJya7wIy5dNF2mJN3BeIUcZKtVVN5OfJq43WuIdUtRsQ0cumbt5GdFT/SDqORzQGXM1qzv/shmfiZ9KKaQar7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqsh99vQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA891F000C5;
	Mon, 19 Oct 2026 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422188;
	bh=tTkONO151232em5VDf3vTzgtyFbTNxi7eJIgeTZmlZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=nqsh99vQdhShBWYYjNwcIn+aUssCPvfLloJSpjdSeULIJDYSllSiX5IFYydPLRe+Y
	 qH5GZqN0ytr4/G/b2paxJHbGsrmPTuSyJuPCcTKBe7Onf989gYTjYgZj084M0v43Yy
	 Dh2LyG6cbWQUkBanZrzRzWfJH86O6YMGrayPrvOD2ai6MSjaNjtent8SIUvdOBpoaS
	 6OzlWgEVo+otA7X8yjJU4wPYMnUhaQ3NGi2XHYvCbDv85Sw62zzcquklrf92LTiKav
	 eMHnJHn2CHCEg8B3gntrlLdpumTZ17DKUqQNEINiWdbDEznteqhOsuJ5V9esSh7Axz
	 JNc7HpfyAh8PQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/23] tools/power turbostat: Dump RP-Enable MSRs
Date: Mon, 19 Oct 2026 10:38:49 -0400
Message-ID: <5aeb1b6edffaa651cd9646d23d088cfa301504fb.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

To reduce verbosity, put the Enable MSRs on the same output line
as the CPUID info that shows they exist.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d897c48d85aa..591c3497efa3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9092,6 +9092,14 @@ void dump_rdt_m_leaf(int leaf)
 #define RDT_CBA_INDEX 5
 #define RDT_RP_INDEX 6
 
+#ifndef MSR_IA32_RESOURCE_PRIORITY
+#define MSR_IA32_RESOURCE_PRIORITY	0xc88
+#endif
+
+#ifndef MSR_IA32_RESOURCE_PRIORITY_PKG
+#define MSR_IA32_RESOURCE_PRIORITY_PKG	0xc89
+#endif
+
 void dump_rdt_a_leaf(int leaf)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -9116,8 +9124,21 @@ void dump_rdt_a_leaf(int leaf)
 		has_rp_thread = eax & (1 << 0);
 		has_rp_package = eax & (1 << 1);
 
-		fprintf(outf, "cpu%d: CPUID(0x%x).%d: %sRP_THREAD, %sRP_PKG\n",
+		fprintf(outf, "cpu%d: CPUID(0x%x).%d: %sRP_THREAD, %sRP_PKG",
 			cpu, leaf, RDT_RP_INDEX, has_rp_thread ? "" : "No-", has_rp_package ? "" : "No-");
+		if (has_rp_thread) {
+			unsigned long long msr;
+
+			get_msr(cpu, MSR_IA32_RESOURCE_PRIORITY, &msr);
+			fprintf(outf, " MSR_RP_THREAD_EN:%llu", msr);
+		}
+		if (has_rp_package) {
+			unsigned long long msr;
+
+			get_msr(cpu, MSR_IA32_RESOURCE_PRIORITY_PKG, &msr);
+			fprintf(outf, " MSR_RP_PKG_EN:%llu", msr);
+		}
+		fprintf(outf, "\n");
 	}
 }
 
-- 
2.45.2

