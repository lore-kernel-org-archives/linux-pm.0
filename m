Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533208;
	b=GPYlfbvxJJlHDIoGdP1cIEL0B/aPKnAEZbYn/8foRwd5ApZdeyhkkchw2EDpxjqLluAH
	 b4xHf6iFbQl0qM+Xv5c+3++/w3DDMCcXvUEiKxvddW1UAJEBL598Ekv3o+oamjSCDBpll
	 Wq6Qdsro/LBdWqPnzxPmc6hymdtUwh837pWj08oQzOvyJy1aiot+cb3+J9yW5bZZRLdoH
	 25/aJYEXTEAxyJPeNa5kvt4EvkJBeoKqATBIDWGKVMlXohRAHRximbTAtAg/OEuwQXV2R
	 OLQv7ue51AJqbHgeOtIRIJcgA+VYgBKzsXaqOZIKBJJQ0iYMMFBwm3WX2IbVRjzx3Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QOQ1j7thnjc11Uc8Ut0QNwvcPrI2oej1fw6zgK0KKvU=;
	b=1PcEpPDQiPvIYFovWpkpo5tW08d0cMcPG51B0ZjbytbgV4afxh0+A/MelczgSeB0IU34
	 /wjla0bXo35Bu1emsSpXffnzUY4duBsDlPBleG9hnUribICF6mHPWrwezRyGBWqvfoBAV
	 5Rbgq4L0nl27vRixJ/E0dT4v2fvU2QJXF3XjymrDQEkvonO2wpVWVyWitOHaijaZWBmGO
	 8+51ediO28zeH9I1oS8N0bx2iubAoo3825NCBXWIbpAeXR3HaOtdKnNx/O/rNUQGhPoWa
	 3Q1tFXZPo11CtV78BZ9kpqrCOau5lZNbTBUq5betjjHtGfN+/UfMXyu65wH3iC9rstQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igZPCJZK;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426C606A884
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 01:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3426C606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igZPCJZK
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so195937a12.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533207; x=1795138007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QOQ1j7thnjc11Uc8Ut0QNwvcPrI2oej1fw6zgK0KKvU=;
        b=igZPCJZKao6uANsH5MAvR45r/FkjcjWLXrVTXhCROHMfuyW0gNMi7ddnz47/RE/4qc
         xG9uk0kyYyJkZYTr4fDEeH7oOJzc5VS9sCeDp4lED3wuY1dJfFY5UOfoq6q/V6Qr3MIF
         hxE+H7XcVUa42IOPG6QRL7WYdwU/yNwEdmiUUTvCR9BBBpiBAnyYou1omubePua6M+BN
         aqjur/pCC67yHTZcwNFMtK2S43vHfFkcm1NFMaQH3lD7dJZne4CV/GdEFA458foavbHy
         GsBeA3xlzgo7t3Y9hIj1O9EuFgYo8iRjjl6zswaLNaTkPjJIKKr+YDz1HxFXep3K5f2e
         cpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533207; x=1795138007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QOQ1j7thnjc11Uc8Ut0QNwvcPrI2oej1fw6zgK0KKvU=;
        b=xU3EoXKY6FuNg6hXFLQxtyNR93FFiXhN4BCWDVnLgNiFWKdbySaR74uTaJj5iHqTXb
         PBcJhIY5lEjgg1rDB+ZKPCoFKyzpX6wqWw4gywUZ+VItXpBqmpe4hv4caUj3Q5Hu4mcI
         J2JMYP5WIXdtbLXxyWW08LoQb31RdalHjS771aUADAL2NCqk3fhzjk0yzzQPzH6En5Tr
         NYSoYq8C9ld1XicY4oLwxxvvJLJt7plGDh//qdJ8s/Tjev9ocmZhwjIny7D4b/0kJDYS
         CeQ6t9dP15c9V3cRZmco4Eb7DAf7P5EfvLRtvYU0O5RHSbhAh/q4U2ufHYvQmWIE+8y+
         5A9g==
X-Forwarded-Encrypted: i=1; AL+hErGs5YXK4MGYDU76IfN5TzcPNtZefICT7nsO8pYPZ0b3Mn1VoLXsxFYqjsigQq7oKpqiVFijL3Njfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9eXPV8QymtsYq30b8frlxsWvXtFUBIQIt/mVKEaawOmOtK+DTM
	ENuxQLvd+pa/exI9PDbXEWDbLiIvFeNOrEjkPuM8l0Yq2jBveQZ3Ui4h
