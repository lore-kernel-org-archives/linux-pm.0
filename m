Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536981;
	b=rSVLjPSAIo0WV6SRKxLiGm4rU7/GVsMuS8ZHNajNFyMkEvR7vj+q9vlJX5O3SjO8Z2Ou
	 555SzvhDTs0lnrb51QayVRrYHv+NU083LY1zlHNzN6iv/1d3/7S4nCRdrwNbKVIa3nugV
	 HPfbCVXx3qZnxBRz1Rs7SLuWXkdu+QyIqzfOymzQRsAktFznsN2E2Py4MI12Mx1vFTtzO
	 am6SGH1AMSGK1wO0G+bkHhHAC/tRnNKCByb7FHagZ6KL2e4y9sC0NxZu9QUC/aOke0p0I
	 BNfF2TIB5iJIk56LpY7lrzvUKeiFnjXWxuXNij1TqwzSEe8OwwHASHkyxSJ1pzCKCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v43qrtIVqNMJqQE5xu9+Ge4cqhglAQOPGlfnsSn0+3Y=;
	b=fvO47AV1xuTYmOAcBQrTWYyJsw7q54Q7vqKcHWanELu1YeDr6t/q0qnvRB45aNgeHAS/
	 fuOFuJq36azZcKVhBAqDaOKsFoRGl+5GGDrXNHOemEvFdiy1NH6m++9cY2U/jXarWzsVl
	 BDnVGtdS5YfZavBp778qGE2rPaVREg9awuLg8AUy5jRRXNt8X/uGxbxBLypB1UMRt7Ly3
	 2svcgfujIzGe53vtJ3L576h0vjCM2DCUpk0EL1QyFGvaAzVFhln7LzrTPJdH8XnV5qtOi
	 YMZKndbwC/FQMp/PyCZwhWaBmHjRD6HBHwEJsgBuDim/8+o5LYpTJQCrivm9VL8H6dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNPGWpXs;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB61606A323
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB61606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNPGWpXs
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b5efadd183so736038b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536980; x=1795141780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v43qrtIVqNMJqQE5xu9+Ge4cqhglAQOPGlfnsSn0+3Y=;
        b=XNPGWpXsCjETwnFCuffPp7eCJFAjPVi/99mZwpTMb2DRNM4I5cgZJAoZ3JYWiM1wLJ
         w1nHmltwfpFRpKNUP6d7AyFQVX+NMTf28PpTpWEl1YgnNNcPki/L57XvC+tMAYCV9L31
         nK4dy11iSbOfh/VboH5uGugu9tRroMUmd5AQ0LBfc/oVpaOeYAIoIi1/NgKjh0uT5DRE
         AOxsh5MmLvbDo5yd9ylcpzf84EuxXXZAn5O0WeLvbT79xt8GMZnVxzO80xNl4XHpkaBe
         ENbml10NvkFGneq/l0ckCzHD4yPQWwsdRhrcmkoEWGGidgxPJid1Hi6TPTbOBAUbyYH0
         2/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536980; x=1795141780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v43qrtIVqNMJqQE5xu9+Ge4cqhglAQOPGlfnsSn0+3Y=;
        b=WBLAZAH3+eGcZnb9Bz1ULPg5Y4E+Y6E0YFV87q9+sqi9RYHFEMUGf2eVPFuhgYht8Z
         ncOAbOw4P8yQnpDb8xf2BFWJTkFYY2eKB7BUaIZFq0BcGDCl9tGF5ICTJfI6r6nsiNq9
         mOCVA7o4UceCf4LFl0Krj8K8o0B36q5cCNTCfoRuOUY2Y8TQhWZ4yd4BQbnMoKM/GJA4
         eQK6gmUokc1+hVavZIkuT150NoeE9+XUOS7h93qzcBm0L8keKk2ffGG9RZoPttFVVPgV
         TMzYSil+7kb1dWHUkY6WDS2dMBueaoaZauAMR5+KiV2JDVts6cGf0LzEsj55GRAEVVJj
         uvuA==
X-Forwarded-Encrypted: i=1; AL+hErEYH0/X+3iXdFaRe288xDy2VUSi7zmxJaBcpF/fPXnS6x/TZAs8uAO6/sutX8CIoA8lwkS+QZLHEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+lpnEal8QONJGncYNkvwDX3DvxMvthbyo+BQL8gdjUBtNu3YOj
	YcsqIEMRZ0HV2i8Dnmly9a0U8UEhom2Vr5oB+urAnyb5XCl9Ggux/jUq
X-Gm-Gg: AYBFou1k9sV/QYL32WOsZbZ1ziC4IEQDtuVahKEqx5j/Z/5B0A4zsAsgcc2QC5Rt7Y1
	cpZzAP7XfWVRGnrOlcIGeZ+h/5tCdNrDqgc6Ob/0Kxf9c4p89xEloj4GtpqcS3WQdXdV60b6Deo
	1HhZV6RR6/xOPzpA/wzwb/D/7IZOgz52AmMnI+TKBDnI81+N8Y3Fa19tmEy+wCZK7dIMXaNruAp
	5X9lz7One62fhzujpv12skbGKrsqcaNF5btasYrYQ9xnrq/URSy245KhSk7jxy6OjhJ8Up2QYBe
	AOyYXFAL7YGOCUH9pUfxStCqBitMbjlUy+quJWCg9c8H9XlnU8HuBcpaWx2euoHLfby9aCL3ktc
	t9PVdkgOdUHs94lC7yPxLmZVmNmvMfbKpynssYsn3VyFsV1z8/Lo2twWQ7CanhVzCsSh0Yrxsbq
	FjPBoq7TGH7xLeE5KnKjJKu8HOQ0oHNj3LPfqi03wAy9qkU8mykWNSkcTWYaD1FTxwDgZ9vP+Id
	WK9tsggafqwsKSzNffiHMbfphvigFKi4LpKUYmngNR17IPca+sKLvQe5E856hLc77vKT+/wd4VA
	JCrWpGHZMalSLi/Oj9GCTOksqne9rY6EuDebAd31
