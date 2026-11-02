Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793622142;
	b=h8wg1mMF4hbkh4aFBIoPBL09gV3V/pHIY0Oab5fAmvLMeTVq+AZlXL0DP4f9uh4MB4Tr
	 nMpoNV96ZKVv+jrr7f+2YV4RkmW+zfdofQSmda6TOEzVuIFx0lB/Y6w9QXjTSuwXVOpTV
	 AYuIrJNN5hO4IWu5JF3SyrUvu3F0DmkF4yRLCOq75egbjOJMVi/iKa7cyZjun4qzvo/MA
	 eaeUVOEl3fVSSl+3Q1lXYuxYm6AMnVF0cPp6JoPaIsaNw3bIHee1iZ7PY5LvsNwDuN2xd
	 /sfrcfCygY7vJqadjvbQHf9g1Aw/fQLiPzeRlneU9mrz/FMV0f7kruqDl8ts4f0wBQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622142;
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
	bh=3KXsctB09rV/44s0Xo6w8GjIhX67hZ8Mjw08r4bobi0=;
	b=LAzRIeyDce2I30EFO1iYISrV9grajNd7mWqOGWEDLdCs42bPvNWivgeYdGGf2i0UWyZc
	 gBr0rRzB6v5qIXaTu31fSO+8LYSIsPVV7Tc6jLSGJ5tlmBRXeVXow7L6153TmB/m+qNl8
	 egD8jl2WWq/Os2w7EIqpZPCI7e2FLw61QpJO17AMzKFae49SYK6ec483UoQNbnwwsoSBP
	 ixX2GlBtEkcjhNeVkzURntP/Gv0G6Mj7z3iiwDHCf28RuvhKzmyZwh1Zg4Cx+7iRXb8KB
	 QUJust8qqsXOIuLv5h699I4AWdMqhF3cfuydCX34FcckpQBghgnxyPoWCFBztcfc0LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BqvUPsKf;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878F606AA28;
	Mon,  2 Nov 2026 12:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2878F606AA28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BqvUPsKf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793622142; x=1825158142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RoQ9YaIi+TX81Rta9PdBXbHMEVBFZtXmgAqiR5ZVAY=;
  b=BqvUPsKf5jjV3WCUuB45Iabh6+TmRIIbDVgZZDM2F7g+En4dw1LOH5Vi
   8wqwF+9nhzvTjqHB2+PRpqXmE+v2yPn0fa5ygENCWvYpt4N7V5yNXOF70
   /Cc8gRY+VAuvCYrxpz7QHqi6RqJwIlwuNi9aYkUypkVhhQktk/M/Nhq3r
   KN3XZdDRPUXmGFwzNLP+X01sccL45IEsUsUViCmDfLE0baU2RYFNiM6u/
   CPN+m2e+P5LQ9uSCMhX3slbTBfu0uUjrzLWm02TzDEBuhG4fdLCm91ge3
   UfJUap81ZonfymA7evkuND/3HqCwoe03anCGJHt1qC9Rj7Wfz0bVdz+ZH
   A==;
