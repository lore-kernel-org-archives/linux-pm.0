Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391483;
	b=J6iUNeJP5HG1uARWiTchilpi5EX0aA7lczP6cBVR33Sru7msS28rbwb9kwziHyawMWh1
	 KziNYo8pYhCA5BqZ46ft9FstfKUa97+HkewGn9xMwkpQ4P40OEkVD6uGWeE4UD5B1RiPL
	 KXo5RWG35DWJXEWjZ1Fb9QSBRagXQgLWYTxhRGx4UMtH+ULSxhGw5Jy54CGy2ZycYkcid
	 TaYinF/El0/xc1QTmsW6w6dZ3JfcUA0+UiPIdSlAFNYUa4xS2Q6E5NHKqA3SoTxfxR23Y
	 CSLUPkh4YQWwLIH5KUmKXhggXMBEKZw7zyD4qE62Vd4rTQpVV3WFNRXH2iMm3jLK00w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391483;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oVhgG1D34iAaFPpyW2HKAfJcIy1AudwUf4aBHqGSZjY=;
	b=rZHSWYGsO1kbL0HUpmKTaVPSeayOJgjCyX5bdmeGL9v9sHz4aCrytr1nb6w+LcFEe9Ht
	 yPbAL5aMzCg0GgXYUHc5Ps1l61psaxIYJ86ddnolvW2/gXS0EnBvBgrJn/lbOsI9Q9i3B
	 8pRi3sFndJZV3pIXfdaLL8Dj9KMWU3sE1Cg1XtfgfUB8bOVjmrsqvETjQVKqqvsXrKQx6
	 dOmNrmgTOi1Fa7qsCSUsLUUKkTowRYcGdm6p8oNq6xmiaHWJ+T4/QaPaICrq0bSdTKZwr
	 GqoKq6Pqiq3DFp3g8fs3q7fcXniQ+sWzJA7wzcLlcrokNOrM2gvmRCCASTgV751/CpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UKu6c68L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.16
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B5606A324;
	Wed, 11 Nov 2026 10:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 063B5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UKu6c68L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX08IaMGtklfnl9qZdTq+oo2PWWg7ib3ZS/R5cP4ph2oicplgiXZ3+bgqIfLElpdBawhJO8kDqDc/iYn7CEZe1cvcsS0sxwkBNcl4NJ3bwfKXFAEk7gc003KM/Q70kaX9ohLL5mDsGn3yEhSSlWkHvJYJESElu/Jn2GI3TxlgU2IAiF0BKxRR/0v+AyYZK1taTZYY2sP5NvdxCWIdjp3AVS/7mY29L2LwcfRAHFmsr1yP4WC6Ng8VXRJ5BY9BCKa5um9KBMqnEPEnbrp5dSPaZt7SEOiY055EuUiowMOwA5abbVpFXGJ8DWL2/i35ZQ0ZhAHpk8WMdJJ53sfZsF9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVhgG1D34iAaFPpyW2HKAfJcIy1AudwUf4aBHqGSZjY=;
 b=olId59uIUT9jEN99u8eTbYomB/gZUqVr+wnkK99yA5Tt9hIS56sT0inmcSa1LkA+j7nEvXuaWxuqDDhKR0Qark4FGqUpUj+WfgTKvqrY/sqW7c5CBwcDa6CKptdlZOoOQ2uFpNKX1Jo+DC29lEpiq20YUKhZobnPAZdi9ZO8ftLl4zihol38rK+UYYhYvMbLod/pCGRV0jddOlOD7hkmYNZbuoDdE8Ye30FtvzpMCTjIsKZLErzZkN3Ryhmuxkye1Y7PYFZc/BM84i8Zbfw1fcK5AU1sFpXZhmfPHeDWvV+xihFepwe0wIPW+jbyFk6ATgXpwIZmmMxM8LweO+sUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVhgG1D34iAaFPpyW2HKAfJcIy1AudwUf4aBHqGSZjY=;
 b=UKu6c68LO1yzr+OaNC1Xz7WdPcOONVbXuq/XvAQBLjWBC+FfXlKqDjrlWdR/rakyRs4O2Dk9+vd+ngg6s9TnAZmUWQQH0RD1gzxWsPNIHqwF9fuAAvRMvTCkNq24Ks+DPMNyx1hh8UinnJFOCza/YyGSc3wH6PUYOs4IHZaQyes=
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by IA3PR12MB692094.namprd12.prod.outlook.com (2603:10b6:208:712::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:04:39 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::9b) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 10:04:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 10:04:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 04:04:38 -0600
Received: from [10.85.41.63] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 04:04:32 -0600
Message-ID: <f0bdf36b-4453-4d2f-b82c-85d1d62c5f78@amd.com>
Date: Wed, 11 Nov 2026 15:34:30 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Vincent Guittot <vincent.guittot@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, <lukasz.luba@arm.com>,
	<rafael@kernel.org>, <linux-pm@vger.kernel.org>, <tj@kernel.org>,
	<void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>,
	<sched-ext@lists.linux.dev>
