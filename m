Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C03EF650
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223915; cv=none; b=pYr0kMZJzMb+qrUsQkBWGtS/SH0I98hGTLtyJE1E7y0LA6lq2OYJsS5Qhk1Zp64S7kOiTyyCrNJWBmmc35bE5hBz05xtsH6LY1hNcs6Wr8bWng9BKs9C8C8Imd7+j82wIOm+JZbWHSt7hY0ADZSHu2ohNN0i787kuhyR/if3fdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223915; c=relaxed/simple;
	bh=4xpVeItWkqudiEfHBZRIMb5QrkHqOcGxCQePYM6uO5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPKa8BkOxIuBtxKqenZs1xMcUrmVL2DttJmxEhrOBcJ/iiSd8kwv3wv/+rtzYKHjR7Vc0VpuQnX9GS6VT9hYmrOnBSAnNDtlBMBSblw+DDydQVxhf+PGXU1u0NtCw9YJ7vebNwJKnmchyqKfLif67/ahxcgFrsrjeTZy++BH/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=cfKzKkwd; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="cfKzKkwd"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1920971a34.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785223912; x=1785828712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YWNsXHIBJlqz4/+X9edyEl8bV9nFnDuY1m9HgGgtZK0=;
        b=cfKzKkwd9gDoqd68CtxTT5Bg5ugCoT8Vt9kN3Oop0rxcQXO5WVe55zvTX37Ds2WTAT
         UGZ8W+eeLluy8fosz9Q3BOPYbzGAfXz/QEtXKzNnVbE8mvII3P8nBhItjPVzfF5RTIgu
         CRPR1z7o01Kd2b5DaW8wcR5jb28QI713ZXsOO0u94608oClYzXg6RQdYU1Wk3JSM3WxW
         QtyYc7neAGb1fac3kKZdWWOB56rm8X7iKfHYCFWdXcPsPlbgQj+NecSNm9OWykQkSNJ5
         JraARUk1mQ2kGSRZyR+X6ZX8nq1Z3il72yE8HN7qAg3ZbyhvApvMr/fQqDAGKVycXL8l
         e1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785223912; x=1785828712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWNsXHIBJlqz4/+X9edyEl8bV9nFnDuY1m9HgGgtZK0=;
        b=UohDO++vp570D2KP4b0rKZgcShU692w4JkrHuWd2i2ij5H/7d2yf2FqBt6DsYir52a
         IU03McDt7m3kkUaDaelgUya87/GB9eocayjv4wDJbKMqswzNtJNEYcNAYzvBtHIkPVog
         oHEULXVq7cIFjDHtUyeXaSbs/yXfbkd13Zmjen6D8crr7rVYJkbvPprG26W8y/ycPH32
         20i51KQIZnQASPbUXQnllmvzyHPSuuIRRoP29W0ZUpVdrz02EDGXEwfCPNyvqBfpacCP
         NAUGCOfIBUvYxK+L9SNp6480Y518rRgpV4gP9jdcPtPo/yaw1PDL7iH7wav/Ed371+mJ
         wHDg==
X-Forwarded-Encrypted: i=1; AHgh+Rqlta1ADx5T5WaMYHXR97w7qYJs9XIKuulI1NkbKog8d4j7/F50EQ9NDbOJVYho2aH7+uM+7KbPMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Gx+1CSHurkDVr/mc6O9T3PvqPcLsqCvi1YT5ckcINF6aajTv
	JJWuYlcFEGVMNuGIjwW+zhpFNdWjpQtwSS/lWYBi5jzoPjaMa/kXXrwBzo7DvMlKUsOk
X-Gm-Gg: AR+sD13ImF1OzoT6JCJPy+dHS4Dn5R8CxjaeXsHJEbLlTNU1PkP8AMm71YvziSK7qWg
	PceY7sKhYgDKqtornIVonkP+GnRMJVkDBStMaDS+mFuJDiEsmvvPbFxTB7/eGhbebgGUbbVufOn
	TCVM5gJCZNItGf9pboQYHcuyY0VUwBJuLhOO87+tGF+B7orWGFNTGLnpXMcqw7S/BAs/L8JK3Pf
	xxbzLBYsQwo2UQhdXBK14XknDUftNw1J9FQB98wHoxjOYOAz5Y3XxtQffOUdA451tYcTXaNLlCV
	PkdXGByZfM1BI/wpNs66x1DX7N+ugViizrlN/7Q2dTu06paRsJUYkYeIsdiTtqOnMWmf9BFVJxS
	VVo4GBr2wxUvfGqE0JxQOejqgd3/arZX/pyM/DBy7vTaXkU7bCIloa9n41WCbMkez1pBUEvIEz/
	PVY8fp4ZheMJ++V2fHkPaRmx0rimypG2UnhVBYRA==
X-Received: by 2002:a05:6820:1886:b0:6ac:9658:b935 with SMTP id 006d021491bc7-6ac96cfc03amr754090eaf.59.1785223912575;
        Tue, 28 Jul 2026 00:31:52 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf93b43efsm6659022eaf.8.2026.07.28.00.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:31:52 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for recently-busy CPUs
