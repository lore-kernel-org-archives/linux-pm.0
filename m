Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793778522;
	b=aDP5NIFwPtOpkidqvjEw1TO/klDWhfAsl4ZgwkuCZE5o6EbTc87oOesJL+x+HYQMTAF4
	 MYpQFvnC9cMX6/sZIhSitGakXZw5mj+WEJpOQLghnDXwAK1YmY5cgGb9hSKXxpuIAIotv
	 1kOyVfW432iurlsU3epJCmWoDaSD8lMhd6Jm71YbjNou8E9DoiXwP4rYWpSnpXeCb+Hel
	 X5c/49+/1Y6XwToXwh5MIa8gEOzW0ZJsZoYQBlZbjplZ8ncd0Vt82/22Fap3+bk/j0z8A
	 oG0E789Yonp4CtOVYTtPs+pPtgCZjDHse4aNCScBn8+hydeGerOkVNpOcZjBApLUcug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778522;
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
	bh=8QriBTYsNTSaDKGkRfJvrusU9x87Nt+OfdezGL67DdI=;
	b=QNkkXua64PlFoNb9gEf58NlpdE0yKgFShgysJlJQGpnLtioRr331kLKthyzjHO5mldzy
	 1uAQC9y+Y7Xl30CsDaQMmzBTSoebUImkbCF/Vmi7zbY7TvIBGNMPc0AeMB8LvNROKSfhZ
	 jpT2wwEwRx4ZJOmnWmaQIUCH1Wz/KOUacFbgCfGQnB/7mKA63l1y6T/bb6486ozzzyas1
	 kUgXcNrSmRDBKvTKz01xa1nVVltqqyK+1lG+8OfrScddhajm87xS+uUBeJVa0ioZdnmUb
	 9bKkYyd4n+8bOD0TrGrMweRGHEc3YlixmQ7eA/KWALbhXgCFyzczz7sJMRzjL7W7ElA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ltu96cqs;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BA606A328;
	Wed,  4 Nov 2026 07:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C04BA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ltu96cqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793778520; x=1825314520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O6tRQdEg3EeDxpNJWr/9tzJFKVGdWPqxRPilIqS/Gz8=;
  b=ltu96cqsyQ6zs5XbXU9wnyc2mpcU/Jrj4Hf1eKxlFfhuftu1QQmy4mYP
   dfagJbtufMcEvUOWNVCIvQK1A8Spm+qzReaWmy+IZjMSH0ld4NMsmQqkq
   Y9i5nVU/mtBg/NlwW5S6D/rmHjdFvj8wBu7C3Tw/KhJz40jR0G1BybTLg
   x0UhnmLTX4T+HxDdqDXc9yBPz/xluQMT2sfVy+sb08aInodzu9iQrVl/g
   usfTYSJuGAkWs8fpXUIX3dR49wWfIwWvSFyIwQPhHv+l0BeWL9/2iRymw
   Xe7Cx4yIcRogKQITKtmua45IDZ9Wiy+Lzt2jjGUQbUmBVWFHWPDPLlgbx
   g==;
X-CSE-ConnectionGUID: rwNW12XsQa+CJ2fFsBBOfg==
X-CSE-MsgGUID: MnG1WTk9Thq0znKG3I9Cuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2554706"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2554706"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:48:39 -0800
X-CSE-ConnectionGUID: 7ADKqiiQTW2DKWJILRS9JA==
X-CSE-MsgGUID: FiT8GEhURumusw7sius7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6804985"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 23:48:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:48:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 23:48:38 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 23:48:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyh9GNFznIIKgpxFUvpLQWTe3P73FVRkLJabZthj/Es1ATRSg4N3Ah+9mQBfyZ2I6TEYQVjyqtqe99jcdy0xcaWkj+O22QqT9wmSoWmch7EA0bbk6vXRJtrWkhLi2L/Ip4+j0YSw2LnZ1ETZed2zU/FN4ZksO+TIEcgMlgnBaUfjo3T9QTbSME29pi4EqLq+RHzGWEU8hQien4PIQYpgFTNGlAv9uuig7uMBJQ9BVCmaD9LYxFNm1ra2OiQ9z5F1B092seNFkexa0lovF31hVCOjI0HvlzNVPLWngbXoSmpqV0YArCBff9x+ReqT6SJZUb3buXNFKEfAmunM2pdSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QriBTYsNTSaDKGkRfJvrusU9x87Nt+OfdezGL67DdI=;
 b=vK0fOQnIoglzaMLV4Ex8Ud57TEpM2ZsBoGaHtad1TGnZ58GNYOj7+yduMs6XpAk5OaaeAE9Ejx4VgbKkdxB/OjPxzX42KKE0uPoGBp3Fk0vfxuObs8cBuGLLBRcDMJJTL2bJVSVM5OdEocW6WIwFZFeebJPMg1FDSo+3iu3lbogKO7pcDsLdWF/JrTL48U7a3YKS7MPSLCQGlDI4rOIV1DWYF57VigPbgGSDlxMvQHlsHiotwFXqZBdsOeuBboKN5QglqqHKPuhvxLkfU6C/mzgR4YZ5TkZgyqlHWzB1sjuPf+6TI5TNcPEDL+GhCt1SfA0tMhvULFSGeMzrqaOQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 07:48:35 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 07:48:35 +0000
