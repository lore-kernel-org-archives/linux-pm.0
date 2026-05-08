Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DE37186E
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236033; cv=none; b=jVl+hykgzAcrMT0R62ieHSV9a8MS6K9YqpcTQCz0z2tHcnJFAVTFKjEO/jYbR/y/ge5NJ3e+AF7WnXv+dJe6Fe27Tx2+BaaV32FdHqM4BFSWAqf+Je4D72vcedWU3PK0CZoYltrSqH1EVgxl+eNAGH1SJUZ5DLQ+PF7US/5y1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236033; c=relaxed/simple;
	bh=0D7MRQxHEn04ATSWBkzBguDZ9exycFH13LNzkzZHI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=essJUsPsu/ehl0Mz0CG6d9Gq4a3iFmRCa2lHHvfYJrbWCHRGQLfncWTv3ZQDpIkMWMiBKMyuHu6FI4wAWUfh2i5qeHd4f3BJtSaBMoEztEDTe5P7JoZMY8BBr4dOGfVtLQBs+Q1tEKb0QpP7ocn+kESLbLCZ1wuxzUnEYCQQfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c802803ac17so807570a12.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 03:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236032; x=1778840832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnNuKtVj1c3jsevSEXyLLwmSEHEWjAVF1+jRORGv2IY=;
        b=gbTXrw5NE3dHAXbyyeCUnLbJzJYfZ0XUnonwPhAWDu+BK5kpaMx0B3ndU+5vn8YyYe
         MAZJXsMxAGFyFWUz/2SeRDikselGmtMFMN8a5NQpIluG4JBHqXEUA5xUVM21sxKyfcMg
         ofRhaiXMwaLdMcrpVqqdHKr3o1zd65027UHkezUpM+cnuWEVS0+lmpU7Yk2CZ3mWwwJa
         v0BzuCZ9WuivSVEaXoI0e4u1FKes/FU3pI0Z07y173xRk4EqdLj3wBNqRWWJqHMiPiX3
         h72fIyXqXWhU77rVjjIqs4OC+f/qI+x/DHccJh7vc1uorD56MEKC6yJyDelnWCR5KEXp
         U8tg==
X-Forwarded-Encrypted: i=1; AFNElJ8Tp3L25DGKdGtmwR8MW/k3AejaYT+xy0VlW1hxZPz5pieRX2Qlwh6oE5tBtTvE/6Pm8+AF96XLLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+a25MHUn7Vh49xGlQojZJZzI+Y/QZFI6TuiCVO9EMWxeK7ia8
	h/kireNHEzz/TnvcWobHMKZHNJQzNYKetaQw0SY+ryjHFH9iJWK5Dbg+
X-Gm-Gg: AeBDiesvY84YndXAiQuJi6QcvJxa6r5ZV+elswafzLHAqGP1u94VXXPWbkXu+5hi08X
	/THMf0L8eHpFPXYpZGdpBlCS7s9GrkFKMsqXpy3P9BNuwThHRN5kpkvwFU4kcziBb6CvFBCymUI
	GsZa3Csa9sLsak5hiVTrxB1BfnvtghMkWf/K0eRA4R4L9VNsuy+W64QbSfrnwkysbG2nLzr6uQt
	6PCj7JfbsVrAG1UeQ0/CN+7S98lgn9wum64RfA+QrwLfksl/DyJyewOpyY4MUPuLJiqHEwxzxFR
	3uKSi6jsnVbXh9/zvdMUixPQnRoD+nZ9jVuPTiZ9vPiPXjerqhn/hGMNSLtjC5yvoiXLA4PeY5j
	Z2AknUqbYsqEVr+t/NaL3GfmITwz7TcI6sLE6xSc68fBmOHS+LqV2I3iHXnnb1PVtAw0/225RYM
	zJVyroVmj4IIs/diH/7pqMpeHhs/h759IhQnIc2AMXTDPd6A==
X-Received: by 2002:a05:6a20:7f8d:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3aa5ac62b2bmr12200186637.44.1778236031661;
        Fri, 08 May 2026 03:27:11 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c00sm11021319b3a.32.2026.05.08.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:27:11 -0700 (PDT)
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
Subject: [PATCH 2/2] cpufreq: cppc: Add update_limits support for Highest Performance changes
Date: Fri,  8 May 2026 18:26:48 +0800
Message-ID: <20260508102648.142688-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508102648.142688-1-luoxueqin@kylinos.cn>
References: <20260508102648.142688-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI CPPC specification requires OSPM to re-evaluate the Highest
Performance register when Notify(0x85) is received for a processor
device.

Implement cppc_cpufreq_update_limits() to refresh the cached
highest_perf capability through cppc_get_highest_perf() and update
policy->cpuinfo.max_freq accordingly.

When autonomous selection mode is enabled, reprogram the runtime
MIN_PERF/MAX_PERF envelope against the updated Highest Performance
capability through cppc_cpufreq_set_autonomous_perf().

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7ddf4296c474..fc0fc27342c1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -873,6 +873,50 @@ static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 prev_highest_perf;
+	u32 highest_perf;
+	int ret;
+
+	guard(cpufreq_policy_write)(policy);
+
+	prev_highest_perf = cpu_data->perf_caps.highest_perf;
+
+	ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
+	if (ret)
+		return;
+
+	if (highest_perf == prev_highest_perf)
+		return;
+
+	cpu_data->perf_caps.highest_perf = highest_perf;
+	if (cpu_data->perf_caps.nomianl_perf > highest_perf)
+		cpu_data->perf_caps.nomianl_perf = highest_perf;
+
+	policy->max = cppc_perf_to_khz(&cpu_data->perf_caps,
+			policy->boost_enabled ?
+			highest_perf :
+			cpu_data->perf_caps.nominal_perf);
+
+	policy->cpuinfo.max_freq = policy->max;
+
+	/*
+	 * Autonomous selection mode uses MIN/MAX performance as runtime
+	 * hardware control bounds.
+	 *
+	 * Re-program them when highest_perf changes.
+	 */
+	if (cpu_data->perf_ctrls.auto_sel)
+		cppc_cpufreq_set_autonomous_perf(policy);
+
+	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
+		 policy->cpu,
+		 prev_highest_perf,
+		 highest_perf);
+}
+
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1027,6 +1071,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
+	.update_limits = cppc_cpufreq_update_limits,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
-- 
2.43.0

