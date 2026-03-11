Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45713BC67B;
	Wed, 11 Mar 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225182; cv=fail; b=Tph+u6FpGaLskvYczHNN0f3nrFU8r64Ch9iw0hV+2X8KHx6LdlSfaIJ5PZMdt9FeW3SuRBLhEwJup2a/ec2GFU6rxs9mpCette5exMd3+VR3nkN5dlRjA99upRXk2lF9QTYlrEY2LOvbbGed+W0HF/QALGk6UUVEdZ61hPfl6dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225182; c=relaxed/simple;
	bh=3KbjRGt4OOXvhUGDIh5437uU04UiukaOQX/n0FL4lRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a3gQUhT1GhJaa2sv7cL+pPKhXjDyex08xipuvPEEiT0fDrAoc7ZEys8MsCl5A18zLYlzzurJcNrwT9hzSjd46YUtzK3Z6p+TjczmasMSRjk2X2AudEbNcjjngeUhBaNcAC+UK7Jpd8Nff/YDylTLTjd9IqPGVMKzJcwhYEDztxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eC0ZpYQ0; arc=fail smtp.client-ip=40.107.208.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eC0ZpYQ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llSXZONj8/CjbO+pJauOxIv1BDvCWuXob/qJ8mx+AT0GbvvZfNMOTYI/vu3JcZ2qh9+7cAnH1avph56+dUM/qKP/0B3Jd3Vg6ft1oKGggsHLxDTn+BzAaT8P4iSAoD0QSJ3GN/f/+viU8ldSFykjtD//QorgUo0FctS9K+0V23khjKp6mmfRBYNi4h45thn8j/t+atSZcxuDJPD8rKdzCMBRAAHOnODB9X4ZzrxV+9csbvvHycxXssQHj7Dfj3elzN4/O/Ugvj3sag53/GANPDy5Y6AmtCFa9EeIg8PQGO8QuNV5qvc1PP3hpxwaluPk4S9hIAR1rCcazINTKracFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koGsT0ukSaIJ5D+NK3mKBKmyATBgX8sukI9xcAcOoiY=;
 b=Ehtrlggbfz9ys55OQ4bW9H1eszlVAbpTCWGAIWl22fNu33eVmTocgPTgS6G/WiSSIgaB1Z7iKn9cVl3JWqKOwkPI+xKy7GkojrtRUMOKMehsm5O25fVLsvBXomUiSfvEB2rxM8sqfEDDIPJBSAcxGrWFxh55QmYEdYCu9105Vd8k3DVXcqyG5AjIYoLx7OWNIjeVQMYqhx3EzKFW3TvZOzcOtNtkZYBX+A3FqCFTOI28/Hw7JwcI0Pies9BWGfp6mILer5BaPif7TRW+bwvQGeoRMjbqEAP+XtA2HDbnUO7m44JT6ezHfwlItUSERgKC40eYC0MPaMJpSYJbUdiCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koGsT0ukSaIJ5D+NK3mKBKmyATBgX8sukI9xcAcOoiY=;
 b=eC0ZpYQ0AJcoq6lKjHsNQt7LV5wjsuD1sqzLsCuDu+oHBT9OBOJN24a6Q5d85oJPz3QLcM4x/wWH/UkK1u/3w5JypQWqYQEn1SlgW+RTgUvVyZ0+6v8RSZuM4jxuT9lXTOoG3F+XBw2yBoX4zg9PGqdNEZJj5QnfTW1Uyt/mkv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:32:58 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:32:58 +0000
Date: Wed, 11 Mar 2026 16:02:48 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 9/9] Documentation/amd-pstate: Add documentation for
 amd_pstate_floor_{freq,count}
Message-ID: <abFE0G/7IqJEazX7@BLRRASHENOY1.amd.com>
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
 <20260306095753.17155-10-gautham.shenoy@amd.com>
 <aed4a704-6043-4741-ad0b-d98b3aed7666@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed4a704-6043-4741-ad0b-d98b3aed7666@amd.com>
