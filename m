Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81C4E0B67
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669273; cv=none; b=eTmz1GgzlhE6aNCbk2HlCDpJXPlcGEFrbPahRFr5ilM2bHAQYtjFEswsPcpqjVDdw+uSOnlz69pMsKWbA81aPOGEijpKXMJsohDm8SgG9PTaXqC5WUoY4lseiySMuKurf5gcz3QubI8n4VxlJjSe7GusTHyUnVA6+8QbdevGGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669273; c=relaxed/simple;
	bh=fD/FBkx1Ez1YZo9i+o4hAzLDSVkeRh7196qjRUTI+mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Siy7/fYkP/d43Zhh3O5i8gtZdjq2DIdH7mb4JXTxHa2qOBl+YMDo/eNnSM1wYxoS7/rgMpofGSbZPG2hVWtfexUTDoOGnZqms1M/Pxyq5N5qncLVPTBM4peMQg6CB4IiOtSEagA38kilaJIpoYbDXZo/RnF1P+2jQwFQGbI93pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbqcmGif; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbqcmGif"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso8670625e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789669270; x=1790274070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gUHCOX6sUXg0tUw+Jt5/2DPSL1IAFpd2jKjnoUpgn0=;
        b=DbqcmGif+2SbTCzdifVphuO+ybxkBr4cjWfzndIxbG030JhtSTzvicatomOWjlTPvh
         S+u/u5sIrRGXnyu14Ls7Px+cUnYl+tXwpgwzJeEE6FmO0mS3l14bxCTVDtZPviNSjyhZ
         0cmRVpBkFqBPU8cx+wPMlIZ/1Tc0LSI7Kua+92VJrYYlPkWUxQ7kyrrdf/uihV+Ed6GP
         MW4Kob9GEBd6LSa5BaT/VNNZdAlsz9nDQ3wd5IjY3veOAC0jOxrH4WSh+LGLJXqeGXSj
         d9oqJC/CgQB8MMUWVuEivuLfHkP9TfQ1sYTigYzftiJZu4BxCMYZfVZQirY9nOItmmru
         WdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669270; x=1790274070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gUHCOX6sUXg0tUw+Jt5/2DPSL1IAFpd2jKjnoUpgn0=;
        b=eTEnQ+qM32+yOW6yh+muqYByUd3+Oc0Mm7o02QLVj1I+5RYl9zpG3Yi56cbPPmHe0C
         Ym2oLuL3Tql9O1cQmW0mLWL5NtMhcTRHqcfEQrkVXur5Ek2Ngkk+6zUx/8+CHxP2HlJ9
         aJuhGiDFeDoTp9l71ww883a2WQNF77fiMPgvE8AU6YZONbWF7yCx0Jrf0D+6hM8oYha7
         bU8UUyHkmzfgUqRpeC9xAjT6bD3EK80C8BXsFwpxL0ualmDrQUQ8bTbJQIYakUnpne4l
         QMx8A6NaUFoweGrqGMjyjyj6hVa8LyciiMy4iK267BO4bFq9E1ej2+PjjWSBcMKyQyot
         djVw==
X-Forwarded-Encrypted: i=1; AKwUvBwE9MplmDPgt4pTV2NMurt+bEwT2KrNtLxlj2WUQcJbJlY/gti76n+oOv9FD3WBDsafcUJ2au+fCA==@vger.kernel.org
X-Gm-Message-State: AFuF++mbJ3xqQXrlsIlcnkiBjT/ftVPqE1GHdu0CEHzznUueknVek1DK
	csj46W8ZBS8KaznjnqDw0iF/1r4CMawjxj2NplF3jefvXWaE97234xh0
X-Gm-Gg: AYBFou0QkJ5TtFKCz1Wj5F+gzxFjR6UfltP1X+TDvYk+JQVed2s3UThv22EiZ6HVZzf
	t9SAFFth6FVw+s/nnLTiT9jpDQJ5yh4d0TctR6pztW2Htzd0lwmXNXt9BnietTy0761tHfgYORd
	8+LMX7Br0zwdW1UquRfXzB0dTLRFtcAv6Wlh5djgpkUPkv7T7/bjO2yOY5RzX+jLKYxdZM2u76e
	DvGwYtDBPvcH11Dt7x6yk7C9E+pNGCJHKke60R8vYfOFnYJQSuvRs3trxxw/VVjw3T2wRrUECG2
	2XZmzzcwOYwPBvgoOyFay47nj6qN93tzxD9WMdaFK6uwl6DXUtOz1AS0xi5zZjjqauocO3csitR
	H+9i3cltzewBaEzt+SvBPH9vUadNMn/ot7ElftrKZ9vKDfirvPTnFeIAE7iUnTjYEgR/0HeeRsz
	WZqiROqyXd/78A1Klovd3AfVAOqCtfOAz667Qeu7J6CGoG5YLEy8nhA+YeIpg8n/FKZN7LzI61K
	ejK3TAa
