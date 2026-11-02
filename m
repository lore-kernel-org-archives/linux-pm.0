Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793616876;
	b=GhxBZRK6FNeqUb9uYdUa8o3ZVGPrpZ0Ai/BdclF4nRbT4UPwowKvjTmppEprbF+4129X
	 Vw3T9eiQwXD59/1lEdoZWY/TbQC6pw/7hNczGFXhLL8mtRcOYelScgy7/a71tfHItJppw
	 RjFt0e7Kob1s9Yri9umFKYk69eyCkyR24Nm8gDsW21dGIgUp0OWJm9LqTVDiYN4+0LWyV
	 jebwNMp1Wygr/xST1oBxduQ/TlbcndtidBHXYNT0zbWT0fkdf+2elfnaqKTdG7Zoi9TGA
	 CAXaodWyhyBIS2guXuK4CK7K7RKWjzTX9c2WwACgzBlk8XFzHjylhvjHsgg3gssTfbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616876;
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
	bh=8h1d1MzP4REuhxeamgOz7d3n0ZTb7GuhxIZHXUlMj6Q=;
	b=dj4wWmieXDZXHlA0nLritdc+nPbybfhrxpWSDHS8veJJstMcgLAv1rzW0g9pTP5npb9X
	 ckCYrK1xEXPBhCqhREscMisWXI/EY3s1JC6+fwY3JycQLxjXqGuQVfeWyC0W8wQQRiuSv
	 05q+8uje1f4a7k7efAFfLRb657W8azDyqabMBCnlS0vIVsOkswqQ1eCC2wclM3+0UyjYI
	 pkK7/SHDCOQUwGcMPQiR9JVq0ZhqC0c/Ocx1d657ShflshIwXMFsvj+OHhzBHT/RzuG7k
	 r9co4nsE7cj6tQjVk0o1qNQhNKm7Vqeq3t/NxETDSb7LvUZCRdJu6liEM84Hn2L4oEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="gb/qCp/0";
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F8606A329;
	Mon,  2 Nov 2026 10:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 826F8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gb/qCp/0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616875; x=1825152875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HhyKBURex4zlzm1RyyR1gMP6UOoeS7E4IWK+y5IxnBw=;
  b=gb/qCp/0an0Ayrt732Lg5+tYu5gzy4CqVkYH63pdq3NRjRn1atzbETXE
   XsLVzp94V2h1cdsvLh9/GyQ3nPVR03qHfIqgcF/tOS+eKvsJkeQ1ksNi6
   T7kUhc7uKQ/i/aiJn1pmmvz9rknOjs5mgnXWacPZH0uqS3X45yVQcE3bl
   mSX6mVXjZAztY4OE9ADJtwXNYCEb80/FpX7mZz1Kt46qTU/DEhAjp8wee
   gi+49IqHHloBlidPausEKGtLC18VWhRmsEkmCVM9DNiaZ7elM8Fvka/pR
   Lz2TYLbAqY5c5pK/J7msJtcLpXlzS4FUJ11vpM5JqSO/EBEC69UUX0b2R
   g==;
X-CSE-ConnectionGUID: dhSef9S0Tl6e3p13N+6h4A==
X-CSE-MsgGUID: ZmTQxJBATWWZ66K5GjCKHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2190870"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2190870"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:54:35 -0800
X-CSE-ConnectionGUID: 1B2uCd4cQdq4CtCR2V/CDQ==
X-CSE-MsgGUID: 5lJKMR6/RCe2xEss433TvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6178387"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:54:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:54:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:54:33 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJMgka3VGMF1ByQ3+kDnKF1Kva3br71sXDcy++OWSY4mIzQ5wwkFfR3CzQLDjFCEyMDptBdCYvRIa2smRpZVDT4NVXTUlUhtqXL36UF1v7fyhp8sWpkoHA1dkcvvqMPNwUEouHvUTWmi1Of0VR4xIfK2o50d6wkrF8CMDLw1S0KM4V9CFs4QrvSGPcpGuT+JJJZ2l3Oo+BZENW+aSbpEyh/w58IUJm2yMiN6GOfMsufIKkOp+zZeEWAsPfruHvM0V2JmrtzE5r/HqQhrOn0+BRtR0mu0z27c6GhXWo7wlfM7XvuA76zwTxMPW6tcfcDbZOTLKmphaOCYGIG2xnxXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h1d1MzP4REuhxeamgOz7d3n0ZTb7GuhxIZHXUlMj6Q=;
 b=ou2e/3LS4W5z16XE85wSc3kDyyy1bU7v4OC3ci7lT39IbNT+/IAqepFj4vcDiC8EB34rNirHptyubsU5fEgT7n/73l8svf6vKcDR/lVrxlxWuAOykUKJgDiHLa6wKRwLIkFffQH9BuVwobG4cv3ty3WB5yvc/++xWbSevFxKFv4l3UwjWKshuamXqyhVOUj7JAlQtZmG4PK9gGBl1CeRia0vqqs5CtoUWgvNzpaAmkToWahVWo/MKqx2z6XbErrvQrbpShNa8jD31wokDo0muvEmoL6zCoQ+FZOGRhuDxkInOePw6RUTXgKSgVygUE+611zAVWdeLSRNpGyFqkqerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:54:31 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:54:30 +0000
