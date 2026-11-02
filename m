Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793615051;
	b=oyCSgROzJ96A9/9gaenogxvodvXPJgZx5FN6SWHIzlstzK/N5qZi66Iw8KEkNTiLHM40
	 vL5LqZ+wN/zQG+zMzleE+Qi+l0rhU0xAxrPpPGzIUaBP8hjvcBUtt1PsNtbGoknHB4rJs
	 uYf22IsG3yZyRwGzzfsB4h/maxJLdf5rk6yWTrTT6Z4oU3kdml3q2Zgy7L/s1pgtZHLk7
	 i6HhFfGpKHaUWGQNVUNV/3zLj1V6ehH8cFGB835MANzqMh4aIqs/zFKAwScrkWF5pxBnC
	 MzZeG9k8/NtkIl3yKWI3GLO8W8y4c66ftrkge+88QfLlkrk8C0mRRv/nOKRl4gpKsAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615051;
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
	bh=lsox1+XC0oIL3mFSDS6nHHUhaOMMXtufo20mJV8KX/k=;
	b=mym7FQot8Q2JFSS2vWsP3FTEdXDLXr671ipCf/c9ZBgrfFrzKbpaUVeVypXYbXSdgjbE
	 edVyPnSCZtKNMiIyNti+JWv+8ZeEpdYMV2AjSCke13gX6eGhz7/MWFt0v+56hKOZaK3yN
	 pD0P1aL6HZPr4EvQp31sdXNgYim3whu1uS6Nlym1yIB32011WmUPoUjQkHOVhrTXVKtiS
	 uSX/+I4C4CRQZT2fwcrWc5fT3eQmiS944zrREFA0pfkQRQCfYn7HTRnwj4FsmRGCt2zPl
	 GtdoQc3Ti4/1yXwNeJt73rLeZRIvdjAzrC+Ss3D2gfu3EIi+57WcaWz4sBhsS5tHefg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fM65xz6Y;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571B606A324;
	Mon,  2 Nov 2026 10:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0571B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fM65xz6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793615050; x=1825151050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N+erJ8de8abzYaxTjwaNVt1YdCosAhHFnRjj5Zsuc3g=;
  b=fM65xz6Y/cM7KHSImpd5V8lBWQI2+BSSwp3UNZCp/JfEoOEumK9Tu3zq
   eZph/YKFJYz+q4GoegVvAswf2lSV9+VwbkBed6DjPhP4hihkrCWppuxxw
   F6yS0waExb86SvxEWtrWrhkD1cQpwsb2upaCqWaMYeemxCxsYixS1LtFW
   i5c792ZyWKjMfsoWXnJUy5xeoTgByhgYa/9AENcDKF+XcRD+V9YG4/yVf
   FZvSLABFzcsIcziypk769LGLWk0hJARxFpaoI0kVs3eH7XIlNTDCDi3uj
   PVSMtcjpXH20aH0jIZf7HdNPWY6c7PVXGlr3aPYS0f9ClvEYbXCwZGkMj
   g==;
