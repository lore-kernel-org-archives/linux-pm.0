Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC234A68B0;
	Wed, 23 Sep 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163303; cv=fail; b=KWky8M5KhFWTmi0N/oU3GAxouKiEzIGud/QDVmwx9pmK5wb8siHuZtPZsN9dBs2plWprHhODJsGJsP1R0CPMJGMtqF2s47XVOlrpFASRny+xpvlmX4KpNwkTE2ysAyXTvyRU48AFw39DOnmcn2s4FelZrwkt6eZclQHlZgrrkqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163303; c=relaxed/simple;
	bh=2HH8LfpCxFj5rZ2dw+UjxRgUH1ivtc4eZjU4MNcrC30=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F70Z19u18afRw2nb87NaIvjMsqGkDi1ixx6JSlzS8XqPLk3i1MryG7xf6P2AcmNMQ9pIGKeI7h+52QbIS2TShGiVWG5ZeY2YG7GwRkli4L90JrhuTZQgjcQoW1wISctpGgnygnyHnoZF+AgoXkE6mm37olddxE/A9nX9pWmZcnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxssE4D/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxssE4D/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790163296; x=1821699296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2HH8LfpCxFj5rZ2dw+UjxRgUH1ivtc4eZjU4MNcrC30=;
  b=LxssE4D/j3ByAyfgYihW2+bPJVHKd+TLecHE8jLC3xDjSlmbJSZ3JGOv
   IiOcDo1E7AXAm9+gxk+WuBenfpoAah1kYNXHwN4njUF94Jsdy4xk+L3H5
   jAWDNIPzMx7Xj+IDjxwt1XyBR2mbFUPAg3RnjyjeMSIhn6/otJ+XAnnu2
   Lm7YJqCOcsEJD32q1Z5Ol1/rSPUHHZHJtS4JpBnQ3TnypR96UtoS6hN54
   JrjU1kyfwR63O3uxbUS929nG4M6IHH9tW12ekr0uvNydIXsWhS7d08psZ
   UkT9MBMOK13lpxXOWEVL3KU204D3kAzun0Syrzl9ebDj4zRXOR9MES89c
   A==;
X-CSE-ConnectionGUID: 7WKemmvBR/GzaA9g5rJLgQ==
X-CSE-MsgGUID: 9iAn8TUbRduXLAsXaqBZjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89766723"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="89766723"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 04:34:52 -0700
X-CSE-ConnectionGUID: ErFgsm5pSHyXMIVR6fy7pg==
X-CSE-MsgGUID: oH0nXo1mSsOeCG7KmcLH7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="273746033"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 04:34:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:34:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 04:34:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlBJKJScRuDTaBTV1dXe/QPO9ki+hO78I+AymcrzZDdBfWuFayLB+7CCH8BRLyhTYKzrC0IZjuQaGfdUoHfL1uq1dGmANcVV36pTISl3eUp1mQaQmILSTPQudZ29kpH4Ej6wuiMCJCpsWbITOqMqJQs8JFuAgDxFqm8jhz52vcQgbTF+xoNks9Hnd0cydFIsivh8F3tp4JP5v6eEpkf6iJ1IxcZg5usnosCjrtJI0kEimAymwAgkLnTnQvjXJYHKZZ6fXRuH/tHP1mB3buOdlcYyhBhiYqk69qNK8ldvcKUWtzJC3etmJLURsiUPbx5S4L8juHwwWKdHnoI4TCSZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL922/6PIa9unVwLc6i5hfNDdTkkv9QVec3BGD7zEM4=;
 b=zKZHeBF8M/VM3nrmg5KsHQ9wFtAfvFpS8xVu50iZUPPDYaHh2di3sp2vS+ojQYLRul28SeyG2aebVlK9JBz6FcWYYn9xUvcbh6ejstrlsGm154EN9tL49paI5bqe3XqhtDMhdeDArgRblRYfBSMj9H0kK7JlLeUe/PYOn9Of+Ut+OZ1NIB3OeZNRtx3VdGxraaqu589OuyPf9Z1ImtTFimxkTx1tOC43bTgz+Zdt9Z/7Om+YJ//aucJWrANXbGRZnfSWXU68nj1FCO2POY0BKFiwAeUZVPFfP5WvMcxlTEF6PdlQEQ3WPYVEplj4H11lgY5vmvnIj53IU8Ad3aOX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Wed, 23 Sep 2026 11:34:47 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:34:46 +0000
