Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C9377EBF;
	Wed, 23 Sep 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181177; cv=fail; b=XpAQ8MA/wXGv1Oac1IY0EzpwuN/iiuRLaboqfC/Sjzlm2Q7ntrb5yLLw/e+9NAoC+jGKG2IiBc3FWJ68IEF1CdZ6stW/y4gi7D1KyzrWFaCRjvb95EM0wsp+b69dRJZrFaoqO/pkPYD+8Q5Opg6GI1G7wFDFLq0HVtP6/CX+5nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181177; c=relaxed/simple;
	bh=8ud/vKMyPPbr33Y1gl5O2Tp2kqiY0gE+c8yfnRCY/ZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADKC9LA8DHJoSBuu28F536dsAvY9/jDyaZfrmnvpUG2G9rRuYJPZb7iD0aJtrTK6ziWcIlUwG5aOLTs72Pb87Mp20gnzO7v9cK3uZfZbbq5PCNgh6H+JeH2u/elLMhxrvnZIpsJsAmBN0YZAOFuWCl4H3PW3sB/aHPGU5vaCLHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqcTRKfw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqcTRKfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790181175; x=1821717175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ud/vKMyPPbr33Y1gl5O2Tp2kqiY0gE+c8yfnRCY/ZM=;
  b=mqcTRKfwMfxGb52aqoGiXE9XtFdqhWJ6C7Nzrs/MYtUwmZdnibRIWjyk
   EXz5cMrGg4f42eR6yCMsokW4QZlt9oWnSVHpgDshXiv2MP4PHyCpMKCsP
   ridtqRCbFg/HPTs4mieHENvi6ZpARn/ucvH3KwpEa3Mh4S7mgELvGTPvG
   SOav/U4RwjVxtSibOqjEekq/DW08KNz4EB+dL+8wKKX4NUNy+iaVvPTGz
   Roip/Fdy8qPWsdFiyjlYYD5P3IIB5IvdCSEFcPjitbf1WNy03wm9nlq1o
   5e1LKBKkGsrbNkxm3ripiET9VNXWr6W1Revuzzib6jiAxadgBbCsfdsvw
   w==;
X-CSE-ConnectionGUID: JKJLBkxWQ2KXW+6VfE9YNg==
X-CSE-MsgGUID: NVqu9m5pQkOSD2fQSxc/EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116421089"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="116421089"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:32:54 -0700
X-CSE-ConnectionGUID: wGGm6hFxRpCAOH9Ux5PKWw==
X-CSE-MsgGUID: us6uSFw5SUKr4Yuhir3riw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="272280412"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:32:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:32:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:32:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:32:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3oY3Jl3IvuQBHwzG14bzp2NHu1OEXHuifwEKbvh+UyXp0ZO1yVRqH2FnR2fSCyLutBGsE2bn4eSZRSaTE9yHuwov0hjJWeoyAWW1B6x5xE8v07G4/YF2ccRZ35bKL12ncwqE4V7qq8hE/FV1UefPtlCFLoS/Uil+hzCHgbk35H7n4DwdSsvguKDKMyF1tkCTNszu62R8GHZH/fAdN+6WYMSX9aWbqrDDLhYfjb3fM+X6IVWtu5pE53cN6U4Ya6DiWRt/xyE3XtBh210yb3j4vMgyX+9C/pNLktmdwOsd7A39kPKLilyOFoWf5wnggAg/2AQVzxRjlMrPGJyoC1FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKvYXwY7Te3+QjPaNi7u9REcmFBdqq8mIpz1mxuJB/I=;
 b=C5Hsck3haNLTy4bGe6INShJdC/l79bBl86xRrE8n4GSKbpDJr7c/0IUqzDG4CF3M13sP90nJdgRJI2/tXrP3Joeyl820Ek6raALglAE38I2UfzKKrIvB435z6I+mrxadlKn1tiRYfZJ+Hz/vtwHAkz0WoueJTsySh0x3KeMnj6sdLIhTe6R0K+INZ9DHowo0/V+1M6xoAjOqzqWtLekfVtBksqE1MeM9xKehrbbNJwq29x1IrEykJgwqTdUOpexuyiIMk1B//UAZK8R3XSox+wRLL1QTGIOeu0sR1eemp6Xa+8xnI9G6VoAmtSEbjHOAZyAk9C1fIC3clovyV40RgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:32:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:32:50 +0000
Date: Thu, 24 Sep 2026 00:19:34 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Christian Loehle
	<christian.loehle@arm.com>, Jianyong Wu <wujianyong@hygon.cn>, LKML
	<linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Fix max_freq fallback in
 cpufreq_update_pressure()
