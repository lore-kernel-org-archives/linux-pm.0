Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7441D655;
	Fri, 24 Jul 2026 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888228; cv=fail; b=QuGfFdFwHVVSAZYjfGtL2rhAPnleAoW5afxjqg3GJt5m4WwH+gM7WGohVqjjGF2Z8by1unY6SzVWOlPkvG31huvxDjsPSuqGRwIxoDWlMxnOpft+bLpazzdotIDaMidJsOTC0+daxL2GLzwjS8WSPI5ruM/1TQzAhf9HVJgu6Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888228; c=relaxed/simple;
	bh=ScqY6otfWW+mxLjE9Sw5ny+DJHum1tiL90b35BFrDhA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TeB0OShQ9LhFWIiDaLZZ7Zj7iVwh2Fk2v/2zdAxAfjYh+Fi7MylBVEBdbCigLbRzTRMrsfh06akVZb9RPVdAYKpV82hQzKKlaLnItT5RvLw/IOTlExwChFGnsQ2ZQgmLsIDNL7R+4TlpEvDUeJEPsSv6jjHKIjyWhB92F6uVVH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i66AWzWM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i66AWzWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784888225; x=1816424225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ScqY6otfWW+mxLjE9Sw5ny+DJHum1tiL90b35BFrDhA=;
  b=i66AWzWMeyzPy7G3mMabZb88yCJOnxh7CbmurijH1cfgMSUQi69n2g+v
   /hRZnlFjzRdIqtIYhZp6z4vwW8HZfgf6pfi4aiBrRm4zl0mkvSqu4+vvl
   zaubM1X1tS9GTtdgbOWv0QagoDr0N1yXRMP0B9RkPxVPSwcsSyONe+ljv
   M8+4T+wZ4arpdmAUqdHxFX3wzjgzMEZfHcDnn/xNB6VgKc6ShWjA1JWXk
   X9Az53x0yDPGgqA4vrcH8kT4O4w71UHxKLjQugPMwxPbnebzEwg1+gfua
   lTsuXEoAXWZN9JpEI/817fR7F6pl/GEs9AsPzSWQClED08PARIcMcN1Ac
   w==;
X-CSE-ConnectionGUID: E354ZFl3SrOnxFF4CG7S7w==
X-CSE-MsgGUID: UzagC3NwQT2y6ILpDpJBJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96217639"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96217639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:17:03 -0700
X-CSE-ConnectionGUID: 8hQmk/2iQlONfnLOB5Z/xA==
X-CSE-MsgGUID: e0K817pzR66D3swDQQsAXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="254362255"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 03:17:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 03:17:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 03:17:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 03:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxbVRrGCLWZAWdpYX00vNTnYeViRGUiOuHjqzs5JwuZk8ZUUpIQdGJKJUcfRlsyPDb/sIE4+1yr+rL3UNM6UK8dT0g8MEW5INI+ejMN57y9lDPh6OvSO31k8Q4xhHKBasksB7TBrUHVK2HKWgdKAiaC9ZdekJsnK37M2XHB7++eKbPhNq6yplLgXcDJAnu1HEdV5Zi9imLHO6ypR0VWuC5AOexEcG2hrpOU6rfj477KKfEY/8z534EuJ+oSmxLVcGlVtqBCkOQ6KqZyqtEeSyRLbK5JFXq8wwwuWSJp/BpLeaRFYPQQzR5xRADmsda7nERxRCLruirjFgYQVshdpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWlnj5XbZJTlMkEz2YLDysWXdvyWb8xrv+7EXLExrNw=;
 b=ZKCod4OaRwaLHPEUE2e6xTuNNSiuyqNL9xV4T5Dy5lc9UfnFlclD7J8V/1ReZNplgR8R3fgtBknN7n/zYMvvj8YAHSf4211Pfk15DEMeI6MQyqx4ttSYuVtX/2rRHhsvcFvGAe42bPJGWzm7jBHZ6tPsNfzmmegPpn+m/F7V1QNhEJ+q+HYUfbOY/l8oyZzENDtv/UashOjwBbDCTXHYYBGPcjzIhQW8M/yFyguoaXRw4f+IYa+1RGUgZZKt8Xz0yE+WouqjOYub5NlpcTbC9WWdteIWfpfEy6+bmPBPBdWNLluFQGxmbCk3FT4mMXgHew5mBlp5MP9ScpKdx0/IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 10:16:48 +0000
