Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793643242;
	b=aQHo1yhjOTmbwGPKyBfJPA22o2hMWkIRe7IkocDUvUPbTTe5L9cyCljr2Rr2xGXpxWSk
	 fjalJoZM68O6zlKwXW7tNHnCjcUx6ONk1z33qTJr6i5U6yNTh+MahB2YPQmy/8phWPTW5
	 VGPOjSBSBZMhTyX7hsFKG74N97iik//HMmfHj1a9DrD0M4a6Uo4qTnwhBM/zn3F6Pa9j4
	 zlq5neks6mz2+vduyPhzAah1zd8XMnqqfPxEMgxjluHXgOmcE3WPSVEH/Pb47txeACZCA
	 m/MZ7Fznqd6Af2a1hOWT0haSe+T8aRWWZKReE39irKj5bVyK5CvAb4F95/hD49b3SrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643242;
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
	bh=b/lObaS73x2c6bPNa35r82q1+7jCl25TfF5zce4VZfU=;
	b=RuuzWy107yBKLM400W9px9zL7dP3EwK9TtCHAwyYp9IDPVaQ9xgCqiB/jDKf2eVaEm8j
	 uYwe1qisPNLP8NkjGzlxobmYUEoketuQkJ0P8GH/DBZacIQpbtKrxWis9+l5UBemQ1XkW
	 ro+cF+viM2fp3jg5lD1grHW4gjel96dYqrKnpG2zRB8KgaccubY0ktuJeWSc4GfCJpzur
	 sapezuTBghv5F1Jg2TrWC+dPFY68hxZL33kSehpn7tWiEXCkgv2muACKQCdCmFcTYNvQB
	 QMPHmhlKD5CG3IOvATHLZ1GkNO0+ru0D9k1cbL0qqt/JNF7tDVe6MrJFqTPa+dze3Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aBF5Xefc;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AC606A326;
	Mon,  2 Nov 2026 18:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D09AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aBF5Xefc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793643242; x=1825179242;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uqym6ST47+4J3KzyZIYvz5ySTfqtKj3MboqSGuT6hQs=;
  b=aBF5XefcKrk/bynvrsWRZgEOfkBJMoV2m8xYgJLcyvvy7lpRQCPOQs3O
   3DyK1m0F54bSwd6SlW+OPbJxaboF17Fw5WOejrCn+Jmxda5OZfJfILDai
   D75CT3RkFS1th0DZqvSV/fP5d1NvMHJBlw/CqMyVVR5pGZ6CS1QDZDj0t
   Qor58e4CX9QI3aPIpllmbgluFcuJc7useDe9kkzM063zK0mDRpvI9WzFp
   eLVPmOJ3Yq36QpAYLis69/COTwHggLy02QO+WblZKSqhILZ7rE5Sl2R+t
   SMGTGXskCk2hrhAE20eBe36wCZn0GIGqvOi2KjDV6OSURetk4ouWaPsRO
   Q==;
X-CSE-ConnectionGUID: zDXkuOTvROmEpcvNYHN9FQ==
X-CSE-MsgGUID: 2t0pfUypT5mMVeZiqBAC+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2231309"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2231309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:14:02 -0800
X-CSE-ConnectionGUID: FxhpW6TmTmyk4ZobWCcyJw==
X-CSE-MsgGUID: 3k2murtUT8+v9loSbX7jJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6316103"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:14:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:13:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 10:13:59 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 10:13:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZJSR59cWUjNQt5yBhkPcIT8o37vQoRnhnUtHY3JZiB/JHb+7Bnfi+kcXyeJ4s95o6W038hp90jkDD50PNhspE7dIqHOih6w7Ry27BgIc8sZPDFykDLmsqqpn2XtQTQkJk/niYx4mg15kIKKdW+Kujxpws5XM/fnX0zKB8nKuBSLvqFC23uKBw6uyyWSLlL+Ig1q2XdogY07sEwiPCRTeB0R/owWy7wOSThXu0UOMVp6TBvzZqHV1mue24Hds6NHxRAiU/b+oC2SmyboVft9DwCnJQnksYq0yA06Zs/dERj/bCSvjwsZ8pxQGLEcS8JujtpLQmVJIt2r+a7MCaq93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/lObaS73x2c6bPNa35r82q1+7jCl25TfF5zce4VZfU=;
 b=BPN+Ds/fdGSIsSw0C1nUDUWn0/KVpf+W9boW5CsNjSnDpPiEJYI8Ks37ZwyUa4LCMZEq+baqv82OhUbeFGoAyJLqCcGDlfNLiW7Rr5lTBcYcB4fhUR+kuAceDgYDLk4lejPAxpYVtilIWICwVehZEUEdwko5XX7xRlNJ0Z7io02zveP65tVbXPOl1lG7p92m1p92OCGxUh79o0yRF/orQwLWCRW+t7NsxcdVi7zlTJtYahMfVtBtXrAKt9Ya2fcsx5PtZ0H/GxywhJshNb72RcBa8/u/KksTrKHuAiueiUI3LnqaI/BC8t4v3fy0dJ7WQaJfszxct3exQW4NtxEi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:49 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:49 +0000
