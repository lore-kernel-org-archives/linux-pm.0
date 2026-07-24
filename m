Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976B238D52;
	Fri, 24 Jul 2026 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872710; cv=fail; b=YiFmJkrzQ8bQevpZWdod+5KaYhTzja6Wo+oQvZxVIwFOhuF8STWo4Eh7DAUhYavWkWBOVn2lR/powLDJkmv5PlpusbOyknurpywKvqy24WI0h3otWQKgabvVTTL7/23ZqAKiweMrzWw1jDtDOZ8XJ2lkM9a0dvaY6il5sZQUazs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872710; c=relaxed/simple;
	bh=w9xPKZWmMoOMAhU11r1/tFMS6UhUiLcrtILi61N0Gtc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9iMqeEl4mRXX2i4Wg7I/uhKR77lWMuTrYWYAuyLlgXNaHYDmq6XfS8RdZA6U90g37CN6kslef4yHPsAS4tgMwKqtfpk8B/1nHT73ZrkKbM4IgrAifCGWOKVBD0wj890KHq1RneBAqODUADb/GIYFJQ76xhqwIBYdv9wEoXgC7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnQNPg/k; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnQNPg/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784872708; x=1816408708;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9xPKZWmMoOMAhU11r1/tFMS6UhUiLcrtILi61N0Gtc=;
  b=CnQNPg/kbVZ5/9YU6gDVQ4sO7WdGVyX/FBrLjy3fiMQEBuYAfQH7eVro
   f/kuAAQSZ01xdy61zUnn6ftjDeKRHUcTwsnMKu/EvETzpD4ApWqWR6JkC
   zWtK+d0aWbyGKCpTrdp4rp+ReoM71P+FsG6x/mOPoZh6BxNi+EoRj8mdN
   HFVxV0JzpjcrrlUPnPMVIkIHfvvFHdck0rQpJIxkjz/nFzPxjU5x4UFYd
   1TDjZC7nO+wGKiqxmyFgfwZMKIe282OShBE7npLGmC7ghZ+FoWXcYx2ew
   h0KUMS3j36Q0ZZrrMec9ZLTYraxC10299qTmRnoUdgn5KvNPlFAFWbsae
   g==;
X-CSE-ConnectionGUID: 4HIccJ5FRfewgKM5kib08A==
X-CSE-MsgGUID: QI8ERAtKSwWpHs9gdKyh/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96683480"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="96683480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:58:27 -0700
X-CSE-ConnectionGUID: VThTSCNBSoeQtLGhgx46+w==
X-CSE-MsgGUID: fBBke6a3RxSimC3x+SED3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="255245892"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:58:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 22:58:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 22:58:26 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 22:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvHnoC6aORpgQ3NwC/y/2b/X25hsgH5XclLMlaEIYjNt+7ActCJtaqAhIMe9VbqEsphDC+K+OYU/dG3kRkDn3ngxIoJzL1rrCKIEWRdTW7r1J4gk7Ac1jgKb5gX7lQ2zZP/wQT0K+P5tEl2/VMRSmQym2cI9ZUdJ7Z/dZ9vsZzKEleicWxYz/cAvGPDXDTUOjrav8321edQOI4ZxvTEPSjjZaRWwGEsHGSo5dTPPvIQg/M858eucr0iCQ4IMn24boAzLNv1gwnRmznDrXAEqNZ/4vX9KbywljxUQid/XnHlj2oVVKXPtuUjRDsXPGrNaUirGAvS4KVbHVRgH5RnceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey3wSjjJs93Api1xkDDtQ2PjI/86KWju4BT7pC965w4=;
 b=DBgdvBLCvbVK7eSncsWcxN0M4p5LxzkkJqrinFyQZJzXu0g3tKWSXmUsKhsNTjQ9kU2EYQO1sF7bA3bfyOTQioiE3M1BkSo26FMGLsyS1PDz+Fp4YfnLQ0iT1hcbqnYSLoDgYUVb9vYEYvBQtSC8oIoOQ5dfy+ZY4o8OgHQQ6vAYJqf0CcGGqxeQehwKegTSjsi2vxoYPVXwwthIdrmRoKiS3W5XNc9F4zNDMfI54iX3PC8tDdOVk/8aA5pUIpjruoQKtaLoQodQBKDLSJwGf8q+9relbP/kJYOFlcWBF+zqdjlO31h3qfeEj5D3n+XhNW0tZp+ZMKpqi0P4kfuGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH7PR11MB6835.namprd11.prod.outlook.com (2603:10b6:510:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 05:58:23 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 05:58:23 +0000
Message-ID: <a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com>
Date: Fri, 24 Jul 2026 11:28:14 +0530
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION]: [PATCH 1/2] power: supply: leds: create triggers based
 on properties, not type
