Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085A389444;
	Tue,  7 Apr 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581826; cv=fail; b=jUpqrQRKOr7whLqjH287P8Xs3ONlchXCcudLQ8oRKOacUHIywL14E0LEv91VScQV7hKFDQANoNKHiBtlaXgqujrPOa7T5ZynHzEX4vFxR3wdpn6s4uzEvdnrRnZOw/K2ytS8HJFEJ6FHiJG51xJhfvygJIX5W898yi55wYrI5dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581826; c=relaxed/simple;
	bh=J9wuPBEb1b1Gl5BFeR1VzuNotN6wkceypdd6usdubRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IA28FfM+FOJ0mgZ+Y4Kng/QG51YaT69ioW2KIf9LEXH+PnU0yVfV/2XCYaDe2U0EflVESMWA+ml9GccwLJSxcJOYitUfKrAUNk3Wdqnes1685DK20xiZnYeXINN2BuP/wEGZBu/y8DCyboxj6o+zphWS+MivE34k7HwgrSLI1YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hdZRFceL; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hdZRFceL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmbBm7Zu97WAUMWuNgeKz6dgk9+KSnwpwLpsLhbZVVNRgB0eo8vV5CgcVnIA+Tx29zzUUQ0XQKnBM5Zmb305QjtMZArbcKFSMK4HMchcbQ1zRdjcudicgtF1aw+uAmEwXuHAs+UwetDxn/LrCatpej13w6XGFKa3Yt0FsLhjIazsnNr/hg7jCJHiQ+UE5TngIgy1c++nTCGxa/jZc3TDKj0Tp3jeLlzUPI4QQVhdb1o+8zwlnu7neXskpxSIEF2Zd2ysw+jidyOr2/EtoaiiwMaI0UYoQyQit9R8HpFuHGPMLB2lW5zo9O38L6f/naIv4MDX9q3k+mV2s2I89KxbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3iG7E2gDS2ryZePu42cs73CiS0nJ51rtvTcnY/0IVs=;
 b=rorb1l1FH4vsZ16VBxAsakY0JYzJacFXyQMszKUPMdDf5LGA0bCS+YxNt3xVBpzJAeaoVKXe/vJeyq2ydegEURcEER/pUAJJHgcfZkm+pmtRJz1y6sdWHfoAjEkbPpmfWaUdjcrdKpg738uadsfOy8GRC2JnlGfIhxL87JrEsFd9YKI6RVjm0iTKLivaurMHR9kFOzM0Euiz3qx09nPszlxc7tgvRx+Y/Gm+xH517KLAYBpv11eXKUo9XiJj63GvSQfTb5Nv/CJSJAXeZPddT3Tqr292bvne7XOMYd5Zp7yljGEwR+MeHAQvMl39LR75n+C9tansgxIt6jkxWHimfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3iG7E2gDS2ryZePu42cs73CiS0nJ51rtvTcnY/0IVs=;
 b=hdZRFceLUTwIpIKfJctJ2SZP0D75Bnt2vY6Mi2F/7SUtsjSVUcUiMtPwRwOisJrUxiXD2opYpC9n/wbqIPs4HxGgmIsS3KfKrph8hBTnhrppko1gYB7AWDAopByXLyQ/KTcCdr8I5TKjtA955W1m5dO9dOoDaph7ZruLEh4u8tg=
Received: from CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25) by
 SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Tue, 7 Apr 2026 17:08:19 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::fa) by CH2PR05CA0012.outlook.office365.com
 (2603:10b6:610::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 17:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 17:08:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 12:08:19 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 12:08:17 -0500
Message-ID: <50b3313d-aa85-4cb8-801a-e40e3168383a@amd.com>
Date: Tue, 7 Apr 2026 22:38:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Add POWER_SUPPLY dependency for
 dynamic EPP
To: Mario Limonciello <mario.limonciello@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20260407145458.163727-1-mario.limonciello@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260407145458.163727-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c396c8-6810-41a3-2994-08de94c84480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FilukJ9yVr1ob6Kn135lVukOX8aQp2aNLxAxwMzp5NijAch2M6kfX5xpaI0R5sY5TzmXVUKLF1SVeMiqpQkRyGjqxMVkr+Ju2qivrrGiuMQmr4NCPwpxPYQ3+Y1b7UKpZ3Y+QGesMWcXFc9Ohv4kKL75fGz9JrEvlG82ZpgP6bswewoEwtFYtCGM8HUGYUE4DKbTiyQTG4iyQYOkH4gueLHz0nu+YW24HocY4MmfFyK/FySZKCv32Yn6eRqJj8hwSmlgUTEQOmFoWXkd380u9CXXcTmIZGF1qmiUXiKmo02tras7S4znf0cXUIb3+fen+8RbwFr544OwAWBXGwTUzuV6YhieenchhFLYnSJmJjKF6cOaHPNPlPq1Sc1378b3Kb9EHIU8R5Cu8POUORAPap+2YRktoCPjDWb1wVZbTU5S0EEuuHQHl2IG5YGTQi3Gsa00woieXcpT7ojXRxPGmJzccNNyx9aUIxpqvQN1CZI5Alzf+aw7blweERAj+YI8pZrX5qgdoqraXCO74FREPBi8Dr87XrcWrUhacqyldGVeupwmaL87D7PiINa2Nt+7GzCm0ksxjMBjBPHaFZZwctKRMLeSQAZJ9VCN6nlNkPQSuaz9doo+8e1pEraqarfrI4vF0JA448GvqcYzLa6VbO0bZp6a/ShZWS1hSrm3Pqf3moiw0pcJUqANc2W6G1Be7SPlVOhJe0vVpCj1hiZ+RikuKHuYpeIqxzCbs6TPKQFun/QXBt2Tp5GPSzk0UP/2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DM4YazkVtSdBmt2Mko+o9nbYkat3YWWvJxzUSbGm+e9Pal4jJKv/zyTNGpQalu/7bXSNhoQTfgyk3Pt8RBAYcKgNmVpZeUNk1eDziYGVI0xQAyf2IO23a0HmSewu1kY7RME2BlVDpsxEJlH4pp6ozB/5GI+nnduUFIWnoV7brbz/fmUS8tRdaZs/V84AGh1ZlQ5oj70lUYIMdmhrSAZG5/MQMH/PI/oJlnp+RjoFXy9OyqxSFOgrrDuKb4tFPzCvQ6S9DPz1PnhJzSHoaSSmUhsqesUuF4opa8hJJRtwVbZL2a+ct1GDZywDPMxEev/yct6uF1/Qdpv1EfhKWC5Ay35deZWqPJBjk81BL0043O2At0TzY2wIuVVweeGeZb13eZGdFn1IW4jIbb1vVx7Gx8b/tpFnomaQmmi71s7++pbVHR8mauATnvwG/SV8rFcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:08:19.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c396c8-6810-41a3-2994-08de94c84480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

Hello Mario,

On 4/7/2026 8:24 PM, Mario Limonciello wrote:
>  config X86_AMD_PSTATE_DYNAMIC_EPP
>  	bool "AMD Processor P-State dynamic EPP support"
> -	depends on X86_AMD_PSTATE
> +	depends on X86_AMD_PSTATE && POWER_SUPPLY

This config only controls the default selection right? The offending
power_supply_{reg,unreg}_notifier() isn't guarded behind
#ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP so we'll still run into this.

I thing X86_AMD_PSTATE doing a "select POWER_SUPPLY" should cure this.
Thoughts?

>  	default n
>  	help
>  	  Allow the kernel to dynamically change the energy performance

-- 
Thanks and Regards,
Prateek

