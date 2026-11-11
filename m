Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387040;
	b=1Fui9v5TpEInjcCiUbgYhovHYeccb3ehycVMteWR5BxahCd/M8+nd7WPZwFppqwslfhe
	 UMG+dHkqlmcNShyYO6XR0Y9jBqvDZNPBBPP1rpP6I59C1SIYIf9SpLjp2/6lkBk4yARrJ
	 FsqlkjEWNH62vHYx4zwPO0Hoc/4B/5ORcIjzSt6W5HSr4teyVcYHZgRGXlxzu0JgI2YvV
	 gs+jCQ0Ma9H/qTpVBrYdT7UstvqyACwEb/mNR8sePnfDNZUBJj3wyaMzoxY4BVuvKW56A
	 WueiIbUh+LAfoucp15ZDij8d7Y1cIldIVB43/QgvzYihwxiHQGr+cMcASsoBNK1YGJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387040;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
	b=DiCFLjMF8lQG8w163T/YwE2feBVCiC5O3HFr+DFseebgFaxWkXyTyacnAz8DfwzuJ6hb
	 mmXJ/JjjSHczRbvEIla5LW1sh6SFctA/jQOHWDr4H06xFV9yI+LHWa0NIpv9mdqBHWrae
	 z/iJAVvdjEYm2w+3/FnbqZp0iFkprlOUMdkNsrNBjzlMbMw6DQrxnSugDLTmnKRR37MSv
	 GR4NxN+pw5CkjMmg/i0cw9Urv/CE2c+tvTFam8C5xNPh7OB3sp5DyfQcoDkW+VjhprZeQ
	 TAACx21NDpiQNGbg9Adnav5DrM/XJFaiJC8BvFMdpqjSHVFzLKsncpFGhSKUCNVFSyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D392606A321
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D392606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b0d11b85f0so1780670a91.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387039; x=1794991839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCRooG2x6MjJhhdGz/yUbWYEgmkxtWTULJ4B2gjVcXc=;
        b=mxTpAKrR0RtFCohf+wkl0wf+q9ipwXHQmFeKXbDp+KPgX3TSp60i243H7t1sGkaL5u
         gDlKN2fy4JeFeHuuCKhxH6sq5Uq0Em5zvj8MeRD07nSCXiLoNLtJxUHwai9kwecKwcsc
         0o18is6L4ZhvcrrinvaAOeNDvEOM1XkITplcOPNBUwmXm4sInF1mwvoaDzIDeai5BVk2
         MYBHDBN2zredSLKQHBKS2DnO0aKhZGYDh+AmCZgZzd6EYbxoVWjORcWU3QoJrwoSqRUC
         qFl9t/gAmu01xdKvEndBkuBRKHBuWlPVf/Prhkd6eNIXUzEA4059qSel6LmZsi0/Nvft
         XpKw==
X-Forwarded-Encrypted: i=1; AL+hErFhDXFUHCXZPFvgEkApyuIsGLzy59Pg4Ktg3nxEPFU/K9QvfS51Ni/HP/+c+/H0OLK2SY+ekQPxtw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/madRGUCI+yaV/DlF2bYaW5SyWA8RfvPm83rXfyz3s+6IvBKDs
	p8gTq/cSWPdxFejHDywS7I8r4p5x50QNykTYdkq/7lWJGofwcEQz+fgn
X-Gm-Gg: AYBFou0HfR/qTIz39vZbxKJq0lxSDY31S2fQHrlMcrAV9Lx/zxqW2A37AYKN+X1R6/n
	gkyWiNZ3s+nK6pmOWN1bIH0BpJIMoBnmdv4ij3IenTUqKWEDlMuYznoiUCRRsGV/HRGLCdgCZW4
	C4BbiSp77NPDwnMgPg3x/dWhzJLGN0KfLDl0v7Rorb+cJOnQIu7Ux681VjuikPp1bDfpVIfKkpj
	vdvaN10ykG4ilSY0hGvkmmkFXb9slzdSW9yYdKB/hEpTQD9NNr7qnyhxe9A8R3TwklP4XQqNuw5
	3oO7KJMALXRFkyNWamkXX93iXFoq9qbASw6icXIrs3icPCuaeKg6ilFhnqbNAEkIdk3jX52RVrU
	9WO9uTITtMOSci+F7apmWrqko2I587g2hK7mCQuAldBy0m6PcqqaWtc+2vq/8bYwSsc/ehbvJv6
	tn62DyMffetIKfr1zzgWrgy4CFxPH/2+6ljnj/AGZE+u3WHBK01yIXOuKEz4iIZ0PPxH/npmS0O
	KOxsd7TWLsh3E21AAS3kfuQX+BHb+f9a6l3zfvRChk5wU/JMr4GjcBa+BYVaUZ07Z/88owF0DYI
	VSE1B6qOwbjeYtL8AIKGeWhS789Z4Rsj5ZMWaoqGtwqOc20guKQ=