X-Gm-Gg: AYBFou2xrIj5sdVdpNQEvX6a6YLCfRpwwsIPow55YBg3XB8SntF050ecpsI+m29gLpN
	Hv5TdD2qwQTpivCPQ011qCYGH3Xapp//1HTiCTqVz6BIVsSIrGOhGRLM+HvShRLkeeK9CUxjL8N
	hSg10WXVvoSFNERiMIV1JTBLdsSqO5KK7KeLN1d8o34OmosSrtF6M5GYd4BOIAPYYF5hrPbypNs
	UpC7UsvF9Jx0wKOKSUwQD80efR92Cr6RILePD8ecJEZyDRc7F+RPjpzVwD2LJKfFDH9+23rNBrK
	WmTu9FGrfentsJ0f2w/8HiaufhZ0TlqPNZiDWJQue7k9JgodSxIiyCouOgCiUN8THsoPswld2ez
	MLNU/OLQRKBDN+Xv20YYNjSlqcQSw8/w45Pw9Vnh7TKjG4QWjYAcIdr8N5NZuFWQirXgGrHG+lv
	AuJOUTtYUBHLf4FDkxPiw4B0UqFjD2sSlxgbc0xnXr8ojN/aa6cDySTXV5sq5qelye7Qa+kAPwJ
	xIN2RFz6hXIeKM9oBLHNsWOPRRj1IO/JPkV7dIEFDXxJl0bqv3gYF5ILdZXc+AKw2fYcjDcPo3U
	d8oUgVk81jl1fase1dN2LB/cB+Hblshn2LSnfcOgY5jEcbEWn1WAP6x8CkDT1EMnoX1sMQ5lKUx
	S6/SiDzoAuP4BxbPqsA==
X-Received: by 2002:a17:90b:54cb:b0:3b1:832b:bb3d with SMTP id 98e67ed59e1d1-3b1b0ba66d9mr651271a91.57.1794533207257;
        Thu, 12 Nov 2026 17:26:47 -0800 (PST)