Message-ID: <74511f6b-f5ff-498f-bf97-ebdc86c43d24@intel.com>
Date: Mon, 2 Nov 2026 12:54:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] irq_work: Re-raise pending irq_work after system
 resume
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
 <20261102074039.26983-2-adrian.hunter@intel.com>
 <20261102090604.GR1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102090604.GR1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::7) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: adc46c36-d25a-4b01-653c-08df38cfac29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: l+OvSBszHGqVg6FbqP6F+TYWFxeP60a5zsEgoxJAZlSl+ln8yCusuv3wBwao8zypYAQ1jsR0JENgBt2oPyWQHivoM7dirTmsMQRXWVz67kml+bvR3UqtrzSmeZ7ahVBW19JhcEKGEx8NkfE2Lw2wolcw2P+n8bmJ1RgR/Ef23bmFe7+kkHlZ50OkdegUMOvPX3oSBqK3UQHZGe+qd8yRaggdGVF3AZV8oRH7ipa+Cs2JAyYX9forUQWhz3kS38gg/1s0AhAVq6hYqdhe8m/D7zIYJHVJgKpoboHKIx+KQs1xV1VeUi8mnIhOrtL+OFa1CY9Koqrs8XdQ3ChJJDdEAYrEfLFdJQ1X4I9i5n8cPHXP2TpxK9Mx5lD0XR5TWVK2zSj/aN29afBMFc9ocQ8hw/aT0CgIEv+QItAFXuHQjwLOv9TdH/Ntk1hz2AmuDmcu8/m3PgBG6EgejNoTI810hmsiEKiD1QLEhen+v43x9PB8RBgN9LTBUiSoNgr1tjjZErmghv/360U5owG6IOaU9tygTRluDcOOoQdEvT4QC1frJSbjKUdit1kqEJjGNIyRpU8EW3F+7ImxLYzMDcnSoKnaAubOYBwVD/2/VAggwXwv1p6rzhpM4ANZUplEk36ZmsSYCo+2VGMjvwGT3MjnWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3pkRks2R2FmTkpRckFORTFpODhpTkNpNUZ6QlJ5VS9ldU52WHRQMlNzNmFO?=
 =?utf-8?B?RXJHOSt4b1Z5aHgvRnQ0dEk4dFVMVmU2ekVzdlRYZGwxUlhqbUJUN3NWS0xB?=
 =?utf-8?B?WElsbStPS3MyUkRKb2R4YzE5QWJnbjVMbmxYUnZZV1Q0cEgzQ0VhV0owODZV?=
 =?utf-8?B?Z2hscWQ1aE9TcE9ZcFNGNDQrUzAwVG5jR3NJVWo5M1dPc3VsWnRCZEhzR1dQ?=
 =?utf-8?B?OHFhZnFqQnlSVXRvZDBwVC9uUUpKZzJYSEgwZ21oYjg1amJUdzhCWkRjNTJS?=
 =?utf-8?B?NnM2QndNTE41a1RkZ2UrcGo5ZTlLYm1sa3ZDUko1U0Nxc3owYTdseUNYd3c0?=
 =?utf-8?B?VnhFWStoY2RSV2ltWHppYWlod0NkOVk3aEozWDNpZ2I2YjVTdUkwSzZoaFhx?=
 =?utf-8?B?YzJwNkRvRXVsYWtSMFRLRGtMRU1RNWxPdkRNSzJCQ0JaRXJJU3RIajFwZ2xJ?=
 =?utf-8?B?QUpDSllSdnMzWVkxbHc5OUR3dkZTa0pqK1p5T0s5KzRiRVBxVGJLU1JiMnhG?=
 =?utf-8?B?eDEvME90ZmtpUWdGa3RScG1yT2doSXVneDM1amJkREVmOTNUeTBZUXJHZ2RC?=
 =?utf-8?B?Qzl4L2xzSzBiMVJYMGlTL0pwUFpENGZsMUNGQzl1N0xtSDdHZmlDKyt6bXRP?=
 =?utf-8?B?aTNmK1R0bEVtTFkrTlliMWZ0RnV2RFFpNVV0VDl0Und4SVVBYnozK05VdnI2?=
 =?utf-8?B?dGRWSkpoN2hCQ3RPaDY5R1JLbzRzZVg5NlJBRVZINmUvbVE0Z29MVnN1MVlQ?=
 =?utf-8?B?eFVOSDlDcWpzNnZINHBaeTR0Y1NLanNweVJieitEamRzdnUwbS9RZXFZelh5?=
 =?utf-8?B?SC91WTRaT0x4SFl4eU1abFk0b1FqVStrMmpHNWlWUmhCbzRWRW1zSGZ0WGZa?=
 =?utf-8?B?Y2lJYTlWK2RNL0VlUkIrQzk5V3Q5bUI4V3E1RTc2eEpRZVBlZmZjeEh6YkpZ?=
 =?utf-8?B?eGFLdVFOcEZKVG9FeEFUMVFIN09waEdpWHZEOFR6bm1LTkF2c1prRnlEUTNy?=
 =?utf-8?B?SjEwaHpidS8vd05jdmlVQ3ZDYTF6b2MvQUNxMWd4akk1RTJIc2dJZ0F5bThq?=
 =?utf-8?B?QVArWEpyaUlqTzJmbXZkWnNTc05jZGxmcVdZS0pQMExrclR2L3pOZFpRZzAr?=
 =?utf-8?B?NU01YkI3eGVHV3pzUE1BTEh6VWVkc1lRK3Z4dXJmMDNiLy81Qzd4TVZKNjdh?=
 =?utf-8?B?bG40U0hZL05KK2V1WWxLRDJHWUxOZFQwR2RTVzlmQmp2NDlrK2J6Wk5GcmU3?=
 =?utf-8?B?VmFHQnhaaTVmWmZLc1BKSnVFa0hVbEF3ODBqY2pnOTlDa0ljT20ydWNzeUE5?=
 =?utf-8?B?OTRjWFJHSmVZZXNqdlBIYmc2R2c2QVVoNEJmOTFDa0tIZ3RreTVDRXdsc1BW?=
 =?utf-8?B?SkZDQlNXczVtbGJla0hEOG50NDBxSlg2YVRNUjEzMnlYbWRkbzNzNUN4VUhH?=
 =?utf-8?B?aSt5ZVdhK0F0dG01bndHYkRZQ2FmTFU3Z0tNUGZiZVNEU0VuSmVEb3hNSnFE?=
 =?utf-8?B?aWF3SXJjVmtBVGY5aldtVHZCYzlrUFVDTTF1cGt0NElLdGxyVUh2VTdNT1hL?=
 =?utf-8?B?N1ZiMkk5YWhhaVVKODR6enU3NEZkbHR2UTJRSzdjZDhxY1UxOUdYVFpmRGg4?=
 =?utf-8?B?dFpXTUlIVlpPNHJBbUUwRWdlQjA2SzEwYkswemZ2L2dZOXduOEUwWFRwdDg5?=
 =?utf-8?B?aEliNExKQXNjb3Q2ZTYrZGkyL255NzdkTmFkQzhRZFo0NjFUdE5ubFBDYUtv?=
 =?utf-8?B?MkJqUHVFWGlJVEw4YWNTMFh1YmxkK0I1WDFYVnZ3cXo0TUtrRGZnRndEajlQ?=
 =?utf-8?B?bkwzL3VyeXBuZGsyN2JORDYvaFNtakJCbFA5cHcyYjRtOGdsWTB5NkQxRFhj?=
 =?utf-8?B?YTFJNU84eDlvZW9IdDNOcFk4RW1PWnFiYXBkU2hQdytsSUNlL3kvbzVudWlL?=
 =?utf-8?B?eUZLVmllT21hODVwMFhGNVJpQUlnZE53Z1praERWNTd6ZndyTW1QdC9WNStT?=
 =?utf-8?B?cHdQSnVNTzdHQXJNdjZmbnV2Y2NTV2xCdnVZUGMyT3c1MEV6L3QzRHUrWGZm?=
 =?utf-8?B?UlBXeWl6YUdBUDZScnVTN01wR3ZvRWZiUUdkQi9xbHp4T2hiSVBVb29CbHlo?=
 =?utf-8?B?MmE0cEpTQWpKRmN2TC9mSW5vVFBPbVE5RFFWbXJvVXF5Tlc3R2l4RVBuNmFG?=
 =?utf-8?B?cmlpTTY1eXJ5ZDU2aHd4YXhPaXhNTzIvRzF0ejBxSWpwUXB3amdWWkZGZ1lw?=
 =?utf-8?B?Ti9Xa2xLT0tDRThJclhzblY2L2JoK2Rmc200QXRXVFMvSEZqYmg0WGlzeG5Y?=
 =?utf-8?B?a3dzbERRaG5GSVh6UjlIMGd2aXFKN1VEb0xwNnJJb2Zhbm5HamQveVVtZDF1?=
 =?utf-8?Q?RXIAjjff/KyaeL0I=3D?=
