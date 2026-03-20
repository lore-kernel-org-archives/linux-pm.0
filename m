Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DF3C73C1;
	Fri, 20 Mar 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017866; cv=fail; b=T3mfWWYB5BgWv3bH7eTQLM4eaC0LY0mQs027zPA4RhvYqR7wLvfeV1sEMX80I1d6t8YvvkmYIbF1MKQUXubQUnGUvaeYxAGcfUcvuOleBIW2dom66LFxoKpLTPCEFZgHWzRV83vDUFXqFQ1+cVc+NWOV+8k0eDedgJAWr2KdqH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017866; c=relaxed/simple;
	bh=P9KB+2X1mAg0Xug4+ksC3lirYjVwaF7qGUY3j3Ik1K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3JRkwRaQcGLuqEepQJHj+eAYLWn9+UkDSpNu1KubeObXoGN5Gf4lYa4lFxF4EcsvZ3jaYxtXPw6bXyQOqxQYZjlZZRwipfKS4jw+z7+B+NxH5uCnKAQkwjlMZpuv7m1XYz9WhqkO0vRbB3IkiMX0pEAYSqIi7EDd1hiNoigatU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E/B+3O2Q; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E/B+3O2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVmG0/URckQDwZ7NbgVwf7ty6Y0OoCk8zoHQGgKhmt9F5gj8JtpITDxOdegLf7JgKJnDpvD1qSdVfyVqs/dC1abpfVAnCgXUGQFMe4DulxXzulMxipEjithyqAf0TEZA1GUrvYcilqfpffzXrgx8iDvXLEgQb2r55pH+m3W0VsCSBw1fewn97yCPNKCX1B1O5zBTxgwXCj2/COPyPG+cn2v/XwfrzPD+SB1wSii+6P2NtDJ1sXmGtGUCH2lE+iiOiHExxH/KNQJmgNAQ10yCJoPz/FuVT3zUeQpQP73Lx7wS1ORAKvp6ivzcXv1WoOEel0XJEsc6z9SwH/L6Akgryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GITbD6Y49EzXl7KY5/HMNz/7B6r4x4Llh75aKGlS3rY=;
 b=J3843k2JN5nRRGTV14wWvDLrL4lLd12AKMlXtlXgamXSUcHl3pxTH5DerDq+JyeowwDxqZY5sfgbM/DITqCRtVGZqAE87V7JAJwW/LLbR58fqYJ6IPl92UEQVIzRYbiHQ0YC/NAJH6kmEqks5DetaZPTaG7hPkDarYnIe4KeGCaGk8l53/js7AKZYP28Di4+gMNCMt/Y46yX8+ur731BKGn3NCyKMzVcHlZDDjEhLSA1UE5syhYy5WYEcsIyoiO5gGtY+DuJYUSV/VYaZH56KihrkFCA0ptRt5Bfvu+koGmCfH/zWix1zKWp19Fr6kpRGCEk45ItMKSPmV9wyelmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GITbD6Y49EzXl7KY5/HMNz/7B6r4x4Llh75aKGlS3rY=;
 b=E/B+3O2QURDfDqxsn+dvuQaYnxqA7JkeBEu2t3/gl28OGde9Z6lJl7FNsT0JZyXAa+IH/6rsLZpgLi7U+Ikx6aoBh7J0OgsnbaAuUywy4Dx1+8W62DDgGAVHLTKzZD3EbMzVFhKEYQS7zrVsrTDCJgIyAToSeyIQ0QQWpaiC+zM=
Received: from BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::16)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:21 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::77) by BL1P221CA0044.outlook.office365.com
 (2603:10b6:208:5b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.24 via Frontend Transport; Fri,
 20 Mar 2026 14:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:21 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:18 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 10/12] Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
Date: Fri, 20 Mar 2026 20:13:19 +0530
Message-ID: <20260320144321.18543-11-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d7395b-765c-4b50-6cca-08de868f2c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n4Li+hXY3mHA+it1axqMB9cGFxk9LhCURHvUOP81IiyL2CSzJLUjVjVDmIDK0b4mvvc1WjKDaq8hqSI211aAjt7qFWiketLpeJe2aQurObVSidoLJUeyGcnyc5wJJGaoBR775QHfKl2EPJ5Ye5pxRnDIGd3PCd9qbAGLr71ujJ4A/IVqInAsddmjqyL6wPDOZpRAi5NHYQ5CLtOPH78LnfUGyNCIQuXQmF/exs7rJdbC1QworsKGO6dnWpIjk5klJERHMjmqwRvYM/yHayCLGf04HWuUgZqhgTzSvWemgjhN75tRImqgdzj8g8gLrlpUxdSHi5Hujao7B43HqRqoPq32EAa7uP42sxRns+cSs0M+OqIPAAtri1ttc6mtFD2roIFwU8bYOMQhh/8yEhh1S1UvmXpktMrWPdZkIUsWKjJWVQoa9XAtNlTS1fdhuSvCC1cF+kO/BMocaviqbX64yxGkDAgZgqSGscy9/LeCSX5uKTouwrwtpN4JT2x9UG2SsMopaSa1FeOl89HMoseizHmKPe5Z5ktNOoil/GEcnozQ7pIiZ7qR5i5n8fIItdw/aDGWHZ1qnnzxNjvnKVxQJu6XMCVvvY+/9AueCoC1Lks1agMqIrxIMMdJEySS8ltcEPNBjhS0Q8hooZHzGTrviq+mM3adPg+GHqf9f4Q/e01GvhEkDryorTkjVmzSB2NtqPGKkSFVlD9Kt9iVFFDUgxfUqKE/N6l+5uvSU87hJfoSfm7LF8HQ+zR5cuI1leSvywwO5PxDX9i7NmOU3B5OFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1JU13MIyolgusvbyiSPv75dwrNSshQubfCm1TZ4qUHWUkH1QkxQZBN3nrWaM4gaamKpWWM8Ipxp6Cm/xZnFRBKqVsc8EDfyV7vw9Ln4vz/WvScZnqR8tscwPIqypOA7SuQjI4G4zvZrt2pPPY1HnsL73Op4CY+r/6je3VHlD0o9C3d2OQ1n8M95+EOvj0WbbN67bvPiK0ude7V/kALrsoTaFYn3N2xARC+neRAHQ1/jd5ii/xjWUA2HkR61FLR8cI3d5LS4bmujTN/wmhNGWBEPPqzkdzDRs0PqwX6l1UAmFYNZ8lFLEgnv7/JWuQTZ/Ehqjdx0P3hOIKw52UQ8sqAk9C1xtiCrWwl1P//mcWpFMyhHdLGWtBXHg+4Hes9PIqPygpBB6k5CjAIPgzAU35AORHkeNPf+qINJGQVoAXaQ49ip1u6ShgJisX/bhTtPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:21.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d7395b-765c-4b50-6cca-08de868f2c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

Add the missing amd_pstate_hw_prefcore filenames in the sysfs listing
example leading to the descriptions of these parameters. Clarify when
will the file be visible.

Fixes: b96b82d1af7f ("cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5..b8c846cbf301 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -239,6 +239,7 @@ control its functionality at the system level. They are located in the
 
  root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
 
@@ -264,8 +265,9 @@ This attribute is read-only.
 
 ``amd_pstate_hw_prefcore``
 
-Whether the platform supports the preferred core feature and it has been
-enabled. This attribute is read-only.
+Whether the platform supports the preferred core feature and it has
+been enabled. This attribute is read-only. This file is only visible
+on platforms which support the preferred core feature.
 
 ``amd_pstate_prefcore_ranking``
 
-- 
2.34.1

