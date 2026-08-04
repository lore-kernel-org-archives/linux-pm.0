Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FF468C39
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838429; cv=none; b=vAcnce1emeuV1RIcZ1gtSgt+uCvhucQqgcx59tC8+scQYMVi+ZgmwSTHzvaHlPq2BB5zE470nr6aRI1OfXDTavIBED2oJT8ozHsWiiMG7b47ilU02TQXH78VkvpRjlrROTwdXuxAG0FTl7yS9hBo+qCovumvkPJN2UcQhMpotBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838429; c=relaxed/simple;
	bh=2ePzo/pU6lnAZDcwIcH2JFhlz5VEl6ppdYnDOWIsk3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qe7pLuQjfodcoXfQRW9PW9xOmfZeh2+qkZ+tkTJ/Ab2LRTLVDZIO2hQEVmQabeoS/1k3L1RhcEOBrFFHT/+c1nyNkAMKoC6Js1KPsjAWS6R5mi9sBj1XQSxzzdQNNxGdSGpDfczTDqtFgDxNvsjsyWtzc3gDTCTYJPlImAHscfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=f/GJz0pF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="f/GJz0pF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so17093365e9.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838424; x=1786443224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpfJ4Gli2ICc7NrMUOjLeYPoXMbQrKhq74hAZX/FVUs=;
        b=f/GJz0pF3MaAOdU7CqxqkqfMUeqcrniuUYSgvMxvqQU0cq2/kqgFmSKttXtK7/6+J7
         vcQpkk7vuVI/S5klt9hJoJNeI8Mmj4Dw40fjnnKb+f0Oje3154wPfB5DQr/PXjZ/BaPC
         qVm0+2b1fv9DSGrTR0zlU/25guFETpuTxQpIefWqPpluYDpt6GnkJgGF+dDzJB4j52Ld
         zqvyW08VUBfhIzc/I/WzIUAefucHgE77QmyiEXK54AxWfhTPLxJ9VrmkeAnjnJqGoiqu
         bFdBGvJNOy81ijM0hlOhsqWxtXdZdlyNJFzhVt0ToPKjg4XKAiW96zGk0ssrGDdml/PH
         yrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838424; x=1786443224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpfJ4Gli2ICc7NrMUOjLeYPoXMbQrKhq74hAZX/FVUs=;
        b=aFw1/atbvNe24cTKfuU0yQhgw+rt1fwSSthlUDk5jmKep5cXzchEfxoRlP1KTICPCd
         kZ4+mfqHlGkeAXKUcpkghUFzxEKCAxTz7jbRcpYhgESE+ugIk8LqgAQTGJ+seRLRWcsR
         rAkWEKQ8PW0k1xLgzYTORE//SoDBTVLWdPL4X6eWxjfqWHPG2I8ilZHeUSsD0aUcxjWk
         e1Mg/XbIGgYn5LuwnCu24BdtOeueQnONpBMKB7YgebDO8lipDLViFF9brCRQO9Uni9G5
         fdhOwErTwzD+XN7OrI7ub8dTBVltzgUFrTxohjyoFzFqSdoalTMibkY1/L2MIaMLZTo8
         Ns1g==
X-Forwarded-Encrypted: i=1; AHgh+Ro68gXJSYSr9cU6vOARVo3Mrw+BAbFB164EoZ3U88ucr28HuQMZqIDk7qh+RiQ9z1bdA6FK3nFPag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E/Dw3mZ0CUKGQTvGCTbeHWKfr/icSM0JpCAgIKPjHOL3szZl
	7DC/OX+75956pjUSdgJBLHwGgGYahXPgfmGBnZJKEplDfnE2Ws5rgBKYo9Ef/uR5FF6u3AlsU9N
	eE37JhxC9
