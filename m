Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D3448BA4
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083131; cv=none; b=uzs3zXYqQLDUe37Y4xQ5ZNq3SilaI+ykCoy0ZSKHBI2KsSJGrY4MDZnAaDihm0M7Y8A1aDrZCk/toLuJPh7LWvZlsCGMKfc2DArgw7e+uDrjo1x8WyCCTstWMBTTOKoeKIGpzzjq2vpSRO7oXAyiWgnVLTFv4rp4YA7yFOuwb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083131; c=relaxed/simple;
	bh=CBkY0c3xbjJo5xy0a0Ya0TPioAfVbM03GZcCRoqC/+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G11h3W+dH3MStNrtmUoQIhcsCv/5m6IOT9yK3odQ+0d/zdFbfj8eB98/T9+vlk2dEqzKuVP6WXdv5Lb7fpEzcDZrOIVvffeVBXEgA1mu6UqZTN0qVSsCi12O+ozcEqI5AfTNYo3TObybom/tKHcKgL/OPxrE6gvBR56yovfWjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eca9b7114so1710133a91.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 23:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786083128; x=1786687928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rIKFf5IUphGedu29HI3S87K+WXZgW1+znZSL9A0NdHw=;
        b=Y/eXKI9WNKtrXcZt7euQK/Cp/LLdpGZXcM9uLhLWfPyhjnYnUGd/A8eoSQJiBeshqm
         tBxO4tkhBUcl6a/JdPvqNEaFVuV9n8YKeaydFuGMRLfvWWuTi/ShQbdOPyVJTbIrIdIH
         gD54uLLJxb1o15gzo06dNK4jeUbzrVp/0OIH08zR+ru8rdvf9NNpkVPpgb70qVBpDDtN
         orhGU3g6TmJldeCsqWqkHwwXE2Yg4A2ufOcwWesFx/N7rRV9PBbdHGnF630201cSkpXO
         zvNdjc4Iw2bW9ryBhyBXqnLe/6cOX/bQ9Xcx3biSLmdJgZ7D9qbpQyHLR4CTFgpWWMEo
         n6sg==
X-Forwarded-Encrypted: i=1; AHgh+Rol/Dzg2n68oX1Lqt01vgyWsUOHkd+op7qfHf7PCmAwlQ4/Y7PP0TVFjiQ6GafOAxahXt+pW5o3yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqInkPuvbtBG2JJMQ35lKJD04KfVUlaTWspiB+wYmPpQHCxP6
	0ObJr1a8v1qhx6lpXMvh3NNCRonnXZuRqp0ajiBWb5qzbGtmPV7khq4d
X-Gm-Gg: AR+sD10aMs2EyTeAJNbqhwSGdoQetiuQ5oovV0K57EGPDrM6crD23lwVanNeGbDRCAN
	DFeiidun+pLXnbdslA7cJ2DLGjplnvhDxa6z4UovWoO81AfNeUWKDjogV8Vmxi3BdEfNan8DWHV
	zBV6aNzSwAEuuxxWYKLlHUnJGfigcl2Qyy+bt8ZWkAL2bJK3RAeLc6cGviimsu47YDQQYSaqddM
	iiYhpngjtZwkKQ+hyhJ37VILUbKWVrd68oqTgvpzMLDbl3NfuDyM/wdfP3AZomxPJbiJVCPY+z4
	ejNuwJwvAgpnFr21dK6GwveLoYV7PFmUav53VG9VO9/VGAMhEYa+Td2NXg/MKxn5b3R6EaYaDJL
	w34zp9JVjJ6JGNDWOWtDshi17cnRVZnvivjeBbIlytDYYB16zvP9OEuLZ5fbU9cxfy3M+992k4Z
	PDFPgr6jZLzBXIKLxe92i0u+dtBRV1xnPX8NBdPE0+yYNf4O1p2K1XQi8fINBbd1zg/p1Isy269
	NnHHTJtXA==
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3903c599356mr20672051a91.2.1786083128112;
        Thu, 06 Aug 2026 23:12:08 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbe349sm3434375a91.4.2026.08.06.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:12:07 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 1/3] cpufreq: cppc: Add update_limits support for Highest Performance changes
