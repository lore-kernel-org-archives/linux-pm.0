Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A83AC0E4;
	Fri, 15 May 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848014; cv=fail; b=nhcHd5kb87Kem3ByXwJtIFkzMnO9VlTqFQWqm+7i0zejLE3ZUy81Gz/rjaSLJsKFq/1cKbke1flxi4oW9e8UuqZ56jb5vbyv/Gyl1V+Qb0KWUrYtkrOMSek+K5iOsNl24pwlQHztBGdQGr5qxtRLHADXM8n1nPJAl5K6WLRMk6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848014; c=relaxed/simple;
	bh=Iw3YBPdZ6yufVe0SSRCjWYBpX7TEFZj9/A06Hs0IlzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5ay0KIt2qdwbGTsUvLauuIYMtEcwrGPgjYG3+8P1r/Gupm72c91pzyjFjVdwH6ap8j+gtjmaSZz/s3kRaKGRwBcQ6jJ4pVdLWA+UTPoCpXX1jMy8fdQBIL/zVSv10ma5DxqDnxQu1wtge5Ob8ZtHU/3qk1bs6ANIl30nT1WkhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s8i4OqkN; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s8i4OqkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghIyNb/yRg+lg+8bfg8CRjJzUc/gfYEmh1vozNpPt1TVhb6sovJh4XoznGN9XkucilpwieMT2p+VaXGZk96fuQALZu7SK8f9MxdWVgTKsO7jf3dKpd9DVtIjhzWnNDp9pVDvy2bD0l3OcFveyYRbcEOB8wPH5E0mi4uiyE1VtXKsbh0otPro6B5LLcHaEJsE1qOfwxLvu1v1BbwIynfKtM9MzlS7M/TkWI573yFRSizaB5q1xyMH+gqk8Y1KmUHtQZ6om4eKqVYpqHEhZyEnXy58TpNoQ6PJJ167F2umVeaCmvxYdru38pwfhdCc9mJIIiY8EtI9br5GsK8NKDVeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEk1oJZVJ1zWkrQEyFKIauMTtTkW1izWqpRXyqKfdM8=;
 b=XsJggg8rkOr+ZifUKz6o3zUT8389rhJuXxm62bPivzQhVQuEwF/NOrIo2BZhjVaOZbOxTJrHRe6g2iKfQfwX1zWcjfTv+u0splQq7k9ybSH020jKFJGf4C4xY0ni2YrLlCJph4tyHdRK7z1JiQnjv9Dn+jvNGv/5OxtC4tg0IGvHqgu8o98drVDQTr7YS8ZLNCEm1TMZMddcYOphSz3YdiLCq9v2XOyn+FI8vS/Dyo5dJ5XYQH9exNFclWIL9CqIDBs3Krs31g7VQV+yjyJVpJSkk31GM/uj99e5Epo0VVx3yl2GQPu6xFyN4K2VDERHdnS0kk/xrRbU9AuS1FY9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEk1oJZVJ1zWkrQEyFKIauMTtTkW1izWqpRXyqKfdM8=;
 b=s8i4OqkN1HKbelmWAyS/g18SrxSLq0LDetOETl4LB/Gwzk0dwINsLuoKY/TsETmWvbZPlpWmGFW3NG+ToWNN/wlutKjc1kxbYgMJtEk16sewjAcJLntjfLbdDbymAae+R/z/4n9b9wqpzuu8P6hxlQTXCWurqYFWfkj2YVqwkJGs2gsb6Z+eEPiMN5uhZEbDohhPVcIzE/J2w5RHpzgSl2i6JDVhMnE3yuJCO3cu5ClrshDNGvTrfsVlOe1r1akyyDMTgPjpzEtwwyxnIlQXOvJ+aC+GU3Z4c9iVchZTrY/gS9DlBtFmEZRsR74QKNDr+HtjI5dm73d2VW0bDSU2mQ==
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 12:26:45 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2f) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 12:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:26:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:26:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 05:26:41 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 15 May 2026 05:26:35 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v3 1/2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
Date: Fri, 15 May 2026 17:56:23 +0530
Message-ID: <20260515122624.1920637-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515122624.1920637-1-sumitg@nvidia.com>
References: <20260515122624.1920637-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d74b35-cad7-4b23-f74e-08deb27d39f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|56012099003|22082099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info:
	zqprd0WFJCIV0kEBdb2nnIe2Unyy1qYPqSIxR9PuEAd4SPcEXlO89Ga8hui/3iNQ9TwGlecjTe7dkKnseOaUD4wW+J0pmcM4vinvvXlxgYuX/rYe1efJ4flAvsu25iunbz7bhAeggpp0xqHf+w6VGN28Hqco7q4bMOzIfq2LBO/JVgCtDhGkM3km6+qmXmKyffMK+TYYLTe2WzB4wqt6LQacgbKd6rjEM1xaEKyUih/ZKRadjQ14/dzl+n+nK4msGnyJH5LgLKZp9WwONnO+hNugkxU6unHRzjxjzh8YSX6odAGCIlOkl6vyXIrkoIDvzpBAIadlRTUxdV89Ly7oiy3XUG76drcFo6WJmGrl/Gy1lz+O6qENogef/ZLTy5W4ewll+kaQWIN7sP6cs7KD27lRdI2TNFH3W0PRiHaiAo/QsYML9u+BimXt9XJmDh0EtKFBKb4zKobK0SAUFyL1IOQz/S8+iaZpOgii9sqwNPRQOZ/wAUPFTkcWPXoCZO9Qx9Cw6nRjdf36rg2/Ukzv/pgQBAciE9c3htMTsb++OE9lf+mS3RhhFER0/VMibvMvy6iV/oSHQ13isbJz+oB5+EDiFF4d4sBgOrt308uIMGa8izmjOD2sVxCO7F8aJLF/ABXKGScGl07DOp9AWxeAxjHYUc+0MXCNSFYBaR3azNEr6E/zqzY2mg1fn26PomeGKuBhqfk2DCWHb1pUmhjZg/t7VJiA296Y8tFBLeX3lVEjn495/Pvve04qgmEaKvmZfH901FM9YdNWOfCsaNq9gQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003)(921020)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	32SwUcoygScx/axb6yqN6Abj3x0o9FFvFETtPPxyNXmL6HGtE1blK48w4ROV8BWbXRmk7B/+WuSj0tTTye63VYvzZPwIVDaJJUwSeO3QPOKUNwVgAtv6QRNEHwzKHLxU9AW3gZo3oxe/4VgsKVL8DSCs8urynHGXqc/qQ02GSkXURgFFjVvmFI4gGYfDyGlBqvrebMSdGfXu7DlwnKR1pz2I+WIQJ8wz7HmBKoDNJAedxb2TK87lpLbq2hoepWuz9VPMVbApU7OyOwvDj1xr6P4jx5NmLQi95UPDRLLZ7C9KtNQLPMiEHyTxzq5TCUGMoC0tXwM+h0FUoz0pn8flqUR+/C8BN+joIOKl6pWc3Igy41I5CXHHQgdHj66HtnNQ10MektdLtFdTsZP3bMJfz7dzObMPlmuekcOkwyqQ7PidfZiQUNzVMVnzl5IReDmg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:26:44.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d74b35-cad7-4b23-f74e-08deb27d39f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
  "If supported by the platform, OSPM writes a one to this register
   to enable CPPC on this processor. If not implemented, OSPM assumes
   the platform always has CPPC enabled."

Call cppc_set_enable() at the start of cppc_cpufreq_cpu_init() so
this is done for both OS-driven and autonomous CPPC control modes.
Errors are logged but non-fatal as the register is optional.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c1ba6c656f61..6b54427b52e1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -655,6 +655,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
+	/*
+	 * Enable CPPC for both OS-driven and autonomous modes.
+	 * The Enable register is optional - some platforms may not support it
+	 */
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
+
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
-- 
2.34.1