To: Steffen Dirkwinkel <lists@steffen.cc>, Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Steffen
 Dirkwinkel" <s.dirkwinkel@beckhoff.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, <ravitejax.veesam@intel.com>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
 <20260625-std-power-supply-triggers-v1-1-d80db570d329@beckhoff.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260625-std-power-supply-triggers-v1-1-d80db570d329@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH7PR11MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f93740-44d1-453b-c5c2-08dee94891f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|12006099003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lhto4Nqu5ZpuQ4yW3Es9GdAuPOh7T13YhQ3CtKPGrfFGsWji7y1gfkpBu/q9xN4lBZvD1/vVmJ0wZ3CGbKOlx8T2Q2Li0cm9+O1oA2r1oRx13h8LQgqugazZTCIpiLMtrnbjOQgrLve9Bt18AxQyDai2blU1fkrtlZAJ1mq7t8OQWIzhXpa/dkMGwvyL9CXtB/z6Jm3tReM/4X4bWDUBsYFHOmbEHH16c3AmBGb4fuP6LgDGezr93UrDyyMmjNp+YX6rp3s/pXcg2DzEV2cX9mYiV9+KD2a1kTKKjJtWpk3A54pbeum+OM3kKYntOv7vRLtrMtQWC1cFlGpt8mhwmbe704sZB8lEFQFg31HRUnd+t02yexS64aTqU6GDKMxW1kRr9npmQldanrAxEBNeqHHX6xGKXPWJuL2EyLmisgeZWWTBx8M6wKjxq1OiDiOS0SEhDZ0V9capfFym+dRpjI6EXQyfeJFFTj/KcutoC/+9mjHMEpcT7qbE0TrOvUNwNguXNMtZ4ZdElEtKpjt8qb8CD+BVTA6aizlkCAnqW3GyYJIonzD6zmv49tvyG/AYTziFIlxVRW4uL5OODJ2Dcl6WkV0X9IYI4Nlqt12xIL+G2nbhrjXTwGHoy3y9v/1Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(12006099003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnk3YW5HeHh6eXRXanpPNEdyeUw5MmJWMDlkREE2bWgwWk9COUc5OCtudG54?=
 =?utf-8?B?ZnVHT0lURy9ZNHJ4SFV1VjRXcVg3OTR0OGhqTDVFOVdqZm92WFZBTStSQ2h1?=
 =?utf-8?B?NXhUbi9rdnZGaEVpVFZDYjdUbDhVeWhmWURSamlxQmVaaUVRZXlncFd5NWx4?=
 =?utf-8?B?S0g4UEM3TWIzQ2p3YXJQNkpvZnV4VlVCNFV1UHBkNVpKMm1hZHZrUjJ0RlVF?=
 =?utf-8?B?bWdHWGlYc3JDZlFBZHlQQW1hZDBmelFkWUR3NEhPc2dyMVRTVFl0N1dHZWkv?=
 =?utf-8?B?Zkt0cVN0V2NRbEVVNC85c3N4TlpnaElFWFo3SW5FTTJ5NkNjaDAxMWZ4TmNZ?=
 =?utf-8?B?ZHJFVGFCM1lEemFKRUFRV2w5cUg3c3NHSmFtVENzdjl0a2hmY3IzKzc3S1NI?=
 =?utf-8?B?blRvaTFqbnRDTUtmd2xYUmpCWjVucS9MM1c3TE9scGtWTWY4elpwZVJYM2pD?=
 =?utf-8?B?dC80ODdVMHpFajUwM2Fza0hkQk5VbWt0V0ZJdUdYMnY0aXdib1dsSGg3ZDBu?=
 =?utf-8?B?SVRUS3VyeDJha2hxMDE1TFc2M2F1NVgrV3hVVE5QcFMydlRtVHNFOVI5Z1V3?=
 =?utf-8?B?S25wRjhMOXh1Y2lpN2ozemc4WVB0cUZnM2hOc2pxMkNLaGplNzU2K1J2Z01i?=
 =?utf-8?B?Szk1cmdhbUk0RXg2dEhVdHVtN1lUbXRwcFV2SDg1blhpMkpmSy84TjRLM2xE?=
 =?utf-8?B?elZacWdubHJhU05ScFBsWThHNDd1a1ovbWtUd0t3Vmh0WHFzQWFWbWQwUHpU?=
 =?utf-8?B?QW8xZjZlaERib29JOEpEc2dvZmtyZGFUMXdEclJVdG5PM1FTTmlqRDd0SVkr?=
 =?utf-8?B?NXFvRDFWRGo2cmZGckhSZ3N1OTNWTmtxaHJ6SXFORXprd1hnMUE1K3J3NzFp?=
 =?utf-8?B?RkN6TFhYdmVXS1AxWkYzNUI2cnNSWjRMUFNtV1RXR3hmQUJnNkdCc2wyNzU3?=
 =?utf-8?B?c2NtK09MaGVFL0pNV1F0UTFVbklST0xmN2ZBN1hoRHI5MHl6RFdnd2lwdmRS?=
 =?utf-8?B?SCtXRHBuUTdrdEdFN25LM3BTOTZYWG01bHlXeGJjZWdHUEZGS2tUdkVFeTc1?=
 =?utf-8?B?WXNPeFNnUXFvYmdLUHBIbmhXVXY0NzE1aEpheHZBM3hoa3lsRnhrUVZvMHV0?=
 =?utf-8?B?dFh2NDNzOFloajNyYWRTclpPUkdlcVAyQXZYbnE4ZWlqSVFINkFtRmJaNVc4?=
 =?utf-8?B?ZmlROTh4ZjNKY2NkRXU1Z2VqZy8vVXh0TGJmQjZGNERIbzQvTXJDd0ppN0ti?=
 =?utf-8?B?OTgzSGFWK2JYbU5Rc1ZHaFU1VXozeGxITnVDeXVEM2FzcVg5dHYvQTFRSmsx?=
 =?utf-8?B?ODJFNWhNNHRrMDhKNzFsUkZZelhzL2VGZEZCK1JGUWFrd05BNVcvK2FNWUZN?=
 =?utf-8?B?QmFPSmlWUExEK2U2a29sN3BOTGVjOUFOa2owOFcrSkVFTkNNNkVLaXhmNktJ?=
 =?utf-8?B?djRjK2FkMVV2Q3htY0x0ZWljOG9SZWZhY0J0ZGFBeTlpaGFieGp6RFExeEYx?=
 =?utf-8?B?TGJOaFBtcno5THdLYkkrZytpMVByR0JlMkQ5eW9kZ1hQdjlQOVhNUVhIa2ll?=
 =?utf-8?B?Q0doV0dpOTlyaVBBOUIwT1c4aEJkSUtwdGZObjM2MWtjbEp5T0luRWF0aE9B?=
 =?utf-8?B?Z0hPNWQ5VDNZa2VHOEJXaXVGN0p1MTFyWUhkQnFQajJnSnppTkFjR1M5SCtL?=
 =?utf-8?B?L1BpbU9NOUlPZlY4S3lBemdKM0pFdFozTkJDNEhRbHNlUVpBYVg0a3o5dU9R?=
 =?utf-8?B?RkpNSU5NQ245Y25oUTNDNExNbUQ4WlpDU3RtbDV0dnB1d1VqSE9Bd0lRcUk2?=
 =?utf-8?B?WWNjNERsYlpYVlZVcFlNTmNpcnlYd3pTQjVYZmwveG9ZKzg2Vm1ETWtZK0dX?=
 =?utf-8?B?RU9aZ3dSZk4wblMwU0tGZm9WSCtVK1BQSVlKN2hBc2grZGN5dm0weU9EcVN0?=
 =?utf-8?B?aWhybTZ3TFkyVVBIZ3NPemZXWVFIWFErQ0JlTUV0S0Q3ZzJzcWQzenJ6dG1t?=
 =?utf-8?B?M0l5ekV5cDdibmY2MnMxSTg2QWVWdmhKYldXcCtlUi9NVVBLRTJaUTdEcjFx?=
 =?utf-8?B?Y25kWXp5cEMvZ3hiRzBOb21IbGo5YVZGeGdRSEg0L1dYdm5zc0lhRGpFTDRt?=
 =?utf-8?B?bG5yLzFFeVpGV3lDWEl2RTZndHpOaWY2OE50STBlOUJSM3NyM3BjQWpFSWNl?=
 =?utf-8?B?N3dvRVVRTXB6OHk4YVRLcmNkVkpPRHlFN04vbUZMOVhpOHBxeGZiMzJrMkho?=
 =?utf-8?B?Mnp0UXU1WlU4UnV4SDJ3UThXYTBOZHZHdS9WamVHc24wT01qckp3VG1vYnB1?=
 =?utf-8?B?S21kSUhKWjA1ZzRsTlZMclhaazh0TFU2WFI5M210NGQ5ZXBEbENFMnYxRG1Q?=
 =?utf-8?Q?+2GmXW2P+gSe3n0Q=3D?=
X-Exchange-RoutingPolicyChecked: IZy+VtC9+eC5VBlpYAjG8mhyer5bZT24O1XSdVP5wdciZEeLq00mlEkvz09IPPBjbnYUmd7vRGXlPo3z6R58DMqOCmHQ03/18Zfav7lXVkJi9B2JIwalsuv4y+XX2xe+BAPfUdr94oQ5hT222Sw2Puu5wJX4O9pvOMrDYuy8Pxzp4YBa+gnhVQE/C466ci/i4ZyfFREUS4lSMBlyXSkz1dJhDV8N3Qy9J4HCpgO4NLo8iKmgu1Jr2XO5fl0CYeCuTDILwfYxUNQVOMruYaPU6klTdKiU3Z+EK6zval3155ZC1Y4/3/NwECy6N8XChdQFTTMjy2lud7HjW/RuKTpPZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f93740-44d1-453b-c5c2-08dee94891f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 05:58:23.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgJEN1JL/hnUCsW99yNW87prKHYuB7AYxKx4mhwuNi7ysUs46cXQ5EyrR/egnuvJQNsWqNLIaurQ0STRNxo0hYDxzLGkNB3/i+ZVYhWD1Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6835
X-OriginatorOrg: intel.com


Hello Steffen,
On 6/25/2026 10:37 PM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Currently only battery power supplies get triggers for other properties
> and other supplies only get the online trigger.
> 
> This changes it to provide the triggers for any power supply depending
> on what properties are available. Batteries will still get the same
> triggers if the properties are there, but now other power supplies can
> get the triggers too.
> 

This seems to be causing regression in our linux-next CI [1] since 
next-20260722.

<6>[   11.206334] ------------[ cut here ]------------
<4>[   11.206341] WARNING: drivers/power/supply/power_supply_core.c:1384 
at power_supply_has_property+0xed/0x100, CPU#2: (udev-worker)/324
...
<4>[   11.206524] Call Trace:
<4>[   11.206526]  <TASK>
<4>[   11.206532]  power_supply_create_triggers+0x4b/0x150
<4>[   11.206541]  __power_supply_register.part.0+0x3b0/0x510
<4>[   11.206547]  ? __pfx_devm_power_supply_release+0x10/0x10
<4>[   11.206560]  devm_power_supply_register+0x75/0x100
<4>[   11.206569]  tps6598x_probe+0x34c/0x6c0 [tps6598x]
<4>[   11.206592]  i2c_device_probe+0x19c/0x3b0
<4>[   11.206604]  really_probe+0xf1/0x420
<4>[   11.206612]  __driver_probe_device+0xa2/0x1e0
<4>[   11.206620]  driver_probe_device+0x24/0xb0
<4>[   11.206627]  __driver_attach+0x110/0x240
<4>[   11.206632]  ? __pfx___driver_attach+0x10/0x10
<4>[   11.206638]  bus_for_each_dev+0x7f/0xe0
...

Detailed log can be seen found in [2].

We confirmed that reverting the patch solves the issue.

Could you please check why the patch causes this regression and provide
a fix if necessary?

Regards
Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] 
https://intel-gfx-ci.01.org/tree/linux-next/next-20260722/fi-kbl-8809g/boot0.txt

