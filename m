Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422188;
	b=Vh6rDPJrJLGoiwoVf4UUM818CWrLUojkjoBKSloFe6n/NCRfcfQmo2dwmr6Ei2CTdIFr
	 ug+GXAKQoXTEIG5YCoA+CPoavQLjUJYFbAGucKzDgGWui3H12oV7z1610q6m/stHKfFIF
	 uYk/r08IoIryiFspxqWkoA6vchfi3/w7dMlnMqlt61kapYLctxKmG8HNmeVd2cWUdnhrS
	 jtW5yHz7X8cw+BEthrdZF/GSCTKwfHwBKKWFVqz/vdW+eCFgahM+qt3/geXgRGxf/jl2/
	 oxfqTQyyXGnbE95nP8XkvwKMSxxlzRxgVIVhvGcuHrQKsOoMjM/wRMwCVWiqmry7huw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422188;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=lJJazYxauTjFzwkLJrroB64jb5yBmhd4yj6qamxYq4E=;
	b=y8IKlk3MQgs5PmoT0f8yu3ckKxrAB3MXIy/du1J1T6lAye93kEW5pPhLUh5yS3lb6dNO
	 MRyvOu4XoK7u0IYQQ66GxB0MLiDdCyLmM7pPgwZc8Mj3LucVUUborsjVOzjcC8iDX4dRU
	 df0SjwAHhiXH6BVcMHfGovm+oA9RquF7kpHzfMs0GhRPMVdhoNGCzQdzbBX6GRLTYYuv4
	 ap8Z/0KKDACYjy7sJ3kb+nhVtHh+6rZkOnM2Gn+cCTDYwvzaS+QfzzSWVZHl3+qOZocRI
	 1VyVoBKD2PPFdjAoscMpeET9lHuL7TtOvIxcgldS4E5Dt2dhKkBJ+4YlCuYWOLZTyWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRHhn0hy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9992607D360
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRHhn0hy
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946106513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422188; cv=none; b=LIyqaWwO6kJ5gJUfleA9yFZTBCozw48e6s/d7ZlXcDmUPlHQJSH1m+v5ydhE1K3HpnrtuZAeFSst/SkPQXXqm2el+j+KMvVZkCEpy6dEeyvLOmSTsKo1f9wFqv241Sx43p5fzJrdxA0oOKGzzaJu8oyGJID4lXzC+Scd23Qeg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422188; c=relaxed/simple;
	bh=LlS7e8yyA5iEjENgE+tR4yqKZOxeD9pGMn6SQEgX8dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouvK+WsTKfUYXpKbb0uHoDRZTHyqVApT+BkNc7gdF9zLPp5UbhD2jY0v5IzOb4AQSTvIKKwokv99jke/2xF0XqA+7tO4WaM+YmzIinkp+ZglLuKXMCN+H0hN9KkTuDw48AzPlE2kC+oWWiJi+NIs4OgA1Hu1fdMwB+faf45GHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRHhn0hy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A151F000C4;
	Mon, 19 Oct 2026 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422187;
	bh=lJJazYxauTjFzwkLJrroB64jb5yBmhd4yj6qamxYq4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=lRHhn0hy3+eFlPlgztst9CxeyiJgawMwtT6p3pjSkE7E/pjpRPJgSTL0UhqsWkQzE
	 IGhHooViShyz3OzQieqCROCLwwh1sQq32vKqGgD3uR1g8HylKConLjNFBZygYl3I9U
	 h9rViHQlaQkVJtsKF2SIjVJWnJ54H+OXFTof+/2uy1y/gUZhsRAIayZWxouI+wSF72
	 JdgxxpaAEeVMJW/sbiJtMKA5lMcliAozCK3jZNEe4AT76HlwlYB8wbrxhLm4VMVBJ/
	 +TpSsFyYZ1p0yBfXWtcDYRoj+TC4LQcPJhyvShc3yzY/NH7JEuhD7gjmKaYdLBJf2j
	 7/CG1U6mGndLw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/23] tools/power turbostat: Dump RDT CPUID.0xF,0x10,0x27,0x28 Support
