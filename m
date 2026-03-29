Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856F40DFDA;
	Sun, 29 Mar 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794642; cv=fail; b=J/PlzUQsR4inVhibbQjCtjOnK1uCtVZqI1cAoQYX3S2PEfkQJE9LM67swXyv/xXsWZ94EUzlPZEpVA5TyLX8eWr/raJQm6bMUzJMhCBxQT9zOMDLXT7f5PWjOxIsMYBxUOjIVdJut3L/qeqoQULilFaKNE8XrsOla1vTljOIbbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794642; c=relaxed/simple;
	bh=V+bYZmZxdPG4vL4oloMAYksDawBoQkRlwSGyoYLuUbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYjpdhnPjomDyy2wn9EI6z1Qy8o6aH/uiDy46gerAo2ldyt0PLcNi2/EBxa9Zcf1SzuCDFFODKajk78xqrd+hTDE/+3yz9qbDA4vxDYkpt4lOabOMvLLrCqpVlWFsiQl3VHNsvydw/t1ny/k/qaY2G8ZoNMOBszSrFxybObgEXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1x55yJM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1x55yJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774794640; x=1806330640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+bYZmZxdPG4vL4oloMAYksDawBoQkRlwSGyoYLuUbQ=;
  b=J1x55yJMbhu9Z+f9+QTf0s3uWmFpqif8r2s5Qjk6T1oHORtLWjg29hbH
   eE0AOlakfLQTRlpR2MDJIILNU8kEqEWY7KaWB6xQLVfxSb/jE5qXxsur8
   kw+kXxdhSgH6asyszqGHsn6nLiWsYzmmLfKIpwNO6O9ctNzFVC8fQfnKF
   f0syiq6qmXZ2Z4Pps6AIWeAFxbiZNddS+32jLD8EfT0tRS2u/s/WWM6se
   ws191TnbE1778XAS5t6xcSbT0bflufqv3XININyUC6FRuyiYbBKeBsrF2
   p7tWZakGEUhcnCDuaP6vNj2zOhvzBaoVnv3ynFrtR1dz9Nr3ugC/dxGA8
   Q==;
X-CSE-ConnectionGUID: J+cTBwKLRGuyCZvgDayIug==
X-CSE-MsgGUID: kyET+gOHTP+zvv99XJy0Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86493540"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="86493540"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 07:30:39 -0700
X-CSE-ConnectionGUID: cIvDB1EPSU6nAtQ5KZa5TA==
X-CSE-MsgGUID: e+Gb+KOTQbSg4u9gDPZDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="225697344"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 07:30:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 07:30:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 07:30:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 07:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iReQaqkyLg825de7SfQtq2yWAiuh4OXY4yoRXI+slIwpI2TvXR5JebLKxPNmKcKU7+I47DklMwPA3KVr/cSzkRrECSiUmqjCeRpf+I+elFSak2U1b4odP5xkUT+MvGBJQVqnxgTaLh3wwxoon8KRxh+tdHdA6BL+hxwx2JER8c446rJEhIOlUBV/hk6Lex30rSFwZefDSGomEKvyGFHNBsczX4PBkWz7xnWExAgBaVLFfyO+hBktS1gvjfcsTn4sKnGrpsV7/EkEqToee+Fk//HZ9is1+Y7zAxMR7cHCZa1bq0XLhlAvzv7JuH7fFcEDRQuPp4BsxJREs3tPij14bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+bYZmZxdPG4vL4oloMAYksDawBoQkRlwSGyoYLuUbQ=;
 b=a+tSKsYoG6nijp4wRMHnpWzQ7KqOvpn0ZHeg67HdPw/EbGTtw0A5lWig4h1xU1Smk3iHCy1iTbqFqZPEFZyE25oJH+Y1k5BesHpGXDbvaond8f466s3b/5ufdURdVfj0c1skNKo6D0/AHeUg3Jj0Lo+1EJWUZogCzjB8zFjSd3s6oA5XH3y3Q2P0UtUwjiyso+Tqzrla5xa7HMgmrAQ3UXd9omEuwAPWYwkFwp8rQyaeh0uHQUnrRF7GQiZVqAKfis7khxtsb0SBzwN3KcJSIuKxAlxr3YU6U3bXatDuzYEmykYhcJBmlv82jp7T5LN5cK3oZoWOUW/yv6/6N8xBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 14:30:31 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%6]) with mapi id 15.20.9769.009; Sun, 29 Mar 2026
 14:30:31 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Adin, Menachem"
	<menachem.adin@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Todd Brandt
	<todd.e.brandt@linux.intel.com>
