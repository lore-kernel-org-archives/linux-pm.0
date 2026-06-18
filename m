Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B133F58C
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822744; cv=none; b=lfG2MufA7nN6dBVmaEViTIAWQrHiKeVfO4qPTjQOHSpshWv1pu4ter8a0QAYJ/oKKvMkZtCoFxHfItC/VAHli7vJW0FQq8LFln4S7M62ZY1FwxZvqFyp3Yk60J6ATbQDoySEe0a4yraYX8vBZovmxVXQwm0UH54CAD9ZgOkaLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822744; c=relaxed/simple;
	bh=BjA7c9I6piwWq9wtAxtFoFdK4hfiQGXOkTBLMpji+sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b7H0ot1NakEeEcNi24q2WDZdqRR1n15V0PlTEU48xgtrO6VeVUiJju9vs9+DAr6PXx4j8BoQaqaf+57KgZMQutIa88g4jrRWeg+xpNOOR/eBMgdALBmNTPHjwRuon8Ik2qzxIESEtuZ8h5iqrR6wyhFUzc2Has/+e6yNDMeIuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWR4cEg5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWR4cEg5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6b4271491so10492365ad.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781822743; x=1782427543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=orCsuuUrSE13rotpUYJYYTAbwaY/W6h9VEYHAL58Cls=;
        b=oWR4cEg5WCPwcxIlQqb/d7gdbgzV5AjFn5Mnn1pyu8HI5ey7x8lED78fDXzGA4MNzN
         IhWuAElrO/BrQ3PYNNHpVKzqFnSUB6NBa6cK+LxsO6xFkKheLQ5UM+1z7edQSQWsvQax
         Q7Y3cWc3OtclFReZM8QJQVDY+bikmQ8t++UiWYQB1ClVINA91+mhBWy8xQX4PnMqzdpt
         zg0g+c98tnlCDbHBwxNYDIXvqA7TblXy66HWjLkZrNNeKT7DBVucC97cqvZZf1QuhWaP
         qMLG6IuxPwiUj80xymx22rEw44qWFBjJzZT+xdK3K58df7g3VQKIlsCQF6cv4sHOWPUn
         8uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781822743; x=1782427543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orCsuuUrSE13rotpUYJYYTAbwaY/W6h9VEYHAL58Cls=;
        b=gsVfgV7uhoGieb1nZacMguBjR8ipJt+0J6ifbJPAP1YuQZnMPf4khuzCFLLMfI/AuI
         STLHGuC8T1Ska64Xritbyei3kb92xmMyYpcHNNCWMpQ4v+mSj1phJ7ff98WTpzSvOH7U
         APJOOezicDXvcJFVnQV/T5+fN5PkOGTvVa+C4ku1+2nMWXkWa0OZkHtzVYHJ6OCx7Nh6
         Sm76CcI3qMeajlpjxMi3rikHXAvkMKXwolQ9kvmlBzWbjteEmfuCyMy0qoM9PKEC4NAu
         CpfSqupP+HofwoRqnn/3Kc+fpGZZGu7N7rVOtGzO8gM1WqACvU5yQXMlfVHkNEinv1JQ
         3m1g==
X-Forwarded-Encrypted: i=1; AFNElJ9JUt3go+0qb4/Sap4v9E4daypCSybg3BWGKn95hKIAtTtMcMorfWS+zF9KXImN+1pRtOu/n+BRxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxltE1jjQnn6+Q4V/YKWw5T8cBOuFt88cMGtbeuN1dCWqhXLgwe
	GSvvzk0ubv38v0OBG4RFmqXeLju7sQo9mZid31HZo5747/2g1No5AgpaidW0dtzVEx31L/lx6o/
	kXzgXhst+ezKo+g==
