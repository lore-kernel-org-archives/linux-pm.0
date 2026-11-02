Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793617514;
	b=b6Y0ECYcBk8Bx+HsImFfX44e2BWmAoo8jxe/s+MHN0KcKeJKVC5LnbsNT37ykQBxxFHn
	 QxGo+nlGBpC4q00OiZ5sTwC3vvTpBrVLprKwkixC3rj7yv3knS8eEJuXY0hhUPKMXK54d
	 Gh4/QXfy5EFZD4WSbHSccTbJk6FUXDgJUAR3NU/aG4sNslEkQ0BKvh56wF4OBCb/RrHZd
	 NeAo9xzgq64RwXN1yMqkrvfR+k6YInyJpPvf6rsgnLciqpjAkMuJk5UHYb5SvDGHyiUuL
	 lDpMhWtGdSrnkJUWI0v7jOd8pfqOSbgLsmO8XdfqaEI+39NFUvHGGkL+qitsStfCcyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617514;
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
	bh=sPv+Fq9xSeR/EL9qzZCHKs9nO0+ro1mx6CtWZphfk0s=;
	b=0gO7C1LUJHbHhIWhXa6qjFk+4tb+mMm9S8OtdBPIAxsbGywCgETvrYKqL+i3SdDD8tqp
	 ecyZr/bynzRFrkgfZrQ85wOXvEoCGLsxlDIhrKiLJLo1WelCfZ6F4JcA13gcXrWBsZyBA
	 qyr5KHboZCFt7Ms0Ws/Cul9gO8nW+45Yi2kHVz7xnf6uKN7BQ+pqofA6WDGi9UAxBTaUy
	 8Gc9gqyJj3l5ZPcstIpaXQhbcgBj9ef22qAu96aYViRsjEPm3REnYjL/bmrQ9ixgx6Sl5
	 B9pUhBvnGqq08PgUJEtUVj+KGDhP9/N8tOFWykkTbY9ZqOZGy4AudJYYdzIiFM0ekuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9o4bgxi;
	arc=fail smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913E606A324;
	Mon,  2 Nov 2026 11:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3913E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9o4bgxi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793617514; x=1825153514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2MfgLxj3103UkJw08BxDyrlbpQd6kZ8oUezU/ojqKJc=;
  b=b9o4bgxiHSSE7W8XtldZopJuCW/JPOHIiFxbOBpvXO5JPHisWLr8cPBo
   c7HrVoVq48XUKPCAtEsujEJFYUvV6Cjq+2NZp2Jv55VOS6u+qhDdMAnep
   +l0zE4ParBaf1qiDuUw4BEwDXR+oc41FRR00R3CsjxpppOacT2ZS069YI
   tBYxbnWKB6ptD49DZnttuICIXkdsQuNohwAsTykJyf5AcoxtcRcqXQLzE
   ePOAEhq8i9OOqqeD67klrfr88FmIr6dUcZxd3H4Qs8IPZQYJFU6/EO4BF
   XifTdISFbRMOP1MOF+Iq9wnsh5M/QXDEy5NjI1YMHuvDwakuEeSjdcLra
   w==;
X-CSE-ConnectionGUID: azmQR4vDSRu9E052SRIqcQ==
X-CSE-MsgGUID: /bKI66KZQ5iLtD0kxHvz0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2317653"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2317653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 03:05:12 -0800
X-CSE-ConnectionGUID: x46CsoN7Q568/OLwj370Zw==
X-CSE-MsgGUID: 6w1SEcJkTrOOpmr+tPJ7Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6264985"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 03:05:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:05:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 03:05:10 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:05:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOcCAyD1JVK51jBCw51ZdlfXQHIK2SSyWzpZdxgx1rpIYg0QW5XtRbjK8CMCsZAK/ZDZNEDIrIOcMqTn0au2dSNOK9+KuyPlTlGPSwBGmyjqUqYSYr9YH5ohv6khi9U4GlvgFmsonbXjNmw60xdgR6Xqfjv7u1DDRVFVXH8xBoEHo5SwU5i4fh7zvzP4U7JhpCv719rcvQKTfkowzCxh9FfZYId+w7KElKa+b4P5s15UTn1n1FDFfKGV+O0ct0TsbeiEijLSHkC/MDVYp8qydB8GFuIUiVeHi3YQn6jASnMn080d8vlKms/EoIYjLRU7s2Ila/qPR6/NkMJdt66XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPv+Fq9xSeR/EL9qzZCHKs9nO0+ro1mx6CtWZphfk0s=;
 b=QjJV8Lz8d2ZgCn+wnAWn15s/9Lt78aiQVWOBgZoDk5fIIH+YTuSq6FAh05KJxUpwRs1juTfscWMFTdIGiHgL4E2rSJ/W69CdrPTzGVrHgiwL7l65gG7vs0+fvAkfTOVL0teQW0RRcGIWeFUDpTtjg19itC6P4FoJV9pJh/oS6soS9gOqJyJBQv6MZ3CcLmWsAfs7RYjhN1mWdwospkOPc3qOY5yPOPLzZNNnXhr2XZIaLh2cMtdQYbI6Wo42y+93GHRKQ9HoZhZ23Vn5taHANtBL043wqEkRLsxNTPvXXUsb9DkT3Nj6/q0HmI3xSw0Ffm4I68xqxWGLcQD5D2gfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:05:06 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:05:06 +0000
