Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF5318EE6
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467226; cv=none; b=hdGr4KYAsIYg7r6yukzogOO4oRZYSpUGOQThqmhHJynsPy3DarHYVMcASY4LCRQRG+G4p/PLneb7kHN0wpQ7F7l+FqFF1xtwV3n0mHf1VEttykNoZQWCs6NzAh3auBVj+i2zcXBVPo2dqJdBK5pmkEGGhs6K6FpOpprLhSeqhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467226; c=relaxed/simple;
	bh=zszaOxevbCZvQXNJatfYpEcNiEPZQLFiTIZjL+q2sQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/a0noQua++9ISMtpwegmfLNZ/fhvgFoJQhNn9eI4QxffokEYFOAsaHTloMT+i24wNRfiqiORGyz4QjIXp6Vyf10fYjlStQ0/PrBKCS1I8hib9th0cIwoqVd8YPAuz/PYzHyMcNkf5afgb8jFb8f1JQXaq75zxsE8iOC9TEtdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhgFii16; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhgFii16"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so15013455e9.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776467223; x=1777072023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vu1kRSyuGOU++w9iy+F9ZQAZzQ1+PneeABTsBbmkrZ4=;
        b=KhgFii16H6rAfvoKGXa969I/UmFGnfOGwz2cRs74xEVPaC30MKBksFgPr4TTP2IVRm
         i92UwyKWibOSqgcqOodxGI3TLXj4Fl8rbIQTt9OmYSi1rqwGGOs+u2ZcoIr0HChY+miC
         jNoYEy3R+owtYJLzZQEwJkXFYv/lSupwygS3FnG1jZ5xQW1w8GQNb1it3uf/fWn7QpS4
         Z4kZNEIWdYlUEiGolC1W7ERgl3IQ6I+CavuU4g8oVa7Czd4yDADfboYNfvzNJwJ/nUIb
         0+5UY0dGY+sGZDb0J3TYFCOKBjbEJjUMlfp88XFgkR6HQWecTdxrCLSLwTbxan87ZIjR
         lWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467223; x=1777072023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu1kRSyuGOU++w9iy+F9ZQAZzQ1+PneeABTsBbmkrZ4=;
        b=lCabqAQoDYSS4wkz8X5WoD8hqz+8Y0H2HTDuGjckaRhMGtW4w1XpRFWXUKyBxXI7Ck
         tDN3PIIe/tXenkd2V9urC/beDsRWGSAcD2RCoPBQ2tVmuAUfscuWByrQ+7KUlYsS3Nbw
         yJT8+dL+J1myuNyObLD1Uu4tfeyXSusFRLnANhY45qcHACgWkn5TOFm7za8+xKeZ4i+S
         s0vg73YRRmaRry34/4G2DB/XHclX3JnR5jomy6sAwXBk0eZv0ttjLSoNzLgWlXqifX0S
         QH3/pyxOAPPB5cpKIePK92EjFhVrWELlsb1bky827fPosxl3ujHic3ieWv5qQcdIeuO3
         JWDg==
X-Forwarded-Encrypted: i=1; AFNElJ/pKqJChQVc1JM2gZkGLOjnCg4msQCF7m5Dd0PeVfWskcCjMKtTQ9nTp5l2fnDXBU9FA2CIxWK21A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqdrGEsKeWNs8/4snNi6Kx/EF1cK50bNSVBrUyZncXlxVQ0ez
	B1MxwgNWNFOEqDd1kyXP9VdOpIHUXUuHkeXJ1BED98ooZMN+nBpwyZrejDIuklSR20RZkw==
X-Gm-Gg: AeBDiesY5x6Dl+EJEdvY+rmplmlfWfs0uAXnk32VhNWW4bPYrmSv1o2xr/iyMTM3ri5
	6P7KwSoimdk++MY3cqyL4HlqtNpAr392M1W+bIRw5QKshNbCtg7ZmA79CAw9NDkZPBiVLErvOQO
	LSFquf8RmZNVqt7iAjiATyEKpT7hUIl6Z+BgRWW9XZINIbne3yaWD18u7tc1NQdqmbx3LiN3xMc
	dpRR1gWCXV29QnDcW8ApNmPu3d6pWP20bjEISH6NtBb4UdhnaOazH0Lk8FSFlvzeryx+GVQd5RH
	0FAsmI3SgNMn9uNI2H0RFl8ahDNzqSPxMcrNfDVC8C8hgED9XCe5Ufgb+y45L33Jx+PwbzdTfQF
	c7Cg0nxxcjOGuhqK9Eq+dn2dy1amFtuAtSNFRVyo7/t9OahKtZdwThZhU2+J+BiQYspnZNvyF6D
	rTSgUQ3i5GoNkZ6j0foVuBRvJPtF2kEQFWbozP0WNk7rzRWbkeEDYJ9su/ZYVhfXGSLg==
X-Received: by 2002:a05:6000:230b:b0:43d:773d:7908 with SMTP id ffacd0b85a97d-43fe3e13d14mr7567622f8f.32.1776467223000;
        Fri, 17 Apr 2026 16:07:03 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm8248689f8f.37.2026.04.17.16.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:07:02 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: gautham.shenoy@amd.com,
	superm1@kernel.org,
	Perry.Yuan@amd.com,
	skhan@linuxfoundation.org,
	ray.huang@amd.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] cpufreq: clean up dead dependencies on X86 in Kconfig
Date: Sat, 18 Apr 2026 00:06:52 +0100
Message-ID: <20260417230652.305414-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig in the parent directory already has an 'if X86'
condition wrapping the inclusion of this file, meaning that each of the
individual 'depends on' statements in this file is a duplicate dependency
(dead code).

I propose leaving the outer 'if X86...endif' and removing
the individual 'depends on X86' statement from each option.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/cpufreq/Kconfig.x86 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 027e6ea2e038..9afceb1143df 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -5,7 +5,6 @@
 
 config X86_INTEL_PSTATE
 	bool "Intel P state control"
-	depends on X86
 	select ACPI_PROCESSOR if ACPI
 	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
 	select CPU_FREQ_GOV_PERFORMANCE
@@ -36,7 +35,7 @@ config X86_PCC_CPUFREQ
 
 config X86_AMD_PSTATE
 	bool "AMD Processor P-State driver"
-	depends on X86 && ACPI
+	depends on ACPI
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
@@ -84,7 +83,7 @@ config X86_AMD_PSTATE_DYNAMIC_EPP
 
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
-	depends on X86 && ACPI_PROCESSOR
+	depends on ACPI_PROCESSOR
 	depends on X86_AMD_PSTATE
 	default n
 	help
-- 
2.53.0