Message-ID: <56198a93-670e-4187-86a3-99ae54295998@intel.com>
Date: Wed, 4 Nov 2026 09:48:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] irq_work: Re-raise pending irq_work after system
 resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	"Thomas Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Jiayuan Chen
	<jiayuan.chen@linux.dev>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Frederic Weisbecker
	<frederic@kernel.org>, Andi Kleen <ak@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-2-adrian.hunter@intel.com>
 <20261102090604.GR1779021@noisy.programming.kicks-ass.net>
 <74511f6b-f5ff-498f-bf97-ebdc86c43d24@intel.com>
 <20261102163937.KwllF-Pg@linutronix.de>
 <2d6105b4-bd75-41b5-a7b2-da91bda31350@intel.com>
 <20261104073220.Hgq4chT1@linutronix.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261104073220.Hgq4chT1@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ1PR11MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3954ff-8ea5-4555-e8fb-08df3a480788
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VB0WXgUnl3WimxpQVrwfBWhaLAF4ADXvK9kax4Pv4WmnWOcjMJ7WYKRaewVebh26DHM+rAbEH0nMNInRW3iGWbV8yx0pmSvfG0WGcM492lhnIHz1ahijG6uX/MzdAtIgY94WIEca8vPLFjTwrr9RG5qwozAJRHw/7/ifZLrU8SQhH1w0HLZiPKS8JGyHmuqg+3Az9EGhdAU5W+0hfC2l9KN8qM8Z9vQ7mi2IFkNYmqKvDoRrfNQqTt/VLzoOvSpmjWt3VMeWppf5zZWkl/Qco2laBpT0J98Cieg2Y28P8CJ92ORT0DfE19iqj3VIKp0T3ZnoGV9QkYeQ1eFDMZOVTBYHk1KLm6VldOnja+tkkMjuu0DVXQsHpNfh1NMK8yeNxn2EXBau2ekxJxjYGkVWfpPkYijrOT3GrtBtR0JqSTwg/hWvaBY7Ic9aJ5YaM8Z4WSctMgjqq9i9H3IC8Qbc3zGEgA5JEp/U91Ck2gMF1sOTjXqFIWZdt3XQsHm1sAeEQfT0QSrr3vFewXPujgkDg82eo3s6OrB3wGkAeVElEEQH3uT1r6eLFawnXe66EFa22UNn+Vc7cRc0lO16ckti/fVnvdqhvwu7NUhTdh8P2yin2EJKbVuAWFY6mJSlNeLtnvA7S9h/6HTQLCbhNhakrJyQ+C+MuPS8j1YIjrP/wfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JudmNjRHdrL21HSnVMNHFEdkNkZXFnNC91VE1HMU1NaE4yYkYzVkdpQ3JE?=
 =?utf-8?B?S1Z4OHhmRGJBSEhwOFl3eFF0RzNPUWVzcTBXYjdxN3J6ZldMSGE5bWV3TFM0?=
 =?utf-8?B?aXZwRnNOSXRHUVhpc3B0MVNrWmRIUHhHRzVDVlJoRDhLWm1CeEpCNlJYb0xS?=
 =?utf-8?B?MUdUTnF5ZGthRWFDVkRwQW5xYWJPMVpwN3MxTnhyQjBSdmVmUFhvcHFpNWM3?=
 =?utf-8?B?TTlNVFM0UWNZNGlkQTMzSU8vY3JwUkpwcDNzNkV5OGNCNDhpck1ydm0zVWdr?=
 =?utf-8?B?ZnhqR2JMNWpIV3I3RThKY05FSS9RYmJ1MjY4ak05WlNzcUFQSmpyR21aVll4?=
 =?utf-8?B?SExtM3l4RXAvMkkwMHlNMjFhREhHWTcrNVF1bGJxZXRESE1LbnFOOUgvNHJw?=
 =?utf-8?B?U1VDdDZoOVV4S2dObDNRREJWeFpKdHgzbHZ3dEJ5V3JRMlVpSkw5UUdiZEpO?=
 =?utf-8?B?UGNUa25TMVdsRnY1WStmWGE4R3h5T0pNNEc3VWxTUnRTUXc5eHVnc2FaeGVj?=
 =?utf-8?B?VEFXeXZodDNlWm92NEl0RjZKNTV3eklickhscXQxMWx3UzdhRVVhbTJrODZB?=
 =?utf-8?B?VTF4NHh3cUtiWGx4SnRBdkFNVTEybDlBekFBbWYzWUtHcXJqNVpCWkp1Y2VH?=
 =?utf-8?B?WS9nc1NqUHJ6b3FCYzlLU1lRQTNITkNZdkdkM0NWUUs2VTFydlZLU0RKRnI0?=
 =?utf-8?B?THNBVWdDUmVQZG9OWjlIVTRaWWZaK0N5L095U3lFZWE4V0JuV1EvRXRYdDMx?=
 =?utf-8?B?eHZMV08xNXduSzU2K0ZrOVBvZzJFSW9BZWhXdWNBck5rWDV3Zm5sRnVTYWVw?=
 =?utf-8?B?SVh2MXd2enlIczhjQzJUZ3ZnNWdrNmJpRGcvRHlkbHhLd2xubjAwRldhZ05B?=
 =?utf-8?B?NEFmYTBIeW56K3ZwQmF5Y0w3dUxoRUxVZGI4RE5OOHR2ZExscGY0cHZGbzNq?=
 =?utf-8?B?dHRRc3VJc0pGV0JMZDJMaFVqTFFvcTllNm50OGp2YjVyaE5rNWN6bXZzRjYr?=
 =?utf-8?B?SVYrV2pUbS9idWh6WXNzazkxY0lxM3B2YmhLUDU0M1d4UXdhWEhTeTRFcGNU?=
 =?utf-8?B?VUF4RFEyL0dvNlN5eEpSYklJcDVHZnFDcVFLcTJCOWFjYmZnamhGL2ljWEpZ?=
 =?utf-8?B?WDU5c25rTnQ3ZGc2QUsrQU5jZGdZamZTVzZuc3FleWNPODNEY2JsV0RDT2h1?=
 =?utf-8?B?TCszUVloRmlxOWxiSklpbDVvT3lTTnM0YkExbWk0Q0l2UDNkdGxBRzRjLzJX?=
 =?utf-8?B?UjV2YUVQYXRQSFhzK2pXVDRicm1SeHRZMkphZElWZkY2dk5VMG5hYmRaUDha?=
 =?utf-8?B?VlgrUThQY2hEMGdTckxwRU9RaGcyU1NQNFY3NEVhTEltWkpScDQxNVBhYy80?=
 =?utf-8?B?WlcvT295MFN0cHVKdHVnakF4SjFVWjl2MitsZDg0dUd0ZXQ3V2pld2JQMUpM?=
 =?utf-8?B?alAyZlBpcU05WHdEWVoxSEoxeG9hMGNBNCt4by9qSVJzOVpHZWVSR0Ywa0dY?=
 =?utf-8?B?RSsweGdaTXlnbENuME1TM3ZDekl1MGVTa3h6UlVZQnFpclF2VitFVDhKT0hw?=
 =?utf-8?B?Nm5LK1VPZHhYd2JoZ1BidkRRQ0JmK2IvUy9BTkpoVXNUOWwvcE9nN3dhbWFE?=
 =?utf-8?B?azRxZ3lpbEc0QnY1emt5eGVKVlJzMnBuMFArdlZwcnA0VWRNQjlmRTlwRnRW?=
 =?utf-8?B?a1F5RnFTdXhYUjlMRC9BN0dKOFNUZmF1WnAwVmM4cWpCSHlMK3hGUSs4MHR5?=
 =?utf-8?B?eWc0SHBBWXlQd0JWMXNaVXlOblVGa0Jyb2dBZWYzeDRienRhNlIrVjlPRWlw?=
 =?utf-8?B?NHBPYkl6VExwSGdaUHc4UGoyQmZ0ZGNCMXlCZUZHOW1Cd1VPeHUvWklNYm03?=
 =?utf-8?B?Y21BMlR1TVc4eWsxWU42ai9RUDQ4aGtNRWFBYkJqV3BLUjcrRkY1N3BBZzZL?=
 =?utf-8?B?bGhZcE56bHhFM1N6ZDBwQjRMa0RKMVRZdU5MWlpPb0E5cDJ3TGRBWTN2UlBt?=
 =?utf-8?B?d1N5aVZYdUJtNE9LTVltVEd5dlQvYjNhVjRJeUtkWEptSXIyNC9kSEd3S1pr?=
 =?utf-8?B?bEdZaUpRWmE0M1AycWZzSUJOZllYeUFkSmlXL0F3bjlaMmQyaDIwSktHOWtO?=
 =?utf-8?B?bkM4c1BuaHJnSmRUNjF2V29hRnpzeHN4M3VSdC9pQndtbnI3QUJCQVA5djBm?=
 =?utf-8?B?aEtnV3dPbk9oaWtZS1RWT3lXOHpJdThzaWtIM08rbWJ1RGNld2oySHVZTlQy?=
 =?utf-8?B?d2dSNDVqZUQ3ZnJENHJCTzA3YjEwK2lhVUtFS2lVZ0IwRmZuL3B6ajVMYW0w?=
 =?utf-8?B?RGV0T2ZvWitTNEl1TXcrS2JHVU83R1NxM0lnMmw0OVQvdWZWZ2ZCdz09?=