Message-ID: <ca44daab-662e-41bf-b050-3ff4a94c7948@intel.com>
Date: Mon, 2 Nov 2026 13:04:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf/x86/intel/pt: Stop tracing if VMXON has not yet
 happened
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
 <20261102074039.26983-3-adrian.hunter@intel.com>
 <20261102095750.GS1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102095750.GS1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::13) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9de441-94ef-4566-75ff-08df38d12702
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3qeYJ0tpQsvdWG+9OIy1elPYjMjIQWL1Jla+MmBFUpv19cldCLJ286swtuNuxFFsLFleoxc2Z4ADjQu2FNVua9wZVZNQC+6gphdDGLy6h6lHVbJCBgsyfjpHqBFt0s9qTxfa2A0BScOgzpgC7x3PjyLlsTk3tOFZP++n2alDl46d0Ht7g185lwB0FQwCz2+KmFmaXfu+bFkUS6eO5KizPxEh4yMMNkKCNtk3Co+8bgHLucb8odEoktPcQwNFn0PRYKUvS8vJvA1mPfiCnKGD0Hwe2M+vw/Ei2rqN9riNliNgexF3wJkhutR29xwzbnYpBjrUPFRomK+MsGm+Vwa0glw7jCz7hcDIW6jN6dARFyGy+swBv/A5uAH8UUFH3oHl//AokkuYszwu9KkFBO9pmQumVryXv0WjhF1XL1pc/ws2ay8Y7TSq7pCT0Z/tmx2TpN41FDUtmSNNfyUMBOjOg+AhuOnh1njBOg7X48iS/nc0DFL6wyyTO3fuSumquL7O6rb+VBHKF7G0+wdeyG3pUnTyJ4/yWkoU4EkBU852qkjqmEArqW9tvSOxEuyV84gtARn2Pm9aBDhcS/gBIq8MONwqfa5LHtm+KsjCL5Yn236oN5w7CJZEjYrhg0lCaa6ozW6DPLOlaXoogZF1yrERRbeOtBVi2LyMvWOd13OR2BI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpmbUFkVnNDUlBRT3IrR2tVY013Rml5MFhrUE95SWxwUUhnZWpRTXBiaXVP?=
 =?utf-8?B?eGtBUVV2dG5qNnpXL29Wc0dCM0hMakI4UTBNczVYY3g4QVVNVXdLTU0vR3hv?=
 =?utf-8?B?R0o0ZnNyWmJZZVVPRDcrRDhTZUFxVDRCampjamV2UTF1WlhoYUxlZVMyUXY0?=
 =?utf-8?B?NURPRnJMbTNTSTVsOTJOaWNDU0NkT0h4TERweFcxMnQwYXpzZWNWeVcrblRG?=
 =?utf-8?B?NW9ndjNkRmlxM1JKL3EzOHhpZ1ZxTWRiWjhkMGIvWEdvYWwvSnBJY1JXZjFC?=
 =?utf-8?B?Q2xiOEExajlKTGw5QW5VLzdCZlpUUGtzSEdqOW9QNUdKb2ZnMnVsdjM3anlu?=
 =?utf-8?B?VTV1b2VUdTFDR1UxMEo2QU1vQXlmcjlKT29xdjBGMzM3clNmS2MrNXR3Qngz?=
 =?utf-8?B?K29ZbW9pQTFlVVNCcFV1WURTLzJhQUVzZFFscmIybldlbVFEZFJrS1JlY0tx?=
 =?utf-8?B?SXN6SkZsT2hXMGlRRGxYdkZBREhtKzMyLzVIK1MzRDNrRWlRWXUzN1JnaVB2?=
 =?utf-8?B?aVJCeXMzdHdvaVlucE4yNUh0MVA0OHFEdmdQVDh1ZlhzeWZubVRJKytYdlc3?=
 =?utf-8?B?dktPZ1ZJNU1pTEI3VzQ5QXBXd3pzLzhWVktteE5ZaWpleHJ0N3NlVkZ3a2th?=
 =?utf-8?B?bXFsY25EcjJaRDRmd2pSMDk3K1RKWTR5aVFHUVk1bFJiUmIzYmt6MmtCdjlq?=
 =?utf-8?B?YnpkT0QwcklyOVgvMUQ5eitnMWo2MllsZ2NkRm5HeGZWQm84dlVFNVNNYlBq?=
 =?utf-8?B?OXpHRk9va1NyMzVINVIzejV1eExOdS9iTW5zNnE2SVMzWDc1Vjc5UFI1RFpu?=
 =?utf-8?B?OEZkSUJMZVhWZDFqb1lld3c2bEovanF2WFBFOEc3ZlNkRmJwQ0N5SExuUmFm?=
 =?utf-8?B?V0ZrTFoyVGRidWVsR1E2WmlYdmtUY1BnVjd0bFJuZjA0WHI5aDhVMmZXTWFZ?=
 =?utf-8?B?NmdRbTBxNnQzM2RlbnFZZWl1UjBmLzNONDBZV2plb0xiQ2JycnlPbk9jbXRo?=
 =?utf-8?B?bWtGdDJmVWJQY1dzVm5Nb21kRFZXajBDOERGeXFxakFGVldsK2IyQkQySGcy?=
 =?utf-8?B?MllXVlR0VE9NbCttQmVSaUp5THB4SkNlbGwvM2ZwQmZEWm85eUs3MDdWUlNo?=
 =?utf-8?B?OWVQaUNOSjZZSTBnWk13bkJJYXpKMjRYbmRnUUFwdkpWZ2sybGt1akRXS2k2?=
 =?utf-8?B?VEd4YVN2SVc4YXl5RWFRU0ozakVFKzZVemZTMjBPaEVmZWxNUWNDODZyR0wy?=
 =?utf-8?B?OEtXTERFcCswczRPSy9MSkFORWxiMVNHdWJqUlhVeStGZXdsUWUzdDhZeHk4?=
 =?utf-8?B?ZDNuS3hCRVhZNWFCaTY0cnpCYWNZQUoxN0c5OVZyRmNLQ3ZJOUM5MjdxRUNT?=
 =?utf-8?B?QmR4OEpWdndkMVh0VytVVmJaZFRWS1c0SzYzZHlscnl4TDhDN1JBOVU1U052?=
 =?utf-8?B?MlVkQzQwRTJPNmFyQ2NVUUc1dmFqOUVLdUpPZVBoRmNmL04rOVIvb1A0R1dQ?=
 =?utf-8?B?MG9PNURib241V3lRdGlaZTN6dVg2YzB6b21jdDl1d0FHMTdZZUVXQUxSU1g2?=
 =?utf-8?B?T2Z2QmpWQ3EybjhPQVQrb01hY2VINjBsaHRwbERuUnFwQmJRZUR3QnVuNnFB?=
 =?utf-8?B?dFdRQkVaa09wU0hnNXpPMys2VHR2bitTbWVrSk81MWtjTS9UbTVsQkc5MU9L?=
 =?utf-8?B?SEFpK2ZhZTk4OEpzem1iYzZrQkZKZURmY3Zab0xXNUhvMjFjcUNIY0c4MFpO?=
 =?utf-8?B?NkJjQjg2RGZud1RFVDlyUzZrMkdVV05odW4raDl1Q2R5eW8yMWxmNHNxRmF1?=
 =?utf-8?B?Z200d2dPdExhTkZNL3dZUCtqTWc1RnM4dzJhbjZPaEExWWVwT2xVdmNmTGVZ?=
 =?utf-8?B?T0NpN3BQL0MvUmw4ekpkUWxYWllMOWsxcDNPM21IUDhtUFJZcEF6Ry9QR2xj?=
 =?utf-8?B?N3JXNGRib2k3R1hSeHhmY3JBcEZYbkNWYXVJZTIvbWtKbEJUazJjSmxJWElP?=
 =?utf-8?B?VmtMaWo3OERtbjFOemM5LzJONHZ0UFp6eStDYzY0cmt6ZlI3WUo3R2hsL0xu?=
 =?utf-8?B?eG82SkdUemU1SkNPUXpHYUcvWE13Vy9DRnk0aVdqcXZ5Tkt2RHk5N3krMS9W?=
 =?utf-8?B?UHVlSGdvcWtFcno4bjg4YTExVWNRUE43NjZ2RERZVU16bGNPam8rVDBXT2dp?=
 =?utf-8?B?anpadTVuVTAvUnNOMUtoQUxFT3F3V1V2OFA4UlZhWSs2SncxM0VqYStiQ1BS?=
 =?utf-8?B?TmRpYThlNmRTc3VocFRuclMyS1FmeS9uZ24za2oyTmVZZGlUWFN1MGhYMkRM?=
 =?utf-8?B?N3RKR1Vrc0crUE5jSEoyTDlPV3g1YTN5UVNMeEdyOTJ4VEM5VTJDbVJQNDFT?=
 =?utf-8?Q?53iEdi6WnEt7iieo=3D?=
