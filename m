Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD83A0B1C
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540987; cv=none; b=E6uSWugB3ErHAo4zVA5CdX6vuaXQMbYHK0RqDRnWP2uqlCvsNX5R97srTVrR4/IJKLZls4q2u4Zd/U51GpOujXB+tBpkn00Joai3dDJHLsvbC08SoAges41EQyFI7AOfSzhj8GPoyOvf5aNsponZl2BpPPjcCu3iuVFtqCKH/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540987; c=relaxed/simple;
	bh=sqq/qPSKz1lViJOySSG2d+4zaWxQDSGoekBXbovqVhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYEmX2yQsrrVDSMi+N+BHhWydYHzT2tcYVp0ZKd8fp92WyJx2PjqsRz7o7HuySSA3k7VoPBfurRd/q1LuyWnZqqLfPZ8A2XYzGMvphdB2cJcW9XYkZDn8wfyESfYlioDnpSfUM53cvUMIyQLxOQSUXKa4tehmOPGJh2aihZ2K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so473622a91.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 02:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540983; x=1778145783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qtfW4eKcGs69USuhwrOvQAdJOTpdNYJT///RBfXHr4=;
        b=azPpYkI0x3H28e5YHCr+syd+sLc0y4O2hOp31d5/v+wclyrQLPpX3FH5dulv2whWHi
         dgLeyaTeM5qDEH7tRxbOWkbMc3p04xNSTJnbdNE6zBH7RvN4EXHUGKk3nt5QEFYkJih2
         UeuwjL2Tprs7DE2ZLy2JAil0W6hBzLGbQfMJF7OGRcMFAxwooXTYufAyExsUkgd2xkJH
         OetVKEe5LdtuGx4NixANNyXnpiC//IZ1d6tdvRAS5OeUAEP3CJw7R7MezH0+WN+P1ltR
         LitdFh36NK7su9ZR6XV5uBWR2cGJNTHkcFVVjkS61phT63hksxWQ5SMt/t/yy1eiCL+W
         rpvA==
X-Forwarded-Encrypted: i=1; AFNElJ/B/bs7XwMDdWi09x4IE3HKDlo+HseC8SHELg5rCVgN357FZUL2n5rMNcwt3rs59honW7wnEPxNzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xhvCi8jMXLa/MQBeRSnL9U+mvnuy8IuCbdNC/dzBkegWvWys
	UNxIr5sLroZgac/qe9doDgcXgDoaefo0vXOv6sprcjRtl5r7mDAxyq3Z
X-Gm-Gg: AeBDietnhH2Vwh6HACKiodH1EZ4znUJ+vzv33tW6M2DT9vjehDC2WPcoQkqVGBXGisG
	zPYyJZ2+lGMA5TRzfqUPvBYKmNUy4ZcWLOsZ4iIWKFFA0vAgVyZ7nAd24yojF5gyNVFrMyG8UVI
	lXaAX4y5cAkK0L5WP0qnHYSvE1v04qc3SY+SLh00pLd6rgUxz5bIBDKH8OpU6H1rhp80AvPsQao
	qw1/6L2h47iUw082TGrr+34BFbMlE5Ua+/v7gQb1aDdS+JIFAjl6kOyGBr3hqaZ3qpur8z60u9E
	5z1c/2kiHQELEHSVQHjYkt+UXSKW2s+AK2myCfXMfCqMJY2EMGW9gGi6hvlESascD7emOSeWbrW
	QFajmOeoqqbx+mRU1uuV2iHhqVepxEgsGje67TrnDB8H9zWBoR0rB68cZyOZLjv+P8G6o8eHW5l
	hXheiaum1mT/CMugsWwY4p+hmtIbnCHn6Pf4wrEiE7srEZ3kUlEuukp6Ob
X-Received: by 2002:a17:90b:4a90:b0:361:472e:3be6 with SMTP id 98e67ed59e1d1-364c3161d69mr2093615a91.26.1777540983253;
        Thu, 30 Apr 2026 02:23:03 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf81f3fsm2086722a91.14.2026.04.30.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:23:02 -0700 (PDT)
From: luoxueqin <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com,
	pierre.gondois@arm.com,
	sumitg@nvidia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2] ACPI: CPPC: mask Desired_Excursion when autonomous selection is enabled
Date: Thu, 30 Apr 2026 17:22:50 +0800
Message-ID: <20260430092250.380996-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin luo <luoxueqin@kylinos.cn>

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

v2: update subject

 drivers/cpufreq/cppc_cpufreq.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..c7444a6ceb55 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -982,8 +982,44 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 	return count;
 }
 
-CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
-			 cppc_set_perf_limited)
+static ssize_t show_perf_limited(struct cpufreq_policy *policy, char *buf)
+{
+	bool auto_sel_enabled = false;
+	u64 perf_limited;
+	int ret;
+
+	/* Get Autonomous Selection status */
+	ret = cppc_get_auto_sel(policy->cpu, &auto_sel_enabled);
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			auto_sel_enabled = false;
+		else
+			return ret;
+	}
+
+	/* Read the Performance Limited register */
+	ret = cppc_get_perf_limited(policy->cpu, &perf_limited);
+	if (ret)
+		return ret;
+
+	/*
+	 * Desired_Excursion is architecturally ignored when Autonomous
+	 * Selection is enabled. Mask it to avoid exposing undefined
+	 * semantics to userspace.
+	 */
+	if (auto_sel_enabled)
+		perf_limited &= ~CPPC_PERF_LIMITED_DESIRED_EXCURSION;
+
+	return sysfs_emit(buf, "%llu\n", perf_limited);
+
+}
+
+static ssize_t store_perf_limited(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu,
+					cppc_set_perf_limited, buf, count);
+}
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
-- 
2.43.0

