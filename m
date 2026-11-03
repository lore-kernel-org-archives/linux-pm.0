Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793720812;
	b=f1fTSIFiGVbGempjh+OIWLqnYBBRIOaecOtQpdtLW5wFkROSSUvxysHPn8ucJPZ2Zr8l
	 8waAA9k64Bg2L+rFhv0RS7I64hP6PQYz4RHM74hbj0+TAYqN1bt8b5VateR0nZE7cLL5O
	 +TqUlwa712bklPV4bwnh6uoaA58XGmcpDEIV6LjwdMC5f0WawNBOYdZO6z6WhqdJgBg23
	 AIk5pI1lR0M9tqSiR7eljR4gKKGE5Iy7P/yH8YB9y8zS3V2/SBWN71aPbbYRt5KGpbcfp
	 sHBZFtxCROU22+BHhKWOMqfi/t5xCu/e0dYFA5/hq0wLjgWxR0GZO0xjYg8cFvQDxBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720812;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=qVRTqzfaeVpKWt8kmwuMLd+abFPhafywgS2GXAiH+08=;
	b=tWD+FPtCzT43QhQk/PbN24PEbZqv01OPojGrGbAfMCIkVBrmSaL0BaWY0I+VcZruk2Kl
	 tQajWpbK45uoZUGg8rKPXatkhCIrRr7E/B3qaThMFetCU1sv9y++MAezytqKomv1jMQn8
	 rtUIP2fI/EsC07F5dE37JIpVsBuqj8LavM8APBABtguHKihhahCS4d8iefN6haGYlz08U
	 JOkW7hcNejJEOn5KUT9Ks+buHl2TDnlMDe5S1NXThLQArzzItS1v2U5bH4IjAfFxrChF4
	 PZrSDfWQjU0aXIb/1F1dj1nVRBe6f1C2dYnFw84Ti4JlUFf0cHnAhTb8Hili7BKy15g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6PpWy9T;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1B606A324;
	Tue,  3 Nov 2026 15:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E1B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6PpWy9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793720811; x=1825256811;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOhhZRhkxukTShsoJWDaD4OELhUUv9rAMu+Ssi/ZtPw=;
  b=b6PpWy9TSm0GGD8c6DrrqH1p1xQIqh0Y90wzujqnEX+eRXMopTTNh8XV
   2gvBvOidAh2mvqi5Qs7WwVdV6QVfj8YAowY76tWsPAZYAatrvIXy2w9GZ
   4HdaOtmBQyobIpRqx7kGCntXq+9xRGlgCwnz/dtFHs+DqKvadS2Aqf99B
   ZTJpaaJVGTXTGVWIhwfkuh3Y2JI0gkktPbyCER8VqOXcQot8ANHJJBCCE
   yCE1tF4llUwJiGGf4xKnff+noJBaDfcqQq6Tk0vQ/xWwEmMLpkIF9Yi/d
   CNrrwdNObcQJbGqDa/cYD+HmFtV6Lu8TWiZkh1B2s4+tnAGVfIpLjZE+X
   g==;
X-CSE-ConnectionGUID: GSVtVZq1TDSYB4VIQvo21w==
X-CSE-MsgGUID: GqMlqT9lQz+MPfUpH8yqEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2477727"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2477727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:46:50 -0800
X-CSE-ConnectionGUID: lbPbrbHHR2SMaPhmD1QEiw==
X-CSE-MsgGUID: FaEfT+8OQja0Qog+Bohbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6780341"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:46:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 07:46:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 07:46:48 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 07:46:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzsemlkfhMwY61mK17aOXzu/Fx+ij+5lPTdjDXMBqc/BtviG8JiHSXrp7Dw++T//IxNEeuTxO0h9GKShLLreQLOKUWiRgxULNGZUCD+H26Hq+B0vGNDu8DDme4YSHYtbtOdtrObS3ceqSmjWJ+uzSv+BlSFdDkIxpOcXLCjXXTNYxlqUR8V/ga4/h9kQSEd0l1ZLLirA+FxET82WPqGWabsrYEOLPFWC7jp8j22oqly2T2xpDk5fzyD9v91NKEOKXifFpg8noohnTQxUj5/2oRO/LAXcVd41EmqCtSn7NZN4baaNrp/vDZqthb56D7f42sWlrzSSwUOp7sDq2+HaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVRTqzfaeVpKWt8kmwuMLd+abFPhafywgS2GXAiH+08=;
 b=F1a24HTVZBzTIAIQXblrCDpCWdgqNBG9c03n3YOewnPgfPi58eJyqTqt6BNhUZRLtppobBTo2L8bAUf57mwnVf1jXSXLp0n8PSILwUrPlojMQjTRRt7+rDa/IIATe8QoL4PJTM5gekk3yjC9PoffKpJIdm2HmQjruv7rF7E4BzNpSWF8L013+iS2Ts6Xod1UXAhHvXnHRa3BYg/V+7lTx7HIuqgo9p+FX8P65Xis1LnVtbSXy9ZRATNMTT9nKkBnno3PluMzT5seNEBGucX7JPDS1m8cOhg1fnhuChRfyjRJ74pyqTbtxif/Modc6Gqj1rANfVELlVO5p1Dkg+nOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:46:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 15:46:40 +0000
