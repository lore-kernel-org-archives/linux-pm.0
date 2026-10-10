Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD883A7198;
	Sat, 10 Oct 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791647760; cv=fail; b=T0GVR+h87TLS1r2CEK66wcqNW8a8MJEGbKBfEVKiouhl0SYd8S1tOftA38rMHPPWXFMgoNEQpQ5iH14tJDRAyXKo4blUR2G5x9k6pebkACVH70wTQTklr/uVDRuKPsPtZ9Ji466Bd+7V28JsP3FMH1iMp405gSjfguXDoLHHolg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791647760; c=relaxed/simple;
	bh=40uSemZnUwyj4kjTAaybJH3UD5SXN0tSg76lLcmspEE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZnjjVw0NoxhlAQd9zKz81GfNjy5vWQDiKl+F+xNtNJdjNyDI7gbZp5SOUJhErWLnhG8Fm30h3NE0syPVvyFmQkJRgrQY3rw7OobLqtLO4T7Wtf8l/tEFLh2ZJQjNYd2+tsdRJrKQu/se116wbB1nYvSQWQRwq7WwFoIHRF/wQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klqPL04d; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klqPL04d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791647756; x=1823183756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=40uSemZnUwyj4kjTAaybJH3UD5SXN0tSg76lLcmspEE=;
  b=klqPL04dkGlyv4upj4dBUhREpRQpEt56Xhtw46mM1XuhQEsi93lUF6rN
   FJx7xfFsTShhpIKPA+o/e8M4nVDo8tck+DEvC3POjmTI6j0VgN1lympms
   Re8iAb2rBxfJd7WuLkNqILy90EdCwS5YxoZOfhgtVcMCxQ80B8DHTRGVm
   KrKPEyh6cQTwg5KGxzmmNtUda/NWa2BYlE7kphe2/nS0kXSWyykWc90JI
   cpSdTdYW607MjYB1NdkJalSASYDRf1h6dS2aU+1e0qkNKVD/OaORrXAEE
   1ospvIQkIh+raadF3TZKDVacyBgjG92gc0748Wc09H0HzT+7tts1eOlGq
   A==;