X-CSE-ConnectionGUID: noOqjmOFRVCwNQ5QkLKcGA==
X-CSE-MsgGUID: aQ92u+xIQP6BFY5b3ZUJUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2320899"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2320899"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:22:21 -0800
X-CSE-ConnectionGUID: 5XcW6hdrR52lGG8KZZ+oyw==
X-CSE-MsgGUID: MamO74EVQ3SeFhjJoyK3Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7883932"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 04:22:20 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 04:22:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 04:22:19 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 04:22:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjDVGe806TzzzMkchmTCs/nVenk1/mdbTJA+Jc42+cf+yIlRvcaCZKEw8yf4PIJh2XEVnpJgfOilYI8zDTeWPhpug4P3lmzDgFQHd52oEE6WpfQlycgHdeHbyp+zoJZiLkpHSb8NZqxsdkpJ9LEZMAxsTZr4yFY/sBmeL/3oxFW4WVcMgvCI4pdd997yluinO/0A0b6fOnqgnwe5wR0/NU9SMoOPn2BUpRe6lOK+4CgnMX92FTS5t8m/okuSS1kwwH9qssV5KNZoHWLDdPm+n1YoB5aPUhdJsPGEFe3xNDr1biGHSYKYmPzOXfhPq/gaPEKJWk/RXKbgAmyJ0Qn2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KXsctB09rV/44s0Xo6w8GjIhX67hZ8Mjw08r4bobi0=;
 b=cE6GYE3nLIVijcm/1raQLXJdiWhm2Z7DnVN9+6OV0mTSEAsnKz6u/dHjsXK7LRtXCirYj5FNK0DLEBBpxQnnnuXaEudEtNaBjjy/XwzzSnWZRYY6uOlwd01cZ25j1ZLcr7RaBGEzWnhSDSutrpmOUraXIIWzj/1pzO0mIdlPcb9lY3LZXiPxg8EOz7E4kUMGL7FUO9JnffIm6q9DnPVy+RbPANaG6vRRW959rA3G9PEpTcuhrEv0Gn2N2gq5FNkhDfWLRKUsd6LmT6G6rj/D8ONrQ2xjnpnhQAsHtuzifYok3we9FkuUX1ro9vRTe0qTH6wOBT0nXa8WR8tmMyTm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DSM1PF4FC338516.namprd11.prod.outlook.com (2603:10b6:f:fc02::147) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:22:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:22:11 +0000
