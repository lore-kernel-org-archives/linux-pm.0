Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D063932CA;
	Thu, 26 Mar 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524631; cv=fail; b=e0IxqzU2PHFvyKMpxPUP+FGtIZft6M45/j78n1f20TQSlSkpBGtKTxbycAt4rtDaVSYxwNiAtBwq/2pjarqd74Mz6+cBNqhpgsNakuAFaTwLQ7cKWxbXHDZHgXqZJo1Id1oJVRbhuCzFU1d/6D536EuSwZgIciA4RdrqzdcU8II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524631; c=relaxed/simple;
	bh=D8OSgd7NaJwVh1btss3Dazw7dwdB4YLVi+KTUFbvrXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r5vwNCChVn94em+BP8s4/YERQJZEg4NRhSkGNjojDFeWy4idAF4YJYYgqEN3cwJ8FBXBxMEwsb1XotIw8AFBrzcVYbF/HGQxjLM7hUBVWk2XNhXApdIO31SC7zzm4gnPUWEzXS4vTjeIgwG0cpWfMxf7pjrjch0UQP3vzRcK3Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wC6bFpi5; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wC6bFpi5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE5UXCZQQoHNOkT27xcL/r76S2IORKlsiGkH25wfMbgkRIzT6EDciB9p/g076iMdQJ90nVPfE26qR+oFvzttD0N6U7wluJFU6Sr4rdm8rPmKVZClwiIAmThD4NUcVZSkL41wCKOZivbg7L2jVxx/VgyUA7ApK7In62ZeTEUytDhrQyXSW+nNVUx5tiuTep6LfTLCRu6QzS7kZAMclILAQyWR/eTjrgvDNUDMRTqmnVprUarReCoogFtmsJyAqcXkuuh4nInEypY00qKsIK1WJa5QMbHNSXbhX4Rax0MOWdq6BWFTR3mg7AFP83AZM3qqk56jYsebL8NhyB2j3QTiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epvCAQw9bWu0SQuRkxyU+6h3QiCxMc5s4KEWr6zecIo=;
 b=FZrWRjFxahF0DSYwBUqxVsD0qOgNQIqoMYOdZmuiVn74+2zsEwKFiHOZafKxUKvwyE15YoAC8jdYZ+xaCtXKm0Eiir+EsQ/x/jPactFQwk56e7tSQPHot2baMZa7a6ri0Pqui3LcG2yH0b/2vl4/zfXDpzaMYjYNp/2osj2qA2FemUzimYkhP71cGPYXaPCdrozYCNOLsmPAHopWpUPUEJ5U062Pqx3/R+41jSoOOvVEg3cksFEzIUtW/uGxroC/UzkjdV8TcncHfli53UkLFLHK61XfPbaUGHExegaIEqzerFMtCJoiFMzBYlnjBWW/vKbQLceW8/q+sSeoPLsdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epvCAQw9bWu0SQuRkxyU+6h3QiCxMc5s4KEWr6zecIo=;
 b=wC6bFpi5lzsxwL6+PREVGmYgpqmsMTof1wCXMvXVTIbW9C4VuhpQ2GJZRislDFz1S0vW4BVRxdKgVkq4CuIKfzJEO5+3s2N7EEmRskr80pCPqEDekvgKDmVvE/k6TdGyU1+ADRJdEapBIcB4+HLnkZmwK9mxyJgsOcHWUT7BmsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:30:22 +0000
