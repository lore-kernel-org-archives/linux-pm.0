Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0675338595;
	Thu,  2 Jul 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024599; cv=fail; b=KN2Om0cCZ2jeJV4jmzjTufUgCiwEIUiBzc0BNcrdXVL0cpVEiSQBrc9ERPdcd7O7EdPXyGxFkx5c7soT/FVEL+UreYanhBMc1FKcznhJe2R3br7FdAQCu4GaT/NMdNahyzv0lAY6QsyEt3aFRf5IpflbFdiQtpF5FbbEPcAXpI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024599; c=relaxed/simple;
	bh=SEKdYGQ9EO8OOvXPx1vKk2m3/B3W/4e+JKh7+5I++AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjOMPTOTw15/qYBW/IwKYKhYx0nUC3iuTtou1YgT2/78TxpZ1U6G67JKVESnqnZGtXicRVFcwf3XUcL6UoZteyXFjr5LXk1NKBbtTXAS9+/feImG1ZUXs89t/e85NBuMjLxe96dxsxBHpM9L4fMVPmN2ASH+Fep+wqnfhuYMybY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uBvfsT3e; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uBvfsT3e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/EeeRvpYFmVipiWJyET3mgKDV2JjqIHNB4cqYBCUmte/T34rn+WN0UuP4RS7ZlR+XIjt5lbUqQefmj/xZcvgOosf5ODA3xrln4IK/SYdgxaPChBELIUn2wrLzaB7tcBaqSwE8R3lQPNnunsEtYiesVsocp3JmR2NN2A3ZIXEk3IUNagoaWm89/0ONZ0t92DV+va4ABJv5PLXAmT2lQ9+Ik6ZhuVBSikhl3I1w39Pvs5rNUvsr6zifsx1K5+Tx1FVFpbknW7b7rFNrLX8bo7WftEWhTiN+4RxPuYn+8BIhvs0Jzqqd8ZkFcuLArR62PurWRStajqeVrZew9kbwKaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISfpaqQpHEAfnWySxi6iDWNeUfmE1dOEiv1CH6e1Gyw=;
 b=NWon6R6S4xnZ9zpaUMc+q5AFxFJkLCdpA4M7i9YawFIsDI0FAGUzch5/N4coUwh+Ma9XvrLDiYPuyWl8z5f2UoZllaJh/QsOAvzQM7VkpX8++xPOUiBli3x4bMv98B0SulLHlu1SbSakMeLuF8d1HKhNDiAgWnR2tE97bdVtL5F+nxO00KojU3QDX/uUY24RYXUh72PyPk9RYKCDSNvpDwlzzf0vv0lSAaiaey/aA5J5NyHUnYgP9TQwj4hShCVuQZrtvX7NpMXjllhQhzZOI4FKWFKH24qqwfxhv+HbUTrRSKkO9c6fG2BP9jw0PZvqVqNsTi3tSRk/cCoXC4tPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISfpaqQpHEAfnWySxi6iDWNeUfmE1dOEiv1CH6e1Gyw=;
 b=uBvfsT3ee1cMbc9Gxw3yLIhvlKIZ1ZA14bbJ9dwPHFdWWxrftySMlJA8shmr8UjzREG9o3Ob9d40D8un1G0HDr9rqnLas0RvA5LC8tvM/NomOMOMX5olh3fUSCJ6/hjkLx+thQePpgIElLpXWs+a4kM1SpAKJ6fNHVNppHMG4eM=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 20:36:35 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::47) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 20:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 20:36:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 15:36:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 15:36:33 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 15:36:31 -0500
Message-ID: <5f271215-6e83-4d75-a562-16d8e70ce672@amd.com>
Date: Fri, 3 Jul 2026 02:06:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] cpufreq/amd-pstate: Repurpose "amd_dynamic_epp"
 cmdline and corresponding sysfs
