Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793644876;
	b=DPuKV/BxOBXshAHQ2PowU5taCpm1pIYuWUQUjFC2ovRBFeo7FFMNyqzVLKxsX40jCH+u
	 itRoBOL7tE49QQK+HffWdBeTpo5x4xNme3yKXiFxn12FVTs4na6Aq5kzntm9qnwZdV4AG
	 4LgNa0LKC2nLg/vegpapYSmvB2UVx6UjXfuizRfwBSsyXB06N+FmzcmTpJqUbB0Qbq5SX
	 smYu3U3asN78Byettn8Vh507rk3HA8ezxahmmbzrb3NZq6+s20nVpmKPFNDDogQ+KRWd2
	 nGIx1sZfXZ/pf9XguSR9Wm6TBZyg1QumsCHkaATdXVwcp7VP7jbp7KA+4bwM8HO4Fqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644876;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=nCnUz0CrzUDurUFU6wkJkx34u53bgWmx4c0EKNIxJxk=;
	b=JBgDkG3HnaQZUKj9zU/lHaIE3qnRsHdWsfkYJ5NPerXl/yQUIq4XYj4DjC+pDzwcAuwk
	 6OxCC7taVoAff2fDb2MgXBt/lU/vNDmeR8YkoUMzt59HTnkKUcQbMmsNN+LyH3PeBkSyx
	 BNh4QRjJ/lVMP/e3ZfFraQD/ou65km70uA/VB7QpBapQl8VZwrl8au2VXbjI6lPBF5e3F
	 qQwGw5ebAp6/sAv8bizt5bwAZPZpbYtBgCHVluqW7MR3+dJYs/PL+HUWZOHXN9G4FBU8I
	 +ZiSbBDNLwD0zUprKXfhvNEzV7pU/rCjiEOzJv97T0jYiCF3EMvBTA0BLcoUAHelnXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TptBgPFf;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C71606A32F;
	Mon,  2 Nov 2026 18:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C71606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TptBgPFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793644875; x=1825180875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hkWj4IA5ws7SNAYwCloOnrUxKw9K6Fmybqsu0EX64GI=;
  b=TptBgPFfMHSRVFjFDwbfbqLKlw4Z8bDA+tUIDQNjanqFtsBDVXf3kMGg
   /Eqh8d8lJFBKLILUCxDl9j3lx7KKFr99IKMbg2Ps4Xm2Q60LDhMwcDgLr
   bjyWEZZvjbZYSMQGVWET2/1aGJdTM+vt5exbSH90YLuOgedu0kxeGEhbZ
   nrCi0A8OI5uqLbztid+Ax4SDbeVZO1nAOhhZL6nTGn7MpRQyCxnxl1jIJ
   yE47P9Ea9Z3IkpuIU/AAIbt65eunsbqpfDE0s9+V/pqAoKTm0ENBOgevR
   dGYZi4qnrXMpMD77IqoNA9mYGH0dLZ2X9o3Q0110X8Jk3iKlyUQ9RAHy1
   Q==;
