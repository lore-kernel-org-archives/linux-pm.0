Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8793F7894;
	Thu, 26 Mar 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525713; cv=fail; b=NojjhpJmjx5EttgJD0gaHXLgkzvUl2wuf32dC5LGsqq/JPuNPUCmV3cO0HAw6boyZj5QE7jVMHcw0Jlv1z7M+wCRcW8WfU8oUIGrO6cW8XD4mLxz1pGCVkXWsm2YmDKdFU+85VQA/oQYgyPxCuA1yZz24p/x7WQ+GAFSA8zQaCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525713; c=relaxed/simple;
	bh=R6ZuV4jrEKcQNjbjHUezoDQWiFlyQC0UibLnXPKVwq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T18uUx+AJ3qFD/lzJQzwSONRPf/YIBL7H339HrmpPRr55VqUKRCc3uFc28DeG2cfbNFFXNMVjhnsGO+mSkKSh1QyH56MoAXJPXCUo83+r3vAyFpBlwsSjTh0hCm6aZL2fPHOGiHIW6GnReaU6XjxZ7Vchcehcafy43g0+8MYL5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0u5jF/I; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0u5jF/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihMdbsk0aRlc8HHMbhRbR09PEySEZAiEjVzUnk4BjqEbFociA91jywjUltwHK2n6UPYha84fUUd/XYF7VSqfCL0e3gMFCsvLO4VTlZbxRAhO2uqGVTVKYxSP7KmR+wbMegaZa3SUXQcopVLHOpbiCL6NqvOUMz20EZg1g6EmejNeIfgk4bg6PmpwjmgnwZV8J9Q+tfHfKqtK+KyA/E7VWh2tSyulPwxfnbB5sgVgVu6QWcUOKYRMF5HRAaDeUdLjeNwvK5cT6glvy6T+gmEb8x/MkcbgB8PAKC7sH+itiVtFyDHOdhf4YPpMyLR0WiCdc+c6/4V2ftRsZz3/06cBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiGWPpgOD513OMJ1BaaBkh/WCPSknvpsaOxutrhB8/0=;
 b=mc4s9IkKGCPlXyq7f0f/7ErcSZNze+yqfUKMGJvFTiWuJ3Pb2PiLGvwfxucTjCuzJuywytfqKYwryyV+tQQVrv+jJ7LuDUYNuM/QlysNPt7acG+Q4IXXkY+X6jyOoz7rYpUwL4BzsP8yu1yOpvkf/SsG9pDiYMjmNwH4EZ74mDNwuSsvYwzNcjYc4GwRW7ZiZCXINLLiMTCHAQPxL1ozmJQ/dw5vrjxvRetLdH8pGfK0M1djRXy51cVQaFSKTKULzQcm0tB1SGAAsoCRWvFm546UE7GSfLjbt3oRthcGYAUcjmLQ08JcLRuI9qyHQ5IwWyn3hEdP7AXVziscOt4oVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiGWPpgOD513OMJ1BaaBkh/WCPSknvpsaOxutrhB8/0=;
 b=f0u5jF/IUErSPAhCmh/rs5wgmsChcdpkWBT0WcZXzfRQuc+KlGP8f1vILIXLtZ0GuIJCTS/HSLTqXihugaqzA6AMOZoSYOa0wt/kjqvfU1GeKfj7ZIFe2EwtC5npm28W5/EcWQFeKIMa6SoNqgtHep2nrn6EkuS1Wc5KW80pVIw=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:48:20 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::fb) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:20 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:17 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 01/12] amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
Date: Thu, 26 Mar 2026 17:17:45 +0530
Message-ID: <20260326114756.20374-2-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 64425196-1fa7-4825-fc83-08de8b2d93ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	EPF3IgN8dAq6EjhfS8xjns84y5QwzdANGjnDeWRorctLfMn71fPsW+y05y3gpEdKYrnP3i3BIGHjIjhC+I2XiKFEKOITBix229eoJ/S8Umh/K2bI5zluGAUWT7xh+V8qOTsgdGEds8r9PyOK17Qg5y+gcSpW2lfZ7ZcPZsJavSbRtjT3nI+udtxyXd5Q/gb9+3VOkO4QtHk4TNFftbOiosq9RVuVP60dBeCJPqBAzOXMYhycexCyn8qpoamHB2igf6dQnPoH9TbFh/HOvSFqBdvPlFvqnmpGqjLJlZPgTl1W+jZYXe13aABF3vTK5RTAtZFwkUcHCNcKNw7IMoo6arcsS0UPeSGRp0fN45kDjogzOAwqmDMuXI9YalFNQPSdn2bhllY3s13ixKq7iLG8Q9LHYnWlHBcMSZxkFtsUKyZOr2dbF3+CgTqzCtPT9V/z8qXItFFbPy9VGtV7Xd0emVUHGFpt30ZZ9nL8fnlzhmEOp4O4Ubq4t7AsgrU+xoxaLZ4Yx2ANM55sur6LHAvM9f42jwW7scuQQmVlMTP5XWAvj9gPtKg15Bu53DQEwTRlcq27hgPIKarE5cGd7wu8AWF+Rq94odxHaoZGchOSL0+8f3DCzGOn/ctiDQ8KjGmOHY0x15XEHPqKCQmyB7ZGkD+w9xPOp14QZGDVA7C8oZKxJtGp8t/KjM7tvjmnE9AXxGcJc+2Pst7Jn4389I1Ti9aPMQEdcWEwsfLi5pQrUYArnBl0nLZ9UnV5iaJA9u3yxu0ZQ9PQklsidjmgYGDY+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vkmPseAYN0KfLhP+rcVcVd1Ukv0jJaamDpr+DVCG4HxTMGF7nO3oFJ6V0mgJ0INn51YGacasnTO/ljiRqiw2X5BGtLtT/my0IT9sW9Gb+ctWH1kqRVnDCLDsiG24DQRh2LpvYibBSx5vhIhRF0aZLluqD5IgA0j7gnk0Y8QERemh/1Ws9/HsY57Iv0NGPdWvNku7IvFFlmDWvcMqRxbpacDr0i5ypV1wqGb0/oAPbW4NfSGQyzwsmahndXzpgUuZQmP4KlqwneJzD+wy14fpaaauV1hVjgYCM+rTGmR6/7HFSBkm137U8xZ6fbkNyXttX9SM0Y+7zL/qRVwoB8noo4SmJvqp+AaL/gseGDE1jmQnyt0ldnNdwjFt3b5Jg3iAPhk3X1bndZbY7fxWjJ/TvsCyz6YLAKv+ur5/sh5Tvqh+0Sq1uDOnYIvLsVKZF1pL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:20.4057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64425196-1fa7-4825-fc83-08de8b2d93ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

On failure to set the epp, the function amd_pstate_epp_cpu_init()
returns with an error code without freeing the cpudata object that was
allocated at the beginning of the function.

Ensure that the cpudata object is freed before returning from the
function.

This memory leak was discovered by Claude Opus 4.6 with the aid of
Chris Mason's AI review-prompts
(https://github.com/masoncl/review-prompts/tree/main/kernel).

Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
Fixes: f9a378ff6443 ("cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf5..d57969c72c9d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1533,7 +1533,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
 	if (ret)
-		return ret;
+		goto free_cpudata1;
 
 	current_pstate_driver->adjust_perf = NULL;
 
-- 
2.34.1

