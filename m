Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43A4EC640
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649502; cv=none; b=BaWB/z6xFKOGhMdybfnoc4jX2sYCJCtTXDCncAYAMu04CdhaEsochETpQjLZ3UVNWG+aw12O04CFQ+B1bQhZkeTl2unMdW3Z1HgBj0bxytJmuJb5lKi1x755oTn8dbnb0VfO/jjVEbYS3t8+8FsaqVl9z6OzMxo3kDtrjNqzstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649502; c=relaxed/simple;
	bh=EdyvNUGzZQfOCichJt6a2G8qG+Z+dq696yNIz94RDV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYKzFCnLqab2AdgMoGIyF8obYFHIy3lV/nMH7k8TjX3hNwNeobNw23AY5qFNpATYgppTOgyijWpe1QaVI3xPNPMaODhSZuUDGzGh/ui4At6RCitdVgSH9Zu1rGfFiVh7+WwWxaFzLrqgh0GPGb7NZU//vnJTWcZrdTLFSDp2wys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxOnDJqZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxOnDJqZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so4225415e9.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789649484; x=1790254284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuwmjuHNbGK5+6CI3MWKqt2Q2NhbCap9Z5LDmt81Ho8=;
        b=lxOnDJqZWJQ6rUn3e8fZTgqNyRiIZadguNCaYIQZdw9XJnL6c3wGngXimE3m9TvTqu
         Q89Gdbail7OHKTjI5eMDDOPOVbhlzFpDQz54d5VPPx1iBWbnBOBV7c5rpu/8fkCT8tC9
         LtWcbI0ZEw43F2kX5OXG8o/NpLDX54bCQM64nCBOMNuaFEnEDaDIzqVH7zMMho3dkGH2
         C8npca9FkmH3cMfaYbgVW8WALx3KjHAvWhqEp9LevTtYn40ZJsTeHMt1BSkVq4newc6b
         tw+vrSw6Aagu+urT8vYSEKZf/j9Hg+xNGBEDCrmA/qftUt8jVNOgaHG3pjykUrhhKR9Y
         tocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649484; x=1790254284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuwmjuHNbGK5+6CI3MWKqt2Q2NhbCap9Z5LDmt81Ho8=;
        b=zJwbsWjddX6FuQH0it+54pCcfVEhn5bp8+R7W9Din4oksWijx618NzsJFiG5K97o8P
         I+JpGsXqKaKSo+xcUQoFyPvQI4wNE5fUR6xy1y+uObFYL4L+0Oa3ll8TeTuZYAxEmxqj
         smUMYywYQ4rqc8rgOLJRg3A+364aUZKEY1dw7rMKXhTuSifpaLwpfod/Qtg6/bcT/Mrl
         +ncaSpF1NPToZ0CXpd32GwBPoJCXCO9pvpXQbaVHVH3Ac8fFO8nSChJDO2yKJvNNR9fU
         xb6VCvmeZ3AlUdd3IOITg1n0mM3xFGI+bzjXfrHUVnuMSLVh9MGqU1f6mHER9hvM6tXH
         ir5g==
X-Forwarded-Encrypted: i=1; AKwUvBx03xytKUKJ78bMZQs2COXMyashqyRu9o1scaI+fgtl2m7g+gtAQ2fcQKbd6VPDTG1x1RLX4mnD4A==@vger.kernel.org
X-Gm-Message-State: AFuF++mWbznBjuH1YEyn7duAGncs+iWd3YQJxkQKJC1gDMU2zmcnpJGB
	y1r/2x13lP7tCJqKTflW8d/wa8fF4f6Y6oybFpGu9xsnd7Tj2OSDzgMh
X-Gm-Gg: AYBFou0w6ycwV3YmQuufaSOVsBt9aqgfCyn65vRIO/VI/56wqnOkAEGmQN2Kolwd99y
	CR3boofjjNvwak+Cq/QQIgx3nElhpYhorwnKKM87iGOmABQ5JpWZuiXKGAO7CUwXZK8DisZWanD
	7azvMpGCEePeEp1pYhqrpodv7YbxbUOvdn3mQI/SQYTKMByw9FuKfwu3fyFfJoQ3BsiOp6t+j3z
	CznImbuA0EgyhaLOyhlvHilyOcvs0s+zOrFTTi2WTp6OFc32FvfZ+sJ4lk1nDEwaw3mzCjvG6kL
	1iheJKI2efDm8w+p6hgiH0tXET4/vmNWmZ3CU158MkecE563ksmn3rPkA9N4saljaTjCEpByxpK
	30XvO65v9mTF7u+GIaPLOARCFTtyztF4dDqv4NWTXMOu/fwzENfjtmzxWZY++lut1uABlAEQ+/C
	PDArvAJfLWY+eIeSjbHOViHvzRKpjcY2XnCJ42+4j+2BtKUT94q4tyyBZ75DAffqAj+XWU6pUen
	kr663H6
X-Received: by 2002:a05:600d:4442:10b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-49fbd1e4f0amr32449375e9.13.1789649484234;
        Thu, 17 Sep 2026 05:51:24 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fbd204d89sm86555015e9.3.2026.09.17.05.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:51:23 -0700 (PDT)
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
Subject: [PATCH v4 2/2] arch_topology: use the boost frequencies for capacity_freq_ref
Date: Thu, 17 Sep 2026 14:51:12 +0200
Message-ID: <20260917125112.2283-3-okerixx@gmail.com>
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

capacity_freq_ref is latched from policy->cpuinfo.max_freq by
init_cpu_capacity_callback() on CPUFREQ_CREATE_POLICY.
cpufreq_frequency_table_cpuinfo() excludes CPUFREQ_BOOST_FREQ entries
while boost is disabled, so on a system that boots with boost off the
reference is the non-boost maximum and stays there.

Once boost is enabled the CPU runs above its reference.  On arm64, where
the AMU drives frequency invariance, amu_scale_freq_tick() caps the scale
at SCHED_CAPACITY_SCALE, so the scheduler cannot tell a boosted CPU from
one at the sustained maximum, and arch_freq_get_on_cpu() cannot report
above the reference, so cpuinfo_avg_freq is pinned to it.

CPPC based systems do not have the problem: their reference comes from
highest_perf, and a disabled boost shows up as cpufreq pressure.  Do the
same for frequency table drivers and take the highest valid table entry,
boost entries included, as the reference.  With boost off
cpufreq_update_pressure() then reports the difference as pressure.

On a Snapdragon X2 Elite (Glymur) laptop with a 4032000 kHz sustained
and a 4723200 kHz boost OPP this moves the reference of the big cores
from 4032000 to 4723200 kHz.

Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/base/arch_topology.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..300f64ffea2f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -386,6 +386,20 @@ static cpumask_var_t cpus_to_visit;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
+static unsigned int topology_policy_max_freq(struct cpufreq_policy *policy)
+{
+	unsigned int max_freq = policy->cpuinfo.max_freq;
+	struct cpufreq_frequency_table *pos;
+
+	if (!policy->freq_table)
+		return max_freq;
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table)
+		max_freq = max(max_freq, pos->frequency);
+
+	return max_freq;
+}
+
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
@@ -404,7 +418,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
+		per_cpu(capacity_freq_ref, cpu) = topology_policy_max_freq(policy);
 		freq_inv_set_max_ratio(cpu,
 				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
 	}
-- 
2.55.0

