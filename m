Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156683EB81D
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062734; cv=none; b=FTVGETMpL2pQA6thzzskH533AEyqe4a+39yH4H4/VaWqdWxDJl1KD/uReQrjMrVThdrTRKIkm9R5QMILCjkZDzm+KH4/xIszkzApBITCgMlzBP/F7Z6w6zEkah9k/Awyt6O7WYKlo0FGkTwwifK5XPPG/WxHihulxxwBXLOZN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062734; c=relaxed/simple;
	bh=KbpXX1Ym1bmxn0ZLZ/2SX9JWOdVZecC6m9Km1cJugQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pi06jpFLiVITwKOH4JP59KwRWOEKKudgDSTFzZBLyY+gkgIWcJnQWJzqWPzn2GiZZD6gumwbPDuScbu+mRo5tAnfaSGSH6b8MN3THbwQ7rX3WvyodTzng1ilqmsN9v9S6EFl7aAD/PTUn+q9ckRT/zaXw180qBNWRgZtkH/bESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8367df48711so1536968b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062727; x=1778667527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJfO0HN9ehRLvbvP5xDLTjyEfOl5gQpG4emVlBW6Xo=;
        b=aT25/omqApuTreuvW4WmIO/f6ZT+wxiQCqzPMcoVmL4KgCGyqTw8VaBI2PAoSSZVeU
         5D5snS7bn3r/tkCfDA7QAQEM3GThNlk/VAePKQjqITsfhpd8CTgfs1R1dSFVxlZid+6e
         FYHwrtbzLpxl8q66avRHgdW0IlbWjJ2UMISV5OaHyZv1HFdZwa/egE1+cKvqtRSeP+gL
         SrDDT2LTOfOn20ixpWQItgo3oluIuJTd23Rw4nIeJBBA3fPm3H/37B0iI5/9THMs7dhW
         wBia37CWNQCOKgJcGZgW1WnFzjRKYS9z6CdhJgHqzRbv9ZARHmsUSooMb//T5BuSFKE+
         NhdQ==
X-Forwarded-Encrypted: i=1; AFNElJ98LXmnuVXmEhHYEji3QkKX/uHpVpZTJ83c/dJyySA68tl3l3sQTMz+1kBGtOnDsVCQD0K252cocA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTjIlLTBjyMAWMN+jn97x3WMJ7EyByLqlZnYX88cfv/+3frV2
	NcEZJSAkFSGxGFbcnvYquYtM+rmVFUSLS22Ys3OIe+aU0Gm0FLaqj2o/
X-Gm-Gg: AeBDietZWrtRfUOYbE3jLRgvys1//utJu4oURUCQdcKJg7z8FeR37tq6HmlJol0JA+m
	I4U3ruDOcTqVdR8rtfx70m/QvaUsiUfkK57XuvkkZO4uJm9vQ5+6IVlZTctayfIBrBhAQlHKQp/
	bhHENpgSYovgrNOFRkovKKtKdr6vO7MTz5IFCzM5Mittwl3O7hm3Mdrga7aP3N2YMQgZ3EVx8l5
	J4I2knxf8nU9PMwZ440JWbiDv8u+rnsOKBeH6XInVVF6offp7kGwo5vP51h0EOTqv6C/KHNjP2B
	QS7KweyxooO9osdYASTCpYbelRnkNatZIchnD4Jm+p58c0dFKh9vC10bBNloGCPNBxRzJgEzc35
	PcDrhXnnawJ1ISqhfX8nL+xbiujHnfMmOqVWFUQluiZDlFlWXtNMQnzfN1nRpUdqmiQmYWxGMR6
	/BKhoehF4azyIkf/0POlrCIjakfen9lRh+a+c59r47Mfa8PVZLMSJysO1keGpw3aCDuLE=
X-Received: by 2002:a05:6a00:288d:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-83a58736dacmr2697578b3a.0.1778062726927;
        Wed, 06 May 2026 03:18:46 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm4870070b3a.57.2026.05.06.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:18:46 -0700 (PDT)
From: luoxueqin <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3] cpufreq: CPPC: mask Desired_Excursion when autonomous selection is enabled
Date: Wed,  6 May 2026 18:18:34 +0800
Message-ID: <20260506101834.343001-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin Luo <luoxueqin@kylinos.cn>

According to the ACPI specification, the Desired_Excursion field is not
utilized when Autonomous Selection is enabled. In this mode, the bit is
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
---
v2->v3:
- Use cached auto_sel from cpufreq driver data
- Fall back to raw value when policy is unavailable
- Keep sysfs ABI unchanged by using a wrapper around cppc_get_perf_limited()
---
 drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..a439d9621eed 100644
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
+	bool auto_sel_enabled = false;
+	int ret;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (policy && policy->driver_data) {
+		cpu_data = policy->driver_data;
+		auto_sel_enabled = cpu_data->perf_ctrls.auto_sel;
+	}
+
+	ret = cppc_get_perf_limited(cpu, perf_limited);
+	if (ret)
+		return ret;
+
+	/*
+	 * Desired_Excursion is ignored when Autonomous Selection is enabled.
+	 * Mask it to avoid exposing misleading values to userspace.
+	 */
+	if (auto_sel_enabled)
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

