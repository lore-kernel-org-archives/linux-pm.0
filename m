Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B38E5C6;
	Mon,  9 Mar 2026 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094841; cv=none; b=W8qiKw+vke4dgnU5RYjrJuBR8tJ5lFgpIkk1xLiAiTU++zS6L/PJEsjxfyv6z4Yod5wpVxptIUvUy/Vj7WftWGucgTVCn2sVC976EVonatswmLpZNWEMr4LjK2wS5pztApvGoQnIa7YLOF3Oe6qPNHpxCQJErxNYLK5foJ0YH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094841; c=relaxed/simple;
	bh=F1AQED94e08k0SWL58HdTlp1BKL2Y2eWIRKWsUfiHsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/xK/32SefQ7Zgn4ju0p+m4FpedrKgSbsS8J0p48/jjfZp88Pzmbx/+j+WRneTKUr8qDz4ggbKG6VGSU1lMiZZx+TieOdjZlkTSIPMA+397XwwnoyIMUzSHCaJ40wrGgwvDFPmSsisx7WN5ITrAs5DHch16qPjtLW8R9PM6mGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJmNNcmj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJmNNcmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773094839; x=1804630839;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=F1AQED94e08k0SWL58HdTlp1BKL2Y2eWIRKWsUfiHsM=;
  b=mJmNNcmjn9sOSuEc5j/4uf79fLqqlLdRS0eg+8rjVEIwuRrSUXJXsOy3
   DEtc4xlZsNa2uE6wtlfwLS2/vf5zjFNyBwV/Cd0iBbjxgsEqEalrV2wvc
   xQ3QJ7gdq00+jiPop2eNadypgZioB9FHVZp0ay5esyU21UFFW6A+Qvgdv
   YCrfXXuSmTxRdJzIdodoQFwMno9fqq4IAw8tk+0o14BXvqi/7iZm+qlzT
   cyKzFAMDvNwsXwKAOYMGtrq0ZtkyiabJSaTmAvXQh88hixypDdo3dG6GY
   5bQap2EHHsXokQfSmhicZhne8vOtB6i9ebAdu2RG7gxGupU0JaMSkOmKd
   w==;
X-CSE-ConnectionGUID: pQQNaFotR4u7U/A3BOJl1g==
X-CSE-MsgGUID: 5HGXUJY0RISI7QAEItEiZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74050652"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74050652"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:37 -0700
X-CSE-ConnectionGUID: oS8gFM29RE+/D9HXkweZuw==
X-CSE-MsgGUID: zclN2n5gRMORG4UuEMICdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224004285"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 Mar 2026 15:19:24 -0700
Subject: [PATCH 1/4] x86/thermal: Add bit definitions for Intel Directed
 Package Thermal Interrupt
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-rneri-directed-therm-intr-v1-1-2956e3000950@linux.intel.com>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
In-Reply-To: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773094782; l=2125;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=F1AQED94e08k0SWL58HdTlp1BKL2Y2eWIRKWsUfiHsM=;
 b=H6Vj51EcgCI5yd90HGMxoxN57Vr7ICr4pOi3BDKA+E39ht382WGajio8ieeYCbR9gBBGahUEh
 gKwhWzrr/w7Dl3GldYyHlh8jCXfSYdwHjkW0DAhrvACsGoTPDXOFNGt
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Add CPUID and MSR bit definitions required to support Intel Directed
Package Thermal Interrupts.

A CPU requests directed package-level thermal interrupts by setting bit 25
in IA32_THERM_INTERRUPT. Hardware acknowledges by setting bit 25 in
IA32_PACKAGE_THERM_STATUS, indicating that only CPUs that opted in will
receive the interrupt. If no CPU in the package requests it, delivery
falls back to broadcast.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/msr-index.h   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..487bf9da0cef 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -364,6 +364,7 @@
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* "hwp_pkg_req" HWP Package Level Request */
 #define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */
 #define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */
+#define X86_FEATURE_DIRECTED_PKG_THRM_INTR (14*32+24) /* Intel Directed Package Thermal Interrupt */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
 #define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..aa1c652a9581 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -995,6 +995,7 @@
 #define THERM_INT_HIGH_ENABLE		(1 << 0)
 #define THERM_INT_LOW_ENABLE		(1 << 1)
 #define THERM_INT_PLN_ENABLE		(1 << 24)
+#define THERM_DIRECTED_INTR_ENABLE	(1 << 25)
 
 #define MSR_IA32_THERM_STATUS		0x0000019c
 
@@ -1024,6 +1025,7 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_DIRECTED_INTR_ACK	(1 << 25)
 #define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2

-- 
2.43.0

