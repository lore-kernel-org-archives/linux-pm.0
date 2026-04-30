Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A1377003
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536649; cv=none; b=cmTjiWi/BlKiSR0bqO908C4xKh11esfidiaZbTDjSJOse6M7iWP3Vei5vp2fYCeIOAueMzFxQRG8cT0KiOmUlva0ZscYg6YN4WoUZBPdJf/qyNn5ofPhwBAkNaY8ZXe91VTOHW5cgTWoEyVVVeQ6XlDUL0yIILZbTX5EKzcdIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536649; c=relaxed/simple;
	bh=gUTTShATbbYifleGHcJx237FPLs17oYKKLqFvMOgfkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THQAyW+03m4iQCl34lrZ5sBaDJYdK5rLTYTRyi66Q66gjrEmUbnEdcMS/8yLrwjO5Re//JO3QU+JAbOh3eaCxEdJTGayucttKwo+RjLn66b5mDTB7HlQYoyNJ5jZduvktcK407WfuB5SiR3pFVYfKdCvexdBwXGaM1UV1stps8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso404288a91.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777536647; x=1778141447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/+MHZ+y0Q4fMJhPFmuJZnC9anV3GSr5sZ/H7ZHsam4=;
        b=jwooazSuVl3pNWaGz4g2bhQ2GA63KIdzREaUAxFDJMgfyQZIX4KcUvw+gZmQsAp4Xq
         Uiyvm5MNNUNcCFVekW6qD1e0LnebDfCTrZnBR2NbgUgsaJRgTCH8ymSgBDJkLf4Q70qu
         tB8Nf3TxRsgD4z2gnLr0vpiRUkgQXLHpk7QiwY5ldMVX6wJC9eO5MioHm4OlntKqVFyz
         72B3ao1qtKrH6AbuBCjI+2YPPmuiRgTcSIpHg4OcaJtAqOiXkbKVocePnyAGWjRjgMv+
         3xAGNGe/NUDPZ0GO/H4utFTS2699yUm/IFyJ3B+kLgTMmEC/N4gC1kqJrxpXP2Jjp6lu
         vRvA==
X-Forwarded-Encrypted: i=1; AFNElJ94kFCmLfPBcE482hgoOcMBQQv842EyZjvklFJs7PmL+LPw6/ZA/Vm/5Km4NhljtcZjkKsWtRRgtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGB5ftssPmth59Pq97l1HoHQynHFYacROz+OUEspTFXbhMevsB
	CWPCcGevujqVzaocGIx6uTjvWoA6X3z9Cl+rIMvkum28REm56bxjvcya
X-Gm-Gg: AeBDievd5gjrgBQYixbR5tN4Y+g32wUpw/ktPvxdVS8vdhJ08OSdGflDYe1+BkPQvoH
	aBYSv3qKy2VWLLoJNdewBTetwupygQPMl+P9NwnDFKloh4aMmik5CDmN4VchQAGnY6n4OSE74eh
	76EGusKQxYbj2D1y3jHqM/5J3lQAEd+m4YAggmnaC3gkE+CbmnRm6I/ZNgWpVrAOeNCOPwrpPe/
	m/44RR+O6QhL6f7j++vCSLZ089so5L1Ve4gYRAyY566IJzLPpTm/kPnavjavYwf3s189cC7AhR6
	hUgNmuFWq1bNW0FHBhhyRMwq9FJCBTXLL2E5kt21K+En2/1CSUq9Mh8gSvwX6bZkf2HasM/gLnt
	+WoM/2h/cgGIlpkTTq+SgOql0hKxo5aNxCbJqvl8Ua7/8+HgFQp86D9o3ztvH3kDyvKIkWEXD/x
	KyQ1P+amZn4l9Ly3e+iwsmc51oDjb1dUZljmIbORNX/D+9yIacnRTzKUNO
X-Received: by 2002:a17:90b:3e4f:b0:35f:bca7:5d22 with SMTP id 98e67ed59e1d1-364c2f8aecamr1831112a91.10.1777536647315;
        Thu, 30 Apr 2026 01:10:47 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6514e11sm4366458a12.30.2026.04.30.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:10:46 -0700 (PDT)
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
Subject: [PATCH] ACPIW: CPPC: mask Desired_Excursion when autonomous selection is enabled
Date: Thu, 30 Apr 2026 16:10:36 +0800
Message-ID: <20260430081036.373723-1-luoxueqin@kylinos.cn>
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