Date: Fri,  7 Aug 2026 14:08:46 +0800
Message-ID: <20260807060848.832929-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807060848.832929-1-luoxueqin@kylinos.cn>
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
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
policy->cpuinfo.max_freq from Highest Performance. Use
refresh_frequency_limits() so policy->max follows the standard
cpufreq_set_policy() path.

cpuinfo.max_freq always tracks Highest Performance. When boost is
disabled but still supported, constrain policy->max by updating the
existing boost_freq_req (created in cpufreq_policy_init_qos) to
nominal, instead of hiding the hardware maximum in cpuinfo.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 98 ++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6fe0e972952a..089f734f851b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -855,6 +855,103 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
+/**
+ * cppc_cpufreq_sync_boost_limits - Sync boost flag, cpuinfo max and boost QoS
+ * @policy: cpufreq policy
+ * @boost_supported: whether highest_perf currently exceeds nominal_perf
+ *
+ * Highest Performance can appear or disappear at runtime via Notify(0x85).
+ *
+ * cpuinfo.max_freq always tracks the hardware maximum derived from Highest
+ * Performance so that sysfs reflects Notify(0x85) updates. Boost being off
+ * is enforced by updating the existing boost_freq_req to nominal (capping
+ * policy->max) rather than by hiding the hardware max in cpuinfo.
+ * boost_freq_req itself is only created at policy init, not here.
+ */
+static void cppc_cpufreq_sync_boost_limits(struct cpufreq_policy *policy,
+					   bool boost_supported)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int highest_freq, nominal_freq, qos_freq;
+	int ret;
+
+	if (!boost_supported && policy->boost_enabled)
+		policy->boost_enabled = false;
+
+	policy->boost_supported = boost_supported;
+
+	highest_freq = cppc_perf_to_khz(caps, caps->highest_perf);
+	nominal_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+
+	/*
+	 * Report the current hardware maximum. If Highest dropped below
+	 * Nominal (unusual, but possible with test overrides), never
+	 * advertise more than Highest allows.
+	 */
+	policy->cpuinfo.max_freq = highest_freq;
+
+	if (boost_supported && !policy->boost_enabled)
+		qos_freq = min(nominal_freq, highest_freq);
+	else
+		qos_freq = highest_freq;
+
+	/*
+	 * boost_freq_req is created in cpufreq_policy_init_qos() when
+	 * boost_supported is true at policy init. Runtime Highest changes
+	 * only update that existing request; they do not add or remove it.
+	 */
+	if (freq_qos_request_active(&policy->boost_freq_req)) {
+		ret = freq_qos_update_request(&policy->boost_freq_req,
+					      qos_freq);
+		if (ret < 0)
+			pr_debug("CPU%d: failed to sync boost QoS: %d\n",
+				 policy->cpu, ret);
+	}
+
+	pr_debug("CPU%d: highest_perf=%u boost_en=%d cpuinfo_max=%u qos_max=%u\n",
+		 policy->cpu, caps->highest_perf, policy->boost_enabled,
+		 policy->cpuinfo.max_freq, qos_freq);
+}
+
+static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data;
+	struct cppc_perf_caps *caps;
+	u64 prev_highest_perf;
+	u64 highest_perf;
+	int ret;
+
+	guard(cpufreq_policy_write)(policy);
+
+	cpu_data = policy->driver_data;
+	caps = &cpu_data->perf_caps;
+
+	prev_highest_perf = caps->highest_perf;
+
+	ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
+	if (ret)
+		return;
+
+	if (highest_perf == prev_highest_perf)
+		return;
+
+	caps->highest_perf = highest_perf;
+
+	/*
+	 * Re-evaluate boost capability/status based on the updated Highest
+	 * Performance. Boost is supported when highest_perf exceeds
+	 * nominal_perf.
+	 */
+	cppc_cpufreq_sync_boost_limits(policy,
+				       highest_perf > caps->nominal_perf);
+
+	refresh_frequency_limits(policy);
+
+	pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
+		 policy->cpu, prev_highest_perf, highest_perf);
+}
+
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1048,6 +1145,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
+	.update_limits = cppc_cpufreq_update_limits,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
 };
-- 
2.43.0

