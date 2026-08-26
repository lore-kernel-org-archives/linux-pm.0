Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339553B6C19;
	Wed, 26 Aug 2026 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725864; cv=none; b=u+ly2jZdGqDnMa/QROB7hs/A8JwQfs5uZJ5QKSGHi6P+u3gTYgEM8ehCgn/+9JGv7ISxA8k3tPf1BqwMMTDNULekuacZozIoOtd06Rz0FYcn9JibOuqF91xD0tX+L1QNpSYX0VMia+aidtfcZ0HiVkWgceHPDYkrnzQaaZ0OlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725864; c=relaxed/simple;
	bh=+jb7/evfvaXfr2UU41bo8k+Fmp+ILyAQkKCXJznvETE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEDaNOrfvIrrpzBXp5NXSUOMpnfgFHTY0rEPZh5Ong63buDVcVQq0/cR0l/pbJpFFsfm2cexdA7Az8pMN/wf2/QWbgqPJLa+0DPfI/B3AU/EognCxRtVGr6BGLNiBdfdGQv+lpTUs3XCsGjo0NELYPl9+QWRD1ni9VxK+aod9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vFgGHy0P; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vFgGHy0P"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E1AD16F2;
	Tue, 25 Aug 2026 23:30:55 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8D663F7D8;
	Tue, 25 Aug 2026 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725859; bh=+jb7/evfvaXfr2UU41bo8k+Fmp+ILyAQkKCXJznvETE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFgGHy0PzDYC/83GHEg6kv6ljU2Wuk3QUwK+7Sj18EPyBxqG+3pIKJy5pdpYeEeXt
	 ztyKgkUiWmwzr7ksBLDwmSClU2b45eMaF9zlanRNk5C/wRLyGrNjwwieQaC8ONHxxq
	 myCj4I+J4LMjWwaO9U9KmmZ7WCbClQfc0HdsrdEI=
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
Subject: [PATCH v4 10/15] ACPI: CPPC: Reject direct reads of write-only controls
Date: Wed, 26 Aug 2026 07:30:14 +0100
Message-Id: <20260826063019.670240-11-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826063019.670240-1-christian.loehle@arm.com>
References: <20260826063019.670240-1-christian.loehle@arm.com>
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
access unit to preserve bits outside the field. This is valid because
MASK_VAL_WRITE() replaces every bit of the write-only field, discarding its
undefined readback while preserving the surrounding bits. The descriptor
lock serializes the RMW, and the preceding SystemMemory validation rejects
unsafe cross-descriptor partial writers.

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
 drivers/acpi/cppc_acpi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 61afb44d552c..a5920e627d00 100644
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
@@ -1291,6 +1306,17 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
@@ -1684,6 +1710,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		if (reg->bit_offset || reg->bit_width != size) {
+			/*
+			 * MASK_VAL_WRITE() discards the field's old bits, so undefined
+			 * readback from a write-only field is not propagated.
+			 */
 			switch (size) {
 			case 8:
 				prev_val = readb_relaxed(vaddr);
@@ -1775,6 +1805,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx))
+		return -EOPNOTSUPP;
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-- 
2.34.1