X-CSE-ConnectionGUID: 4nBiIo9SSIq6grx6GJhY4w==
X-CSE-MsgGUID: xxXMouo4R1OWj33pjhjyGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2327322"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2327322"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:24:10 -0800
X-CSE-ConnectionGUID: eUlMAmkDQQ+EkT70zZozmw==
X-CSE-MsgGUID: wds5r4JzSNWaahCV6bDGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6214961"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:24:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:24:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:24:09 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:24:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebYl2YR9adE6pna4jB8xSKWNeeUvrBpgsVtApP1PV5lwwU/AfoUAEP8AR6d50KxCtvWcRNdHcr1bJWenIc0bxLxBxWrfa0u42d2SFxda5gdzeWh21skCk3tvRgOQvVAOfnNG0vxAEeZg2ORLUZW8hHb/B47BNFQtzG/c5LlfENza9G5+iyuZHTaUB1fV2/kt2bfTYEa0fWbQcddvtHusvfYq7g3Ij/Cq3ptt6luXR5RYxrLUVOBpoc1sbfywVsnI2dAVJyjuWrlQtWfav1RSjz3idOeeZ2nHX9a3ZrGMX0BKNS4yBAiVUQpB6pHhdYKhDaE5kzMqWSqj3Drmt8YSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsox1+XC0oIL3mFSDS6nHHUhaOMMXtufo20mJV8KX/k=;
 b=F0w49AQCs8f5bBDII1HyEWeSQAhw4ra79VdNW2pQF4U8Co45i+I3i2IZZrFgHlun0++iHbC/jfOhsCsXAnn6UEa0YIn5L5pq85Hgm3V3QxN5kUvsSw55yLbvbwrXb75+LozCcns0aFE6zbLTjY77rbZTirmaoMfLxKWt2/i7oKZwo/iJdqwML7T/DBTg08ENg/Ek7MMrFkNfILMPf2fOmr+IONMZ6EttjhoRKyv57ODnu04lmwzqzolbIkw9mkTv7U+QlXMoQsYRL1VPVKELbks/nzG3kF+OOmCCXmcf82akV8JzFfpre90aqmNmrnQUucJrCTPn2cg66HHl80FkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Mon, 2 Nov
 2026 10:24:06 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:24:05 +0000