Message-ID: <3ec2f0ca-924c-4d25-8800-52dc8deaeeb3@intel.com>
Date: Mon, 2 Nov 2026 14:22:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] perf/x86/intel/pt: Fix tracing across kexec, kdump
 and suspend
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
 <20261102101034.GV1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102101034.GV1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0158.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::13) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DSM1PF4FC338516:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb64b8d-da34-4115-b41f-08df38dbeb5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|4143699003|56012099006|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GSp33bOjQedINuNvIjdKcqUD+FNCRND8queT33fyiX6aerEDsMV+ywkq5kVdkokCqCaOAvY39RdKSEpOPzXee4f6ngVMxz9L2Sq+/q93RlSyRtFwirEAX7yAeVtf95kLsgjCMmWEvH+hXS9vOE1VUifl6ZagyGI5aI+kDWFF3HMR6lYPwuSUu7lH1IQ5C6Tykyl8fZlqI0UId9mlY8SZ2DN9cyvn4+qrhuTm3nbVBimxlXOyYeiotwIPrLACkKJKKyOy067wN9L2VD0IPCUsbsOq30Zr+nZT47fTSI83vF/rN1a5T2zxy8Rd2hx2VMsNxTXvgbk18JGjLe0pWMdphYDX3Cs3Bu8VnMfCllMpqXHIPRwZbMvHxYRjlhTvIh9DbmiwOm6L9aAbYWUfmMeRe61w+B5XLlpPGnVAGuQSi15nR66M09NcsYSnZO0vZONcYOmYf1DYZhQ4VLeD8cF1ykNpEPAUjGak7pnvplrlKqS2W7IHY/Awwi9dRxcndfDD45kfJQvBeIHf74DcHNi+cJVsJvn9zk2ntmP2//NpdpRE1JzwjC+v9wvi2qYHoCSZJ161mEdBwGIjpL2nlQQ3Yokvqje6PU40lHA94LGvpoXnY2Nhc1Dpqx6k7+RFjkHYifVv6/0qkp8arVMmhvsSgQ0XlI2Lt3aEq3JKRXfmZPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXQ3eGo1RmdSL1hwSFJJcHlJM3kzZlpTVndWWFNaL2xhRzByUVpOQU5aYzBn?=
 =?utf-8?B?WmJVc0dnRm5IQldVem1HNEFHTU5DSS84cFA2TWcyNFpkU2puR2x1MjNHMHc2?=
 =?utf-8?B?SDBKdVp5blorbUhnazQreDc3Z21wZXZLTVN2M0dXTUUrTnc5TS9rRnllcnVl?=
 =?utf-8?B?dEMrU2NrWlY1WDFsUmtZNktoby85UnAramUwOXdDZGFGQU80c01Bbkl1dCtR?=
 =?utf-8?B?K2F4Kzk4dmRPcURGUFdvemx4QldVbTdUUlBaMk5teUxEUG5waEEvTlMyOGM5?=
 =?utf-8?B?K0ljWEdDQzUwamwyNkJVMjhSbXo0ZDVxR29FcEJaMW5kS0l5UXpVWDZCU3M0?=
 =?utf-8?B?TnBiRW1TbG1Ea08zaWJlZFRRSkxJMFhnNnVLaUU4SWxRcEt2MExkbnkyTkUv?=
 =?utf-8?B?UE1YWk9NT0VET2QvS3lTZ0kwZVFNQjNOaE9qbVFsUFFKajVOdktkUUROQVNF?=
 =?utf-8?B?WnJqSDJoUUhHODBDWGlwL2QrR2J6R252NDZQMFdZSDRJQzRIT211dDIrYSt1?=
 =?utf-8?B?UnhWelVPazl2c0NvTUpkVkl0dTJjcDROTHBwTlJQU3BIbmd4OExXYjhBakNT?=
 =?utf-8?B?RElDdVoyNWE0a203WFRGN1hicmdvMXpJOGc5dXNka2JyNHdZMTZicWxTcmdl?=
 =?utf-8?B?V2l1cmZzS0dBQmwybTZmMnVHa0tEclp0THM1QnZseE9Ga0MwM1JPQW8yWTRF?=
 =?utf-8?B?aUFrQ2pXbm4rdjdHa2Jka0RhaTJvU0RKN2l1SENZRzBxMEFUd3FadEF4Kzc1?=
 =?utf-8?B?eXlJblEra3V2azJYaXFLMHdDQTM0M1JyejRKVGg2K3pNbjJNSUpKTE1OdXJv?=
 =?utf-8?B?b3d6V1RnM0xWdk95VFpOc3dMbGxsUE9oMWN4cTJQVFY3NmpvK0htWU1tOFMw?=
 =?utf-8?B?bk1ncy9HYjluYjJhZVROZHA0VDFFbzF1TWdvR21iMjNQUlM3cjU3c0p1aGF4?=
 =?utf-8?B?K2ZOQVIyV3drTVpNQkFMVXl4TkhvWGxxZjNSeU95ZXMybnVUODlnREFoSnho?=
 =?utf-8?B?amdxNW94aUNiemcyWVZQQTVVeTFnUFFvYzNMT1Z1M0VQb0NiS3lyMXpPZ3dL?=
 =?utf-8?B?VEJEbWh2a0hGcXlNcnVZL2lzUlhXbXZPN3hzM21uM05oVnhqQUJJaUV0M2lU?=
 =?utf-8?B?OEhlbW5DTS8xUjdoSlc4WlQzaXpiVFNSZ0RVRHFjTXhIK21JSmZwSXAwUlhv?=
 =?utf-8?B?ZTFhMHU2cTVOQmQ3S045bDZ2UkZiVFhvaTFQRk1Fazl0bUtFNGpUWVZpZnRN?=
 =?utf-8?B?SWd4YTIrakMyWXpTanVPdTN3eUdDWmg5TVNBbTY4S0QvcFprZlZyVHk3bkJh?=
 =?utf-8?B?K0dkSERQZHZ1TjJhSEZDMnduSnVyelMzU1FUanE2TmVqOSt6aUlXenlNOWxV?=
 =?utf-8?B?U2J0aEExOElrZ3R0S3V4RnZxcVpuakJWaStVNC9EQTBxWTNCU2pUVkVaMDFI?=
 =?utf-8?B?MnZlQW5HNGc5Zy9tZXhaUlN5WjVrZ1cxY1JZd01Vb08zQmYxNlAvTkExL3dT?=
 =?utf-8?B?QkFxY2xCeGpGOWlKWDNZTzJCdWZFdnExYytibjRoZUZkUEdJNjdXTmJQa2FV?=
 =?utf-8?B?TUVPNW5yRnorZ3lRbnRFUFYxSzNqSVNZQll3a1hEYUVsbXhKa0hna2YwZndV?=
 =?utf-8?B?WXZDZDhrL09PNjRQVU5KbjVtbndnY0U3Ni9NMUMvQStHdGFUYWRUV0ltY3li?=
 =?utf-8?B?bE9BZlJzQ1Vjd1BhaWFST2xVaEc4RDhwakFEVHpKdG1CcHUrdDUrSll6VkJX?=
 =?utf-8?B?N1VUUUZOd2FmTzNsT2IyN0s4WndEUS94SDU3NUg3c0VDN0hRQllIN3h2VlR4?=
 =?utf-8?B?UkNmSFdIUmRKUXJGZHBkK3JReGxsRitqWnFLMzYzN1NuVmNFcTAybUNtVVhv?=
 =?utf-8?B?Y2xkdXNycGlkeml2bU1KbGVQcTI1eXNKTGdmaXRUdUhsVmw4TVk2MlkwR2Nz?=
 =?utf-8?B?UTFONWl2b0EzY2hMQTJPSjRaSE9TOEc4dWd5ZCtMejNqQkwyNXdtRTVhWFkx?=
 =?utf-8?B?dSt4dTFUQ2tFNWdOQ2wyclJqOHB5Q0FuZTN4bkd0eTkySmlONkZ4TFA1c3NR?=
 =?utf-8?B?aHl6czc0M0x5QVJpSStuK2tUbnFhUFgrb3VtWDdSbUw3d2lEamM1bUN2bXJM?=
 =?utf-8?B?RU9hR0g3a3IyUGZjYjR1OXlHY3B6MFZCQy96YmZlTFg0ZEFIZW1wV1N4RTI1?=
 =?utf-8?B?akJMNkNiSGhkK2duU0p0ZWNMV3lMYXlxY09Sc0toSjBIanh6cWwxbUgrUDZO?=
 =?utf-8?B?WEIzZjZldlYxaVZOSUJyQnlZcjZCbHpWbWFPcVpTKzhsKzBSVE0wcFBkREMw?=
 =?utf-8?B?YTg0cVhVVHNNRnUxamFrbXZZVFNkY3grQVkwRlZQY3dQaDd5V1BwNFhOdmIz?=
 =?utf-8?Q?mOu0CgJ9zfaGejmY=3D?=
