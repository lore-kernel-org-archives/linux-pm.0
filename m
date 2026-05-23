Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D443AB0
	for <linux-pm@vger.kernel.org>; Sat, 23 May 2026 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779511150; cv=fail; b=sdipBvQFn7UMUh6d6bUrZ87uW7o7FnX2qOq2MQ0OwqCoXxbZ4Kk+cldmJQdsvzjGzZaoBopYNej+VKIosuDoAqgA6fUfiHbJSJxtvgVkRCcll9YW4K+i89x48lLG+m8p4+ggprKSzgQ2y2n6YF08S5eoAGVdZKgNS7KeAcdGgVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779511150; c=relaxed/simple;
	bh=vBcbO0REmXQb0wz9Q+0AglQxPVlVA5GQCQsHWiAgeXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ONeNT/Z7nP82DaUPuA/U41w0auGia3eBZkaXA8QWjdZdxM8MM2AlaWn6tss7U5tkBeeqqRJgmqK5KslAeoKdn3WuZ9h+t0XuBKfKkSZ84Ko13bzxHyonks5FdJ6X9rjruw2tdc5ViTlG0FQZyseDj8HK2wOrq21K5viT1lxU/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZZXwSxv+; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZZXwSxv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLJMPLchYF+4t+qu7ZvJXpB2AKb7Sa+rkRTjlYrMhebLS91ZrYBTICW3tMPDfE+cOWd0IqWKnZv4U+fzhRp79NLQMmGM3sMpny0Mk+KTs3sswuyi8in1DF9m5T97IAhf2U23iMzJFlCbU7EY0dvHM6kW48JtKzqL/nPLOPVw9CFcM+VRmDn2rHBR+skJDuC7Jo/yNKFsm329RwChLUsbCBi586y3RDn9/D3FFj9mYZhQUN5Ep3PwJqkaG+92QMHc2XdjPcNbCCHvfdXWZVWUVakOCoY2mcFmKDmKiA4y46ArZZSbsZHbvrv2VjHL+DU/x668TOaNONzfmniDJSi9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP3ui+Jv1ihdh4EzCb+IUWK4hJw78c2TgWBL1cYonCg=;
 b=Ox0Z+Xoxb0DtxpDZo9PykN6imoK3Q7cSDrsiLsKrBm8E/LJz1acsGn14wRNkMi4rOEuRGoJV+UMYOLQ9j6PIA2zou5tNr1gby6hxZ4uL0MyKLdhzdAM3Ta+f0F+/BoGks8kYhTEh3DzSlCyhqpxgeY6ynYmm6kdBDyYAgWsu2x4yMirCoZFcYKGcvyj6JZnWtzg4kyfzU0arfUS89USQfF6b8fByzDwgSLFLJ0DAgwFVBiEr1EKFJiDzouUwMJTd/jDzf1JZ9Bzo3lQqV4+6ABm02T0DRMFJaDJkfXL6+T/hc7Cdcq/QAsDo3nIahulvlvsP5PyqloqLHbP2TGww7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP3ui+Jv1ihdh4EzCb+IUWK4hJw78c2TgWBL1cYonCg=;
 b=ZZXwSxv++0/kUnP3xKSWTvwJNKg9gW51JMegL7fgcur8zZSumcCMZXL696h/36QdY1wa6u5HJuHbTr8+j5FQm3T3LjKLrvSw8FEqECD0yFBGso4NeYhiRB5hBzi45AZzx7mg87HRa3ZTTowhsp3ktRb+JtIj/+VPAI4j3bHjfK8=
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 04:39:02 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::2d) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.18 via Frontend Transport; Sat, 23
 May 2026 04:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sat, 23 May 2026 04:39:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 22 May
 2026 23:39:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 22 May
 2026 21:39:01 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 22 May 2026 23:39:00 -0500
Message-ID: <13d8e8da-65f6-464f-801a-8382739246a6@amd.com>
Date: Sat, 23 May 2026 10:08:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] cpufreq/amd-pstate-ut: Drop policy reference before
 driver switch