Message-ID: <8cd3d3f3-c866-4ed3-a41f-a4210e2d73c2@intel.com>
Date: Mon, 2 Nov 2026 12:23:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
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
 <20261102074039.26983-4-adrian.hunter@intel.com>
 <20261102100451.GT1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102100451.GT1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW3PR11MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ead79b8-1fda-4a87-9c73-08df38cb6c4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|4143699003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +ytzkLvXQxeWf70CStG3sPPKtfMAuzGjxRUXe4+gGkjI46eZyKndCLa5B7EKc077obGZQrZJFpLfd/xdvPbMsP8eg35EUaERW74y3kNFBykmwUDnb/wMIq8XjYz5bjDgSX7/OHLSPaODuhE6c4T7lVuu2Q6WUky6MPOUhEd0UMWu7imeDoLqR/IcjDibMK8PCvlD/j7jVczwUmDyDm4G8kDbjFzojonh794QNGw7NTbVzN8OZj04BojWayza5IFaXd8CVHgBhE5pb+xx9+cAueT+MJ3C7rYgQYtSow8b4xsJsx0B6lqCujbcL16ky3h8hbTvZjTnBG9K89l/epmZ+aFrsU2EWqfVSIcFJqqGQfTINGhy2uGSpHmpcRdxac7uvRGw067IB3wT7zBdt1RsiTnWf6/GLBgR/MLh5PSGsAmbrcyCsbShjwamcxGZckfvD7DBSJ57mTwibFLp9ezdPqJ11U3ZoZbDNBIim5nIh2j7/SEUkgrS04zJ6dOE35SHI7hR3/FwaYXXLEgqz4LU9jjlO+DTXsSP9SqDIu+rXZjshKcogqTF1sP5Em+rh7dJ3VjwzTxelDuk8KkE+5gwkPiTnQe2LRalfoLDdsrzUJoZYSZPz3Fa0+FUh4CCoPjyaAuT1OwPTjs4qccUOFeOesePGJenQ8t8KpUG2ohg1E8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhFRkkzVDhpL3BHNjJnaENkRmhqTEpvTjByNjArTHVHQzhaLzNwUkNueVlR?=
 =?utf-8?B?OGNNTlB2ZzlWZUxEc0ZNVTM4MlZMdnZXMlR4a082dXhuNGZTaFgxeFNXcEN5?=
 =?utf-8?B?N1lnMjVvQ2FkN09HZUswL2s5OGtIWWFhNGU3LzloRm5CTElTQmV3WFJGai8z?=
 =?utf-8?B?SWtYWnRKSDJjcnkwbzZWM01aczRzZ3A0VnNkdmhVOWEwTVFFakxqK2dYRUxm?=
 =?utf-8?B?MlRYbE5UVS9xblQ5SHBaWVZpV3hjaTJBZmgzV1ZDU2dRN1BHVnJxVWtRb1p3?=
 =?utf-8?B?aTFEQU1USkRMRlBKaDdQYlZUanFFMGFwa1Fkbk52RTFjcHpRR2duY002dFEw?=
 =?utf-8?B?bWlwNms0eExOOE9rSXpVZHFVeEZONzRMVFNzYkgwRnVyMDZ6TE5mK2diUDhO?=
 =?utf-8?B?SytuVXp6VEg3Q0swNGo4UHJsT0tYK0Izd2hmczhFVFBBdWNPbTBZQTMwU2NQ?=
 =?utf-8?B?UGQ5Q0N6cnNsNG1lZGh5bHljTlJlVHdqU1RjRjd2aXZwWmo1S1pJZW0ycDQw?=
 =?utf-8?B?UHJwdDBPZEJzRU5zKzYvaGI5M0p5bld4MUZYYzRMV2NEOGlmZzBxcUJCYnht?=
 =?utf-8?B?MVUrT2pJYWJiQ2N2VUcwZVh3N2dGY1FwZm5nd2l1VWtCdEFQV0lxSnZmMytj?=
 =?utf-8?B?bS9tU016aitBcUZ4VXM1Umh4bTU3NmRaSng1SjN6SWZ2Sk1scTFaRkNIUTlY?=
 =?utf-8?B?TXFqUUZTKzhqQ1hwcjRzdmNYYkoxL3pCRFNVb3Z2bGVyMVZrVU93OHdjM0tp?=
 =?utf-8?B?QWM0YVlnczNKN3U4RkFOb3J5c3YxSFdKdFpRYmZzb0tFa3RVNk1NSkUvaEhu?=
 =?utf-8?B?T3daKzRTbitpYXRSbG41WTE0MEF6VkVjYUZ1VHROSWd6U0pMMFNBcmRSTXdl?=
 =?utf-8?B?aXhhdHRSUGc1NnZ0U1FpMXRGUzlEekVFMDNWTjBPNVVBb2NkUzc2R3V1Q2Zw?=
 =?utf-8?B?SEhoRVBTdC9mMUVrRUlkREY4Q3ExUGRMMXRsTGZXcTIxVldGclJGSUpQWENF?=
 =?utf-8?B?NW5kNzF3U1ZqUVp5eFR6SlBRUWlYRCtQVlVKbzBlb0Z5L3lGMmtvc0x3Ukd2?=
 =?utf-8?B?VFVxd1cwaUc0MkFBd0xCenM3alFTR0JGczZqYnJySTdQd2VyUitKeUErd3BT?=
 =?utf-8?B?YVhJeGNoQWd5N1Z1SmFucUVSN2JmWFFETzZUeVVqSEFsYkIrZ1hOQXFza05z?=
 =?utf-8?B?ZjZJNmJRQ3RTU2VPblNWVTkvRFRqNG1lNVcxT01ubHM3V21KaGpoejhjZ2xE?=
 =?utf-8?B?dTl2WUQ5Z1ZTc3RwOGlYQkdISG1POXFRUmIwUnl3NUtnQnZibDJuWGo4ejQw?=
 =?utf-8?B?N3dySjVwc0FlYTJDaU05bnZEZ3ljQ01VeVh0WEIzVHhaQnNleUgrSUV1TmpB?=
 =?utf-8?B?YkFUSy92anY4OEI0VTk5MWdFV2NSaDVPS1hDVGpwLzlBSXo5c2NVMTAyWHBp?=
 =?utf-8?B?QUZDRnN4MEFHU2QrRHdIK1liZE5qWTZ2d014Y01vb2kzZWJCUDFCb3RZZ2sz?=
 =?utf-8?B?VG5HN0oycUZuZnVPUmlrVjVaTlRqSG5iWG1FcHFtSjVuWGV4WXlXZWdrVVBN?=
 =?utf-8?B?K2tDNENPT2M5SmVBbnptMHFyTkVHM0dtM2g5N2p2cE9wRDFEbFBUdGRiemZL?=
 =?utf-8?B?bE1adlVic01lWTVFTFRaSi9ETlN5MXVvQ0UrMzRXSFRlazRIUVpBdXJPSG8x?=
 =?utf-8?B?SDBJVHBzTHdpRnVIZnZCTHVmOWNzTHVPdjN2WndjVzZvaEJZWFVnN3FkTWRR?=
 =?utf-8?B?ZnZzTVdOL1NpVHhYWmpQNGhTZmlXY2E0b2Z1d2p4SnprajRrOEVjWi9uM3pi?=
 =?utf-8?B?VWVlV0t6ZGNpZUdXNnpOaVVOZXlRajZkZjJKZE5uR05rS00yanZNNVcycDc4?=
 =?utf-8?B?UUllbys1Nlg2K0lLOHRNYldHZjErRFZVc2YydWRKN0h5MUdDclBOaXVYNUxv?=
 =?utf-8?B?V1hNaU83SmFYcGZZcGRGbHliODgwWTZZOXdhaG1abHZKODJocGR4OUcxTS9C?=
 =?utf-8?B?WlBDK2hVMkp1SlBBY3BILy9qYS81NnMwKzAwNnhSUStXTW8rRDBRV1RLNThP?=
 =?utf-8?B?L3Q5UVYzalh4M1FJMWNPVHFrR2FVQnhUVmhocXdCZmFkRE9YNUE4Tm1WcEFy?=
 =?utf-8?B?eXRQMytlNWVtb3lkT3UxQTQwampkMDBBNnZYekE1Z2dNVnZlSzF2ZlNzMllo?=
 =?utf-8?B?UkFsVU1IUjJ5ME9PSmgxQjZFQjhwbFZ3SmRjSmpOT2Y0M0lWNXU0L3Zoc2tI?=
 =?utf-8?B?QzAyUU8zRCthV2lJK3NES0Voa25vRG1FK2JCQ3lqY1k3K1pFRkhscXJpNzFs?=
 =?utf-8?B?NU81Zjh6dkxMd05pc3RaVW1lM2JLeVBmcE1ESEgyNW1SK2RtOFJxcXdVK01F?=
 =?utf-8?Q?IjxWYwMdO0/awtQM=3D?=
