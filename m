Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6B3AE706;
	Sat,  8 Aug 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177705; cv=none; b=E9Li2Sth28blZHQf5yinDXu+qBboWKNzoHEAkVUjGqmf9iAZ1OGP8P0fnqUz6sF/2hJ5U4/sTqaX4ALGQD7ORn185oKk1mLYBJjnHE93O9mVSVtZ2hELzhDKdwyBOCpDLJZvmDwrSuDuyZoF7BiUvXqByHYmhxFgGQL4zYshIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177705; c=relaxed/simple;
	bh=BQkpnVi240xTDiTC9ce9zDxoG1bHz0Okq8GhmS1txTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L28cgZAqeKqbZXhtl/2DZFdFi+PsQCwCnKr6E457EIYdaLpe+RqN7Ss8ofRSSFDNSDFipBHYp/jkH3kuvvvNkPge2V/WLRCnVDVMP5CMjl632wxMnnHInsaedbV6luiVd4PrUyg7yxT0q2ibJX4C5T60+OjlhsTJZ9s6lgAulK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V9o0nCv6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V9o0nCv6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073C81A9A;
	Sat,  8 Aug 2026 01:28:19 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62BDF3F9A2;
	Sat,  8 Aug 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786177703; bh=BQkpnVi240xTDiTC9ce9zDxoG1bHz0Okq8GhmS1txTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9o0nCv65AtLsMrZfH6NXsiySU/R+TJ1iutYHx0nSbZwjwpPbqkQOHIsFfbZK2fcB
	 zuWCSGUx4YbT64DvzSuPnsQMLXT+NiZ1nm6Bz+6W+8dfS3lE3v4kg1TrZsWxYdP5d7
	 yXNDSd61OoeaZmY7j3YH+3nJYCKmNutEEvVQkJq0=
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
Subject: [PATCH v2 12/15] ACPI: CPPC: Validate SystemIO register layouts
Date: Sat,  8 Aug 2026 09:26:41 +0100
Message-Id: <20260808082644.1251332-13-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808082644.1251332-1-christian.loehle@arm.com>
References: <20260808082644.1251332-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpc_read() and cpc_write() access SystemIO registers using the complete GAS
access width. They do not apply Bit Offset or preserve bits outside the
described field. Accepting a partial register therefore reads the wrong
value and can clobber adjacent fields on write.

Only retain full-width 8-, 16-, and 32-bit entries with Bit Offset zero
whose complete access lies in the 16-bit I/O port space. Keep accepting
Access Size zero when Bit Width supplies one of those sizes.

When CONFIG_HAS_IOPORT is disabled, mark SystemIO layouts inaccessible
during probe. Also return -EOPNOTSUPP explicitly in cpc_read() and
cpc_write() so a SystemIO entry can never fall through and treat its port
number as a physical-memory address.

Resolve inaccessible entries using the control-specific policy established
for PCC: optional fields can be disabled, while mandatory or semantically
required controls fail probe. Reject overlapping logical port ranges when
either entry is writable; read-only overlaps remain allowed.

These rejected partial forms are permitted by ACPI, but never worked with
the existing whole-width Linux accessor. Implementing them would require
field-aware I/O and appropriate RMW serialization.

Fixes: a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 53 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 67fadb43c65a..c39b022f1573 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -225,7 +225,6 @@ static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value)
  */
 #define NUM_RETRIES 500ULL
 
-#define OVER_16BTS_MASK ~0xFFFFULL
 #define CPC_GENERIC_REGISTER_DESCRIPTOR 0x82
 #define CPC_GENERIC_REGISTER_LENGTH (sizeof(struct cpc_reg) - 3)
 
@@ -1519,21 +1518,28 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr = addr;
 				}
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
-					/*
-					 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
-					 * SystemIO doesn't implement 64-bit
-					 * registers.
-					 */
-					pr_debug("Invalid access width %d for SystemIO register in _CPC\n",
-						 gas_t->access_width);
-					goto out_free;
+				u64 access_size;
+				const char *reason = "uses unsupported SystemIO geometry";
+				unsigned int access_width;
+				bool unsupported;
+
+				access_width = cpc_reg_access_width(gas_t);
+				unsupported = !IS_ENABLED(CONFIG_HAS_IOPORT) ||
+					      (access_width != 8 &&
+					      access_width != 16 &&
+					      access_width != 32);
+				if (!unsupported) {
+					access_size = access_width / 8;
+					unsupported = gas_t->bit_offset ||
+						gas_t->bit_width != access_width ||
+						gas_t->address >
+						U16_MAX - (access_size - 1);
 				}
-				if (gas_t->address & OVER_16BTS_MASK) {
-					/* SystemIO registers use 16-bit integer addresses */
-					pr_debug("Invalid IO port %llu for SystemIO register in _CPC\n",
-						 gas_t->address);
-					goto out_free;
+				if (unsupported) {
+					pr_debug("CPU%d: _CPC register %u %s\n",
+						 pr->id, i - 2, reason);
+					unsupported_regs |= BIT(i - 2);
+					continue;
 				}
 				if (!osc_cpc_flexible_adr_space_confirmed) {
 					pr_debug("Flexible address space capability not supported\n");
@@ -1624,6 +1630,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					     "PCC");
 	if (ret)
 		goto out_free;
+	ret = cpc_validate_non_mmio_overlaps(cpc_ptr,
+					     ACPI_ADR_SPACE_SYSTEM_IO,
+					     "SystemIO");
+	if (ret)
+		goto out_free;
 
 	ret = cpc_validate_required_controls(cpc_ptr);
 	if (ret)
@@ -1752,11 +1763,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 	size = GET_BIT_WIDTH(reg);
 
-	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
-	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		u32 val_u32;
 		acpi_status status;
 
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+			return -EOPNOTSUPP;
+
 		status = acpi_os_read_port((acpi_io_address)reg->address,
 					   &val_u32, size);
 		if (ACPI_FAILURE(status)) {
@@ -1852,10 +1865,12 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 
 	size = GET_BIT_WIDTH(reg);
 
-	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
-	    reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		acpi_status status;
 
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+			return -EOPNOTSUPP;
+
 		status = acpi_os_write_port((acpi_io_address)reg->address,
 					    (u32)val, size);
 		if (ACPI_FAILURE(status)) {
-- 
2.34.1