To: Dan Carpenter <error27@gmail.com>
CC: <linux-pm@vger.kernel.org>
References: <ahEq0CvdBX0T7_cO@stanley.mountain>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ahEq0CvdBX0T7_cO@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 677897d1-3a82-4a41-aece-08deb88536d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6XsOD6suHTmbRbIbGaJ4T5ouJippeTDtKniywN+cQK3G0bHZiCJQ+INuLJEAqNBOokr0Sx/6bQR0kg1UIdySAHzxeCtXUEXR06Fg+uHER5u6Qqb4aBF5fQHah3xqnyvLfh97ZYj6B0ijrsfTMuXtJCbfXxTBRXaaPpTPemMVM4Z7AfMUUreF70bTpD+Gzkhs11E6D9GZY/D23p2N9ydASQ2wf0ctdCT7pftF70iF0QZ9HnL88302YxbgWzGeDKtdaSseY23ArgWEYwQT2Wzvan0dpZP/MnhWwkdTzRpDVLRoA/RA49thawkT5eQpsjTM9Cla2Ka/4ImAhd9QuVNCBjgdnMqJPrZ4WmXr+dOPZNwC1NOzt4SPS2utPldaxLV4ytP3ZRX/zUTokLcnZIq7tmuZ5uim2sYkIqwJFpoxGCD3g+/C5seIIyeNBwzsIsPpMyLNJuI1iJOdByaElSXFRBj0kQdrOTiKBd7NOkX/iB2NjTxfZOcj9g5qtgChdGA4jbJ1MEbWYd0Mg5OE9Svq7goNa2H4IX2m+6lMNw4cVca6uhU8NbwgDJyN0sPhtfs8lp/9+9qKRpVQNKQIVbDf3lSniBCZiB5FOBGmco4+oFfFTNKOiUQ0e1j4aUMOknZCGUPwtj9zsKAjJWmm0IrrPWON8PAFTptptb/i7S+DhEAmfMzQ4bdFz6cvj0jGekHeENAz02IxXMgPR3VCopmSNTafs6SE9qEqekfD6OHw2GM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ECBZI4p4nnxwRmCcXnWi+5lwUCtTfisPH5x+bm4I9KGVwC71x2PFPuPRXOAYdnJAp/fn+fDv99UwBvICU4wgGGTONnWif47T+GJ3n13zggW3u4KvJ1GnM2g+1MNdy2fA6XnAEe+Nc5Q2c68dgDykdtY5qb8WvqA5MHZkUAx602EPqeTJ2JKaDmoOmwqwDf6Udc0SgW4/LLuoIHe1dNA54+Q9H9dR29RyO/43fL4aMm87hSmKWdvfFvxghmsmXbim08ZzvD52UcFKapceyu/daDviU9gSNrorpIU1gqLLZTPoC/hmydTOyTOQ8BI3Pp+uc5cyItTbq45VcCYFs1EuYVx+HFoHGDg5zVa5F74In8CbTNuZZR7UnEV0tbfcXNMzaC5P5OoxqNulTzj/H3Q0ofO2lMS1yKNBgDksxQ9Rgh+IkT/Cq2s3drbdR3oRIrYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 04:39:02.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677897d1-3a82-4a41-aece-08deb88536d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

Hello Dan,

On 5/23/2026 9:49 AM, Dan Carpenter wrote:
>     301         /* Drop reference before potential driver change. */
>     302         cpufreq_cpu_put(policy);
>     303         policy = NULL;
>                 ^^^^^^^^^^^^^^
> policy set to NULL.
> 
>     304
>     305         /* disable dynamic EPP before running test */
>     306         if (cpudata->dynamic_epp) {
>     307                 pr_debug("Dynamic EPP is enabled, disabling it\n");
> --> 308                 amd_pstate_clear_dynamic_epp(policy);
>                                                      ^^^^^^
> So this will crash.

Blinks! I messed up that rebase pretty bad. Thank you for bringing it to
my notice. I'll send a fix soon.

> This email is a free service from the Smatch-CI project [smatch.sf.net].

That is a useful service! Thanks a ton again. Running this against
linux-next is much appreciated _/\_

-- 
Thanks and Regards,
Prateek

