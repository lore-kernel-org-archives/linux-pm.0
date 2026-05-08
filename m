Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C92383C6B
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239200; cv=none; b=VUZEZXYKV+LBNVbCEaedvRa3NYxN60rgt0/+HqoJm1F9pjFmS47wiUUYEfmKjmJzDQR16kRc5qXnnSZoG6Nn2T3XEIKry5UFdBxYTByCBrPCXiVdsnbUgluzn7kY54AZill6J9RpFJZ3tzkM3OxEfAgLy6qZ5Rq3pbvtU81I4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239200; c=relaxed/simple;
	bh=m9n7BT25+vHH/n7hjui+1I5GdOQU4U+9Q5f0iR5AvOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUh2dHeUVaGFRz0KleU4bPBwOAs7LWDaXJh4KnIF5X4cVsFfcZurOpNTBsVHdrXyW2gJ5OfkQT4R9XCjFRqHS7ZshpDpkCOpqGWJ8ivOUVPSeGozm4+uXDEDiQ2CM+7tJbSN9VJPBjM5MXkpTvCeKhwl7hEeXMFo5REAFwtGWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c7980c060cfso820755a12.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 04:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239199; x=1778843999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mVqzfOQgFkCVMi9YwAzQslL8I8SYFxWQkm2YEukEH0=;
        b=lbd4AiAiTuH7/rm6bRvEuzMObAZSsAPpNYw53/VqU1mBOM+foMV7F5XOW5U3o+5uEb
         ciANxTiKoGi4PN2jd3VKZdc6P6yZeTZQ3zhx1Zsl1xwq8gxsyWtyFMaUEyJGnVEWRbZo
         R8NSPaPOoue5N+MPPEjrzHHlIs4E63fCXlG2E5H7RduRW6Mr1Rp3xF/RbalGwjL2wtPU
         oJg7f7uWrs3arWCrh2nZMAZZifreuPGyMgZJvafg4Oc1w81eXfjxXrZN5BDwd+Ula2yr
         FoihVPJBPASHpM7MBSLWilBFMIpgmLo+mefOCAIi2qG6mWdQ7FjbyR+bfT05EA2QOUR+
         PlNA==
X-Forwarded-Encrypted: i=1; AFNElJ/7ZjZQ/ltiZa7FT8/CqNh7yTFLmWQBK6NCFx3H38U6AWfkCYdJbMXlOzqNuIN2uDDDdH+aT1Wf+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YtNhIcidpLkTXUzx22Qtw9HL4FaaLbIpUs1Cy01d+e7vQHgy
	MdgfqT/2naTzxYefhafETs3RVKwVbFcUspA3SsQaU9kJD7IK07PtN4FE
X-Gm-Gg: AeBDievQrGrZIV0YGuSxaHrLkeVsEq6Lz/D6VXhxvtOIRb0rA7U/EZQJXm4QJUD8MeG
	74QJu9CvLtTPVzk1HKQxO9RLaU/su41d8D/ZF2vfLglnavgkkVL5WJBxcajAQa8JCMWJgHWXJSp
	XU1F8Wb67zlTva70J+Um/LZN5sexQkWwLY8631fNDtXjaMkk+fnd5YV+kk8y0btdLBxIpS498gw
	yonXRwle4LclgOjxfXs9OzKREBZgg/C6zV5tQa9mUeo01S/sVhGJQReLWRZxGIoH6L/qMCfC7gU
	Zz3RM6GHMPU724072+xcOplMw8gZqLs+hlauY3Q6xU9FBBw2raNUPixysmw0WmJ2GxNrlD2M2G9
	5B3h4n8BzwWK5L0GH1Z+NrXeCqIIeWeP9sWQ6z81aO1WQQf5vLHVMfD6PdYPMamTTer18Vj4mp/
	ao+90Ot5/8GbetIfS8cChvXrErKLOGUi2BssikY/kKQVuzoxYwNaIItesj3hy6lcEJI08=
X-Received: by 2002:a05:6a20:3c90:b0:3a1:90fd:dcd6 with SMTP id adf61e73a8af0-3aab16e9e2bmr2827928637.31.1778239198883;
        Fri, 08 May 2026 04:19:58 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839683a088fsm11947041b3a.58.2026.05.08.04.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:19:58 -0700 (PDT)
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
Subject: [PATCH] cpufreq: cppc: Add update_limits support for Highest Performance changes
Date: Fri,  8 May 2026 19:19:32 +0800
Message-ID: <20260508111932.185886-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508111932.185886-1-luoxueqin@kylinos.cn>
References: <20260508111932.185886-1-luoxueqin@kylinos.cn>
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
--
Changes in v2:
Please ignore the previous version.
Fix variable naming issue causing build failure
---
 drivers/cpufreq/cppc_cpufreq.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7ddf4296c474..09c7f2ba0540 100644
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
+	if (cpu_data->perf_caps.nominal_perf > highest_perf)
+		cpu_data->perf_caps.nominal_perf = highest_perf;
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

