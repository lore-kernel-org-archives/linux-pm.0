Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC9E55A;
	Fri, 10 Apr 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797434; cv=fail; b=fGxikF/NZxNL/HElAvmek+1OzwVOQqSgmA1i3/lKbIlX4Hyql2EP+8AUpfE3HBIztbtlHRWn9kldDxkByXjGKsn06qVZCPDUrjO+z5SG9G6PYW61kklFTWQoheZHIJBnJpXt8BbGQPLTi9qYmrd3a5tUqNKfAe1zBt4uXiX68pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797434; c=relaxed/simple;
	bh=7RRs4+5wouGExWh1u6YJ2B8r2ubtWi58yhqVQMeQM38=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+0QemkYnu5rgwMC3suM6VQYwq7PmNUS/hWAe1P3feQsdLudJXAHVZMMd8bp48Ls9mkKCVwQZ7uyDW1pXhzX5XbzTY+4bXlx9Yd0uQpvj6RQwJ1v077lrl2qP02j5qgwO6y1whaXIqHwmifdvnWFzDCZCD3/didAkaHPmqvHYrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkS+it6X; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkS+it6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775797432; x=1807333432;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7RRs4+5wouGExWh1u6YJ2B8r2ubtWi58yhqVQMeQM38=;
  b=nkS+it6XkMpYi0uHLGAiUKoXdPFRhisRzVfsWBRM1d62j49oMhPjgDIW
   3o/+s1X/w6K+BofIKDf5ZzMRXwMo0YvWxpWusfATiu+dr2YALubzFdGtN
   oVCKSD5GPr2ArM2Q6jUv2Zp2kSXC+xemozUSw/V5ZMf5w64H86vsfVaUy
   PppxWXc4Hl17yH9MIesjGYUN9XqTan3w5ejUHWfbRdQfxvKaqYHy1it0V
   sWMizI/hkpIoXaudUwdLJnIW3ob/j6+DloPl3Y5kmSJyPaTgJk7ISln1l
   ACEbFF6I0Quez1tczDbNO36tk06d86lJwcdTKV0IdYRicHfRXs3N/m/W9
   w==;
X-CSE-ConnectionGUID: vFkBJoWvSYefYxg+e+La3g==
X-CSE-MsgGUID: +zYRp8rwS5SN8dysmcyfdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87099604"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87099604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:03:51 -0700
X-CSE-ConnectionGUID: qDyN/AXvQySGTIGNcEYWnA==
X-CSE-MsgGUID: B9dWxpU+SwewpfSWoZONNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="222488333"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:03:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:03:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 22:03:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 22:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfy8FeHMJU2s1fzfkBzeKMJdnIArujpwAdSZiUjFxPefkNWeuRYyHFxQGsW/whCZA5TETBrPiSb9efum0Vohy6xic8l582uwL3Vd5yCmNXE6BA4TuCRRCr9kwQEtlBqbfznlNy7vRaWyjUMpGWTtxuXu+OB0WvVFzycXTWpYCSx3RgQkDthCR8giKZYEjhHMDsIYL3MSVjBrZGyLTEKw5JSvHDkMB4PcYD4+zsnDTXousVLFGtUlKx+gLJ20vd2CCWUs/UiI17Zk9/QgwRF2DLkdZUgxsuOcDWIDUDK3qggW0vzbEgBRxpaffUBH6vV4UgAJ3wbFa99bQaEBZZjzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxUoHEo0nqhA+FcX7NY6pEng/nJ5IO6r4/DkpVmjW3Y=;
 b=T0v4RO/IEo+wsHJhDRWBaOQLBys3Crz5zj4T4J47NGQuE05/hOIzWlbbJXUsKvITwiehaCPoveFjyjXguHNl9PG60wUge5MPvjuT2Uo5dYikAobhnW5uOgPhVm51eNqmtEuMZ0Cs7ZKRjvx8Lm7FNPiyY94AfB7FDSDCpcAPdSc7vedxPosoIj+828vGjSoOeWW6EiVlocwQEpLbHimHiF9IuVSycn1ZWSGUs1YBvm0DTd/mrkEtucZr8iC5P7ajs6mz8Uy9dUKxyz6a89DTEbJZ2cBvzUqAhkVBCrCv0b0H+4wI2oHAnwk+ZX1wk89PHtftIQxFqQJXIOBI/7Aong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 05:03:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 05:03:45 +0000
Message-ID: <4f66cf15-7780-4b48-b5ff-ec39783219c6@intel.com>
Date: Fri, 10 Apr 2026 08:03:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime
 suspended for Intel controllers