Message-ID: <arP8Fv9z0ozmVP1t@chenyu-dev>
References: <12975163.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12975163.O9o76ZdvQC@rafael.j.wysocki>
X-ClientProxiedBy: SI3PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:295::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 130b68ca-18f3-468f-3985-08df19904eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|11063799006|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eWj1J+YDrBpQlRhlSsLmxb0ZCg0tr0xakPl/vINRCWrmLFSOBAGsGUmBGrzmJVqBMzFUz4sN0OmCil1VzOT5I4J+4VPcJ798WCQ0HTbcytv12irZtSkUdOLoKCjA2DqEw8z5IxQoGNOFICpKkLlKpZS1ZJUqQlKq+IOq7kxp3ZgzfW+VGjM5xwlwmMZE7bD3KhSx64FV4QTXvul9rhMtdPDH57Y1nTL8tCtjNWBxhD5I7kk9elARPF71R+cJfih9zH3j/WLV9QT4hy/wxnEjbXT2E+GiBqXT2fgWVtPpKQ9kwdJhCrT4X/t+b3P0Zf6mlIG1yVXzqnEYdtEtzCYK1Rw0g3sqR2WAPtWBSdmZmk3gU4olQd+4vG9vZzBas81iay3521cMcPNCh2J+gR3vXEcMywk05IjXf8RnKkCPv2zGfBZ13ec1y9lQQiis+BjTz341q0EjFso7FZ/ib/wUueiKdKsxTr/g/ez83fm01seZgVM3P/V0K5Prd0t9EO8iFGawqxRYKIzftJo9NSAOShX0FJ8Xmu+AR2Kz4Avzy62xDur3Jm0DEwQd94rCUXsoXSVDbI2G4fyQqN/LEE37I0fllQstO7F+hEq+mnK7uzVgtf5dfekKNfS01qzYSkwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOPAdOF6qcLD7RJRM5h7c/UenmTS0wuhKT3LNwG4wclJ8bse6mJgefx3gWln?=
 =?us-ascii?Q?16yBzOthS3LloGAOjNKSU++KdbWEZy/kiTcm2ZF5de5v/L6c+h+NEfAauXsS?=
 =?us-ascii?Q?ZVs2gtPC+GVMIdWxOyuTf6lT93Xw5UggNLp5kai076KUX1+s4kKxS7WfRt/a?=
 =?us-ascii?Q?MoOVHhsWYRI4u5PbXPaQKxr+dd6bI1648LxNMQozb1bR77DJ0NT4D94+idd5?=
 =?us-ascii?Q?XJo8c5Af72chVnztMeJTKrj1RggaoPi5bHXbf4w5PFJzTKk3ct9pKYS0AFJ/?=
 =?us-ascii?Q?AcVNgkniQOtMRlCQw709+Hnz/7RTKv/JiRUbtW+UDe9BN0HSCNHZ3nh6XvtY?=
 =?us-ascii?Q?t5qAwFnGTq/TdNw4rFVnjOjYmYt9Bs1wJbSvohIA89jFix2rS9ShSAjAz1Qv?=
 =?us-ascii?Q?ueAhu0PeZ7A47Y8j3NKNtIYIZQ7zSkvvUM3w1xVRR3ltcF6/KYQEMD77HxBL?=
 =?us-ascii?Q?DbHDzsoEUrYywe8reNKuRnlWCZohjJlNPGI1Fa8v8tC9NexUpzgJ+jMRlrIW?=
 =?us-ascii?Q?rhTrcsz8L2n1BlopaDGf6nFwimIgwgUVDtBi8QOE7Qai1F+rccl1clblaRDk?=
 =?us-ascii?Q?Ece7CCo/gpSP4jOwoD+b/2vwqzECeeODh59t1Ev/a5nFyDMNhBx1oQCzU0ei?=
 =?us-ascii?Q?GEixNgYLOtQAWZDiHc9Y7fCR5JjIIerzaD2EkpO8p4sRR4qCaixN9V9mqX+C?=
 =?us-ascii?Q?6JosdBKgphX4nkGDCtWyF3LVQGiadn6aLsOZ6r72k4EbUnnp2JPqJ0jFWZ9V?=
 =?us-ascii?Q?tAYUP3Ny3FzBVPlobSl9EpV0JBav1D+s+nWMzwpjVVqiL7oR+uuXYUHXPozd?=
 =?us-ascii?Q?NjNkhnjZyx6r6JogsyQVRP2AJZ+5MXVJKolIhyoNcF4l68gi5diZhr9wqQNX?=
 =?us-ascii?Q?qVewuu+d6akJVgoStg2G1KZE4R340JX7YWLN8IJKj9xxN5IULzJ/X27eDdHo?=
 =?us-ascii?Q?EfIBqAS5/dB3nqqMDjbR6vYx83lRSn9kVtvs9kiwojgpjNh8sra/gLXvjrcv?=
 =?us-ascii?Q?1lB6NYlPimZDvIlwHlyAk+i1zc2FHdbFExpoq4NaVhM5wpk3/+mG35Iw34/g?=
 =?us-ascii?Q?yOrHSqiBgXL37QBDAXCZWPzQV6uVRc7JH1bkYDSqjsizHxqwf0gNljt1y8zj?=
 =?us-ascii?Q?ODpTT8tPwdF8yVsPVEj2LrHlwal+BiMeEylsHTj9EwSvzkMpnvJpAOdIwWhD?=
 =?us-ascii?Q?ksxFpsNB+cXWNf8WDu0YHJhlhpwEI0OoAe7Wirce3x2LgMdhZ9+jL3WpAiAu?=
 =?us-ascii?Q?renWJp2qVUPjguxZJUtBlfgkeoXU+CiFTfmv5P5CFsYmw7MZH4A/IFdulcQo?=
 =?us-ascii?Q?a2egD4ozsWWWZGkWsUpkARF/dQTsyAwQPdAvZuFuKdXg0SJheCMaQLa9n+K7?=
 =?us-ascii?Q?ZDezrHMkWXF5C1Cgtwv0KM6CTZu1nrxaLlor0Rosi1h6efbndwhWKamuBSmX?=
 =?us-ascii?Q?mMEfy0hxjlFv0XJ+FxbE4wairVsk96LE1UVoeASS2U3GIBAFeArBYc48UNus?=
 =?us-ascii?Q?gNgU65mkeODcAAjIgNhJX1OltumwgLVUUUxEgaSiF7md60D7YHoqUj4LLRmv?=
 =?us-ascii?Q?q6nhFq2Me5xNkkjQyhvqzTPH0PWHQNlDkWBg34pZLSnKGF95OotsCQs5lf0p?=
 =?us-ascii?Q?gPyJt2Q1hY8LIxEKtTwNTQiGSHbmh2h9/HreFc8/saFksxssv0GnMvtAL1Jz?=
 =?us-ascii?Q?nAlreNifTBat52ppGJKFyd9rkVyXDURAKQEt47YDcEPcttsNaKa6baDtA5cg?=
 =?us-ascii?Q?Yb2l0GwPvw=3D=3D?=