Subject: RE: [char-misc v3] mei: me: reduce the scope on unexpected reset
Thread-Topic: [char-misc v3] mei: me: reduce the scope on unexpected reset
Thread-Index: AQHcvTNUrAEKsOFqokaSMfrrFrzppLXCdbmAgAMgTGA=
Date: Sun, 29 Mar 2026 14:30:31 +0000
Message-ID: <CY5PR11MB6366E99764D582E2845DDE90ED55A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260326145720.3937252-1-alexander.usyskin@intel.com>
 <CAJZ5v0hvf_q=g-PzerYnqZBjnDEsnnA405ZnD-BumPJG56HHoA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvf_q=g-PzerYnqZBjnDEsnnA405ZnD-BumPJG56HHoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH0PR11MB5143:EE_
x-ms-office365-filtering-correlation-id: 68f532da-9d90-4998-2c9c-08de8d9fbb7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: M2ip2VM38wZ0MnECymrD2nJcQA0UIsKfdDaFtygq2SMjrL2b+lxZva+svknxvLtfn1jHGNeAYvAUhMBP+tV5E/r43jT5pm/TyFsUhfjAn4SibkdqAO39RcVaM6xA/BTDQ3vmX8kZWfos4Hg3euHyPbMJLcs8QTjFCk8sqts3BgtSM1HPze3Bb5glzRoO86W6AiZdZ1x6ksETUxPO2pZovNoH6iADvRRXiPaEVAK27wl8G1+9RIh4hU/zIdVdmjDtvQ3dq30oU9S6jilba7ipgOnk/zk6uI6gqI5+KheQEiHOtisFOMv/e53ZbTSqVpZkrIsaXW6UsJ1u/BZVHff5wiXXFIh2vbiRBdAp7T1RI9HA4j8r4sYwhhSiyj/rMZpgwWKjG9zZI+VVaTdlH8fatPMx+enxl6lRuNwEopoGrMIQUrD8V/Woryj5OjivIjf07TP7CqXo5TVhgy/wO8ZIQKpBOPO4ckx4meri/Bh1RGE0j7Tdz6S66i9rAJr2UwtL0/7T0vjYJH32zkXUgZOeDiSlllNs+dpQHAXAztPPfU5aOMKCqAVhReaeCs8VUkMhMVWhHLy7PC7hx7thws/gA0kLCOlCzQ/oDW2ZRgsoQ7gts1K3oWtd7a7CVDTkhD5n3O8fLgqjtPYTLtAXSjBR/XKUOw+Uvc82GB7lxINL2fsDcmpWX7+opWJzve/Akgu7Ru0ctXK59BytAO1xC6Sa5uFaG216O3oFkP7+e2eWJZJIAPTrL3JtrpTUlO/18LOe78ihrHVlnMgCVinqYhMSJvj4wOwwbAG/BjkvtOnkg/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVRoSXhxRk9YcU5UWVR1Vno4a0xKeEovTE1hZXVmVUZ6TUhjRHd3WW5lVFo0?=
 =?utf-8?B?eVV3SUdQcGttdUNSVXNRZUpkQVJTaE1HQlpHcTh6VjR2VG5acmJZZXpyM0tN?=
 =?utf-8?B?bXVUcGMrVFRoZmdwY2F6WHp6S3dBMy80Y2kzMGs4UUZ6ek9XM3dobUhPTzdv?=
 =?utf-8?B?VElxeEcyNnRvRTlEUmRKdXVYK1RYTzdnY1FpZUhQaFA2M2R6RkhuMlk1c0N6?=
 =?utf-8?B?WXl0RlZ6WVh1TVZoNzRRbFdveUh0cFdZR3F5c004dFNBclFsdThNK0wzWkVo?=
 =?utf-8?B?UnZVdHd0anM0RGwvRHZnWUJ5TTlFd1ZFV016Zno4S0VyRlI4ajFTa2huTloz?=
 =?utf-8?B?aVdIRjl5QXgwa3gyYk53OFNNOXhRMStKM0ROV2tLZmR0MWo1VzVxVVBrMlZw?=
 =?utf-8?B?cGZ6ZDVqcTRzcW04aFVwMitYWmxnL0lTeFVHcFN4MjAvYmxKVVVtNEcwWGJ2?=
 =?utf-8?B?ay8zZ2JjdDBwV0hMUnVMeUNFWU5MRXFIWWJTeDk1TnNWR1VWM3RyZENmTVhu?=
 =?utf-8?B?WnhvZDlURmIzTlNvbVRSK0tacW9tQ0F1RGJ2cWVmNysvd1VvTmh3d3gwcTRv?=
 =?utf-8?B?UXZGYTlvQmJmREwya2RUdmUwNjVkVVV6cEp3cEFVNXByVEtOczdzU21sOC96?=
 =?utf-8?B?MzFIODJQUVZSWFFZYTAyeTNDQ28wTy9qWUtYYUQzeHl0ckZLVU13djFHVFpp?=
 =?utf-8?B?dkxxaFB1YVcyK3ExODZRUEptcGs5WWl6aXJkZTlvK2hrSkdhZzBDQ1dSMTZG?=
 =?utf-8?B?R1VnN1B0cWJxeVdkRUJ3MHVrVWVqZ1VINXEyb20vWWxvb3U2ZXJwdnliaVJT?=
 =?utf-8?B?N0s4Z2tOWGt5OWRYSHdlUWtpbnlkS3BiM0JZKzN3MlRZKytDWSs4UzhySHEy?=
 =?utf-8?B?N1ZBdERObmdid3czQ0ltdExrangzOURhaW41OXZBa3BDOUpoVXRFUk9JdDVC?=
 =?utf-8?B?S1M3dVlDVUdRaS9FZlM4V0ZwZ2xHVkFIMjFyQW5kNzVHU2daUm5lUEc3bnRC?=
 =?utf-8?B?cHczT3JMbDdIb2EzZ09EVXpiUVdKWnJUbGR1UHcxb0lpQi9rUFU2ZU9zcUlF?=
 =?utf-8?B?eURLdUtkY2FnbU02azZ1WDVwbUk0a3Z3OU5qQWFkUEtadFgzM1dSZGJRd20y?=
 =?utf-8?B?TFRsSFhPaFBTb3F5Vjc2b2h2K3V1L1o5OEhmdGNZRXFiY1p6dDlQbk9FcUpC?=
 =?utf-8?B?UlJDRFRpOWI1RXpQZnZ6NFJDVlFINFRJQ25pYVFnRVVkZ1VMcVg4dURXaWlD?=
 =?utf-8?B?ZXdKcVFGZzY3WDZpWWphQmpTbGhSS216Mmc3blh3cVpicmU3TDUrNldlUi9h?=
 =?utf-8?B?am5DMlg1am1FcEZIMWhuTjhLeXFaeFFlZGw4SnJFdlZxdWQxclpQU1kvak9I?=
 =?utf-8?B?cmNRTHhOSjdIN2kzWFowZDQxOVM5LzRQOUNGSDYvd2tML09mb21mZzlMUG5a?=
 =?utf-8?B?dWwwUU9QbjdLREpHNGRLVGpKV0M0ZWxGTWNNWS9ybUxkK1NLTTZ0WVIwY3RT?=
 =?utf-8?B?L1RRbDRjTVpBWVNJK1J2TmFIL0xKY1cyRjFVQVlzYkZZZzdlY0VNS1NOUmRp?=
 =?utf-8?B?bUk1ODZXdHFhZHk1TWl5cUFMdm8zazQwUVM5d0ZoSWpYMzBzSUt4clZHQ3V0?=
 =?utf-8?B?VmNRL0E0N2NsWm9FVjcrSGJ2N3E1cmZucmNhNlk5L3N5SWhOZXUzVUtrajZm?=
 =?utf-8?B?OVNUZXA4aGFKVTNvUnorYm41bXhPM1lMTlorMDMyMDJJejIvV1kvc0R4L3dh?=
 =?utf-8?B?MXNNT2R2cHlwaXJVM2VsSG1sNWNmRkRLZlBPbld0cGlPeVFkUHBXS3QvT2VZ?=
 =?utf-8?B?QXE3a3ZQUkJOZkl6eGYwUEpPN0xsOWVZVFpRdURMU1kwRUsydXM5NDAzRGh2?=
 =?utf-8?B?c0lLRTBtSVVHWFRNd2JTR1pjOWJjL2xoNlBaWTk1a2JjMlBteEM5aE1QQzFY?=
 =?utf-8?B?cVB0eHJpTWJpd3ZleVczMDFZbnRIaldZYmw5UWtnaUI1NlB5RFBFMVk3b0hR?=
 =?utf-8?B?WDgwL3I2MHdKaEozd1Z1NGZGNHZVNEVhd3BIOTkvelFDOHBoVFlXWmZkWEtU?=
 =?utf-8?B?UVcvKy9pQzNVM2sreEh6V05lNDlsVHVvWDV4cm0vZG1FUnBMbzNxaGMyR0w4?=
 =?utf-8?B?OVNRdjdnVWdoSnhDdlczRy9hV1ZUUkxTVTNhQ3FKMDNxR3dxMFhvYlZocFl2?=
 =?utf-8?B?ditMa3g5bjN6OTJiUG9NNHV3N3g5ZVBCK3NyUWtOejRSZDN6U2JQNFNRN3Qw?=
 =?utf-8?B?Q3BYUzdyS0txQWxBU08wSVk5bTFjTjhGL0YwS25vZG9PNlpjRjdSemh1MGRv?=
 =?utf-8?B?Z1dqNGtQeEpuc01uYnRFYVhrU3BVQllKaTdwYlJya2x0L0gwUHk0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fI1BNe7CQ8MHJrk/y0D10UTGzXSZ3k+2oFF/V8L39ZBHH5oCNVVCxACazzMdrEEVgT+6Vsz78TCBo0XfVK7/8qlqlcKMdeIA5LwjFN9HGbj7H/ewxxJSLRDECE+qzDfLRxg9jI1rI7RAHAN2rg5LY5J+kI/BzBXWFa4e84wWlQgEB32l1vKuBqx455UgCffTztQKZ1gWfWKifJ8cbJp/KIKUL+06+FMTrUQU7sjm2bikB9nQT1AbAbDgqGSuR+qO3mJjyhA6tBrv23v7xReqFpzZHGV73i9ODwoH98px7CnE0h4aDJIfH4sr5FjqzUFUW5nXnLs3BFGC6QhN4XcQfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f532da-9d90-4998-2c9c-08de8d9fbb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2026 14:30:31.7341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cg67bKsM9e4/65HfOxmmwzPCn8APb9kB4xn6F5i4dBZFmNVKUAzthQ9iGHFcSdgaaG4lBK+FtdsZ1fgvxdJXqvfUC/OESOrHpl56gF9wbzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYyB2M10gbWVpOiBtZTogcmVkdWNlIHRoZSBzY29wZSBv