Message-ID: <ac8a6383-3a8d-4fcd-bad1-dbb8dd6cc742@intel.com>
Date: Wed, 23 Sep 2026 19:34:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in
 fits_capacity()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
CC: Zhan Xusheng <zhanxusheng@xiaomi.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Viresh Kumar" <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Steven Rostedt" <rostedt@goodmis.org>, John Stultz <jstultz@google.com>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-5-qyousef@layalina.io>
 <20260923065407.3451520-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20260923065407.3451520-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6d4d08-fc68-4742-4ccc-08df1966ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 6kslgspGCTLfSOb5/CndQJvhD6QmBGXRmIs4hfLUAekRFaKsjqwu7oh6sgK/Pt0m7uCRS9/cin9DBZHCNL/wBpvADm9nAlixXwvSmkvEff3P+kUam6vU90kU72hwZWN9aNIf6ENLaxxGIhZ1lzBIKSii8ZKX3rRfzNRzvTK/J8XSYo88RjiZTEKOcMqOmdEbawJSHfGtp9e2FAKwilCoN/g7WtYkyPSffZsFgCl1cT2Po1YITcBHXS82dqn/PVdK9YzKIvxzwwmxi6rCakpE/qITTEt3rnukhHJiI+qIvMiJ46dHnZ7ZehiImq/lJgNynI1raZccreVCWvCXT+vjfrktExKAftO+b+sRRGGDIFO1MZbWEQh2Br/OSSlcciMwEYPj/cLR5PmCzkB3V2AdbIvlfb6PwBJ7FiDeOlCYSpAuGpQk9HOzw0/9DyhJfrxdjqio7PUsHaRSgwGb2uoqZZoC8e5s4Gt8kDpxtLa77QLnW/tqOtIYlzwQlJEs51o7EHxH2W/vJ3LqVqpL+u1QL4C8LDFQhBJqCvQf9Jb6gIlMLdVBeSLU7zOtSOu0iML9UPeQv+JBpecSLFRv2S1l6u8TTZMwOMd53PK6AgYQIR5ckiOJVvQLgIbpN0yHZ73LVhFk4FbcorsD7qFozQD2+RSMqmFvAfDgktUeWOg+/5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhaK2xTZnY1VklzdEhxbkVHdGhOdi9ySnhDdFJrZkZsc1hsMzV5LzZENWZh?=
 =?utf-8?B?WDdPaG9QdkdBOTk3c1hLOE9iWFNKVXZkdVNicG1HaEZScndMV05LWDBsT0Z6?=
 =?utf-8?B?ZzJTTkgwdE1VZk9nVnVDM2k0ZVA2WDE0ZUNZbXk2Zk4wQzlHaWR1NDYrOEFk?=
 =?utf-8?B?UFpGNWdmdkdWc3V0OUM5VmhQN0VIelovZ0RCYytWYzMzVXFDamhRMW9sU1Ay?=
 =?utf-8?B?MDlxSTlTcnRWdlRzTzV4MmFRbXhzdnNiMGNSTTd6MERQdnpObS82TWdGN3FN?=
 =?utf-8?B?aXZpbXVTbHRsNHRNRXlqcjRrMUZWNlZrb2F4bzJjZjFMd3RFcEw0ZVRoVHNZ?=
 =?utf-8?B?RnpvTCtlV3Jhb0xuVkVubU10U0NxQnhlYVFkY25mRXRaNnA0SUZiM3pPTDVl?=
 =?utf-8?B?dFM4akNGQ0FoNU9NNG1TTXdtWWNuK2I4VGpmUno5Z3RxRVZrZW02Zit4aXls?=
 =?utf-8?B?cFF2aXBNam5hZzduUVg5RXljYWU2R3RPTDJNTHBEbmlqK3dncWpIKzE1elNY?=
 =?utf-8?B?a215RHlzT3c0bFdrTlBzY0ZkNzd3RE94VzRXQXk3OGtYZEt5cUQwTVE1R3FW?=
 =?utf-8?B?TUVKb2ZCelFtWjVieTVZM2dvUUc1WEJZTnlFSGlhUWhXYVZqYktqZ1BTeTJi?=
 =?utf-8?B?SlprZ3h4b3dtOS9RT1NqRUdKd216TnBRNmJiZnBxMTFNY3FZbm5UZDA3akV1?=
 =?utf-8?B?OWp3eUFQdWFuR25NYXFFZ2QweGpSblVEb2ovSUQ0MUpsaGRtVXoyN3NMNWto?=
 =?utf-8?B?M2lkQWxRWHJsL1NNZndSM0xWOVlndm1VK0tnazI0OG5ZR2VNYVFRSE1YNTZ0?=
 =?utf-8?B?V0ttK0Z6OHl5cUIyWXJWSlNPV0VxVkRRSS9jOG4vNEJsM1VwclFLSjhBQUJW?=
 =?utf-8?B?K3YzbVFVaGFUeVljdzFpek1MMWwzKzNjVXZDRFNxaDFMaWxjVTRuaFJRWlZm?=
 =?utf-8?B?RW43bU1zYlkvUDRUT2xsRTRjVG0wNUZrNlNaTzFMeGFqM1JmOW1pUURIYzJp?=
 =?utf-8?B?VUNSQXJITU56eStIZ01XRnU2WUsreGJtRXdaNENpTEduN3g2bXlTcW1sK0ZD?=
 =?utf-8?B?VDJvQk9MUEwwbDlzSEJUampsb3YvWVBWd1RmcjV3OE5qYnczdHJQY1Rvd3V2?=
 =?utf-8?B?bVlOS0ZkMlU1TUNTSFpDNzF6dy9BVnEvTU90dEJCQmNGWHMrNTZMWGpNSU1H?=
 =?utf-8?B?anNZUTZkV2FQT2s5NElYODRMR1BYM1JsaWE3bDUwNUdrc1N4RU1TL0diQjFE?=
 =?utf-8?B?QWFjdTV3RE5zUE5mYmM5VmMrdGh3ckJvM1oyclQwaVpaaG9UNGx6ZGxNZzZC?=
 =?utf-8?B?NVA0SmI2WVcxOU9hK3RWUGFudUkzWTJ4QTRoSXdkblJyeEdqNE5QL2JiZ0NO?=
 =?utf-8?B?QzRmeGV2d1dXdEN6UXBhV05yejA2d3BYUzZaRTl2ZzNKNkFPR0pNY0pZeHVy?=
 =?utf-8?B?SEE4U0lRd3F5UHEvS1ljaFJWM3Bjd0gvdmlNeWRVR1QvaUtTZFBqSkk3WjlI?=
 =?utf-8?B?eFZOUU0waEpldFNvU29yMDFEeGlpaHRzbHJBUG8wWlBJNXd1OC92cEtHVU9L?=
 =?utf-8?B?UW50ZkFmRU1rSjFaWHEzQmg2YWxkT2NwSVAyMURWREdBVG5hL2IzNnN2U1Rn?=
 =?utf-8?B?bjlYMjJQeTEraXp2K3lwZnhsV0dBMUdlY0dYcExrYTVoWUIyVHdUeFpDWFY4?=
 =?utf-8?B?RkIwMTJQWmdSSVBNckJmWVJwb1U5Y0F4bVozTTdkTlFnV0NpbGhqb3ljK2VB?=
 =?utf-8?B?eE1ncm4yNVloZTFpSUNLWjBXSnAzd0huemxneTA5OUhCWisyd2lPZC9FeTV3?=
 =?utf-8?B?eitqQkZZWUJGVkdLY2xYSEV3MlZiUzFsM2FST1poQzk1S0l4NU9xWXBXSVg4?=
 =?utf-8?B?WG81UmtIZTJsU1JUdzRhUGJKanVuY2VLaGpPMDc0Z0VEeDQ5bkhDcHE5NHpL?=
 =?utf-8?B?Nm1VTlhNN1hBODJtVHZ5ZFFZKzllOW9peGRleDdWY0Nid2JNekVRRFI0TWN0?=
 =?utf-8?B?VlNEak15NC9CZjJTM1BXR3U3T1RQaXJlMDRBS2x6dk8zTnNwNlFFMWdyVS9H?=
 =?utf-8?B?RjRhTFk5aUJ4Y2lDdzJnTEFxeTJyU0hYUlNTNTNGc1dqMFVienFJYmRNQzdu?=
 =?utf-8?B?OXJXTi9VWWRPekYwd1VmYW1DdHBjcmR2djJiTitHN0hIa0xRbzdjcE15Mkxl?=
 =?utf-8?B?U0pLOXlHZ1FvQUVMMzZXL2FOcU0wNk5qMjlIZm5WNk1GTGoyalFlK1JzTjBI?=
 =?utf-8?B?SlhISjZzR2paYmphQkp4S1g2L0xOdE1rS3JRYjN3QlZ2TDR0MWxMa2Z0bXFX?=
 =?utf-8?B?Y0U5Y1ZZNjd5R2wzUEluVDhmWnlMa2dOalNhNEljYnoxS1Z3N2ZnZz09?=
