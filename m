Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F475470137;
	Thu, 10 Sep 2026 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038954; cv=none; b=VHc7Lj9BmLu1zjC5mVuYGIn0HAkqlZE5jyuk4gsr1oEl8WeD24aQH6ABt6Dkjf9yCHO1wVrbvA9MnoL7BVLa7K/htVBfR788WSr2ikBauRdOG1+m99kd2BfAnh2TKL8AE1VYXCthCOm7Ms09N+GSzFeYSI/3TvOxeb5m8UtMlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038954; c=relaxed/simple;
	bh=lRF7Dl5bp2u7TMi46n+iGbduop9cF1vcUheNOrG7UoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5AXfUWXoSpp0tw7cnCXuJTH3OEKqGZzmwWUJQpPbI9g14sdRgpN6H5WMYB+AhmL7aqoKLKra+06n+v+uwkAbADpxEuxXtf+VOTrLefIdbt94DV0FOnQpghLxFn6M+o0IaZRoI094hyL2HFlAh5tKAyrekCOXqoUY8Cu4DssAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Z/Ji7Ktx; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="Z/Ji7Ktx"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v4 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
Date: Thu, 10 Sep 2026 19:13:28 +0800
Message-ID: <20260910111329.2220-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260910111329.2220-1-lirongqing@baidu.com>
References: <20260910111329.2220-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789038822;
	bh=RpVinj4s0Rh3TFJZafzq4jkBDp+N9yNwbfL62hb/wKU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Z/Ji7Ktxd+cz4db5O+zKJhPYN5AYBi/uj+wpamNPoGALZD8GYYhd5fnus5jV5eoK+
	 ndEvWBcOhw39TA6w0AOAAO9cBqf8F8NDxvH6IXm1npq2tMOb/+uz1IbL9pJ0i8/xrA
	 HoTJ0w+kH/ibGtqRIDyrjLCxtYt73yNWhdqIpKxlWCwWR2Ldr7Ei/ODBBxWRv6+geR
	 iu1HqoCLq906vkvOJ62eSZTQjmUDIZ/4mBNPCKn3EKS1UWJpJ+xwnmoq9DlNJQNUfK
	 VIu7GAtPY3LaxUJFUlNhzEl+J0OJRqYQQEw3VJBHlEwl3hg//82rEM87ssTrp/x8bO
	 hul7BtDvVQZeg==

From: Li RongQing <lirongqing@baidu.com>

When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
that are not lower in frequency than the previous one are skipped.
For each remaining entry, freq_table[].driver_data stores the
original ACPI P-state index, so the index space of freq_table no
longer matches perf->states[].

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
drv_write() has already programmed. It then sleeps through all 100
iterations - at least ~1 ms of usleep_range() plus 100 cross-CPU
calls and I/O port reads, all with policy->rwsem held, and
.target_index() returns -EAGAIN, leaving perf->state at its previous
value while the hardware is running at the newly requested P-state.

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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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