X-CSE-ConnectionGUID: 0SBgcwlzSA+vcIOB3dMlfg==
X-CSE-MsgGUID: EJqIDbqmRs+k1Oblf6e5pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2354528"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2354528"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:41:13 -0800
X-CSE-ConnectionGUID: T58tnR59Ql+oJnN4yW9XzQ==
X-CSE-MsgGUID: z4RW8OFuSXWzH9KQ0bvpKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6533108"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:41:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:41:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 10:41:12 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:41:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHF4gzQkN7ryNFoakgD7NwBvIack5l82C/R414Ejo96Gw4Qd/BvRGBlqsXaD+vUaudc5VuJ5hYi4vSIheI3kr+P0xCWrVxtg8wAFNwTVnbd5/W0ksLHDYt9WV3QoAg6NXWnb6SfmDiM2iTD7w/PNeh0Cflzgaj554Ed6edKlTphWw4zBrOpqCvcS+VuLMUcDyDOrMT6BLUiW4avDcKvwatcWVywk93+eXVQFzK+8xniw2jiPYgZ4utSb74MqjJRc7kKbPS5t/7x0jl/v0vuswW45FStxg1BDHHWbvT7zxZ/xdLFAWHQ+aHaQpSkuJpgBkI9zYr3l28c2n+CYwPS9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCnUz0CrzUDurUFU6wkJkx34u53bgWmx4c0EKNIxJxk=;
 b=n4OdjUul82FbxzRdUz4nOdD1A9JQNGHHxQVbMg3Y3qVaJRrpYtbITN2DHdKXJ9S+3rVs3HtwhVB8yGaOk+SLLDSS3RBGjUfXiNWFbQhsJni6+ItRu5Dtz+FxHCmOTix1pgst42K0AijhObX+yATIAUFl7jjnLhHqj0RMnTKRx/8vtLsBdBjVIjVxlT8eKjWeK2xgNZDSQkQGv7acvKwonhiyHQ03YZf2vqFnvMzm4xyt4JHxCoqRRB2Vl/ZfuWgj5FJnyXnBF4tXOA/gmHuyEgVthhGRkR4XN5pHd5yVEf5pEsrgaxTt/024SOV98ZhSQJAStyugpDPky0GO+9jVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SAWPR11MB9897.namprd11.prod.outlook.com (2603:10b6:806:54a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:41:09 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:41:08 +0000
Message-ID: <0cdd28de-cbdb-4194-90c7-58b07c45dffc@intel.com>
Date: Mon, 2 Nov 2026 20:41:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] perf/x86/intel/pt: Clear TraceEn in hardware in
 cpu_emergency_stop_pt()
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, James Clark <james.clark@linaro.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Frederic Weisbecker <frederic@kernel.org>, "Andi
 Kleen" <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<driver-core@lists.linux.dev>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-5-adrian.hunter@intel.com>
 <20261102100750.GU1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102100750.GU1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::39) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SAWPR11MB9897:EE_