X-Exchange-RoutingPolicyChecked: 3F4bRUieYlx6tMvKAUm/gZP56Spn2Mo74wg/3Xw4JmkFfeoBJK5G76gYiJadPbDbR4nIW6ZKU6gEUxwaaUIv+8nWpidkHxyYWoP2nqZXnJtWch3N6dR68MJKIsXRgxWpTloaPmXLaLy2kFor+Go4fxxq7mUXfONVqt5wpQv+0VfRAj3pBO8EJQ/qplAE1/JxBToHfnLrRqw4q85UuRzD6yiRj74R3hlRWIRjxqW6ZaMnxDeXMMHTBwZ66AeVa3qPF5Ld+hRxQGPW/1F9Ryfa62pU7UuctgUL2BC9ZfEiknToW/ECYP0tCWC3ZHypar0tZk3EFfaLgiTHLnLAupAlHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6d4d08-fc68-4742-4ccc-08df1966ab5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:34:46.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTz4wioS1iywCDEkxqUkf11bDxAmHl3iHhX6PGaEbaO+zzpUKHYpOygHihQCwAutclLusoEieMaJ4M1V6GX35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com

On 9/23/2026 2:54 PM, Zhan Xusheng wrote:
> On 05/04/26 02:59, Qais Yousef wrote:
>> -#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
>> +static inline bool fits_capacity(unsigned long util, int cpu)
>> +{
>> +	return util < cpu_rq(cpu)->fits_capacity_threshold;
>> +}
> 
> This does not hold on current tip anymore: fits_capacity() has picked up
> a second caller that does not pass a capacity, and the new signature
> accepts it silently.
> 
> kernel/sched/fair.c, invalid_llc_nr():
> 
> 	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
> 			(scale * per_cpu(sd_llc_size, cpu)));
> 
> The second argument is a scaled count of the CPUs in an LLC. sd_llc_size
> is a per-CPU int and scale is an int, so the product binds to the new @cpu
> parameter with no conversion and no warning, and the test becomes
> 
> 	cpu_rq(scale * per_cpu(sd_llc_size, cpu))->fits_capacity_threshold
> 
> With the defaults (CONFIG_SCHED_CACHE=y, sysctl_sched_cache_user=1,
> llc_aggr_tolerance=1) scale is 1, so this is cpu_rq(sd_llc_size), which is
> not a valid CPU id on a machine with a single LLC. invalid_llc_nr() is
> called from account_mm_sched(), task_cache_work() and
> can_migrate_llc_task().
> 
> Separating the two uses first makes 04/13 safe to apply. Something like
> the below, against tip/sched/urgent (3cb0243767fd, where the cache-aware
> fixes have just landed; sched/core still has the older mm->sc_stat form).
> It is a no functional change, since x * 1280 < y * 1024 is equivalent to
> x * 100 < y * 80. Built with CONFIG_SCHED_CACHE=y and =n, no new warnings.
> 

