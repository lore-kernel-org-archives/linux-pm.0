Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DF3A4508
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301460; cv=none; b=f1IEYhutos3X7sUQJFFFtzNirXe2QiF+9nu4s6MRccDb4Ol0ka7UPM/UE5iwGyspp8B02zC/uzcpon6IybHfFakye1BD4h4xRla6K1Vb9+dGFvOGa4ksmmQuPpqGQaixSpVDgfZ6EBMTmlNnL85p5d8rFeVOKTD7lS/MnOs020w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301460; c=relaxed/simple;
	bh=4AGkGRB2plf/0Ask0sPCtxLnsA7rQl6usfJ+Nff+VVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3xDhem+B6inr8uO7EIKbTr7T1+ePaztqhTBauzz8prP2SyNaYD6vynKue8Bnl/I6lIh0V+z8k9tN2vFDz+SP+s8b20PIFA98ZMH84Bf76EWrrpGOCgYf/pnaVLx57MRqg6fWPjVhXsztFUs2y094P6BUCeguMmWaFp+8bGtFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDVGH9p2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDVGH9p2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so1609115a91.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781301459; x=1781906259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNkjCYpEbULRy9cBwWwyHLE3uooi2JdnjRxHBrTV8h4=;
        b=ZDVGH9p2jkqFerU5CeY17G7nYrCm99HcC+Vv0wGhpA1E4hEBcH5uAezI2K2+OE3vhs
         XBZDZv5k/r5xQ63Ttd++WzPP7ogc5lJsYKkbLzvwbt5Qc69Fx/MgIHc5vHDiNt62vvH3
         TtJ50UBkNC4XCSulIkqkD93uv3nVkrD6hpsBwzcjjavGfwJvTacVIli58EaklaEFtoZs
         LOYGAekUj3d68IjGuAhEsPazjR3nKuFsTUMa6UFRlMMq0iQYnbVCxEaY6oXB7vwfnlMK
         fw9IWZBbLH3yZHgA4j0ZdXGv+cpAQ7HlT+W0lDpsK31oUonqAm+/Hqm/tHotkxafIsOy
         +9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301459; x=1781906259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNkjCYpEbULRy9cBwWwyHLE3uooi2JdnjRxHBrTV8h4=;
        b=rtIUntL0Q34ToOppkTTk0LOeCinPFY0F2wDFz8OEI3RkkpSeUTG1FRDPeT5QyU52ze
         WvC22RIwgDnDlfmyITpsyB0MpwIxY4Cp8IGE382RR/n6rsVkmsoE48hVxRauxiWj6TDi
         T95JOJrKT/ToHhtI/un3BRRzZ/T1sgDrHN7m30ct56yA02pk5q4BPXzB3jDImhTpOr30
         DhvEUrhvlzx/Fr9mv1TqEpzsF1fXCeNv+vZdlw29jelZ5PYJxJHYNiRq8ORP1VFns39L
         gXJQvYSQ7kS4AkYxCLKOQaNuw1rMoFp5MqSbA99OvjDraOFe0PtIkPMUp53wR4XHFhix
         tnsw==
X-Forwarded-Encrypted: i=1; AFNElJ+oQIzc5FLydXPp37Kmoi/U80AnAQ2xpL4gJMBqtoZTNRysDn25zdGTd/lu0ZCRQnN/eIfToHQNoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWgQYX0Mppv2DnKhAYYmPXA6xnl2DUKHuQr8r41BEV2LZ5Obp
	TH1QjJo5C0HYsus8yDhQE4eu0Z1UJZtT1HRbgrPhL4uUR/Er1B+Wtl03s1Ahw1rdQ2Ide/5hDoP
	3yOWogdhJVrUUAg==
X-Received: from pgac25.prod.google.com ([2002:a05:6a02:2959:b0:c79:788d:5b72])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a83:b0:36b:9daf:1504 with SMTP id 98e67ed59e1d1-37a036ea6bamr4795053a91.14.1781301458921;
 Fri, 12 Jun 2026 14:57:38 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:53:18 -0700
In-Reply-To: <20260612215729.1532175-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612215729.1532175-3-jmattson@google.com>
Subject: [PATCH v2 2/3] x86/mce/inject: Avoid racy updates to MSR_K7_HWCR in toggle_hw_mce_inject()
From: Jim Mattson <jmattson@google.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, yosry@kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

toggle_hw_mce_inject() performs a read-modify-write of MSR_K7_HWCR as two
independent crosscalls: one to read the MSR and one to write it.  Another
HWCR update on the target CPU can be lost if it occurs CPU between the two
crosscalls.

Replace the two crosscalls with a single crosscall that performs the
read-modify-write using the amd_update_hwcr() helper.

Opportunistically, replace the open-coded BIT(18) with a new
MSR_K7_HWCR_MCSTATUSWREN macro.

Fixes: 21690934d934 ("EDAC, mce_amd_inj: Enable direct writes to MCE MSRs")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/mce/inject.c | 34 +++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..e24a0a6b5d17 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -900,6 +900,8 @@
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
 #define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
+#define MSR_K7_HWCR_MCSTATUSWREN_BIT	18
+#define MSR_K7_HWCR_MCSTATUSWREN	BIT_ULL(MSR_K7_HWCR_MCSTATUSWREN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index d02c4f556cd0..9d6e330fec61 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -30,6 +30,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/nmi.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 
 #include "internal.h"
@@ -310,28 +311,43 @@ static struct notifier_block inject_nb = {
 	.notifier_call  = mce_inject_raise,
 };
 
+struct hwcr_update_info {
+	u64 clear;
+	u64 set;
+	int err;
+};
+
+static void ipi_update_hwcr(void *info)
+{
+	struct hwcr_update_info *ui = info;
+
+	ui->err = amd_update_hwcr(ui->clear, ui->set);
+}
+
 /*
  * Caller needs to be make sure this cpu doesn't disappear
  * from under us, i.e.: get_cpu/put_cpu.
  */
 static int toggle_hw_mce_inject(unsigned int cpu, bool enable)
 {
-	u32 l, h;
+	struct hwcr_update_info ui = {
+		.clear = enable ? 0 : MSR_K7_HWCR_MCSTATUSWREN,
+		.set = enable ? MSR_K7_HWCR_MCSTATUSWREN : 0,
+	};
 	int err;
 
-	err = rdmsr_on_cpu(cpu, MSR_K7_HWCR, &l, &h);
+	err = smp_call_function_single(cpu, ipi_update_hwcr, &ui, 1);
 	if (err) {
-		pr_err("%s: error reading HWCR\n", __func__);
+		pr_err("%s: error calling ipi_update_hwcr on CPU %d\n", __func__, cpu);
 		return err;
 	}
 
-	enable ? (l |= BIT(18)) : (l &= ~BIT(18));
-
-	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, l, h);
-	if (err)
-		pr_err("%s: error writing HWCR\n", __func__);
+	if (ui.err) {
+		pr_err("%s: error updating HWCR on CPU %d\n", __func__, cpu);
+		return ui.err;
+	}
 
-	return err;
+	return 0;
 }
 
 static int __set_inj(const char *buf)
-- 
2.54.0.1136.gdb2ca164c4-goog