X-Gm-Gg: AR+sD11PVqFANMOMMOu8mmCLGGndt2DVe6d9M6RAxsyeZ0G5ZkhAOdu07kvPIYDBfBi
	v2ypLkUt026HvYjCgHTEAEAFuZzjFvblL7KuRzA9sv2dKDlTgQtpfDeinvT9LU9PNlmhRSeFn0c
	XMuVEwgYTCTUBq/+txax2x6E1f78P+DUAtXqmVcJryjKZSQNzjZzJMWlLfRStLXQ6Qcp0y3qsod
	lgC1FY0tdhy0KLAg79gOvhs/dlv1mjBDVqowFKyJr+Bp5EdvVLWAJ1VYBq45FdH1mLzO6XYHwbo
	mcJV0SzTaB2P7Uc/Gz4r6JHdMUax3gt+wtzcRdBd65CU/dsHqZpsNr8hFRk/gR3p4mRzqPIXxsu
	uExyWjo76hU1c+KtHq6OtoJlt9WX3leqrq7mQohwFcVwufij7Z4Eb0iinyVaQOoZD/kqtlOc6e2
	Jq9R0zyxPjarNKG5ICImfvNDveeLhHtWw/bJZnCHWpsWNl7zWoaLlVhqX/+LtBNt5HvisjIFdjo
	YKZJprz5JkVAMQJt8ybofxRvXk9suI+
X-Received: by 2002:a05:600c:4688:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4981595be82mr160266135e9.4.1785838424082;
        Tue, 04 Aug 2026 03:13:44 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm138799565e9.1.2026.08.04.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:13:43 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Date: Tue,  4 Aug 2026 11:13:41 +0100
Message-ID: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some AMD systems return from S3 with the boot CPU CPUID leaf 7
override MSR reset. On Byte/Cezanne, CPUID leaf 7 EBX becomes
0x219c9fb9 on CPU0 after S3 even though XTEST still raises #UD.
Userspace can then select RTM-optimised glibc paths and fault after
resume.

The x86 suspend code already has a small MSR save/restore list for
firmware-modified MSRs and restores it after resume microcode has been
loaded. Add MSR_AMD64_CPUID_FN_7 for the AMD families that can modify
this MSR during CPU init so the pre-suspend CPUID mask is restored
before tasks are thawed.

This covers family 17h, 19h, and 1Ah: family 17h has the Cyan Skillfish
RDSEED leaf-7 quirk, family 19h covers the observed Cezanne issue, and
family 1Ah has the Zen5 RDSEED leaf-7 quirk.

Tested on StarBook Mk V (Byte/Cezanne, 26.07 firmware):
- without this restore, dmesg showed "ACPI: PM: Low-level resume complete"
  and "PM: suspend exit"; the post-S3 CPUID probe showed CPU0 leaf 7 EBX
  0x219c9fb9 with hle=1 rtm=1 while XTEST still raised #UD.
- a temporary PM resume hook clearing the same MSR logged
  "CPU0 MSR_AMD64_CPUID_FN_7 0x219c9fb9 -> 0x219c97a9"; the post-S3 probe
  showed hle=0 rtm=0 on all CPUs.
- this patch booted on Byte and registered the MSR save path; dmesg showed
  "x86/pm: AMD family 0x19 CPU detected"; pm_test freezer/devices/platform/
  processors/core passed with the same boot ID.

Tested-by: Sean Rhodes <sean@starlabs.systems>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 arch/x86/power/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 702f30eaf9c4..b85061f4cee4 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -467,9 +467,24 @@ static int msr_save_cpuid_features(const struct x86_cpu_id *c)
 	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
 }
 
+static int msr_save_amd_leaf7_cpuid_features(const struct x86_cpu_id *c)
+{
+	u32 cpuid_msr_id[] = {
+		MSR_AMD64_CPUID_FN_7,
+	};
+
+	pr_info("x86/pm: AMD family %#x CPU detected, saving CPUID leaf 7 MSR across suspend.\n",
+		c->family);
+
+	return msr_build_context(cpuid_msr_id, ARRAY_SIZE(cpuid_msr_id));
+}
+
 static const struct x86_cpu_id msr_save_cpu_table[] = {
 	X86_MATCH_VENDOR_FAM(AMD, 0x15, &msr_save_cpuid_features),
 	X86_MATCH_VENDOR_FAM(AMD, 0x16, &msr_save_cpuid_features),
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &msr_save_amd_leaf7_cpuid_features),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19, &msr_save_amd_leaf7_cpuid_features),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1a, &msr_save_amd_leaf7_cpuid_features),
 	{}
 };
 
