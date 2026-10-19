Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422187;
	b=MzMZgt/b7FdUepFae74X5hEkRNHr4JfzRyKxsmymyaP+mPQM6HSdfVFFzKjhTx/5oUSB
	 kEnI32TNdZ+n7WOdEPAzL0yyyVrj+BGJoQW7xIpW8V3h+ThAcshbc9cIaimfLkw7q1lto
	 k8I/XnynYKhLB7DZ4yCvlMcWSYTkS7KjyfyfDlfRL/UNPg/cnGAfuWeMCS6ioht+VWSCe
	 Tv339t6i4kO/xGIsJaqX6CVpHLN8n1DM6WQXSCCn5kAv9JslK23QToG7cAwp9hS8z4ECo
	 WIt8Akx24nNM3Xv4JuN/8Jtlvkar7XzCeFrI67OT21fijLqSX/IWtQa6V/fMwblaBEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422187;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=jvM4A5YXiBPXAabIRMTdMXOmDGWVTcobd/NhQ8DKoaE=;
	b=Yv+2RWav1r88CzCRYma1DwUE57qE7j9UUDVuldIya2qoIaJy9yyaYWoMLmcSeBwPwjAA
	 SNgeXaBKY/g+C0D6s3cnEdMLWk51VfWmz3mC5P2BFSq64KSm2A1hiFwaflKxzrWUK1yyb
	 bpQJVhzc73ualjNsfaGBU3Rh5PyBC+oznjgytVXdgE+rNaRlIigjYKbo9V6LEJzM/YIkW
	 um23mfi+unac56SilTfuqCWJJmCHlgMArlLe8It7l9m/2XXmwGoPaTHYD6LZQH8SBT/ZF
	 hQvuJm9ittg3D6jevluC/eakhIVI7Z1y+8rsGxnbnrCLMm9Kunbg9Ec64Y0wdYIS1gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILqrdwTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55829607D357
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILqrdwTD
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1716513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422187; cv=none; b=g9ZW9edtjzgTxeZPcYu0m28Nbvuude5FkQWz2UuME/zIqDHXAVAAmQxAiJp1i8YnAc+eq+vA3hotlANj91aSUkwEUI3oWzAA7Orx8bd8bsC7VDsNT3PgTA4lFmAgge482bn8bOiR7EixRJZFn30mWO8jjbjuPC/j4Mx7pzbDRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422187; c=relaxed/simple;
	bh=ZG0bnqHHB9Gg6LLkimATobkXLlM9opage0Q6cR4DPW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrn615aO4xLAyEFgQt+Dbkd+eLtaaespeDDszA93TnYkFfhxQ+9RW66QuieKST3oPmsgM24BbeZOas1CyPppzZYh0hxmVswq7IEFXQCmjFYk80b136ANF7EWS7j80omUvtDQ15kCaYGPPywIYZ5Wok0UXVQAiiI5GYjNYGYE7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILqrdwTD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE2B1F000C5;
	Mon, 19 Oct 2026 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422186;
	bh=jvM4A5YXiBPXAabIRMTdMXOmDGWVTcobd/NhQ8DKoaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=ILqrdwTDkTOk1eYcKRFWxZaWxYmkhGD8VO3vk4xAOoZXpGQ0hJqYleYE6qFRhCotI
	 r32QD3TtC1E/0GabFkDmOYbiaT9Gj4aE6fXctzmKD9XbJkoutzxLGq5Q/0tCUHoqjI
	 2MVff3vrXw9RkjJBJ3KLdIGJjz2FQQ7/ejJz3oywZutkwo3sD4HJ6UEESHTucptZoD
	 uFgtGAslWC81GZOW7n4uC6C2k16N0LFhM0UiUptmwN1lU51Eb14Fbu4nu416gxt7An
	 HuXWsZr49bE1EkEES6up+7yjeHKaz3SyTy42T9gQnITwII00+rF5LZvDFZMBXhi4D0
	 qnz3dmENwqqGg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/23] tools/power turbostat: Dump RDT CPUID.7 Support
Date: Mon, 19 Oct 2026 10:38:47 -0400
Message-ID: <890265c019317ce56219013d41cb73d4e664d623.1792420722.git.len.brown@intel.com>
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

Show both Symmetric and Asymmetric RDT bits.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 31 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cacdf4c9c5d7..02d566f0de1a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8327,9 +8327,6 @@ void decode_feature_control_msr(void)
 	if (no_msr)
 		return;
 
-	if (quiet)
-		return;
-
 	get_msr(master_cpu, MSR_IA32_FEAT_CTL, &msr);
 	fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
 		master_cpu, msr, msr & FEAT_CTL_LOCKED ? "" : "UN-", msr & (1 << 18) ? "SGX" : "");
@@ -9200,21 +9197,31 @@ void process_cpuid()
 		decode_misc_enable_msr();
 
 	if (max_level >= 0x7) {
-		int has_sgx;
+		eax = ebx = ecx = edx = 0;
+		__cpuid_count(0x7, 0, eax, ebx, ecx, edx);
 
-		ecx = 0;
+		is_hybrid = !!(edx & (1 << 15));
 
-		__cpuid_count(0x7, 0, eax, ebx, ecx, edx);
+		if (!quiet) {
+			int has_sgx, has_rdt_m, has_rdt_a, has_ardt_m, has_ardt_a;
 
-		has_sgx = ebx & (1 << 2);
+			has_sgx = ebx & (1 << 2);
+			has_rdt_m = ebx & (1 << 12);
+			has_rdt_a = ebx & (1 << 15);
 
-		is_hybrid = !!(edx & (1 << 15));
+			eax = ebx = ecx = edx = 0;
+			__cpuid_count(0x7, 1, eax, ebx, ecx, edx);
 
-		if (!quiet)
-			fprintf(outf, "CPUID(7): %sSGX %sHybrid\n", has_sgx ? "" : "No-", is_hybrid ? "" : "No-");
+			has_ardt_m = ecx & (1 << 0);
+			has_ardt_a = ecx & (1 << 1);
 
-		if (has_sgx)
-			decode_feature_control_msr();
+			fprintf(outf, "CPUID(7): %sSGX %sRDT_M %sRDT_A %sARDT_M %sARDT_A %sHybrid\n",
+				has_sgx ? "" : "No-", has_rdt_m ? "" : "No-", has_rdt_a ? "" : "No-", has_ardt_m ? "" : "No-", has_ardt_a ? "" : "No-",
+				is_hybrid ? "" : "No-");
+
+			if (has_sgx)
+				decode_feature_control_msr();
+		}
 	}
 
 	if (max_level >= 0x15) {
-- 
2.45.2