Received: from DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825]) by DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825%5]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 10:16:48 +0000
Message-ID: <a3fbfc29-3591-4e20-a006-425986d95319@intel.com>
Date: Fri, 24 Jul 2026 15:46:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: hold extensions_sem when creating LED
 triggers
To: Steffen Dirkwinkel <lists@steffen.cc>, Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, Steffen Dirkwinkel
	<s.dirkwinkel@beckhoff.com>
References: <20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260724-power-supply-triggers-lockdep-v1-1-9b451b1f1916@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To DS0PR11MB7631.namprd11.prod.outlook.com
 (2603:10b6:8:14e::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7631:EE_|CY5PR11MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b2f7c6-f531-45d3-6782-08dee96caba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EfGpZN+UP9o/e3sa60HQyqs2vsugOGaT2BmlYmL7B6oJYBcQK8ethvaRdFlVMxphSTd95qc8uBtQ+E4JSLhMu4ETqAWwEloaGkkCuWTQlfxePjQ53hfBB9E/jCWTdxvlft7AAr3+ktxLmFJVBAyEa6aCSR8OK8lPtXiZIwo9C7MqMCyd2BTsUY9fnKyIKYjneTbpiwgXQcMfY54x0SyuqBpcA2F9xBMdrUdCijN0ixrD0hZaZ/LX5n9FjYaS83/scH3ZxEnFhXD3Eh7164CC5T0UIJ/p6EG8/xWE9ZT3rEHTdE8s29nkRvJIOeIvBuoPRLSr38EVZyECH5JTpeE2u/Ul4LDoomkFAw/jsNit0FVD6S621oOsprvS+z2MP4w6h7q6jSsiT2bZ4IUAvrWYXnj5HLwTT6/o0DfWX7EnJsRToIm+YoDp+RjhNNh4nJKdwWJTFjjBjvmgmAUQtPNtljow/U0Awg+OgyecI4unMot/8XDTw7NaGRccdgVcc4NGQlLwOftPx+F03c97ImttjV5v2NE+aicPhgUrbI5DYteptE1EdVFiq0hZHlrv80FALwjmTYlwV6PPaRlIpgQ+izdX87kGswoHZ6sxU00l9EgH0gRvK8UM/QKg89UbVwJnLFitqsMoK5rq7QA12VKC4n/Y3u9JsFzhggkFaMeBYlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7631.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFrNzJiMGFQTmtxL2ZOcUpMRnVpNnpBWWdsNEYxbTdkNjYxcXNkQWZjcU0y?=
 =?utf-8?B?aHVjZ20yelFtVnFhNE1IeEEvS0ZJRzNVc1htSllqczNSYkcySVEyR2ZnUVRv?=
 =?utf-8?B?MGs4MDZMYm9IT01sTndWUlhyK3g5MkJJTTM3SEM5bStXZHlnTEVpVm1UVGZx?=
 =?utf-8?B?RGk3cHYrNG93UVVnRkw3d25xWVZsamRyZGVhT3RRY0l6S0tnMWI4UHRGRUNH?=
 =?utf-8?B?c01kVnFNUkU2UDMyWW8yUGtqaUZUQXJLOTlkOFplTUdkT0JwWVJ4K293TnBj?=
 =?utf-8?B?cE9MdlZ3Si8rTVdWK3BPNnlZUk1PWktFTFFYUDN2bmlxUUU1QklyZE1ReEla?=
 =?utf-8?B?S25vVlJSaGNXSVdjSkFtQW00YmNlelY4ajk5Yk9takpCMzlVeTQvdG1ZK0g3?=
 =?utf-8?B?ZVlEYUdWSUFLYWVQY084azJydzVYLzN1cHVWRjJ4bWZETlBuYUI3RStWeFln?=
 =?utf-8?B?WjZFWTVhQTlscWh4bHVVcC9yQ3BKVndZanUxNXpGb2YyUFZFd2d0M3hZbzI2?=
 =?utf-8?B?Y0tSVHZ5anlNaUhadXZoVHVtakM3SUw4TzNpL2lsVHMxM2FBMXZQRFFQbldU?=
 =?utf-8?B?RFRQM3ZxUUVtTEJqRXd4eUtvM3krMGRiT0hLMW16N0JWcnEwMkl4Tko3eE1u?=
 =?utf-8?B?QzdUL2hLVEJIWEhncTNQdU9TZG1OMVZITnhkc3Fid2lsVXkvSlo5dFFGU2xp?=
 =?utf-8?B?TkpxekJMbGZ1S3NHZjJPZTFmNzhaN0l4SmtNbllOMHQvRGRyaUdlRU8zVmhn?=
 =?utf-8?B?Q0xUN2l1MmNodjV5UVVINGN1c1pUZ0c0N2NEQkV1Wk1HUjc3ZGk4aW11aEdH?=
 =?utf-8?B?NDVWbmdLaFdqUWcyVkQzcHI2WDh0TmQ4V1JUVGIvNnI3eUZyQkJ6anB1bUpo?=
 =?utf-8?B?RDhqMm9nSXF6NW8yaUVtTnRsaTVaUE1uUGo3VmhUeGs1aWtjd3FSeWNxWjdq?=
 =?utf-8?B?M3ZPN05vaTFMemEzT3JtOG9VbENpN0dQWFcwU3hhNlhteEJyeDFja0lyZ2c0?=
 =?utf-8?B?UmdFTDRiODZEdWptejlDc0NCOEVtZGdoTFVQaFhRMFk1YWhGcFd3NVFJVUJv?=
 =?utf-8?B?bFNHenpnVXVSNUhBcmZUUzRRQlEzTVpCVkEraFRmMVJqS3VCdGUySmVWY241?=
 =?utf-8?B?Mi9LVGtxVWFjcVNMNHZ5U3ZoSHg2dWJrSklNRGl3bC9ZMXQ5Ty9GcGJMbmZQ?=
 =?utf-8?B?dXZORXh0VjVGN1g1b0h3aVhmS1hTOWVoYTdGTEMzODYyYlRwUzlFdVUxYUdk?=
 =?utf-8?B?OW9wUEhqMjFsZm9vL0hLSWNsNHdJQmVVOThYdnVzWURmVjNVaERNcm0zbHo4?=
 =?utf-8?B?cm1KWlFTenBiNDVxWkVUK1Baa1pRUHNMdmpBcXlxTmZBdzgwTDhmaWdGSzdO?=
 =?utf-8?B?NmtzV1JiV3NsNHltNGQ3Mk9SYm4vWlNWdExYaEZGeEhKVDJKN1J5ZHJxbnN4?=
 =?utf-8?B?djRrODM4cldQRDZmM3dQeVBYWVVkTkt1MGdjdkVhbmtRL1BhL3B3cnNaOUxQ?=
 =?utf-8?B?M081Y3QzbkpiS0tjMlcycUFBaTZ3QTJTaDFTOTdPM1dxTmpYb2xncDZuU0FY?=
 =?utf-8?B?RG0xZGg5ZEE4V0ZHZVI4RzhoaHdjZm1NNGtpdzhndUVVY2tEQWZJRHN4algw?=
 =?utf-8?B?NWJZOExKQTVNTXVjK0NSejNPdFpPazhldm02WjBROXBpN3VLOFhxWk1GL1Nm?=
 =?utf-8?B?VXF5cnlYMTVtOUR6aDRPSEZEVDZwQUpxdnhHbmRCSGxnR0VSeUFTOFV6SDkz?=
 =?utf-8?B?YldPNlc0OWw4cThvWHpWTENRSmtwSHBiQW9RUklHMjFpRmFmK2UrMUxPUnBM?=
 =?utf-8?B?SGxQaDVLak9NZUhLU2JFWDhvcld0VmZmdGNkcERVQzV5UUpUU3A5c3BmNW1t?=
 =?utf-8?B?eGRXQ0x1UG5aK0lWTXQ4dUlXUG54Qm11VXBXWWtQeUFGMm4ybGo4VlRjUWUv?=
 =?utf-8?B?cE5kYmRBZGtzUlJseFhJZ1JjRGNucU5tK0x6dlp5TGNHelkyV2Zoc1dPcWR3?=
 =?utf-8?B?blY0OER6dGJyL2d4MFNta2JITkRFSGx4QUNwK2xHakl0eTE0RWozWmhnd3ln?=
 =?utf-8?B?Vk5PbWpWOHFDY2JZSWNlTURZOWZhOEhpSGo5Y2FMaU80Qk0yV3dZNzBMZWpv?=
 =?utf-8?B?bi9EYTZaTnZjZGo5aWovaGdnQ3NGU2EzMHdLUVJ6R2I2QjYvQ2pjMjRSQUFK?=
 =?utf-8?B?Y0V0NG9Bc0dkbGdZR3Jrc1ltN0RYdzhOaVVPbS8zV0FoQ3dXMkpUTzdzcUlQ?=
 =?utf-8?B?M2RVdjlNdE01YkJpVDJGazBTcndoVjNnSktRYkwwa2lpWW1IdUlud1NWM1Y4?=
 =?utf-8?B?WE9UTDFNc3RYd3ROL0JmSmtMRHpITk8xWWhKNWlXVjhaUVBWWk1obGF6WjA3?=
 =?utf-8?Q?hRYSXzlsY/K1jtfY=3D?=
X-Exchange-RoutingPolicyChecked: eDq7sJebExVLjAsyJPUMR2JmJ4Nsb0Cen2uIotnJ9p3OZiZX9x9B6yw6Ruwq7HhuM3Kmbg8ynJ5Ls+MC8XPnsBl5cSP5zkhGQFONFRR7/J3OUt3j3qm3o76la0vQigvxIg/xBJFN5/IZXFK40PF1QeVB54xnnfHQy4Ia+cx1qvUs3pY3tvQxuCUOPC73Fy2lPbjDdJAONkXFWfV+7ibNZt3FerW1GtNjdPHoWEV9z5hRGtDj0ny+i919hVNAXl6SAGTz1cAJsj3hOKumnEXpceoK5PqUXOfZOQhjQUc1oroTGQHEpl8vanjv+1k2Z+CUYfIAfZkUN+IdDLBaatc7rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b2f7c6-f531-45d3-6782-08dee96caba1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7631.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:16:48.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5p6zl5ryrMHfrW3Bf9n+O9WIXAUQ9/WUcfRRHKyw5Zj1FRB1Ot27JDbMpDWarKl0GLWwbfNHTMpBX4yI25vtzekZlQudxEDZUs6p+dqn9GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com



On 7/24/2026 12:57 PM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> LED triggers were created in __power_supply_register without holding the
> extensions_sem lock. Since commit b04510c3af6d ("power: supply: leds: create
> triggers based on properties, not type") we call power_supply_has_property
> during trigger creation and access the extensions there.
> Move power_supply_create_triggers down into the lock scope used for
> power_supply_add_hwmon_sysfs for the same reason.
> 

Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> Fixes: b04510c3af6d ("power: supply: leds: create triggers based on properties, not type")
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/all/a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com/
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>   drivers/power/supply/power_supply_core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 2532e221b2e1..cbf6ebef7850 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1636,11 +1636,11 @@ __power_supply_register(struct device *parent,
>   	if (rc)
>   		goto register_thermal_failed;
>   
> -	rc = power_supply_create_triggers(psy);
> -	if (rc)
> -		goto create_triggers_failed;
> -
>   	scoped_guard(rwsem_read, &psy->extensions_sem) {
> +		rc = power_supply_create_triggers(psy);
> +		if (rc)
> +			goto create_triggers_failed;
> +
>   		rc = power_supply_add_hwmon_sysfs(psy);
>   		if (rc)
>   			goto add_hwmon_sysfs_failed;
> 
> ---
> base-commit: 657cd3a42e937276262c0a8ae6b01a87004309de
> change-id: 20260724-power-supply-triggers-lockdep-2083247dcecd
> 
> Best regards,
> --
> Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 