To: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
 <20260630185904.5602-4-kprateek.nayak@amd.com>
 <8155d7c7-2a10-4fec-bfde-0aeb017724ac@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <8155d7c7-2a10-4fec-bfde-0aeb017724ac@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f94388c-4f75-4e8e-f2cb-08ded8799bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	rUNusGWWY1czX/rstLehHwYJKlfldoG32TraUIpXN+V7MoR1QVpf3Ihil/Dop+UiHLHIIHMI90Y4oxYr6+hR8S+Mzqw6A2ncfuNhc+nRPOQX1ShIUykiGf3hCFrGjFraG/7JMQeaEIqe9S1ktjcaa4T1ZmIu1zKCF9HrLQREEfO0wR0IcamY8Ucb/Dk7U0nsrlfXfoO5Qt7fbjtvPmkWmuN61z8pPWlelzC/f1QrP6ime+oM9a3Ww7jBPn4fWcZ5/Y4qj/6EkEM2GiSbz/mBJ2p3CEFxjNw07JFXEwhsfT8K/b2xtiFFZ9OCUNNCp1OakH91sX4iCHafajdMWfKLkA4I6TFFr9jLpqUzoWQ8+UT2O7gga2MRqZZ9LQnkuV1mCRv0znWIoREYCrgI6rut9eu7y8H/vTBmXPtiI10mzOTdksBIrcWW6k1rXLbU+JWb5/w2Pux2VU47JOxZ6PxqutYc+Jof/F/uy0arwotZHJRkj1jGw9OA8ruAvdYt+hoNHjyGzevkMhmQbCuYWvdF3UTvP/s1wEnfbBSM2OrmS0dGe37nzOofCtRSJ2sS6wri3R5C4Loox2gkSitwfzRTtXrss1k4TkFmubmtfaMhuF5+XrB3QotgJqCxYmvR2ZvsbbvffJSN8wQ6kRr7PBajg6USIK6B0/grW3b1kyVwfseOzyqOyYpEpuFXoZNYxj1juj+Ua2QN+J6PZcq0xA9xpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VaTtEmE7oxllX+RDa8j2V5+HiBvrD0hPN3bEOOoPWuD/TCsgErbNGoX9DnraSnOwmqQj6BL2zxhFGuPKKNz+JpeVJaBOIMgNfNfgEuoMD/5SukfkYI26FVRHuigiCKH1KLBngd5VR7RcEJYS2eqN3XsW6OXam/OUmthKK+APQriB5Sw5RJkAqaf2EW0KIbvYa/YpIof2afAy4i09HVYp6fjpm4OgidaLAqI+paF1z55NGAVepsxhkDTyOt5SPxbW2YvdX1q3Awj+9DJY9rWGfExNQSYRknLTXe+oGIHJ/yL4hy8DQuEfgAYIJbf8eqlLVLIPY2cun7RtMYzI5K5xPuFGQ5XAdvfXmVyOt+NPW14dN2mGgNSLO+btjC4Ng1i/Y+4MHJG4DBlafwc9EDYmX247Qp8+qFCPn3Wc0FKbj6AWWwCqcdR3ss3/VfqvFwfe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 20:36:35.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f94388c-4f75-4e8e-f2cb-08ded8799bdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

Hello Mario,

On 7/2/2026 3:10 AM, Mario Limonciello wrote:
> On 6/30/26 13:59, K Prateek Nayak wrote:
>> Since dynamic_epp has been converted to an
>> "energy_performance_preference", toggling the feature via the sysfs file
>> is now redundant.
>>
>> Repurpose "amd_dynamic_epp=enable" command line to opt into dynamic EPP
>> by default when the active driver is loaded, or switched into. The
>> "disable" counterpart will "dynamic" option out of
>> "energyy_performance_preference" to ensure dynamic EPP feature can never
>> be toggled.
>>
>> Use a tri-state enum to differentiate if the user has supplied a command
>> line parameter or not to enable the feature by default vs keeping the
>> current defaults as is and allowing users to toggle it later via the
>> "dynamic" option in "energy_performance_preference" selection.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Honestly - I have to question if we even want to have the kernel command line option anymore.  If userspace can easily opt in and out as in this series, do we still need a kernel command line for default policy?
> 
> I'm of the opinion rip it out, less to maintain.

Ack! I'll rip out the cmdline and the "dynamic_epp" sysfs file then in
the next version?

-- 
Thanks and Regards,
Prateek