From: Adrian Hunter <adrian.hunter@intel.com>
To: <alexandre.belloni@bootlin.com>
CC: <Frank.Li@nxp.com>, <rafael@kernel.org>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20260306085338.62955-1-adrian.hunter@intel.com>
 <b9a756b2-a283-41c7-9ae4-b139551205c8@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <b9a756b2-a283-41c7-9ae4-b139551205c8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 73da6041-5c69-4416-726e-08de96be8b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kKBp2KJ2hEAT3rIyUHt63GvLBTqQGIwzl7tsKJpdxnrcK2wUqp4cDu/rUPWKRShqi3XRyy/76YH76Lvz0Fy4cNGxNE5wCqXYvmAaZtLt/cGQREnTJ7rJoMw/9H/cqkCchy+xqpMoCwR+Lu+o94FylGfogDwD0zCg6D4PD19K2VPvBgB8Vzg+YA2p0U0ACdyMTiL2A8fSraanHdZ716cMXcUzUnqvNw91rC6NsffoYbaNrn3LwSM8B1q57qYmg1qz3apkhsnsVjGYzTznfEIo+qvibNL2e1cf382cMYOdL9t+TbbXBsftqu1zTuISShOM5E4d7kS3OK4exY6D97ZeC2BMZyoqHpOUYtBOuRlaYEh3v3T6EqWzk5+UFZvBTQNxSQKSDoPcLegBtI6x7TZ278Ieg2z3rysr2XgToQvwBnrMXiW+CNTTzhdeMdBt0GiuxtQucO7pxN1uyXyE/GGsFKXuMPSFCUIzP3hqJpR5rc1y6VaT+EBK7s3DHsiZJtHveftUKwsunJM+8ncARQVu3ZQcGlyQBKEuTsrxQj+w29PnyOLIZhUAJCjsw9gAOBXOEtSZD8HgrJi6bwrijmsOmbUPGBmeCwHw7gh4EnQGskJuK8oR7XvUW81mAAgdVl1xQ1DByT1LCIwt1wyQ1uswyY6gg73xjxro4hwKksnc13P2Zs8BfhUS4KP0Dg7wuAGk641/m2xaGnFiGYdxCRxy1T1hQiURzIxNYzy8QysQvZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZEdnZEdTN2QU13S1dHM3MxbHNtVmEvZk5TcnFaZGo1cW9VSEl0ODJDZk9p?=
 =?utf-8?B?ek10OWg1bitzMk1oV3RIcWtMTFdlbFZ6d0dMcFFYdE5tbnE5ZS9ieEVsSjk3?=
 =?utf-8?B?aFhoN2xlT3VBQkxlcmE0aFJnaUkzczVEMHpoVlpPQTgzaHF5SEV3VEhpYVZY?=
 =?utf-8?B?VXVpYnpXYnJ5c2dWRkdERThoMEUzYmp6WGloRkIxWnhTeUtRRE5UUFE1RVFz?=
 =?utf-8?B?L0s5bXhHUS93T0NkMjJvandmSkpVbGYzVExRVm5sK2xJbGxIcUhTTW5kNUhy?=
 =?utf-8?B?STlwayt3Ymkvc2ZYczF5SGo2UndhNVZFR1MrWXRvNXM3ZVhLMHBHeUo3R3NX?=
 =?utf-8?B?UHFoQkRtMnh2MWpzdWdwUDVSczZvbWVOeFMyT2drOXdGMVpTK0owTmJkeE96?=
 =?utf-8?B?M0NjWUVXS2lFV2htNFdLV1BNNWpWMzFoUk1jUkJ0UXhJSUlXWlVKVktGL3hU?=
 =?utf-8?B?Tk5kSE5USXpWSktIenhZekdEMVBNVHBmTGUxS216c2RENThUeXRXc2pScXZB?=
 =?utf-8?B?a2JNYnB3YzZtdDR4UGQwZHdRSUVva29YeU4ydGR6aWFDd09JWlcrbk9CbnVi?=
 =?utf-8?B?bHlBdnR2OWwwNStzRk02VUVsWERxckdCZDBPcFZLTklqMnV2SzhuN0pxc3k5?=
 =?utf-8?B?ckpyWTVic2ZZRUFQNEdzbjZOeU9laDhrSzliMTZuRkM4Mk1RdC9tZ0x3NXNq?=
 =?utf-8?B?cTVDNkErTGdoaGNYa2c3dkJuemNCc1RRREdSQWRsb0Rnb245YnZpUG0zSENG?=
 =?utf-8?B?MEE5MWxna2I3WXpCYXlCT3graFpMdzFubmZNRlQyR1VnVUxTTHZMMGphNEtC?=
 =?utf-8?B?bnZ2WEIwbmxraTNiZzdFQm5GM3BneWVuUWFJakZSOVl2dEVIL1NwWmlLS0M0?=
 =?utf-8?B?SUlpTjYwOGh3aDhXQzhtS3V3cHFnN2hLYkwwQ2s0eFdtZDNySXphYVkwaUlG?=
 =?utf-8?B?SHYrcXdsTzdDUllNZnlIVzA0YkRhK3VVRlo1aldzdll5OEgzbWlVdkRKTlNJ?=
 =?utf-8?B?bE9ucW0rU0JZMlMvbHc0Q01wbDl0aFpaVDczMVMwcXVFai8rZUVLenhKdmY5?=
 =?utf-8?B?RndXUGJrSzJONjl1VWRoMEgrMlpzTkhTL1lKTllScm9ZcEZlU2dhTko5Y2V1?=
 =?utf-8?B?VzdYSFVqSEpNQ0UxS0I5cEtyNXpRNVlNYjY5elJYVXEvMWlZcmErZzB4dWtW?=
 =?utf-8?B?ai9kR2xGTEthN3pUWmdCR0loM3VtQ3JSYUhxY0N4WEx2a1ArWUwzMHdZeDl1?=
 =?utf-8?B?b2ZHTzRrQ3hYVlQreHB3UlExenVaOHhOeklZQ0Z3V1FsZkZZclNCOHlTVzJv?=
 =?utf-8?B?QlVIbkNHUzJ3NXZUL3Jza09jUWM5UnYybE1oaHcxNEJIczQ2alZ6QTdLNmIx?=
 =?utf-8?B?WHVjU1BNei8reW1Wdlpld0s2Z1hia1hIeWFWb2lhVDRUN0poc1VkNnZYWVg3?=
 =?utf-8?B?L2gzc2pmSmlQc2FpK1FhVUI1Nk9ncUo0d0ZnajYwT05yRUhWc2tvRHFVQ0dl?=
 =?utf-8?B?dFlDRVJVdEt4YTM2aW5seHJXbG5CMmRubDk4c1RYV0t3ZjZHMDIvNCs5VTZK?=
 =?utf-8?B?emdKZkF3amQzNTdwZStiQ043eC92T1RkRTBjUFhXSXR4WWlHNCtiK3Q5dnF3?=
 =?utf-8?B?UWh2REk2S0JhZ0doR3JXNVgrNUJSMElaZ3lKL3VORm1Qa2Q4TUIzS2JlMGNE?=
 =?utf-8?B?R0dkVno5WVBMam81Nk1mR1ovWEFuY25KaCsyZFBVK3Y0ZHlPUWRiaUl2VVF6?=
 =?utf-8?B?L1l2OXdVRXVsUFdWeXEyV1F0VjMxUUl4QUgvdHJTN1kxTXllS3JoSDJGSmJm?=
 =?utf-8?B?WEZhbElOSSt5bkdXWFdjbWVhTzFSVzAyZUV0dUEyUXd1QXRYcnY3R3BZeUFk?=
 =?utf-8?B?Y0o4bjZBRStnaUI4VlJ1cWtFY0ZvanFVSU5WUlc3MHJ6R1lIdmNPRE5qMXdj?=
 =?utf-8?B?UXoveWd2Q0hjVHhaZ1JpbnQxU1NYSEM2YW9qTzBFTWFiS3l4QkxIMnJaUlZt?=
 =?utf-8?B?NGxLRTZXUGRUN2dTSW5BSTd4bm5qR01EazZaK01peG12YUp3Z2Jud2VJNTBD?=
 =?utf-8?B?RXV5NVVjRmp3TWtqekd3dCswWldLSEpsRDZ4T3I1QjVjTXg5OHRTZTFnZnpm?=
 =?utf-8?B?MTB6UTNxTG9yMjF3VWg4L0tFRDBtODZmcmVMd0ptYnpLWVBFTkJxanJVL0ZJ?=
 =?utf-8?B?RWJBdStkcEJERmdZRkZ4Y08yeStORG1GWnZxVTJuQm11S3VMR0dQdjNaU09l?=
 =?utf-8?B?NTZDNzF6bkJ5ZXFkMUJaTS9GRzRDL29aMElNc1hMd0YxR2lSay9qUDdXeThu?=
 =?utf-8?B?NFUzUlA4RWJ2WlVZRFFPK1ZyRjVwYThhNHhCU05McEZ4YmNnM3RIQU01N0Z5?=
 =?utf-8?Q?YqA3GPeXWgpWxksA=3D?=