biB1bmV4cGVjdGVkIHJlc2V0DQo+IA0KPiBPbiBUaHUsIE1hciAyNiwgMjAyNiBhdCA0OjE04oCv
UE0gQWxleGFuZGVyIFVzeXNraW4NCj4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBBZnRlciBjb21taXQgMmNlZGIyOTY5ODhjICgibWVpOiBtZTogdHJpZ2dl
ciBsaW5rIHJlc2V0IGlmIGh3IHJlYWR5IGlzDQo+IHVuZXhwZWN0ZWQiKQ0KPiA+IHNvbWUgZGV2
aWNlcyBzdGFydGVkIHRvIHNob3cgbG9uZyByZXN1bWUgdGltZXMgKDUtNyBzZWNvbmRzKS4NCj4g
PiBUaGlzIGhhcHBlbnMgYXMgbWVpIGZhbHNlbHkgZGV0ZWN0cyB1bnJlYWR5IGhhcmR3YXJlLA0K
PiA+IHN0YXJ0cyBwYXJhbGxlbCBsaW5rIHJlc2V0IGZsb3cgYW5kIHRyaWdnZXJzIGxpbmsgcmVz
ZXQgdGltZW91dHMNCj4gPiBpbiB0aGUgcmVzdW1lIGNhbGxiYWNrLg0KPiA+DQo+ID4gQWRkcmVz
cyBpdCBieSBwZXJmb3JtaW5nIGRldGVjdGlvbiBvZiB1bnJlYWR5IGhhcmR3YXJlIG9ubHkNCj4g
PiB3aGVuIGRyaXZlciBpcyBpbiB0aGUgRU5BQkxFRCBzdGF0ZSBpbnN0ZWFkIG9mIGJsYWNrbGlz
dGluZw0KPiA+IHN0YXRlcyBhcyBkb25lIGluIHRoZSBvcmlnaW5hbCBwYXRjaC4NCj4gPg0KPiA+
IFJlcG9ydGVkLWJ5OiBUb2RkIEJyYW5kdCA8dG9kZC5lLmJyYW5kdEBsaW51eC5pbnRlbC5jb20+
DQo+ID4gQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTIyMTAyMw0KPiA+IFRlc3RlZC1ieTogVG9kZCBCcmFuZHQgPHRvZGQuZS5icmFuZHRAbGludXgu
aW50ZWwuY29tPg0KPiA+IEZpeGVzOiAyY2VkYjI5Njk4OGMgKCJtZWk6IG1lOiB0cmlnZ2VyIGxp
bmsgcmVzZXQgaWYgaHcgcmVhZHkgaXMgdW5leHBlY3RlZCIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPg0KPiA+IFYzOiByZXdvcmQgY29tbWl0IG1lc3NhZ2UsIGFkZCBSYWZhZWwgYW5kIFBNIGxp
c3QNCj4gPg0KPiA+IFYyOiByZWJhc2Ugb3ZlciB2Ny4wLXJjNA0KPiA+DQo+ID4gIGRyaXZlcnMv
bWlzYy9tZWkvaHctbWUuYyB8IDE0ICsrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWlzYy9tZWkvaHctbWUuYyBiL2RyaXZlcnMvbWlzYy9tZWkvaHctbWUuYw0KPiA+
IGluZGV4IGQ0NjEyYzY1OTc4NC4uMWU0YTQxYWM0MjhmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbWlzYy9tZWkvaHctbWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaHctbWUuYw0K
PiA+IEBAIC0xMzM3LDE5ICsxMzM3LDEzIEBAIGlycXJldHVybl90IG1laV9tZV9pcnFfdGhyZWFk
X2hhbmRsZXIoaW50DQo+IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiA+ICAgICAgICAgLyogIGNoZWNr
IGlmIHdlIG5lZWQgdG8gc3RhcnQgdGhlIGRldiAqLw0KPiA+ICAgICAgICAgaWYgKCFtZWlfaG9z
dF9pc19yZWFkeShkZXYpKSB7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChtZWlfaHdfaXNfcmVh
ZHkoZGV2KSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIC8qIHN5bmNocm9uaXplZCBi
eSBkZXYgbXV0ZXggKi8NCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGUgY29tbWVudCBhYm92ZSBpcyBz
dGlsbCB2YWxpZCwgaXNuJ3QgaXQ/ICBJZiBzbywgd2h5IHJlbW92ZSBpdD8NCj4gDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHdhaXRxdWV1ZV9hY3RpdmUoJmRldi0+d2FpdF9od19y
ZWFkeSkpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9kYmcoJmRl
di0+ZGV2LCAid2UgbmVlZCB0byBzdGFydCB0aGUgZGV2LlxuIik7DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXYtPnJlY3ZkX2h3X3JlYWR5ID0gdHJ1ZTsNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdha2VfdXAoJmRldi0+d2FpdF9od19yZWFkeSk7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmIChkZXYtPmRldl9zdGF0ZSAh
PSBNRUlfREVWX1VOSU5JVElBTElaRUQgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRldi0+ZGV2X3N0YXRlICE9IE1FSV9ERVZfUE9XRVJJTkdfRE9XTiAmJg0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZfc3RhdGUgIT0gTUVJ
X0RFVl9QT1dFUl9ET1dOKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGRldi0+
ZGV2X3N0YXRlID09IE1FSV9ERVZfRU5BQkxFRCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2X2RiZygmZGV2LT5kZXYsICJGb3JjZSBsaW5rIHJlc2V0LlxuIik7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZkZXYtPnJl
c2V0X3dvcmspOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+IA0KPiBJ
c24ndCB0aGUgd2FpdHF1ZXVlX2FjdGl2ZSgpIGNoZWNrIG5lZWRlZCBhbnkgbW9yZT8NCj4gDQoN
ClRoZSBmaXggc2ltcGxpZmllcyBvcmlnaW5hbCBwYXRjaCBhcyBpbiBNRUlfREVWX0VOQUJMRUQg
c3RhdGUgdGhlcmUgd2lsbCBiZSBubyBhY3RpdmUgd2FpdHF1ZXVlLg0KVGhpcyBhbHNvIHJlbW92
ZXMgbmVlZCBmb3IgY29tbWVudCBhYm91dCB3YWl0cXVldWUgc3luY2hyb25pemF0aW9uLg0KDQot
IC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCg==
