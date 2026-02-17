Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3E285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355272; cv=none; b=lJhVwWtpRz6VzpRw1WGRUaweLtqdCBySkVcoL//xQ/wLKvp2mA14HA0pGdoz3P9BXHKCrMyH1IpSLXHvrXgpJnnjajnWijF0Dre1jryPkuAMJIuL0vKm2IyRByx3jRaHBZ9f9ytCwf5MEd+WVS42O9c39DIKMDbb9l7hTuSfZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355272; c=relaxed/simple;
	bh=5yGsXDDWOGx8WRkHm0dgQnG2dr1z50rOvAnWGgvnVjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PttaGAUboB7+3dpv5OvBshdMq+RrPvydUSw8I7V6MVTjHFq4MIEXo+R2826R8871HkpWJ6P0j8Cml72GaKkbSkiYGpB7vkdaqGrokZDeYOWfSprX05qiWvfO3LIglDzoyhR+25wYPymy27L2w/H8b6Se7nhfQTGBCYOvvpzX4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A26zkRp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A26zkRp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C11AC4CEF7;
	Tue, 17 Feb 2026 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355272;
	bh=5yGsXDDWOGx8WRkHm0dgQnG2dr1z50rOvAnWGgvnVjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=A26zkRp1Oduizovo1QzZatyOJZs8D/DKTi4/n+zT5Wi8Vcxd3WAjABXNpJR4jVJV2
	 fdbUzcu18NM4niwtjmm4z50nyAvOsN+N+djSl+TCSIaizDcHBWfNqitNrVrr+uEOTD
	 /6EGVuw3aHtXOYJfegu0/3VOlaYkVmHw3SJVKPKIur1ZgvJslN+wdWlW9oDDZ03xZ/
	 XXbGLmD9mldFNiB+h1eD0h17oDZoeLyaeK+B7nEEzl7re71/svHplApKfMeC/zBX4a
	 IW2A09PKN8Zzccbl4g+08znMaitMgzAZq+elKU6vc+UKYMVk2YiOyVNSncIjlSK/c4
	 GejeiPMKcLhxA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/23] tools/power turbostat: Dump CPUID.1.ECX[31] (Hypervisor)
Date: Tue, 17 Feb 2026 13:03:54 -0600
Message-ID: <00b9e2a7fa671e960f8d708b06fb6b4b87ffec15.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Both Intel and AMD use CPUID.1.ECX[31] to distinguish
between hypervisor and real hardware.
Indicate "HV" or "No-HV" accordingly.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a209c5d87ff7..0ef36f0330a9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -498,6 +498,7 @@ unsigned int list_header_only;
 unsigned int dump_only;
 unsigned int force_load;
 unsigned int cpuid_has_aperf_mperf;
+unsigned int cpuid_has_hv;
 unsigned int has_aperf_access;
 unsigned int has_epb;
 unsigned int has_turbo;
@@ -8803,6 +8804,7 @@ void process_cpuid()
 		model += ((fms >> 16) & 0xf) << 4;
 	ecx_flags = ecx;
 	edx_flags = edx;
+	cpuid_has_hv = ecx_flags & (1 << 31);
 
 	if (!no_msr) {
 		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
@@ -8826,12 +8828,13 @@ void process_cpuid()
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-		fprintf(outf, "CPUID(1): %sSSE3 %sMONITOR %sSMX %sEIST %sTM2 %sTSC %sMSR %sACPI-TM %sHT %sTM\n",
+		fprintf(outf, "CPUID(1): %sSSE3 %sMONITOR %sSMX %sEIST %sTM2 %sHV %sTSC %sMSR %sACPI-TM %sHT %sTM\n",
 			ecx_flags & (1 << 0) ? "" : "No-",
 			ecx_flags & (1 << 3) ? "" : "No-",
 			ecx_flags & (1 << 6) ? "" : "No-",
 			ecx_flags & (1 << 7) ? "" : "No-",
 			ecx_flags & (1 << 8) ? "" : "No-",
+			cpuid_has_hv ? "" : "No-",
 			edx_flags & (1 << 4) ? "" : "No-",
 			edx_flags & (1 << 5) ? "" : "No-",
 			edx_flags & (1 << 22) ? "" : "No-", edx_flags & (1 << 28) ? "" : "No-", edx_flags & (1 << 29) ? "" : "No-");
@@ -10145,7 +10148,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.12.02 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.12.05 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2

