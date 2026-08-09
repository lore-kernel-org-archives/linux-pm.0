Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468B331A48;
	Sun,  9 Aug 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786256767; cv=none; b=YGhM16ZPkgbI753b8oYtj+IS5H/bfzgNh7IdxNWes3YbY6SOV6ZJ9iBIaJtQVQ/T1q1HWn38uPNamePhbZZTpL3GV52CZ3i+3CKLo/z2MKyvM6PYBircPp6VuUIXvuyMGEe1+LiJPFFctZ9xQZCv7Dd2UZQAUAqRH/gDR5fKeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786256767; c=relaxed/simple;
	bh=EhX+PyDPrYY3IXQ8DHKX5zUAHMPAFkjK6IThU6ZsAso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRQv8wKYM4v6JVi6+ZxN6K8lIJ+IRBYRcI9EnlQvwoWN0Tbl6ouFcjFVzCn8lz0CEDNdIstfy1cUCYKYmH/b4GjF/znN4sPzKdhFZG7oTAR73Nu0e7XahNu3xys+Q3FaSxV7z+JyhnmGqYNZ3BLP2JNHgjCgl/vcdhXTwCIJdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NL4S/1XU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NL4S/1XU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 084AB1570;
	Sat,  8 Aug 2026 23:26:00 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88F7E3F9A2;
	Sat,  8 Aug 2026 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786256764; bh=EhX+PyDPrYY3IXQ8DHKX5zUAHMPAFkjK6IThU6ZsAso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL4S/1XU+JtE5zwCIMj0RrBexJmI8u8UNwEL8HtvzBr8NTPiJn6OGPTyi+Y1G0GHK
	 mKZg+cfTdTGE/LYqCaA2e+vb23kDYqlAFrjZaFhZ/QCGqg51NECLn6BPZm6SJmSeHq
	 mJXke9aR3JXvv/ktbraLdHse/4v8QMp3TK6qMsFM=
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
Subject: [PATCH v3 01/15] ACPI: CPPC: Validate the _CPC package header
Date: Sun,  9 Aug 2026 07:25:35 +0100
Message-Id: <20260809062549.1415955-2-christian.loehle@arm.com>
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
index 2f7c09552566..17d88aae1c3c 100644
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

