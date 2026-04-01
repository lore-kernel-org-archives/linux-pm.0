Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198447B42F;
	Wed,  1 Apr 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063833; cv=fail; b=cAHe15wJGjslzCLpma68FqqMdYWBiYetCzIlQkSTCpbK3mK1/yRXA3eLpxs5iDkKuwXTJIs2aJ6ZvkeiCdMJehZbujf635zhEXdh6xP2peCgBB57iAM0SiV+7fvDNxhQzbXmC2KZpV5Dg7KrjpGthkfQfQCOirJ/0+v/xB6YPdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063833; c=relaxed/simple;
	bh=hH/dwQUjQpIHAaszpzYdyptizqjCNea05iyd9joJphg=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bVezA8y/cdgPFoNpB81mMUuHTivp3DfnMtxzIS/qPvahzIs98MF+596jUSN73kh0UKnbU5wA9RdbxRdzGHXlksJthUCZcJO36Gu4LR+VpLs4eGSVrunnRnKhu8nVkGWVr9XPPrJ5Y3K0uQMmlueq+zm5i5flGR3ulpQZzf3TB5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4WC+uwJ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4WC+uwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775063831; x=1806599831;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hH/dwQUjQpIHAaszpzYdyptizqjCNea05iyd9joJphg=;
  b=R4WC+uwJ/mP3xkpXyECAJo4GrwC2+MXsxribMNvbb9n+RIvInqiqtwA3
   i0F+BHN0IrvHSJGeZC4EXfOuXx/eb96K0q6Ct8+6/IjktRTynXThua1ib
   N68CNE7tgEOPwR3iy6Qub5N7ODKEdEZb6j7gpEQA70lGLBScPwrC8wNAT
   2q43wyZEIFo+GGR9FmFPT1E66tlN/8YHDGkFQdL7fbk9I88PyFrboQIue
   wwCoq3EjD+FKMkzyTVI9C5cwhNeyBIM0wv7r6X5tuwH4JrH/CWNNz+74B
   9Yuj0e64VZUKFl15i+MUc5aAyW7ptA2/bIPK/+DpPkeZIDS1tB1t2V6Am
   g==;
X-CSE-ConnectionGUID: HYPIEzsvTJ2hnp8JEKBjqg==
X-CSE-MsgGUID: jT4I8EDjROeXsX6jnlfKlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="98723042"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="98723042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:17:11 -0700
X-CSE-ConnectionGUID: 3INJWTFgSXO/Qqf24kZbRw==
X-CSE-MsgGUID: 0kQ4ZLoKSCGhw29TTUe/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231139865"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:17:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 10:17:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 10:17:10 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 10:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd5jMp6jXTvMikgL+MHgKSV2kgkhM1x28JYmpfF3TsXGnhJPX9Pukjf2qOGCm2nV2VN8e7U++PDSvvwKKr6Ce64LMQ5V3o4QGCIS/4JDjceIpK3a1XZtpj4K/2bCSdKabzF72H3SnCk9A2/zNQUpUyvAzNA0Qn3K1ntw12u0JCpPGzCMRFzlIwPygcQ9kFXGs7vHNkZBoQcGOIKtaX8zNE9M8EBpJDNKHWd3C3un4x9NetdTWHLfbEF1lXAkKWFFWcScuIjUMl0VXLmi2/eaxdo/iAZwbR3xoM5bzyjfni/0Lw87eg17cH9xmE37uBI5Ta+W4yFN081yprllR40YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pJhISPG3xh492ku3n8qhCI/dLyPDtYQszpAYsEbmh0=;
 b=gDawcnv5MLIeVblKVnff+13gXjWv4KhpAVLwUoFvZd+fOYr2cYpbhIN1LzvUKVEPl6O9ssImWmePAxgFMeKnWgVEXw4MkUW7Igqbd3Qtka9aZqhRds3uWOEqZNWxc3Nxw1efInDG0f2GtLMWriGKcFZJMFxI9KMgUwR/7PMovn7B0LRrWvhOxG02iG0vfvYGislL2URG532JNUHBMf0eBK+x3yiQEhI4BDTr5qnmzERG2bHsf0E4RvOJ/B1m6CBdGE18pw23tzo93tVIida7cHcgiZ2C9MUM/uD8rs2orQVjbipFwz+FixcqzHWEnVOUMHBng63Wbdzdaz88tMbhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 17:17:02 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 17:17:02 +0000