X-Received: by 2002:a05:6a21:d82:b0:3e1:8a37:bf1e with SMTP id adf61e73a8af0-3f7aa8e5c67mr648446637.42.1794536980123;
        Thu, 12 Nov 2026 18:29:40 -0800 (PST)
Received: from fedora ([2601:600:cb86:7af0::c952])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8682sm335547b3a.10.2026.11.12.18.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:29:39 -0800 (PST)
From: Aiden Hecker <heckeraiden@gmail.com>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aiden Hecker <heckeraiden@gmail.com>
Subject: [PATCH v2 0/2] cpufreq: amd-pstate, platform/x86/amd/hfi: Enable hybrid capacity scaling & SMT ITMT ordering on Zen 5 / Zen 5c
Date: Thu, 12 Nov 2026 18:29:32 -0800
Message-ID: <20261113022934.13397-1-heckeraiden@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Hardware Observation on AMD Ryzen AI 7 350 ("Krackan Point", Family 1Ah Model 60h)
=================================================================================
On AMD Ryzen AI 7 350 (Fedora 45, Linux 7.3.3-300.fc45.x86_64 and linux-pm 7.4-rc2),
the silicon interleaves 4 Classic Zen 5 physical cores (5.09 GHz max, CPUID
0x80000026 CoreType=0 / TOPO_CPU_TYPE_PERFORMANCE, ACPI CPPC prefcore_ranking
208/202/196) and 4 Dense Zen 5c physical cores (3.51 GHz max, CoreType=1 /
TOPO_CPU_TYPE_EFFICIENCY, prefcore_ranking 135) inside a single 16 MiB L3 CCX:

  * Even CPUs (0, 2, 4, 6; SMT 8, 10, 12, 14): Classic Zen 5 (5090.9 MHz)
  * Odd CPUs  (1, 3, 5, 7; SMT 9, 11, 13, 15): Dense Zen 5c  (3506.5 MHz)

Observed Issues in Mainline Linux
---------------------------------
1. When X86_FEATURE_AMD_WORKLOAD_CLASS and CONFIG_AMD_HFI are enabled,
   amd_pstate_init_prefcore() disables amd_pstate_prefcore and delegates ITMT
   priorities to amd_hfi (`AMDI0104:00`). However, neither amd-pstate nor amd_hfi
   calls arch_enable_hybrid_capacity_scale(), arch_set_cpu_capacity(), or
   topology_set_cpu_scale(), leaving /sys/devices/system/cpu/cpu*/cpu_capacity
   and arch_scale_cpu_capacity() at a uniform 1024 across all 16 threads.
2. In drivers/platform/x86/amd/hfi/hfi.c, amd_set_hfi_ipcc_score() passes the
   class 0 IPCC score identically for primary threads and secondary SMT siblings,
   without distinguishing SMT secondaries via topology_sibling_cpumask().

Measured Impact on Real Silicon (Ryzen AI 7 350)
------------------------------------------------
- High-entropy 64 KiB pointer-chase + branch workload (450M instructions):
    * CPU  4 (Zen 5 Golden, CPPC 208):  66.69 ms
    * CPU 12 (Zen 5 Golden SMT)      :  66.09 ms
    * CPU  1 (Zen 5c Dense, CPPC 135):  95.18 ms (+42.7% latency penalty)
- 16-thread mixed desktop/audio contention benchmark (2 critical + 6 worker
  + 8 background cruncher threads):
    * Unfenced equal-capacity placement: 75.77 ms avg | 109.22 ms worst-tail
    * Hybrid core partitioning:          34.66 ms avg |  39.42 ms worst-tail

Changes in v2
-------------
- Rebased cleanly onto rafael/linux-pm.git (v7.4-rc2) and generated with git
  format-patch; full `bzImage` + modules + `W=1 KCFLAGS="-Werror"` build-tested
  and verified `0 errors, 0 warnings, 0 checks` with `scripts/checkpatch.pl --strict`.
- Patch 1/2 (`drivers/cpufreq/amd-pstate.c`):
  * Uses x86 `arch_enable_hybrid_capacity_scale()`, `arch_set_cpu_capacity()`,
    `topology_set_cpu_scale()`, and workqueue-deferred `rebuild_sched_domains()`
    rather than writing generic `cpu_scale` directly.
  * Synchronizes SMT sibling capacities via `topology_sibling_cpumask()` so
    `SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY` warnings never trigger in
    `kernel/sched/topology.c`.
  * Removes hardcoded CPU index checks and boot-order `num_online_cpus()` races.
- Patch 2/2 (`drivers/platform/x86/amd/hfi/hfi.c`):
  * Scales secondary SMT sibling ITMT priorities (7/8 of primary IPCC score) via
    `topology_sibling_cpumask()` when `X86_FEATURE_AMD_HTR_CORES` is set.
  * Removes unreferenced module-parameter stubs and raw per-CPU `cpuid_count()`
    loops.
- Updated recipient list using `scripts/get_maintainer.pl`.

Aiden Hecker (2):
  cpufreq: amd-pstate: Enable hybrid CPU capacity scaling on
    heterogeneous Zen CPUs
  platform/x86/amd/hfi: Rank SMT siblings below primary cores for ITMT
    packing

 drivers/cpufreq/amd-pstate.c       | 121 +++++++++++++++++++++++++++++
 drivers/platform/x86/amd/hfi/hfi.c |  18 ++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.56.1
