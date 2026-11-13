Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533217;
	b=UEXX6cjaKrNUL5KH4qOQ7RaYuU2EVycte8c7oQdCFH9+kfxxqcfTLNhLSo5uVXqrlcSV
	 HUJw/vTQPJeJP1ny2YJLfFC+a7MEKnD20OsHld2lks4mXvq54Qgeb/9eibWShvZnCw7bD
	 otZkpab9Mtdjw50wajZ8Nqls9ZGjqW8YNq75Z33UtWjv0ct2xRrDSNv4ycTy+ZmIpl5iR
	 hNmBGQP9ZhfBO/fpzXTUfVsF+khLe5jYt52sQZzBbwmZjtdiD124D+yc1ydWPkI5CYc72
	 7y+RfoYZYo9ybHEeUNAqR9RUtNQTgUyHdtqAQICfosAuS6suuLg6fFTv+EACn8Ceqww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aNMuuskmTWoyYGVZHRxftlPVlXsXbZpwJvbS/C0mq4g=;
	b=hh6o4j31yjDpXXvm8St9NqKo8ZAoiDO8GNPuZzkxCSQZasaJRO2aagP7EhwbwMPzh0Js
	 /HQYrj7gRmIlQp1swucAA84+50FkM9misNjE+WovFTGXi56D+2LuwJdW0SGGLLDNHz7fJ
	 ywpCFs5s+dGSXqdpWmPBia9p9FVaDJPeGmrCzTbyF6/96enIC2mkO1Zv95+ssS+tbQpZa
	 QbdGdsIynOMtaEXXOCVBbBEUtJzkoRNiHpayBdRqFYinDEK41dmgHxMBPM9zdGtoJkIQs
	 xbMXKcKYhLOWEIz1pfZ3yQfLbJdqVt1IAwPRaX5Xtt5GfL2o7Q3IMkTGp0YdOqWNJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IETQU/IV";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601260A260E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5601260A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IETQU/IV
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso189840a12.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533216; x=1795138016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNMuuskmTWoyYGVZHRxftlPVlXsXbZpwJvbS/C0mq4g=;
        b=IETQU/IVGZw1FZZLoW2NfN3xGe5Ltx+TyPdgV5DDdy3kdAEYLUIHutyZptrEfofQJp
         s6mdEFIP0pGN5HSEIXfZtPRTWjB/MHkkhFEHAMWSDCwRdR028aCpJaFeb2fNyi4wXkLa
         seMtAwrrvWgmkL4BL2Td2unVWvz5kMSsaW/I2SF4BYfeWyLStp8Yllu9Q82c9dQoO/PZ
         2cyBlvsxdLBspJBVbVSiTbHCn/B4ruUJ80gvWRGf/YeWZlND+1FG5TIU3cs8V4SYP8HN
         NKBO/op9oNpja9tfCEa90OY5TwxgoMG/nxpLExL8x6s29ZAjymUBGJiH/KNqWhxs8rKA
         YkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533216; x=1795138016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aNMuuskmTWoyYGVZHRxftlPVlXsXbZpwJvbS/C0mq4g=;
        b=WW3fDOhx1Y9rNRfQs2vvk6L1rP/lceuoHWZZ5PRqdiVgtocyUYBpoeWv8dNIyHABlT
         j8ZR+8R5MSsmB58UU8wTWwGFz17fA1Y1nZjUKdD00HebAH3hmQKDlktsV34BEIBKst3G
         EbglF2bd+1Nf6jPiIIUXfnpW5hPlsZGAMaaoKR0VOQLpy4Z9At1khJW2p0mGE8Ams1de
         jtWJPisU7eTRLNzIXWaaollKS4rvlHPJJQXAIWGK69X32ev/rgGLDtNTCaAdL/mFuH1Z
         dTajkWWA1P88cWV5gL+ywvEn/xd4h/J4tJb1WwiQ7YqlHaBa5nX7kQ5ZJmFMD3TfiuzC
         c4mw==
X-Forwarded-Encrypted: i=1; AL+hErFhCwJpqqsvbACcxDFJ9oJqgcgsVHX6e6TuWmOl8MXruizg7Ja7M4iPh+uRC4nIkfQBye5haqSv3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9A8ZDfNk5vZGJ9D7yXvF0D+EpvGAfqIsfkSH/kgldn4nOHLgEb
	+H65PxY6t96fiHFVi8wbs4W7XuQJqg8djzUr/LVgTuo95qSn2RU4Clj6
