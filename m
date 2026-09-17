Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EE503BD9
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649505; cv=none; b=sF0KbGPxJyFXlas2m9k5+8LmQXh6LGKSjJrI6UqWS0qi3HfHH5jaLAArIwkHckaVQNpa9Mc4F0g5MIiB+woFJOuR5xndiwqrfrCaGpEDq8fVVud3d6vqE6MDgg7z8TL0Q0B2VQLJSuV9fH7W6jIHgI2zLvhQ0hvCAe6talACg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649505; c=relaxed/simple;
	bh=9OmuWBvelp9lDciabV7GiixARHZSbiIlS541rWDiTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCJQ4COMtGR9v4zPa1y98a2CONXYbk+hc6zheuum4J7asePvSvdn2Fk/21UKDn4YRotoGXu4ksP0JhpFuL5Y/GYNgsqhuSWBGXc+mE4oOEyqUBLSFfwhyshvCNdML34wNg8IecwYtCe05/XmeSYWJAiw1QcxJ9aFpjsQRCsUGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKMaJNC3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKMaJNC3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso7570615e9.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789649483; x=1790254283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsBJ75Nos/JKeIDPM3xGBy+cj9I+X9kBPg+21akMtHI=;
        b=KKMaJNC3+nMMzTXrk0Voqe2C5agN2WlPyUOLErXVRdqxyTS9n8RgiDXAWxq7XE8VD9
         NOGncy26u5LOKxKpXD95GzRkhW2IC4TcKFIRAR5o2DFvXmoclk5uaqfSgQJTWb7/Am74
         uXAcgBZqb4e7mLA3HCnaW44ms1t7WMILYFLDC5I+BF9l0fJOBKzhBlRE2peHYtypaw9G
         s1KzvZ3KDGLS/PajzTZYD9iIbs7EsQKQRh/+7MRD4xYzJyzDiPJID3O2RPmM1XzJ/7M0
         k0+7oGYBxqCEMfLZG6s7qfFAzXLKOQymFGQ+dstAdmSk7Uzr0gJA19/oUulqW/+KlgT9
         Eqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649483; x=1790254283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsBJ75Nos/JKeIDPM3xGBy+cj9I+X9kBPg+21akMtHI=;
        b=Ug89PYiv/R2O5wNkQD036yKjJSSiSGzXRos2advJr2jGcV+RgQVUhkzX5R4icoxlEH
         dU1zuKJ72rJVZLI+TEdSH/7lrk2LfB7FcN33Jur9nes/siQPQVHoo5YQ+P5o+JjQe5u2
         pAymHPihw2H55u978SljdDV5gyt9Qxh1MoS3XN6zuctVqg7stxMjPTLJXPTumWz9aupu
         6jkS0jKk/NXI+z8g9MTdVNSf/tFsLnsWOqDY8ymMewcJNlCa9z9QQsKd8oMiDI261g5L
         znkNJSKRkS6Y+DmYkTWHy6du8U8FAC67dlcxry1hRoesdSiWYg8qWDuSNdRCPs/OQDbs
         tdcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDBvXLTrk2X/eID7fifVc8okxWVDgqrWIPVo+KT87dOsCLA9qDrGLgX5jTONR8dP5Z9vAx2TU0Fg==@vger.kernel.org
X-Gm-Message-State: AFuF++nje5GywE2hnD6y2hZ9zPH6mIFUVQQvmJbh5AbrLH9AK9RxfA3v
	NMP937Zek3ILZQx1nmV+7eobJAK9loAynuLP49Q1pRo7AHwlK7tI1csz
X-Gm-Gg: AYBFou2FrS+y/4Zseyu7aRin4REotrOCma8PNzVPa0II9O/NgTi2wHBp4hvwOh2UurG
	YNY1dxE+abV7VghSL6uobTSjSkHeICrOcRqlzjbAizZB1Ipg1RDWG9dQaN8m0/GlSoJWIYMKGEC
	qTTWfOVIq9F71CFRu7TqKs/p9NbuHy33HNTS/rKviYNbpbBjKrMeivhuzUuVg87ZziNuRdK3fp2
	tawNegebXTMkorYSvbNWBYQMHnDKnl+Kp2HFtuX+PdQla4mQ+I85j6lWkvOoPb43UiKESoRQ/0M
	OaByE9fvOrTYdxiYItKts5XylzKLMf8OUmlcKhteI615skPcRjOCFEVaY2aEslG2FWN6kW4rthP
	G0Ay/NMPgZX/nwrzh2QNgJGJz4r95XkyHlOPxYMl6J05K8P6Gbyhy8ASAPVM9OveAe5Tw5hc3gi
	c8Sw6jwF4Y1oiE8iR1d9zSr3MFQs9jS8mXU9Y/ENxV0T3BuzX7tzntZHrmuCqUEqx0mfm20nCUL
	J2+952w
X-Received: by 2002:a05:600c:83c9:b0:49e:7caa:e7b2 with SMTP id 5b1f17b1804b1-49eb733800amr66060375e9.29.1789649483005;
        Thu, 17 Sep 2026 05:51:23 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm86555015e9.3.2026.09.17.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:51:22 -0700 (PDT)
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
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/2] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 17 Sep 2026 14:51:11 +0200
Message-ID: <20260917125112.2283-2-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917125112.2283-1-okerixx@gmail.com>
References: <20260917125112.2283-1-okerixx@gmail.com>
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

Use cap_scale(), which the scheduler already has for exactly this
capacity scaling, so the multiply and the shift stay in 64 bits and
only the final value is narrowed by the return type. Move the macro
from the scheduler's private header to <linux/topology.h> so it can be
used outside kernel/sched.

Fixes: 16d1e27475f6 ("arm64: Provide an AMU-based version of arch_freq_get_on_cpu")
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 arch/arm64/kernel/topology.c | 5 +----
 include/linux/topology.h     | 2 ++
 kernel/sched/sched.h         | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index d28438f8b83f..07b8c497c9e6 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -186,7 +186,6 @@ int arch_freq_get_on_cpu(int cpu)
 	struct amu_cntr_sample *amu_sample;
 	unsigned int start_cpu = cpu;
 	unsigned long last_update;
-	unsigned int freq = 0;
 	u64 scale;
 
 	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
@@ -245,9 +244,7 @@ int arch_freq_get_on_cpu(int cpu)
 	 * (see amu_scale_freq_tick for details)
 	 */
 	scale = arch_scale_freq_capacity(cpu);
-	freq = scale * arch_scale_freq_ref(cpu);
-	freq >>= SCHED_CAPACITY_SHIFT;
-	return freq;
+	return cap_scale(arch_scale_freq_ref(cpu), scale);
 }
 
 static void amu_fie_setup(const struct cpumask *cpus)
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 709a2dcf4c73..0a4ee12a98d5 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -351,4 +351,6 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+#define cap_scale(v, s)		((v)*(s) >> SCHED_CAPACITY_SHIFT)
+
 #endif /* _LINUX_TOPOLOGY_H */
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
-- 
2.55.0

