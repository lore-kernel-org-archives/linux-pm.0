Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344238E12B;
	Sun,  9 Aug 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786256796; cv=none; b=gRBdA3BgS0/Hi4pPsuf7yMzht+VNldmh8AGLmQn+H1UmmEqCgMCtBDlZP1/Sh4wQNJTy5TbjVuZ3va3jINQfPT99Yxfqh8aRIl3YPAPIq/uKwXPBymf7c5Uhd0VyuUhbRZQjWhfS1Gu3DfWuKJ8vyHmkwhmbDwEykPDKd8Y8arU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786256796; c=relaxed/simple;
	bh=/RQ2+r0TNEug5T7Zux9bb8mgmAOL/CC7MsjBAjkEyfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMMVsUgi7qImeMWE0lRciWnroIJnnEMbiCaXuC/wN8FwR4f2ZA3FKi5AorHx9QBRecW+A6FhoBXss22aqTxFuyrQTK+9s4462ZFXw3XNjC043Rbs5lHlfwjFV/TBpr2XPb7T4hlZziPkUZudUVpZOoPUqoqJ/D4gcBDEhyOxTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SjAxLv66; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SjAxLv66"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56EA91596;
	Sat,  8 Aug 2026 23:26:30 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DDD03F9A2;
	Sat,  8 Aug 2026 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786256794; bh=/RQ2+r0TNEug5T7Zux9bb8mgmAOL/CC7MsjBAjkEyfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjAxLv666FJNUnpsvXUnlnaLOvO8BcpMC1hHOb8Oef48znFaEQeIWR/1L+tqz/5vd
	 2npWFvk1K9IA0t5FE+jyMox9p37coIyxHvsBflim1xetP0//ITEliFavOaWEGkhnvr
	 XprG3h6L2ujHB8TpqYqm3eVKkdg63CE4yPhBuks4=
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
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 10/15] ACPI: CPPC: Reject reads and RMW of write-only controls
Date: Sun,  9 Aug 2026 07:25:44 +0100
Message-Id: <20260809062549.1415955-11-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809062549.1415955-1-christian.loehle@arm.com>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between _CPC revision 3 and revision 4, Desired Performance changed from
Read/Write to Write. Revision 4 also added the write-only OSPM Nominal
Performance control. ACPI 6.6 section 4.6.3 says reads of write-only bit
positions produce undefined results.

The public Desired Performance helper already rejects revision-4 readback,
but the common register accessor still permits either write-only control to
be read. Reject both centrally so new callers cannot bypass the revision
rule.

A partial SystemMemory field would also make cpc_write() read its complete
access unit to preserve bits outside the field. Reject revision-4
descriptions of either write-only control when their geometry requires RMW.
A full-width description remains supported and is written without a
preceding read.

Mark an inaccessible OSPM Nominal Performance control unsupported because
it is optional. Do the same for inaccessible Desired Performance while
parsing, then let the post-parse control check accept it only for immutable
autonomous selection. This preserves the autonomous-only exception without
accepting an unusable Desired control in non-autonomous mode.

Fixes: 71e1815113f7 ("ACPI: CPPC: Add support for CPPC v4")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Link: https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8967ffdac76f..26e4c83dc2df 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -333,6 +333,21 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
 	}
 }
 
+static bool cpc_reg_is_write_only(const struct cpc_desc *cpc_desc,
+				  unsigned int reg_idx)
+{
+	return cpc_desc->version >= CPPC_V4_REV &&
+	       (reg_idx == DESIRED_PERF || reg_idx == OSPM_NOMINAL_PERF);
+}
+
+static void cpc_disable_reg(struct cpc_desc *cpc_desc, unsigned int reg_idx)
+{
+	struct cpc_register_resource *reg = &cpc_desc->cpc_regs[reg_idx];
+
+	reg->type = ACPI_TYPE_INTEGER;
+	reg->cpc_entry.int_value = 0;
+}
+
 static bool cpc_sysmem_reg_needs_rmw(const struct cpc_register_resource *reg)
 {
 	const struct cpc_reg *gas = &reg->cpc_entry.reg;
@@ -363,6 +378,17 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
 	if (gas->address & (access_size - 1))
 		goto invalid;
 
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx) &&
+	    (gas->bit_offset || gas->bit_width != access_width)) {
+		const char *name = reg_idx == DESIRED_PERF ?
+				   "Desired Performance" :
+				   "OSPM Nominal Performance";
+
+		pr_err("CPU%d: _CPC v%d %s register requires unsupported read-modify-write\n",
+		       cpc_desc->cpu_id, cpc_desc->version, name);
+		return -EINVAL;
+	}
+
 	return 0;
 
 invalid:
@@ -1291,6 +1317,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					size_t access_width;
 
 					err = cpc_validate_sysmem_reg(cpc_ptr, gas_t, i - 2);
+					if (err && (i - 2 == DESIRED_PERF ||
+						    i - 2 == OSPM_NOMINAL_PERF)) {
+						const char *name = i - 2 == DESIRED_PERF ?
+								   "Desired Performance" :
+								   "OSPM Nominal Performance";
+
+						pr_warn("CPU%d: disabling inaccessible %s register\n",
+							pr->id, name);
+						cpc_disable_reg(cpc_ptr, i - 2);
+						continue;
+					}
 					if (err) {
 						ret = err;
 						goto out_free;
@@ -1759,6 +1796,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx))
+		return -EOPNOTSUPP;
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-- 
2.34.1

