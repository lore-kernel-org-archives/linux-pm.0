Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665266;
	b=kEW8lOjtAkwvLuJAIAJo6H9k9VpOcsOYxx5Vbbf/sx0q+d5gkQ4NO+UKtPPNbwnvNvJd
	 BP/2s7uFay1FKG2cZ6pdX1VuXu1mRYKRXA1vxZFmjdOuGKDC1SyiF+loxJfE+SfxLmehw
	 BkuagwHnQAlwvRAGsvdHZVA9xM8ExsFuwTQxyL6Tx46G5Jlb07TRgb/YcS01kGKOrR4yt
	 t4eO7jnFcwvm3G4WGnx5D96s7BRxyz/uIjEDSCB7VkKMwEKa5Bt7iw6tbUjwRvup4vrqA
	 CauTDzYLo6JI94h029XL6MDU5L/otlrhla+9IvkuUcXTdCo000X0ZkjrPQMG5ITy+IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665266;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=tP1acQlRWf6l7bmcZWZ2wj1d0QcgiPDNN8cVBdGDvOc=;
	b=3umHLJJ/Sm1Qwd1e6rFFXRWFhySsy1fZj3Lb6+MsW9i6QABlxGJ/WIldYAEuVLPJANO0
	 BbKn6RKNFvIMljnWPi0OxwA87Ii1jPBQyczTQasPCu9RL75h39S/tjwBFGx92yIuXk5zB
	 RTP4ej4vwTNclvx+oqWshl1N2hfZC9Nv84QHyd+r6mkovrPPbKyZbGJL5p6t3drHqk8hU
	 brazo1IyD8C+VV7mrd0cMg+PCzvEf6fVXGUXpEGMvrLxL743SIPyJdkowTxPMWt7SVrZ9
	 0vgvDZ+oeQn1ZCOM6jQFosS+CV67kJkBccH+cEa8crnwJIfBGWh3M7dj1q6TnahzERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=mFdcQQ+M;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 18570606A32E;
	Sat, 14 Nov 2026 14:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18570606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=mFdcQQ+M
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v6 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in get_cur_freq_on_cpu()
Date: Sat, 14 Nov 2026 22:07:23 +0800
Message-ID: <20261114140724.2336-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261114140724.2336-1-lirongqing@baidu.com>
References: <20261114140724.2336-1-lirongqing@baidu.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794665256;
	bh=tP1acQlRWf6l7bmcZWZ2wj1d0QcgiPDNN8cVBdGDvOc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=mFdcQQ+MIVtmrvh4lsSeh4/mFcfqikDFmBjULU/RYVTrpfBMKNDd2dgmmzoRgtrDY
	 yskRGeyWLJf3HbLryTyvPUPasS06tdr4XGj/Ord6Lxm/iFHGUdQYMVZs36+fRlFds9
	 BCBsruoJ8BlZLoDE78nvt7QsRcD6yzWZiXBWGc7yNw4wcAtCGSrGq9WlSOcGtHA4v4
	 efKSaL8k3uCCb04vuSCeC+RCQVjuSgif4ZpHgRiln1Ls5w8AG0OcJTrW/H4urRiSos
	 VmBgSQJBWmJLqh4Bo3ZpFalAW4GhYIwqq6vqKXLuTmiDhPk+ujresueR9sjaXGhU1F
	 9DBD0swHe86Ww==

From: Li RongQing <lirongqing@baidu.com>

get_cur_freq_on_cpu() uses perf->state, which is an index into
perf->states[], to index policy->freq_table[]. However, freq_table[]
is built by filtering _PSS entries that are not lower in frequency
than the previous one, so its index space no longer matches
perf->states[]. The original P-state index for each remaining
freq_table entry is stored in driver_data.

Once an entry has been skipped, using perf->state as an index into
freq_table[] can therefore select the frequency of a different
P-state.

The reported current frequency itself remains correct because it is
obtained from extract_freq(). The mismatch only affects the cached
frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
change behind our back.

If the wrong table entry contains a frequency different from the one
the CPU is actually running at, the check falsely detects a frequency
change and sets data->resume. The next ->target() call then performs a
redundant control-register write even if the requested P-state is
already the current P-state.

Conversely, if the wrong table entry happens to contain the frequency
to which firmware has changed the CPU, the frequency change is missed
and data->resume remains clear. A subsequent ->target() call for the
P-state that the cpufreq core believes to be current can then
short-circuit without rewriting the control register, leaving the CPU
at the firmware-selected frequency until a different P-state is
requested.

Fix this by taking the cached frequency directly from
perf->states[perf->state].core_frequency. perf->state and
perf->states[] use the same P-state index space, and converting
core_frequency to kHz yields the same value stored in the corresponding
freq_table entry during initialization.

Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIOS freq changes behind our back.")
Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index f64fa37..2d7d147 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 {
+	struct acpi_processor_performance *perf;
 	struct acpi_cpufreq_data *data;
 	struct cpufreq_policy *policy;
 	unsigned int freq;
@@ -368,7 +369,9 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	if (unlikely(!data || !policy->freq_table))
 		return 0;
 
-	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
+	perf = to_perf_data(data);
+	cached_freq = perf->states[perf->state].core_frequency * 1000;
+
 	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
 	if (freq != cached_freq) {
 		/*
-- 
2.9.4