X-Exchange-RoutingPolicyChecked: DGQmSTx6QqVFv/jczoq0ybykux0sQn/kQjkBkBDDokHkcuE0hsfFoaHdCwzb7D9lpenm0Ne9r+otA4ysQaoiuV/GdCxtNM8ZSIfgdiIOizkqCW2XPdpW7VY7RNQU62GqWAxoZUXDdeEcpfoAWamTDat5Ro2yv9Owbjy/LWUAbb3gMbsJzwy/zvDoB4tjNqMiSMktu/ei2S/bNI303ntW61vaSHPodYW+1I0gcIkv4ejOpF6/uhz+2qSBf9H7oxyaSmhJVs6WedNYvKgzKFxq7TV6DAIwqHSw7azM1/p7tAL4Qw6oaeh3UDxchMmE/Uxc27kZFzvGqO7a5kODknUmiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ead79b8-1fda-4a87-9c73-08df38cb6c4a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:24:05.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhdeEk6aOLk2VdtOEEa1gKZydwrbe8p0SpEKKPQ8b6X6dPEp5SBAUe1dqQNYIcgGcmdLAornvjoTH0J8C4aNxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com

On 02/11/2026 12:04, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 09:40:36AM +0200, Adrian Hunter wrote:
>> +static void pt_shutdown_cpu(void *info)
>> +{
>> +	u64 ctl;
>> +
>> +	/*
>> +	 * After VMXON on CPUs without PT support in VMX operation,
>> +	 * TraceEn is already clear and RTIT_CTL must not be written.
>> +	 */
>> +	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
>> +	if (ctl & RTIT_CTL_TRACEEN)
>> +		wrmsrq(MSR_IA32_RTIT_CTL, ctl & ~RTIT_CTL_TRACEEN);
>> +}
> 
> Why not unconditionally do: wrmsrq(MSR_IA32_RTIT_CTL, 0), at this point?

Writing 0 instead of ctl & ~RTIT_CTL_TRACEEN would be fine, but the
condition is needed.  The comment tries to explain.

The first processor to support Intel PT (BDW) will #GP if a write is
made to RTIT_CTL while VMX is on.  Since VMXON clears TRACEEN,
if TRACEEN is set, then the write is safe.
