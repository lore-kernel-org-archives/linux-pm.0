Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3F3BA230;
	Tue, 10 Mar 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113909; cv=fail; b=FW/kZho7IMiTbgFEc9IsuffmJVXSJyTdce9sLxnaeyn5abKmU4hEoqzVFaf0UgXJaK7Zahv7xMg9W+JkAJvbJDppfG2bcKtsZHEr3ZBN94yVjAcQI7Yqgg7A4n921KZ6HyuD2F1rT9ps23VB3bOYLK5SJpgesX/fWECk4joOLhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113909; c=relaxed/simple;
	bh=yjPVok7hadxmuoVJHFjkxFg43fz0TIgqm2cO7h0hIME=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q5QkNVY06M1/MPvNbjyaXhB7TMyjmGBKVpxyd3Tb+dtJDQ6jHEIvOO03tRttDYyw4pBso4xPBy5vdcbDRB/zpQffRG9tQy5Mfp9TapwI81pKax/So1SeVqXQFomtoxK6es/6QSzpDMBgIWHKqCjzqzHg2VQspI+c27tEDdhJSB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HS8cZ0aT; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HS8cZ0aT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0H05iJCt/zs6b8x4B6K3/fcfD0zPjEpJt2SDQm5qCPwHcwW+XyoMTrF3Lo3im1GwrGFWDAqWdLplNy4xtppOu/zxby/gPbu2mmRTKPCNLEqigRzHWPoJ4fu3wZlsSmuiyEFtOwG1Pq/X6O55wmi1NSDh94x3Lg3w7ufUSR+mQJQQzYtUf1ZMxgnbRA4G5AQyqMJARFE/gBuFMAUCY8vJXaJGMgFgK1LD3oFA6G4LSvL32c7JWewqk0Y0x8k80KLtdAbjtBloRVnnpDA25n6UJF5LznT6VO94wc9oVmvWBt6xBjbQ+gGhwFgkgfct184FydjVQ+QjhnjSkVCvtmVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2LGcilo/KUtqOFVr5xodLfw2lXyDlstbAYial9n/G0=;
 b=IWAyxfCyIaNrVjNVhcUXo5jS9DNROAEi6g3Nv5KglCaHgl+0fHUBSW6w39/ZEWd49y3YzTj9Q8+Z5W6vfkXdbvAY2Uw6IR0uHynTK4/jFB24hydi7X0EJgn/Nbe5JVfd4ax7yU4O+varXEH4Ok1b5AhIIH4SFRQd8HXr0ZGRfh2U7dLqDivoFpVUZe1Drbr5Ky9IT1jVYYSsjQdTKdLzld8Geyk4X7eY4A0jW0HaMd90Yj8EeOYFglWLPUL8SdFpYrXaktON+aw//livS1J+2roPkXJ+5e76GaoYgQl4ODgV5ZHbiFJd4rojZHWX5akSPn7+wHBqBHlNYPveMW8ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2LGcilo/KUtqOFVr5xodLfw2lXyDlstbAYial9n/G0=;
 b=HS8cZ0aTmE2J2CyxIbPSZTZaIwvkLy6+0QtvrCjFPm29o39N0F0mFnyQttt2o69NpNilbO9aOW2XKbk4bX9wPX06cJM8xgTfMDTTMubW7WbzpG/saxVknjksD8tbuRSJlhCO40/LCeQT9Jl3ItP35Udvo7V/h/fUAnrpyRmrm+0=
