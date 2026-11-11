Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387066;
	b=bpOT3uhMUWff0+TOsSXvOanXT6hHgbXu0PvWpfQiDH9OTLcW1B4zOjwACjstldePy2BT
	 nUp4DAc0oFDV2DUXlL1HXDi9mkjf96vszljv1TZlaD6p/52qr8nAuTdoIgwtAojbL+kwp
	 9N/yh7lXaMtKbKV5p1nh5IPU914rDSsTxB/dfH8J8KLN1tbOrTa4ftrREJeJnzQ+SYxtQ
	 ugt4k+QbNk5vRRcMtF/BUwRt1totAjChIqs06WBRUacNUxBmNoazm4Xd9M5cVBcEGpL1P
	 +C1Lqyopqzmx/MnyQDjPTU+TqrNxCou3IeecELq5OhNescHqQuHNJNgbCQ0VrW7i6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387066;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
	b=4jY92s/m0CTbr539HWobdpMpqLyucJ5PTGRzjAFboR3HIBV4fwJUHmOZZN7r1LimKQZn
	 nODaoxdLht4r+Z2lDAp2e12SD1BPSEFvoVVfXEF344I3tR7E2SUMFKlKtaQQrYNxGfjKY
	 cS/wDjBpGdTvxVz6OK3WKkyHAk2itCgkHST9r4HkvWGzk1iEZPVAan5Snbr5tqIEBweMm
	 6+gfu8M5c19Z5CUnEyDYy7yTbKDaG74EaizTbA3nLt81XEpBVrBcizAdYHX3PhA1LgicG
	 igsh75PfhtRjGT7pwaoOMfIMW1cGUGvJ4xwQFsnqNdXy/udua/SezIVn7iKTpZHDjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F92C606A31C
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F92C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3564so859289a91.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 00:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387065; x=1794991865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3JRXipHaQsA2dpbPLLRBQxHUpuSS4w/ATARj/qhSxk=;
        b=r+ikkIFyzxzMi0eFWFC11I8iB2TbB1caKJQ6Zs5Y1B0/mw4BZcctKnTzcQQFP6BqRj
         so9RBBN45DdOuTzwOP1OBE5Uqh3BZlXGSy4Y+Zga/yPL+6w/i1R1JypB66IhJ+X4Hlh1
         tPjxQutBuYZhbdYuYH1S1C5UTFvz6eUHrmlykaezY8QvnSQRckHmYqT4W0GW+bLBfPvr
         csQdqRHpMygvtozJCy8oPfFGxhsj3bV2mWHL7mY117nsX6ItAVKX/r6x0nQQRkmoxB7p
         AOdVgGEAMBVhlHEVt9hv2EgZ79mey/ZVs6RjWi0peKoUKRfmdKpAtzbgf6BfnPaLhPB4
         w+tw==
X-Forwarded-Encrypted: i=1; AL+hErEnU85GHDGqz/PY/+xJv4LOZtqSz9qEwzkfQH0ufqR8n7tp0XBJWRxWoVQMDJB7DwFJaVwQi/0rfA==@vger.kernel.org
X-Gm-Message-State: APuU4Z87aOLfMVae4l6a/Q4Fml3YIH/PDwfA7J7pQf6j8DdgiX0fNSMX
	B+vwD8oqfsVnIiCgclZAvWRG89cPsF+6YjGlqMMFkjQyvtGGblhOY1JV