Received: from IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::a9db:8817:757f:e20e]) by IA1PR12MB8240.namprd12.prod.outlook.com
 ([fe80::a9db:8817:757f:e20e%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 11:30:21 +0000
Date: Thu, 26 Mar 2026 17:00:04 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 05/12] amd-pstate: Add support for CPPC_REQ2 and
 FLOOR_PERF
Message-ID: <acUYvJUjXeH9wcdk@BLRRASHENOY1.amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-6-gautham.shenoy@amd.com>
 <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To CY8PR12MB8243.namprd12.prod.outlook.com
 (2603:10b6:930:78::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8240:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b139347-b6bb-4902-ea97-08de8b2b0fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j04NGSd69KYfcGayTH9mfF9NaLHdTisfcsx6nCFA8OuuXiC7NfpK/urHM1/Oc7PeBd4CigHzxQqW8JklW1EYoCYJKLz+S4BhyebnZFh0gbRfZWagoajrdjkDC3jwPYFylN+400VP2iSBgzhOWzifMaR/Z2WOMlmAXt+1tS9e/dGiCg4me55s7D4kCmqLLsNYLRx0/Tt718ZkI9hsefo1LrPPKLOnktHzR6mwlO8lJUWu76LzJjq0oAkc8RlzCPH7RZplloMipFr5ENwLTxX323+kDZHKxqaQ4CAToEjZEa58KqPpIHiqiPQH7MPmuADKdnhbC8lahKb4XY9K6iTzRQLn8YxDSk6g9xxLCI6TyGO8yM7GSFxDhYUB/gYPK157Rx2lExqgcQt/DpP5VzIJVL3oaDoV+hO8vCh2C98CNaCsypnUCI2ngNMAaAOqKn0AFdY0/6fsM87Bbo/2SAXf5sI79C9kQ9ppdjw635lr473v/pRWu/T8DBvPI30Fx4TP0BM5SZlo4H/X2Rmy3u0CoxMpyr6u7u89ChUkSXuGNpqJbQUy+Xpzseg69CR24KegWmFzWuAd5VN+1mb+KSs8Diq8DkHHHob4hc8uk3WW01yVmgbqmxY8Sm6upkqoxu08MgdDzBWfUsOknoaLW6ZMx3PdeZIxG/DOFBJR5oGsCr223Q4OAGMuIZOdf+VVFSG45TwSv2LcxMYH4SabgSRWfd6BTiw9SnY5yZlmtl4n/Jw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8240.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKjvuDhZKJ/rIztvm9Oyw9WnII9s3MM99CzpL9NMgNCFH30m8iHyB0pdO/44?=
 =?us-ascii?Q?vH77pjmEl7/Stp2VtHLxKFYALOFvso07oXuRtzjYjxebYoX32A1zP5MM6nsT?=
 =?us-ascii?Q?1Vo0VOGq25CwzUO5SH976ijdw2JAVirvE8sknUhjtF4eYIwNGp1sqmD1JDnl?=
 =?us-ascii?Q?u/iLoCm63nJ0CjsCNPgKOwHIhoT5JqNGG/bQqxQ8h0esjUQtUN5o9BU9QS9j?=
 =?us-ascii?Q?F+G55dY7a4wXAOI+OgXITzs4RNIDbsk2N4EmS175NhcX1+IEboE5CYZdL/Qq?=
 =?us-ascii?Q?k2PWTGzc3HothqKkDWkYwcePlKWJSjReCcmpRLz+2cVLvPehuqM0AKOtNSbp?=
 =?us-ascii?Q?/ZoFjtIewFt8odjEuh4/6v+imsCRPu77uwHX4LGL0VTrf3nSUZ50fSueoOXq?=
 =?us-ascii?Q?SuZoikHbWh8XRHaWf2Uz2zcyQTnhxAo+N+yMssl9SHeJcBFs5Uy5aYqsgf0E?=
 =?us-ascii?Q?BXzZVEMohpmCuRV57Xo8VhKmUOZ+1UfZDGLdIof6rF7fr6HAkChL8ScWq3n7?=
 =?us-ascii?Q?wPkoLS9mMLpc7q+aDQBKTcMDhyJvm9FT4xaqWtjOcNHs24T/l/3hvxZonEBA?=
 =?us-ascii?Q?F6L9mA4h52T+Lj+ce5UDo0V4T/Rz1pNtPtdb7Mv8HZF9ogFA1ve65GEuxums?=
 =?us-ascii?Q?heNdhllq6xjqIOkIFs3Xl+U+EG1zCOnZk1kuG6z3gOyTbbHjqcBbHQAgRIks?=
 =?us-ascii?Q?nd7bAzVJUK+zNmpGx2AzN5Std6l7FUimB7Q77ZS88ooGz0IvkO/fEr4gitXF?=
 =?us-ascii?Q?X/ZzIl1N96O1Xoy05PkEG+k0sUwZ2dPYGzBZ1zd68qseyDCqKZWNpEGwCHQn?=
 =?us-ascii?Q?fYgl4KnYhYCuP/kSv2vOleiVJtYhOCk80DyAlIsAzu1/ThwBO3lTOEtfqxzd?=
 =?us-ascii?Q?NTECWW6fPRY47ysAoWCIFc+zKZGoMahBKa93wvqfb73vdd3cvFxi5akQ0cuo?=
 =?us-ascii?Q?ES+XRAIh5ImQ4gH7qj64uCYq8Y9qxowZRqG/69tssdYeKzhoMAqYs3T/8RTm?=
 =?us-ascii?Q?3S91C9Xe+p9V73/CXBR5vuLf/lLB4lRxWdQ8IV68m00kRbBryovP5BdIiC3U?=
 =?us-ascii?Q?vm+Q8tTtFtdfGIaO7A3R/1u+cthQt/uRbNwMtuG8CBTOnst3AbLbKunWUXN8?=
 =?us-ascii?Q?BtyZ5xcXTen42Ssbq7o3RyNUvLYwUvE/klQRfi98HK93eobOuBJvsa4OSLjT?=
 =?us-ascii?Q?8Ynld4/8w1eF+A0PC/63R8zafxflfrPZZRouxuvuihv+/mEgr++8ZBiaxwCT?=
 =?us-ascii?Q?6K/L1nTp7DMYN5RZ6cyN42Ad/vl4xNt1w45/2+JWBC3sFwI3d1jcnwbgrQnv?=
 =?us-ascii?Q?/CwIY2h9xbYvi//zeEzrOxg7hVoHCFDfpCZK/7TjiKjNyOzddYENQzqaLQmP?=
 =?us-ascii?Q?XxJhW92lMkjdhfvUvxqOb2M7Ao3k2N2Xd0Yd6G62Yrnxl5BfpUVQoh0di6vD?=
 =?us-ascii?Q?4QeZwrAGKkXvDs72h4fDxzEfyzZ9iMkBhgVZ+T9l+ncGykIJp0vZzVAJGt9Y?=
 =?us-ascii?Q?MjYgcxaTEV1V4hJuAgRlRGBZLg2S7/XC3eBcSr75uiDw9c9DHjXvJgEZc490?=
 =?us-ascii?Q?OmrWU9JOghQYdTp3wIehbmjpgBNWIdcndHQLfXt3wVU41nO+4gZ/Lw35+Wkk?=
 =?us-ascii?Q?4tvjOUXKhKrYSBQD0Mw+L8s059rdqKkZb9OBKazP00nNiONH5hBf6yoAazv9?=
 =?us-ascii?Q?7cA6tuJNuNLx4yVDlYh7Cl5ahOxYYIBKMUgegaQ3nilrySuepKzh8HiFgHEU?=
 =?us-ascii?Q?4ZJGqowQxw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b139347-b6bb-4902-ea97-08de8b2b0fd6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8243.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:30:21.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVyT5o7hyWOp4q9W3dMuN/DMHfzavqm3mByx7uu9Dma4DNT1qxH/i26n2LSCr7OqJNrGHar310zUkmu3ZgQVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

Hello Mario,

On Tue, Mar 24, 2026 at 04:38:07PM -0500, Mario Limonciello wrote:
> 
> 

[..snip..]

> > index cb45fdca27a6..f04561da4518 100644
> > --- a/drivers/cpufreq/amd-pstate.h
> > +++ b/drivers/cpufreq/amd-pstate.h
> > @@ -62,9 +62,12 @@ struct amd_aperf_mperf {
> >    * @cpu: CPU number
> >    * @req: constraint request to apply
> >    * @cppc_req_cached: cached performance request hints
> > + * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
> >    * @perf: cached performance-related data
> >    * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
> >    * 		  priority.
> > + * @floor_perf_cnt: Cached value of the number of distinct floor
> > + *                  performance levels supported
> >    * @min_limit_freq: Cached value of policy->min (in khz)
> >    * @max_limit_freq: Cached value of policy->max (in khz)
> >    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> > @@ -87,10 +90,13 @@ struct amd_cpudata {
> >   	struct	freq_qos_request req[2];
> >   	u64	cppc_req_cached;
> > +	u64	cppc_req2_cached;
> >   	union perf_cached perf;
> >   	u8	prefcore_ranking;
> > +	u8	floor_perf_cnt;
> > +	u8	bios_floor_perf;
> 
> It looks like you forgot to update doc for bios_floor_perf

Thanks for catching this. I will add the doc for bios_floor_perf in v4.


-- 
Thanks and Regards
gautham.