X-Exchange-RoutingPolicyChecked: HH464j1K97gRhy41S5JDZvaWzRv6PNXgDBIMCAsuO17Bia+Dy1wTbj6zdoozc9bigRmXWevuZihUyRBwoLOZmIwRZcglFZ3yk1+s3OYpFD9wAO5oQiiRQWcARGQG3HFZy+emRolMyN2wX/O0AP5tmlvI+5JI7fdF+1uwTcHHDsre7S+a5zu/kND6LeKFy15GypqkK3ComQ5EUTz7B3zsaiDpV+C4VXvWGIECXPKv/HJwR/nwrqs5zjBKHI0LtFVG9D6kJKOuJa5DlwlfYUm8g3OdVTum4coghAUlfR+v9rWPbL2XU27csWl6xdVw8EAz00zgl0Ds2xLo70fnVVdRQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73da6041-5c69-4416-726e-08de96be8b28
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 05:03:45.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdcZ4rSp+0LrMsV5L/6nw+jfH3IzMTjQMVADYqVr23NUjNkiJqw6i7d7fU6v5/USXXJ2uC9ca15elzJE5GCv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com

On 01/04/2026 20:16, Adrian Hunter wrote:
> On 06/03/2026 10:53, Adrian Hunter wrote:
>> Hi
>>
>>
>> 	Please note all patches have Frank's Rev'd-by.
> 
> Can this be queued for next (v7.1)?

