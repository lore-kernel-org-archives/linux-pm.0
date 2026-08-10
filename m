Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BC7C625392C
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342766; cv=none; b=KXgShJeu0CXIK72gR3SeOU/dnEMGq6pEzRPnNBDBdpf2hT35tb9r1eTEmVC0aFjh9em+pESY0ZwnzuJ9wNvR3q6TFGWUVSdpif5vKf1YaHMCfnnPKRndYIIot7M8kYKXvILxmi4jTbHfPwRQ+Z3qAtvN0p72jv3iOUNC0ZIbxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342766; c=relaxed/simple;
	bh=jB1oRK+rufiiuWXZUZ9mGwcGRzCTXvHt2wdj8rGb/3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUQF/5bgyf6PrPlvEEJ5WZdhALEDnJWy1BFlqC3AxhFCYtW+ZCcXKLQ7VmjI4f5yhkgXzy1WzSbiZU8wFU8L2ANh9HL3Jdl2RKjGiEFZqccJTxKkUT2PF6QuzXMJVDq8WjJJaj/WoL9TlJOXon/p+nHqKdEfBXVXcsIO0mvVP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=JCXGedqa; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="JCXGedqa"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: add NULL check for acpi_perf_data before freeing
Date: Mon, 10 Aug 2026 14:10:43 +0800
Message-ID: <20260810061045.2397-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
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
	s=selector1; t=1786342261;
	bh=HmyJBSvWVSwt94rS37ueoP6y4fED0Xf//KJuIP79BTs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=JCXGedqaxqTtxFq2KwEoVzCsJ1kR0RIiVTsSq77h/dJKfw0bw/qlktsm+9YbPqMUg
	 3ahQnDaTgcGe8kJNhdb8YfXuIfZLpN79P5q/55o/ugJQ3Ah7JTYJiOgqACjvioJ5dN
	 sPkdWrGEkcA4fGhydJkNxLzbkfkRoGoxhTMn01TqzNf1k5sOSu4es/XTqHBmzd2cb6
	 b18baCq9o0j59Y+IN2Ns/3CxfS494sz6UX0uD4OaiYEbwa5iNgZC5NZUBy64qrJGcS
	 2I0zcedEOJPuXV6EbWe3dqWvZuLSYZp+GJwGShA6fLAuMX611PXNMEdufMsqcmusWP
	 zDTS25PGPZciw==

From: Li RongQing <lirongqing@baidu.com>

If alloc_percpu() fails in acpi_cpufreq_early_init(), acpi_perf_data is
NULL.  Calling free_acpi_perf_data() will execute per_cpu_ptr(NULL, i),
which does not return NULL but an offset pointer.
Dereferencing ->shared_cpu_map on this invalid pointer leads to a kernel
crash.

Fix these issues by adding a NULL check at the start of
free_acpi_perf_data() and setting acpi_perf_data to NULL after freeing.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 87e4923..cd2ca87 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -517,11 +517,14 @@ static void free_acpi_perf_data(void)
 {
 	unsigned int i;
 
-	/* Freeing a NULL pointer is OK, and alloc_percpu zeroes. */
+	if (!acpi_perf_data)
+		return;
+
 	for_each_possible_cpu(i)
 		free_cpumask_var(per_cpu_ptr(acpi_perf_data, i)
 				 ->shared_cpu_map);
 	free_percpu(acpi_perf_data);
+	acpi_perf_data = NULL;
 }
 
 static int cpufreq_boost_down_prep(unsigned int cpu)
-- 
2.9.4

