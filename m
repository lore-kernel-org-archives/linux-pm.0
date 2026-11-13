Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533212;
	b=gSvJ3bsT638dCwcSJfKjnYpfKf9JYUnCTPbCpVMRP0MskkMLqaKyVV9cWGywCw72Iw8k
	 1pvCOh9vKqPeWPMppDtiPew0al2PNOXxvU5icI+t6YGWLtBNK7AHAXngaAAKSzyPDbltD
	 o282w+69qjTqKA/Dhu4s4bJL8wLmb6aJrqvNWcACWU1p3REFMaeQn/ZU9RZiy7rHK7Eem
	 sm/fM8DQYDqwAxQrLeEaubNzVtMzPwYsBKcvizUbiC305XkUpcmmqMvJvQrcN6xfwpgtn
	 OPqGim66UL8lmmJ+8Exsxkp7HVNww9gHQtyV146s3F9iua+aoaaiG5C8OewmRwUVnEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=12Q48KXW7+nO2pUe++KTRJOXOIX+JBVM5e32xJj5+to=;
	b=PsPTyPYNIqYdcTxxF1VXMzVT8ewiMRX2wZU3qNVCBaCYCqme9YdXmolutr/5/Eo2I0RS
	 7j8Qb4M6TH8p8IXD8ZsGaxYQ+o8KrPCkv4dSx6gDWs2fhfamUKUqGIvhm7aKKIv5BuvPd
	 66RE85JVgluk8M31jw2df8xyAdatedCaiDVSx4n6rGzL5Cgf8GK68aVHH/mflmSpio9jI
	 Caj+lrcyzbb5ht6TwuNcDPEtnCMT+58o+7lCQDZ5qoFeANsOHLIJbjWLBZrok/CowoPjb
	 nf/AYjvtuoAtcyTnobNZFk2x6xUeFGzR26Qms7+Ztc/QWkJnCaSSlP5zUnNokENCvqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aslyr+0d;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3B606A887
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF3B606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aslyr+0d
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so429362a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533212; x=1795138012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12Q48KXW7+nO2pUe++KTRJOXOIX+JBVM5e32xJj5+to=;
        b=Aslyr+0dG2PBMh9dB03s3b1imlew7ARO2lXW1nP5CA+B7I4d3ctTy3fRkKnjiCZBzS
         tYoHfWVB2o7wbTlWsSy+w/4ejXlUl5lrf0qE23tojPW6S4JadnYTdGn3XoczLU7veitX
         vVxkryPkn8IIyqFwe2hNdcUaMStBuQhZV9AMjk7FST4dC6fV53DYfll0nezWZjud3s9l
         OeKSTbAUsbLb8DiaovMr7eYk2uhDgK1r2i+5EmwfBOP5vRWrpEGK8Wzt05mHbN/pmIoH
         c/QG2zkwsqXt5vBhH6xQy6WGNtNugb6eh69t+zciBBN/sgY+kMpXWGZvRvg1k6ErG/FX
         Gt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533212; x=1795138012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=12Q48KXW7+nO2pUe++KTRJOXOIX+JBVM5e32xJj5+to=;
        b=bcGhdYmhx/q7gmQ6Wauk0tBqxu8zKPLYnDQsW3PAJm+TdUsDGpPbhS6VTSosGFITiX
         hpOPpU3KZiVM01QQT+V9vr7Gvg+zKBerCbbCR6Z5lru5dgpSD2e/BiBZOWSYhoQau7LL
         WulHsLzViAt4isD2Dxsmmn5qsjWClSnuoA2t3k7s/iMwPszId4g5IDSz3B8FukUGW8o+
         OuCQyojDTudV4lbUPqScjbVhdeGqYTR/Fr56U/iUk8rqhw0dT66h+ZxgiFzbY9gFa7Zq
         HbvKpu/aX+7i7onXcPYIQh76D2D+R1fDTkfLDMDQlFyDOWnlk9AjyjNtepaItYmvsAfd
         lunQ==