X-MS-Office365-Filtering-Correlation-Id: 87596625-f671-490d-1c3c-08df3910dc1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|261102123227099003|56012099006|11063799006|5023799004|4143699003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: 1RoJKQS69d9vBzbcfBbUxrfArct2rkkmYPNrcPYG1iEGdcsxKDEmsk5LiWbiYEmKQ+AlY8TIGg1X4REhA1nfFbC0vYwIOdZRMudP7p74lK2Dg6IqJdsKV6J9+geT14R+bjvlVsERVeK2UZG5bfgfjcmLrV9bjo/SJwJsFOVCQ5//y5jN6FAlStnNQulax11SS+Bw3OQODZgueYjz3WCYpB57WbFgosC/zL2SQf1dtBzLEi/dSM+QyjbiqAyl1pzqVj1PvuKaPFx06EHpbn30wUHI2W3vqRRIZOHr/9Id18+HTa32/7t5vrACHy8i0QLnLOD8nv+hmhNJmE27M/2Fv0OpbpOE4Qq/cm+XbkH4Q3m/vgtdAPN6tdk2v1CIylKSMKZoJdG8095YAe+Ruf8030QvdUKMyIVR6Br50Wn2WH0wpaIm8C0xCVilgEaR9+j1uKGP1sTOQC+AseNizCIa2jMUGtvXJA8IZDfViZyB730rVUUpLTWB3slzaPjI63VbpCay7tz1U7CWZxWZwtZWUzLbnqLUOsqcQ4S9qdTvmDQ5lXMt8TO9b95JVGhqdXSZre9a3G1hijGyrz+q8QwT3aFYFT49FIMVt8UJLzo8OSAsYC4yNuu725AJ4GOZ2insMHJpXBQzc+1fkX/p00OXAWTY1GeLwvFVUGgNH4RBrl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261102123227099003)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y21wOFozWStaS2VmRTd5WFNsU1Vjdkt3RFpuRUFLUU1uOGgxZDBpR291VmFE?=
 =?utf-8?B?NExKc2lSeTBacnBVb3hEWWV2Q2JWd3diVkU1THd4UjRuTG5iVXlRUXp3M2tD?=
 =?utf-8?B?Y3pLaXk1eGZXUUFvYjBFeitjTWhxcHZIUE5wR1hQSmFZNmdFcXhNUzNkSEhw?=
 =?utf-8?B?NWR1UVRRVnRDWjZrNERIdFdzZTBZZXhCVDlyZ0IweVpPVU84Z0RUMDJoRjk1?=
 =?utf-8?B?bysrMVVyNmVxb2JPR0ZKbUFLTitVVVNkWHpqbWU4cEdnTWZpVGIwOXk5Vkxt?=
 =?utf-8?B?YUJLVU83L2lDbUtSeDdSOHlkMnpxamt1cnZHcjQxQ1huRys2R3lkUHFGRTAw?=
 =?utf-8?B?ZEJmWEl6dDhGaVNtb1JQK1Z4bWFyUnFjb3J2RXVGT1VwRFRDeE8rN2N2T1B6?=
 =?utf-8?B?RnpuRFBpVTMydHR5VTE5ZUxCSGdJY2NRVXpqMFdJT2poOFNZSHZBb2dPTXh2?=
 =?utf-8?B?eUUwS2hOc2xnZ0lXaTNla1A4ZXZHbWRVbno5dWdzcmdCekJiWXVvWGFFYVJM?=
 =?utf-8?B?aVo3L242N2lVc3RlR21rTXN2eGRpMDBLVERtbXdST2kvTHFiZWN5ZVlVL3Rn?=
 =?utf-8?B?di9rR0o5WlIwZHRDcmkrenNXSjVYWkUxd3k5NUZMZjhEUU1JZ3o3VUtKOE1S?=
 =?utf-8?B?N21HSFJ3SXgvSFJwWStZZFlCek9vcHNuNngzNCs4STZqT2xSL0NpQXRaQmxh?=
 =?utf-8?B?R0V2RzQ0S0hMS2xHcXRjNTNFaWtBeG5QN3JtUGlLZ25UdW5LcGdWQlMyczNK?=
 =?utf-8?B?d05VdXlMWVNHWERnNldlaWFOamk4Qi84c2hqem5mSmhveFBXbU5GTzFOcmw1?=
 =?utf-8?B?cTE4Uk1IbWFlYTVrd3lMZXZYZ1dvTGZuelVXeDNZS0lQS2tuY3hodGxzTEp1?=
 =?utf-8?B?L0NWb3AyRS9uUWlLSmpXU0tDWUN6VEM0cDFvdW1hWDdBK0xWcjVadmdzZU00?=
 =?utf-8?B?VEZVTzVMTXBiY2pXNW9BanY0MS9zWHY0UUR6YndqSUY2V2s4SWJPam92T0xU?=
 =?utf-8?B?c0xvMUo3NjZ4YVVua0JzOGswY09vQXdzeTljampJcFpqUGhiUE9vQnRoNDMx?=
 =?utf-8?B?OEZEa0FlZ1NLdElGenQxVFJ2N2J2S3I0aVY1OHNLeTZDdnpDNjdzV21KNzlQ?=
 =?utf-8?B?bTBTRmdHdTJoVm5OWUhRYWQ5Y29vWi9IdXJuOGZHUkJ3Z2ZuMk05Z0tlMTdz?=
 =?utf-8?B?aGR6Z0p3cHJDbFo5OXF0Y25Ydm1oQVBoc0NId0V0ZjZaVnVqdTBodVAvKzU2?=
 =?utf-8?B?bUMvUUVUaTRSSnpxYjZwOFQ5b1puSkZjbjMyc1IvUXJod2lmUW9NQzNmRWVN?=
 =?utf-8?B?eTJXdG56VmxWcWNscnZqWEdCa1pxUWZsbjBmQm1zSHVES1hvYVNidDhFVEV6?=
 =?utf-8?B?U2dveVRQa2l1K0tDaXdxdzRVN3d2alB5VnVCdDVLSSt5ZUM1ZFN4V3VtbkRG?=
 =?utf-8?B?V0tWRlFqYjB5enJ5akN6bm9QazNtdXQveWRYeW9SK1N0L09zUmorbHhDb0My?=
 =?utf-8?B?VTFCQ1RFRndUTWV1MWlNYzA2bmZRZDJPM0l4emRDK0VaWnlJbjNGY0I0SEQv?=
 =?utf-8?B?Zms5YXNQRVR1cG40dTRCWXJuK29LdkpTUXp5MHE5NHp0SWdwMldNVS9wUjgy?=
 =?utf-8?B?czNtWkFkRGJyY25sYUNTR0V1VWRLRzBRM1J4N25pcm1mN0Y2TE80aEdwUlVT?=
 =?utf-8?B?dFZNZlRzMGlSc29UaU9iZEZ5aHpPZVhXbkwvMVlUU2pQWmJHMVVta1VuVEYw?=
 =?utf-8?B?c0dibnE5YldOSEM2UjAzd3lMeXJ6Tm5jQ2ZBZW5LYmE5ZlZGckJnTFBJMnRk?=
 =?utf-8?B?ck12R1B3TWwySENGZ0M3RTNEbUN1LzNHWFhmY2Nhd1NLZk1rN3RFS1YvSUlt?=
 =?utf-8?B?c005bkNBQ2I1VWFzR2tQRXpSb1pOMEZ3VG9oSmQ0YmZGZzFzeTkvSmUwMkNE?=
 =?utf-8?B?Z1YyeXNFZ2ZUQTdoOHhrY042L0NHbFNJVXFGMGQzTXZhMWkybHU4d3NQajBC?=
 =?utf-8?B?OS9LV2M0YlRubE8rUnZ0czdzYUhZTGwyZUlmNExzbGJUT0xFMGNmTUc0NUpw?=
 =?utf-8?B?YkRQZXpuZ054WnVsdlh4VHY3V29QaDFpU01FS3hyUXNxZ2QwUWtuOG1sYklw?=
 =?utf-8?B?NmtUczBvbEFPQTlPQzNCNktCR2lYUlFWY0xEUDFRKy9razlZZE1ETlkySGRw?=
 =?utf-8?B?RHluS3Yya2JvRUJXajh5bDlnOSswbHhUdUgvVldTY3NZdnVqYXM4WEJzZVJz?=
 =?utf-8?B?UkE3NGFoRG9TcHZvQkRwVTRrb3piZVFpc0FOU3FNL3oybnV1SVNrMldPQ2ha?=
 =?utf-8?B?ZW8wREhPMW1ya0Q5ak9XTW5pM3NqeG5wMzgySnNCM3ZBL2cvR1dlQT09?=