Received: from IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::15)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 03:38:24 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::2d) by IA1P220CA0015.outlook.office365.com
 (2603:10b6:208:464::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 03:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 03:38:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 22:38:23 -0500
Received: from [10.85.46.243] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 22:38:21 -0500
Message-ID: <c8ae4fcc-56c6-41c7-852f-e81cdf1e003d@amd.com>
Date: Tue, 10 Mar 2026 09:08:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] amd-pstate: Introduce AMD CPPC Performance Priority
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Viresh Kumar" <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260306095753.17155-1-gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 39faf346-f4e5-46d0-1518-08de7e567b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	8OhI0Mnk2SviJmd+4c6Z6jZk8NUrhec5dWZ71dI1TRQPeplP1fM9bjLJYtfhz5HabYgq0NEKioQbKZTAzxiiZTlJWFFv5SBD7jnjoyaNfpD6tCLJ5WNTh/YHDH0DMbCaETQkmSwwAVT3I9RthZXtGjM3uGAh8eyVmk/ir1m3zimnJvDLpWS6+RrcjtcP1E51Q/hhEvybllcDcmPdeGriUTi28vB7gZKPhDZPCwertRSrd27VsnYXSWGQmuHoSt29Wi/Zq0rgsDwJV+9JGvZ5z7EC3BtXpOLj6h7AbCjXMY0WmrDfUF3N/DSXHuDgU7ogXdYQhO/2Js71yHPkg1VIUIIYXE4EnKtcKZNRUrFYEB0zSykFJS8rabxkv1lnyO8KWLQxzBQPTgHIvMPrGe62K4gLOwRoJ3blL3+FsGkbKHQesOfCW0z/me2OxsvhTErFd42Zb/VkPssqJNP+S7R2ahgIiogRp4+LMIu3HIQXyEvueZwBmGT8H3SYKXV7sjjWFMWZGSOk6LcqlTph1bfV7VuIhgyTCgznSxdG/Mty5abaCmdMeATYS8hbq//+/49KP0iPM1Y/XAkLWRCWCQFEDY071Fya+/Q0c7Hoj3h5Wk4dhhSlB41hwUA1XbPrA+ZdSGANViE1M1kY+JrXyl+KkTT6IqdZ0edz9zVQUAWlgw3BY60IQFn2CHU0SVPmvj1Pc0JKGzCxC3mUDb1ts3a0mTPe8VORLARATba+rO8T9Bq1Oxd+bIKGKtKAv/+5m5X9XTylNsuadd9OZGKRgOpD3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NyhBr00/nF9ehJRRTudWvT1r70ajuG3nPwayRYVV5oF3CDafvZ4+GfuoZ+0BIbos9g1fFyav2dZXSumauSqlALX4VhV9Kpt/HXnukLI6S1dQ+v/qbzkXrDQgYQwQGfj8DfwKlhkOGSj+7awgSZEqqgdFhFXzNZPu+pNk3uTYJp8oau0Ar6AUrA5ZA62AMMwiF5MDXscQxttl61/E5DwcwiTDCDJZmc1Eix4jfAqiX6ZrTLWVzwiO4hokBuxOJ/6AIh30VdnR5hagd4o7vR6xzEFM1LSpvsOJZFFyDqNfIk6bkCyWQbr1KLBEDiM7RrmVOLflXob3mrBBwdnWQQotVehXsIR4y7HAuhdBenZiqu3otJFaqASPJkj/f0QbOaeZcfM8oknjl4c87Ge8hgcohMNQIXNegVxrex0wXL8eHVg8wOBNslq1VomYbzf6ir+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 03:38:23.8411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39faf346-f4e5-46d0-1518-08de7e567b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558

Hello Gautham,

On 3/6/2026 3:27 PM, Gautham R. Shenoy wrote:
> Hello,
> 
> This patchset adds support to the amd-pstate driver for a for a new
> feature named "CPPC Performance Priority" that will be available on
> some of the future AMD processors.
> 
> Details of the feature can be found in the AMD Publication titled
> "AMD64 Collaborative Processor Performance Control (CPPC) Performance
> Priority" (https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB)

Other than a s/GENMASK/GENMASK_U64/ for AMD_CPPC_FLOOR_PERF_CNT_MASK
that was flagged by the Intel test robot, the changes in the series
looks good to me.

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

