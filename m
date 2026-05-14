Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E63D1CAF;
	Thu, 14 May 2026 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795820; cv=fail; b=EXEDxQEkh+FHWR3Gk+9xJuq9OOtg47jjZbZr2wlJcRpsSOuIqwldtNfPqfNPAghLWSwpURa7CXBRm6OYlYSaEt4KS2xKVQDGc0k+AcdoNAGe+AAgi5LOU4Vb62vYwEdo1KEudihpzD3ZTZYuklnkG7V4k8WSq02c4Sy+0NQG59U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795820; c=relaxed/simple;
	bh=wREPvnWJEng/iKvW1iCqSYW308F+6qje+rWUGygDAWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE1QPlptRgskNnl4EORgrwDbaaMy1xEW636YDcnlyC70ZIV8sYKGK4epoSeL/+sGFvGg7+bXawzJF3nARC9ZQpqSCXz5h1YuG9/Rr7F1wi6ntvNmf+0/0N9Fv/sqPHDRdTDOhMGTJpPpdLK+RR0pvxJF/OmXlcySp4DjstASa3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gss7yGGs; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gss7yGGs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmV/dIZnQ6UjSvdpKZDm0wrVYBx5p177LxqA94TfxIUZdfg0xWUyFi+uv20yV5LXBJARsE17nimgFsbQpvxgDEvGan2D4u6OuFffBIz6aYYtAuA5xn5le/fMGfYfv5EfKzg73UAd63azOVlYc2TSmUe1Ke8UFyQ3wN/ZzDTKWUX+slN+Plz6VGAfV94xLAy5zjvbNkuTVnEE78GG28WSL2m8kCURSFvH/G4gfOSqiHP8VqgEjNqg+x7eoyXI4EbynBRO6BC7fdUpz3gax4rz87gUwq+CWOTSTVRAH4J0rkRTimm6XbvNPqYe3LJsT5pTB9pNuuxMzNqnYWaV0Yg15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQQjDnNuaTS6M7ghP7j6KKtC8Kn3E2Z+epqH7R8ewUw=;
 b=V75UxG+XbPUJCzqub0nTJ0DecAYjG9u6gvq/xQik9J9YWwKfJyIFBTzF89QJSjmoEEtiLh34ZcErQ9m7PK0LA93jB1MX0zskSiy+DPBtJTWB8mUiIvZeL3UCRUWj8iwom+vy+E+CdFj+ME8qTg2j5bNfJYhUnNwK9fNu2+X6PD3QkR693O3ZegaBH1vm82fVK4lVSWNRukr5ODy9Y2rDXl2Apd/kjU77sN5QRtfcVUrrveU6VGemghzSd41X/c+2P/wCwiUtunPgYfvcGazxNLV14gyQPvtFgKeGoo9kOp1fr/3Xp3b948Yh/0synmV4mlB8B+OskqW5uzty4gmNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQQjDnNuaTS6M7ghP7j6KKtC8Kn3E2Z+epqH7R8ewUw=;
 b=gss7yGGsknxRMoUxTBeWpM8vjbE4IyQzk4eYrK0OkGU7wFNMJwGGv0wHHWO0sqZAr6G3FTmCcGfK/ump/H8EamXOOIg4K9MCyebCMgAZ23t/XLXMarn4ATkZ7HRrK9uJJSEScB0B+YDbCyqzyoj4NSYD5OLqqfcdFD+0kMeDym8=
Received: from SJ0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:a03:2ef::8)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 21:56:55 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c0) by SJ0PR03CA0183.outlook.office365.com
 (2603:10b6:a03:2ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 21:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 21:56:55 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 16:56:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 4/4] cpufreq/amd-pstate: Get highest freq from CPPC if available
Date: Thu, 14 May 2026 16:56:26 -0500
Message-ID: <20260514215626.35327-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514215626.35327-1-mario.limonciello@amd.com>
References: <20260514215626.35327-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: df031c81-0a88-4df5-fe8d-08deb203b6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	jt5ku/pFwLD+ztzvfdFFjfoT4/eM4m0d6BSpXsqUIC7TxG4IEUeq6+XA4k5caHyWAmdoHdYr/oPpdFQOMxW/JbNPnzle4KFONEdNnlhg1II0ZX5sRF/GUNSkogQBn25zrorjC7cs02RXePCasizuu+lBc734CK1Tjw/otj6GyK1KcUvA8dkdQ+pA2R0D9D0aiSGeSjWSXEskTqWWm/1Q2humyEarGTVHilAWueVlO6qQPV2LFzik1Ogq+oF+hNefMUivkYPPFQL+aaAXhHIM8ceqNH2j4aAxy87OISaSstzfAq8ozB9bKCYCWDWBPHnoGaKvvjD0wde4zGwhxdkv7njaqShY885WI7RRi76IBmMnzRfWsSvgU4spw75Rhff7UIcyDR3ztZ9lmH3MxwkwLgmBDWK+gjpYLgLmqQv13BZKUxykuthvxXkIGEp1FtAa/lSobnFr7SbOsxI+qX/+ojwgz0Ov3aRjOiaoQjzXIJzRQ9g/okjj99PTvx6480gSANtVOERcOtzCZqHYRj1wHa1yPnpOCGPzJG5Evde+GwCIia/+Zn8FtOV5xDgU3faqyH13tz1M1VnvlOHUMotOkMCyJlXXlnvhxoM3DOp0k/QVinxKBAewdWMoRX1WTNVwDwgKduNC6AQIwrjuMej44EY0YlqZRWqoBecJLzfKk2+QYGVZH9nEshVtGb7oXQ6iqq70oTgLb+zg7+MVziFBRgHJY9VTBXKoVvWpttcLUkY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qYToWvawsVJq/wWXZjus0Q2wwKYWgLkYcCiKfq3QQxZeFl5P/jrwMpQi4uAqv3uneyVelMw4aNKiEPjeH+1YW2cULXk/bxH2gsGa3MrJZyO9KoBJ9m/mVV1SdHaaD9Jm2IU4+GyzlAPq5DsFUrRc2T0XnwUWSNlqt0xDNomIs+ZS05E4Mudpq7mqjlA0gQA+vssomEhJ0fiSlSnGsFTwPP2nv3R7kWX2OlWqJLv0J0aEEQyZ5FJQ6/jUis3o7VxMNtzwk7jSLV1LQFtb3MfEYYOHFKVGcOAC3it0+JdbNHpkyHGSVs8/HNhqwerfyqCjy1WFq44zxGaLMHfDb2o1qKhm1rmeq5qyspxgC3zGzJHDRB5FhG3Xy86A5iQt/JSIKasalojxZEfwWt45GcvqH2I0XmPeyQiBIDvyr6TJczCcIBktyaIQMDWGfDkMHRcW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:56:55.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df031c81-0a88-4df5-fe8d-08deb203b6e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

If the _CPC object advertises the highest frequency for a CPU,
use this instead of trying to calculate by linear interpolation.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ae8d67fb374bd..3f06e33f47120 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1022,8 +1022,12 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max freq came from _CPC */
+	if (cppc_perf.highest_freq)
+		max_freq = cppc_perf.highest_freq * 1000;
 	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	else
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.54.0