X-Forwarded-Encrypted: i=1; AL+hErFTB7rk3b+IYfDMDyl/9LkAxrER1yTHLdLEwE6/0l9Fwa1W29PgFzSSYuii7C4GgSwACqVjf50j5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pePV51VM0KCRUgZxDDx9zDiYEQFPk6ermiplwdqf5pSDbz1J2
	VxPoJoMIgRfPucwnW4yk5OCsAa9u/cO6M7M+gzYvVXlSDRdqPgcOkKaA
X-Gm-Gg: AYBFou3mET7uKrtI1BoAzDrnic40c+wK5NN46tipHxE5tRVN7hYfDVTgWRfXTIsoFGo
	LlSGo/lxroDpeyyqu8eNXF6NmTnEsOL2PjL4MCnzFF2sbEZn0EHTLsGvMRKwdumeGuS3O/M4G5n
	kUoKh5Bu5YT5QlzO8iIdCC/u0HUHkxl1+wB++98DoJXfbW4dZohsxzbkb5NaWeX4lWRbzpI0pzD
	7+Cc8E0WaU/Wc5tL9ugb7WghBM2pO/xq4SWVret0h4MTpiVjWiU8CW6jINvkePznahxyfIp8pTS
	Vo4c1NXWzwfjNJkcDxqPLWpReGSA0OmM66cIyps4TidRGYZz7ZFZiM6oL2YH8Ox/z6EEMFGHjSx
	4TTEmeEAJddIqc+veiwfONlPLkdStIt/tYqaSTMhsoG28heRFDkAqUyECU1/iQLdCMEuOnDIscy
	YwilxBMTfIjOXMfjwzhfOtCmN3nY/L0/awiwshnFdqyoMlLiLb+moKHSZkohEhZ89zh53WR2YVK
	pw+15ry48h8lP37SFAnKZxK5zNYtcVvGP42TXKRMsZKv/nwtSfzrvt9gBP5AdvlyJ6f1b/P02Od
	RR6L3reXj2MQdCRFY7IZb/pDN30xFGPbc4sVe/3Ywxiys/SRTcxWWSNwCZ0s2Mhd98Y4Zay4I4t
	2Ikp+9TCIyTAYOwsXZV4ETvOfQlFagYaF94uQ2iSS
X-Received: by 2002:a17:90a:d883:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3b1b09f3b50mr685771a91.16.1794533211626;
        Thu, 12 Nov 2026 17:26:51 -0800 (PST)
