Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C551370D77;
	Wed, 12 Aug 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499668; cv=none; b=UJ2cH5YgCks0/WfS/IHY28MLP5wyaqHVE3vOVjvknufN6ISmzvw0tODn4M2lOW8aPR4oKH8PO6KUQfvtaOFmNvgNa9j29eWuV94NS4NYoraTNclT2CuPNdCA+322BgNyRoHOMMqJVtEEA5watMa8mtDSYiPwWeLu6OXT31YOYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499668; c=relaxed/simple;
	bh=SFifmtolDLhp7/hIPyEN4KkxrXXW9qcorg+HFcP9k3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CL350D6A6TcTEif8p6/aK41X7x2a5i1ddUiH5SNWVyCmJCAFynL8BMzdsLSZ0M4i8OQlMlfGDHr8f3K2RoJsYVFcNU4k8oMqOpl5QwROWgfqmy1t4zddC62iRBIdERzBp8TAHKUtSMQ6wU1A61UlrE5oGEjp0M4v/mDITRBfLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=w5ItmmVB; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="w5ItmmVB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yKGqqQI+Uhtn74jATxL7vYZkfUPEKo/fbFgxPKC8IXg=;
	b=w5ItmmVBe04bQA2BUp49OUOIW6odv8MFOXXRQrz3DNZbrNuf+H2Uq6ZF2mb2uNqZQ93ewKtSe
	7SSv20mBDSXelAc8R9B94s+fV1tNPWBPk2zEixk4mDo866cNEMQBJKd72mCAUSUJwMhyQRZbXhV
	yh16vzKwzKN3NdIJylU/BKA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hKWW15zTkzcb4j;
	Wed, 12 Aug 2026 09:44:13 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E0494057F;
	Wed, 12 Aug 2026 09:54:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Aug 2026 09:54:19 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 1/8] ACPI: CPPC: Prepare cpc_register_resource for Package-type entries
Date: Wed, 12 Aug 2026 09:52:09 +0800
Message-ID: <20260812015217.74598-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260812015217.74598-1-zhenglifeng1@huawei.com>
References: <20260812015217.74598-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) introduces the Resource
Priority entry, which is a Package of sub-packages rather than a
plain Integer or Buffer register.  The existing cpc_register_resource
union only accommodates Integer and Buffer (register descriptor)
fields.

Add a Package variant to the cpc_entry union so that nested
structures such as RESOURCE_PRIORITY can store their element count
and a dynamically allocated array of child cpc_register_resource
descriptors.

No functional change intended; the new Package fields are not yet
consumed by any caller.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 include/acpi/cppc_acpi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..1839582b80be 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -71,6 +71,14 @@ struct cpc_register_resource {
 	union {
 		struct cpc_reg reg;
 		u64 int_value;
+		/*
+		 * CPPC v4: nested Package (e.g. RESOURCE_PRIORITY),
+		 * elements dynamically allocated
+		 */
+		struct {
+			u32 count;
+			struct cpc_register_resource *elements;
+		} package;
 	} cpc_entry;
 };
 
-- 
2.33.0

