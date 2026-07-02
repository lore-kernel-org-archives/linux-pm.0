Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48A36896D;
	Thu,  2 Jul 2026 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024223; cv=fail; b=eypsarUrUJpRwogkwinNpuPMAFW4apopiEvrYWUPDj38dYYqVqlp9tnYgQBDnQFMPL97YSz0KVI1jVImGQqeVBtwxr9TACaj/jlEPjv32zExA5/fyiHqvzM5dCnx4Y9B1iB47ICNZGsCBKBUnyBA0+BG+zsFUpnw7RNWmEmWJRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024223; c=relaxed/simple;
	bh=Mep16tbZQw8Y/r70SBBUVk2Stmp+cvHrQ6ExnZobmR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WH/H3ilDsnYRkdQepUXaGP678TWA2HOWfqMF95iwsSszuOxRPA9b6ko631EQZqEuK3v51+pnXNnVP/y0B/z+0IACOimshrTrDXw0ydqoEld6Arzmba0pz0sd4oI1o8AtBUP/WvwRouBk52u69EHI+9PJgaNhVuPGtoEozDrA+Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MamidZ2R; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MamidZ2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP6HuQuW2c1r5kI6I1gwmbLisxlafpzAWURaB0KkCbDq+Vyro1tHlYYsM9g2hgWfQNeYvfz0ehgVw5h+6U0fZ0Cqq4Mdij9HqGCrdphyGvCKf70fRs/weyVAbvlu6betrwA5f/LKE+jvpXDOA/PCaxsrPpV+muRG5YpHGIKDw4v1E6AUv6JJFmmnfriwRoKFG6Rw3s0axmNU2FV4pSjfEhXc9lykTUGdVPrbjA0nh2chrUb4w4vYuOwQlwrxK9zTT47C0euSviOYNn/fSqyJ8ZL5Naf87t9HrONsbZh9KJbnVNwyGa6JnUda1WEW5xJ+aljXnWsMLv7CPJzxG9GvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xDXD68DgpFPZPKb3RwXyiOImxoEJcUDsvkcaYsJb/s=;
 b=lLF9hpLAb2C1NVdbdTTL3+mPSJ098QWQ5t8FXYgQY/aYRqweTDqjB9pOxLc+BqEc0D/uGESFGreSMiEO5jkfGtGknFhAI7J8Rx5viCWNzdHh9dA+s7NzD61AOnDdhR8k+ShbyzHJPSqH1FqosvE9MweeXDK0T3QSDLJ8z+FSUXSDZXXlJv1Bi2uIqSGPPYneD7IqG/OJnQzSig0oFyBQIpzf4e5aF5LfXWtAs5Sb3MpykghYUZNnw6WMEBYPzVyVz9lWz4y/QU8I1sNawdMmU03DbKGMyYqu2qV/jf5cHMEPY8OU2HjZEbtXKNYIDi8INMONBeCoO9m0+NfK9Qhseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xDXD68DgpFPZPKb3RwXyiOImxoEJcUDsvkcaYsJb/s=;
 b=MamidZ2RwZ+WO8TCNAYNNAYP9EQ4o+1PFUp1EyTQ15Mvj7lUgSvZ+qx99qDcAEgiVfKmtBDY7NlTmXOSIiB9pRPBr9UAufgWG7jjgQ8LiDg3GZ4lUxNdscyp4eE3534NT43gqf2k2yv9sT55/1mbhLsQzUmMcGaqb7uFRAr5pLE=
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 20:30:18 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::2d) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Thu, 2
 Jul 2026 20:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 20:30:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 15:30:17 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 15:30:14 -0500
Message-ID: <777710d3-c25a-493b-b81e-4b114b412343@amd.com>
Date: Fri, 3 Jul 2026 02:00:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] cpufreq/amd-pstate: Add dynamic EPP as an
 "energy_performance_preference" mode