X-Exchange-RoutingPolicyChecked: aFFc09sBSJlJZPnLhjPFscPker3LQ9COF+mTIjBI35HQgPU8P2uqEKI0BmVaHksypaz5PIvKgHdB/1EdG2y0PS0neXranh76z8CAWrV//bdcJGP+8RlMCABbF4IpNsuANNZSEa9Wl57JLxvvbkixENwT1+M7xLQtc7F9ozDMMfE03gAE/9bqadGAZncMTO3+yQYaYtFI72Agj4px2qBJHAjcMkDKyMivvP9QkQGJxMPiGvMKDheYqbYkl9MmYAeBfld0h7oNnBzx1PPy7ZGoNIXoIe3eTiOFywmUt2fA5t2+8K3HHd4OYD/s9nFQ2qkcAUJLzyZ9eL8Zk/5brYPdIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 130b68ca-18f3-468f-3985-08df19904eaf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:32:50.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Acm2KwQU5j6v1J4FopXBCnnm0ua0cWW+9CHAC8KHOr62qwJ07Cnk2ATewxXl7vGMQJuhhs+m+cSRIufZb47SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
X-OriginatorOrg: intel.com

On Mon, Sep 21, 2026 at 09:12:00PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> After commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
> back to cpuinfo.max_freq"), cpufreq pressure appears in the CPU load
> balancer unexpectedly in some cases in which it was not present before,
> leading to confusion and uncertainty.
> 
> Clearly, the scheduler assumes that cpufreq pressure will not be set
> unless the capacity reference frequency of the CPU is known, and the
> commit mentioned above violates that assumption.
> 
> However, in some cases the capacity reference frequency of the CPU is
> in fact known even though arch_scale_freq_ref() returns 0 and in those
> cases it should be possible to set cpufreq pressure as appropriate.
> 
> For this purpose, introduce a new cpufreq driver callback returning
> the CPU capacity reference frequency, .scale_freq_ref(), and make
> cpufreq_update_pressure() invoke it, if present, instead of falling
> back to cpuinfo.max_freq unconditionally.
> 
> Add that callback to the intel_pstate driver and make it return 0 unless
> the scale-invariant capacity of the given CPU has been explicitly set,
> in which cases its reference frequency is always cpuinfo.max_freq.
> 
> Fixes: d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq")
> Reported-by: Jianyong Wu <wujianyong@hygon.cn>
> Closes: https://lore.kernel.org/linux-pm/20260915065747.1671965-1-wujianyong@hygon.cn/
> Tested-by: Jianyong Wu <wujianyong@hygon.cn>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I did not observe any issue on a 4LLCs per node Xeon server when running
cache-aware-schedulings santity test,

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