X-Exchange-RoutingPolicyChecked: yPgvLVwy0y5JnsyUXq8n2rUXTN7j3J7Vv/QuF359/OsOeyYaIzwgQWE/AU+RxrkluOn4drf2kGz5E/VAY8SBKkx337TnWzzZXKd4EKLzJKAZxNGg7LJRzMAfrpaopKU4YX5z3BQ0CgEh8+pd8bFvkGo/kSUOvAJrWuJHES9KOUdPuc4LVHlEqXdgjwhZrwJ6Lsazr1Amqf6OYek4YYpnkdqRRl0EbdUeVqFoqo6ijPQ3xnbOtoThlwZ+ELm68wA8dTveYXjB8Jz6BmLPAOB8FyuzxKElwF1T03w6/oI8bTtvO4U9a+/2Ijj9DGlqoWT6wOwhP6Bf3d8unIn/RPtCjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb64b8d-da34-4115-b41f-08df38dbeb5f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:22:10.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKBoY3DCr1ir9vIdcRvTuUzZVOyMixA6Fur0QcD2yNMjg+gLj30rPFTVNIe2cfGKEy5FENalI1IznYBvkWvQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF4FC338516
X-OriginatorOrg: intel.com

On 02/11/2026 12:10, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 09:40:33AM +0200, Adrian Hunter wrote:
>> Hi
>>
>> Intel PT writes trace data directly to physical memory, so tracing must
>> be stopped whenever the trace buffers or the hardware state describing
>> them can no longer be relied on.  This series fixes several cases where
>> that does not currently happen:
> 
> Same is true for PEBS, no? I also saw that AMD/IBS is already

Yes, PEBS and BTS

> registering a syscore handler.
> 
> Perhaps it should be a perf wide thing, than than having individual bits
> and pieces do their own thing?

As mentioned in the cover letter, perf core could schedule out/in for
syscore suspend/resume, and that would negate the need for "[PATCH 6/6]
perf/x86/intel/pt: Stop tracing across system suspend"

perf core could handle shutdown too, but it also needs to consider how
to stop events from starting again.

If that were done, that would mean the syscore ->shutdown() in
"[PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown"
would not be needed, but the other code would move to "[PATCH 4/6]
perf/x86/intel/pt: Clear TraceEn in hardware in cpu_emergency_stop_pt()".