X-CSE-ConnectionGUID: 01wZ8MwlQc+ep7P5TkStww==
X-CSE-MsgGUID: VmXczM8aTj6ijIGHhekA7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="424306"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="424306"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 08:55:56 -0700
X-CSE-ConnectionGUID: Wc9Xr5GCRXaQAdQqoZk3+g==
X-CSE-MsgGUID: dc35/QnrTnqBfzktIY5TqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="2373563"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 08:55:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 08:55:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 08:55:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 08:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzFkg1cMzEPl4ylBD3IW4cZVYG0NDbRs9Yvw1P02LgvYRVEmdqRs/6iV98cCtaz+vcpm1GML0qoHPOWmsY+XbJGXUm8QZS+b/NOl1xu0y4RnC8J8FtqDMobrAPcks9ZPYdIP7zGJMDGYC7AxvQ6r4j0KZ6V9CwsykbQUCtzwqKzzZylBSOJumAZE3kynEDfJT3QO0Rm1OsBNaDP0nj3cRW/2wc/LCzIHTkqZy8igFzMjK6ZVaYFgzwyv9HHUZkrjm+QJ8yhaoezbb0y7VA6/jjvQoAMSNj4Ga8fieHD/zbmm5+KNMIWQaHGuhFL0mLNxJeGztnSs6vvXDamuQzlGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06QW2kHacaBzgGcKeEr/TEFx+S8E8iQGffutsqLHHoo=;
 b=Wd6xelZhblxHHxr0Do4HKBFlyxhCA5ut0gK0mZYbUlVnZcXehVo6ybVjXtNjyBMpREcpLDIKiYj1lRSXSbGQAQxXp7GQsx0AZsWG8U9EFlmfc2swlA5F5GS6VftyR41FkfJwcFIcZRUPmPpO8NiKQtmsbMaIN8DCpF+jAkv1o2YuJfYIaUrUuu/XAcp3VahPziRnaWKUeLElCskbBHI9S0HLRljkXu/IXZvAq10YKK4QmSgKl1Aj12qeXnHKspjwMjeLaGTMsXy+hNxJIzE/10QSAdlQfEjPAbExHbO1/Ma+XE7/oIJbN1Fn8KqLFjN5qWEp34idobwrmhWCVwvSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB566309.namprd11.prod.outlook.com (2603:10b6:610:34c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sat, 10 Oct
 2026 15:55:47 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.019; Sat, 10 Oct 2026
 15:55:47 +0000
Date: Sat, 10 Oct 2026 23:42:41 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <lukasz.luba@arm.com>, <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <sched-ext@lists.linux.dev>,
	<qyousef@layalina.io>, <christian.loehle@arm.com>, <pierre.gondois@arm.com>,
	<sshegde@linux.ibm.com>, <chen.yu@linux.dev>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Message-ID: <aspc8doovTKdBqPC@chenyu-dev>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org>
 <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB566309:EE_
X-MS-Office365-Filtering-Correlation-Id: 2767d4e7-acb0-4f7c-4589-08df26e6f2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 97lgIpLT/dm7iapdrrrX2IvRppnNdhfnRRKWLYDVoJclo8jNbgPixs51bqzBJrvUaxQiu2OO1CvmuRuCywVluaxm1u3scbvDE3eoFGNXaVtwxRaxu4OKcmQbPv4uI6qJ9i/+36gjBdcHYVzQpRBwTUFziQ9CWv4xiBF+MsgehcY5lwsgogEJhcJUmff/xI8/J//juHj9COlAqZmIls6+4ZGe/nvGlV9nN0fXj/Eg0oV4Ow0j6gpCmzTaTkdHDh8dq9GedD7SnFhXJiLNMcMgYbmEC36yb7M5LZ0m0d3FMvcOcVtqgCdfE60LsQpU2BzKXO73pp/Do2zHXPrMYBnAKGMPe9z+Dbf/1xYDjGbc9KC4X/rdXITIEcwRXqlUocKd41rs5hxnnqf1F2b663GLXQTAQyIHO9y9nT37qJRSVahCtplUGeJkdITn24tW5nwv+0arlYI5JKpTTrDqCshcw40zNsaY/OFIEKG3QJHClOg4LF/DCXIc6B+K7XaIHJdkb75Q6lTvM2c0vakLv8xyiG0YWUN962DXtF3wcT4chVDPGaseHwEFWMXlDMLvDZMoMbNQrMxjfoMj51C1VIgnbRMRHi4GrSVOHDO+ldAvvMdKIaXFnroZ8LRk49z5RNUFnlsM9G9ZEhMaJ31c9IbpD02LDBJ48yRq4RC2sEK5ago=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XtuvIZJnRBt0R06TXcD5RqYqMpYgBwAiTBj0a3r4uiFDoBa6k2IgNm0UlTJ?=
 =?us-ascii?Q?RJUUrUWN8TtXVrn3R92d2DDB/2aDEpY4zCSX6cI8c6ObLxg39Dxks1HNh/xa?=
 =?us-ascii?Q?/aDMLjC4h3sEAhjAGmNo1DNmBkiEy9GyU69rtuOtWmJIn0/uCc+j6xSEarsd?=
 =?us-ascii?Q?OT6u8aDIh+hBqudPzx3VShJxE5adOiU6e89ZXCaKf9VAy9/VBY4icwakuutX?=
 =?us-ascii?Q?0yCMRFqL/YjtGP1z4DS664u7U7N1PIDwxRKMET1yX9aBDO9YxhpzRQpTghT7?=
 =?us-ascii?Q?l0c+jaWSqPKUrJKZHYdCPZxDgVy0Sw27s0hC5jRGOIHAd5oKknnWq3hzYo3C?=
 =?us-ascii?Q?QUu3KF7oRrOMzryR0Xj+tZPpokxWy+aRvB0yNKavq8YnvOhz7PcfQOW8SE7/?=
 =?us-ascii?Q?CGkRNPIQBSttdG4div7ZHC6ZtgcMb22w5Mmg9BuIkS4S4Yzi/SJ6+9tInYc6?=
 =?us-ascii?Q?E4vg28NfskipMApR9Ar1pjtt06MCbBiGnq8AvBUAMfWMZtU+7jvqsKVp531b?=
 =?us-ascii?Q?mhGgtL6FUnTAowSE9Ryh5/uKMlMs1CZ9eyLTXNnNMahD17fyxq5Hx65AtWJ3?=
 =?us-ascii?Q?LmQvxrY97VaGrJ8ykyyR+lYB6GccOXRpWb4o1uVVmNgi9XZIbPdxpizMvdbL?=
 =?us-ascii?Q?YdDtzkLvjgtmSw/xcMOrfYyj69q98YbGoJ+DbY/tb5J8FrM3FRCZlLgMTzhd?=
 =?us-ascii?Q?Cpi2Fh+bHftHE62jmG+RrxbrNiQKW98NETWGxhOZmoUIG5tOAcVsGgxWD5jP?=
 =?us-ascii?Q?MzwUTEuq8Ivc5aUTezittcbI5CHQeA9f3A8u0Qc/gdSUtOc7j48X5Nbx/KEW?=
 =?us-ascii?Q?YDZkRWWgf62OV578wlTKqngl+NvXJc/6s7sd+wC7g8cjviZYaNDMh0mqR5Bl?=
 =?us-ascii?Q?iaKFgTiVYZdSIwakliPvtYTSKeQFC/1O3HYTffspWBSawtUC460Dt0pCoZni?=
 =?us-ascii?Q?ngRjRE7bsvD1RPWz7pISgOm7zaOxcQw3tzXEIKPvh6D9K1PqqvgNsEfiwpvy?=
 =?us-ascii?Q?2a693fLH1bwvT/LJzmfkJdK27Lmu/DLb8ZrxXP+9/HK8SadH4k6ElgV1rCDH?=
 =?us-ascii?Q?aWOk8gb+yAsEjHSleRH2mCu23WiVUNOqawDT52B344Qc806n8ysTNeWw2ZQv?=
 =?us-ascii?Q?Ol2S5JB57DsGmXNZ4Z7Xp1+TlV5jTaeq7JxgRKv7D5ikqAMi50C/qS9XZJ/x?=
 =?us-ascii?Q?7QRonC4se9cHS10SjScuKQl+x4uIGrj9MZIGsrVmgQgxlr2lrg9rC1oi08Kt?=
 =?us-ascii?Q?++IgdP5CeL1ld6jbQUt8kNd29kLNHai8O5+EtvGwe/tsXTMx4KpyOtD2P6To?=
 =?us-ascii?Q?HG62sfIto9VNogDxK1fCAnHowF687LiO85L5EFZreNWDcjC0wO9xkfXcm5IQ?=
 =?us-ascii?Q?YY+4HZKBAkTWJDkCmU4zTtjbNYzUB3XAXKfp1u3Q5FO+EALzOviw8/TkUJBP?=
 =?us-ascii?Q?unB+I5oUjHhGRMqG35wCzUXCgSdJ3O4Z+30KVfcvqwPWLDlL/e8Z/TUWeKPP?=
 =?us-ascii?Q?1yV3XePZhflaMpVRZysvWdKnSHea8Q9vOPnhQYCYe8R4Ctm0/HpXobtrQC57?=
 =?us-ascii?Q?tm1KJWp5eNDyH+akSE8OwFBqNgJJjJbLuFsfUEni/fRIVHS05xsJkF7f+XE3?=
 =?us-ascii?Q?Xlz394FWDga8CvYD/IofVweWnAcO6dM9otpU3U8eAm5YNpHX8fVkye1NNbcH?=
 =?us-ascii?Q?KI8WL203XmjvU9QxtBfwmWNTFlnNe14z/62u7aFsFPT0mlonl7eDAt0u/PoA?=
 =?us-ascii?Q?rGuUL7194g=3D=3D?=
X-Exchange-RoutingPolicyChecked: PbSoIOMZM3vR0o+/R6E2BYYOPyTY5zGfagHU+RgwiDgnFMdtrPFFXvG6XP9orMi20DNUgT7I46Zu+loGQGYBIrMPX68Sdps10cyB2ASCJhhInI4tG2/cripa3gWZYeiNBJyRm8ERak98p5y4gm4N/pxPObMpmbml1gdiiMGQH1SXwnLI1pyDqHvg5sIjUqhCjaJD1Hw/5Vxvf5smNc3vABQMqJSF/nRMF09W+R9s6oXCYdCdUEMZHR+167gJcK42GPVCGIFLYyxoW0R6VicQ+51KTxD0/SblGUlmrer3v81YtxZweJ3wVfQqnGCkQxadj41NcNIQS37Irgs5a6k4VQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2767d4e7-acb0-4f7c-4589-08df26e6f2eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 15:55:47.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjhcYFkyLy+DbKMo49D/WDBG48O4o81kq50iMs8bIDWr9NoLKhwqPJA4too/LSt1sBaBD3atb8qB7XLZee4Lsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB566309
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:

[ ... ]

> > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> >         if (select_flags & WF_TTWU)
> >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> >
> > +       /*
> > +        * Only a push triggered by cache aware scheduling will push the
> > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > +        * slice task, uses the default push strategy.
> > +        */
> > +       push_cpu = -1;
> > +       if (select_flags & WF_RQ_PUSH)
> > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> 
> Is there any reason that you do'nt want to migrate the task at wakeup too ?
>

The wakeup path seems to be too fast to aggregate the tasks, so that multiple
CPUs try to migrate the task to the same LLC without synchronization - a task
bouncing issue was observed when cache-aware migration was enabled in the wakeup
path. We can double-check in the latest kernel to see if that is still the case,
and to see if we can mitigate that.

thanks,
Chenyu
