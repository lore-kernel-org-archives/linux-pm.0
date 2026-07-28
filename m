Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0E33F588;
	Tue, 28 Jul 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254752; cv=none; b=XeDpl3lH42NTLneULYANKw787hQMrGM0xbOIw48+1rwktyA0KGSS8fLL5iWKVGmFY9QwmqbBmNmpPIW/RScAEfukzb6VWa7OCsm5GlbECtQOsH8wH6/qION/zqXDLUFy7UFbRLrzT1JUmJr7dp/r5+grLR8VTAMk6aU3AFQznDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254752; c=relaxed/simple;
	bh=Wcio3/Oa6Ix3rJYIN/41UhejjiTiKiw25e0XYgNpLYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+lDog0g7ozu2x0vwy5fsPAhrkANHevGoqBBaoUH9eniZEti2FH1JskOTAKGw14EwPfhM0NKenAXArfDsyENX8fq7dF2+UN4154nWmua/2i/RX7GipeBnG39+1OpQc8kq+hR8NDrmvP/M1tpY5dmS1NHuGFcTqXefUI+9OrANlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Oka8E2IQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Oka8E2IQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B4A169E;
	Tue, 28 Jul 2026 09:05:46 -0700 (PDT)
Received: from e127648.cambridge.arm.com (unknown [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2E233F763;
	Tue, 28 Jul 2026 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254750; bh=Wcio3/Oa6Ix3rJYIN/41UhejjiTiKiw25e0XYgNpLYA=;
	h=From:To:Cc:Subject:Date:From;
	b=Oka8E2IQM3xBxFSz4W0mkU0yQ2mGbZhlVQj5q2dwzU5dhiKOl92PHBPB/Y5ZQmVl1
	 xCdKcu7R/Sj4FYZrBCIpOx0Oamf8aMLQyBXOcBrognONyNApft4LCB5NBdwqcI9YRv
	 +OqZFHRp1BWGWdAiy1SGj4GGHPGNShn8AALx92RU=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] ACPI: CPPC: Gate desired performance getter on ACPI <6.6
Date: Tue, 28 Jul 2026 17:05:38 +0100
Message-Id: <20260728160538.2574100-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
calls cppc_get_desired_perf() because some platforms repurpose Desired
Performance to report actual delivered performance.

ACPI 6.6 changed the register's Optional Attribute from Read/Write to
Write. The existing cppc-cpufreq error path now falls back to its
cached OSPM request on ACPI >=6.6.
The original (and existing) workaround was for a specific HiSilicon
platform which isn't expected to report >=6.6.

Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
---
 drivers/acpi/cppc_acpi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..218fdea09c1c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1321,10 +1321,17 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
+ * errno otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
+	/* ACPI 6.6 no longer specifies Desired Performance as readable. */
+	if (acpi_gbl_FADT.header.revision > 6 ||
+	    (acpi_gbl_FADT.header.revision == 6 &&
+	     acpi_gbl_FADT.minor_revision >= 6))
+		return -EOPNOTSUPP;
+
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
-- 
2.34.1

