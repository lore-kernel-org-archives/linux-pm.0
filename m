Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4E92723D283
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342286; cv=none; b=s2UyzCljqv6XQjYjibPyVzJj+PEsHVZiUdSvb+oIgmnTjbHJvJDTklrarDBPvzh8wEE6ROkNdzOCIsVfC7hpkyx0m4VWlA9W991oAroZLm62HXnlUGI7lZu19/p65RfbomzVNUBqEsCDGyb//Aqo/bkXavUnQpkSPKVZgcuISRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342286; c=relaxed/simple;
	bh=HraxQd17cQeLNHQGPc/+qJ8aIu9Oo+VbhqzBjyQdoaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWfWPv+NPohntzLEzk9LqUL91b+JQHvcUT47Fc+PBGwH4MeKIZOsXE7ncd5gGZ5UwGdvhCVuJFBiznVmk7zgifAxaRXUpeiC2NFhDH9yb8wt93XKXbq7h75GP0orl1pjv45L0BiCm6PT03ou62F69lciouwsQ8uGI5uJMP9h530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=QGyirXK4; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="QGyirXK4"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: Initialize cmd.val in drv_read()
Date: Mon, 10 Aug 2026 14:10:44 +0800
Message-ID: <20260810061045.2397-2-lirongqing@baidu.com>
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
	s=selector1; t=1786342272;
	bh=Fmdbg3aVYpxG3trN4JvwqC83bz/txT6RTajtfwcZ0LQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=QGyirXK4/U4EviM343QDMvbtVwU3F1vIcWc/nPGStWeC4v8iNKxyXpbsXJY9VOgVN
	 5e97rncUKkzGbQPf1uGYnKaiOiajLOMf87dE6CkidltAILsM7vdGlETPgwkUeBJzjQ
	 IRGr8ko++WiCEl9EP5ePONbEnpGYFkn63rB/NFX7sHaaNe04A0bW1k+8wsgSaAjg/g
	 zYgFI8YAxZqOfUdmHVSZMXkYoi/m5AcgSzV35eInxdTxU9BVHf6bCBv4gy0xgsUKo0
	 JogGs/8bvVo5mF6XPLdtTcI20/jOgseNgujhyKwci7OxUOj8o2ZtIRu7JCYoJzZR7X
	 00YUN4KqvMPfw==

From: Li RongQing <lirongqing@baidu.com>

In drv_read(), struct drv_cmd cmd is allocated on the stack with .val left
uninitialized. If smp_call_function_any() fails, do_drv_read() will not
run to populate cmd.val. As a result, drv_read() would return uninitialized
stack data.

Fix this by explicitly initializing .val to 0 when declaring cmd.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index cd2ca87..6c7ece9 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -308,6 +308,7 @@ static u32 drv_read(struct acpi_cpufreq_data *data, const struct cpumask *mask)
 	struct acpi_processor_performance *perf = to_perf_data(data);
 	struct drv_cmd cmd = {
 		.reg = &perf->control_register,
+		.val = 0,
 		.func.read = data->cpu_freq_read,
 	};
 	int err;
-- 
2.9.4

