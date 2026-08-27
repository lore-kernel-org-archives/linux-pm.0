Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078C364EAA;
	Thu, 27 Aug 2026 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812302; cv=none; b=CnD1B2UKXqJcNNLstwnwjQuhOvdQRCfU2viQ51dHKltqsY3iwqW/PXn6n7r2gzNvvwio2+USk05VVhTVEU8C9Z/+ro+szMUr6OIoxmY1Y1joMhy1zOhCFbLDfJPynFvML/pD1xahmTY15JdCj1I6yU4ApyAKK1oJHjB0aZ9vxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812302; c=relaxed/simple;
	bh=pKoTNaV5uTjmczuk05FrTbeYCimwTUMRNY2S3fZnUMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjFNLHsUdESyU6s0GMMxjjBLebpVyGwWZlRPDPJlUiXPw38ytKGqtBkScHzdp59LcX+7YaKkNaHnCr27P5yb9lrSwP/TRNVL7qiORty5OdbEJUuWiUk/3efysnxNwICSm0k6tY05U6gt4ep3VGIJgHe1gUtMmDYw/BMqVsymSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vGWUzbX9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vGWUzbX9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01FEA1691;
	Wed, 26 Aug 2026 23:31:32 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.73.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B3A93F85F;
	Wed, 26 Aug 2026 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787812295; bh=pKoTNaV5uTjmczuk05FrTbeYCimwTUMRNY2S3fZnUMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGWUzbX9V6TzR4voyzcmGL4Vr4T39hZB1ZQqMQuha7gr8W0Y60rWHoO4A/XIbshlK
	 EJVaVU0doo9ZpzPCgM1mfPlP/k7XkZsF+gEmo9BzTv106jN6MIxzDNjGFYuEykODnr
	 C8n+8GOf1M3s68SxbxvtQ/vBJhlTKV+mQ/9amzuk=
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
Subject: [PATCH v5 10/15] ACPI: CPPC: Reject direct reads of write-only controls
Date: Thu, 27 Aug 2026 07:30:55 +0100
Message-Id: <20260827063100.2741066-11-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827063100.2741066-1-christian.loehle@arm.com>
References: <20260827063100.2741066-1-christian.loehle@arm.com>
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
be read. Reject both centrally so new callers cannot consume undefined
values.

A partial SystemMemory field still makes cpc_write() read its complete
access unit to preserve bits outside the field. MASK_VAL_WRITE() replaces
every bit of the field being written, so that field's undefined readback is
not propagated. However, another writer sharing the access unit would
preserve and replay the write-only field when performing its own RMW.
Reject such pairs; a partial write-only field may share its access unit
only with disjoint read-only fields. The descriptor lock serializes
supported RMW, and the preceding validation rejects unsafe cross-descriptor
partial writers.

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
 drivers/acpi/cppc_acpi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e1fbbf46128e..aa5bf02b85a4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -347,6 +347,21 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
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
@@ -495,6 +510,14 @@ static int cpc_validate_sysmem_pair(const struct cpc_desc *a_desc,
 	    (a_desc != b_desc && a_writable && b_writable))
 		goto conflict;
 
+	/*
+	 * RMW of either writer preserves the other field.  If that field is
+	 * write-only, its readback is undefined and cannot safely be replayed.
+	 */
+	if ((cpc_reg_is_write_only(a_desc, a_idx) && b_writable) ||
+	    (cpc_reg_is_write_only(b_desc, b_idx) && a_writable))
+		goto conflict;
+
 	return 0;
 
 conflict:
@@ -1336,6 +1359,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
@@ -1726,6 +1760,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		if (reg->bit_offset || reg->bit_width != size) {
+			/*
+			 * MASK_VAL_WRITE() discards the field's old bits, so undefined
+			 * readback from a write-only field is not propagated.
+			 */
 			switch (size) {
 			case 8:
 				prev_val = readb_relaxed(vaddr);
@@ -1817,6 +1855,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx))
+		return -EOPNOTSUPP;
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-- 
2.34.1

