Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0633F5B0
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042701; cv=none; b=jhEnPQJ5ACdsajNg4p0mPcvlDr+V+fKMEDq4HialhOEWaAhuJFEDVS4URYGeHJMhTlV0BFRi2bwwn2qI2hsNy1QhyyRy4Xp4afiYs7lYUcHWpuaRdtQ1n/El9IOaLnkb27ad/snV+pqnLJJv/Pg1Q+B6pBy6U5s++s2PpCHzxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042701; c=relaxed/simple;
	bh=IM3BzY+gKDUbwOzi0elpTmXkAq0dg7APDtCwAuuGtNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6o9OWAxTlgQBzuQlvGGAmKR8F49auNch6H8ypGmLT0xB420nvyuS1G1UJvY9f0Rhwkv+8PbRpVF5WxhayhRVmAh7fluVCLBctveFZZJdGVprgM2oc5O+rwPchY5rf8IFh4wEnFY2zOLWx1DSMjp79FoDG/M229c+aaiL3p4WeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bf114b0cf9so8672805ad.2
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 01:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042698; x=1780647498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO1vwp8sJ+t+jcxvi6cBiGKxFDrYU96NEUGJgzYEAbw=;
        b=HbrbOolUV8TNBTQEmkLehe8ynK0eOCBAF1uxHHdOUI63DuZLPirHkwd53ZcbCKp+eL
         jZNDGVS8WfsC3iRzqAXmAZ3RVdBGW2JGsIyElg/uL8+1t5z0lt3uv5tMyg6IS7SsRNhJ
         ee6DuuPHrp8GaNYenOD/o6ai1bGch+B2McaVB/1jSdS2cfJ8p8QiCRNA9lcIRnFPMrr3
         QThtBdMAF7p69qfoGJWNL64NwzcaXQtNxjt6qxD29AnHQQmufoIID0q+tpXhyqxLsmEH
         QKhkqxaMAfEQ3URRm8azP2ueyRLGtXbPl9RTadymvSLGTk5dL1XH0TTtIZUOOww8eD3F
         +01g==
X-Forwarded-Encrypted: i=1; AFNElJ+/w25aZSduVTaIMn/AI6iKtXYf5+EKw8s+xNS2MNp5QZfCRb1aj58LrwR/uLqgpRUFQhahY8ey6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64rMhYxvat/cBpESK0bUz+mDIInEWj2q19uZku7hlSzbr/eIL
	58Mk7Cfzi4t/JdRemn+hzaVTijtqLYmZE0raGt+aIkSKnP8P1Trd6u4W
X-Gm-Gg: Acq92OFfI63YTekyz2lUF54a5/ZOyuiiPEs5ZkZ0iushd1oJDfpLbqH0SccltE/F7bC
	f8Y+33boOtZZeb7I9zodR6UgMRd1hOij1O7l/o91G8lH0I4CKNiybUoR8STSnGfQr47ENfsIDYL
	QxL6S323/I0SAD12kbw08d6UU8unG66Und+Qe/dvaTaHw26VPIgYc4PWAireK/9WAO+jK37EbUy
	f10JFara7lS/Hb63zeUF7eVc2SDls9jQqAkUES4YautrfOqThMxGf4k9cBtt6SLmeJ633Zw2Nn6
	6b1o8MIC9jCtCggfqywQqv4x+7Weee8iRWYWs7NmKpwHbjMhQFNT+RAhtrU7w0J8g6LYzyVoGit
	UGfPKKmwGi0jwl398fIzlGxU0zzUmLe7L8Bjh0XeGpsRNRBMdi/Up42/fd6vglahKSvB1LBEKJb
	Hx+nJPno+FLjeghiFDmKbq7K2FOlrs6DxiLOQX7ulieUbS351HMXRYGeY=
X-Received: by 2002:a17:903:1ae6:b0:2bd:7191:5708 with SMTP id d9443c01a7336-2bf20bb8cbbmr26366445ad.29.1780042698270;
        Fri, 29 May 2026 01:18:18 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3a5c8sm10204315ad.71.2026.05.29.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:18:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	viresh.kumar@linaro.org,
	saket.dumbre@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] ACPI: CPPC: Add helper to get effective guaranteed performance
Date: Fri, 29 May 2026 16:18:01 +0800
Message-ID: <20260529081801.29346-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the ACPI CPPC specification, if the Guaranteed
Performance register is not implemented, OSPM assumes the
guaranteed performance is equal to nominal performance.

Add cppc_get_effective_guaranteed_perf() helper to provide a
spec-compliant effective guaranteed performance value while
preserving the raw values returned by cppc_get_perf_caps().

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
 drivers/cpufreq/intel_pstate.c | 10 ++++------
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f370be8715ae..6dc11030707a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1328,6 +1328,32 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
+/**
+ * cppc_get_effective_guaranteed_perf - get effective guaranteed performance
+ * @cpunum: CPU number
+ * @guaranteed_perf: Effective guaranteed performance value
+ *
+ * The ACPI CPPC specification states that if the Guaranteed
+ * Performance register is not implemented, OSPM assumes the
+ * guaranteed performance is equal to nominal performance.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf)
+{
+	struct cppc_perf_caps perf_caps;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpunum, &perf_caps);
+	if (ret)
+		return ret;
+	*guaranteed_perf = perf_caps.guaranteed_perf ?:
+			   perf_caps.nominal_perf;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_effective_guaranteed_perf);
+
 /**
  * cppc_get_epp_perf - Get the epp register value.
  * @cpunum: CPU from which to get epp preference value.
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8dc22a65e025..8934e48f71a2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -404,17 +404,15 @@ static void intel_pstate_set_itmt_prio(int cpu)
 
 static int intel_pstate_get_cppc_guaranteed(int cpu)
 {
-	struct cppc_perf_caps cppc_perf;
+	u64 guaranteed_perf;
 	int ret;
 
-	ret = cppc_get_perf_caps(cpu, &cppc_perf);
+	ret = cppc_get_effective_guaranteed_perf(cpu, &guaranteed_perf);
+
 	if (ret)
 		return ret;
 
-	if (cppc_perf.guaranteed_perf)
-		return cppc_perf.guaranteed_perf;
-
-	return cppc_perf.nominal_perf;
+	return guaranteed_perf;
 }
 
 static int intel_pstate_cppc_get_scaling(int cpu)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index d1f02ceec4f9..c02f3bc1fc1a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -155,6 +155,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
+extern int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
@@ -198,6 +199,10 @@ static inline int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_effective_guaranteed_perf(int cpunum, u64 *guaranteed_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

