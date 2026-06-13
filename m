Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719D3A6411;
	Sat, 13 Jun 2026 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388436; cv=none; b=d2MNtrt+Z6g7Dc47cZJcbryqGBTbyifteHNgozDMZKj/EkJHk55rpOtIeRyCC5M+MbgGNkv4A7yHuoYpsKgXzSD1wemvnn1WaNznrUIUE9wkY34EDAEig8NXv7imVchubZaWpj+Ov0dcuiQisdJLuDfX4mnmMVfFHrYm0CLIFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388436; c=relaxed/simple;
	bh=tXctir45E9TTexbNRcmHf/Op7hhINEpCT1wTF9KbATI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9h4/q8HbSf8a9YqB4r7uftzQwF6DjljaKlbZJO+wTThBPEGUZp51r2HzysGizFPwkKSrbpxa2F2d5B1C4eF7Jy2MkT+JoDfIe0lBYEX5h7iFPGvbfZrDAobG5aEmCbKpTdU4nRWVSRDcg5No2/ZCDbhfd4dGNkH7IiBsJMAdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0PMd1QU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0PMd1QU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388435; x=1812924435;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tXctir45E9TTexbNRcmHf/Op7hhINEpCT1wTF9KbATI=;
  b=O0PMd1QUJxmRldx582WWLm5HoxgHuZLQM3+qpZ4wYrOuVfUHcNfIwdBL
   sjrNlQ0VXbxvsY3p9eIH0QpM/w1tlHi0SOYoOVrFQn9DbVov2O4YrRgaI
   nxTPlHQQI20BX7sMVdSZ7IGX9qlKOFzObLlP0MHPhyPZml87w0cgCWiCe
   8orhx6FoHl4zb/zaNVMTMttELMDMXItp8hSWYHLvFbiKiVW7Z3tgsRAuC
   h22VloiJqyEZG6g5Vpof56reqb1O2WZSWa60NHK8uwWM7h7CC0DxDZLM6
   4n718bRjX4fbqGz/oyKB7NGBLtPsAq8CUsZGJnaf7HdjCGMMXkZwawgB0
   Q==;
X-CSE-ConnectionGUID: 4l4l+cY0RdqgqVFTHy9r2w==
X-CSE-MsgGUID: r0xm4ewjR3m81Kx3XtMaSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029418"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: KXZ4RKAiRciRdRBep5O/Ew==
X-CSE-MsgGUID: GSv+QseqSCGpQJoI0mL/MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221849"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:10 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:48 -0700
Subject: [PATCH v3 2/6] x86/thermal: Add bit definitions for Intel Directed
 Package Thermal Interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-2-3a26d1e47fc8@linux.intel.com>
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=2437;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=tXctir45E9TTexbNRcmHf/Op7hhINEpCT1wTF9KbATI=;
 b=oPdzia4MZNNNwcY8TeXzp/ZKdIKrsBF4GqcrH2yEk7xQhRHn750LJoHqY7Cm6YBdhAt1bsg0A
 ecLf2dX9IX/DwiPAYIi2YZAdDHwFxcAJPXuyekt2+vAlW3bb5Ro4V+3
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Add CPUID and MSR bit definitions required to support Intel Directed
Package Thermal Interrupt.

A CPU requests directed package-level thermal interrupts by setting bit 25
in IA32_THERM_INTERRUPT. Hardware acknowledges by setting bit 25 in
IA32_PACKAGE_THERM_STATUS, indicating that only CPUs that opted in will
receive the interrupt. If no CPU in the package requests it, delivery
falls back to broadcast.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v3:
 * None

Changes in v2:
 * Added an empty line to denote a hole in the feature definitions. (Boris)
 * Renamed definitions (Boris):
   X86_FEATURE_DIRECTED_PKG_THRM_INTR => X86_FEATURE_DPTI
   THERM_DIRECTED_INTR_ENABLE => THERM_INT_DPTI_ENABLE
   PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK => PACKAGE_THERM_STATUS_DPTI_ACK
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/include/asm/msr-index.h   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1d506e5d6f46..ead68fb9913b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -365,6 +365,8 @@
 #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */
 #define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */
 
+#define X86_FEATURE_DPTI		(14*32+24) /* Intel Directed Package Thermal Interrupt */
+
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
 #define X86_FEATURE_LBRV		(15*32+ 1) /* "lbrv" LBR Virtualization support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 86554de9a3f5..b67d90f46263 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1006,6 +1006,7 @@
 #define THERM_INT_HIGH_ENABLE		(1 << 0)
 #define THERM_INT_LOW_ENABLE		(1 << 1)
 #define THERM_INT_PLN_ENABLE		(1 << 24)
+#define THERM_INT_DPTI_ENABLE		(1 << 25)
 
 #define MSR_IA32_THERM_STATUS		0x0000019c
 
@@ -1035,6 +1036,7 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_DPTI_ACK		(1 << 25)
 #define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2

-- 
2.43.0