X-Exchange-RoutingPolicyChecked: j0whBeH2pE0DIrw2WgThfH2Js1vjOlO+Sq1wIyd6y/6mIwTWENkcIAjerAoGk2e0WMJ62dmO9d823KLaLaEDrXHhZ5xjbhascKcteX8BbBtvBsFzttDKXKFaJs10/CIj45IfzJGZwccogYtmcZqcTH2z9TBd2NmKVuAiqMk43RvM6n5zCR+GPtujOXS5/STFIFkWHq8cT3ntPhTrhuiGVkqvRHTPZ318badGanzBi5vyZ1vJ6S51cAyWOs1sQHsPD7rZmZALn/W7vu2z7h6zKcYNwPXQ5/cMwtyOZgHmR9JErQ1b/VDil9zToCmyyE3mnWoipvr9nmt8mp+0kjmxDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87596625-f671-490d-1c3c-08df3910dc1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:41:08.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LuH2/7k7mfmg35yDgBjHbbJ0CD7V/QFdI+Ek7uD+5+KixxOwAjDGkOUbuC09TWG1qLwh3PVvIGoiWXSsxe7tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9897
X-OriginatorOrg: intel.com

On 02/11/2026 12:07, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 09:40:37AM +0200, Adrian Hunter wrote:
>> cpu_emergency_stop_pt() stops tracing through pt_event_stop(), which
>> assumes the software state accurately reflects whether tracing is
>> enabled.  That assumption can fail when a crash NMI interrupts
>> pt_config_start().
>>
>> pt_config_start() sets TraceEn in IA32_RTIT_CTL before updating
>> event->hw.aux_config.  If a crash NMI arrives in that window,
>> pt_config_stop() sees TraceEn clear in aux_config and skips the MSR
>> write needed to disable tracing.  Tracing remains active in hardware.
>>
>> Alternatively, an earlier NMI in the same window can stop the event
>> without restarting it, for example a group throttle calling
>> pt_event_stop(event, 0), or a PT PMI for which perf_aux_output_begin()
>> fails.  pt_config_stop() again skips the write, so the event is stopped
>> only in software: TraceEn remains set in IA32_RTIT_CTL, and
>> pt->handle.event becomes NULL.  When pt_config_start() continues, it
>> sets TraceEn in aux_config, so tracing continues until the event is
>> next stopped.  If a crash occurs before then, cpu_emergency_stop_pt()
>> sees no event and does nothing.
>>
>> In both cases tracing can remain active into the kdump kernel.  Moreover,
>> pt_event_stop() may access PT MSRs while tracing is still enabled and
>> can trigger a #GP by writing IA32_RTIT_STATUS with TraceEn set.
>>
>> Fix this by making cpu_emergency_stop_pt() disable tracing directly from
>> the hardware state.  Set pt_shutdown and invoke pt_shutdown_cpu(), which
>> reads IA32_RTIT_CTL and clears TraceEn whenever it is set, independent
>> of perf's software state.  The shutdown flag prevents any path from
>> re-enabling tracing afterwards, including intel_pt_handle_vmx(0) during
>> the emergency VMXOFF sequence on other CPUs.
>>
>> Continue to call pt_event_stop() afterwards so that AUX state, including
>> the buffer head, is updated for vmcore collection.  Its PT MSR accesses
>> now occur with tracing disabled.
>>
>> Do this only if the driver initialized successfully.  In particular, if
>> pt_init() finds tracing already enabled at boot, it leaves Intel PT
>> alone, and the emergency path must do the same.
>>
>> The race is reachable only through restart paths that call
>> pt_config_start() with TraceEn clear in the software copy.  These were
>> introduced by the commits with the Fixes tags below.  The restart path
>> in the PT PMI handler runs in NMI context, so only a machine check can
>> interrupt it.
>>
>> Fixes: 8e105a1fc2a0 ("perf/x86/intel/pt: Factor out pt_config_start()")
>> Fixes: 25e8920b301c ("perf/x86/intel/pt: Add sampling support")
>> Fixes: 08c7454ceb94 ("perf/x86/intel/pt: Add support for pause / resume")
>> Fixes: 2e17bf3a469a ("perf/x86/intel/pt: Fix stop/start with no update")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/events/intel/pt.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> index 7453e9880b25..8d71c00f9ff6 100644
>> --- a/arch/x86/events/intel/pt.c
>> +++ b/arch/x86/events/intel/pt.c
>> @@ -38,6 +38,8 @@ static struct pt_pmu pt_pmu;
>>  /* Set at shutdown, after which TraceEn must not be set */
>>  static bool pt_shutdown;
>>  
>> +static bool pt_initialized __ro_after_init;
>> +
>>  /*
>>   * Capabilities of Intel PT hardware, such as number of address bits or
>>   * supported output schemes, are cached and exported to userspace as "caps"
>> @@ -1900,6 +1902,12 @@ void cpu_emergency_stop_pt(void)
>>  {
>>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>>  
>> +	if (!pt_initialized)
>> +		return;
>> +
>> +	WRITE_ONCE(pt_shutdown, true);
>> +	pt_shutdown_cpu(NULL);
>> +
>>  	if (pt->handle.event)
>>  		pt_event_stop(pt->handle.event, PERF_EF_UPDATE);
> 
> So in general pmu::stop() is reachable from PTI/NMI context, through
> things like throttling. So arguably it not functioning correctly when
> interleaving with pmu::start() is a problem.
> 

Yes, and it looks like there is a separate fix for the 1st
scenario described in the commit message: write aux_config both
before and after the WRMSR.  I will add that fix next time around,
and re-evaluate how much this patch is still needed.

