Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9938C2B0;
	Tue, 23 Jun 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202055; cv=fail; b=t+vdpSiFJmyMccUH/yqONMfb1olN/A4lQQmRwjvaA/WrVBdoZosCL6eLQ4da5tnLkgO7Qfjp9kX1Fbze7swhRJPtuOzs1mjpv+SRg9/bZfJpI8Cv8wjeXafZQ0srsFdUckQQQ1eToz+hRXBrvdTeEMi9xyMcenKjK9uRkfWC0vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202055; c=relaxed/simple;
	bh=jibhR+UeDUiFAJ+c7gGeppDN3yLzC/ClAxANn7ZAtBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVPHNNsmAA0CktbgKs3H2ymJnd05/50b5rsj5SL6UW2tm4q3GVKyUP9n5yAHf2LaB7bxxfwaCZdsLDJQs8nVfUVSIXJ3FW8xklQQEk2IPhcFYmMKnrZ5tBRZJDWtXYRfC1CfWlbGUf9ZzmzlXexfm/cFr8u7GgrQVtvnYVetIkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CBH3Xp+9; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBH3Xp+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO5iRojT7WoFGC4NQWDnxpk0fizJydvMG3PqQb9cmaodnKehMLqib0Mnj7MywDUMgtRqCkn8GZcSfeQJgAEEv9E/y60kqBD7mmH7iJoNOx/QqUj0edfO49ReS1SXNEjXehyQGMr/b7+OzvClQgk+uzCgPBiLmkLwZFDPBAPcvxJMrwUCiaq/3Bwlzz2WbYZRycl3ltwv1NF7DHDrKoW0eKg+CmeqwXM6xIX7Y9qjyO0Dyur0VsC4aKzDnLJ3vVMVhpqAcm9moXWv5YZXdxeywfgdq8RQ2lNEe8kya4SMqbUdH1mdSG+eSkTuFPWKQ0+rXpMZrTHBju+5gdcLoFQifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12mmDZpoA5T5DyU+9oFzxQv9ucxmTT+d1W0IsN/ekag=;
 b=Ok9+YWCacYWY/23cTSROZ4yf2mZVjYW6zM20r35ss8jTqZ8IBpdw9GDJcVHemgj4xxmFeM2xKPOUpM3w1H5JNfioJGvJgtrSBeDRbsYIyvMnSa0xbzaL4Gw+nN+uVbnmOVeaPCrgyr4X7cwdqxh0cBihDehQDxZMx44EFf9GIP+LZn753tfjM+x88hmsecX3+pk5Rkm3h7UafPg1iSoFswm53R98LUtZMKKrWM8koh4YEYzEdP4iumEiEfpMkBTFwqQ1AWTU5Q4KHCFgDAqzLwp79um4937juivVOxtVG9QNuolJo/sZ1DYZ64SFdKMUt17k5KAo4Qqt5m8nzI/e2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12mmDZpoA5T5DyU+9oFzxQv9ucxmTT+d1W0IsN/ekag=;
 b=CBH3Xp+9/SYvPP1pHnikWiIb+jYIBzwhfVZQoHV0GY4tNtxUIJP3WWv0wrvrgOSYNi1IfcilXZPbSf6L0zEoXlDt6C9n8lIdr5baYpAtlEw8PlaX18XbO1uSG+WN7S7hzIbowuA/t6FlzhmyKl4h8xM3AiDF73U3L5Un43l4Xk22P61Di3NsD8i5t6ELN52P0zRw4EB1MIZyCAqicN1q8KjuSQ6JeLxlFyqJwJ6eYr4epFDvB3+A9KNvb/Hzp5f954uKK1BxXCAK3Fsz9hvnOpRyDIrtsndVS+JwlXIxQsSv6MUoafYBR2xEhmqTAPBFJf6TTKLLF9egbSvjxFSsRg==
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 08:07:26 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::13) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Tue,
 23 Jun 2026 08:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:07:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:09 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Jun 2026 01:07:03 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 1/2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
Date: Tue, 23 Jun 2026 13:36:51 +0530
Message-ID: <20260623080652.3353386-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623080652.3353386-1-sumitg@nvidia.com>
References: <20260623080652.3353386-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 895023b1-410b-46fb-96b2-08ded0fe769c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZKYPfRYYLFXgrl9kr5TlNBfBRIfK07SUNtzigxKY0i6uFpDaqQAdbopuSrDJ3rXUrez6CtVzaFxFrbN201V2aYRno6NhB4IpI2lORhS+EwRX6NIqvvRB8FuUsxkwPANCx/vowypxICZn8BKM2fkbVyH50vnrB7ejd+6/d9QYfxk/oh4XyGXaB3+RnILrxQkeIwsTrZOlUJKyOODmqUabp1ygDobfNCMIppsQ5BeidI8KlX0fzIBqSASXCMEt8XAvxUIAhwZz+AhqtRuMDsGVDzd0dvfi6DSoZ8N2gn7rs6PmpcLgYNJh6XvYEQVc54eCfB5bgB17oLL4RYxqKsbLA3gaTIpdZEYV4blx/JovovzgolkrYaufzJw7YUcaiCPQI14FCnuz6tmgRyWu0+FVjL/cs/Ke14C9bby9dDQE2tVteaIJC6SJvTWlGJ4YfJ63muHCK1cZh+Wh8YIa+3vEDZKrvhcZ8KXrox7MX1AxIWgMHaJTNs5n26EPywlP3eoU6xH98eGwlxkwPpbkV9RTy1bSX6ee57qcx6IPMhBXjwpQP/xcT7aZQYNLN/x4mWn6tZDzfeYiEndfxKbtYieeivQopULQ4TG1FPCKnT5SapHlIya1/O51UooidVJ/Uq5IafPRXbp2pc/2pxB9qlGmmDcHrvMv5EfKYhhYreH9l+dkFkbyPsWnSjdXoFJjYva7QaMKASUK8tIJbKcyqan8KoZzKKymZ0SgetenVet9xC501C0vQTyWyrKZafHIbu0m
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jNgRISlULNgv4V00YRuOK26GSdBg5lcbAGxNrfDIy93Hz79UaVnjFFkNv8ahFnC/6t+abjAD+umpTUIFjlt5awPO2XORPblMNfXBtniL02vU8t7WZiZjck6en0YF3iHpZpXn7ZbXpLLzm166g7ki+Z+DbLMRaUO/Wi6mxJaTCckA2SC8v8Z7n4WLd1VWxzZoN5kjKufWC/kGT//uHrKbfyf4jAniD/GaYSSwIWXcrLrGROOUtV9OS0f1R9f9Z15ksXMI2JEaHm4y6nEgvuZLkBkqma++YwdUtx+F27Q7OKnLE6YvbbwGQX5jhrMC7hpF8dplCxQx2xHVAuEI6PZ7Fx1AAkBwipQWEo9Kgh4sCUf7wVTUrpM6qfmQmEQCxAmNY/WNJXXqflE9n8+CWMzfxDDFOcgIGmHVYGLwp+hHfaNhNvUUgZ7mRk/7uczMTbc6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:07:26.1457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895023b1-410b-46fb-96b2-08ded0fe769c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

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
index f6cea0c54dd9..f7a47576717a 100644
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