CC: <qyousef@layalina.io>, <christian.loehle@arm.com>,
	<pierre.gondois@arm.com>, <sshegde@linux.ibm.com>, <kayracizmeci@gmail.com>,
	<tim.c.chen@linux.intel.com>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261106151947.3991524-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|IA3PR12MB692094:EE_
X-MS-Office365-Filtering-Correlation-Id: f6274983-a2a1-4606-96bd-08df3fdb32c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261028144727099003|261026140227099003|261022105027099003|261022075727099003|921020|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vXvqy3euHbzuDjjvP4JTZ53YB05+P7CjkVqQIAOPDx5C+yS8asfBQFZ4DOL0DUAPfv1AOw41QCSGyHPGy0QJlJ5ytjY0c36B4NhlnB8ji7eXPDbXfV8FFIESpAiBqyPvmQJ4QuxknDtLdxrEdvpivT7AvtknKbST8yRsTdGA7IEKNixc0DPEiZGtbwdW6AKO3QceherRgVF+BRogE3PtM9w811ymykzUXHRgZeJCzRBoJ+ga2/x+4qOOG56+1iXt8Jy+72PYyxdQ7pc66sTi6OEyWKbyh7oaJ8wAVsFA8Wlvfg1z1per9kqLn3uVsLZx6EoBbM63ThFRvDsTmeEEmeWzDuQzrkurQiyPMDUFAkf0MlCY41S2g+r6M5hhYxvz+n82co0yUtVD1L9x2iRepx1DPl2M5nbsQgBKm67LDwjS/nq+Cs5rOa3QUVTZmG26z7hIubRirlEd8Gu5bOiqbQzp9m3Mk5QgiEZchG0UAqBMzZa4yS5Hqjj7C86rfc+dKQEJAhsm8PXgvqwivLIEqQghU8gzTQe0OYQK6FIs4GTrgsdrQgmixTBkh5Q2He2QlZypu4UlSvwj1Ah6iGUi7mEzS67F27ibm5e54zCIyjFLRKw1C9NcgM6xoFfI2DGqVgYqmvo35wYQAUmYKVFnUoJ7vKkhOMkGyMNgfuUAcSCM3NrVnfnn7a5Yi4egv8x8jRQdwwz5t3tUjXzxYMqZ7p5xrjFjm94pN3dYqZKG0eDLcTWxAsYmcIR7HhKmm3G0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(921020)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FV8SwxJT8IFAYGCu6fIVnByz1XYwKmhWVgOF/Xbev6IJxRvNJcNuWqgx2qC7PxZutq9gaCMHnks+AHA2zly1wbJc8+z3TAPSolGmDyKyWCtxf5i5Oa80dNeLqC2mRGGyVkQm6wIL4QHJfuRtANfQ14tPonHuMI7RJ/LfKoug3/SIooYnRu4RikBDkafnaLupiUttUlX72zyqh8sssHew3R+QtxyDK5oEFBHSScGa9ziaoaHn28CsbTR6Gpy0PK2628kXKcGJjy3xjaSj8uhTX2TAwwtWhTpCNdE9H7T7pT/TXuLlphMMs98k1V0WLG42j6yGt8EOe61fC0WSl2XusNHh2i3u+0X2I3yDcPARMbsyPlwDLWRWICDc5cVr8TPaWxS0ijyxNlm8wAqkPGkIBh8A+fxH8ubrLsLs8m+J+6dLcbPr+RiSEhVEHfCBToEg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:04:39.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6274983-a2a1-4606-96bd-08df3fdb32c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB692094

Hello Vincent,

On 11/6/2026 8:49 PM, Vincent Guittot wrote:
> @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> +	if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)

Should this also consider DEQUEUE_CLASS which will move the task out
of fair class and leave the rq idle? setscheduler just adds it with
DEQUEUE_SAVE when moving classes.

> +		cfs_rq->idle_seq++;
> +
>  	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>  		se->deadline -= se->vruntime;
>  		se->rel_deadline = 1;

-- 
Thanks and Regards,
Prateek

