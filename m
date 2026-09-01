Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F583134CCF;
	Tue,  1 Sep 2026 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255411; cv=fail; b=Ez/UxY8e1hE6Ysoe6aPmhTH/sDaCBt2995hfoF0KqNSty2dYRvTMjlCTl2Oc+o9hBMhC4FGmk8QgnU7CQsgzxv12i+nipXwto4RIW1TCuwbdHF4d9oubSAHRjKnPUBXM2ut0hmH3fjuXLhNjjR5r8EhI7rQzSW9fRDiHEOFKJug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255411; c=relaxed/simple;
	bh=Sx9cf9kqKt2goHix+1lGAot205Xf52k/WeB4BnsMKVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VuDILZsdFSror53dxpSM+LIUEj2tayOaD9mb0dYJL95FKs/v/bMjEjV1u1W6ymUEU8aKrn+rEHPR3ZgUUxdLOCZu6utKJQ2+Gx2PqelKTV/k61SQh5lN28niJEgEBE8bLb64+M3bDfI+Ni0IoHwwfo4jh0wmT4uszexCGdBQIhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9eQJRMS; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9eQJRMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRf+4fkm94BKSE6j1RrWEVKgPCmWBfiAJogVzgu62ZcUvzOIxkT7vSDrrIRA52nA4c39Xgj6pLWbBnXkXTijG7Jy7goXFYvMNuFe/NnT5PQ5Io0FEXeQW8zrH/sYlnAXSRrxYD/qO7V+ENI9WXlh8ykZMJGdRVTwSfQ9uMzVXAPnUoq38S4fPliBNprHG2xpyOqAOznwO8u/iEw1kWxRQSOABBMrJ4hFiAbm7KAnERhMltAl1daG4azdDPadT6/AKYc+ktsJiDh9yiNRtYRA7++SdKyqGBCcFtpM5llpnecVZX2COphDFliJL0Gl6buInlce5rYy9wF1B/lWD7SP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMM7iQTjXlkFxFIK9pumRkOkrwJFfUdzNJfwM3ZNGEI=;
 b=prWojpAGHUMQKKFp62r0T61pCsc+ZaFRAQF9DFR1LpD4rmLoeZ/4Hn5jDUOEQwBbkA9xDmI9WgqdRUR4J57/SIyotVxT5z9HtsckBpXk1qtcWHYgrY0BCd6P0Wf1dijPVv4+ST0Z1y02ImR8bbR1WKiEBZczBBwgeNOMB8cc1JSqfMXHjKn04R0RZhCH1xNl+qByJi43o2yrvH9RE4Xt+9tOn3yqm3PEF0c5eYVR5MiZq4Ev095ZYzox0z1n7Xqvpm2AGR8+2Wj5GlPCl8gDuCgSHLqjkJofZF/BANyDtGYDGCw185zIbQEzEiAXr6bsJYM6pM8Rfr5jYe1GM35U/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMM7iQTjXlkFxFIK9pumRkOkrwJFfUdzNJfwM3ZNGEI=;
 b=f9eQJRMS62/ggS2oj3nvrKatxKlR1VI9egmCBhhp7H1Qp1HTIL4tfq6Z9xnE/3oXGpMamw74dYXp+dom1j/hIsnyry9Pyx27/8B4kpmKcYn2P4xHOUBu4giyv/5mmHQUobLPf6jyKopsgS6h4gvPADRNb6J2P38TSMrnGPj3sk0=
