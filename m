Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF243630A4
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647347; cv=none; b=NpYoXlFmQfjSVYtnt+DZ6i6NN42GhF6wTzJ6HGZohBdO2lEhaEzqPQlh8LHia/l7dh9sARWF+4/UdPXippODkegmAfg3OE69S2oOeTbsTc27u3r66i0m78wOFr/RsAXbONElUJWfrFVujlegz7bUi1JBaay0I5ZM1z5zxRlgjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647347; c=relaxed/simple;
	bh=oULNC3UZCvjN2UcusK8Nb9sPh9TgG408pjBtAGXwaIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKQ9c+mCAVhploJ5ySUDFmTBCWW9J/NdmKmR3MFxITXlHmrLcdysc03MUmqPsw8Sp6OYSfXc63x4DPYhN/GGj1Yxy4SOTol1dVpf1aC7NB005OoNHS2yPOPoQcZpelJuNYPa3k41fAujMvWoG1QOWs3vmEN4atglKhjT6GRE9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso2928694a12.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 21:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647345; x=1779252145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUZqKHflH2DuRsg4tco5F2JeMX5q65irGwlJ5N7+VuA=;
        b=itUr2TcRWPxhgkgf61T4kZv7yyaLh2e7IODEEfgacSCcsz6jE6aKtB7Tc2tMBnWcpB
         7DlHa///RMJaU+PwYIR+ck7jieJu5AYUlSZqD1FOEiF2c8NqIUgUkQgdHM/3wLsNgmtv
         l8DTtRnS5xj4Uq3kB7fXIUllT6UGK+YQOfFSYmkOEaBdQf7VLZC/Vu161GoqHRlk8463
         8tlRP0INCfN+Co1/IJTmkLz0A6CbJqPPXiou/4MXC9RlJdGQKNEHhvly4okusY2HCLzm
         ZmKiX1PVydtQ25w5v3TxgWoO4BuVhS6ZhiRJzbDa6f5LCR4Ohiy3sP00bYfSIqTzekjp
         vQAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hdMpmxceMsogn80zAcVtrTXMS6NJQxLDPcW6makzTYEAnpYush4xqYoR7iMk438xj9dtRKU+rRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhcwoB6XMw3/KK7H3O7wd/cAOP31/Ry7tEns92g+QAn0y195t
	dwxJrvtMoynz/uhHXRIN7U5wdBE2vZrSIHEbZyUtQbTaAJuuB2iTYSxb
X-Gm-Gg: Acq92OHe+s20ttTqFkH77x7MoBe1SSdmHDv3MakVJxOpbhK8XZPhFBDFAB2QVxM63jD
	9dURQ+11x5wDGzY+TRO8APdmujPM+EOv+B1LsEm1Qm5Pv4jD2qWEKkgOR3lIu3jusUHDuasdQ0J
	wGNnr50P6hFGw5qUfeNLScuPVM9AVdhuQ8WXbLlt5vAoC+ZKYG8nAnU9+DtxRxIkGVpJ7awhs6s
	uEQKZTasxpSWAiaDNHM4VIhHUfe+b8u8JeBa3GrBtvYzI9a92qWktFs0v2UQ++ZAIeeDue3dilD
	Dng9NfVTyES+co4dPiqH4pJe33v+e/A+n3fy98y/+W71vQS2rJ0Q4eY3YkSI4wSACcJCmVcOJ9l
	NF+QrVAwI+xE2+lP0Xyb/EX/wxGm1fITNccGub9rSK9/DuO3xC9tgWq/Gf4FhftUJfnL2ZzGIMA
	hBHJFUhY3Yxe9LAaUfy5Mt0AZKSbOlUb9jbqfjRagC+/3B
X-Received: by 2002:a05:6a21:107:b0:3a1:1120:796e with SMTP id adf61e73a8af0-3af8187657emr1851509637.41.1778647344746;
        Tue, 12 May 2026 21:42:24 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267711513sm13445457a12.16.2026.05.12.21.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:42:24 -0700 (PDT)
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
Subject: [PATCH v4] cpufreq: cppc: mask Desired_Excursion when autonomous selection is enabled
Date: Wed, 13 May 2026 12:42:08 +0800
Message-ID: <20260513044208.161607-1-luoxueqin@kylinos.cn>
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
---
v3 -> v4:
 - Address Sumit Gupta's review comments by reordering the
   error check and simplifying auto_sel handling in the
   perf_limited getter
---
 drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..d2f86df06129 100644
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
+		return 0;
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

