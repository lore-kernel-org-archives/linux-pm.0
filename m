Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBEE43148E;
	Fri,  7 Aug 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101196; cv=none; b=kZoGmOMPfxTES+iiNTv+vHWNA76O/UQvDSbJ+PITrG37kSdynA2y/q9WGuEdjt7pwe6X80NGbLJ8dhmO+BMXhda4xn4Hg51MZPYTFOwKIaEpgFMKylLUVWLRoOvKDHrlC0S1Wy9xNZNHODcry6AJ9qnabm3QqlWlLH42A2HJSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101196; c=relaxed/simple;
	bh=RxPYlS/UVdd2pz1eChWAGRQslOXWXnUCeu0mgGU0+SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1bmFlG09BbS7HinClNMGSvmdNsg0ZdwF5kfCncsefv9EFiTi57WhPjqswUa58BUPGPnfmHwPzZmq/UM1U7M6lJwSsOgVWWsdFbLOlh02tFeRYJLnWw+HlfLqIbU50l/cfRjskstxAhykOGN+BFQ4LFlQQF6LMApCej3FaNRgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PquvfEf9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PquvfEf9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC061A9A;
	Fri,  7 Aug 2026 04:13:10 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 622903F86F;
	Fri,  7 Aug 2026 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101194; bh=RxPYlS/UVdd2pz1eChWAGRQslOXWXnUCeu0mgGU0+SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PquvfEf9q+14hip8dybKaMXMM9ToS2q8kuHB63MjfMLQwBL6/YoJCQ3iyaJBgpuqZ
	 Fx8sy3GVIJrxvmtFUduUBY7aB3gc07/BfJKzS7f90ViZRCSnuhSUczfp/Wl4NiXQUv
	 gjOkjEycKe7fs2IVA/sMpXz2cmuPmpNJcNtXCzSo=
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
Subject: [PATCH 01/15] ACPI: CPPC: Validate the _CPC package header
Date: Fri,  7 Aug 2026 12:12:49 +0100
Message-Id: <20260807111303.1062391-2-christian.loehle@arm.com>
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

The _CPC NumEntries field includes every package element, including
NumEntries and Revision. acpi_cppc_processor_probe() nevertheless reads
those first two elements before checking that they exist and trusts
NumEntries when walking the remaining elements.

Reject packages with fewer than two elements and require NumEntries to
match the package count before accessing Revision or iterating over the
register descriptors.

Revision is specified as a BYTE, but the parser assigns its 64-bit AML
Integer to an unsigned int before validating it. Reject values above
U8_MAX before conversion so, for example, 0x100000004 cannot truncate to
revision 4.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2f7c09552566..a3a203f8e816 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -793,6 +793,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 
 	out_obj = (union acpi_object *) output.pointer;
+	if (out_obj->package.count < 2) {
+		pr_debug("Unexpected _CPC package count (%u) for CPU:%d\n",
+			 out_obj->package.count, pr->id);
+		goto out_buf_free;
+	}
 
 	cpc_ptr = kzalloc_obj(struct cpc_desc);
 	if (!cpc_ptr) {
@@ -803,12 +808,14 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* First entry is NumEntries. */
 	cpc_obj = &out_obj->package.elements[0];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
-		num_ent = cpc_obj->integer.value;
-		if (num_ent <= 1) {
-			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
-				 num_ent, pr->id);
+		if (cpc_obj->integer.value != out_obj->package.count) {
+			pr_debug("_CPC NumEntries (%llu) does not match package count (%u) for CPU:%d\n",
+				 cpc_obj->integer.value, out_obj->package.count,
+				 pr->id);
 			goto out_free;
 		}
+
+		num_ent = out_obj->package.count;
 	} else {
 		pr_debug("Unexpected _CPC NumEntries entry type (%d) for CPU:%d\n",
 			 cpc_obj->type, pr->id);
@@ -818,6 +825,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Second entry should be revision. */
 	cpc_obj = &out_obj->package.elements[1];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+		if (cpc_obj->integer.value > U8_MAX) {
+			pr_debug("Invalid _CPC Revision (%llu) for CPU:%d\n",
+				 cpc_obj->integer.value, pr->id);
+			ret = -EINVAL;
+			goto out_free;
+		}
 		cpc_rev = cpc_obj->integer.value;
 	} else {
 		pr_debug("Unexpected _CPC Revision entry type (%d) for CPU:%d\n",
-- 
2.34.1