X-Exchange-RoutingPolicyChecked: WtcMfzMFtNQbPsFSoNMNrYLkymxFjat0nG6HZyXJP7Q+yA7+oXrr1dj22ssk1bg9bNKX2DX2YVEVaW2T/jdsZvLU18KAGqxpxswnHj5PA9zL4cWW7QwhRC6BpaHRjcnyTA4RZbCxAVaeN+knFJ2gFnsfZBkhcYM0FmjuEwG8XmSKaMOf5EHuO4IWwJL9waX0rtCOBmGkZ1f/H9MQWySa+Eyirqo0haaxS5xpfU0G0xuB1UbJMpAh9RuGCrmbolYrxQ+ad2E70D7DUo+Cs1I9E9sBFNAyAzyxun5xYOAx30FueOVd758ex1lsJc+tyaI6JvSDXwPyehhG99LO5fGnow==
X-MS-Exchange-CrossTenant-Network-Message-Id: adc46c36-d25a-4b01-653c-08df38cfac29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:54:30.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzDr4CEpQ1RpfrLrCUdE5YSmL3+7tcqJhsRN0bUqBci3eNDLoL0CRMRdj9XZaY8UXyjdHlwZ4JVkFw23Fd6L3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
X-OriginatorOrg: intel.com

On 02/11/2026 11:06, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 09:40:34AM +0200, Adrian Hunter wrote:
>> irq_work_queue() raises the irq_work self-interrupt only when adding
>> work to an empty raised_list.  Once raised_list is non-empty, further
>> queueing assumes the interrupt is already pending and will eventually
>> process the list.
>>
>> That assumption can fail across system suspend.  irq_work queued after
>> arch_suspend_disable_irqs() and before the interrupt controller is
>> suspended, for example from NMI context, may leave its self-interrupt
>> pending in hardware.  If that pending interrupt state is lost during
>> suspend, hibernation restore, or kexec jump, raised_list remains
>> non-empty after resume but nothing will process it.
>>
>> Subsequent irq_work added to raised_list will not raise another
>> interrupt because the list is already non-empty.  Architectures that use
>> an irq_work interrupt and do not process raised_list from the tick can
>> therefore leave irq_work pending indefinitely.  A caller waiting in
>> irq_work_sync() may then spin forever, for example when closing a perf
>> event whose pending irq_work never executes.
>>
>> For suspend, hibernation, and kexec jump, only the CPU that remains
>> online is affected.  The other CPUs are taken offline beforehand, and
>> smpcfd_dying_cpu() runs irq_work_run() on each CPU before it is removed,
>> so checking the local raised_list is sufficient.
> 
> I thought here was a suspend2idle option where all the CPUs remain
> online?

Yes CPUs remain online for suspend2idle, but currently the choice between
suspend2idle and "deep" (S3) suspend is a user space choice,
refer /sys/power/mem_sleep.  Many modern systems do not support S3
anymore, but it has not gone away.

> 
> Anyway, I'm torn; I would much rather make this trigger a WARN and have

AI now also identifies ftrace, BPF, GHES NMI, and #MC as possible causes,
not just perf.  I haven't tried to confirm any of those.

And, belatedly, AI is now saying an irq_work raised before lapic_resume()
might result in #GP if the APIC is left in xAPIC mode at resume.  Also
not confirmed.

> suspend pause/resume perf in a more controlled manner.

For fixing Intel PT though, it also needs to be suitable for stable.

