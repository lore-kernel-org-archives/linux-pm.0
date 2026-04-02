Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC26362157
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144759; cv=fail; b=YyXCUt3xdpy3R+DV1jYp4TZ6Wm7Y9jjAIOKlWifgIW7apxvjEErqIDmlZqYIWPs2jkNKkh6XJz0tSzGwj/2M5rOH32SbQZ44SgshRsl8OwhP7p6pR9a2iRi+vhmnG1BAvsxW4FZAMb8DfWYRDcbyZ+ZNOEZDmN1N88vMRSp/2yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144759; c=relaxed/simple;
	bh=fwdjlI6MzibCLnp7G522QWZBMVJfw+ViJYeCtjwnVn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tcrv5QrYa1SBM2R77jcTErqmwPOELYMjXybg/PjNJDe/BbvdS2YPvQ4RhNW3gQapDlp6fc1YlrEovfS5j+3v6d1rs3bzk0jEL30eMcS4FjhC346pPJm7eASXM4MNG5hA9oJsKrLR5GSHHQIa5emTep6EKQ8p+Ujs2yamC/uljyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuZSmjRA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuZSmjRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775144757; x=1806680757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwdjlI6MzibCLnp7G522QWZBMVJfw+ViJYeCtjwnVn0=;
  b=iuZSmjRAEcTg6xuM3KF4ZPu4wyE9ypKzBfLJ27rV7y1zRyl1zHdDIRzU
   r7saGwEaVezOzoRAJVEu3q43vD5yqcf2zbtZb3QDes4f9vSrk4tsICQQP
   9xqFPyu+Yv4HSmDVfWWcykKraEYpFe1PgXplw2jrm6m31kA7CfpoKAb6d
   FjLfumGIQLHZvrHnesNeLrRy8ZCC2aRhvl3a+8kipB6VlENfXvbwDLlUO
   TXUqycQr9BWvxFlLgt7rjVIWGwH5TW8YCbNvCvDuj/tUzApekTBwZvxuR
   s7RxTptrWooXwXlWQrTGSuHdM3QbMi5LCw1VNFJww2lO9oCwr1LSf3lAx
   g==;
X-CSE-ConnectionGUID: lvp+e1T3RwKUQm4J1DJ7pQ==
X-CSE-MsgGUID: W7XI5ERFTSCv1TG3aWtO4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="80094156"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="80094156"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:45:52 -0700
X-CSE-ConnectionGUID: u5E6wklVQQig6N0CMJcmfg==
X-CSE-MsgGUID: Y5UFBEeQT3Cm5MnftKNbEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="222160890"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:45:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 08:45:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 08:45:51 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 08:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwnB4aMHwOP4pDVPye/frTneEIrmoe0TTnsFTm77UacMqLNzbm68/DIO4sYJi68YHoNy9iJ77uE0lSGEZq0+nOioa1TOlwsQydhgiWLT5SixxHii8HbxMl19UHmMWMG2sILrJEj+bKSJO5ktBPhjh2ALXdI9h10rCIG78UEv4X9TEZXeONHP+bnaMpdl/EoPmxpi6YC6M4mT6U1GfBxL9st0/IQMaSuyn8QeYz1sg6t5VCLPWV/yqcw1yskBm86XuqgBs7HJSFB87US7sDAw7FZ+YCgxefgh+kaHhdbxRPGyr15k3+WwVc6qMmuVKd3Fr7jmKbozTG1Vl0DWy4253Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwdjlI6MzibCLnp7G522QWZBMVJfw+ViJYeCtjwnVn0=;
 b=B4QZWy1HlHhY9RUzEQLbO7I59Md8ZuIgtHhfXDXs65/uZeXywwABxso+X39++A4piaJYosRVWzpH377TN+2JVAl1Ji9oH1lxOyhTzvy/6/zraNBgJfroQT9L2IPcRtCCo3tBO+6tYO7Q5Z8DGfRh1vjwvamIBAeBKWwupI6kJShHWm7KilmT5Gu3qxvzIBrDk+ISxc2/CnxQnuHgbP808TshOLBEvj5bOzfi1FIAQmTdK4RuimP2djKIyKLQEhA2mvNsy+XqwnVcW4U+wPhUgjvpJMKye2W5heqUUFHDOIUXJKENAUzF+zFj1i8h9QwO9fQLJ/J3auVtkpNWeBDRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 15:45:35 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 15:45:34 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "jwyatt@redhat.com" <jwyatt@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: remove extern declarations in cmd_set()