X-Received: from plae3.prod.google.com ([2002:a17:902:e0c3:b0:2b0:5102:ab9e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d489:b0:2c0:ccdb:e02c with SMTP id d9443c01a7336-2c718efa7acmr12378295ad.7.1781822742377;
 Thu, 18 Jun 2026 15:45:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:25 -0700
In-Reply-To: <20260618224527.1506419-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260618224527.1506419-3-jmattson@google.com>
Subject: [PATCH v3 2/4] x86/mce/inject: Avoid racy updates to MSR_K7_HWCR
 during MCE injection
From: Jim Mattson <jmattson@google.com>
To: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

MCE injection performs a read-modify-write of MSR_K7_HWCR as two
independent crosscalls (via toggle_hw_mce_inject) wrapping the actual MSR
writes (prepare_msrs). Another HWCR update on the target CPU could be lost
if it occurred between these crosscalls.

Introduce ipi_inject_mce() to perform the entire injection sequence (toggle
ON, write MSRs, toggle OFF) in a single IPI callback, ensuring atomicity on
the target CPU.

For the local CPU initialization path in check_hw_inj_possible(), use
amd_update_hwcr() directly to avoid IPI overhead and ensure safe updates.

Remove toggle_hw_mce_inject() as it is no longer used.

Opportunistically, replace the open-coded BIT(18) with a new
MSR_K7_HWCR_MCSTATUSWREN macro.

Fixes: 21690934d934 ("EDAC, mce_amd_inj: Enable direct writes to MCE MSRs")
Link: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmattson%40google.com?part=2
Assisted-by: Gemini:gemini-3.5-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/mce/inject.c | 46 ++++++++++----------------------
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 86554de9a3f5..29c4abade594 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -896,6 +896,8 @@
 #define MSR_K7_HWCR			0xc0010015
 #define MSR_K7_HWCR_SMMLOCK_BIT		0
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_HWCR_MCSTATUSWREN_BIT	18
+#define MSR_K7_HWCR_MCSTATUSWREN	BIT_ULL(MSR_K7_HWCR_MCSTATUSWREN_BIT)
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 6f8a49d8baeb..1e017d8e23e4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -31,6 +31,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/nmi.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 
 #include "internal.h"
@@ -311,30 +312,6 @@ static struct notifier_block inject_nb = {
 	.notifier_call  = mce_inject_raise,
 };
 
-/*
- * Caller needs to be make sure this cpu doesn't disappear
- * from under us, i.e.: get_cpu/put_cpu.
- */
-static int toggle_hw_mce_inject(unsigned int cpu, bool enable)
-{
-	struct msr val;
-	int err;
-
-	err = rdmsrq_on_cpu(cpu, MSR_K7_HWCR, &val.q);
-	if (err) {
-		pr_err("%s: error reading HWCR\n", __func__);
-		return err;
-	}
-
-	enable ? (val.l |= BIT(18)) : (val.l &= ~BIT(18));
-
-	err = wrmsrq_on_cpu(cpu, MSR_K7_HWCR, val.q);
-	if (err)
-		pr_err("%s: error writing HWCR\n", __func__);
-
-	return err;
-}
-
 static int __set_inj(const char *buf)
 {
 	int i;
@@ -500,6 +477,12 @@ static void prepare_msrs(void *info)
 			wrmsrq(MSR_IA32_MCx_MISC(b), m.misc);
 	}
 }
+static void ipi_inject_mce(void *info)
+{
+	amd_update_hwcr(MSR_K7_HWCR_MCSTATUSWREN_BIT, true);
+	prepare_msrs(info);
+	amd_update_hwcr(MSR_K7_HWCR_MCSTATUSWREN_BIT, false);
+}
 
 static void do_inject(void)
 {
@@ -556,13 +539,13 @@ static void do_inject(void)
 	if (!cpu_online(cpu))
 		goto err;
 
-	toggle_hw_mce_inject(cpu, true);
-
 	i_mce.mcgstatus = mcg_status;
 	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &i_mce, 0);
 
-	toggle_hw_mce_inject(cpu, false);
+	if (smp_call_function_single(cpu, ipi_inject_mce, &i_mce, 1)) {
+		pr_err("%s: Error injecting MCE on CPU %d\n", __func__, cpu);
+		goto err;
+	}
 
 	switch (inj_type) {
 	case DFR_INT_INJ:
@@ -727,7 +710,6 @@ static void __init debugfs_init(void)
 
 static void check_hw_inj_possible(void)
 {
-	int cpu;
 	u8 bank;
 
 	/*
@@ -737,7 +719,7 @@ static void check_hw_inj_possible(void)
 	if (!cpu_feature_enabled(X86_FEATURE_SMCA))
 		return;
 
-	cpu = get_cpu();
+	get_cpu();
 
 	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
 		u64 status = MCI_STATUS_VAL, ipid;
@@ -747,7 +729,7 @@ static void check_hw_inj_possible(void)
 		if (!ipid)
 			continue;
 
-		toggle_hw_mce_inject(cpu, true);
+		amd_update_hwcr(MSR_K7_HWCR_MCSTATUSWREN_BIT, true);
 
 		wrmsrq_safe(mca_msr_reg(bank, MCA_STATUS), status);
 		rdmsrq_safe(mca_msr_reg(bank, MCA_STATUS), &status);
@@ -759,7 +741,7 @@ static void check_hw_inj_possible(void)
 				"Try using APEI EINJ instead.\n");
 		}
 
-		toggle_hw_mce_inject(cpu, false);
+		amd_update_hwcr(MSR_K7_HWCR_MCSTATUSWREN_BIT, false);
 
 		break;
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

