Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B53B9D98;
	Mon, 10 Aug 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356675; cv=fail; b=P6Fak9qtKw6MVrgsdY/qQ8hEf9CwtWIjDwYSdh3XmtSmjjZ93Rn+JrI0j8YjpilZx/0ym0RfTWPIsk4pteh9zaImNi/i+i0uE7V5YIjj8m35DgwzVJZSvlsTvKGmmZlHuubGkSUBarh3ied0HK04+CZJ+agE3fOaOnku8mnR5zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356675; c=relaxed/simple;
	bh=LhaYzxo6upJgFnuWwD9zlGCCws7CVTrEeUFyuLJhOrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dic64WYqDVqsKVX2PzzUxFvva6nU6FAAObcRR8CI5L1uLOhsNiYJg9EYwkZNTWwHXw1Q1gTzjZlcCnFBVuDLGpObuWyhZXb+r9L7VJ2jFl+8Hc5QDYqUJJ56Gi1xTzX+3ypkn0WAUxGBBXzfhjngdjxIt7GGhKRDk/aJqjmvPQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=syxjkBDv; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="syxjkBDv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOW159x8T1vQN8l7pZVUK5+t3DsPsBsIdsiTe/GeRN+FsKCnrVECZtGCvnFJvnzq2B3jSBkWYU9LppcHCnV/de/GluY9aUHhBDObWEBAvIeDZ85dk4Yr/R+9BlcdndgiUp5eARmDHUEwF6+JE4PPAoV7rs9R94ol/oaxMV2GbF6EWBbfLOn654OdOT/qDxyEXJ3QoSTiVCG9m9rUDzZACO5gmmE0eAP+PQT7DF9JiiIqp1UL7ToTsyFsSOVhI4EclBqkqjUod/CMqxF7Enct/mLWc8wrrLVs2ryS0KKx6MGLIgaWIL26PUHFRvS4FS2Shl+1vli/+D0sN85dVofTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kakFxOb27HijGX0N/+KNhJNQIladx5DFKy0ctEYSeQ4=;
 b=uG9fj+ql1qlGTs08WabqF6oRWxfClQbzoVGLl3aitSkKRaw9TG9oSOidKoRLUix1IZFjUswz6t0IJdM44RX/heNAG/kXxELmWx0MB3orIpDr/UVyiQGxJuCCUDmiGbGMmKGP41V/C0tt08spicJ5/EomDlt6Bn4kigP7wAP+htwNnoZnyJf6pNlp51McaOor0HBz3fxIuQI2DEO4RZy5rU6Eipt/oSRTnc+k9/n903t6mw5E/BQ9nNHEDtex3PSkNGyxSDY1CPSFkvB6mRGNl1DxKZ/rtgGe+9rwg7bMx5Q0zVhTrkyNrkTwGDdWx6KAx7zdtNiav9Mcp7oDsXRlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kakFxOb27HijGX0N/+KNhJNQIladx5DFKy0ctEYSeQ4=;
 b=syxjkBDvpkrQd5oPBoUGT6nB5LvWSaBc5Wf/mGEuuV+kkR2b0G9wSvk/h904kP3QnO6zujTralxHph/PUVSvYP1RaVcJOS+h+5dAQ8OS419zL5N9FOg8aEjJTXMoB1GNfKpq+VfoGwyjqUOItjurLBfMSzS0J9PuYOHcxcm3p0c=
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 10 Aug
 2026 10:11:04 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::66) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:11:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:05:04 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 05:05:01 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <nagendra.golla@amd.com>
