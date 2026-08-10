Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AED0536D9F5
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342288; cv=none; b=BlQbQLxcH+OjGsNCIVIHB+odd6pdKNevvGo6L6uCPsYGmhII05G18ZoT2oue5own1AsjwmQZUc+oPCWLSTmUKSiUp1RyOJq/EjUflw9WYJCb8xQFoV/YH8fB9viVkYcYf6AF4pW+JdO3yYLJ9H7dg3933wi6AHxP57E6JIP1piE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342288; c=relaxed/simple;
	bh=q/gM4f1R1EPTLVoFKK0U/bNdFJ8Vwa5Z7UHNzdQU6Yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Js6q2cYGrO+uQUIDS3h3iP/7pjktZ/7ASCsfCKeJgHGRNqAGGytVt++w2TvjnH7HoZj9fkPAdBgY2o3/fQrWGrJVzHhJviDjo0EhGZnu0c/i93qjRalQ23Tv0nyb3fB6j3KaBxRiVqNa2MeuUQKMG6KjsKPZKhJo0wYivTkccSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=KSONNCBv; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="KSONNCBv"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: Using cpufreq_for_each_entry() to iterate in extract_io()
Date: Mon, 10 Aug 2026 14:10:45 +0800
Message-ID: <20260810061045.2397-3-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260810061045.2397-1-lirongqing@baidu.com>
References: <20260810061045.2397-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1786342274;
	bh=Y0A1Z4tza/mNoZgj9x+C9Fxm40boKOEkU7y1xLnd1RQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=KSONNCBvuo4VlLQ2BltxPELbVM69XmfBSwK4zYvb7RGRX/A+hxWwYI42w/bsKjGCw
	 JlpY9uYML2kvA3HXiMqwoJf5O7KRkbw5USVaRAvXVGYlX0Spbziq0WJiukEoeXK4np
	 mOazTZl1Mfo+NZX4+oYz2BKimTayHXEbUtAGrK/+BZDUMTLEESG1CJT+kGG5+va9iM
	 /HVychgdydWTeENXXsn1vnonMIhZG3QVA2+pq2EEonN/W4uo7VEDvgedo2WHnTDLcQ
	 XXJvFav73kpP9VvboAOlBbLaDroiMMoh5ngvgDKftYNm/obLogQHKHuNB9v5lmkB0L
	 9zngDB41yltgA==

From: Li RongQing <lirongqing@baidu.com>

In extract_io(), the loop iterates up to perf->state_count. However,
when building policy->freq_table in acpi_cpufreq_cpu_init(), duplicate
frequency entries are skipped, making freq_table smaller than
perf->state_count.

Iterating perf->state_count times directly over policy->freq_table[i] can
result in out-of-bounds array reads. Furthermore, policy->freq_table[i]
does not necessarily correspond to perf->states[i], as the original P-state
index is stored in freq_table[entry].driver_data.

Fix this by using cpufreq_for_each_entry() to iterate over
policy->freq_table, similar to extract_msr().

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9..87e4923 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -196,15 +196,14 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
 static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
+	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
-	int i;
 
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

