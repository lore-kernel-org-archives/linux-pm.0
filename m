Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E12E2DDD;
	Wed, 25 Mar 2026 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412938; cv=fail; b=fsN6JCV8IlkIAhWH2buej4PK/9558YG6vKb8e4wfulnmf/ojs28g8xdJOYbC01TUPzpaMblEoq0saehdCEDvflXA86LVPYfoDr4O9YHzazD3UDofhOq70bxHxRlf+xqnLFM1BVyuCZ4knEC/9FOCkwXDGlJzLymvYQnAa5LJDUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412938; c=relaxed/simple;
	bh=mPyUv8/Kn0gtg9hxHj/qS2a7uCPYpsMSktVHOwXkk54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=flce/1BnR9nsdoYAHwHxjLyrTHHxbR21k8NL78LWVUuyX2nn77yz0udGnT0M5Dl+8odSIYN59sqGCjp3hGWxFhkq34Ec1yvyOa5SOm12P3fQ/PKSkIXFESaPWvI3VL0xcYkSilkl0graWtu4ijh8lDLIrJ6wPZz3OICjLk6H6jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oLA2nyfC; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oLA2nyfC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c14v6UWXiKT1NSc9Eylq92TxjGnDs6/znw5Cr0GsZ6EZJHanTlkjZFOTuhQCCZjiNT6PXeKN58Sz+z2HGoCpPbJKH2FCG6nm8+hlMI8XS9Tx7+vzskIL4muW8dtsKcDdUdV62plpVe6393nPEzPuN20DN1GoFbHvnBjL2EZYRxc0CpskrtftS1nK8+nT3FM/Ox47HnT8X5L+owIKBoQpRF/PevSnvwpyWJBSHUXEz/LgNkW8siImBCCyoSbiNaLkVk84ePSbQA0aXewui4zNzBiufg9+djeqGKqOdPlrpecJ0zOgn2UhPiOBI64c8GqQryw9cHaM9bvXBihL54Nt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmpjfwF+/F44wvudkonivK1JymQQqMnb5koQ8cOBPFc=;
 b=mvsk9tr/abWdv03w8fYc4sSF9iVuLjVNNTdMlgVfqaOlrYWXJl1eETp9+fgG5go7Lg3RKe1dGFGDlqW4VZxQu3rJEzZ5uZ0eSfjrMjHumnVKz7xLVUf6IMNg1uCovZkJmMQ/1DmAgdzChZ5NQlpmebABumMdGMRnh04/5PfyhYYa3G2DuQWFs/V/5hiteF8j8NQO5/7WrHkW2lkvI1Nw59cE9BE0pUKLZmXbEOBbwUQfGZDwzvEIjlzABu67bAe2HxiPm/CtimJ3MI7p+NHfYbdnorvDrWHLtMnX4fgBB2yrtjxOHBAeH7eyePqDeddhzXQed14sSTKhsywoDmV6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmpjfwF+/F44wvudkonivK1JymQQqMnb5koQ8cOBPFc=;
 b=oLA2nyfCnzCrrym9Ect9QyoYzhYUp3fZPXg8tEoI54sc9SygOu2d2BG4xqCdEPGVNKdtize45cKZuS8YVCZUag2IxFyvXzPDAObtUjKE+2gzAUOv1yKwodcUUam4l7SAIjYl0lwLMmWvia58zJmH3AsJZo8lt9qtr/jUI4RebwY=