X-Exchange-RoutingPolicyChecked: 1W0v0jhLoe7Ri9r/Zq6WX/bnAWWgy5u+VLYUPuuTzLDOXylSgRRVpHLmtuq6wjR5Y4Yf6XWaQSAwoT0Q5LTBFSeuPE7Dm74UCbQWDwy8mWXW4d4gAD9CtEqVp6UAMU4sUr9kmSdLjKt5cxbnkUTj7d9vzHBKLU0c5eXueOMc2SBfiDdNaBtY2GLP9N58t64/kRThykYqaxn25YAMQ3Zb4NkST+CcixcgZ383j4DGYR9+74SeQpwlOn8SvUFKn7F+UD9vo+yqsnN871NNMgj+XaFvh17CEVr9IpimzGjJfwSzvK8tfyC01g71EJnoMpvoK01L1XSOAaPtyspalDUnog==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9de441-94ef-4566-75ff-08df38d12702
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:05:06.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jxi8WDvwvo6lP/4ie7ilpT/gAj2xhWMI/0S9xXPUnNL4aQ/oRvqPaAJR87WgFLP7ewGkp0zdw8nM6x3B+/oAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com

On 02/11/2026 11:57, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 09:40:35AM +0200, Adrian Hunter wrote:
> 
>>  arch/x86/events/intel/pt.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> index 49349afee611..36bf039668d7 100644
>> --- a/arch/x86/events/intel/pt.c
>> +++ b/arch/x86/events/intel/pt.c
>> @@ -567,6 +567,15 @@ static void pt_config(struct perf_event *event)
>>  	pt_config_enable(event);
>>  }
>>  
>> +static bool pt_trace_enabled(void)
>> +{
>> +	u64 ctl;
>> +
>> +	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
>> +
>> +	return ctl & RTIT_CTL_TRACEEN;
>> +}
>> +
>>  static void pt_config_stop(struct perf_event *event)
>>  {
>>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>> @@ -577,7 +586,12 @@ static void pt_config_stop(struct perf_event *event)
>>  		return;
>>  
>>  	ctl &= ~RTIT_CTL_TRACEEN;
>> -	if (!READ_ONCE(pt->vmx_on))
>> +	/*
>> +	 * vmx_on is set before VMXON, so tracing may not have stopped yet.
>> +	 * RTIT_CTL can be written until VMXON, and after VMXON TraceEn is
>> +	 * clear, so still write RTIT_CTL if TraceEn is set.
>> +	 */
>> +	if (!READ_ONCE(pt->vmx_on) || pt_trace_enabled())
>>  		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
>>  
>>  	WRITE_ONCE(event->hw.aux_config, ctl);
> 
> It seems rather unfortunate to issue a RDMSR for state we fully control.
> Surely we can track this?

The RDMSR only happens on BDW and only when VMX is on and someone still
tries to use Intel PT (even though no trace can be produced on BDW
while VMX is on).

There is a window between setting vmx_on and clearing TRACEEN.  Dealing
with that would be complicated, compared with reading the MSR.