X-ClientProxiedBy: MA5PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5897e87b-4bb7-445f-201c-08de7f598fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dg7GSG2NTn7gnRDQIvzZk/8m8NbCRrG0AIywI2F3/pRrwmlfDG52L2Hq/QeAEqPKbhzyK/1x1Wky7gaOV78KrzfsUQJNJiJQn9mn+38lJkBlapaw5dUczovheK7ezjweOoHrr0SQ7Tm+QiDse/ub1n9ohDemjqHypDO1cwuEIkkXCU2iwK/5x6LSzJ56S8aJbl1zoaJpm4SHnMBDsCXLK/kZJi0Onin6Vpgh28V1J0JGI7jV/odVq9TPWuUqD8wrLQH4+ImSoDUtUZ1JYImm72uYTE79RpvIdA9FTBvK8RAPKlF6+oteUBfP5fKHeN9EsfZpCvQ/Bh3+pLGf0CZb3RE5hCuoZQIksUtwR6xZzDcyrVgRHljIYlgYn+twFd3JNygeaJJV4DKyVRbrfmtwLIHYiL6FainMBE9w5q7YOBfl05zQPAHy2BTs7v2pPwnkpAaN2NevAYifLpebFU42vN0iHG5kImgwWxZ4o5Unw+i4tbJEWe8TGwxarU586qvDjlIvPKD+xEBnfG9OCkDXjWcPrl5a26tpN5vPoiul07RZKQQeB3EDX9OMIUejfyVRtJyS5HMr3ZeUAaf8H+A+6AtM86JVAP5eFFXzQ2ikfjAF0/feqyrusMF4RykR09zfBGlT47OQ8jqYwpVeoSu07/MnyA93MfV4OuxdYDsykyFvAzODc8f6fSKgMUqLK9A9IaPsYhzFQs6tgUN22rNaIgzKSlMTrQU8Z1P5qMS+Mj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZRo/j5U9YY5M2d7KMTi4e3/QVXjqYLTTqMi6Q8OdeduGU/IajJD7uV+vsCD?=
 =?us-ascii?Q?fP6fFcDbSErzL2kZOgaxkGrrYCkG+TXgqIfpcx/flCHnkt/tIhO92MVaJh5P?=
 =?us-ascii?Q?4zQCdRVDnqdZc/CVOQYpWlRf9i7d9nO9+gL784jKFU4CaqQI3jN2P11j+HCq?=
 =?us-ascii?Q?/ciiy/VxC/aNmYJf1aywHe31Szi1KzzBoAbm5BmsxRKVuslZE327gY81GZMB?=
 =?us-ascii?Q?RKkjnaFH2DsIxfShvMq9f9DEk3bplnnWU3kJft+oxkERMRP/ph7CnpJgIno4?=
 =?us-ascii?Q?O3Rk5Ug8FmG0VKakTWSQJD18jPoCmg+O6wPkAjmP1hBx6o7bSEq9BDZP4nGQ?=
 =?us-ascii?Q?JfpbsFxo6rUEJyFWT/YsM+amud7xZ5Ii/l2hgIhvuhf2BKiJ1x/HGkjguEcz?=
 =?us-ascii?Q?91+lqHuItVUsU2DdJb3lez+KqaCsYwT8m81fRFltiCgt/DwklsTUtP31rGVs?=
 =?us-ascii?Q?HaMiHig1KCX2nJohOtAxNTsV+HhFRddcZsa+anY8KULwmAeLhK28e4CUXwlp?=
 =?us-ascii?Q?IuxSjez9PcqLgxoDE2ecBPgjLGuh6HgDUCEUes/cb1Nvgra7a2n6KpfW9TBc?=
 =?us-ascii?Q?Xz1mhRPvrSelw51UlZ3LiaLM9QgjgESHDTw2B8Zpfsnh1XZZ3s7IaAjuG5WQ?=
 =?us-ascii?Q?iN+LJ3kBp7oJDeH0+yo0GfUII3w/81PlzLDq6I1Mo/CEQC54eHPGxMMj4rEP?=
 =?us-ascii?Q?bNbH7U8Omkf+IpOxPEfWFQh2LLva3pDCuq4tHwVV0bzM35kYqQFT5ZJgr2ot?=
 =?us-ascii?Q?TM8yuPDdOp2xEZ48lb0+xmvy9BqnQW/WCkjAeft6tRQ5YXP8Hrt3IOBFIaUT?=
 =?us-ascii?Q?2BPjsuEqm0UIBmEqWPSzTBKOAT0IIe/fIjtJmQmxwTToSCbknzGzmIRNLDxe?=
 =?us-ascii?Q?82Fp/i9zGIH5gL3A8vb9+IJHnHooBwWixcbvK9q2pj9tJ0RImu9Thp4JUa56?=
 =?us-ascii?Q?xSyG5IJnm1A6yGMHsOEjCoFBeAhDS34oXE+RaKemeaGZgbT2IHd3i/EWqlZi?=
 =?us-ascii?Q?tce1UUBvZxQWKlrMr0vxfGmuxxOXBg2smsKP9RBmt/gGsBGx9I3m8B6oQ+Cw?=
 =?us-ascii?Q?tPI8FFT3F8sPMPINxA1pp0F7gZZuD7OsKdFW0XnaZ7FGbRE/YuFPIkupTmCM?=
 =?us-ascii?Q?4OhWiZ39C90LPXFW156IdEoGAcsAlRID6qblgNEXcnL67nirdqcYWfrwAdrF?=
 =?us-ascii?Q?wqowx3lRNXS5iJmRKNYWEfNhAhicjnoNnssmMqBVP6H9Mipp3Z6qCAmy0YWl?=
 =?us-ascii?Q?nADfUFXw67QfxhaW6uqcjVPJ+slQZTpkXjftONfo9FehFl9l79dZUggmatyU?=
 =?us-ascii?Q?cOr5Re9dDt3tvODYW+gxPHlrzmHT+GXDFglS8dfWWco8xFQGafJXHPkYChqr?=
 =?us-ascii?Q?lr/H9M8zBIltBgcFOIunDXTBKCuNCen5VTMmUrRmXdUdC04qQUj2B98Lo6ha?=
 =?us-ascii?Q?T8s7bXi9jIzzNFqEssKtZmmmqeplkz/1uSFG17vi+A6JWQf6wnZvj2CDOe24?=
 =?us-ascii?Q?aIZ2/UcGf5+Wq0A4ORNezplXCjroAFb53X6km+SQcwB1e/ncW2NVBUpf+bX/?=
 =?us-ascii?Q?K4i8nbOBBS047UFMTBLrTsmY6CZXKM6fRDwEYry2l3nj3rZyW0JjWXIkHYUK?=
 =?us-ascii?Q?ervPkEODcEJxIWjRqGRHHw7JpL9NpXdHNH9p59LchVKGYtUCe1DoGqJdhvja?=
 =?us-ascii?Q?L5ksX2qxY2fryh18u1sxtrqS4W/ja826HJhp0zfC2wkZlXYfhoaCwkTcnc+X?=
 =?us-ascii?Q?dQGgKOe34A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5897e87b-4bb7-445f-201c-08de7f598fdc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:32:57.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUFj93omEFSKiSVp5cqgom4L+5msVFF2wphqpgswAe5Ur6JUriqcB9g/E5itizklZRwSkT649ybOC3m2CvKgQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