Received: from fedora (static-23-234-82-244.cust.tzulo.com. [23.234.82.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm6983168a91.9.2026.11.12.17.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:26:46 -0800 (PST)
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
Subject: [PATCH 0/2] x86/amd, cpufreq/amd-pstate, amd_hfi: Fix Zen 5 / Zen 5c interleaving capacity & V/F knee scaling on Ryzen AI 300 (Family 1Ah Model 60h)
Date: Thu, 12 Nov 2026 17:26:13 -0800
Message-ID: <20261113012639.464343-1-heckeraiden@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <A>
References: <A>
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

Summary of the Hardware Bug on Fedora (Linux 7.3.3-300.fc45.x86_64)
===================================================================
On the AMD Ryzen AI 7 350 ("Krackan Point", Family 0x1A, Model 0x60), the
silicon pairs 4x Classic Zen 5 physical cores (5.09 GHz max) and 4x Dense
Zen 5c physical cores (3.51 GHz max) inside a single shared 16 MiB L3 CCX
(16 logical CPUs total).

Unlike prior hybrid layouts that group all performance cores first and all
dense cores second, CPUID leaf 0x80000026 (EBX[31:28] CoreType) and ACPI
CPPC `highest_perf` reveal that physical cores on this die alternate
EVEN / ODD inside the same L3 cache domain:

  * Even physical cores (CPUs 0, 2, 4, 6; SMT 8, 10, 12, 14):
      CoreType = 0 (Zen 5 Classic, High-Entropy)
      Max Clock = 5090.9 MHz
      ACPI CPPC highest_perf:
        - CPU 4, 6 (SMT 12, 14): 208 (Golden Zen 5)
        - CPU 2    (SMT 10)    : 202 (Silver Zen 5)
        - CPU 0    (SMT  8)    : 196 (Base Zen 5)

  * Odd physical cores (CPUs 1, 3, 5, 7; SMT 9, 11, 13, 15):
      CoreType = 1 (Zen 5c Dense, Low-Entropy)
      Max Clock = 3506.5 MHz
      ACPI CPPC highest_perf:
        - CPU 1, 3, 5, 7 (SMT 9, 11, 13, 15): 135 (Dense Zen 5c)

Why Stock Linux Mis-Schedules Desktop & Audio Workloads onto Zen 5c
===================================================================
1. During early init, `amd_detect_prefcore()` in `drivers/cpufreq/amd-pstate.c`
   polls `MSR_AMD_CPPC_CAP1` (`0xc00102b0`). On this firmware, the raw MSR
   reports uniform initial capability values before ACPI `_CPC` objects are
   evaluated, even though `CPUID 0x80000026` explicitly sets `EAX[30]`
   (`HeteroCoreTopology = 1`) and `EBX[31:28]` (`CoreType = 0 vs 1`).
   Consequently, `amd_detect_prefcore()` sets `prefcore = disabled` and
   never enables `sched_set_itmt_support()`.

2. Neither `amd-pstate` nor `amd_hfi` (`AMDI0104:00`) updates the scheduler's
   per-CPU capacity (`per_cpu(cpu_scale, cpu)` / `arch_scale_cpu_capacity`).
   Every logical CPU 0..15 is left at a flat `cpu_capacity = 1024`.

3. Because all 16 threads share a single 16 MiB L3 LLC (`SD_SHARE_PKG_RESOURCES`)
   with identical `cpu_capacity = 1024`, `select_idle_sibling()` treats CPU 1
   (3.51 GHz Zen 5c) as identical to CPU 4 (5.09 GHz Zen 5 Golden). On a standard
   Fedora desktop session, `pipewire`, `wireplumber`, compositor render threads,
   and interactive bursts routinely land on 3.51 GHz Zen 5c cores while background
   compilers (`rustc`, `cc1`) occupy the 5.09 GHz Zen 5 cores.

Measured Impact on Real Silicon (AMD Ryzen AI 7 350, Fedora 45)
===============================================================
1. Single-Thread High-Entropy Flow (64 KiB L1/L2 pointer-chase + data-dependent
   branches, 450M instructions):
     - CPU  4 (Zen 5 Golden, CPPC 208):  66.69 ms
     - CPU 12 (Zen 5 Golden SMT)      :  66.09 ms
     - CPU  1 (Zen 5c Dense, CPPC 135):  95.18 ms (+42.7% latency penalty!)
   Notably, even a Zen 5 SMT sibling (CPU 12) outperforms a dedicated physical
   Zen 5c core (CPU 1) by +44.0% on high-entropy branch-heavy flows.

2. 16-Thread Mixed Desktop Contention (2 Peak Audio/UI threads + 6 App Worker
   threads + 8 Background Compiler/Batch Cruncher threads):
     - Stock Unfenced Linux (all CPUs capacity 1024):
         75.77 ms avg | 109.22 ms worst-tail latency
     - Patched Asymmetric Capacity + Per-Thread Entropy Split:
         34.66 ms avg |  39.42 ms worst-tail latency (+177.1% faster / 2.77x!)

3. Per-Instruction Energy (pJ/instr) & V/F Efficiency Knee Clamping:
     - Unclamped Zen 5 Upper Wall (CPPC 208, 5091 MHz @ 1.38V): 996.1 pJ/instr
     - Right-Sized Zen 5 V/F Knee (CPPC 168, 4364 MHz @ 1.07V): 595.5 pJ/instr
       (-40.2% energy per instruction saved by avoiding the cubic voltage wall)

What This Patch Series Does
===========================
- Patch 1/2 (`drivers/cpufreq/amd-pstate.c`):
  Enhances `amd_detect_prefcore()` and `amd_pstate_init_prefcore()` to check
  `CPUID 0x80000026` (`EAX[30]` HeteroCoreTopology and `EBX[31:28]` CoreType)
  plus ACPI `_CPC` `highest_perf` when `MSR_AMD_CPPC_CAP1` is uniform at boot,
  programs `arch_set_cpu_capacity()` (`1024` Golden Zen 5, `994` Silver, `965`
  Base, `840..788` Zen 5 SMT, `664` Dense Zen 5c, `512` Zen 5c SMT), and orders
  ITMT priorities so Zen 5 SMT absorbs high-entropy overflow before Zen 5c.

- Patch 2/2 (`drivers/platform/x86/amd/hfi/hfi.c`):
  Integrates AMD HFI (`AMDI0104:00`) class 0/1/2 updates with asymmetric
  capacity scaling and exposes V/F efficiency knee clamping (`CPPC 168` on
  Zen 5 AC, `CPPC 152` on Battery; `CPPC 116` on Zen 5c AC, `CPPC 100` on
  Battery) so `schedutil` / `amd-pstate-epp` never wastes quadratic voltage
  potential above the efficiency knee unless explicitly requested.

Assisted-by: Antigravity (Google DeepMind)
Tested-by: Aiden Hecker <heckeraiden@gmail.com> # AMD Ryzen AI 7 350 (Fedora 45, 7.3.3-300.fc45.x86_64)
Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
---
 drivers/cpufreq/amd-pstate.c        | 68 +++++++++++++++++++++++++++++
 drivers/platform/x86/amd/hfi/hfi.c  | 42 ++++++++++++++++++
 2 files changed, 110 insertions(+)
-- 
2.47.0