Received: from IA1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::17)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:36:31 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:464:cafe::2f) by IA1P220CA0013.outlook.office365.com
 (2603:10b6:208:464::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Tue, 1 Sep 2026 09:36:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:36:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:36:31 -0500
Received: from [10.136.35.162] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 04:36:29 -0500
Message-ID: <9fcba9fb-8e1d-4157-8e80-bf7965e195d0@amd.com>
Date: Tue, 1 Sep 2026 15:06:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Zen6 client CPPC
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <x86@kernel.org>, Vishal Badole
	<Vishal.Badole@amd.com>
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260831194428.2287055-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e1381f-c909-4b21-596f-08df080c8183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KkyEvAoeHJEpknRW9cbppaqM1sr/hCB+n91IzCOPBdfqdDISDjiv5J2MpcjIpnjuaVcpnvWQhRUkkSKlHm7b4bEoe1dPNDbujBRnxeMwrbchxaGfhJNST3ohVpqWLaVWQCSW3IFDDZfKPQnSJBW3lovkrGcEGTB/feflIi3d8RZO+WZB7s7rdkjeHR9kpoqIvgsu2uAoG7yfC3WUFAJvUEyUObkHcFXd1bMOQfykdmd1GN+PyCaZruSbGbtyZJr7EUryW62/fBy6VDh+2PsPLbkAS798TOpmh55JVZ7tI5gVFbgvbHlGxyZaaDlk4142fE1c7I+QhelEE6U8rlX196q0t3v/u7DZAiHs74a5eEbgXyB/BerhJFttBiceLIebq2BZ+X7ecldehoQj7+hvGBD8z/to7VkiwR5+eAgx4iEeFOoKmHf8LlG9mXCTnSriFNgsG9UiRJ1bhgs7Bj+Og3qY+gQSQKv9Zh4TndVvvb5lWh96FNZ/crGQOeqt4cs4qXfrBG+wXG5HnnR1b8MYiaB3HdhGq7ffc/o2svcgpdXjnYs2M3/oHM5g7VIdVO0i/FdjUS4l12EVJhWIMXmqZhHJuuYWnwW701PycqBR8wtw2lt1zEMO1hP1cqyVuiZhBdjWvMjY1FrlvXlklnL4lxVaf6TCmDzTFXl6Zy6lMRfNpHeKBStMWjv71qKWBisE/YH94BGMJvvdavOFYIL6zg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bGRAq1Du4CPwd2Nf9XI8JwyfGE4nemxCTOWsla9bGhPNnZBuY0P5Cym8SaXkhJlQibC9GxYob9FfOb34IYMcrCnsSjFRduDjoOzTDeYdcNkGcsfSjNVCZlxZeLaLNfhldrudwGp5pyPRywTVsmS99HPVOseJZoPWd8clcxtlmIIc5aBL0NSfG0OaRdL7FHRqOBK0YthM0tiIrc9z/rPLwfHrhl7mSV0nQoekj6jbj0Y5YURagumI0uDR1WkzQEWaLkMzLRRSQ90RlkcL2xhO1/Z8D7pTTaHaBnN/2ekUusdZHV7+0O7T9uyrF87Q5dvMIvfkdsUn26+tdKggVX4D8DT/4ubzWLChPXzeRMp/sZKTA2brf1hTdsBLWuwO3EQN9yqV+qSX7GPRSYPP6nOYyPaVoNJYTienzC9EbnMBSmuPvsegfwHpHALvpgzte9af
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:36:31.4972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e1381f-c909-4b21-596f-08df080c8183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

Hello Mario,

On 9/1/2026 1:14 AM, Mario Limonciello wrote:
> Zen6 client platforms use CPPC differently than previous platforms
> and knowing maximum frequency for a core type is needed for capacity
> calculations.
> 
> Newer versions of the ACPI will introduce a proper interface
> for getting this information, but for now hardcode values so that
> these systems perform as intended and to unblock future scheduler
> work while we continue to wait.

I did some sanity testing on couple of servers and everything looks
good apart from that one section mismatch warning. Feel free to
include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Mario Limonciello (3):
>   ACPI: CPPC: Refactor boost ratio handling
>   cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
>   cpufreq/amd-pstate: Get Highest Freq for a CPU
> 
>  arch/x86/kernel/acpi/cppc.c    | 174 ++++++++++++++++++++++-----------
>  drivers/cpufreq/acpi-cpufreq.c |  17 ++--
>  drivers/cpufreq/amd-pstate.c   |  22 +++--
>  include/acpi/cppc_acpi.h       |  14 ++-
>  4 files changed, 154 insertions(+), 73 deletions(-)
> 

-- 
Thanks and Regards,
Prateek

