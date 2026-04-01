Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277983264EC
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011770; cv=fail; b=SRa+8QYUrBjmeEP9y8Jhxzd27Z//qvQ4/fYuP123SsW50FpokEYdIBtxShLqR4sblLgUxqd82hKx1pRplT68xUCGB4r+lKRMDIdRs8H1xStpJ9b8pNoZoOJRz85f0d8fbGPie1Emavli7uqmI1BGYrocgRjwcCaskK6gtVQPU/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011770; c=relaxed/simple;
	bh=GliqWjwykCNI8JmkmZ/TBbH4rIYRERGWGk9GmsfWENg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOK56y8NqfozMiPmuUyl0AGfkRIkVY+wdRKFwBlRvF1AqchRIJYz6QWySUhHkbQXZ/5cbqYBpU8QsXcod+eFgZcRhVzlSgN8o0cKCMNXh9Vkfc/xxiT+2VIYxfhzMocSf0SnxEGXzdagAOQJXwgxXqi+p+TXl4QK+2HDXTVJQcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViuJdKVR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViuJdKVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775011762; x=1806547762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GliqWjwykCNI8JmkmZ/TBbH4rIYRERGWGk9GmsfWENg=;
  b=ViuJdKVR7FbTOhhaa4K0b9rcTMJQHqM4J0B8JhOVvrE3Nq6BW07a8sbZ
   hlwc+PACmm1CNuF6bcnt0aokF76HbbRp0KlxzTrmnzSyajFbIVJ/4XjZI
   KwnsdOHsGyPcjWOuZ1/yUWuM49L7HJPxm/D5iViZCdzB70YYdeaFGcCtr
   NyYdCvJIkTw/mfJQVYNo/YoMRuBUBy6yJi6AOHeYLYuD6xTqoGBX1quyO
   6hrZLkR5hp1uT3F2dvGSKjOQ39EzLyOH5qlFZ4IUFND2DsLsdr6BPN0OQ
   cQPKp89NrEMEWrz4DzTrBOJpFcyDysjO3iE4ecHIrO5zwoPS/XoHce4b1
   A==;
X-CSE-ConnectionGUID: 6jXfPFFySuWUXySUVU/Ogw==
X-CSE-MsgGUID: 0afqiLsdTmq1AtYEnICU0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76101086"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76101086"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:49:21 -0700
X-CSE-ConnectionGUID: wVR2wHaMRIS5Bbsmj5ZmtQ==
X-CSE-MsgGUID: TvQ/5tIBSCCqCrCI4muisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223660360"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:49:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:49:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 19:49:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIn+PBi2pxHdxsFzGaK5s1Nq4ElxlTTrlshhhcvBrSH2BN1zLdv8/0upPTkdkuZGtkaorfRuct5WFpsm4UfKbB6dJR6UvAICCqwC3Csnn0mh9Qu8NBMwYjAwpQlI2CkhTbukzf5aBRJIeiH/NcnnXr8u4fCoayMib983YgF7E7COpK2HIn2MKsxDwsMF/nZ0p5Gpk46GHX506voKK7mOd86diU4G1gD32p8WjY0cn0yofGXp1e/B5DtGZb0LkPxkKahLAOhjGf0SZLizfWQHlHxuKZXuHtmdBdp2RJuQKI2DSJn+1zI1Ggy1TfhXO7pPf4hUel7KYtbKPd7DAKLqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GliqWjwykCNI8JmkmZ/TBbH4rIYRERGWGk9GmsfWENg=;
 b=VPgTvMDh0Oxkjse9MoPXD9h2OxZoqyvmW6rrYjeshMrOPv3BrB1631nfl7ARe429NAKyXZjc9HNOl+CbVbigNjKUKPtn22gJbf/s4pKLiePbNlBLKQhyVVqBAAEC/Azg+oH+OzNstmRudAaYAOPC6WzIPmrrLFhC299EvOABgYnmbDZgVxt5fCLQ8alTMlGoBx3CrZ8VJYr/pHvYpyUL91aZr41Soi8hZn4xBo3Wji2zYPeuYRSk6mPHGmHNj1LZbAd3khjYQxYSu1s/fkyUJzA+WPvmhSLJ5H/AMp/mkHMXlK5K7oQClIMjU/ZHISE3GFO/oTKQW0lMMmBjLUw8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 02:49:15 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 02:49:15 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "jwyatt@redhat.com" <jwyatt@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: remove extern declarations in cmd_set()