--Bisect Logs--

git bisect start
# status: waiting for both good and bad commits
# good: [842870cdfa33b9191b46484a3264bd5126a90570] net: Enable BIG TCP 
with partial GSO
git bisect good 842870cdfa33b9191b46484a3264bd5126a90570
# status: waiting for bad commit, 1 good commit known
# bad: [b4515cf4156356e8f4fe6e0fdc17f59adab9772f] Add linux-next 
specific files for 20260722
git bisect bad b4515cf4156356e8f4fe6e0fdc17f59adab9772f
# good: [ce3befa9786f3e9eb3990cb6f6b497710bd10ec5] Merge branch 'master' 
of 
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect good ce3befa9786f3e9eb3990cb6f6b497710bd10ec5
# good: [efac7c4cbbafdd21f9866476e3f4e5e5bfae8912] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
git bisect good efac7c4cbbafdd21f9866476e3f4e5e5bfae8912
# bad: [a91e6d5412453d44dc4d59d62d3ce50b53122ad8] Merge branch 
'usb-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect bad a91e6d5412453d44dc4d59d62d3ce50b53122ad8
# bad: [b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f] Merge branch 
'kexec-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
git bisect bad b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f
# bad: [8a3f0f5b2aadc94d6300cfdd8daf3971decc1961] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect bad 8a3f0f5b2aadc94d6300cfdd8daf3971decc1961
# bad: [5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd] Merge branch 
'for-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect bad 5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd
# good: [db30c3e3e3c247b0b1e73449b7ead5dd19044c26] Merge branch 
'for-mfd-next' of 
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
git bisect good db30c3e3e3c247b0b1e73449b7ead5dd19044c26
# good: [406b652bf9c47d6e784fd2ab723e6798d322ef47] power: supply: 
rt9455_charger: Remove redundant dev_err()/dev_err_probe()
git bisect good 406b652bf9c47d6e784fd2ab723e6798d322ef47
# good: [5ec27fa6b9d937188a81724f09df82707cca944e] selftests: helpers: 
handle multi line in test_sysfs_prop_optional_list
git bisect good 5ec27fa6b9d937188a81724f09df82707cca944e
# bad: [353438b3107d56e36a642f117c2b4accc963abbd] dt-bindings: power: 
supply: maxim,max8903: add DC and USB input current-limit controls
git bisect bad 353438b3107d56e36a642f117c2b4accc963abbd
# bad: [741a9b09775517c76a5029c58a03725b414d7e20] dt-bindings: power: 
reset: qcom,pon: Narrow allowed reboot modes
git bisect bad 741a9b09775517c76a5029c58a03725b414d7e20
# good: [f97d9166048ddea147b5673330f9900bf08c725d] power: supply: 
sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
git bisect good f97d9166048ddea147b5673330f9900bf08c725d
# bad: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power: supply: leds: 
create triggers based on properties, not type
git bisect bad b04510c3af6dd34b2e8dcf303114d77d5e443cac
# first bad commit: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power: 
supply: leds: create triggers based on properties, not type


> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>   drivers/power/supply/power_supply_leds.c | 88 ++++++++++++++++----------------
>   include/linux/power_supply.h             |  3 +-
>   2 files changed, 45 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
> index 1548aaba3362..538cc0440e53 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -17,8 +17,6 @@
>   
>   #include "power_supply.h"
>   
> -/* Battery specific LEDs triggers. */
> -
>   struct power_supply_led_trigger {
>   	struct led_trigger trig;
>   	struct power_supply *psy;
> @@ -89,7 +87,7 @@ static void power_supply_unregister_led_trigger(struct led_trigger *trig)
>   	kfree(psy_trig);
>   }
>   
> -static void power_supply_update_bat_leds(struct power_supply *psy)
> +static void power_supply_update_status_leds(struct power_supply *psy)
>   {
>   	union power_supply_propval status;
>   	unsigned int intensity_green[3] = { 0, 255, 0 };
> @@ -102,7 +100,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>   
>   	switch (status.intval) {
>   	case POWER_SUPPLY_STATUS_FULL:
> -		led_trigger_event(psy->trig, LED_FULL);
> +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
>   		led_trigger_event(psy->charging_trig, LED_OFF);
>   		led_trigger_event(psy->full_trig, LED_FULL);
>   		/* Going from blink to LED on requires a LED_OFF event to stop blink */
> @@ -114,7 +112,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>   				     LED_FULL);
>   		break;
>   	case POWER_SUPPLY_STATUS_CHARGING:
> -		led_trigger_event(psy->trig, LED_FULL);
> +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
>   		led_trigger_event(psy->charging_trig, LED_FULL);
>   		led_trigger_event(psy->full_trig, LED_OFF);
>   		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
> @@ -124,7 +122,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>   				     LED_FULL);
>   		break;
>   	default:
> -		led_trigger_event(psy->trig, LED_OFF);
> +		led_trigger_event(psy->charging_or_full_trig, LED_OFF);
>   		led_trigger_event(psy->charging_trig, LED_OFF);
>   		led_trigger_event(psy->full_trig, LED_OFF);
>   		led_trigger_event(psy->charging_blink_full_solid_trig,
> @@ -135,21 +133,15 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
>   	}
>   }
>   
> -static void power_supply_remove_bat_triggers(struct power_supply *psy)
> -{
> -	power_supply_unregister_led_trigger(psy->trig);
> -	power_supply_unregister_led_trigger(psy->charging_trig);
> -	power_supply_unregister_led_trigger(psy->full_trig);
> -	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
> -	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
> -}
> -
> -static int power_supply_create_bat_triggers(struct power_supply *psy)
> +static int power_supply_create_status_triggers(struct power_supply *psy)
>   {
>   	int err = 0;
>   
> +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_STATUS))
> +		return 0;
> +
>   	power_supply_register_led_trigger(psy, "%s-charging-or-full",
> -					  &psy->trig, &err);
> +					  &psy->charging_or_full_trig, &err);
>   	power_supply_register_led_trigger(psy, "%s-charging",
>   					  &psy->charging_trig, &err);
>   	power_supply_register_led_trigger(psy, "%s-full",
> @@ -158,15 +150,11 @@ static int power_supply_create_bat_triggers(struct power_supply *psy)
>   					  &psy->charging_blink_full_solid_trig, &err);
>   	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green",
>   					  &psy->charging_orange_full_green_trig, &err);
> -	if (err)
> -		power_supply_remove_bat_triggers(psy);
>   
>   	return err;
>   }
>   
> -/* Generated power specific LEDs triggers. */
> -
> -static void power_supply_update_gen_leds(struct power_supply *psy)
> +static void power_supply_update_online_leds(struct power_supply *psy)
>   {
>   	union power_supply_propval online;
>   
> @@ -175,43 +163,53 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
>   
>   	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
>   
> -	if (online.intval)
> -		led_trigger_event(psy->trig, LED_FULL);
> -	else
> -		led_trigger_event(psy->trig, LED_OFF);
> +	led_trigger_event(psy->online_trig, online.intval ? LED_FULL : LED_OFF);
>   }
>   
> -static int power_supply_create_gen_triggers(struct power_supply *psy)
> +static int power_supply_create_online_trigger(struct power_supply *psy)
>   {
> -	return power_supply_register_led_trigger(psy, "%s-online", &psy->trig, NULL);
> -}
> +	int err = 0;
>   
> -static void power_supply_remove_gen_triggers(struct power_supply *psy)
> -{
> -	power_supply_unregister_led_trigger(psy->trig);
> -}
> +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_ONLINE))
> +		return 0;
>   
> -/* Choice what triggers to create&update. */
> +	power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig,
> +					  &err);
> +
> +	return err;
> +}
>   
>   void power_supply_update_leds(struct power_supply *psy)
>   {
> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
> -		power_supply_update_bat_leds(psy);
> -	else
> -		power_supply_update_gen_leds(psy);
> +	power_supply_update_online_leds(psy);
> +	power_supply_update_status_leds(psy);
>   }
>   
>   int power_supply_create_triggers(struct power_supply *psy)
>   {
> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
> -		return power_supply_create_bat_triggers(psy);
> -	return power_supply_create_gen_triggers(psy);
> +	int err;
> +
> +	err = power_supply_create_online_trigger(psy);
> +	if (err)
> +		goto err_remove;
> +
> +	err = power_supply_create_status_triggers(psy);
> +	if (err)
> +		goto err_remove;
> +
> +	return 0;
> +
> +err_remove:
> +	power_supply_remove_triggers(psy);
> +	return err;
>   }
>   
>   void power_supply_remove_triggers(struct power_supply *psy)
>   {
> -	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
> -		power_supply_remove_bat_triggers(psy);
> -	else
> -		power_supply_remove_gen_triggers(psy);
> +	power_supply_unregister_led_trigger(psy->online_trig);
> +	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
> +	power_supply_unregister_led_trigger(psy->charging_trig);
> +	power_supply_unregister_led_trigger(psy->full_trig);
> +	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_trig);
> +	power_supply_unregister_led_trigger(psy->charging_orange_full_green_trig);
>   }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 7a5e4c3242a0..68b65682b14d 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -346,7 +346,8 @@ struct power_supply {
>   #endif
>   
>   #ifdef CONFIG_LEDS_TRIGGERS
> -	struct led_trigger *trig;
> +	struct led_trigger *charging_or_full_trig;
> +	struct led_trigger *online_trig;
>   	struct led_trigger *charging_trig;
>   	struct led_trigger *full_trig;
>   	struct led_trigger *charging_blink_full_solid_trig;
> 

