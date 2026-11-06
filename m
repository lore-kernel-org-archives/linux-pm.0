Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990433;
	b=LIHxnTvGvypkZMfHrbsbM6rTbpfvMr8OjT20USK0SOJgQrqSDdx+Bm68tCyrCFDc3/IB
	 Q7auUwkHesQBL1sSRJ2/unAQy5h/QxMbHkAmxrDaAVR8Tz7Wz1lyockxfecoawP0UwO1E
	 Na2CvqqUe7HpdYlBAdKfrVFSTLGLtFXyFc6gmfYrl/fCR/srpZDjIjXAgnfDZ0Yg+bHl1
	 cWS/M4HoQPttUKPOhh+Knyo7T3R5tlpLRcyVIBIBSFC26l2QBey2CAL9Og0o/DlwyJmCv
	 mu6/frKqgoHtEk2WlHCGTJq/5cI/OAOj2/FBwVlDTSlgk4HjK9f/fkwtKg3DW0iL33g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990433;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=dD9Jc4MUJJjWX3IdDDc2c7Pi6LPWA9Vl7DVbTkz35WA=;
	b=wayWZzXSN+nMaqoqEXIHV6NHk/6txW9+HMk3TvVAfS5Bse23zyQ0tH8I8HmfQnZaZsZW
	 H/UARydqGKHD2LjiF+S+tcnDgjGZNU57GYTxCN2UeoA2Dyz5OzFQ9syxdHY8C5BxqQtJa
	 zarCSHSJJLT3D3oou09U5wyPtuo65rS73dCMBeMT6fMjUxFppvpPm6V5ABb5ffNaQaQKq
	 Zj0sDsSA6NejWl5OELcM8nTnN9QONC98//ZwpAQ+fK2ZRJ4w0DPOwsq679QneptLLbAh+
	 /p2yWQJYKZ8hqsqUzBN/FJTucmau8WxLzuF/mvGxetMK+4zWQkkU2g75hDk+CFQkMCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=L6hwz7HK;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2275E606A32C;
	Fri,  6 Nov 2026 18:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2275E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=L6hwz7HK
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v5 2/2] cpufreq: acpi-cpufreq: don't mask firmware P-state changes
Date: Sat, 7 Nov 2026 02:40:08 +0800
Message-ID: <20261106184008.1728-3-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261106184008.1728-1-lirongqing@baidu.com>
References: <20261106184008.1728-1-lirongqing@baidu.com>
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
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793990423;
	bh=dD9Jc4MUJJjWX3IdDDc2c7Pi6LPWA9Vl7DVbTkz35WA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=L6hwz7HKrJRlIgewUpsC3itxSUudwcKAQi0p1FauYQKC7s7aJ/uB39u0c9cI0qiDk
	 EN/LWPm3j8LxZL6JumgJlEFkdoMK1n6ShGsxGbqdwct7B7+/dY9/hQhJ7VBnfIcjpa
	 l5xP1rYkNuPMnzJOP51NlH1RcKMsqpnG9gD0hC6ichZm4cJTqmxZg5LgKyhF9eZl/H
	 OTRvp0+mhJ1XNVCZQC9T9af3d4GyvqtTDlyiByR7GPTxBr/Skbx/D8zeyAOPABSH1N
	 uq4nkvJAfcQMiAS49MLpRly5tIUnARQowRVBN5MEwyZW8x6hhFZQ2YN/4evmj7B8sm
	 H0pQZqHIi+Iqw==

From: Li RongQing <lirongqing@baidu.com>

get_cur_freq_on_cpu() detects a firmware frequency change behind the
OS's back by comparing the frequency decoded from the hardware with the
frequency cached by the cpufreq core. The previous patch fixes the
cached side of that comparison; this patch fixes the decoded side.

policy->freq_table is built by filtering out _PSS entries that are not
lower in frequency than the previous one, so firmware may autonomously
switch the CPU to one of the filtered-out P-states. The status of such
a P-state matches no freq_table entry, and extract_msr() then falls
back to freq_table[0].frequency, i.e. the highest frequency, instead of
reporting that the status is unknown.

As a result the comparison is defeated exactly when the OS is already
at the P-state corresponding to freq_table[0], which is particularly likely 
under the performance governor: freq equals cached_freq, data->resume is
left clear, and the next ->target() call short-circuits without
rewriting the control register, leaving the CPU at the firmware-selected
P-state. Fixing the index mismatch alone therefore does not make the
detection work in that case.

Return 0 from extract_msr() when the status cannot be matched so that
the fallback no longer hides the firmware change, and treat a zero
result as a firmware frequency change in get_cur_freq_on_cpu(). Keep
returning the cached frequency to the cpufreq core in that case: a zero
return value there would be indistinguishable from a read failure and
would feed 0 into the cpufreq statistics. This also covers the
ACPI_ADR_SPACE_SYSTEM_IO path, where extract_io() already returns 0 for
an unmatched status.

check_freqs() is unaffected: it compares against a frequency taken from
freq_table, which is never 0, so an unknown status keeps the
verification loop from declaring success.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260910111329.2220-1-lirongqing@baidu.com
Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIOS freq changes behind our back.")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 2d7d147..1e7dc1c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -225,7 +225,7 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 	cpufreq_for_each_entry(pos, policy->freq_table)
 		if (msr == perf->states[pos->driver_data].status)
 			return pos->frequency;
-	return policy->freq_table[0].frequency;
+	return 0;
 }
 
 static unsigned extract_freq(struct cpufreq_policy *policy, u32 val)
@@ -373,12 +373,14 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	cached_freq = perf->states[perf->state].core_frequency * 1000;
 
 	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
-	if (freq != cached_freq) {
+	if (!freq || freq != cached_freq) {
 		/*
 		 * The dreaded BIOS frequency change behind our back.
 		 * Force set the frequency on next target call.
 		 */
 		data->resume = 1;
+		if (!freq)
+			freq = cached_freq;
 	}
 
 	pr_debug("cur freq = %u\n", freq);
-- 
2.9.4

