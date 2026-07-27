Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9923D2A4;
	Mon, 27 Jul 2026 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124123; cv=fail; b=uILwMPkPT+TmfP2/zwWbW09XkjFHw6I7Jb6KnrgLzjdBKeGBA7P9FPE3uiQ+65org4fxuDcjiDpCxzWK9bdgXYWhkecZAbAogymDhXMJcr0fJdwMkPL/ilam5ap3W7SgLfDdp45nXooaKGOjObGIy7eYcJf7wuimbPI8CZCM52M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124123; c=relaxed/simple;
	bh=ItBuMyoVUFbzAK1PHGHtkZS/FYdPFRMiP3ydaFWrofE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tkvZWduauDO/UZgGCXvqx/stZhUV3FilGRDDMR7CI2mKS9NNQSTKfpcu8C9rrbOHC2Dt5WEuLtL9h5ZFXFNjmewmxhzfwQdtSzK+t1k7Y/W+ZKZjmjgwuwa8RWPR/jGcIYkHibafmNzEHxNuQpxnstTp62Slknh5K6in5PGImWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOPYN1is; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOPYN1is"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyINmu0EGx6/1mxIx6AnWm8LLrbnEXHaI7We8rVL3zJrzfX2xLJnummBgwmN2GVKLrCAriUMZPgCRzKDtdNaPv9khnP1RM7mg1X1WO++fXytzTCt4GlnzV8HGYl7pUxLImHUDGnWrW1k77iBoh4un/NhHbc6ZI/ZGu/OW3uzKPQlKLDO8LUGOoEVvjVhDUCRbw9SiXPOnNNJllnnbEsNbHNbYnCfg9fTMpNtMZyNJvLfe3vThWLRo/52bJM70bRvLe19AVlo1fzxE00kC7GZuPryIg7K20DAslf9/SnSqwzfo6OyMYXWY22oYgtBiwBiPXHnHxJ2zCzmi8+lcMpTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh3fC2EHBTGcr3WdaEyQCKiE/mn+sHQgxvrVi84xwOY=;
 b=DJpq7ElKObWNrjaFekCGYpMRhwaWSe869RWBtb0p/GwuVsbDA/T26ZZw17eYYnrzgJ9TifdVQFYOE7U9H/J1A4789dPPpgNKiPFDmQSSN2/5vIMXOaYqg4iEigwwDUdzk1Tn+k8xmTaRG8mlO6OIWgB1KTzD1gFxf66fC98ox/cECKc5Uy0i1mUqqYbtUwRi3NciSxamiluEL5H5mcLjj+Njy51EgnFrexU+BhQMa47+RDQTNYDvAgBzH5bNc8rxss4W1OjC7pxwsSSmqTk+luw9h1JmHB1f9/nQLGz/wQ3g1+R0ZwS5f74kgh8k6vBTfVJPA/lyB1+un9iX2wZXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh3fC2EHBTGcr3WdaEyQCKiE/mn+sHQgxvrVi84xwOY=;
 b=aOPYN1isV8xwMu4o+kmotQOQ7vEN+Sxe7d1WUMNZf1gzwscabI7tPUCIAB+j3MPjPK9GmpISAiuzq+u/SnNeng1dUv1fFHo3Vv4Yf+8hUB0YxPpMTjG5ccsiPqu+GRYqpc4u9NlaHoJdn/lJIG+rUXTQg6/Q2gXcPIEcPHJ+RVs=
Received: from CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 03:48:38 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::98) by CH2PR02CA0021.outlook.office365.com
 (2603:10b6:610:4e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 03:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 03:48:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 26 Jul
 2026 22:48:37 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 26 Jul 2026 22:48:33 -0500
Message-ID: <a2e55273-a8f7-4f18-a756-0b57029060d0@amd.com>
Date: Mon, 27 Jul 2026 09:18:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] cpufreq/amd-pstate: BIOS min perf fixes and
 Dynamic EPP rework
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Kalpana Shetty <kalpana.shetty@amd.com>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <a841ceef-8d94-4134-9c04-a96cc4f4cdd2@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a841ceef-8d94-4134-9c04-a96cc4f4cdd2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f130a6a-6aa8-4a5b-b77e-08deeb91f0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|13003099007|4143699003|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2y8ove+Rhr6DA33zPF2nyNis7DHMTlrBLrE8QDg+Ups8hrDT5fmM+y5YH/9pAC6T1o76xw4UC/VC+ZHHsfr3Zv5SSDx24dsJ2iYr+Cho9iVcYTf+9lB79Bt44MfIDLi8nhUAH4nVK1G//YKrvNvNB6ISKtzjjLaoulOEBnNWCinZ7SAGEbZaVgvuSGYkjzIgKgtPbi0h9lRY/ZSpcqOsrAu07ZjA9SeOKbF4sFN0SEi+LG1/TzSyHr5W2BvwdTFyh7iBcwKzGD5+b2i2UFrpR182czSXup5kgiWVX2KZlKmNyyZx3RiuEVZVPMr+8FjYlwaKcC8Ow3hwyWXkkV9qzQCX0YJw3j33FzipfwyTrkHb3lfzJDj83pugPNzT7lVdhMawRU+bWAA2FiOx55NJySHoq8nrfRmKML1VgXzKZOOL38XLCE7YFsRbVUQbsH39K8zrGmkzg/WyyOMMgw4smUUJtR5Y+w9Qf4cO4OEoL5C35tFF6z/xarSMiDkHuLnt/r/8aedhIAkQfR6HJeO1MSitfo76Dkyck4mh2/2coHq+enLAIc0zmJzCEqPE9a5nK+fykKISEjIIu/gSj/yCrB2MJ0eAdIivAHeoLdtB37i4ZxIga3TBd7a9ETzvLZM7SpcF1o6TgGHLwF+yHtX3Pg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(13003099007)(4143699003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aBhjQiM+/QM02oFYU8xbmYd1BpqfJWPbjL1KSxmK7vJh2yBEmQEV9jGLwO2c6fxFlfJx0dCMYTXkuLd+ingkGSYpu4PqDR9w5Ef/g4Q5BtYbIeuGARU/X8BT3PJmKcf5kIgHPgfxc3j9BrlRD9eiluOIDtcWdjS4Z79q/RfaW1ZfMs+1osjs06PPT5Xd5bpc+W4DCA+Bg7esgja1lYhBGXuV4ZtNXQyfAnmCkl7aRA60691M0E/I8QhtWDLbTLwYBbm2YSg5AEMdH1POivaSfEtWa/3VcFU/SrLJNED9GKGkA36sbkU9DUkKLVZBCJXF+9y0O5qNXBJe9+u6NmqTUzuQ8hyG2qtgPxL/gMTnV95qP0DFkjAjd8nH1qJKClGsYpfTvFHAjpS/DYx6YaD1UIdTOT0cLAjsLnMM7F3R+X+m5v4RQPQ37RPakfB4rqsh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 03:48:37.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f130a6a-6aa8-4a5b-b77e-08deeb91f0ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

Hello Mario,

Thank you for reviewing the series.

On 7/25/2026 12:37 AM, Mario Limonciello wrote:
> Can you take a look at the Sashiko feedback?  Especially on patch 1, I think another safe guard makes sense.
> 
> https://sashiko.dev/#/patchset/20260723201228.22584-1-kprateek.nayak%40amd.com

I'll address them along with the comments you had and send a new version
your way soon(ish).

-- 
Thanks and Regards,
Prateek

