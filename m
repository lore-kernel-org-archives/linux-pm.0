Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932013DA7E6;
	Fri, 24 Jul 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888038; cv=fail; b=Y9CtTqKeg/IPmGVsCXmr75BwKKNtn1lqs/g1vammg6VuSGoYdtNUTPvKcV10/scLLG/8AkQ3uaBqmwNQr33f+sxMV1Ub6xVcgVsb9cv+T9cu9aoJOncKAoqH5A4UZGk6iwSUcoh+GnqnlycoIUFPzXkMQkLG0BOYumMghAg2Yng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888038; c=relaxed/simple;
	bh=oBJ+CVgOc3S/CdDtY02DriDm79y9ZjRrOxB2QjO2B+w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrgb+JwIwJ0fymCCjf9hGQ4Af7OMOLY2fea85TEbnoKnF7yTy3Edf8FCzzzik61WheXZSRvxQcemxtzochLj9LCPd9YynBL202JPE8BvTQBR2PzSWJUwPxZ90yRoKWtUt2+FwIPHu95JPb/upaUSmTvwHOTwFKkLroMSmEwmw1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEd7olUq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEd7olUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784888035; x=1816424035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oBJ+CVgOc3S/CdDtY02DriDm79y9ZjRrOxB2QjO2B+w=;
  b=AEd7olUqWbeScaqqPROxTp08q2txqINcs7J/oKpgZeI2ZutVY29w3JaW
   /mjtASlKP3/L1ZSTPSogGpZsMiYa4NC3Lx8UyfjkCQTZwdOY02RVHR/CR
   IDOBmwUfmfPSiiil2vQpCmX/+RPR570spqQ1NrouFsk6NH7rM2Ozug7ie
   VPdK9jZ5n766RP0hIUvbkiMOTdsDj7R0UrMkbFxLFLlt9fbPkrBCGvSa4
   pGaNPwhUYtl1j6sTRkVOioYNFApSIFNoOMBvCqWIbVTzLK9n+0TqubHjY
   x+Tz5wr77n1sgk5MSSlAFt0od23T9X1dBrdIAZ8oSgj8/B4hGsjxKwoEX
   g==;
X-CSE-ConnectionGUID: g+qgYH7KS1KHyvRfqeDkTg==
X-CSE-MsgGUID: uBIRN5dUR9q3XDzwJjJ2nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85315671"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85315671"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:13:55 -0700
X-CSE-ConnectionGUID: L5U8ilfvQBmImmBMse75uA==
X-CSE-MsgGUID: 13RFJC29SRKqgIRv+nC7og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256900805"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:13:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 03:13:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 03:13:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 03:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCaZ5YVVVmUvnnX8YtMm82sFNt2UdxGonRM/OmaFUzqqCkbAVpmAK5M0gPYSIxEVHDzV/eqiVZOs0PZFB0C3vlXcMve8hfiaH9q7mQarRw+95aNIlv11mKDs14fFgjCvcqDcOXbvMy45fdcLmPBST5W3nzl557CwXDTG08oaY/R6DgCAiWTLQuEqLrltuZ/9Fjwd7UswrPBBGcu3uLMB1yViujWIbHiTGhc0x9ezl25Ao+rf0jPlDIZSQzJ4WgKD0YivJlJOzvAazMkdn+L2cbvbvdanlUby7o+pV3jIr/Qk2vDThAxzz48Qf/rQhlYcMFiqfvuIGt8PehLte8SADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3RJl/wzXTcozdyh6+h2OjeqDhrWEO2iMNQuGy40cAA=;
 b=oOZekvVxbJL37NdoxB3LtaOWJetlqgP0Z+jlZQwaf3yIMMNrD35RYX1rvUoGcXGjlx3w6FFBJZmOAwj1iGMPgyyC48gEEfeHvc6YHhuAV4NTod0Rob38IcPctyAhrE3KX1DMfYu3uDWiZVCXq+bVeqDUXwCTub026rLwZUK2oTqajFScu0CDb1SoGagP5Bya9WqrTyEQLCDpxzkMuYrcXAhQNQwg9IiKi9kFsj4B5zXGYRX7UaI8Y9zn424mqZTx0lp74HUinazpk4hpwF7aMdafug2ZvekWWaYaflpDFdUxByaLU1qKHuxcIVTyaUQqVSSjsSivhsv+lbJyYQNnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 10:13:43 +0000
