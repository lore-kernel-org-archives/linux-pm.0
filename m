Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0C471261;
	Fri,  7 Aug 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101220; cv=none; b=aAVsVkbDE6T2Tb3Z6lFfu14Dxye6v+XdB+kNs7OVbbLr13b6jtGMkORxlU4/ZP82Q9wJKyUSNc6B5iSZlMkQK8/fubwrPBnofJU3RwPsC3awbzu4i/BOgOaLMhDSGBPKQNWwURswIRPIMQBTF1CUkh31+ons/UielOIxS0MvdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101220; c=relaxed/simple;
	bh=xtYUjaz4kqYWBu2sRoCb5xQ2itq3E5AJCeih7KTzi+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgQOu72xeCEWak4KcjZKw553PkR3PyY7rkyNgIetekmhsmWhE4leIHzoMTI2ZBGudfA+FxkG5/0EHlQkaASZ/TqsZ20LD/jcs4bfO5OxtNigR7Y+ln65sB3JasyGgzTYuV6baMagBjNNKKeDI8QV8ZQ/CUpWbGzEYkw3wWg5SVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P/1NGJwy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P/1NGJwy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB291516;
	Fri,  7 Aug 2026 04:13:33 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AACD33F86F;
	Fri,  7 Aug 2026 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101217; bh=xtYUjaz4kqYWBu2sRoCb5xQ2itq3E5AJCeih7KTzi+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/1NGJwy+GOp9I3mxoH60YzMJxkO112Ffii/o/ClgBbeql+gKbMwbgY6LGBGVhU0/
	 b9zBDw/GlZtlgo7dwrqANq1nR1JddNUV7r+AlnFmFhZaPoZw223E6lalQAgz4f/03t
	 xSFN6Y5Q8UtNwUTK5psSdrJWg+8vXFgOf5of7Cno=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 10/15] ACPI: CPPC: Reject reads and RMW of write-only controls
Date: Fri,  7 Aug 2026 12:12:58 +0100
Message-Id: <20260807111303.1062391-11-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807111303.1062391-1-christian.loehle@arm.com>
References: <20260807111303.1062391-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between _CPC revision 3 and revision 4, Desired Performance changed from
Read/Write to Write.  Revision 4 also added the write-only OSPM Nominal
Performance control.  ACPI 6.6 section 4.6.3 says reads of write-only bit
positions produce undefined results.

The exported Desired Performance helper already rejects revision-4
readback, but the common register accessor still permits either write-only
control to be read.  Reject both centrally so new callers cannot bypass the
revision rule.

A partial SystemMemory field would also make cpc_write() read its complete
access unit to preserve bits outside the field.  Reject revision-4
descriptions of either write-only control when their geometry requires RMW.
A full-width description remains supported and is written without a
preceding read.

Fixes: 71e1815113f7 ("ACPI: CPPC: Add support for CPPC v4")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2bb7d74fc8e7..14f672392433 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -333,6 +333,13 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
 	}
 }
 
+static bool cpc_reg_is_write_only(const struct cpc_desc *cpc_desc,
+				  unsigned int reg_idx)
+{
+	return cpc_desc->version >= CPPC_V4_REV &&
+	       (reg_idx == DESIRED_PERF || reg_idx == OSPM_NOMINAL_PERF);
+}
+
 static bool cpc_sysmem_reg_needs_rmw(const struct cpc_register_resource *reg)
 {
 	const struct cpc_reg *gas = &reg->cpc_entry.reg;
@@ -363,6 +370,17 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
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
@@ -1737,6 +1755,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
+	if (cpc_reg_is_write_only(cpc_desc, reg_idx))
+		return -EOPNOTSUPP;
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-- 
2.34.1