X-Received: by 2002:a05:600c:1f87:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49ead86eb54mr92023815e9.11.1789669269234;
        Thu, 17 Sep 2026 11:21:09 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fbd225898sm101433835e9.9.2026.09.17.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:21:08 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v5] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 17 Sep 2026 20:20:59 +0200
Message-ID: <20260917182059.2851-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_freq_get_on_cpu() computes the product of the frequency scale and
the reference frequency as a u64, but assigns it to an unsigned int
before shifting it back down:

	freq = scale * arch_scale_freq_ref(cpu);
	freq >>= SCHED_CAPACITY_SHIFT;

The product is truncated to 32 bits before the shift, so the result
wraps once arch_scale_freq_ref() exceeds 2^32 / SCHED_CAPACITY_SCALE,
i.e. 4194304 kHz.

On a Snapdragon X2 Elite (Glymur) laptop, whose boost OPP is 4723200
kHz, cpuinfo_avg_freq reports 524283 kHz instead of ~4723200 kHz while
the CPU demonstrably runs at the boost frequency: a fixed workload
completes in 1.72 s at the 4723200 kHz OPP versus 2.01 s at 4032000
kHz, matching the 1.171 frequency ratio.

Compute it with cap_scale(), turned into a static inline taking u64 and
moved to <linux/sched/topology.h> so it is usable outside kernel/sched.

Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
Changes in v5:
- cap_scale() becomes a static inline taking u64 arguments instead of
  a macro, as Dietmar proposed and Peter agreed, after Peter pointed out
  that the macro relies on one operand being u64.  It now lives in
  <linux/sched/topology.h>, where SCHED_CAPACITY_SHIFT is visible,
  rather than <linux/topology.h>.
- Patch 2/2 of v4 is dropped: it duplicated Ananthu C V's series [1],
  which I tested instead.  This fix is needed with that series, since
  it puts the reference above 4194304 kHz from boot.
- v4: https://lore.kernel.org/all/20260917125112.2283-1-okerixx@gmail.com/

[1] https://lore.kernel.org/all/20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com/

 arch/arm64/kernel/topology.c   | 6 ++----
 include/linux/sched/topology.h | 5 +++++
 kernel/sched/sched.h           | 2 --
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index d28438f8b83f..39dd7f8575cd 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/topology.h>
 #include <linux/xarray.h>
 
 #include <asm/cpu.h>
@@ -186,7 +187,6 @@ int arch_freq_get_on_cpu(int cpu)
 	struct amu_cntr_sample *amu_sample;
 	unsigned int start_cpu = cpu;
 	unsigned long last_update;
-	unsigned int freq = 0;
 	u64 scale;
 
 	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
@@ -245,9 +245,7 @@ int arch_freq_get_on_cpu(int cpu)
 	 * (see amu_scale_freq_tick for details)
 	 */
 	scale = arch_scale_freq_capacity(cpu);
-	freq = scale * arch_scale_freq_ref(cpu);
-	freq >>= SCHED_CAPACITY_SHIFT;
-	return freq;
+	return cap_scale(arch_scale_freq_ref(cpu), scale);
 }
 
 static void amu_fie_setup(const struct cpumask *cpus)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b5d9d7c2b8ad..922b2f015e89 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -234,6 +234,11 @@ static inline void rebuild_sched_domains_energy(void)
 }
 #endif
 
+static inline u64 cap_scale(u64 value, u64 scale)
+{
+	return value * scale >> SCHED_CAPACITY_SHIFT;
+}
+
 #ifndef arch_scale_cpu_capacity
 /**
  * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c3ad70e58b8..45796fccdc84 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -236,8 +236,6 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
-#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
-
 static inline void update_avg(u64 *avg, u64 sample)
 {
 	s64 diff = sample - *avg;

base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
-- 
2.55.0