Date: Tue, 28 Jul 2026 02:31:46 -0500
Message-ID: <20260728073150.54964-1-void@manifault.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In active (EPP) mode the platform autonomously picks the operating point
between min_perf and max_perf, biased by the EPP hint, and the kernel
only rewrites the CPPC request on policy or limit changes. A workload
dominated by one mostly-busy thread that takes frequent short sleeps
(common in gaming workloads, for example) can fare poorly under this
strategy. Each sleep decays the hardware's performance signal, causing
post-wakeup bursts to start at a low operating point and inflating tail
latency even though the CPU is essentially fully busy while work is
available.

As mentioned above, the motivating case here is gaming. A game's main or
render thread typically blocks briefly on a futex or a GPU fence every
frame, and the resulting frequency droop shows up directly as stale
frames and inflated frame-time percentiles.

Solving this at the cpufreq layer requires walking a fairly narrow
path. Globally forcing EPP=performance fixes the tail but burns power
on every core for every workload, which matters on handhelds where the
CPU and GPU share a power budget. Raising min_perf on the busy core
seems like the obvious surgical fix, but it pins the core at or above
nominal even during micro-idle and vsync waits. On Van Gogh (Steam
Deck) experiments that I ran, that perturbs the SMU's shared CPU/GPU
boost management enough to regress the frame-time tail relative to doing
nothing (numbers below).

This series instead adds an opt-in, per-core EPP boost. When the
epp_boost module parameter is enabled, an update-util hook samples each
core's C0 residency (delta MPERF over delta TSC) at most once every
10 ms. If a sample shows the core at least 50% busy, the EPP field of
its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
300 ms pass without another busy sample, at which point the hook
restores the request that policy management last stored in
cppc_req_cached. Both writes happen only on the busy and idle edges, so
the CPPC_REQ write rate matches that of a global EPP=performance
setting. min, max and desired perf are never touched. The mechanism is
only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
the hook does local MSR accesses from scheduler context which the
shared memory interface cannot do. It composes with dynamic_epp, which
selects the policy EPP from the platform profile and power source.
epp_boost temporarily overrides whatever policy EPP is installed and
restores it when the core goes idle.

Precedents
==========

The closest precedent is intel_pstate's hwp_boost. It has the same
overall shape as this feature. It is an opt-in update-util hook that
temporarily rewrites the HWP request from scheduler context on a boost
edge and restores the unboosted request after a hardcoded hold time
(hwp_boost_hold_time_ns). It differs in two ways, both deliberate:

1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
   that matter here are futex waits and amdgpu fence waits, which do
   not set the iowait flag, so a C0 residency trigger is used instead.
   Residency also naturally covers the "mostly busy with short gaps"
   pattern rather than only the wakeup instant.

2. Knob being boosted. hwp_boost raises the HWP min. As described
   above, a min_perf floor measurably regressed the tail on Van Gogh,
   so this feature biases only the EPP hint and leaves the platform
   free to drop the operating point during the idle portions of the
   frame.

On the thresholds themselves, the sample period, busy threshold and
decay window are hardcoded rather than exposed as tunables. I'm not sure
if this is appropriate or not, but it seemed like it followed existing
contours.

hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil's
iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
300 ms decay is sized so that a render thread which is only 50-80% busy
from periodic vsync and GPU-fence waits holds the boost across its whole
busy period at a couple of CPPC_REQ writes total, while an idle core
sheds the boost well before it can matter. The energy exposure of a wide
window is small because EPP only influences behavior in C0 and an idle
core sits in CC6 regardless. If folks want me to make these tunable I am
happy to expose them.

Testing methodology
===================

All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
mode at EPP=balance_performance, using the Civilization VI graphics
benchmark as a single-thread CPU-bound workload with a repeatable
built-in benchmark pass.

Comparisons were run as interleaved A/B tests with 6 iterations per
configuration. For each run I collected per-frame frame times and the
busy core's frequency, and derived average fps, 1%-low fps and the p99
and p999 frame-time percentiles. Deltas were evaluated with Welch's
t-test, and I report the p-values alongside the deltas below.

Results:

Default settings
----------------
The busy core's median frequency sat at 2.43 GHz despite 98%
utilization, which is the frequency droop described above.

Global EPP=performance
----------------------
Globally forcing EPP=performance lifts the median to 3.5 GHz, cuts
frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
every core and for every workload.

Raising min_perf to nominal on the busy core
--------------------------------------------
A variant of this patch that instead raised min_perf to nominal on the
busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
by perturbing the SMU boost management as described above.

epp_boost enabled
-----------------
With epp_boost enabled, the busy core running the Civ VI main thread
runs at a 3.5 GHz median and the benchmark gains 31.8% in 1%-low fps
(p=0.014) and 4.1% in frame-time p99 (p=0.015), with p999 and average
fps unchanged.

David Vernet (4):
  cpufreq/amd-pstate: Document missing kernel-doc members
  cpufreq/amd-pstate: Update cppc_req_cached before writing the MSR
  cpufreq/amd-pstate: Add per-core EPP boost for recently-busy CPUs
  Documentation: amd-pstate: Document the epp_boost parameter

 Documentation/admin-guide/pm/amd-pstate.rst |  16 ++
 drivers/cpufreq/amd-pstate.c                | 230 ++++++++++++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                |  20 +++
 3 files changed, 255 insertions(+), 11 deletions(-)


base-commit: 92bf086d086f7cfe0d6f807dfd6b8d11bc61b626
-- 
2.53.0