Message-ID: <b9a756b2-a283-41c7-9ae4-b139551205c8@intel.com>
Date: Wed, 1 Apr 2026 20:16:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime
 suspended for Intel controllers
From: Adrian Hunter <adrian.hunter@intel.com>
To: <alexandre.belloni@bootlin.com>
CC: <Frank.Li@nxp.com>, <rafael@kernel.org>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260306085338.62955-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260306085338.62955-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: c343f947-94e3-4a91-b5dd-08de90127dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: km2JBJUIRls6uswZrIXiSRpTGZepw59F9tUTzpBXgnD+wOrlRqPdvs4S2y9NsJKYVKfp4s8vS9B/1SL7XOJd9G4WIUlDe/IZVGz+45TEQEFoe+RVOdpxTfolxncHFlY4R4+V+V3BSxk6+tH9PV+VL58X6xevX7YaH5aMLaV9iFt+opbhmhfOsKCXsf+e8oVVT0q7NDTELqHHRZDl2OthelTa0rg/mSUsRJHp/SrppJt9LSjAMastgI1DS6rSSNUWHfE4EFqcOQuFKYtdSgbM73jIDr2rdW5B2zpo1a1Ed43ilA1Ort6t+bpHOEny2fDlxtrUNABeHUZbsZwQB1MUExi3dJw2SrrUpWn4T53UnsrUJJa8kd2qrsqcSTY12GCx5sfdDbwXbLBcD9EvikmhvmWuEufpth5xj31pM5iX9GVO9mmuiNaPoO4uvBr3uZ6/8wOIL7VgB37xN0wPzBGEBdazUa7y770swNaw+pw/S4D2X5P8FD4LcWXESFEFE5KSO+DfY5dGjY7mYytNOZmEbe3YdWXY9/6ygRfxyYcnPp+oqSX88JoVaKe6r7Fz2Qmbs+dxmfLRfpUYr6JCMFQ+4Muyg6Phb+8SKRF9qKaqVntOIdr1VYIVBuZkNVOBlUCcBZemZ5K+i19+ECEZZk4W7i34tCqfjX0hQGOnIqWEKAlqbvZ977jtIxQjdlVg/on+RytUksiH0nGZyxSDlXwty4BjEPqXflKs1DNrEM8s3cw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZIYXltTEJMSGhGaFBaL2ZZdzFPTUt3SUJZL0VGK2NsOXVnaHdzbzI5Smlu?=
 =?utf-8?B?N21UeXRKdStvUkZmZFFvSDdOazV4aDRRSFJLa0tSRm1QN2Rvc01vZlM0eHRD?=
 =?utf-8?B?K05ROFVtYmViNEFuY1ByU1VZak9NbHZGZHhTWnNsSFFIRENlVjlBZzFLYjVx?=
 =?utf-8?B?N0RIQU0wUlN1Mmt6bE9lS1JpeklZNmpadW9mZVp3QTlodVl6bUJjMEd5VzdG?=
 =?utf-8?B?cW1OcUhkM2VPbGZ1YXBzT05SZ3JIQmZNT0FxMlN2QURPNGdjSHZTZFJiS0hq?=
 =?utf-8?B?TnZsRDJrRTZJd1ljVDh2YWdyU1BUaEw4N0RaYitqMW1NbFQ1L3RPaC9PMU0w?=
 =?utf-8?B?L1JQL05QMFY5QlJUbnNUZFJTS3BCUC8xTzNSNXlkVjJPQ0R3NHR1OWNRajFG?=
 =?utf-8?B?bUpWTXhhUEs0Ylc3aERET0kwNWFaSkFvRDFRZE1FTk5lWU5YSFI3TkxWb1hP?=
 =?utf-8?B?RU5qTWFhTHBsT3VGc05zRGtyZ0NCdmdtUXJMbU4zbmhkemo4S0pVTTFJU3g2?=
 =?utf-8?B?bUx0Q0hyeDU3akpHQXkrMnViOW01NHdXUExDSU4xWGRNRWsyTE5CWVVpbmF5?=
 =?utf-8?B?bm1OTHZMQzFsUmM0NjFqdDd1UnFKQndmYUpwKzNHSGdDZ0hGK2hCQS9BODlH?=
 =?utf-8?B?UWlDVlRVS3plZm1vN2t1bmwyU0hqQUQwSlV0VHpqdmRobVFDQkJpTkdPVFl3?=
 =?utf-8?B?d3dJRE1YV1FwcGZrVWVXZmZlZUp6cVJZTGs3RnZWak9HYmt6T0J1R2J3WjFH?=
 =?utf-8?B?MCtlT20xUXdCSDZWMk9KaFNOUmVxR0xMRk9DempXbWtHYXBLS2xKbFlXV25t?=
 =?utf-8?B?YXV6MUZ6TGZnQzFFcE50SnRVeVhpeXY4YzMrR244QWRnZlg1U0Ztczd0YjR3?=
 =?utf-8?B?dFc4UTQ5VTY3U3QyU0JxbFBTdkJUZ0x5c1BIaTBlcFFGanMvRUhlOHBwZmov?=
 =?utf-8?B?VlBCTWx1MGdUZm40b21QcHhSc2ZjMy9CaEhTbjVKdkVEc3pOY3poN1hlWHBF?=
 =?utf-8?B?aS9CT3hXRTZxUTQ4RkVnUjh3TnhKNHlTN0hEUENETzc1WWs5WDd4STg0UjAy?=
 =?utf-8?B?U0I4WCt0MmwxUlFwMGhrdWZOWHBHemJmQUlYZzZkQ0pkVkFZL3pid29FYmlL?=
 =?utf-8?B?SnZ1WUo1dVM3WEJsWHlQRHNzRzdFY21jVXVpQ3p4ZTI5MDlXbUN2bUZ2Y0x0?=
 =?utf-8?B?NHM1N3I4UkR4ZW5OUjVOOHB1T3pudlpNT3pMZ0ZGa2dRMjlOZmowL05lRkNZ?=
 =?utf-8?B?a0tjZzRyTVRHZ0haanp0TVdLUW5GUWd4aDA5WEpSUTBPSXlwRlliQXdldDJy?=
 =?utf-8?B?NWUwMzJSZ2RUTUdGSTBoMHdKT1crTDU4WFJKNDZHYnhJQTRGbmxneTNBdEpP?=
 =?utf-8?B?VW0ySmlsQ1A0YVRnaENhNjJqcUpaUkplUjZ2aWVxSHNZQXV1am93MTF4ZVRi?=
 =?utf-8?B?R2xrLzhRZDhzRXZ1WEJyK0hhT2I5eTZMcVJ2R2hUNGE4UFplZlIrRWp5RmdU?=
 =?utf-8?B?ZmhBN25velZISXNGM0gzeHRUZ0VzZ3hLUU9TNit2NzVzWGRFcnJ6NENiT0Ji?=
 =?utf-8?B?aEZNTlhsUy9xNmhaMlhmT3Q5THNQaXFpSm5zbzZCT3VmUDhGeE1qcjVzWm1R?=
 =?utf-8?B?SUVyWC9ubVNvc1MzTGlSS0pERkNLdXpmZGVFaGVHblVKTmEzTXlYbHZoYjJU?=
 =?utf-8?B?OUoyejlwOUlZZUZESzF1VDg5TWhNc09WNk9HY3J2SDVQM1MyVUtqS25WWWhW?=
 =?utf-8?B?eXNZZDNjRk5ZRnpyVGtsODRDZTVnOVpqMnI4L3F5YTNiQ3E0bVRhRzRIb01a?=
 =?utf-8?B?VE9KWm5La1kzYzF6ZXBwTS9BWG44SC9aUlJUNmFqTTdlVE84SExsUXB5R3Nt?=
 =?utf-8?B?Q01aZzl6ZmwweFhrT0o5Ry9hWXR4Q2VVZ3Z5U2c4Ym1OeWdFNjF6emhqZEp4?=
 =?utf-8?B?M1JXVm1NMnNzRWM0eGxKU2Ivd2oxOHVpOGhrSW1KUDRKNzZMMGxDUWJoSk9k?=
 =?utf-8?B?VERVUENiMkJMSVV0b25QQlU2bFFDbzRjS3VYanRxRDFScVFqWVc3TDRTdE80?=
 =?utf-8?B?bGRDb0htL3RvdUI1UWtlRlhrTFFadkNtaVZwSUttZURkeUZZNUd3dlpOMmFs?=
 =?utf-8?B?VEVid3EwMFJCbllTR3ptYldLSzdPUlRHL01GMlRoRXl0YXVOdk0wRzVEc2hK?=
 =?utf-8?B?Nzl6bG1RWmgvb2RJenlzYlBTd2FTb1JSR3RrMk5McEQ2WGhsbnBxaCs1UVh2?=
 =?utf-8?B?RHpvQWY2VytqNEdua2FKVXhpUzgvRlJOM0xURlpYMDZKdS9IRi82eTF4Slow?=
 =?utf-8?B?WXVtTFJta2pFU2hxWlVML29uS2FKZlZxa3R2Q1NtZVhDVU41ZWNFMDRNcmE1?=
 =?utf-8?Q?o6kALZsD2rsDZs80=3D?=