Date: Mon, 19 Oct 2026 10:38:48 -0400
Message-ID: <e48d77302b85bdf80765a6eb3b34c4b5b20f5cb6.1792420722.git.len.brown@intel.com>
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

If Asymmetric RDT is supported, dump it on every CPU.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 02d566f0de1a..d897c48d85aa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9076,6 +9076,65 @@ void dump_cpuid_hypervisor(void)
 	fprintf(outf, "\n");
 }
 
+void dump_rdt_m_leaf(int leaf)
+{
+	unsigned int eax, ebx, ecx, edx;
+	int cpu = sched_getcpu();
+
+	__cpuid_count(leaf, 0, eax, ebx, ecx, edx);
+
+	fprintf(outf, "cpu%d: CPUID(0x%x).0: MAX_RMID:%d %sL3_MON\n", cpu, leaf, ebx, edx & 0x1 ? "" : "No-");
+}
+
+#define RDT_CAT_L3_INDEX 1
+#define RDT_CAT_L2_INDEX 2
+#define RDT_MBA_INDEX 3
+#define RDT_CBA_INDEX 5
+#define RDT_RP_INDEX 6
+
+void dump_rdt_a_leaf(int leaf)
+{
+	unsigned int eax, ebx, ecx, edx;
+	int cpu = sched_getcpu();
+	unsigned int has_cat_l3, has_cat_l2, has_mba, has_cba, has_rp;
+
+	__cpuid_count(leaf, 0, eax, ebx, ecx, edx);
+
+	has_cat_l3 = ebx & (1 << RDT_CAT_L3_INDEX);
+	has_cat_l2 = ebx & (1 << RDT_CAT_L2_INDEX);
+	has_mba = ebx & (1 << RDT_MBA_INDEX);
+	has_cba = ebx & (1 << RDT_CBA_INDEX);
+	has_rp = ebx & (1 << RDT_RP_INDEX);
+
+	fprintf(outf, "cpu%d: CPUID(0x%x).0: %sCATL3, %sCATL2, %sMBA, %sCBA, %sRP\n", cpu, leaf,
+		has_cat_l3 ? "" : "No-", has_cat_l2 ? "" : "No-", has_mba ? "" : "No-", has_cba ? "" : "No-", has_rp ? "" : "No-");
+	if (has_rp) {
+		unsigned int has_rp_thread, has_rp_package;
+
+		__cpuid_count(leaf, RDT_RP_INDEX, eax, ebx, ecx, edx);
+
+		has_rp_thread = eax & (1 << 0);
+		has_rp_package = eax & (1 << 1);
+
+		fprintf(outf, "cpu%d: CPUID(0x%x).%d: %sRP_THREAD, %sRP_PKG\n",
+			cpu, leaf, RDT_RP_INDEX, has_rp_thread ? "" : "No-", has_rp_package ? "" : "No-");
+	}
+}
+
+int dump_ardt_m(int cpu)
+{
+	cpu_migrate(cpu);
+	dump_rdt_m_leaf(0x27);
+	return 0;
+}
+
+int dump_ardt_a(int cpu)
+{
+	cpu_migrate(cpu);
+	dump_rdt_a_leaf(0x28);
+	return 0;
+}
+
 void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -9221,6 +9280,15 @@ void process_cpuid()
 
 			if (has_sgx)
 				decode_feature_control_msr();
+
+			if (has_rdt_m && max_level >= 0xF)
+				dump_rdt_m_leaf(0xF);
+			if (has_rdt_a && max_level >= 0x10)
+				dump_rdt_a_leaf(0x10);
+			if (has_ardt_m && max_level >= 0x27)
+				for_all_proc_cpus(dump_ardt_m);
+			if (has_ardt_a && max_level >= 0x28)
+				for_all_proc_cpus(dump_ardt_a);
 		}
 	}
 
-- 
2.45.2

