Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079334D3B0
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822745; cv=none; b=Z37mm0C1KFvAIgjgiW17fiYw2FK0ZbxyROGHwbz6HaY+CiU3MmhKrZW3lgGoN5TfsceNWP296cU1pysCym5eukWzkbLsZZBo3iFXSz5EwfvehF+lFXIenL0sSZ7HD8CP+snSiLPjMt95TnmIQo8EKE+6JXcrsTSP6iN3fdMT3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822745; c=relaxed/simple;
	bh=H+cAxBHJd4fZaA9Qkzfp9V6DYmmmJCJHfF1TvznEyVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8w3nRkURF7x1fNju+hParW9PYZf/Zju41sovIBt/gCzATM3QYF+0hJAHfDTb0yL5v+Iv7qxiB7NtdKzw3qd7LLMtANf82bJoiA2p1e5B08pKx/B/6oboRBy34fjuzzxeWuzuTVsilBO5/z3m7D8vQq4NxIezmKxRw1rPcuTk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kG+s1mEv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kG+s1mEv"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c89956023dbso679567a12.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781822743; x=1782427543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1jvwhNjvq2Is/V87dzOQZ0MYgc6uXTrarn3nSsMDgc=;
        b=kG+s1mEvr5s3JHPth8hhh1jU40br79RWuJ6ogiVYnVVOaX14kWhDBDljqzk7VrGFlg
         7ParWVt02doQZ0GUcJ9VGQJALc5VdsPUFrH/GuLP1S5NzPYOeKT7V1AbvLDBUFlJDu5c
         DE3be4QeY6sJTS7T9eS0+DVHmokm2BV5UcLZS/scs8EEReT1V3cCt4+Jt0tNyg+en2zX
         N64/sX7NyBD1T9TrGPA4hXC0JbYkrlR+aS0oeLsKTRlZb8DzrZJbq/ajUufRG4JasT0K
         H+cza1TqBx2A4FAX2D7qhr7X85LAbKwp7o0b/PLzkU5bnW3r3OTE+kBbm9VORwIyIxK4
         285g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781822743; x=1782427543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1jvwhNjvq2Is/V87dzOQZ0MYgc6uXTrarn3nSsMDgc=;
        b=GjUJ6eYqHrcrLU+sPh+QAWf5wJW9CJNe/waDxn1UmS8EIZEmIuhFEPb7E4vqMDTfuo
         7jEs5YSf1i+mq9Zlz/70BWlskOjT67nEnqx8M0cgO47q331neU2iIJisOpEIPoLV9zjl
         4XIhJua3yRH8kA62WwLzIERKSsajPU7vifcqsoEV1pfdXDN9Oq5I+xEvzDcrtq6bgCsy
         YWZ01Kncm3pZwQ6CMeJCf92xlaTPbzZM4DCja3YSRGNk8llqtaIcLF6/Q4333g74qLmE
         Pi3qChI64xFEF5Wk66W/ZFwNfGlnxqkIVYC2V7zkZIwZbPMIKkjR0r4sk17RarQdnsxf
         qTxA==
X-Forwarded-Encrypted: i=1; AFNElJ9I2nqXdcTJEjEiR4feU7BmMVLaECOHFiqVJhuf6unAcwiDA6ZmxZIJ36ZP5P1+B+FHe9r66GuWdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YZwQRa/I7VcclSoPgpBCD8r7tzjBXW3u1fdHfzdJRS3qCJKj
	I71BMGBxtgu8uz/f0Cjq8NlEfXgLJ4KH0EnOguLGl0CdBZ3q2SqGB7PT9njlL4EAYfgWqVj1ngX
	77uyCBXoHvzYv6g==
X-Received: from pgcv2.prod.google.com ([2002:a05:6a02:5302:b0:c89:a67b:d71f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cf86:b0:3b3:bdf5:117e with SMTP id adf61e73a8af0-3bb33952b8amr1171897637.27.1781822743201;
 Thu, 18 Jun 2026 15:45:43 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:26 -0700
In-Reply-To: <20260618224527.1506419-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260618224527.1506419-4-jmattson@google.com>
Subject: [PATCH v3 3/4] cpufreq: ACPI: Use IPI to update boost MSR in cpufreq_boost_down_prep()
From: Jim Mattson <jmattson@google.com>
To: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

During driver exit or CPU hotplug, acpi_cpufreq_cpu_exit() calls
cpufreq_boost_down_prep() to re-enable boost on the target CPU.  However,
cpufreq_boost_down_prep() ignores the target CPU parameter and calls
boost_set_msr(1) locally. Since this runs in an unbound process context, it
updates the local CPU's MSR while leaving the target CPU's boost state
unchanged.

On Intel platforms, the open-coded read-modify-write of
MSR_IA32_MISC_ENABLE in boost_set_msr() is vulnerable to preemption and
thread migration if executed in process context.

Fix both issues by routing the MSR update through
smp_call_function_single() to execute boost_set_msr() synchronously on the
target CPU. This ensures the correct CPU is updated and that the RMW
sequence on Intel executes safely in IPI context with interrupts disabled.

Fixes: a3605c46e0c0 ("cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usage")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260612215729.1532175-1-jmattson%40google.com
Assisted-by: Gemini:gemini-3.5-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..48d678812fd6 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -528,10 +528,11 @@ static void free_acpi_perf_data(void)
 static int cpufreq_boost_down_prep(unsigned int cpu)
 {
 	/*
-	 * Clear the boost-disable bit on the CPU_DOWN path so that
-	 * this cpu cannot block the remaining ones from boosting.
+	 * Clear the boost-disable bit on the target CPU so that
+	 * it cannot block the remaining ones from boosting.
 	 */
-	return boost_set_msr(1);
+	return smp_call_function_single(cpu, boost_set_msr_each,
+					(void *)1L, 1);
 }
 
 /*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