Received: from DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825]) by DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 10:13:43 +0000
Message-ID: <f52de11e-6e13-412e-9e29-8fc44fb8871a@intel.com>
Date: Fri, 24 Jul 2026 15:43:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: [PATCH 1/2] power: supply: leds: create triggers
 based on properties, not type
To: Steffen Dirkwinkel <lists@steffen.cc>, Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	<ravitejax.veesam@intel.com>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
 <20260625-std-power-supply-triggers-v1-1-d80db570d329@beckhoff.com>
 <a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com>
 <9c68a65380b440e6a51d8b3d7c9ccce53d82f13a.camel@dirkwinkel.cc>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <9c68a65380b440e6a51d8b3d7c9ccce53d82f13a.camel@dirkwinkel.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0166.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::9) To SN7PR11MB7639.namprd11.prod.outlook.com
 (2603:10b6:806:32a::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7631:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 999c49ea-9422-41c6-eb1c-08dee96c3cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 13T7jr7Mv6+V8SKvUI9QkgCH5rcetiH8mvQJPEj+CEJmWwkDCKPLpz7/y2cdRHe9f1vZeTKp2h5ev7cAPY3XQr69yu2ZoHb3/l8zuCzFIKEBzEuXQZ80Ynh298zqOn6eeCSQaVwWeGcDWaeCGQF/3CJ9/wQeASOh3u/oXS1xvNw2+0ekWyHQrdILlpzdLNudce5jkwAzpmLxwKaSnVLvPAOJo3/ZMUHgfcZ7Vhk4rm8U9JCD2xcs4i//7R5qDW9M7SPP6XfBTFjoXGDTHnoYcOj1gv2O/TKDgjlvRTi4gPHDOc+Ifzml7dpQTSiWir9KffrQ0cQCzeKpgJVTtOU88GUwx91i3MW79wVa699vwizXZrCp4Bmn+9WVf3FfxRE/uaO+tpxt7tukeu87sBSxBLx4O/MoBphpQj+4SDrbeL4FbLRsNli7rCStY5rE1Ki0czhs9/3QDGTRHJIRbCiT988hsI4gyz8Reh1q+R5pG+nY48+vQ8bUr85ccrcKmDFUuqUKEDboQ6bqL3hCBuKQqyddIrI4FdF/cRBvpMoA8T97gQW6BN0LQH50iKAuORi3jDLJg/lFwQB2qwthQFoXdspRK0T7iem3cybR801E0Kv/aBTPmCd1rz9ywV9U1A+d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7631.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHJ0b09VZXlEL0xJTkd2WlJ1NVFzMHRpR3FMS0FnVi9JN1BUNWptRWJ4eDc1?=
 =?utf-8?B?bDBXcHh5amNnbHdzSzNnckNVMCtUWVo3Tzc3QnpzVXNmY0h2a3VpNWRpUVpN?=
 =?utf-8?B?Q2g2R2pGcHVEalBlcWwrNmY1ZUJNWUNzby90TDhzTGF5L3c0cmR6bEpUeDJB?=
 =?utf-8?B?MkJTOHRubFdIQW9hVnc1VXM4b0QxdXJkOVJ1N2ViRnkvdTZ6ck9PSmpQbllu?=
 =?utf-8?B?VkRQTU8vTXdvalVtR09qZUFvb3V6MVF1Zkk0dnJYUDVodTZhOUxnVFczRXpX?=
 =?utf-8?B?MzZ2L2gwNXhIdEpxd0JIMG1LQVZPVDRndkY3VWlvNWRySzFhaE9sMHdMakpo?=
 =?utf-8?B?cnNnb0VwMzRzNFNMMEtpOC9iNmxacDQxUWZyYTBQY1AyY2h0cDNmVTRCR004?=
 =?utf-8?B?WTVVSXh2ZTdkVCtxSUNUQzc3dTRuczMxK25LTHVCUDBURVlmb2QwNCtTbjhV?=
 =?utf-8?B?TzZmS21tZ1ZyTVNJdEhwUnRQQUdBZ2U3a2huR1VneVl2QldmcHVxVVdwNUt5?=
 =?utf-8?B?N0hIeExIb1V6TUtTUHdPZDhHQkRHbVJMTU9ZZ2ZrN3VQRGwwK25MTHl0Mjg3?=
 =?utf-8?B?bC9tN2QrMzQ4RE1GVU9QSU9KZ254bWpnazY0bnNSd0puY3dYaDJTS2RtQVJv?=
 =?utf-8?B?QmRSRDk4MnYwZXIvcVIxeTZ5OFI0S2NHZnVmSVRTTWJNSzl2ZVVWTFNEQ2pN?=
 =?utf-8?B?Yks4Y1hKcDBNbEFjUnRlMWZueXpldXhYcXFZRCtGQ1pkQ2tmVjBkamV5cW16?=
 =?utf-8?B?Y0tpLzZBM0lIRVFENldCVUowNzZSSzVmUllpVExDUUVQeStYWkpLTU94ZzVY?=
 =?utf-8?B?WVlPaDJMSGtJM2xteG00dlU1czBDbUN6Ujk0VVhsQVF4QjljVlJQU3g1VThp?=
 =?utf-8?B?NkwxSHU1L2JPRTNvMmd1MFRtQWsrdkRjdDRYaHZiOXkvQXNtMTlDd25pOWIx?=
 =?utf-8?B?T2RoYktKZk5ZUnVkR091S0FjaFk0b3B6cFZndk5SUWllMEJSY0F2dmFxbXd5?=
 =?utf-8?B?UzgySXVlYWNFdEtJdEh6SWpGZGcvUVpxSzJ0aU9iQjlzU1lJeVNGZkNPZmdt?=
 =?utf-8?B?Q1dkaytCYVkvRUdtbExWUEcxbUx2emZOOWw2MmEwNGY1OUV0S0YxTEJBMmxV?=
 =?utf-8?B?M1dORUhxdTd5Qjc4akJRZlBIOUhhd0RGbGo3ditHSytyaHIvdlc3a3ZqOGJj?=
 =?utf-8?B?YVpJdUdYQTRUdGYwZGVxdlJ1VFVUTDVYUlNheGVCajZRN1lXMGt4c2pCaHc5?=
 =?utf-8?B?cWllbnFpdFU4eXdFS1RaeXF4cDltYVFIb2VPd1R2OGo5a2lJMFRIVHdGbm0y?=
 =?utf-8?B?MkNDZVlxa0NkVW1YTFhqWjErUEhqWjdTT0lPTzBhSzBZRmNmV3ZYdnBHKzc3?=
 =?utf-8?B?ekQ1OENSVE05dGJnL01MZ29IUEdJTmd6N0d2Y0lYUjBqY09DcjZYT3g5WVFC?=
 =?utf-8?B?UDJBTzZZbys2S1p6bGxSdjBTeUpNSEF3engzTUIyR0Qzd1N6aTAyQVdSSlJS?=
 =?utf-8?B?blBPU2JrdWtZditWdWR0RVUrKzFMR0xkV1RYaWg2SGtsYjl2QjJSbkZ0QzNQ?=
 =?utf-8?B?aG81Q1haWmMxNVBLcFhUWTdTanY5dVo5MkVrWm1qaFRkcDFlYlhLVWhKYmp5?=
 =?utf-8?B?MS80dkN6TU5ZWXNXM1RrRTVRWW1JZk4xbit4TWJ4YnpCbXNKNFZkc2M2VnhP?=
 =?utf-8?B?Z0wwYjFZaVVVY2g3cksySkVmM0FuZ2xxZlNENFpoSmdHc1RjNFI3U0NpVEc4?=
 =?utf-8?B?Q2lWNUduOWJpTGlkRS91WjVHVUZJSXUvakNnakp4Z3AybVc5NjMwUFRZdVR1?=
 =?utf-8?B?bHV3NTA1dlRrcW1pT3dvN0M5TjhRa0RHN0FWdUM4OFFqQ1VZWEZiU2xEZTBk?=
 =?utf-8?B?cDRaUWFySzZucjUweWJWaXpqSkdqOU94TGlLSisvZzR0QTV2VURUeEtsRkdl?=
 =?utf-8?B?UHpDWmJUSEIyd3dvN1V6SXhJZGFubC84RUQvSm14REdTUHIrUFJ3V2dsYUFK?=
 =?utf-8?B?N1RxeWRrWG0rVzh6SVhhaFdSYVJ6d0dKbjlvYVE2QUdFNFJ2VkhuczVDdXhD?=
 =?utf-8?B?YUgrbGdRZzBWL3pyTkUxcmRWQ1VpL2Fjb204Z3NxQVBIbDFQVHQrb0pIc0JG?=
 =?utf-8?B?SHN2dHF0WmhrOHhucER6Y2VGRzN0WklBWU00RnVzOUVVT2diLy9zVmI5N21O?=
 =?utf-8?B?VmZiMTVyYzhVN2I4dXZNN1diSGhVTmI5dENLNmc4VzRZZFRwVXc4VGI0ekJS?=
 =?utf-8?B?TWxoZUhNWmlxbEVyQmFqMmhUK2t0a2lpM2N5OEo2TThXdkVuVTdIV0dERnlJ?=
 =?utf-8?B?b1pWSnVHV1NKRytTWVU1ZjF3SC9yZmd2ZTFkYTExNkp0YUl5bFVkZ3cxR0N1?=
 =?utf-8?Q?HgPsDUGwk6h6xYnA=3D?=
X-Exchange-RoutingPolicyChecked: fwhyFRlLOXkVe9gKhWGTGA1CzpErDZy4AzC1FYgDl6ts/xeJqQH/mcpGsLKL6EKHDlINt3497Qs8yggJkKwG56LUjWOmbe1gFq48tw/pc6UmcCPSF9yu3yo6RvWyJpdMre8JnP5sp9JcrkCxfPuCHQQMUUV8cYQASIG87RQBfV9nDhlPi695ZLaPlzq9haIlduwOrcjrEyijSY/5ZS73EKZRwfkVrVg+BECYC0oTsAKQ5cxfPnD+dxJGEcB4N4tKjezVkVZTxhkAque3L0N7wIzVeDXbNsPaXakTRFdRPf+E/iEkwxaKx+EB9UEgFW4dW+D8/8z9UDgybY47lBfqMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 999c49ea-9422-41c6-eb1c-08dee96c3cea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7639.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:13:43.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhvg45dfZjNFnyC3H6+itMgq4flc5b8yaaDWWG0XfTgg+d2X5OcRUJNfMAWVrndV1EjxHu6IWIE/aJ/SPUcLNdW1axd862vgruuA6EUefEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com



On 7/24/2026 1:03 PM, Steffen Dirkwinkel wrote:
> Hello Chaitanya,
> 
> thanks for the report. This should be a fix:
> https://lore.kernel.org/all/20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com/T/#u
> 

It works, Thank you!

==
Chaitanya
> Regards
> Steffen
> 
> On Fri, 2026-07-24 at 11:28 +0530, Borah, Chaitanya Kumar wrote:
>> Hello Steffen,
>> On 6/25/2026 10:37 PM, Steffen Dirkwinkel wrote:
>>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>
>>> Currently only battery power supplies get triggers for other properties
>>> and other supplies only get the online trigger.
>>>
>>> This changes it to provide the triggers for any power supply depending
>>> on what properties are available. Batteries will still get the same
>>> triggers if the properties are there, but now other power supplies can
>>> get the triggers too.
>>>
>>
>> This seems to be causing regression in our linux-next CI [1] since
>> next-20260722.
>>
>> <6>[   11.206334] ------------[ cut here ]------------
>> <4>[   11.206341] WARNING: drivers/power/supply/power_supply_core.c:1384
>> at power_supply_has_property+0xed/0x100, CPU#2: (udev-worker)/324
>> ...
>> <4>[   11.206524] Call Trace:
>> <4>[   11.206526]  <TASK>
>> <4>[   11.206532]  power_supply_create_triggers+0x4b/0x150
>> <4>[   11.206541]  __power_supply_register.part.0+0x3b0/0x510
>> <4>[   11.206547]  ? __pfx_devm_power_supply_release+0x10/0x10
>> <4>[   11.206560]  devm_power_supply_register+0x75/0x100
>> <4>[   11.206569]  tps6598x_probe+0x34c/0x6c0 [tps6598x]
>> <4>[   11.206592]  i2c_device_probe+0x19c/0x3b0
>> <4>[   11.206604]  really_probe+0xf1/0x420
>> <4>[   11.206612]  __driver_probe_device+0xa2/0x1e0
>> <4>[   11.206620]  driver_probe_device+0x24/0xb0
>> <4>[   11.206627]  __driver_attach+0x110/0x240
>> <4>[   11.206632]  ? __pfx___driver_attach+0x10/0x10
>> <4>[   11.206638]  bus_for_each_dev+0x7f/0xe0
>> ...
>>
>> Detailed log can be seen found in [2].
>>
>> We confirmed that reverting the patch solves the issue.
>>
>> Could you please check why the patch causes this regression and provide
>> a fix if necessary?
>>
>> Regards
>> Chaitanya
>>
>> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
>> [2]
>> https://intel-gfx-ci.01.org/tree/linux-next/next-20260722/fi-kbl-8809g/boot0.txt
>>
>> --Bisect Logs--
>>
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [842870cdfa33b9191b46484a3264bd5126a90570] net: Enable BIG TCP
>> with partial GSO
>> git bisect good 842870cdfa33b9191b46484a3264bd5126a90570
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [b4515cf4156356e8f4fe6e0fdc17f59adab9772f] Add linux-next
>> specific files for 20260722
>> git bisect bad b4515cf4156356e8f4fe6e0fdc17f59adab9772f
>> # good: [ce3befa9786f3e9eb3990cb6f6b497710bd10ec5] Merge branch 'master'
>> of
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>> git bisect good ce3befa9786f3e9eb3990cb6f6b497710bd10ec5
>> # good: [efac7c4cbbafdd21f9866476e3f4e5e5bfae8912] Merge branch
>> 'for-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>> git bisect good efac7c4cbbafdd21f9866476e3f4e5e5bfae8912
>> # bad: [a91e6d5412453d44dc4d59d62d3ce50b53122ad8] Merge branch
>> 'usb-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
>> git bisect bad a91e6d5412453d44dc4d59d62d3ce50b53122ad8
>> # bad: [b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f] Merge branch
>> 'kexec-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
>> git bisect bad b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f
>> # bad: [8a3f0f5b2aadc94d6300cfdd8daf3971decc1961] Merge branch
>> 'for-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>> git bisect bad 8a3f0f5b2aadc94d6300cfdd8daf3971decc1961
>> # bad: [5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd] Merge branch
>> 'for-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
>> git bisect bad 5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd
>> # good: [db30c3e3e3c247b0b1e73449b7ead5dd19044c26] Merge branch
>> 'for-mfd-next' of
>> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
>> git bisect good db30c3e3e3c247b0b1e73449b7ead5dd19044c26
>> # good: [406b652bf9c47d6e784fd2ab723e6798d322ef47] power: supply:
>> rt9455_charger: Remove redundant dev_err()/dev_err_probe()
>> git bisect good 406b652bf9c47d6e784fd2ab723e6798d322ef47
>> # good: [5ec27fa6b9d937188a81724f09df82707cca944e] selftests: helpers:
>> handle multi line in test_sysfs_prop_optional_list
>> git bisect good 5ec27fa6b9d937188a81724f09df82707cca944e
>> # bad: [353438b3107d56e36a642f117c2b4accc963abbd] dt-bindings: power:
>> supply: maxim,max8903: add DC and USB input current-limit controls
>> git bisect bad 353438b3107d56e36a642f117c2b4accc963abbd
>> # bad: [741a9b09775517c76a5029c58a03725b414d7e20] dt-bindings: power:
>> reset: qcom,pon: Narrow allowed reboot modes
>> git bisect bad 741a9b09775517c76a5029c58a03725b414d7e20
>> # good: [f97d9166048ddea147b5673330f9900bf08c725d] power: supply:
>> sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
>> git bisect good f97d9166048ddea147b5673330f9900bf08c725d
>> # bad: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power: supply: leds:
>> create triggers based on properties, not type
>> git bisect bad b04510c3af6dd34b2e8dcf303114d77d5e443cac
>> # first bad commit: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power:
>> supply: leds: create triggers based on properties, not type
>>
>>
>>> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>> ---
>>>    drivers/power/supply/power_supply_leds.c | 88 ++++++++++++++++----------------
>>>    include/linux/power_supply.h             |  3 +-
>>>    2 files changed, 45 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
>>> index 1548aaba3362..538cc0440e53 100644
>>> --- a/drivers/power/supply/power_supply_leds.c
>>> +++ b/drivers/power/supply/power_supply_leds.c
>>> @@ -17,8 +17,6 @@
>>>    
>>>    #include "power_supply.h"
>>>    
>>> -/* Battery specific LEDs triggers. */
>>> -
>>>    struct power_supply_led_trigger {
>>>    	struct led_trigger trig;
>>>    	struct power_supply *psy;
>>> @@ -89,7 +87,7 @@ static void power_supply_unregister_led_trigger(struct led_trigger *trig)
>>>    	kfree(psy_trig);
>>>    }
>>>    
>>> -static void power_supply_update_bat_leds(struct power_supply *psy)
>>> +static void power_supply_update_status_leds(struct power_supply *psy)
>>>    {
>>>    	union power_supply_propval status;
>>>    	unsigned int intensity_green[3] = { 0, 255, 0 };
>>> @@ -102,7 +100,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>>    
>>>    	switch (status.intval) {
>>>    	case POWER_SUPPLY_STATUS_FULL:
>>> -		led_trigger_event(psy->trig, LED_FULL);
>>> +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
>>>    		led_trigger_event(psy->charging_trig, LED_OFF);
>>>    		led_trigger_event(psy->full_trig, LED_FULL);
>>>    		/* Going from blink to LED on requires a LED_OFF event to stop blink */
>>> @@ -114,7 +112,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>>    				     LED_FULL);
>>>    		break;
>>>    	case POWER_SUPPLY_STATUS_CHARGING:
>>> -		led_trigger_event(psy->trig, LED_FULL);
>>> +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
>>>    		led_trigger_event(psy->charging_trig, LED_FULL);
>>>    		led_trigger_event(psy->full_trig, LED_OFF);
>>>    		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
>>> @@ -124,7 +122,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>>    				     LED_FULL);
>>>    		break;
>>>    	default:
>>> -		led_trigger_event(psy->trig, LED_OFF);
>>> +		led_trigger_event(psy->charging_or_full_trig, LED_OFF);
>>>    		led_trigger_event(psy->charging_trig, LED_OFF);
>>>    		led_trigger_event(psy->full_trig, LED_OFF);
>>>    		led_trigger_event(psy->charging_blink_full_solid_trig,
>>> @@ -135,21 +133,15 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>>>    	}
>>>    }
>>>    
>>> -static void power_supply_remove_bat_triggers(struct power_supply *psy)
>>> -{
>>> -	power_supply_unregister_led_trigger(psy->trig);
>>> -	power_supply_unregister_led_trigger(psy->charging_trig);
>>> -	power_supply_unregister_led_trigger(psy->full_trig);
>>> -	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
>>> -	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
>>> -}
>>> -
>>> -static int power_supply_create_bat_triggers(struct power_supply *psy)
>>> +static int power_supply_create_status_triggers(struct power_supply *psy)
>>>    {
>>>    	int err = 0;
>>>    
>>> +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_STATUS))
>>> +		return 0;
>>> +
>>>    	power_supply_register_led_trigger(psy, "%s-charging-or-full",
>>> -					  &psy->trig, &err);
>>> +					  &psy->charging_or_full_trig, &err);
>>>    	power_supply_register_led_trigger(psy, "%s-charging",
>>>    					  &psy->charging_trig, &err);
>>>    	power_supply_register_led_trigger(psy, "%s-full",
>>> @@ -158,15 +150,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
>>>    					  &psy->charging_blink_full_solid_trig, &err);
>>>    	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
>>>    					  &psy->charging_orange_full_green_trig, &err);
>>> -	if (err)
>>> -		power_supply_remove_bat_triggers(psy);
>>>    
>>>    	return err;
>>>    }
>>>    
>>> -/* Generated power specific LEDs triggers. */
>>> -
>>> -static void power_supply_update_gen_leds(struct power_supply *psy)
>>> +static void power_supply_update_online_leds(struct power_supply *psy)
>>>    {
>>>    	union power_supply_propval online;
>>>    
>>> @@ -175,43 +163,53 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
>>>    
>>>    	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
>>>    
>>> -	if (online.intval)
>>> -		led_trigger_event(psy->trig, LED_FULL);
>>> -	else
>>> -		led_trigger_event(psy->trig, LED_OFF);
>>> +	led_trigger_event(psy->online_trig, online.intval ? LED_FULL : LED_OFF);
>>>    }
>>>    
>>> -static int power_supply_create_gen_triggers(struct power_supply *psy)
>>> +static int power_supply_create_online_trigger(struct power_supply *psy)
>>>    {
>>> -	return power_supply_register_led_trigger(psy, "%s-online", &psy->trig, NULL);
>>> -}
>>> +	int err = 0;
>>>    
>>> -static void power_supply_remove_gen_triggers(struct power_supply *psy)
>>> -{
>>> -	power_supply_unregister_led_trigger(psy->trig);
>>> -}
>>> +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_ONLINE))
>>> +		return 0;
>>>    
>>> -/* Choice what triggers to create&update. */
>>> +	power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig,
>>> +					  &err);
>>> +
>>> +	return err;
>>> +}
>>>    
>>>    void power_supply_update_leds(struct power_supply *psy)
>>>    {
>>> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
>>> -		power_supply_update_bat_leds(psy);
>>> -	else
>>> -		power_supply_update_gen_leds(psy);
>>> +	power_supply_update_online_leds(psy);
>>> +	power_supply_update_status_leds(psy);
>>>    }
>>>    
>>>    int power_supply_create_triggers(struct power_supply *psy)
>>>    {
>>> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
>>> -		return power_supply_create_bat_triggers(psy);
>>> -	return power_supply_create_gen_triggers(psy);
>>> +	int err;
>>> +
>>> +	err = power_supply_create_online_trigger(psy);
>>> +	if (err)
>>> +		goto err_remove;
>>> +
>>> +	err = power_supply_create_status_triggers(psy);
>>> +	if (err)
>>> +		goto err_remove;
>>> +
>>> +	return 0;
>>> +
>>> +err_remove:
>>> +	power_supply_remove_triggers(psy);
>>> +	return err;
>>>    }
>>>    
>>>    void power_supply_remove_triggers(struct power_supply *psy)
>>>    {
>>> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
>>> -		power_supply_remove_bat_triggers(psy);
>>> -	else
>>> -		power_supply_remove_gen_triggers(psy);
>>> +	power_supply_unregister_led_trigger(psy->online_trig);
>>> +	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
>>> +	power_supply_unregister_led_trigger(psy->charging_trig);
>>> +	power_supply_unregister_led_trigger(psy->full_trig);
>>> +	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
>>> +	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
>>>    }
>>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>>> index 7a5e4c3242a0..68b65682b14d 100644
>>> --- a/include/linux/power_supply.h
>>> +++ b/include/linux/power_supply.h
>>> @@ -346,7 +346,8 @@ struct power_supply {
>>>    #endif
>>>    
>>>    #ifdef CONFIG_LEDS_TRIGGERS
>>> -	struct led_trigger *trig;
>>> +	struct led_trigger *charging_or_full_trig;
>>> +	struct led_trigger *online_trig;
>>>    	struct led_trigger *charging_trig;
>>>    	struct led_trigger *full_trig;
>>>    	struct led_trigger *charging_blink_full_solid_trig;
>>>