X-Exchange-RoutingPolicyChecked: mGX9Hufq5K7pEhi9pAVmLKRkIJjivSOIbf3F06bi1RvgcmJdVjOcp3phqYMIN9/BbecQS1mkVv9CblUPlMq8JZrt3QBtTIlAvA3G1NnbOaH3KfvWJtefKQfuz1wQBS8rHxYfERPxCE8wSuwuKHXdt+INzhKpsptfjyxjjpv1ZXmaxqUiG3VIkMtFfHq1NqA/OebXfx51i5ZlrzxFkwFJQwhTVj+tjFxnl9Xy+BHw+9B0mjZEKA39QOeo2ICd9QZ0Vh0f4oUlje9Zg0eJGWvNurplZrOmTImE/3Wgt6rY1wLWOn5yJb9WoDyBG7UCdG1s0wFTAgNhGldnQgFg7zc9nA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3954ff-8ea5-4555-e8fb-08df3a480788
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:48:35.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+7Y++iO9TgkwmAAArSYDROvmePCs3sK8YWfHUTwD4Lcibsypd5cuWb+kA7M/eulBzWOBLsjEgBVJBUzxrHETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com

On 04/11/2026 09:32, Sebastian Andrzej Siewior wrote:
> On 2026-11-03 17:46:32 [+0200], Adrian Hunter wrote:
>> On 02/11/2026 18:39, Sebastian Andrzej Siewior wrote:
>>> On 2026-11-02 12:54:22 [+0200], Adrian Hunter wrote:
>>>>
>>>> Yes CPUs remain online for suspend2idle, but currently the choice between
>>>> suspend2idle and "deep" (S3) suspend is a user space choice,
>>>> refer /sys/power/mem_sleep.  Many modern systems do not support S3
>>>> anymore, but it has not gone away.
>>>>
>>>>>
>>>>> Anyway, I'm torn; I would much rather make this trigger a WARN and have
>>>>
>>>> AI now also identifies ftrace, BPF, GHES NMI, and #MC as possible causes,
>>>> not just perf.  I haven't tried to confirm any of those.
>>>>
>>>> And, belatedly, AI is now saying an irq_work raised before lapic_resume()
>>>> might result in #GP if the APIC is left in xAPIC mode at resume.  Also
>>>> not confirmed.
>>>
>>> Could we flush this before similarly to what happens during CPU-hotplug.
>>> The question is if this event can stay enqueued during suspend (and
>>> handled on resume) or should be taken care before entering suspend.
>>
>> WRT "might result in #GP if the APIC is left in xAPIC mode at resume",
>> the systems I have checked restore the APIC in x2APIC mode, so the
>> issue is theoretical at this point, although I can get "unchecked MSR
>> access error: WRMSR to 0x83f" if I deliberately add code to change
>> x2APIC to xAPIC early in S3 wake (in x86_acpi_suspend_lowlevel()),
>> and then do:
>>
>>   perf record -e power:suspend_resume --filter 'action == "machine_suspend" && start == 0' --no-buffering -C 0 -o /tmp/x.data &
>>   rtcwake -m mem -s 10
>>
>> The error can be avoided with:
> 
> I meant flush it via irq_work_run_cpu() like in smpcfd_dead_cpu() (the
> CPU-hotplug path) and not go via APIC. You should do it late once the
> interrupts are disabled so no new irq-work can be enqueued.
Disabling IRQs doesn't stop NMI or syscore enqueues, and the resume-side
raise still goes through the APIC