Message-ID: <4a950591-fd11-4b93-9c9f-d5724219e7a2@intel.com>
Date: Mon, 2 Nov 2026 20:13:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
To: Andi Kleen <ak@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	"Thomas Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Frederic Weisbecker <frederic@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com> <aui3L0ppW-cBBo1W@tassilo>
 <a2108322-0c88-48e0-a10f-77ae2556bcae@intel.com> <aujMVC0_8purXK5k@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aujMVC0_8purXK5k@tassilo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::14) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d72743e-d2d8-49a9-4b34-08df390d0b33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|5023799004|4143699003|261021135927099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Sy3/ssrZ8ck3WjVASWHJd7ecDq8HuEilCi6Oa6+H8gsLcUcANiawxYUxVLSNPx+u2pDILNOqh1zxlxggFux6iaFBzPB/4mqI8vVnTtqcUwGRNZj+CQ1rZej45e9ydiMBUZ+RPKUOgnyH3LPXI27/lLbyJNqRBJQ7Af81Evc9zn0FpA33NXI4tdpGeIQ4KcOrQyWMTDCNpVy0J4VOpkfabnHJxLOIx3urf+yUoiQTzA64emSbck25+OnE1CNNje5CiYXIjxmhRg7GJJPibqg7HmnMf5F3iKW8RdteGPZV6JIq7U9bVw8BbYCWs+TxuBRbZKmC9XqL5ExzYS0m0VboekuClJcHTniiF15fQCC8tEHmidtica8+qtU1BL728FjLifk8Fv2K8Z3LS5rHYbV8bGO8BrbBhcEBoL6a0KyjqEIXbyhyrfO1xtcbSB1ytnURQJZGDbJmxkdzyixQEvcPqYq2V+vtFiFJ17yqTIk9mrdhxR3Dt5IULyJZ/eFYrk2XeLxLj+HbmKJcxuzBn6vHJYEB4F6/AJgAytSI2zrYlMt6yJ2aRPtnR42ysSRTI7T0qRi08B3ILWy6hlYhHToMtJbqsZc5OyFEO55tow/s3R6t+2DxdctX1KYIOVy2HOsdejMQc3YnbTgbi9NxulNzoDzam8qtZ+YaFjEYd1vR5cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(261021135927099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RVdVFQa3AwUkJXNFpGWWdFc25QMXdOOVJXT2VCZHlmZy9vOU0zRU1LWTcv?=
 =?utf-8?B?enNYb1RsMU9vVE9rei9tOTQxb2RBS04xdXpnMEE2NFFlcGc4TnJ3V2RLSFRo?=
 =?utf-8?B?MHMya25tTjhUMUc5SG10Q1NwUUpXb0NBeHVVLzRaMlBOYWNwb0kvVUdkQ09z?=
 =?utf-8?B?aXpFeWhRYmNSVnFQd015b25ob3pYUDQ0WmFxNEhqemRKYzIxZk1KcFk0ZnZ4?=
 =?utf-8?B?a1lHQ3lwNVRTSGh1bmFaSjhFdGJYd2pudUkyekZBd1V2TE9Hb2E5WnJhS3Vm?=
 =?utf-8?B?UDBwc3FoN29hWmYzaHNZOEJjTXY4K3JST2xiTWk2cTNoTWdvZnF3NVp0c1VE?=
 =?utf-8?B?Y0k3bHZOSE9HSm5Fc3FKZEtIUEV5c0EwR2pxeHovTWlXRDZlOExxaG5WZDVj?=
 =?utf-8?B?enppM01DNzJEckw1SFFKYVdoUUVJYTR0NExtMzNiMkYxWHV4Y0JYTlRHdlJG?=
 =?utf-8?B?cExnYm5mN1c5TjA2djhlRG9DS2pyV1V1YTZXRENyN0g3cTNVa1pGQ3lnQWFu?=
 =?utf-8?B?MzVia1paMGZBNGhrZ2VsRlhPNE41WnE2UGlSTms1U1JEaE5rZThsSnZrVzkr?=
 =?utf-8?B?VlVJU3VEbW9wYk9teDI4MEFJT01yL0RwZU1zcFNrMFU3U0dncG9XTXJGVXor?=
 =?utf-8?B?T2ZXUkk0MHcwWlVJRmNOR0NLZ25lMG5tWWVwWVdueFF0Z1BrcnFnKzkvS3pl?=
 =?utf-8?B?eW1sVXFHWjR0bWZhYVFBeDZ5WWpmbjMvcTgySGsxaVprWnBLcVNKLzBuRDR2?=
 =?utf-8?B?UkJqdUZ1M1NaMnpVMEdFcmJKdzh6Mkw2LzBWQUV3a1l4S0dhZmNDMEtjN1dC?=
 =?utf-8?B?L1kzdnZYUHk0NEowcUI1ZUx1RTBaZXFjNzdWcFpMVjJKVlZ5dndyQm50WDc4?=
 =?utf-8?B?OEE4MWdnc1dVSzgvelNpb1pEUWtmc0RQSmZnemRYSmFqdHduNkpZaU1UaFl0?=
 =?utf-8?B?SmJKRmFXb0ZvZnVFQzZPeFJ3Z294TjJPb0lWUnlZM2NXT21KaHcxSjJzZnlR?=
 =?utf-8?B?NFZRbHV1S1EwZ1RMVEp2R0hlU3Axbzc1SGwrMHRyRjVhS0pMY2MwcElkZlk5?=
 =?utf-8?B?ZnlISzZYRVNlc1E0blc0bis1Wng1Z2ZNUjhaSURwN2M1SlVLV2F1VVdXQUYx?=
 =?utf-8?B?SUQ3VUNGaGkxTHVzMjFjaHlQbkFYejlSaFJnelpnRmdyWjQ2a253cWFlbzJF?=
 =?utf-8?B?MW4yMk1nKzZQTElHeExORGRxeXhMdGtWSnMwNmY5Z0xzUFdLQUFrUHNFN3d2?=
 =?utf-8?B?RWlQb0tiZUo1WERjOGZJUEhOcHI2bFN5M3VZbW1pbHJmMCtzeFBnUTZCKzJR?=
 =?utf-8?B?RzdvUm9oMlJLUVUrN0tMNGZNYkRzU0VaQTlJbWE4enNCMXBoZVU3T1VGSWJM?=
 =?utf-8?B?cldkbGpUZFhIdTBSRzRwMTF4d1RESUM5SmpCWEttSjlwMVlEZkU0dlZ6OHdW?=
 =?utf-8?B?SlNHMkwzbStGeVVoUmVLK2d3Nlk2cjlKY3JramVUZzM5bmZNUGRMamRNQjZh?=
 =?utf-8?B?cEJoQTA3S3diOWpoUmlONzRjYlRpSHJydmJmYmhRTzgyZkkrNW9GRzFQRTVq?=
 =?utf-8?B?SFMyeVo1R0pHcDN4Y0hqbXBGSXJUSit3MmFGV09oV2ZabTlGZCtEanlpeDds?=
 =?utf-8?B?YXF3SFI0WGJhWWtUWWtUZlZINStiWlBudC8rQUN1ZlhvQXVkNUljYmZuM0pL?=
 =?utf-8?B?RzdqWXM0dmp6VVJqRjVJUGtNYll2bTNITXpaR2xsVGVSRE9MTkdZTSsrcits?=
 =?utf-8?B?QjhGWmI2K0N4UFN4dCtuSkVkNzhqK1VXOUdYZ0RoS3A1UW5NVE1HazcvV0lm?=
 =?utf-8?B?YzlIS2l5OEJ2UndmWFh0TXlkTENzQkNIZHR0WlBWcSsvSXRYTm5qUTN6b0xK?=
 =?utf-8?B?d1dCcGhKelc4SlU5bGpPVjZEajU0NVBDNlk5U3pYblhpeXVIbXZUT09LS1Bn?=
 =?utf-8?B?bUlqeit5VUdEbld6bkhwcEI1bWhId3JjVnl5eFR2MzhlZUFLTndBS29kaDA5?=
 =?utf-8?B?ZUVpZVFYNmZQSkxjS1VoS2J2bjdUd1BucEg0ZWlxc3JVVEdPWU9Ka2RRMm9E?=
 =?utf-8?B?Tk5zMlNnVFdCbWRiNHY3a1Z4TmhyM0VtZzlMUE9SUWE0eHBtWXVUdFUrQlNo?=
 =?utf-8?B?L3lmUCtOZ1ZZQi9nOXRScEdFNXExWExGUDdVNFNneFM1clM4M1M3NVBRRDlm?=
 =?utf-8?B?cjR3akpreXM4eCtIRi9hbUxCYzBDY3RmdzRBUDdiSVgwNnJUTDVJMlJGK2dw?=
 =?utf-8?B?anZzQzArV1Mxd0h5OWJISUpKU05HdTlkTmc5cXB1SXRrNnppQlRCRWxhQ3lp?=
 =?utf-8?B?cldqYnBUNVBTYk9uUkdaR042Tk0rODRhaU1KcTk1aVh1RVlXRVNLbEJ0NlJp?=
 =?utf-8?Q?z/uRp0jWaHk6Pnog=3D?=
X-Exchange-RoutingPolicyChecked: 13SnKK3918zw54IP1lQ/IOq+G5AmCZL0+IKuZ0vwDG/0WuU7ihsedxEPF+7s+lNom2ZJmQI8KYQA6tr/VrOQIhntF93mL17AJtmBvviHp2LvDw14HxeDOm8nu+qlq4K1XOZc+PTXTrtXYxPr8YTtXRG9qsOfjlSkgncjua1om4PXtoXK+XbGxwjpcEs7vx+8JSbyO6HDQBrY1c89/UKR9gHF9hZ8uf5mjmqbGJEQTOczyKOz7LxIQe8mumTU7ZUTi18mjAikyOQSAAbA+CSkkR/8rmrvunG+gIF5gbKuHsKQ0DC5Oy6FngEG6QhQQkdbBgwRH9FXv+NJmSLlQPMdBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d72743e-d2d8-49a9-4b34-08df390d0b33
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:13:49.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvwPJb3gYUj+sTnfqFaV1pP6QqSNg2JRJgIdb7sfl9TPg2oChKvxw0tBSaZSqq7TrvmbXkJ9FGTAGRNyAMUohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

On 02/11/2026 19:45, Andi Kleen wrote:
> On Mon, Nov 02, 2026 at 06:27:30PM +0200, Adrian Hunter wrote:
>> On 02/11/2026 18:15, Andi Kleen wrote:
>>>> +
>>>> +/*
>>>> + * Tracing must not continue into a kexec'ed kernel, which may reuse the
>>>> + * trace buffer memory, so stop tracing on all CPUs and prevent it from
>>>> + * being started again. Events are left in place, but record nothing more.
>>>> + */
>>>> +static void pt_syscore_shutdown(void *data)
>>>> +{
>>>> +	WRITE_ONCE(pt_shutdown, true);
>>>> +	on_each_cpu(pt_shutdown_cpu, NULL, 1);
>>>
>>> I don't think adding more and more broadcast NMIs to the panic path 
>>> is a good idea. It's always a very big hammer and a risky operation
>>> that risks breaking the actual dump. panic reallhy needs to be
>>> simple and reliable, and this is the total opposite.
>>
>> Is pt_syscore_shutdown() called on a panic path?  I can't find a way.
> 
> It's called from kexec which can be called from panic.

Normal kexec goes via kernel_kexec(), which calls syscore_shutdown().

Panic has its own path to machine_kexec(): __crash_kexec() -> 
machine_crash_shutdown() -> machine_kexec(), which doesn't call
syscore_shutdown().  On that path PT is already stopped by
cpu_emergency_stop_pt().

