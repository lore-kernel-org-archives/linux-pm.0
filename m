Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 96627339375;
	Thu, 20 Aug 2026 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191659; cv=none; b=s8PqFZTQXS5ZgAAsrDAvChwLqXUyd4dxEqJdGvNXMUCoVXId3EyymQT2N41kwQu15ig2m1XD5B+v2J7a/fHiFPIQAZFR6aheCjwgIg7ylifFHlEIlCas0iQmNiHJ+egFpPS8i7JDJvCbAqibjJRORo+O2kLX7ywb7XgN3bqgMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191659; c=relaxed/simple;
	bh=lQU91CdqWynhjBpY4FnBu+5hWWH/gec0JMtPt9m686Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq+Nhd+8LEo6K+KmMGtlmBcoVm+cR51u39PBKrbuq0j4NqsR5p4W5GboF3EUNO4+v0Jo1ZviQe0sMHpTCSIPeIZp+YIxjJvHJP6O+wlzPHrwQXgwddGlXBxIO8uA7whF2c73P1muGNk+1jIetTsIeo9CA+WNdiuwrVvMAgPHUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Y0FURG4Y; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="Y0FURG4Y"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 2/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in get_cur_freq_on_cpu()
Date: Thu, 20 Aug 2026 10:07:15 +0800
Message-ID: <20260820020715.2344-3-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260820020715.2344-1-lirongqing@baidu.com>
References: <20260820020715.2344-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1787191646;
	bh=uam25Pyvh4yZ8crwT0sbdjQulm9FUI6tvow0RUbP/KE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Y0FURG4Y7kdKVZxu1kXi+SmK3dJFyLLTcrzyW+u0vfFwqzksKBoGH4BmLpOHV8FWY
	 vZFfaiHUfk2lBpNNGuyFpiRtFaeSzRJOIeq/y5n03mAcV0qwI30BY5+ShzNi/APgCl
	 YaiqPGiMOMnui/407VXqo0DHBWbg2XfoJ2B6aHxMyLRIB+rNFgnTF5xenC6myKtVDn
	 W253TGb9vBpmsLEOFLE9gWVJmIEHxv5HSkrKGaKTGkhzETA97X3jMwigmuAug8X6cH
	 b5nlCSgd6LXTfGnpK+Fz+brwIOJktMFgPCbdBdz7P/+gjFKLPxby3FqriveqGhR+Nz
	 sBgupO9l/OXyw==

From: Li RongQing <lirongqing@baidu.com>

get_cur_freq_on_cpu() uses perf->state, which is an index into
perf->states[], to index policy->freq_table[]. However, freq_table[]
is built by filtering _PSS entries with duplicate frequencies, so its
index space no longer matches perf->states[]. The original P-state
index for each remaining freq_table entry is stored in driver_data.

Once an entry has been skipped, using perf->state as an index into
freq_table[] can therefore select the frequency of a different
P-state.

The reported current frequency itself remains correct because it is
obtained from extract_freq(). The mismatch only affects the cached
frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
change behind our back, through data->resume.

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
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a797bb2..3313c74 100644
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