Subject: [PATCH V3 2/6] PM: runtime: Add pm_runtime_if_active guard and conditional variant
Date: Mon, 10 Aug 2026 15:34:48 +0530
Message-ID: <20260810100452.426320-3-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810100452.426320-1-nagendra.golla@amd.com>
References: <20260810100452.426320-1-nagendra.golla@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 37aa9c6f-5883-42f0-f3f1-08def6c7afd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|56012099006|22082099003|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	kEjn9Lrqf8AjXWzMJdkTqEbzkWRaEFtoYajyYOp/iT7gC16j0Ddw9DITyvP4Wb0q+s02fmstVKaJf+JgiARJRi2WQcNKEqkSuJkslp/44QrgagBKrzhga4hrpHU6OYJRjRgWv3wM1Y90+HSgDpnfPjeI1sp/xFIbG4axtzC6dXcP0rr6/G/dGOrz9gZdMtNIXr2UzNWOZc/HG35OBQMf1uphZfetjdSUTXDYdcu8WmDnNKmEbbFPnvC+AEQlrYtgrYjoXUSx10OBisbtL7fGKH2FlrzdmU0b0FaydPewGAFqxCzrFygk2QGESflX1+b7DdH7elEt7ZDZkB+6EeBDXcPxmaYNPBFfa59S238oiQ3yF727/nCU1vij7x8tk99yJENakhS0m3F0eKcmxqaivXaQ+35ecMo/hP8ENfwZNJzRUjoi9ifzt1btoMbgFlK4DPwBCiuDLwQRuMrYYZRdYbEPO/viJJpnwcO9bq1Q7Z+4KzY9DeJGBva94jvmD8J5Pv11y60vidCPzc05JrkHENh069VqehY+UvrYgkmy3EfddaIoW4LdIgaGj0+Osf2kdYNr4KK32Ywk5VffOya/wuUSod13nMUxgVpRkJBNi6fndTqvioGG0vjlpb7VItCkHwHreVtp9THHRD53ilCRXcyDex+zy+309cFWsM807whIpWKtQW5LJ00VuXLzi8pHvoE6j7v6Dks2xf+5lPdMag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099006)(22082099003)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k4PPUbs+LvPGEVWc8UrOWdeTSl9j213IgeHPUINAayBPr4IhOnO3eypNhrkwexydUEXAM0q91zgNeA29wnLwDpD0lxDh2wIWrnJ/CD2moXhC0OhFySjk5AfKYQWEGmdQhsjiaoFBi9KV8GyK2EUWJ8/mxDAer3s4VImJpuSgzXL23RQKpm9swAq3D+G5LAGinYKvCe3Xs3h4Y6LXIbbyIEvW5tJ9/udsVb2iJAUOVMRUuBmBI7Ulmbxrex5J580ZJBNo3Q4qZNTTOP7Y8rb35curGmoeWMUlU5MDze0HMJDgHk712g61qnJfmAC1dRvqBhj97MlWF1weRDhlsO8x7Xi9V80OOrP3YhndU+fsgZgWJqEQ1/ntme1w8dzgAct0gEcokUptuDFyEd+clwsrrn4YR0YeOzgyL/2im3iWBu0tJficjG+lsnjeVghVFwoP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:04.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37aa9c6f-5883-42f0-f3f1-08def6c7afd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

Add a pm_runtime_if_active base guard and its _try conditional variant
to pm_runtime.h for drivers that need to conditionally acquire a runtime
PM reference only when the device is already active.

The base guard must not be used directly via guard()/scoped_guard()
because pm_runtime_get_if_active() only acquires a reference when it
returns 1; the destructor unconditionally calls pm_runtime_put(), which
would underflow usage_count on a suspended or RPM-disabled device. The
base guard exists solely to back the DEFINE_GUARD_COND _try variant.

The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) checks the
return value and only runs the destructor when the reference was
actually acquired. This is useful in interrupt handlers where the
device may be runtime-suspended and MMIO accesses must be avoided.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
Changes in V3:
- New patch: add PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard and backing
  infrastructure to pm_runtime.h so that drivers
  can use a structured guard instead of an open-coded
  pm_runtime_get_if_active()/pm_runtime_put() pair
---
 include/linux/pm_runtime.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 64921b10ac74..bc6de97e6111 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -609,6 +609,13 @@ DEFINE_GUARD(pm_runtime_active, struct device *,
 	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
 DEFINE_GUARD(pm_runtime_active_auto, struct device *,
 	     pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
+/*
+ * Do not use directly -- the destructor calls pm_runtime_put()
+ * unconditionally, which underflows if no reference was acquired.
+ * Use only via the _try variant below.
+ */
+DEFINE_GUARD(pm_runtime_if_active, struct device *,
+	     pm_runtime_get_if_active(_T), pm_runtime_put(_T));
 /*
  * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
  *
@@ -624,6 +631,8 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
 		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
+DEFINE_GUARD_COND(pm_runtime_if_active, _try,
+		  pm_runtime_get_if_active(_T) ?: -EAGAIN, _RET == 1)
 
 /* ACQUIRE() wrapper macros for the guards defined above. */
 
@@ -639,6 +648,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 #define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
 	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
 
+#define PM_RUNTIME_ACQUIRE_IF_ACTIVE(_dev, _var)	\
+	ACQUIRE(pm_runtime_if_active_try, _var)(_dev)
+
 /*
  * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
  *
-- 
2.43.7