How about x * 5 < y * 4 ?  The y * 4 is a left-shift which could be faster.

Thanks,
Chenyu
> I can post it as a standalone patch if you would rather not carry it in
> the series.
> 
> ---
>   kernel/sched/fair.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 57360f5cdde4..97ce56fcaf85 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1526,6 +1526,21 @@ static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
>   	return false;
>   }
>   
> +/*
> + * The margin used when comparing the number of a process' active threads
> + * with the number of CPUs in an LLC.
> + *
> + * Mirrors the ~20% margin of fits_capacity(), but is kept separate because
> + * fits_capacity() describes a utilization versus CPU capacity relation,
> + * which this is not.
> + *
> + * (default: ~80% of the LLC's CPUs)
> + */
> +static inline bool fits_llc_nr(u64 nr_threads, unsigned int nr_cpus)
> +{
> +	return nr_threads * 100 < (u64)nr_cpus * 80;
> +}
> +
>   static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
>   			   int cpu)
>   {
> @@ -1542,8 +1557,8 @@ static bool invalid_llc_nr(struct sched_cache_group *grp, struct task_struct *p,
>   	if (scale == INT_MAX)
>   		return false;
>   
> -	return !fits_capacity((READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads),
> -			(scale * per_cpu(sd_llc_size, cpu)));
> +	return !fits_llc_nr(READ_ONCE(grp->nr_running_avg) * cpu_smt_num_threads,
> +			    scale * per_cpu(sd_llc_size, cpu));
>   }
>   
>   /*