Thread-Topic: [PATCH] cpupower: remove extern declarations in cmd_set()
Thread-Index: AQHcwWmrgUaI7ew/KUOmDpseWG77Q7XJgUGA
Date: Wed, 1 Apr 2026 02:49:15 +0000
Message-ID: <LV3PR11MB87682C0658A16EC72B47FB72F550A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
 <3c2101df-c3a8-4761-80d1-ca7b7c6aaac6@linuxfoundation.org>
In-Reply-To: <3c2101df-c3a8-4761-80d1-ca7b7c6aaac6@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA0PR11MB7379:EE_
x-ms-office365-filtering-correlation-id: 82adff63-5255-4438-dc3f-08de8f994313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 8D4xuuZHjOqRO8lKYeNEv9e8uczdl9gkZEJO9nJLW7s6RjI1qXuJ+83lkzusGBDSYp/HhdXoVYHokel5xZ6BArik3wwPgz90VkPkjx0nawGp0Wg28gfgHm5lFfnqERsgbJ0vQ0Cte2Umh6rck5FPnHHGJMoJnTOTGplkx8rayxyfW5v26bhwZMUZkYAHuQZbnZFVdMsPQe8WMB8wvrJHwEYDo7c5f4nwEe5HykebOx32bYF98gCaoD200xGlgmxl1IxDpjzJHDBh7owOJX6xMk/9jQa0sanGREwQsBC3WXe6qeQGxOXZOAvKWzhkDh09vsf8PeqAwmYbRpYr1kBiuyZ/AYxvXI6ZIeh7V6fAMwuE9zZvBYMa0xHsA7pznGAt8LNf5y13ZY5cwb51gwNzyjOk0TkmK/+bduEH6TaQXOK0fniE1et92WwUxFMeOTQxmwytHDeI8+UlPCQY0kaWeK4K5QJ9xdIJ+a9zn5L206ObKn+YdB1Kt74L5hdHuKBA8KPReQJU4pKu8noZFHArcwCi8blnlkxxiKLOnh3NoDPuZQ20Ax8LxpVpJlYOeNV3yQfnIJeZO319h2oUzW2+Pv2OR5a3PcrUKWOBIFP72pVLVaRae9hPSRd0yzIUSEuUN0xud29UhmoOxxSJ5mZ/kuU5/REDlINrmOqZ+29UUJnsMl9WfZtkLo04Ow2mEXr008oU0zC26wrpk4qb0b7dX84pw9OdafL1worUyQxXezjjZt7RVHHqb0zedzSBx9lU9598IJfR4kQUMTlX211H3c3udiw6eh4f1JJj2oAYSqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVdsdHFKN1lIRzJ1Z2c4VUtJVFllTm8rWHhkdHoxYWZCZnRpeXVpcTRUb3E2?=
 =?utf-8?B?bndUNEVKTk9UaWcrNkxCcWZJSXB3RndnWHNydUlreEgrUEdUUERiaFd5U2c0?=
 =?utf-8?B?cGpyV1FzbUZkMUdFVDhWQ2NlSW13ZE5LcHZDQllRUWcxM2hQV3M2L2ttbVN3?=
 =?utf-8?B?MDZ2c1VBU0RoUk5rdWdvMmlzTGxWU3o2Uis4UjFSNU5oRFJhMkpFUFI1Ymlp?=
 =?utf-8?B?UTZ6Vko5K1ROUnFuNXJ4azdsb0dMRkFXTUxQMHNNYU53WnhZem5VZWZjNHUy?=
 =?utf-8?B?dGpQT01QODNsbERQM3BaQ2UrY3RIU3lHUUxVa1FHK28xcTY4SEdRZ00wbTdK?=
 =?utf-8?B?NWVmYnhHb0t2b0ZvRVZNV3o4Rk0rdlpkbG5SbVM5Q0t4SmlNRFltS0d2MTRO?=
 =?utf-8?B?ZkRPekcwb0UvdFFKZVF4ZldJbjJabEJ5MVY5OFpWbVZpOGZMQXgwZFNYRTdL?=
 =?utf-8?B?UUg2WHlQbGVDVllTVWl3TFY3ejZaM1ZWaUlBQzBBNEQ5dUV3ZDJSVFFTMUVo?=
 =?utf-8?B?WDEwWUU1V1BPTlN6MU1GV2VjWGsxaWg3TU9BVTNiT2FZdXN1bDZIYlZNb2g5?=
 =?utf-8?B?TlI2Rkttc0JFNkZpTnZyZkttekFkN0ppdE50Vm9xdjFiaFZqKzVTd3NGQzJh?=
 =?utf-8?B?c2dEd3hMY1NiOGwra1dmdTBOY0ZYMWxyZHVTQnZIK29RSlF3dWIzK0tobFpo?=
 =?utf-8?B?WEFsdnduS0psMU1QNmRLR1UyK1gxbGlpdjNBcFFqaFNCakRyL0ZRWCsrZk4x?=
 =?utf-8?B?RDJUb1VzUC9BMXlseWErSXNCZXc0ZW82d2w2REZRMTF0QlVGVHJMWmxLUFdI?=
 =?utf-8?B?SUc5cDZjclkyVnJnaE9zdk5VZFV4RlVlcGpoNy8rMWNJWjNaWndUdTgyak0x?=
 =?utf-8?B?MHVxQlpnME5rQ01MTkZkdFBIL0lEU0lIRVJTbHcyZHMraFVmaE9MVnFpV1VU?=
 =?utf-8?B?STJEcW03UXpnRUFhYmxXQnY5QU4xaGhUOGcrRmxsanFPS1dSbzNySXlMWm5p?=
 =?utf-8?B?a2FveXU2YWZWR1hDMDArR0pwL3RIdlFrMnptTTh3WDVFcGwxa0hUVFQ5QTFP?=
 =?utf-8?B?QnhISWFiWEhiUHdKbHB3a3hxNCtlMkd4ZWVWV1NJZmR6RW93K3c1VkZyc1RR?=
 =?utf-8?B?RE5aK1J5NUpzdkNFbFd0L3pQQjNHbnZnWkFLRitpZlJNY25ieDlVMVVORkxM?=
 =?utf-8?B?c3hUcE1TdFpvbVVnMk5nTWx0NThjWk91U1hpV0s1OHpYY0xBTVJVS1FHNEh5?=
 =?utf-8?B?ZDlXc2xqU3VnNExDM051YkRlL3RUbEJJajIrT2ZwUFNtUUZyOTJOcVBTVmR3?=
 =?utf-8?B?bXJxbVAwalVucm94SldWeUhNa1QrWWNOT2tiQnRNS0VnWVo4Z1R0QXdoYlgy?=
 =?utf-8?B?MmxuWEx3dVVpRVdwSFE5bm5XUFFEVDNacHFzOTlsTHAxSEdMRGhjQ1Fta1E2?=
 =?utf-8?B?RE5ldDRWTFUyeFZmcS9sSS9jWGd2YS9OZkdoZUdxM0pCV0I3UlEyWStIbVVB?=
 =?utf-8?B?NU9COUxkekhiRFQyTXJkOXRRUHROU2Q3L0UySkNRVVFqZDY4U3FEVDYxZU0w?=
 =?utf-8?B?Mm5TSVVhMnUvTEtFTmZZdlFZdXo2endmTlUySFBYMGJCc0tralhqTWZNVE9u?=
 =?utf-8?B?cmMxbzg1Z2Ntb1c3VjlOK3ArVy9GZW52T0psemJud1V1cXRWY0h4RXdXUkpW?=
 =?utf-8?B?bXZlMUcxTG1TUGxHWVZwM1lPb1JWSjZJN2dwQWtxOHBWbnRjclEvMXVjZThY?=
 =?utf-8?B?UENWL2N3NnU5cGYrbWRJL3ZHd21MYzJreWdXVnp1RCtEVlFRaTNyQmxRTnpZ?=
 =?utf-8?B?V25sbnZwK0pIMTIrL3FHaGtZNjk5L25Cay9ld1hsQnlhNERhM3JLSXAwb2Nq?=
 =?utf-8?B?K24vUnJzSENtdTR3UUJHQjJkLytKZWRQT0RoWWNMaFZsRjE3cG85eStBNWNF?=
 =?utf-8?B?citsZ3JoNHViMVM4TS9uRmZOSkY4NTVFK1Y0dmVCTEpHQUFJS3BvaXU1Y093?=
 =?utf-8?B?K3BUSEdySnkrZW5VZXZlSGd4RTZiWXdFa3E1U1dkSVZ5WmJDcUZjUkhuL0RJ?=
 =?utf-8?B?MlFueTNxc3lPYTdhQ2pDS1MwdVMybVRWTkVncDBzZUxISzVKMnFmTVRud0s3?=
 =?utf-8?B?N2hUSVdlZFhqNjlheFp2RHdxS1ZtSDA1aEpaMlNIZ1F6SXR3TTdmVGhoakFo?=
 =?utf-8?B?VkFFYlh6dEhJa2h0YVcvY0VhYmJ3S2Z1VWd5b1ZMR28xV09WQVI4VDVmM3hq?=
 =?utf-8?B?S3V5cURBcEpFR3NzLzE5NFV1eEh2aDJNbW1oTGo2Q2tHVjdaUFFueUtXSG9Z?=
 =?utf-8?B?WlR2V0ZtQXZBT01XTGg1ZllLWWlvV0hNb3JKc2gxdjJMSlQ4MkhYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dI09BoZaiFfCm/CIWkRgBMv6K6Rnovz1STMWyFS1Nm7rXWTv9FC3oN+rhfY3/8URKmUSRkmWp/j16+rMVEKgxYrrcC3v1gMAuJ7jAP1AVJkXDxMob/ffZOspZdvo0WTjr7s6FiCPGtDhV9PweHzv0oznF6XwB0cH0Da1GbLyYFOJfLWp+Ndt2BIYPdmBWQzYjLWVz67ppETE36O1yRsgwaXf89MTCx9rSmUz16MRTtyUaiGDRhPDVAEM3DPVP1V+KuDjD4T6vWwqUQyHieetIBfJx0jKt+Ikn5u6dya5sjlxoBCNKKOoK5+0OLxZdSqmDwLwUIV8wJTGMZIonmsO3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82adff63-5255-4438-dc3f-08de8f994313
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 02:49:15.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKzTHU6OIMPfuI0GxOc3UTRAmXHZVh/4ElRVa+iPfp/jobF7VWJUc+1nfPG+N8UgYVAaf5OAuZOqOWbHwvsJAMyiIpJIjtv4NNEd4kun8cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

T24gNC8xLzI2IFhYOlhYLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiBPa2F5IC0gYXJlIHRoZXJlIGVy
cm9ycyBmcm9tIGNvbXBpbGVycyBvciBzdGF0aWMgY2hlY2tlcnM/IEhvdyBkaWQgeW91IGZpbmQg
dGhlIHByb2JsZW0/DQoNCk5vIGVycm9ycyBmcm9tIGNvbXBpbGVycyBvciBzdGF0aWMgY2hlY2tl
cnMuIFdlIGZvdW5kIHRoaXMgd2hpbGUgZG9pbmcNCmxvY2FsIGNvZGUgbW9kaWZpY2F0aW9ucyB0
byB0aGUgZmlsZS4gRHVyaW5nIHRoZSByZXZpZXcgb2YgdGhlIGNoYW5nZXMsDQp3ZSBub3RpY2Vk
IHRoZSByZWR1bmRhbnQgZXh0ZXJuIGRlY2xhcmF0aW9ucyBhbmQgY2xlYW5lZCB0aGVtIHVwIGFz
IHBhcnQNCm9mIGdvb2QgaG91c2VrZWVwaW5nLg0KDQpUaGFua3MsDQpLYXVzaGxlbmRyYSBLdW1h
cg0K