Message-ID: <2d6105b4-bd75-41b5-a7b2-da91bda31350@intel.com>
Date: Tue, 3 Nov 2026 17:46:32 +0200
User-Agent: Mozilla Thunderbird
From: Adrian Hunter <adrian.hunter@intel.com>
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
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102163937.KwllF-Pg@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0001.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::6) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 714c4603-e174-4fef-1f07-08df39c1a6f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|22082099003|18002099003|56012099006|261102123227099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|11063799006|10067099003|4143699003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: h4nf7Fny4p0ijY+7U8B5cbiCt/cehuu3TitdAe/Ey4PJBr+jJi4P/NqSt9rIieX5kW61xiCW2/66WliYlKqpeW+n5p/i+EesEpTPvm6hj9eYrvh4JVDSM1GnD5436CVotmUoNdioarDcyjQ3w12fQVqj7uujxDZY5yybUxp3ZwgLRZwbvwCVYa4wUChnBrdhC8iEhayd0xGEuRqCnq/Dt5UmgH3b6TTD3/H88oIlLWwEufKL39dVdOpU9KXLgUnQ6GEO25D3uZziYNecc4ByBPzgTUnAD363tbErVL/jNa0THM1SUPcz19cW3BpX91VpPDJlzyaIq5B2Oqvau9/Hyn958mUBD0s+gWH3fFn0T63pfph42zLn1blrUaWF+QYPy87Z2OLnsnGq8z/COMyCUJKBXY6Ln9couzhn9IhmtpZJ+PQ2d7DrdenPnUallWBpF+7IfjZgxiaPoAAVS0J4+9ujyhE3MXmbmiDNpOCMvKmbMMSYcAA/v/Srg5FvRzaDJIlmM7iUZk+C1K+EL7Qerz7Bdgul7Tjunuv3nDjm8aTbXyNunEo6M69c6t83bk4SeV+BAErIAnp5mWXTNUImMv5P1M0kESK9+ue0+xhB3GGMR01mEKVjxYjeBPMbn6Tps/cQYL3pV5/2iCOdSgiOjep7vQwyTt8UmBefSIXXgmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(261102123227099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(11063799006)(10067099003)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpYWnl2WUhLSVlMaXMxeVdaeXV0c3RZeFp1d0N4RFI3QnNJbTFzL2N3cmJp?=
 =?utf-8?B?Tlh1Q1dLRXlUd0I2U3dOUU5VQmEzbjZzcXVtQS9FQU42TjBmWk52OHVhOU4v?=
 =?utf-8?B?dlppUUVieWdVQ3BMT09uL3Z4cmVPLzQ4L215UFZ5Zmw0N3pIemx1bjNpR0Zs?=
 =?utf-8?B?NndQV1ZMTU5JYjM4amFUSHk3ZFlNKzJGNWp4bVVFRThhc29NdVFidGhoWllQ?=
 =?utf-8?B?VGgvN2pMTTBxWXBYdjBXYjhnUWZTektWSVYvdWRyY01ua2x5Z3R0VjAvcFJm?=
 =?utf-8?B?N0tVZnpRTThCQjloQldzTnVyRFVFL1Fxb1Y4UDEyZnF3NlNIczYzN0cvdlJ1?=
 =?utf-8?B?c0ZWSjJuNmIxMGkxREFBUUUwSmdsV29iUkZVdkhWQzlZSmZaVG5ZcmFYUEFz?=
 =?utf-8?B?R0RiUE1RMDR1V3VLUTJmLzhScFFMM2ZWa3ZYbmI2RXhNYTZKLzJ1Y09mTHdX?=
 =?utf-8?B?c09YejlnNWRsYUhtbFNubFZoSW9qa1JhY1N2RHdHb2tSSzdlSHRzSTl0T3FB?=
 =?utf-8?B?MStmRjdLT0pFaXBjVHFxSHB6TW5sQU1XT3ZSMEJjY1hzWFU2ZGdPNjZpZzB1?=
 =?utf-8?B?ckJWZDFNaG4yVFpIem5JSWQvRGtNaHZCZ2hRamQzdVRrSy9naGJFUis5UWs3?=
 =?utf-8?B?NWcxb3pYV0lHL0NCS3JORTRSOVZHTGZEeVVNV2ZuNWN0TWhpTGFrTmdkV2Rv?=
 =?utf-8?B?ZmJ6c0hhcnIvZFV2QTdIMWIyTWZ1V0VGNjkwaDV2RyttbzlJVlpBc3Y1dVUx?=
 =?utf-8?B?QkRvRktBNlZBOGQxSGRsd2JjaytnOXUvcThIeGEyOTc4OWJKemNUbUpJNjVv?=
 =?utf-8?B?alpFT3RQVFJZd1dkSFZ5UlRmdDkwSElBZ3BxSE0ybkVCSjVnR01xRVF6RTRw?=
 =?utf-8?B?bmhGSDNkd0Exb2Y0YjY1RENqcTZFL3c2OG1pMzB1alltZC95YUs4dDNPRE8w?=
 =?utf-8?B?UHJsSUlqWEdzY0VXZ0wrYWx0aEt0VGVGM25ocFJnSENGdzh4S2UxdGVETlVj?=
 =?utf-8?B?RjIvU2tEWGxwWGlMUE1Oc0M0QktqeTA2MUtYcXdxei92L1pXOS9kUDhPbWJL?=
 =?utf-8?B?UUYzY2JhUm5vR1NnaW5PaThDb0p4Mm9pWWtsaS8rMWcvRHlDanpwdkJ0L3Q2?=
 =?utf-8?B?cHBrbHBKTGUxd2dLTWhKcm10bXJ4R2M5VGJOaGZnOW5NYm1XV1dPRTlnaFFt?=
 =?utf-8?B?cDdWZWFuNFR4dGdPRTlJOER2eXE1S29OelVjRjM1b2JoZWpVWjFuT0M3a3Uy?=
 =?utf-8?B?aTZRbzV1VXJBYlYvbGdLMU9ob3ZZbW5Kc080bHNHN2ViWFdqR2NDNnc0cUM5?=
 =?utf-8?B?NE9UYkRvalRuVzVvQTA2SGZIZHpjVEVBODhocW51TFc1QzBGTWs2d2NkMC9H?=
 =?utf-8?B?QkJ4Tnp1ZTJIY0luLzlPNFBtb0R5cXUxSXJmL2FkQjhZWTNMWHFIVWlXb0NK?=
 =?utf-8?B?WGFsMjJUMkpSMXROV0RlZ0ZCK04vQVpTODA2ZHFtMUVxRFpaZ2p2Q1U5SWZ5?=
 =?utf-8?B?dVkwSXRyNUdpcTcySnpjbmJ4UnQ4RWNFcU9wQ1J3THZzc0YxVkZWUTZQUDVa?=
 =?utf-8?B?M3k5RTE1L0dHTVNlS2FsRHN5dzcwazFoQ2Jod2g3d2d0Rk9SRkpvbjFza2RB?=
 =?utf-8?B?SG56NitXbmovTWc5SGhyMjhURjd6dXJ3U1RETTZLS0s1ZVNsMWJwb1o2b0R1?=
 =?utf-8?B?OEswMlZ3bVRVSUtjY1FDVlZybVprVCsrWVRqd2pMWkRkT3dsZldBWk81U2pz?=
 =?utf-8?B?NjlwVytoUDQrMlhObXdoQlR4N2o5QVlEc1IyQjRmVUhRUzgwUURBQ0hKdWRN?=
 =?utf-8?B?YlBsNVdsQzMwU2pKUkcxYVZPWDhkQURJR0E4U2lYL00wTkVIRnNCWVNTWGNB?=
 =?utf-8?B?K0Q2a2NLZ2ZSZGczUlFDNUdheHJBcyt4V2s5SlYzdEpPWXA4Y3BMd1d3aFZW?=
 =?utf-8?B?emJYVmFXWklNeFhoZUU5YndiRjdJRzQ2WDVMazFsandYMXVlMTNMc2NtOEZs?=
 =?utf-8?B?STlVbGIwMXVUWWZHK3hKTFhBTkRwYVJ6WVlvdC9MTHRCb05KUUQzMzZYYjFq?=
 =?utf-8?B?VFgrdnNBeVlhYldON2pGWC9CS0ROTXMxTmk3ampoSE02MXczNVc5Y2VNVCtr?=
 =?utf-8?B?dU1aaVF5RFQybDFGRDNDM2xKOS9YbmU3YVZtdjM3RkR1TUpVV2JlUjc2WmRJ?=
 =?utf-8?B?NDlNRW42T2J1SExlTkxJKzZvdXVIUGFNODBIZVUzczhnRWcvNEx4ckJScHJY?=
 =?utf-8?B?Y1YzcEpZUTdpblRrVHhFdy9WNndPTlNxMVRaVGRNdVBNRzhORnYzU0Znd3dF?=
 =?utf-8?B?OU55RmFhVUlSM0dhQ3VSSFF5c0t2Znhnc3JQaHFucW12ODI1WlYwMnpHd0wr?=
 =?utf-8?Q?UeeUEn6rTUjejrZc=3D?=
X-Exchange-RoutingPolicyChecked: 0yI3Bw7y2fRZ3Y0XhpUnRpIU5GvUlEDww1x6uXRkCd2bpGvT1ACIcE/XJ+PwKXYLIR+KvboReKL9Jk0mBA/sPmaSPNFat095v9gtpwKSo+Hnm65aLDrTabeWi2jccYEu5gyfQSF/8nfU2jplYuf7wuA012Sdp1gu8RK/VN3HPW92wnAAQnvpJWdw/iiMs5h6+uyq4Ucq191yjIYeThwMFrZRJxVIuXtAHWIRyieC5DUndAkHfzKXNhZvktIyInlhO8Qs3vK4kEpt7nxpwSuV+Yo0vjoPNIRCrvJBicRr/uCvVS0eDNNyVAo8kmsZMI4yjZz61U2m3d0xFu6DEMwiqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 714c4603-e174-4fef-1f07-08df39c1a6f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:46:40.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vn+hlKZk2WzHfBsLgk0R9unwMkQODuomvZAepCPxzQZQuFxx71B/cYEROzFlb1Gdx9voCEo3TeA445SLJKAK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
X-OriginatorOrg: intel.com

On 02/11/2026 18:39, Sebastian Andrzej Siewior wrote:
> On 2026-11-02 12:54:22 [+0200], Adrian Hunter wrote:
>>
>> Yes CPUs remain online for suspend2idle, but currently the choice between
>> suspend2idle and "deep" (S3) suspend is a user space choice,
>> refer /sys/power/mem_sleep.  Many modern systems do not support S3
>> anymore, but it has not gone away.
>>
>>>
>>> Anyway, I'm torn; I would much rather make this trigger a WARN and have
>>
>> AI now also identifies ftrace, BPF, GHES NMI, and #MC as possible causes,
>> not just perf.  I haven't tried to confirm any of those.
>>
>> And, belatedly, AI is now saying an irq_work raised before lapic_resume()
>> might result in #GP if the APIC is left in xAPIC mode at resume.  Also
>> not confirmed.
> 
> Could we flush this before similarly to what happens during CPU-hotplug.
> The question is if this event can stay enqueued during suspend (and
> handled on resume) or should be taken care before entering suspend.

WRT "might result in #GP if the APIC is left in xAPIC mode at resume",
the systems I have checked restore the APIC in x2APIC mode, so the
issue is theoretical at this point, although I can get "unchecked MSR
access error: WRMSR to 0x83f" if I deliberately add code to change
x2APIC to xAPIC early in S3 wake (in x86_acpi_suspend_lowlevel()),
and then do:

  perf record -e power:suspend_resume --filter 'action == "machine_suspend" && start == 0' --no-buffering -C 0 -o /tmp/x.data &
  rtcwake -m mem -s 10

The error can be avoided with:

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 08c9aa176c33..41f93586f22c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -63,6 +63,7 @@ extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern bool apic_is_disabled;
+extern bool lapic_suspended;
 extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 40fa7bc7fb97..187cbfad0d76 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2385,6 +2385,8 @@ void __init up_late_init(void)
 }
 #endif
 
+bool lapic_suspended;
+
 /*
  * Power management
  */
@@ -2454,6 +2456,8 @@ static int lapic_suspend(void *data)
 	 */
 	mask_ioapic_entries();
 
+	WRITE_ONCE(lapic_suspended, true);
+
 	disable_local_APIC();
 
 	irq_remapping_disable();
@@ -2534,6 +2538,8 @@ static void lapic_resume(void *data)
 
 	irq_remapping_reenable(x2apic_mode);
 
+	WRITE_ONCE(lapic_suspended, false);
+
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 308c62411ff4..32386b7cf84e 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -25,7 +25,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_work)
 
 void arch_irq_work_raise(void)
 {
-	if (!arch_irq_work_has_interrupt())
+	if (!arch_irq_work_has_interrupt() || READ_ONCE(lapic_suspended))
 		return;
 
 	__apic_send_IPI_self(IRQ_WORK_VECTOR);