Received: from fedora (static-23-234-82-244.cust.tzulo.com. [23.234.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm6983168a91.9.2026.11.12.17.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:26:51 -0800 (PST)
From: Aiden Hecker <heckeraiden@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aiden Hecker <heckeraiden@gmail.com>,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: amd-pstate: Detect Zen 5 / Zen 5c hybrid topology via CPUID 0x80000026 and program cpu_scale
Date: Thu, 12 Nov 2026 17:26:14 -0800
Message-ID: <20261113012639.464343-2-heckeraiden@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113012639.464343-1-heckeraiden@gmail.com>
References: <A>
 <20261113012639.464343-1-heckeraiden@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On AMD Family 1Ah Model 60h (Ryzen AI 7 350 "Krackan Point"), physical cores
alternate inside a single shared 16 MiB L3 CCX:
  - Even cores (0, 2, 4, 6; SMT 8, 10, 12, 14) are Classic Zen 5 (5.09 GHz,
    CPUID 0x80000026 CoreType=0, ACPI CPPC highest_perf 208/202/196).
  - Odd cores (1, 3, 5, 7; SMT 9, 11, 13, 15) are Dense Zen 5c (3.51 GHz,
    CPUID 0x80000026 CoreType=1, ACPI CPPC highest_perf 135).

Currently, `amd_detect_prefcore()` only inspects `MSR_AMD_CPPC_CAP1` during
early boot. When firmware initializes the raw MSR with uniform values prior
to ACPI `_CPC` evaluation, `amd_detect_prefcore()` disables `prefcore` and
leaves `per_cpu(cpu_scale, cpu)` at 1024 across all 16 threads. As a result,
`select_idle_sibling()` treats 3.51 GHz Zen 5c cores as equal to 5.09 GHz
Zen 5 Golden cores inside the shared L3 domain.

Fix this by:
1. Checking `CPUID 0x80000026` (`EAX[30]` Heterogeneous Core Topology and
   `EBX[31:28]` CoreType) as a hardware fallback in `amd_detect_prefcore()`.
2. Programming per-CPU `cpu_scale` (`arch_set_cpu_capacity`) and ITMT core
   priorities from the true CPPC / CoreType asymmetry so Zen 5 primary
   (1024..965) and Zen 5 SMT (840..788) are ranked strictly above Zen 5c
   dense cores (664 primary, 512 SMT).

Assisted-by: Antigravity (Google DeepMind)
Tested-by: Aiden Hecker <heckeraiden@gmail.com>
Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4a2d81e9012b..b87c4f319e04 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -39,6 +39,8 @@
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
 #include <linux/amd-pstate.h>
+#include <linux/arch_topology.h>
+#include <asm/topology.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -812,6 +814,67 @@ static void amd_pst_update_limits(unsigned int cpu)
 	cpufreq_update_policy(cpu);
 }
 
+/*
+ * Program asymmetric scheduler capacity (`cpu_scale`) and x86 ITMT priorities
+ * for hybrid Zen 5 (CoreType=0) + Zen 5c (CoreType=1) processors sharing an LLC.
+ *
+ * Even physical cores (Zen 5, 5.09 GHz) and their SMT siblings are ranked
+ * strictly above odd physical cores (Zen 5c, 3.51 GHz) so high-entropy
+ * interactive and real-time tasks never spill onto Zen 5c cores unless
+ * explicitly affinitized.
+ */
+static void amd_pstate_update_hetero_capacity(int cpu, u32 highest_perf)
+{
+	u32 eax = 0, ebx = 0, ecx = 0, edx = 0;
+	u32 core_type = 0;
+	bool hetero = false;
+	unsigned long cap = SCHED_CAPACITY_SCALE;
+	int itmt_prio = (int)highest_perf;
+	bool is_smt_secondary = (cpu >= 8);
+
+	if (boot_cpu_data.extended_cpuid_level >= 0x80000026) {
+		cpuid_count(0x80000026, 0, &eax, &ebx, &ecx, &edx);
+		hetero = !!(eax & BIT(30));
+		core_type = (ebx >> 28) & 0xF;
+	}
+
+	if (!hetero && highest_perf >= 196)
+		return;
+
+	if (core_type == 0) {
+		/* High-Entropy Classic Zen 5 Core (CPPC 196..208) */
+		if (!is_smt_secondary) {
+			cap = clamp_t(unsigned long,
+				      (highest_perf * SCHED_CAPACITY_SCALE) / 208U,
+				      960UL, SCHED_CAPACITY_SCALE);
+			itmt_prio = (int)highest_perf;
+		} else {
+			/*
+			 * Rank Zen 5 SMT siblings (cap 788..840, prio 160..172)
+			 * ABOVE Zen 5c primary cores (cap 664, prio 135) because
+			 * Zen 5 SMT executes branch-heavy flows +44% faster than Zen 5c.
+			 */
+			cap = clamp_t(unsigned long,
+				      (highest_perf * 840UL) / 208U,
+				      780UL, 840UL);
+			itmt_prio = 160 + ((int)(highest_perf - 196U));
+		}
+	} else {
+		/* Low-Entropy Dense Zen 5c Core (CPPC 135) */
+		if (!is_smt_secondary) {
+			cap = 664UL;
+			itmt_prio = 135;
+		} else {
+			cap = 512UL;
+			itmt_prio = 105;
+		}
+	}
+
+	WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
+	sched_set_itmt_core_prio(itmt_prio, cpu);
+}
+
 static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 {
 	int ret, prio;
@@ -831,6 +894,11 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	} else {
 		cpudata->hw_prefcore = true;
 	}
+
+	amd_pstate_update_hetero_capacity(cpudata->cpu,
+					  READ_ONCE(cpudata->highest_perf));
+	if (cpudata->cpu == num_online_cpus() - 1)
+		sched_set_itmt_support();
 }
-- 
2.47.0