X-Exchange-RoutingPolicyChecked: M0x8TqbaBQ1WAn8dcNPrigZp0/G3ZzvsO5OkV9VWhtmsxcPlTC73PXVvTrys3NF2OPE+JQTglHUiIObp04IRGsY/Wji605OrleVcGyY3z+eORbPCrY/ZqmTbQmZHdjD4JsxFzHzzOl0XGOFC5BUKVqHg/vnfSFtj+UZ30IwWfewwlcYPNOo+wrtb9r2kTUUAdYwxE663bhpx2ozzqZ8922F75GTFU3E/26IDUO7cYtg85sXHhDb15X3yy2h60XxL2e2WfQGujtDtNPs1cA0FmhZjFDm1xZK9d1LOD0UkaIQFTvhbIk2pmM5tuZ8RIi5iRpgYebqSG+OqCnBzWp7JEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c343f947-94e3-4a91-b5dd-08de90127dab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:17:02.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cwKGEcx/2UUa1P/TB9yFpdfp5X1zcgT+Mhaqursu4X0gpG52h+28ftWczrw8kQbQnvBUdY2GI0sdjHwmGZghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com

On 06/03/2026 10:53, Adrian Hunter wrote:
> Hi
> 
> 
> 	Please note all patches have Frank's Rev'd-by.