X-Received: by 2002:a17:90b:4fd0:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b182eee784mr1752558a91.33.1794387039460;
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:50:39 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 0/3] cpufreq: cppc: Handle Highest Performance changes at runtime
Date: Wed, 11 Nov 2026 16:50:19 +0800
Message-ID: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

Hi Rafael, Pierre, Christian, Jie,

This series adds support for handling ACPI CPPC Highest Performance
register changes at runtime, triggered by Notify(0x85) on a processor
device. When the platform changes the Highest Performance value, the
OSPM must re-evaluate the cached capability and propagate the change
to the cpufreq policy, the scheduler's CPU capacity model, and the
frequency invariance engine.

Concrete use cases discussed during review of the previous versions:

- A processor can age over time and its core frequency degrades. It
  is good if platforms can make OSPM and userspace aware of this
  (Jie, Christian).

- Platform operating mode changes between "performance" and
  "powersave" (longer battery life) when the top-most OPP is a
  high-cost one (Rafael).

The mode-switch use case can also move Highest Performance back up,
e.g. when switching from powersave back to performance. update_limits
therefore accepts changes in both directions, capped at the Highest
Performance probed at policy init, as proposed by Christian: any
value above the first probe is ignored, since it would allow boost
support to appear after policy init, which the cpufreq core cannot
handle today (the boost QoS request is only created at policy init).
A policy that started without boost cannot gain it at runtime;
supporting that would need runtime QoS request creation in the core
and is left for later.

v5 -> v6:

- Cap runtime Highest Performance changes at the value probed at
  policy init (Christian): any value above the first probe is
  ignored, since it would allow boost support to appear after policy
  init, which the cpufreq core cannot handle today (the boost QoS
  request is only created at policy init). Within that bound both
  decreases and increases are accepted, so a platform switching back
  to a performance mode restores the previous Highest Performance
  (Rafael's mode-switch use case).

- Refresh the topology capacity for every CPU of the policy
  (policy->related_cpus, covering offline CPUs of the domain as
  well) instead of only policy->cpu, so a shared-policy Notify(0x85)
  targeting any CPU of the policy refreshes the whole domain at
  once (Christian).

- Trim the internal helper comments (cppc_cpufreq_sync_boost_limits(),
  cppc_cpufreq_set_autonomous_perf()) down to the essential notes,
  drop the debug-only value dump, and report boost QoS sync failures
  through pr_err (Jie).

- Ignore values that would drop Highest Performance below Nominal:
  they violate the CPPC invariant and cannot be handled cleanly, so
  the special-casing for them is gone; such
  values are now warned about (Jie).
  topology_update_cpu_capacity() rejects such values as well, to
  match the boot-time validation.

- Return early from cppc_cpufreq_update_limits() when the policy is
  inactive: a concurrent CPU offline may have freed the driver data
  after cpufreq_update_limits() acquired the policy reference.

Note: proposed spec extensions would allow nominal_perf to change
at runtime [1] and introduce a highest_freq value; neither is
handled here.

[1] https://lore.kernel.org/all/20260430142430.755437-3-sumitg@nvidia.com/

The series is split into three patches:
  Patch 1: Core update_limits callback with boost QoS handling;
           runtime changes capped at the boot-probed value.
  Patch 2: Refactor autonomous perf bounds into a reusable helper
           and wire it into update_limits with error logging.
  Patch 3: Topology subsystem runtime capacity updates with
           validation, early-return optimization, and concurrent-safe
           normalization for all CPUs of the policy.

The v5 series was tested on an arm64 8-core big.LITTLE system with runtime
highest_perf changes injected through a debugfs hook that exercises
the same code path as ACPI Notify(0x85), including values above
1024 and full capacity re-normalization (see the v5 discussion for
the measured capacities).

Xueqin Luo (3):
  cpufreq: cppc: Add update_limits support for Highest Performance
    changes
  cpufreq: cppc: Refactor autonomous perf bounds into helper
  arch_topology: Add topology_update_cpu_capacity() for runtime updates

 drivers/base/arch_topology.c   |  77 ++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 157 ++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h       |   1 +
 include/linux/arch_topology.h  |  13 +++
 4 files changed, 235 insertions(+), 13 deletions(-)

Cc: Ionela Voinescu <ionela.voinescu@arm.com>

-- 
2.43.0