To: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630185904.5602-3-kprateek.nayak@amd.com>
 <01c027bf-0360-49c1-9d11-141f7dafde26@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <01c027bf-0360-49c1-9d11-141f7dafde26@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: bd71bf55-b86c-4bf7-eec8-08ded878baf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|3023799007|11063799006|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UJO3Bk2PPeCUkVMgEIb6d8zmvMG5BXQwWTV1In6+imTtuXh6pzHan2D+QYSTUg0JbxjXz3j/S/x38htXm4y18Hxi+NbkZQ5lzNJ01q5yhz2/fkv1jtyYBtM1QGkjsFYG5/d+g83RdQ02NBkgbqjXC/NP255Vh7VbuYycPCZypSIr1kaBaM6cIvvQOFPz/H2XcKwiX75izJdWklIA8msSqCCmrrHku/FvYeeTqKGUZFvemct8qMtLOPO6hTltHFqRORLCTdzxheNKbVBw519gDLqsCVzRgIE4DeAweoMwR+JBE0bjzFXmH1JO14mdGK5KYmsWANsd/1llyvVfK+qPSwaeJcKeDKTLjB9mZReP0tg7u4eUParumh72bHErBtteUcm1fzPLYDRW7BoFx9XgEyFec0d7UtGyadmT8THSwc9r+YxXjPMi7l1l7QfwP3q1LHhqwA/Kqqrwz6awl54UCYkzMM5s1A/x+pnQDqjuzaWs3dyE9FXO939HOKvx3dQa2IJ3kwFKG9za9Ewl3VD3/0EQ7swNAmAX+7Ejm00jVt5VjvhKhSkzTLKR8TC0+iCiItw0FCIxFqRfdDBJKm/hA0JFvvEpljXw6HkFb221vJe5ai3/TkTIoLqK4y/K1yFDYBkftGUVyBvFWD/h8qD8BRvTOAxsFLBIcMl6p4I9r1UTczvppfS9O5I2wgs1wtHY11A0rgM7meiBr9ItvTvk7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(3023799007)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MXhPE+rOX2007uitk1uzY9dYX8+40+8MOvQ4OnC3UH+wwczXY3KvMt+acgEJirGggM5IuhA68O7qW+Zon2sn9vJqqYxAUz0MTPPJMhv2evz8grrVclEQ140n9v7gHZdM0IRYMmQePGKcxsS/W3knZiLiarVqTzGbcblGtiDY5phPGW3t87ghsOUbEDe/ez2oglwOItjlNvHEM8LgT1OVihVnTotWmREzQjQQqiBIdrL4g1yOtwsjsYbGutXVhDaF1ANil425tMdb9R/yW7rM1t+XZT2SgD5r23Bf7AledIPTGNocJeypTQlAovxYXcDqlvwbYk2JeNTH3CjDnKJeW09LUqx+iG1j2EYVCLDlWjkgfF68GDIZiATabKTSEByqTUnR56VsG2lH0dzgo4Rj0C68Iyoo13NZUyCDnIqQlTldkKJTg6FIBF30iNKhAdp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 20:30:17.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd71bf55-b86c-4bf7-eec8-08ded878baf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

Hello Mario,

Thank you for reviewing the series.

On 7/2/2026 3:03 AM, Mario Limonciello wrote:
>> +    /*
>> +     * Do not enumerate "dynamic" option only if disabled during boot.
>> +     * Users can still opt in to dynamic EPP if platform (server) has
>> +     * decided to keep it disabled by default.
>> +     */
> 
> As we're keeping it disabled for everyone right now, I think you can avoid disambiguating server for now.

Ack. This is just a stale comment from an older iteration. Sorry about
that and ack for rest of the comments too. Will fix in the next
version.

> 
>> +    if (!dynamic_epp)
>> +        max = EPP_INDEX_DYNAMIC;
>> +
>> +    for (i = 0; i < max; i++)
>>           offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i]);
>>         offset += sysfs_emit_at(buf, offset, "\n");

-- 
Thanks and Regards,
Prateek