Can this be queued for next (v7.1)?

> 
> 
> Changes in V5:
> 
> 	Re-base on top of v7.0 fixes series:
> 		https://lore.kernel.org/linux-i3c/20260306072451.11131-1-adrian.hunter@intel.com/T
> 
> Changes in V4:
> 
>     i3c: mipi-i3c-hci: Allow parent to manage runtime PM
> 	Add Frank's Rev'd-by
> 
>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
> 	Add Frank's Rev'd-by
> 
> 
> Changes in V3:
> 
>     i3c: master: Mark last_busy on IBI when runtime PM is allowed
> 	Patch dropped
> 
>     i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
> 	Add Frank's Rev'd-by
> 
>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
> 	Remove unnecessary pm_runtime_mark_last_busy()
> 
>     i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
> 	Add Frank's Rev'd-by
> 
> 
> Changes in V2:
> 
>     i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
> 	Add Frank's Rev'd-by
> 
>     i3c: master: Allow controller drivers to select runtime PM device
> 	Patch dropped
> 
>     i3c: master: Mark last_busy on IBI when runtime PM is allowed
> 	Adjusted slightly for earlier changes
> 
>     i3c: mipi-i3c-hci: Allow parent to manage runtime PM
> 	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
> 	disabling runtime PM to instead causing the runtime PM
> 	callbacks to do nothing
> 
>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
> 	Do not enable autosuspend.
> 	Callbacks for parent-managed invocation were renamed
> 	from i3c_hci_runtime_suspend to i3c_hci_rpm_suspend and
> 	from i3c_hci_runtime_resume to i3c_hci_rpm_resume.
> 	Amend commit message slightly.
> 
>     i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
> 	Retain HCI_QUIRK_RPM_ALLOWED
> 	Amend commit message accordingly
> 
> 
> Here are patches related to enabling IBI while runtime suspended for Intel
> controllers.
> 
> Intel LPSS I3C controllers can wake from runtime suspend to receive
> in-band interrupts (IBIs).
> 
> It is non-trivial to implement because the parent PCI device has 2 I3C bus
> instances (MIPI I3C HCI Multi-Bus Instance capability) represented by
> platform devices with a separate driver, but the IBI-wakeup is shared by
> both, which means runtime PM has to be managed by the parent PCI driver.
> 
> To make that work, the PCI driver handles runtime PM, but leverages the
> mipi-i3c-hci platform driver's functionality for saving and restoring
> controller state.
> 
> 
> Adrian Hunter (5):
>       i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
>       i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
>       i3c: mipi-i3c-hci: Allow parent to manage runtime PM
>       i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
>       i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
> 
>  drivers/i3c/master/mipi-i3c-hci/core.c             |  35 +++++-
>  drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 ++
>  drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 135 +++++++++++++++++++++
>  3 files changed, 172 insertions(+), 5 deletions(-)
> 
> Regards
> Adrian