Thread-Topic: [PATCH] cpupower: remove extern declarations in cmd_set()
Thread-Index: AQHcwWmrgUaI7ew/KUOmDpseWG77Q7XJgUGAgAENhACAAV3JUA==
Date: Thu, 2 Apr 2026 15:45:34 +0000
Message-ID: <LV3PR11MB87683ABE1E5EEC0D640B6AAEF551A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
 <3c2101df-c3a8-4761-80d1-ca7b7c6aaac6@linuxfoundation.org>
 <LV3PR11MB87682C0658A16EC72B47FB72F550A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <f0bcad85-81e9-451d-8267-729b60531590@linuxfoundation.org>
In-Reply-To: <f0bcad85-81e9-451d-8267-729b60531590@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CY5PR11MB6509:EE_
x-ms-office365-filtering-correlation-id: 80de316e-7c01-4d43-b739-08de90cee12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: sKV2at4rO9tKE2mDs190H1fEOTQJP4WuyY7GhY9e34ClpoNE1YBugynllGgsoA93HYDgh+BMbrG1oDXK14t2Ob7Exr2Q6vhCQu7gfQx53UIbvYJoLMoA1i4cHvzyB3UaXiKYL4T6fAV7SOYNXJHPwAuzlDzXIZsIDj0LSKP953jL3/mN7x5/RSh0aUN+gTEMzjQqyM2XZc2DLejsEVzS5EiH4gi4qzWwdH+sS46DN1hjypocY5BE1U90HKrmgeo9MVOj2TYWbomifF6CyWYwcAuW//gBpMmohve4Ev7YHIoZxa6nO6VPiaZSY1dyYgt9R8OfHnVffsR7uDpe8TMPjGRM4J/vxn/zbQS6ej4Fh5yfEP0Fq/V21cOQfDEsPPekPGnc5oOZL+qafq0oGWR3cnr43eXXmMb4J3SXqROomZlCc52bRFCM5xdJ6B7ZuNS19UD1e7lMpoGAQSmUgwKW2qf2m1dAjpfKlAezLc5uBfHWx8zOA3ApL9Iu1lhLVKz/3b8cxP75agMgtw88Nj+jov+OVBEM4WjdIo9hqwvDQufYhSikfHAlPTexaGFWyrg6Xm74qBSbbhLX7p4aBbYtkknSKXEANdOOzCbTMecDpui5jENlYRKFHE7GqbiM2wex6b8NLSMr9qAgPgjyj8F6jBgzL8isstxRQNeQKN59MhUM1UyUoJtq4MVzJmoj8mkxjwbFuDzBk63ohNSrJ0Htrpo9f3CVJwtOwE+DHy/y/g6Trxoz+WFTZucFGDXdVLRTXKUbcPvVyhqxRf+AM0VnndXq3PzOrnTxmG8WxIYNYu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHZ0dForQ0dGR2puOThveE5IMW16RGtEbndPMDV1WlFvalh6empxeWlubzJj?=
 =?utf-8?B?eXMzUEJqVWUxcmlBU0dYazFDUHE3MHZtdmpUOG9pN1FNbGNMWWNYdVBxSUlu?=
 =?utf-8?B?VXNLMytva0dQbGh4U2ZDa3EzYkRRNUw0eHVhLzJLVEQ1YWdsODRtV01uR0lz?=
 =?utf-8?B?dVhXUTZPZEVaQkZEdUdOSDIrd21sZjN5NEJ6cXNubEkvN0ZmdDA2bUVuWnYx?=
 =?utf-8?B?REpWcWpEU2ZIZzNPbVRkdEVqYklKR2xmSSt4cE03a3cwUFZCZ1I4c1NHVXVV?=
 =?utf-8?B?Slo0bjFEV2pJMUFDVXQ2ZXI2aW5ZWjZGeGNXYkVqOFFUYytpY0ZwYjk2Rk9x?=
 =?utf-8?B?L1JZNC82cnJYZEFDSWxTdFc2alZidXZ0MGc0TEduU0plSXVxanJ1VDlPSmhI?=
 =?utf-8?B?WnNtR3Rxd3lNbFc3UUZmQVVjMkFSekFjRW9xY2FUbjJ5ZFJUT2NvOWZVZWlK?=
 =?utf-8?B?dWxVM1plSzFNL0docnNOOUh1UmdZSUdaUHA0TDd4VjRuUnBwa3BsVGwxbUxs?=
 =?utf-8?B?Sm8vTVEzT2t6dURoQythUENOcU5MTEtockR0cGRVRTJUUTdtS0lESTBrUVND?=
 =?utf-8?B?dnF2QnBIVFh6U240SVA1aVFBb0pYTE1laU9rYW81ZGdNTldQdjFXS2F4eTVn?=
 =?utf-8?B?bWQrOEowbHJFMjNldEZDb2VoMCtZQmtLT2F6dW5idG1qQmFNRWZ6U3FCeENn?=
 =?utf-8?B?ajN4OFhGdHA0MWxVVVU4bDNwSjdwdkUyb3l2WXRyaEpRYU5LdFduMTNyS3Ra?=
 =?utf-8?B?bGFPU29sSWNNbDJKZDlJWmhTbDRQUmw5L1Y5b3plSHZRTWp5ZHRGbFVHUEQv?=
 =?utf-8?B?OU9QdElNMUhnUnBGQVdTR1RFRU5UTCtvQ2QrUjA1NENFaE9sb0wvNGF2a0dB?=
 =?utf-8?B?RkgyM0d1QTBrUXJYbTB5dkRDUDYvV3BQNEY3QUdIRVFMeGRJMkk1Njc5c3Nz?=
 =?utf-8?B?QWQ2NFI1T1lSdFZyQWtQcmo2UDFBNFJETXV0cktsc055WCs0ZHlNZEMwdVVU?=
 =?utf-8?B?SDJaTkpjR1dENlJTOWlHbmxqVGk5K3AyQkEvTlZxQWJ0UkxUUllSSXJXeGFE?=
 =?utf-8?B?UzB4UWRFYURwQ0R5ZzUyRHFPblNWb2syL0NWaWJIdmVOYlZ0S1RDWTBvOGJw?=
 =?utf-8?B?RlRiTFR5d2tZa1VZZ0VBcXl0R0t4aHpRcDNGbUwzSGxtLzF0QVdFWVNwVllh?=
 =?utf-8?B?UnFYQ2Q4dTBlQjBwNXVGdUFyTnR6R1JCM0lnWUJiT1Z2VjVrOWJ6VGZPVFBR?=
 =?utf-8?B?MTRKWlFoOGYyUU9leFdWZFgyTDczZUZLUlF1NkwxdXhGbzhVQkljRU8vOXlW?=
 =?utf-8?B?YVUwV2h3U05IV09sR0xkeUxsUnJIcjArVGtwQTJSYTVyTEMrcEJNZXliRkRJ?=
 =?utf-8?B?TFB2cmVVSFY2QUJUaGdxNzZmWFYwUlUvYmphYlFuaHh6NG5WVW9FMHRxejlF?=
 =?utf-8?B?c01ZNXVZR2tka1VaZ25yR3h2SlBpWENvekE3bFNPOUVveEpSMERZWCtPVXlo?=
 =?utf-8?B?OVd4eVBjZWhUOHg5ZnFjNzN2ZmpkeGhEbGNibU9ORHhXb0tvNzZyKzNpTnBP?=
 =?utf-8?B?cW5YdEdzMmhTcFZXeXNLdFBITVYxaXJod0NWQlF6aDlPanZKYUJwMi8wSjcr?=
 =?utf-8?B?NEN2VDdJTnJjTUpXdkZMaUh5V0xNclFzZkR0NFZacDFBWUVndnpVSFMweDhO?=
 =?utf-8?B?dktXZHAwckZ4b0lWWkIxYi9NQkdxa2dmUG1GbWM0eWhMME5BaDltWC9Fakt4?=
 =?utf-8?B?NXJCWnNKZ0k4andmd2lKQ1RSSjRYaHJSTTc4UTlJYXBpd2REYzBBUkFnMmxY?=
 =?utf-8?B?M2tZVjV0MTlRSCtXeXRkQXVCbEJmT3hRbWpyK0xqL241cmJEUDFpUDVVVTFv?=
 =?utf-8?B?U1RTSnpmai9TUDVwdzhHQUJiSGdMMFFhZ1J3UHB1NEhIaWJuWHVVZS8rbWZn?=
 =?utf-8?B?QWZNNG1NZ2ZXTWhtRStHOW9tUWVrUTR6VDV1blUzNVZ2UW9HV1RSQmJIQlFV?=
 =?utf-8?B?NFBWSUhFdEFJaEt6SEdpeWdFTEFSUjhsYW1JVGJPM2cwMHgxVDR2SkExREd4?=
 =?utf-8?B?VkJyM3k2YkVlQm1Nb0IwdlVzck95ZzI2ZWhmZ1owQ0JkQzNKUExQdzdmVXk1?=
 =?utf-8?B?TG5Na1hRTlhudkltOVoxK3d1OXhZRFBwZHNtd1A5c3RGbnFLZHR5VnBxSHBz?=
 =?utf-8?B?MGFQaFA0MmpnYWYva2hWR05pck4rbk5mNjFpaWlQZDBadXJOd05WUmpqUTVz?=
 =?utf-8?B?QTVFYmxrTHh5ekIyVDh3dkNmdVlRN2JEbFdCUExhd3NHMGIyZ3lEL212azRx?=
 =?utf-8?B?VFRjTm5Hek1LUlQ0RHNoWDhSTlF5ZkRZaXN4U01xbUxyOFJNRWFpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X0LaL+bYor0cpmgXoUFGaVJ8qfjhYxRsK37zfit4bkDus+m9GhX3jGrEhA+eBRU3Ljs2kuLJNWcUqxabIH4y0fqIHaa1KQj25qa2FGDOtxQPfGgEw7tUo0rTQQ8dHwufMvLlSxN7zRlO/Lw3z8/i9eMjq4Q4BN+krDNrec2/bWOuEk4yPnz/Dp/7tWCnWJ01gVKzn8vG+WZHxqBbpX2sgE3lcck22NwxNkDhltgGU25qItoy33v2V95Fa2N6kIBieOJusdX2Obr8XQIxMsSoOLvlfJOXuU96Lps8ttmBJUWhdhbyUfgKHnfDWHULI6s3gUmrdMZjc2adL3M3egMa/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80de316e-7c01-4d43-b739-08de90cee12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 15:45:34.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lza2nAbOUfd+35hCb0zYwg9c1zP/inyli1oc7LEynjbO99X7FbEAYT83sJPvpSpP82G+biP8+P3lIqM3u847Zy7u5kxBe/Qnidpd3dG25O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com

PiBUaGVyZSBhcmUgYSBmZXcgb3RoZXIgcGxhY2VzIGluIGNwdXBvd2VyIHRoYXQgY2FuIGJlIGZp
eGVkLiBTZW5kIG1lIGENCj4gcGF0Y2ggdGhhdCByZW1vdmVzIGp1c3QgdGhlIGV4dGVybiBkZWNs
YXJhdGlvbnMgd2l0aG91dCB0aGUNCj4gcGFyc2VfaW50X3JhbmdlKCkgc3R1ZmYNCj4NCj4gZXh0
ZXJuIGNoYXIgKm9wdGFyZzsNCj4gZXh0ZXJuIGludCBvcHRpbmQsIG9wdGVyciwgb3B0b3B0Ow0K
DQpTdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MsDQpLYXVzaGxlbmRyYQ0K