Hello Prateek,

On Tue, Mar 10, 2026 at 09:15:03AM +0530, K Prateek Nayak wrote:
> Hello Gautham,
> 
> On 3/6/2026 3:27 PM, Gautham R. Shenoy wrote:
> > +``amd_pstate_floor_freq``
> > +
> > +The floor frequency associated with each CPU. Userspace can write any
> > +value between ``cpuinfo_min_freq`` and ``scaling_max_freq`` into this
> > +file. When the system is under power or thermal constraints, the
> > +platform firmware will attempt to throttle the CPU frequency to the
> > +value specified in ``amd_pstate_floor_freq`` before throttling it
> > +further. This allows userspace to specify different floor frequencies
> > +to different CPUs. For optimal results, threads of the same core
> > +should have the same floor frequency value. This file is only visible
> > +on platforms that support the CPPC Performance Priority feature.
> 
> nit. Should we note that the driver caches the closes perf value and the
> read of the file will output the corresponding frequency of the perf
> level?
> 
> Otherwise, it might come as a surprise to the user that the read of file
> returns a value very close to what was written but not exactly equal to
> it all the times.
> 
> Or should we just cache the raw frequency value when user modifies it
> and keep the perf translation bits opaque to the user?

I think it is better to cache the user requested value of
amd_pstate_floor_freq in cpudata and report the same when the user
reads the sysfs file.

I will change this in v2. Thanks for the feedback.

> 
> -- 
> Thanks and Regards,
> Prateek
> 

-- 
Thanks and Regards
gautham.