Received: from BLAPR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:335::28)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 25 Mar
 2026 04:28:49 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::22) by BLAPR05CA0047.outlook.office365.com
 (2603:10b6:208:335::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 04:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 25 Mar 2026 04:28:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 24 Mar
 2026 23:28:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Mar
 2026 23:28:48 -0500
Received: from [10.136.39.136] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 23:28:46 -0500
Message-ID: <554baa52-c181-4dcc-a77a-ef8f4e0be763@amd.com>
Date: Wed, 25 Mar 2026 09:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] amd-pstate-ut: Add ability to run a single
 testcase
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD)
 (kernel.org)" <superm1@kernel.org>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-9-gautham.shenoy@amd.com>
 <0b1f1901-8ea0-4b68-8887-29e88e86ab60@kernel.org>
 <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <acITFNYfjSMc/K1I@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: d9200bba-51f9-492a-faec-08de8a2702d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	37AZ/zI5uOycNBZPIGHMB4Phb7RPhFHr02adTP5c85ouc/zOO+bYeTQk7mxf+6f9kiXCnAr2HO8IpJEyOmeymOClVYmgoRh4ZbnryLYU71ETF8hKF0Id0AOwwkaeylSUNDruGvWMe2Bb9BiQ20u6uhPNgwDiiEMujZnQwPvje6jm8TQrTHSe7ONJv/yh12RdLC5PQijJqWsDvaEqq9cbcz5Acjde68gHNR+DRhkSG2ksDuwmaj5fenmaWCz2vIEpqLOHJ8Rzu0drIjx6fQZw/K8bNZAHy6TyqGcoz7EadEB8fjdiWE1Z+J/0rE03kOnSF2+iOccx2TGpGYaymAqPcXGTU5v8sbcEgb/sVMWB+AkzSWD8sU4vUaOnrqr/Tvy8h7KVpVdmigywAWwRNTGZn5K4DXDroQIS1Cq/h9HlsO0qFqBMl7Gt+i8Z215COjJUbke8OqYFhwFIDnu2pZl+p5J0NpREREpCRhnZilKz5PKhgQYvseUOrljBM0ikRbL96XMSIuB/RkHVHTphneEvdHWvEfhG5X5zPXW8ljNdnGfKG3TeQkDBexm/0HIL9UyVUBGAMA+RdPlrG9awZwV41hPZLPaR45Inoh7yVgyvxhFFoByssHtiwVeRjhK2uF3Ig73R4zCMstaIIGIZohI40LpuCqtMN8F6W4i13XraiJOprBzBFD8bLw9cS5uRNNZuoXR6I8WUPFJZLPma7TuHY0alR7y8KFwfrLvIFfRjKrvks6iAFTwCL0sI1M0jcoaobtunMJiE6P+ukLmul0emuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DDMaNf2KZvjr8y2AvTWolwOL8jDSMEXgvQxg2rsssdennYOB+jpcruz7hk8Rt/LmZEMfgbq03ZHaXbC7ptyDpubfcBPTzvSO7o0UQaFVVuUclBD3tOfRMD7Oj0hnctD9CJZ2LKPti1IIdcBReckFXZ1aiUZsDQdAvqooVyf8szjnJ9/EceAwWZWmZC7H0U2MS4+nvAWZ64F6kNXCc60ExgzKvnm6gu4HebU1aTb8lVaKH9PEKuVZmBJ1LktqsYEB1TMVR8ihD1MncxWtTHqlmXfS3FmlogY1w6xZ8N277xk6FbO4SSdHPGMIh3OGazeHe+x1ch2XDBghUwsgl3VgJxNKOEgdsuxVj6I9JVKI69EN/jp7jgkqtJZGQbOt0TBrXv+lx+I6pd6mAW+njuJvtOe96x+GbmLZgztyjYjAkmpdsxsfshqAbxrsO2PxL6P5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:28:48.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9200bba-51f9-492a-faec-08de8a2702d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

Hello Gautham,

On 3/24/2026 9:59 AM, Gautham R. Shenoy wrote:
> +static bool test_in_list(const char *list, const char *name)
> +{
> +       size_t name_len = strlen(name);
> +       const char *p = list;
> +
> +       while (*p) {
> +               const char *sep = strchr(p, ';');

Any particular reason for using a ";" as the separator instead of ","?

I personally prefer "," because with ";", I need to explicitly add
'' around the test_list otherwise bash thinks the command ends at ";"
but with "," that is avoided.

Thoughts?

> +               size_t token_len = sep ? sep - p : strlen(p);
> +
> +               if (token_len == name_len && !strncmp(p, name, token_len))
> +                       return true;
> +
> +               if (!sep)
> +                       break;
> +               p = sep + 1;
> +       }
> +
> +       return false;
> +}
-- 
Thanks and Regards,
Prateek