X-Gm-Gg: AYBFou3A2D5CSjTstF+W53QOrAMZWUaCAR1/LMTE12RveN/2mQ5Ui5ZCc/+SbNw8it7
	+C0q30qrLHBS4EKy+wUMH+bfUMtoJfmHUEz+u4Y2t/Lao8hWxxPOhrLcTEkiuTxAlLdruvQD0U/
	xRFqIXO7W8YqgEtgnwu4s+rib8xnZNUFCD4sK6Tjy+5K8acjVMYHQaPqq9K5/bmBUAfivNKGVsW
	82FbaBHWuqa+M/ZbqFdZi4kz+mziWThZA9+kXQAtLp7mtm0Qcv53JCIzshRYlg8w4M8+K+YyYeh
	J+Gvn4B4mpUmL8DPjQ4Rch/OMjqmLAo0BKv270M6p9Z2C0Tgc5b9FzcJ9vK3DMEZtSWAqbaDYJr
	BqabwLywwuiA4/qCGHJENEsTWlQHDrZkjCXJOoCBT0VjdRUzeKJxYcwAPu0p7DDmc8QTGXmf4nU
	zkObLcG0EPDPoLygivdTCg2X4lURB5C5239LMitB0qn1uY94vPnVfXPYsU59UDih6tnT3JdcVIH
	oHdm0UILq44rZAzFQ1/18GX5VPAsaliQgCvPl6RcTooWRI7ohF6rGuVR7/HK+u7HDqXDTktQdr0
	mzm492hG42bX9xP6krXFaUqEZwojkXMDFxRt0vLpCYfWORNuYtg=
X-Received: by 2002:a17:90b:4c4c:b0:3ab:be66:ddb6 with SMTP id 98e67ed59e1d1-3b182eec040mr1437917a91.20.1794387065472;
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm2396406a91.4.2026.11.11.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:51:05 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@kernel.org
Cc: zhanjie9@hisilicon.com,
	christian.loehle@arm.com,
	zhenglifeng1@huawei.com,
	sumitg@nvidia.com,
	lenb@kernel.org,
	maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	johan@kernel.org,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v6 2/3] cpufreq: cppc: Refactor autonomous perf bounds into helper
Date: Wed, 11 Nov 2026 16:50:21 +0800
Message-ID: <20261111085022.1229866-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
References: <20261111085022.1229866-1-luoxueqin@kylinos.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the autonomous selection performance bounds programming from
store_auto_select() into a reusable cppc_cpufreq_set_autonomous_perf()
helper. The helper saves and restores MIN/MAX performance on failure,
keeping the rollback logic co-located with the programming sequence.

Reuse the helper in cppc_cpufreq_update_limits() so that when
Highest Performance changes at runtime, the autonomous MIN/MAX
envelope is re-programmed against the updated capability. Add a
pr_debug message on failure for diagnostics.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3bca30f5c0d5..7dab6e046b9f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -868,6 +868,29 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+/*
+ * Program the autonomous MIN/MAX_PERF bounds from the current policy
+ * limits, restoring the previous bounds if the write fails.
+ */
+static int cppc_cpufreq_set_autonomous_perf(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
+	u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+	int ret;
+
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		cpu_data->perf_ctrls.min_perf = old_min_perf;
+		cpu_data->perf_ctrls.max_perf = old_max_perf;
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Boost being off is enforced through the boost_freq_req QoS request
  * (capping policy->max) rather than by hiding the hardware maximum in
@@ -961,6 +984,18 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
 
 	refresh_frequency_limits(policy);
 
+	/*
+	 * Autonomous selection mode uses MIN/MAX performance as runtime
+	 * hardware control bounds. Re-program them when highest_perf
+	 * changes so that the platform uses the updated bounds.
+	 */
+	if (cpu_data->perf_ctrls.auto_sel) {
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
+		if (ret)
+			pr_debug("CPU%d: failed to update autonomous perf: %d\n",
+				 policy->cpu, ret);
+	}
+
 	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
 		 policy->cpu, prev_highest_perf, highest_perf);
 }
@@ -1008,20 +1043,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
-		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
-		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
-
-		/*
-		 * When enabling autonomous selection, program MIN_PERF and
-		 * MAX_PERF from current policy limits so that the platform
-		 * uses the correct performance bounds immediately.
-		 */
-		cppc_cpufreq_update_perf_limits(cpu_data, policy);
-
-		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		ret = cppc_cpufreq_set_autonomous_perf(policy);
 		if (ret) {
-			cpu_data->perf_ctrls.min_perf = old_min_perf;
-			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
-- 
2.43.0

