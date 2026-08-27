Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5E13777E;
	Thu, 27 Aug 2026 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812284; cv=none; b=XhO26u79KNkCrhRVcM0a0VmmBSBKNE6XgfW+M4+mf8SuAyP7KCzXaFESK/r+P/gDMSLzxtxluRy/0X86fIWmC+iSrBJ4hOnRV4LzOPYCNhXRk44dtuSw/m4hZeQV5C+babvUMNYM3RVAk3recBnuslx7gZD32jDMTZieKCWq2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812284; c=relaxed/simple;
	bh=kR2CJ4g/1ICvY139wP+3YJ4emVdbHeu3Rzzr5fTwz1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjSAFBWlMn8PdHJLZuxE33ttsLmie7/st++8nMgnkHYpO43yL1ZGa5SYwzSNADBmLX8ZbBRoUjUg1AQXG4CIDjIXjJFXoPceUFcknn4dRL2gCy/u11SRhhrsPuK+UGu58zv0fR0DxgWo6x4S4QR8NI09ZSsNmEyjGan9uilDEC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QGP5pB+X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QGP5pB+X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13C9C1BB0;
	Wed, 26 Aug 2026 23:31:16 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.73.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 723B63F85F;
	Wed, 26 Aug 2026 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787812279; bh=kR2CJ4g/1ICvY139wP+3YJ4emVdbHeu3Rzzr5fTwz1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGP5pB+XgHV3vaTUnUMsEhs1+zaY8sdCQeEhdZT1vj11RgPnBrHARjUsbWLyUbzWa
	 hy5nK3z7skXmlVBND1iVf+pvpcuZTTafN6XF8j8D22sAt99/lazw6vUtrW83xsCcPS
	 KgqCJL8n4REF9VASiBVkAQv2SoZVXWOhecZ2Ffw8=
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
Subject: [PATCH v5 04/15] ACPI: CPPC: Use 64-bit masks for register fields
Date: Thu, 27 Aug 2026 07:30:49 +0100
Message-Id: <20260827063100.2741066-5-christian.loehle@arm.com>
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

MASK_VAL_READ() and MASK_VAL_WRITE() operate on u64 values but construct
their masks with GENMASK(), whose type is unsigned long. On 32-bit kernels
a field wider than 32 bits therefore produces an invalid shift or loses
its upper bits.

The Generic Address Structure permits QWord access units and the CPPC
accessors implement 64-bit MMIO reads and writes. Use GENMASK_ULL() in both
directions so the mask matches the value and supported access width on
every architecture.

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3fbfb2eea6cf..1caac71d3e00 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -248,10 +248,10 @@ static bool cpc_pcc_write_supported(const struct cpc_register_resource *reg)
 
 /* Shift and apply the mask for CPC reads/writes */
 #define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
-					GENMASK(((reg)->bit_width) - 1, 0))
+					GENMASK_ULL(((reg)->bit_width) - 1, 0))
 #define MASK_VAL_WRITE(reg, prev_val, val)						\
-	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
-	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
+	((((val) & GENMASK_ULL(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |	\
+	((prev_val) & ~(GENMASK_ULL(((reg)->bit_width) - 1, 0) << (reg)->bit_offset))) \
 
 static u64 cpc_sysmem_access_size(const struct cpc_register_resource *reg)
 {
-- 
2.34.1

