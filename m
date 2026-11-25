Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627294;
	b=dmtg7IUfQH8a/R5tzfmntfeVHrJ16PLEM/UNdjUCRyVOLJrOLva59IX58CLI3g9EDwtl
	 hx3bBLjc9hd6mQZlLAZlnSwG0TmLJStgK70Gsm8YMFsG8ThI/mPj713jfDr9nTUj8KTo8
	 l5vb6TJ+RNzgH3Jev+uPWAB7+/53f4Fm7rZ48Ls5SHSfffCbtja8f8UZTaggTwrU/kSdn
	 wsCXV8V6VOxNt/GTvpdKtm0LJbSdvMx7zqwoRYqs6WWfJk2OHEWUKkU/1rpzK1FZ4sREC
	 PWilQCRgkmMpffD4IzL1OqyvsSy0Y/kyr861lUkMFpOqmt7vg530rXRXW2L+XS5qAaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627294;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=T7/Ndim6esUPJAnvpwRukcqFj7pdfQRsiTyJVVPPwPs=;
	b=kDanYdPeyIN8Z2fAUITLwA4nHVID29UCRRyXuCP/pxFzUTvcuhGGL8yq87RUa8zKz9mM
	 nCsJbt/YOj3mCYgIMwhXIqJMMhXc2kCb0FRj1M9B8ckHq5N0/sNu8+7mQx/8aXnY9iUXk
	 M0MsZc7cCs110w/DRx7E8PVesFAuCXo+HF8vY3fjaY7bfFwZyv5Dx9HjIMEeY736RE0A4
	 iFGf0CMISbAEldKNZlJUxirtL5M8Uq8SQJ6GJNCIEGvBxZ/WMMz+BvAWdIU9xu/liDPe7
	 v6NyqycVmYCPBFoeaJUK+jysqpnevYnVDtDIx10bMbbKzoPZ1X15rfv6YBpwpa+nrRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LskjDRsH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.35
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CA606A323;
	Wed, 25 Nov 2026 17:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 705CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LskjDRsH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6X8QWt/zpn8FVcAQW8EnzfnUXQ9for8uTieUZtW0QiLafjNWDnGDR9QUXIK8M94Kprlgu3nsJFd+rFS3Y8IrcWKYnYCZW80gRGgwdQ7WTQ7uK8+i7neNcYkssSBFW8N33hAlA1OFVokJc12foq4fV9IGI4wCQWwmvA/OgWvGaIz+JpbkdR6h85+QFQgJJdEgWN6tDlaOyUdh/EJxaDA6/goBvKFaWfXhJ/L1Q9hnFYT/LhW/seXRMtzIQ5P1PeLWlLxD7Ns/+f2FmQxxK4oF9cOPclwKAqKrGt9Se4lXCu5UydR0PMvG8S0SX6ntP7hMd8cn4vedvJmSWn1Gsx95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7/Ndim6esUPJAnvpwRukcqFj7pdfQRsiTyJVVPPwPs=;
 b=RtfhiZMoVQxru9CCBbs8deCEAYHbu8W3qohRKkGJBF+BzL2+FvKSplt7ILrC4aQPD6LxR2Ib0dUu7qfNQEC1XWrpbOsbI3fEqK13tOGJwt481Z6s5byWBpAgD7Lx76t7Id4c9e8TS76UJJ09Sa/KMEN6/JswsgjoZcO5SgaRvgwNmMoYBtOdkAmjmmQNJ6fXsSQ+cdNDTiP68cMxQkiU+A0X3gmViKiwSqahHBLMCoWVLHI+vQ7mX7FWpYkdxDW9ZYFL4494WMKAkMwreSbcNHPAMnhFGeAsbsvtvQDVbup2hHUPNqGE0rDKXqe28YZaoAeMBHVUjZZCuZe2fhZN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7/Ndim6esUPJAnvpwRukcqFj7pdfQRsiTyJVVPPwPs=;
 b=LskjDRsHcpLnPz4Ppq32SFgam+OjHSrjKTKvQ8NKdj7FoR8MroA4PK33Qhpn3jx6WYYNbJ1nrwfMPKtJj8SsNhuzXlVoEnlqEkKw0diy7Vax0vfhv0nwRnXJtDxNe2CrnRuWLmNZZIKxjyDzpImM99GsAE41t9VEd5CkVJ562f8=
