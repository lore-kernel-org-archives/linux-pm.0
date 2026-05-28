Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F883F787B;
	Thu, 28 May 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981310; cv=none; b=FL44MXzriJfoafCcx+NE8udkMl3cGJWDNe6a0EpF0H4/mh4k9Usvj3YBgvMk7v/PPhGtfvPgIko/vMMI+DlLI5tgHwgwm69ibVPeAdwvQDAudaO4v85nna5e+2++BUOsqcVanTboNjLhymr8tUN3upE4pRyEup+TWpRkALbQK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981310; c=relaxed/simple;
	bh=JlzNdO/Tu0jxAOy1ftLyJ39j7H2gTMGVMTh7yjyZV0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4z7WVD0uShD3V6gKFDyQ0KLbxJk3I8bJvsXO6NuNHQeMEKSEk3Am0AWNsSI/TmbJSt1ayDeZGP+TpXfXCMhMOwVh70JVzoFscxx+lg0ZIXT3dWxVxbzsB/djVU1FgYXMJxjcpvEfW/XCvVuN/vtKVE2C+vitGqkm6z6g6nyAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1vICXjL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1vICXjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981309; x=1811517309;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JlzNdO/Tu0jxAOy1ftLyJ39j7H2gTMGVMTh7yjyZV0s=;
  b=L1vICXjLfUO9SuxCkKykmhPqxrDvIY7PCbokjUi6OrYSM9V0Yx73LWAZ
   nAbjdAoLkzirtufFoa1HdDVnQeiDwVtuCsqLtzqlLK3EwBMIOQrS5pgFG
   QNxNyJ3X49peMxx0i+SYUZY3F3IA6qk46M31XHfJXGi0eBVr/jB3dB8Ex
   LF5hJ1WJPdz3wi7SceevktDF2hPuWR3JGhDASXNDoXDoOLbKW1GMabyf3
   PrpDwsoqByWoDWfYLYDWbFKoBuxmxZ7B/RqLX9Ap7BAdumNc9aV3pO8jE
   aTxBQOiOT5Y+NpUFG3Pew7Kkbgt/f/V7VRJ/DLS8w1vmD5iTjlvYumcGP
   g==;
X-CSE-ConnectionGUID: +R3pVRXcTXqaobHSFA7f8A==
X-CSE-MsgGUID: 6EmjAPUfTCeR5cl5ewHkdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887340"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887340"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:07 -0700
X-CSE-ConnectionGUID: bSI6kyCWS860IzZHKmTL+Q==
X-CSE-MsgGUID: icDUHT50RIOOj7tiYiNiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536822"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:07 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 28 May 2026 08:25:43 -0700
Subject: [PATCH v2 2/5] x86/thermal: Add bit definitions for Intel Directed
 Package Thermal Interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rneri-directed-therm-intr-v2-2-8e2f9e0c1a36@linux.intel.com>
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
In-Reply-To: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=2410;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=JlzNdO/Tu0jxAOy1ftLyJ39j7H2gTMGVMTh7yjyZV0s=;
 b=BksjLS/tirNT/q9i5Xz3pOiXyfTViSBoDrfXk7WfZSMuE6YyMUgewQNlRLLhCIsoAapcQ5Rtk
 +DJI/PpoFPNAPaQ3zR1NvvHIlqpB3eaU8zOrl9ozl+w72lViffweGZx
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

