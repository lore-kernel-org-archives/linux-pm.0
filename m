Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA53947AE;
	Wed, 26 Aug 2026 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725839; cv=none; b=dcIJ5HEkcZNEmu57n8BKg3LI89r0gF3uUoa10uGg9n2TAIPBWX+xO6iwgB4DWRYxDXCIt2C6ZE3VFEYOLA9eFP2HMr0MjoM2GUj7K5fa1Lm+gj5MYyPeYySs2bpFr8SV1YhKZs/CrVav93puytawSeKsfc40+2gIzRGInM38itE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725839; c=relaxed/simple;
	bh=y4x2hBtTKq/UTTtPQl7KCSgGM77FGT9bLH90ajPUoXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPaZuwttb9Z6YeggWqIIe1eyhEOQMF70/sKndjrg3sl/Gy+HpJaO3Da3fJ1AQVyS7ikC7aSa7I2OCIfBYh1nFwi96T2BWJBEjtgBY1U0x8KCXD0pnJvnCDDWbQtQluxl4XXQ8I9rpjWQaFI1DXgRwxIwQ56EkA8svkdRMEZHM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TFGUAPyB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TFGUAPyB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32D3E1BCA;
	Tue, 25 Aug 2026 23:30:28 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43A1D3F7D8;
	Tue, 25 Aug 2026 23:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725832; bh=y4x2hBtTKq/UTTtPQl7KCSgGM77FGT9bLH90ajPUoXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFGUAPyBA/NtbRESYPd2xxvekYgy+9GN8SGzsv9EwaB/jOc/idIXN6wxNI0K1RgcS
	 3Ts04wsQxT3mG6/mkksLg1FP3h0lR3LpvTasWy0SjFKrwLdhi08C98Q8yxrRYEObvq
	 HpzujaKpvlTV/Y4IMRsD6yBrDpZIGZSkLT5dU+MI=
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
Subject: [PATCH v4 01/15] ACPI: CPPC: Validate the _CPC package header
Date: Wed, 26 Aug 2026 07:30:05 +0100
Message-Id: <20260826063019.670240-2-christian.loehle@arm.com>
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

The _CPC NumEntries field includes every package element, including
NumEntries and Revision. acpi_cppc_processor_probe() nevertheless reads
those first two elements before checking that they exist and trusts
NumEntries when walking the remaining elements.

Reject packages with fewer than two elements and NumEntries values which
exceed the package count before accessing Revision or iterating over
register descriptors. Although the specification defines NumEntries as the
number of package elements, tolerate additional trailing elements because
ignoring them is safe and avoids rejecting padded firmware.

Revision is specified as a BYTE, but the parser assigns its 64-bit AML
Integer to an unsigned int before validating it. Reject values above U8_MAX
before conversion so, for example, 0x100000004 cannot truncate to revision
4.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Link: https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b7..3b8cdf88e31d 100644
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
@@ -803,12 +808,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* First entry is NumEntries. */
 	cpc_obj = &out_obj->package.elements[0];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
-		num_ent = cpc_obj->integer.value;
-		if (num_ent <= 1) {
-			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
-				 num_ent, pr->id);
+		if (cpc_obj->integer.value < 2 ||
+		    cpc_obj->integer.value > out_obj->package.count) {
+			pr_debug("Invalid _CPC NumEntries (%llu) for package count (%u) on CPU:%d\n",
+				 cpc_obj->integer.value, out_obj->package.count,
+				 pr->id);
 			goto out_free;
 		}
+
+		num_ent = cpc_obj->integer.value;
 	} else {
 		pr_debug("Unexpected _CPC NumEntries entry type (%d) for CPU:%d\n",
 			 cpc_obj->type, pr->id);
@@ -818,6 +826,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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