Received: from CY5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:930:10::7)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:21:02 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::97) by CY5PR16CA0003.outlook.office365.com
 (2603:10b6:930:10::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:21:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:21:01 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:20:57 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Krishnamoorthi M <krishnamoorthi.m@amd.com>, Vishal Badole
	<Vishal.Badole@amd.com>
Subject: [PATCH v2 3/3] platform/x86/amd: hfi: Stand down when amd-pstate CAS is active
Date: Wed, 25 Nov 2026 22:50:31 +0530
Message-ID: <20261125172031.741740-4-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125172031.741740-1-Vishal.Badole@amd.com>
References: <20261125172031.741740-1-Vishal.Badole@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c541f2-34ee-4634-8819-08df4b187a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|261026140227099003|261022105027099003|10067099003|261026121527099003|261022075727099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261009223027099003|6133799003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Q3JeHsyrfSM511Mr8+SXqRZYZIHb11S5o8hk4OlaPS3Ot9dz4xiHiLAsfkY3Gjge49GMCJj8HUEQB28OWP0/loexwDSULXK92zHk5PAb7OK7yR2UjbJzUpI8YCFHTVu3iLzwIFT/hdAjtr0yQm49qY/vP6//mga5I0nd7rjzVs341sAYVLCbxzp9xgY5w1N5lr5YMrczZ3rBZLwU3mSRrE+fTYfWNNQmGPI3SznKO3gZ9D2891HapXaORiikxUhhZrUFXwEcR+bmcb8+779XlvcoP6f8QTfjbk1fIYM0tnamJmWT+2NuS/2NkRSIBcdqxrBvkfOAXt5qS4pYofNqbOiewCZe8WSNRA0T7fWEEjjcZLHZsiojwigUhvCuLyOU/lCq3Z+TrD9W9Z1FsznNr0eXmT4k9CFlO/J3WMpnfHRBXGLnsOQibnGxFGu2SEk+ypYLfZo1GdETyCkTjE9jwQ2sZ/+xajRdHJJswXQBiUZu7pInbHHJ5dZVlklaAcS8iH2lospzr6oVCEZFoU3qzgJYxQ8k6Dj9Y3A4pJ1S20zVhDKATrgA8fCGDPC9je/F1+C4YrYfx6ACQ5pWmS0MHrhSSwAoQv3HBPuV4c8/RT6ksz0+fIBq31SWALlz+dSlfvA9v4VubBcMoewCLBt31h0fxG+7erif3AugNFZpSKwxt22sUqf8rTCKoB3v6BYSALIfcADHhI4NPlxEVRRG6D5REOZFqfCTym1sAFwlOFqDhd6Y9RjuHW6HXufrYtlk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(261026140227099003)(261022105027099003)(10067099003)(261026121527099003)(261022075727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261009223027099003)(6133799003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O5Ah+jpuQyQUVPcrrPPYPYrOT5mFdmhhAthg+iqZBB22seETDTE8MmxnHiXuUalr0yfvb1JspyLSZdF9Covoj/aObWrjDzGYP1qRKZljmgjAykWismxEkrIaMTG/VfLfFdT1FdgPInbcceC6bZQB5N8dB/KFXzM7VEtYpD6wW3Ypy1Tab9xqtTOwtAp8e/j1SXPqTsVe19SLWc8QkfIw1Ctb6r4qP1O9T0teVVh/61oauQecAx7YDdRIxi/mjqwtI4/n4xwVH2Novo3narCk+sGH+c7aurqhXMBNORLFZD5Hr2wOHhmkkzedsoaRgfB/FZgCLwuxEL+iWgcGtpnwy9fntJkGAEFgT2HY21R7V3TzsOCXJdvEGG2c+vxG6rF/fAM4FJnmptjQhYIwrXT5j+hiQgSWC+I7EIifTP+kg06c41sSJe7EnfSOqlC6OodI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:21:01.4969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c541f2-34ee-4634-8819-08df4b187a7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

From: Krishnamoorthi M <krishnamoorthi.m@amd.com>

When amd-pstate CAS is active, it takes ownership of per-CPU capacity
values that the scheduler uses to distinguish performance and efficiency
cores. amd-hfi manages the same scheduler state through its ranking
mechanism. Running both simultaneously would cause them to overwrite
each other's settings, leading to unpredictable task placement on hybrid
platforms.

Avoid loading amd-hfi if CAS is enabled. Defer HFI driver initialization
to a late initcall so amd-pstate completes initialization before HFI
checks whether CAS is active.

Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 86a7f4332c35a..73e53203a838c 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -27,6 +27,7 @@
 #include <linux/topology.h>
 #include <linux/workqueue.h>
 
+#include <asm/amd/amd-pstate.h>
 #include <asm/cpu_device_id.h>
 
 #include <acpi/pcc.h>
@@ -536,6 +537,12 @@ static int __init amd_hfi_init(void)
 	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
 		return -ENODEV;
 
+	/* amd-pstate CAS owns heterogeneous core scheduling when enabled. */
+	if (amd_pstate_cas_active()) {
+		pr_debug("amd-pstate CAS is active, not loading amd-hfi\n");
+		return -ENODEV;
+	}
+
 	ret = platform_driver_register(&amd_hfi_driver);
 	if (ret)
 		pr_err("failed to register HFI driver\n");
@@ -547,7 +554,7 @@ static __exit void amd_hfi_exit(void)
 {
 	platform_driver_unregister(&amd_hfi_driver);
 }
-module_init(amd_hfi_init);
+late_initcall(amd_hfi_init);
 module_exit(amd_hfi_exit);
 
 MODULE_LICENSE("GPL");
-- 
2.34.1