Any update on this?

> 
>>
>>
>> Changes in V5:
>>
>> 	Re-base on top of v7.0 fixes series:
>> 		https://lore.kernel.org/linux-i3c/20260306072451.11131-1-adrian.hunter@intel.com/T
>>
>> Changes in V4:
>>
>>     i3c: mipi-i3c-hci: Allow parent to manage runtime PM
>> 	Add Frank's Rev'd-by
>>
>>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
>> 	Add Frank's Rev'd-by
>>
>>
>> Changes in V3:
>>
>>     i3c: master: Mark last_busy on IBI when runtime PM is allowed
>> 	Patch dropped
>>
>>     i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
>> 	Add Frank's Rev'd-by
>>
>>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
>> 	Remove unnecessary pm_runtime_mark_last_busy()
>>
>>     i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
>> 	Add Frank's Rev'd-by
>>
>>
>> Changes in V2:
>>
>>     i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
>> 	Add Frank's Rev'd-by
>>
>>     i3c: master: Allow controller drivers to select runtime PM device
>> 	Patch dropped
>>
>>     i3c: master: Mark last_busy on IBI when runtime PM is allowed
>> 	Adjusted slightly for earlier changes
>>
>>     i3c: mipi-i3c-hci: Allow parent to manage runtime PM
>> 	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
>> 	disabling runtime PM to instead causing the runtime PM
>> 	callbacks to do nothing
>>
>>     i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
>> 	Do not enable autosuspend.
>> 	Callbacks for parent-managed invocation were renamed
>> 	from i3c_hci_runtime_suspend to i3c_hci_rpm_suspend and
>> 	from i3c_hci_runtime_resume to i3c_hci_rpm_resume.
>> 	Amend commit message slightly.
>>
>>     i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
>> 	Retain HCI_QUIRK_RPM_ALLOWED
>> 	Amend commit message accordingly
>>
>>
>> Here are patches related to enabling IBI while runtime suspended for Intel
>> controllers.
>>
>> Intel LPSS I3C controllers can wake from runtime suspend to receive
>> in-band interrupts (IBIs).
>>
>> It is non-trivial to implement because the parent PCI device has 2 I3C bus
>> instances (MIPI I3C HCI Multi-Bus Instance capability) represented by
>> platform devices with a separate driver, but the IBI-wakeup is shared by
>> both, which means runtime PM has to be managed by the parent PCI driver.
>>
>> To make that work, the PCI driver handles runtime PM, but leverages the
>> mipi-i3c-hci platform driver's functionality for saving and restoring
>> controller state.
>>
>>
>> Adrian Hunter (5):
>>       i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
>>       i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
>>       i3c: mipi-i3c-hci: Allow parent to manage runtime PM
>>       i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
>>       i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
>>
>>  drivers/i3c/master/mipi-i3c-hci/core.c             |  35 +++++-
>>  drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 ++
>>  drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 135 +++++++++++++++++++++
>>  3 files changed, 172 insertions(+), 5 deletions(-)
>>
>> Regards
>> Adrian
> 

