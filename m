Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA603126DA
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812975; cv=none; b=iL9PK8q19ttPpPfzFbWJcQmW/mL5jTzS3bQnS8AMDXCGqSgjCW2nQdiAtVWkh6d9pA3o6OMsktr8sOlOkGS4i9u4wd3cO6WfTZgKuQc0dOcPFJez3WbXQQc3b8w8/PNkq5g4OX014/Zpg2OE9FNQ9JBTU/ECzgBGuftWAljJ+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812975; c=relaxed/simple;
	bh=wrIY+8IUZxwfG31GnEdEN73Bq00TYFrEyY3K9wmYU38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5rVxcXReQtcLSddVlaGD2HTwxc6Z+c2PWlC/AvS8b5LDaUjjqmnBYQTSsy2n6d7vMFsV75QarLoFYC8p3OfunTNpybde9DMjs7MeXnUiUooiDaZihnq7OGEMY5u48qKSbPuwtVtQfC5SaoziYycj/gzt+60P05iXngXfjG/kVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso85516895ad.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 19:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812973; x=1779417773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Aw406Z/bDeAb/8cnQR6EZYZdQ7hDrALLaolxxatQFo=;
        b=qXWrWFwH+CwwnFq0DdvKDOaf+f4ecUzPX4BuPragEuPeUcEp1nnlpRzCNf0lvhd2D+
         rqgXdFKAQiyQLABd8iChlngBXE0Ykj0dBLSo3Pf3LYgbYQn2HMoHCtvdjwRDnJ1mEO0J
         DHTxHvFdM0i4sjIaW6MOA+5iJNNA361hQw1cI0XGdGc6gk+f/o8fXK2U55fP9lJdiwr0
         LXxL2urocnTJr3p8NedNrfy6qatUozTGj/l7H+jzDlAnD2hMad6W9O9kMfJgIJ2Cf8Hh
         XLWO0CvzzFNXSpk7thvw+d2WhAcZHxrxZa3mh4iTvaGfX7jomsGxolBOMvDSHuAzp1bh
         ej7A==
X-Forwarded-Encrypted: i=1; AFNElJ+4fkdeHhrEIYSdT64nvMrBxPBZ8WbdHOpUlSBlr/MI9egTDgMMiyutsPJxA1QxbNQOuXf0YSh0zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLHntDOag51w6jNJaYn3fh48LbAUjvPMamtaXaugdb+fLWbf3
	qH+xlzebw3dUHikTyUjgM1vedEb7KDaIKV1UXMn1gfDEcM5HZ422PsjY
X-Gm-Gg: Acq92OFaG6jzDbVCL1fFBW9gKRX7ZY6n8LwZBIuQqR+RgjYw2nasO9mSYJGpOyujbNe
	ysErkIYoHZzuntwivb4Cttf6HeOLtjHvoT7YI0NKEvDDRp1AdOWCmr9CRBmb9grHNMTJe6O7eQB
	jLFcz81TVxXezDU/MVfGrfF6t7mClWUbSz8vFcnrdoLLeKNQvOKw1eCcL5L+KUjq3bv3zOa8Q0w
	TxLjtfi14XUALsEkKEpBPyHa9PBjimZNZTqEDHqyqFHcPKAYmzmY2pjdYZcSfjwV+w+tU+SN2sk
	zENdTJi5zLYoWHEj/i/iz5dSFvXOABbd3emeHLZBY2rv1jjGt9R69W222rjcLyca8RRXUEijiHG
	kmf1yvdNFpeQUDYde6MOrwLiIpbAET3vcMyaE+ExWJsAch1VTXQvAz8a8+bhJzD1NUt81LM8K6S
	e7WoQoL5WPuqJMcl/EjjvC4TrsvDzwHC02ehVjCUImhG2V4Ht5oKh8RGk=
X-Received: by 2002:a17:902:a618:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2bd7e8bd396mr17197255ad.33.1778812972921;
        Thu, 14 May 2026 19:42:52 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd791e0b06sm17134095ad.22.2026.05.14.19.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:42:52 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5] cpufreq: cppc: mask Desired_Excursion when autonomous selection is enabled
Date: Fri, 15 May 2026 10:42:42 +0800
Message-ID: <20260515024242.14196-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the ACPI 6.6 specification, the Desired_Excursion field is not
utilized when autonomous selection is enabled. In this mode, the bit is
architecturally ignored and does not carry meaningful information.

Currently, the kernel exposes the raw Performance Limited register
value to userspace through the cpufreq sysfs interface. This may lead to
misinterpretation, as userspace may assume Desired_Excursion is valid
even when autonomous selection is active.

To provide a stable and semantically correct ABI, mask out the
Desired_Excursion bit when autonomous selection is enabled, so that
userspace does not observe undefined or misleading values.

Writes are left unchanged, as the field is architecturally ignored in
this mode and write attempts are harmless.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
---
v4 -> v5 :
 - Return -EINVAL instead of success when cpufreq policy is
  unavailable, addressing Sumit Gupta's review comments.
---
 drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..bf5175f7551c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -982,7 +982,34 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 	return count;
 }
 
-CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
+static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
+{
+	struct cpufreq_policy *policy;
+	struct cppc_cpudata *cpu_data;
+	int ret;
+
+	ret = cppc_get_perf_limited(cpu, perf_limited);
+	if (ret)
+		return ret;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return -EINVAL;
+
+	cpu_data = policy->driver_data;
+
+	/*
+	 * Desired Excursion is ignored when autonomous selection is
+	 * enabled. Clear the bit to avoid exposing meaningless state
+	 * to userspace.
+	 */
+	if (cpu_data && cpu_data->perf_ctrls.auto_sel)
+		*perf_limited &= ~CPPC_PERF_LIMITED_DESIRED_EXCURSION;
+
+	return 0;
+}
+
+CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
 			 cppc_set_perf_limited)
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
-- 
2.43.0

