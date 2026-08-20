Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AB3E6280325;
	Thu, 20 Aug 2026 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191659; cv=none; b=S5HzeSgO/dkRdP9RS2Q/qsZpKiHTi9ZilU5z3tiQHHgh47W8QaEw/cAWvk16s8Rc9WuLqCMdCxnxLY9a8qY1Yb8A59hlboi+O1ydVwco5/XoVI6FJM0h0A1YLs+Sxm2EJxcD0/nzcpZSz+tT3rnppLKtJWBWgbE9k0yc+X8OPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191659; c=relaxed/simple;
	bh=6m8Nt5AsKbvDcvM0ImQ3oNa47aJT8oxpmBwmLs7m3JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjbZOf0fSIKpArjUDBUYhO1O1gq6jJ9Q+PETa6C4iwxG9ytoOfFA3Zd/5JAgytPw0wZ0TtNW5Mhj7IILtIEUCG/WBSDts60j170cavChVVs8MDd0SrfKWIeUFj6BhXt2NcUzCuaR0hLprFx5QQ/7bbgnliCQNBO+p6Ns8yVRQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=dB6sek7w; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="dB6sek7w"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v3 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
Date: Thu, 20 Aug 2026 10:07:14 +0800
Message-ID: <20260820020715.2344-2-lirongqing@baidu.com>
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
	s=selector1; t=1787191644;
	bh=xIpWUOPU86l3d4TOXdsDBzOPYuQjxDi383QnNELWQyc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=dB6sek7we4wz5yC3q9g/5W3tVoiAhZNnks8LskNrLGxukzYlkcO3/gQDIHhTBeK8q
	 tW5y0BSfLn3NiMNDPSBD2uqJ+K0zU839AO3QY/8FjZAPsbwWcNAyfVGWEaqIWlQx2A
	 JXGDiUfdJ2CLMEa5NnIzAdxnLLnxdjIQRKsq9UiEQqPFn29eQIKH5xRSBaqMzv41Cv
	 N+SMApv+DGcPsSgqBzKiaoK+92y7lQZrsrx4bDKgvc7C34w5i7B0nSzc78YG2L2xSI
	 zsstPpsu5H2OImRc4DUNhNcG5fP7fKn9//Q+XlJ3ComuAwUFJtRBhXigWW5qWRKJO5
	 47l79vZsnQq+g==

From: Li RongQing <lirongqing@baidu.com>

When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
with duplicate frequencies are skipped. For each remaining entry,
freq_table[].driver_data stores the original ACPI P-state index, so the
index space of freq_table no longer matches perf->states[].

extract_io() currently walks perf->states[] with index i and uses the
same i to index policy->freq_table[i]. When duplicate frequencies
exist, this can associate a P-state status with the frequency of a
different P-state. It can also access an invalid or sentinel entry in
freq_table when the number of entries in perf->states[] is greater than
the number of entries remaining in the frequency table.

extract_io() is used on ACPI_ADR_SPACE_SYSTEM_IO platforms by the
frequency verification path, which is enabled by the
acpi_pstate_strict module parameter. With the mismatched lookup,
check_freqs() can fail to match the frequency of the P-state that
drv_write() has already programmed. It then retries the check for all
iterations before returning -EAGAIN, leaving perf->state at its
previous value while the hardware is running at the newly requested
P-state.

The cpufreq core consequently keeps policy->cur at the old frequency.
Since __cpufreq_driver_target() returns early when the requested
frequency equals policy->cur, the driver is not called again for that
frequency and the control register is not rewritten. The hardware can
therefore remain at a frequency that differs from the frequency known
to the cpufreq core.

Fix this by iterating over policy->freq_table and using
pos->driver_data as the original ACPI P-state index when accessing
perf->states[], as extract_msr() already does.

Fixes: fe27cb358835 ("[CPUFREQ][2/8] acpi: reorganize code to make MSR support addition easier")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 10ea603..a797bb2 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
-	int i;
+	struct cpufreq_frequency_table *pos;
 
 	perf = to_perf_data(data);
 
-	for (i = 0; i < perf->state_count; i++) {
-		if (value == perf->states[i].status)
-			return policy->freq_table[i].frequency;
-	}
+	cpufreq_for_each_entry(pos, policy->freq_table)
+		if (value == perf->states[pos->driver_data].status)
+			return pos->frequency;
 	return 0;
 }
 
-- 
2.9.4