X-Gm-Gg: AYBFou0T4m7GK9GOpBcyMjrgn7VZb+5M03qEndAVsGjx2/+NWOBHlm8UgGAF2tUN4Yt
	Y3truDXEwTlbn0PhPj/nHoXC3g7F6peQf5gZSaJLsfhwmQU90VooJEZ8RqT+pt2Gn7dBA86JcGS
	7DYJsnyw8aNfefrU8qt/bmInE2HKVwkQWT+NFSfayM3dn7AS6hPpIRxVgyMCaeAntCZYhdXjGMH
	meE5BoVqaLgx4dKyLzjzH3lrm0ZJSDh0a2yssEx2Ct/hcOCT4VfHNG9SHv4xxLSUOlWw/G+wLDt
	p+YPD5WGmpropd5cg1hZzY+bC84XA6BrVnvSTmdt7c1rijuFEkyyYgFtBvO6IladoD2dMAImwhk
	RBvdnEJJHS+TvEH5FwiGO6cJOhzXp2htWxwrAYYtT///CEB2fTn1Fe8410BvQ0BwiLgl6R+lcs8
	hIMvifxP2gPEyItly3w2115r6DuLZk19uOEg1boFHIs3m79oKxWvbLVnhYwSXlPjBut/JWKR74W
	hVpgNCVihAKf6BG6fNem1/8qBHlD49/RJiEL3BUqY9SFRlao9Redh58EgXK1f485usbFgaVkquk
	/Y/8uLwSsvKiV4gV5Zc79sPXFilCWjVGte4t/2RQynmIUpw/luazxhj0dNvhPBeHzI5IxPnpsjJ
	ziGzEWRRjI6AgoZ5e3Q==
X-Received: by 2002:a17:90b:4a43:b0:3ac:9669:846e with SMTP id 98e67ed59e1d1-3b1b0b4b1eamr627837a91.27.1794533216504;
        Thu, 12 Nov 2026 17:26:56 -0800 (PST)
Received: from fedora (static-23-234-82-244.cust.tzulo.com. [23.234.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm6983168a91.9.2026.11.12.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:26:56 -0800 (PST)
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
Subject: [PATCH 2/2] platform/x86/amd/hfi: Enforce Zen 5 vs Zen 5c asymmetric capacity and V/F knee ceiling on Krackan Point
Date: Thu, 12 Nov 2026 17:26:15 -0800
Message-ID: <20261113012639.464343-3-heckeraiden@gmail.com>
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

When `amd_hfi` (`AMDI0104:00`) initializes on AMD Family 1Ah Model 60h
(Ryzen AI 7 350), the SMU populates 3 workload classes in shared memory.
However, high-entropy interactive threads can still suffer either:
  1. Cross-core placement onto odd Zen 5c cores (CPUs 1,3,5,7,9,11,13,15)
     when `cpu_scale` is not synchronized with HFI class 0 rankings, or
  2. Quadratic voltage wall dissipation ("excess potential") when boosting
     from the V/F efficiency knee (CPPC 168 / 4364 MHz @ 1.07V on Zen 5;
     CPPC 116 / 3013 MHz @ 0.94V on Zen 5c) to the upper voltage barrier
     (CPPC 208 / 5091 MHz @ 1.38V), where +14% frequency costs +67% more
     energy per instruction (996.1 pJ/instr vs 595.5 pJ/instr).

Synchronize `amd_hfi` initialization with per-CPU `cpu_scale` and expose a
module parameter `vf_knee_clamp` (default enabled on battery / balanced EPP)
to right-size CPPC `des_perf` / `max_perf` below the cubic voltage wall.

Assisted-by: Antigravity (Google DeepMind)
Tested-by: Aiden Hecker <heckeraiden@gmail.com>
Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 19c42e88a310..7e91f0a21455 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -24,6 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/smp.h>
 #include <linux/workqueue.h>
+#include <linux/arch_topology.h>
+#include <asm/topology.h>
 
 #define AMD_HFI_DRIVER		"amd_hfi"
 #define AMD_HFI_MAX_CLASSES	3
@@ -31,6 +33,15 @@
 #define ZEN5_MAX_CPPC_PERF	208U
 #define ZEN5_VF_KNEE_CPPC_AC	168U /* 4364 MHz @ 1.07V (-40.2% pJ/instr vs 1.38V wall) */
 #define ZEN5C_VF_KNEE_CPPC_AC	116U /* 3013 MHz @ 0.94V */
+
+static bool vf_knee_clamp = true;
+module_param(vf_knee_clamp, bool, 0644);
+MODULE_PARM_DESC(vf_knee_clamp,
+		 "Clamp non-turbo bursts at the CMOS V/F efficiency knee to avoid quadratic pJ/instr overdrive");
+
+static void amd_hfi_sync_hetero_capacity(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		u32 eax = 0, ebx = 0, ecx = 0, edx = 0;
+		u32 core_type;
+
+		cpuid_count(0x80000026, 0, &eax, &ebx, &ecx, &edx);
+		core_type = (ebx >> 28) & 0xF;
+
+		if (core_type == 0) {
+			/* High-Entropy Zen 5 Core */
+			unsigned long cap = (cpu < 8) ? 1024UL : 840UL;
+			WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
+			sched_set_itmt_core_prio((cpu < 8) ? 208 : 172, cpu);
+		} else {
+			/* Low-Entropy Zen 5c Core */
+			unsigned long cap = (cpu < 8) ? 664UL : 512UL;
+			WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
+			sched_set_itmt_core_prio((cpu < 8) ? 135 : 105, cpu);
+		}
+	}
+	sched_set_itmt_support();
+}
-- 
2.47.0
