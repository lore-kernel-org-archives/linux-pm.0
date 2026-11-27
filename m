Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795758837;
	b=MEtjD2H1jka7jeBrXAopHHn3jlxkmv/hdbKqa9zddhETf2/WZ10tQlcReANhfQRAW4iq
	 MFjtwVsui76M8GGG+klvcv4VLOAhulo/RDjGvwZH2VClWZpsLeOybGOMmN0VolCiDIpnq
	 3ubYssL/HQP3UwDHfP9JEpuEL6dl9BGF5wGbsxsqAP0F7/zntf+T7tpDI7KwLDSyJhmyA
	 zSyI23OMZRc0fDsOK6+4DSA53ICk+63Yw4Qec51EWKzwblhbGyIXMXqQV6tjuDc7GKdRv
	 vvqd9qiE4rv+CImn/YI9SAqe33vWFPGNGQ3Pby/1t8yIdF5cZcDLau19uuPYEER+Ijw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758837;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=JsAcESdt7uIj695NY/eDCfZ7zhJHDMrhAAEMWn9bqTA=;
	b=lRnN2MQfLvEjMS1fpdZ3C9dI7hPWMbjR+o6cQXnLUG2iBrWPA88DJ3dmDqOWAJ+L0b1t
	 oL1ZGehNGynS6B6QWtCa8FDXd2rtnoLPkJrhMlpj/4USr07Y/gSNLcZSEFTqSo3TU8POA
	 jyyc/81/rRDFlV+DDqu2aEVJxpMd6lnMVi00kaf3AHtMJLZB5P9R/NViO0uMSLeV3hSuo
	 kNZ1VUIsxYxmwxrmsYPAVTXcUGHFiIFUndfhulrYNrPPxrEntm8kd2hbsZgTNiIM7b5jy
	 GXOAH5rpRhQOMRFZTAgezbcq19uEBPeh6eEXCpUOuUmlQal76n5z40ks6/gAvViA2aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b98eR6K2;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k1dF8UR4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCA606A32E;
	Fri, 27 Nov 2026 05:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FCA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b98eR6K2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k1dF8UR4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795758837; x=1827294837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JsAcESdt7uIj695NY/eDCfZ7zhJHDMrhAAEMWn9bqTA=;
  b=b98eR6K2uHEglsstL6dFqeZ/Mdv4PJoo3Gd4rHZtBCSUlH+hc+0kIB4O
   dkYEUYnt/mE21qBGQHK+HRAfxWJBAFwzS018SWzC/9+19V62NZCYZcvMT
   xHA0a5HXQaVGYKipf+e1nPp1EIlbYe15Y2j8Kni+8T/oYP9fD12Hd0a0L
   ERQZnxHOImOGBB653KRplVTCIl62q3YfDwidJG1lFs1UAqx1hZTWxmqm7
   t9xwXdsWOUe82lP+wkhrFeY11iT21psZ4pqZPQZ+lIThp983rFKGMLZrY
   BN85Z90RbEd4be6+nlArFnFhAwG9Eeil0AGSuKetAMFp+d5GwTqlfTvo6
   Q==;
X-CSE-ConnectionGUID: Mjlqt0mcRnGbUAZw2VGdkQ==
X-CSE-MsgGUID: gS49tYoUSiWt3IP+8GMFdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4570108"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4570108"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:53:56 -0800
X-CSE-ConnectionGUID: Kh2bGyUgT8OAUFgltvT2GA==
X-CSE-MsgGUID: 0LbacnhXRESamhCrCKyAAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12564947"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:53:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:53:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 21:53:55 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbUDXCcvNiRIgGPZmj1Jrdk3rQooqg16TtyO+ZvPpoIvIcAqz2S6CRA+ATCCZNPn14mFLShy6IgNNPwsoyg12i0Yx29A5m3PXvJO/YkHCEV9n28XvvwEhYg9PrCpAQOUPVPsM5lxzPtOuag4SvPlqVODntgL+1Wi9zH91gx4yiX/HBXo4ZK7YR99eYTgQou6+BinLXlbPg0uSk0gTfORq+WAgKDOqbtHXRyV6qF84QuinpfS0TW6kREFXt+aRxYGgOK8CLXyn+Q9GkGjB9vRo8l5Wsc7a89EHKjjdw+gwR4R59YMaKF5x0i8XhNR2GMqbPXY9AEsB54LeMdVlNwrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsAcESdt7uIj695NY/eDCfZ7zhJHDMrhAAEMWn9bqTA=;
 b=gIQ8YI5MPOq7YLcZgJ3mJyy05e3J/pVMro1MuYkHHsX5bxCQxtDF1g7XPNKUIek4baCPJL9CyYhs1WklTfor7T0D4eJLGs74/6719cUwhus4k1XRoWPn6TP6EhWw2eiNi4kXJwUJc/nqqJFBsJFyqYVs3To7/+WjIGt7JY7Cx19pami0kr1ooJzhFU2D15uosmvFqalznCEWjgMpCHEJ6+XUC4ptACjT5mkSvVIKNJWsBNWgLicclWW6Yjg33JjIGFmy+GyqGheEZqPaUnZh/d8VAPzGiSnmjiK5OXfs5ZSIRuo7TEGEGIDQdJ9nZeF75z7984Awq2zpxjATdCGw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsAcESdt7uIj695NY/eDCfZ7zhJHDMrhAAEMWn9bqTA=;
 b=k1dF8UR4r6cdFVypZkTWtrv+Y93GM60onPSQA8/37aGKnu/sM2xtJovcj5kHqm/9P4Qy6tR7GbkGKkaqQPLY3hp+e/G7sNvycffu65yt/Cxg/EHduSP60lUsedIhR60bNxleF7Gn5tw63pOJBgArbOoBrpFspE01r1X9hoAvEXA=
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SA3PR11MB662844.namprd11.prod.outlook.com (2603:10b6:806:538::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 05:53:48 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:53:48 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "qinyuntan@linux.alibaba.com" <qinyuntan@linux.alibaba.com>,
	"lenb@kernel.org" <lenb@kernel.org>
CC: "michael.hebenstreit@intel.com" <michael.hebenstreit@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"xlpang@linux.alibaba.com" <xlpang@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tools/power turbostat: Fix average format for
 CPU/core perf counters
Thread-Topic: [PATCH 1/3] tools/power turbostat: Fix average format for
 CPU/core perf counters
Thread-Index: AQHdfjOr4R/ISWqkIUe+geZ/HMBoOA==
Date: Fri, 27 Nov 2026 05:53:48 +0000
Message-ID: <766176a7044fcb1886bf65b3a908c7f0a354fd6a.camel@intel.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
	 <20261124032723.157254-2-qinyuntan@linux.alibaba.com>
In-Reply-To: <20261124032723.157254-2-qinyuntan@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SA3PR11MB662844:EE_
x-ms-office365-filtering-correlation-id: f7dd601a-2d79-4259-dea2-08df4c4ace52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|11063799006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|6133799003|3023799007;
x-microsoft-antispam-message-info: Usb6ITzfMkAo/o+uOIoUxYy81HaKZx3E2YFcfTEDUD1NdZ2yVP/mLw53CfYW3hUMg+dbTOiI5XDY8ZKUeTW/uOaJ0xf1d5euh0ZC+VXqCqWfGv39yCFUxwfQbkGcPk8iggRY95SjRCUUVZdOHY+iIGn9EmJ9dJOj6fbkW38Vlx0adCNfaIUIfBaPNXshKKefRT7EyY6Ab7k2urF2oJ8PumlCIrZqE7OZ7b9kjP5Kf0F+OfFuQvZ2Pxf7uoqw+ZDZooCOQHGKQSsT8OgcJDLg3Xw/NDtK8LxDmC+ssJaTqgrQYsA5BeWmdE7llcmyMXIql6sC8PVYI8SfA0P3o9lrnX6qwdiZf69tDgW1LHyYjWKWjjncASV7xNFssMJKQkAHlF+tLTi+r2QuZbGJweZYZqZdeVMPcM1TVhmEkF52mERD2S5xELHOZhKqnG0CQXpN+/KMn1up4RAdDQ6ajWO2K5OggpZz5wFCdfzSDaxU8+n6nNYpYZlPJIOiNvF7YM3gTgs7r44NFwM1h6sh6WLCpE2PRyUFBDINFFNJy6jIix7d0alUurVt9sJrrAHpdkKgmaLO2ybX+Dez2uaOPaLBSNUMHoTStbhx9XnI1Dx269dPlIKSCu/45CjbYDOGTxgqTjhvtg8Y3nUxOs8L62htwCQHbTbWnxIacZyfY5zDYagKB6hyshq3o4pWU+Cj965DSOyDenCniw4XOPyYNLS3Aerj//ng6RrDcyN9jAzmVpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01ySlFlK3daNDJpek1zWjA4ZitrbDl2OVlHanR5Z0kvdFRneEhQMUs0dGwy?=
 =?utf-8?B?N01JWmpwemtZRG8ySDloNmFCSWNXZVk0a2tNVmh6K1czbWxCUTd1b25ldUpB?=
 =?utf-8?B?YncvQ0tTdzdpK1VXdm93UDRzSEtIQUM5ZnlvRTdpUDdRWVAxTTdWVlh3ZHJG?=
 =?utf-8?B?TUx2YVdVdHF6R2hWdHpVZmg2TXVLNUM0RHFCTGNwN0xKU2UzalJMZFVia0s0?=
 =?utf-8?B?M0U0U3dJbmVxLzhhUFMvcTZjRHFzb0JXVFFLalk1SCtDdUtidFhIdXRmMUdq?=
 =?utf-8?B?K3hIb2w4eHVZek1rVTBLbGpYSGxiaUp0RFlpVXp4cnBHZXA1YUt2a20vZklI?=
 =?utf-8?B?TWs5SFBVbUh0d3NTOUlxZHNpNlJCOHVKS0xFMTVNbzBoSFVJM3VsWEtPRkpm?=
 =?utf-8?B?TWVxT1Awd1FNRXpydWF0dmlDa0pYdWFRL29lMmdRQzk3bGIxMlltMzJWb25O?=
 =?utf-8?B?VlJBZjB3SnhLMHRUQTBvUWI3NmJQcFovQVlIVW9Fbm11Rm5aNGxTSCtmZlVG?=
 =?utf-8?B?RmphMUtGMVBWb2Y1RGZ3ZTNwbGV5SUp6d2tWZHA2WkRLdlVMb0VFaHpDVWZC?=
 =?utf-8?B?OGFGUGJzNm1jVHB3a3VzQWZ5UXNKd2hhQ3JHZFZZdndvSVJEcCtqYjZhM295?=
 =?utf-8?B?NzJYT2xRV3YxNHJHYlhUc1E1dmFYS0F2eTlwUjJVQ3VDcHo3OWFNN213ZGZV?=
 =?utf-8?B?VXl4d2FhdGl0b0FPUmJQck5GY1hNWlltK3YyK3dFNklkM2E0KzJDVmw3NjNp?=
 =?utf-8?B?MFpFU0J1ejM5MER4cXRGcUxwK29seU5EejhGNytDUDgwU1FYaVh6MDF5WnhD?=
 =?utf-8?B?N2x5VVNBOGEweCtmZnRYTm9uVHBGaUdRZnpaRTlwWXBSMDlOb2hDTTY5RmQx?=
 =?utf-8?B?cWNrdUtoblNFVHJmYzVjYUpSK1pQV21LU0tEWVZYTzdSZDZHRDZ6Y3hocnJC?=
 =?utf-8?B?dGdsUHN0Z0lveDBBVjB0Y1lodmxHL2tTWWQ1MWlkM2pWNCtrU1Zra0RxaVBv?=
 =?utf-8?B?SlFoOVJyZjlqVVpOVjZHK3o4YUdjdll2MWRtWmRzd3QwSTUvaDVuSVJpQmh6?=
 =?utf-8?B?cE1HYXZ0dGhkYmdVRzZqR3F5UXhyRzhZdVN4d0diWXBxTzNQNTRILzJPZzhD?=
 =?utf-8?B?bDdxbzNZS0NpcTV1bG9BdHFwWFhmbzFTanoxVFVJVkVFeC9idTBVMmZvckpx?=
 =?utf-8?B?S0VoK24yUnVnMVRocUdEMlovRVdHTlduUGtCN0Vwblg4UFV1MzFVaDNWcFN6?=
 =?utf-8?B?c1RJcUw4K1gvVVhkL1BXdFpPUWN3QmJ2QWVwWlRNOERpWk9aRXVHZWRiU1VJ?=
 =?utf-8?B?SmFVamcvUGpuR0dJOENTa29NSEJic3lTREx0Y0czSGtXYVBjY2NCYmd0VUho?=
 =?utf-8?B?TlozMllmMjBWWEg1ZTYzS3lrd0YyTmk3ZFFRSE9VcEVjOFd3SEJBUzZOU2FJ?=
 =?utf-8?B?YXZlbDErZTRSdm5iQnRYTVgxaVd3LzA0Z0lJNE96cnF0ZlBDUkpCOW9EcmV5?=
 =?utf-8?B?WjlyQ1ZqU3g0TFRPM0NCbVd6TWNEU1dIc2xtY01ibGxYVXVmVEU0SzMwcFo4?=
 =?utf-8?B?b3ROcW9QRTVEUWJSQmNGM25BVlJIQUxYR2FOYlhZOVpEeXYydVljSk5zekJz?=
 =?utf-8?B?ZXd5TEZ6am1JOGtGK0JDVHZRTlh4ZnRQMktBMlh0ME4zSEhvVzhVUkhJK3dk?=
 =?utf-8?B?dDJ6M0V6cUdTck95N0k2N0IyUDduSCtyZWZUN0wzSEhSd2JnWmxZQjNsczMz?=
 =?utf-8?B?ellGVVM5ekFVWEQ2RXRmdWtOaDN6RmlyL3l4UUhITDhadzBOei8xR0w5MWRR?=
 =?utf-8?B?WFN6VGsrSVREbWNkSmF0ckorMXIzdUpkNlJlVEZvTHF2b2twMlVRVXZXeEFm?=
 =?utf-8?B?VlhqYis2RTgwNzQ0SC96MHlMaVhsN1NmVjlndTBRcm5oOVQ2dmFJN2VkaHNk?=
 =?utf-8?B?bzkxZ0R5TVVXUE9jMkhhemdkbkJwYTVwUU5pUTlvY3pxUTBObnJ6Um9PdDh2?=
 =?utf-8?B?ZGdpUEI3OG1aakhBUjd1bVZ4K2J1OWtxVXVMaEh3UjBncXBOczNuZ1hlclh0?=
 =?utf-8?B?VFlKTFFEOUZzS0lkL0prWHI0djlqS1RzUllEQ25HL2JKSmVtTW9rbGtwVUEy?=
 =?utf-8?B?SzMwTWh2Q3BOYWJCV2l1Z1NqaWRGSGZ6ajFDRlFtdGZxbUY2N3NadTVjc2ZJ?=
 =?utf-8?B?MGpOMWNHV1FaRDZzbzFLdGpHY3d4elYwK2hwMHUyaWlxUUdBTnNjdGNyd0FS?=
 =?utf-8?B?aXA5OGI3cFU2aUI5bC9FSGtNN1BCVXF3UkdDa2Y0T1RHMy9sRXltMGtldzlY?=
 =?utf-8?B?OE5DOXlwYkV3QjlGek1KRjFrWlhrcU9OM2RRN2o4ZFI4d0MvcTVCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B96F236006AD248B0EADEFE1338B3A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V8dk3vvENFlLfOWOP3cOaUgDvCH959ZIdrLukCwL2w2IXWbVBWzQLKoTrS4dgRbq6ACbroLLlkI3sQTuzYoQ7ojUW5+qiQv/G/+5BLmAqXTnnCZRDICgULzoHecOWP7iSVNXE7c241sHmigj1XwIHs5y8FJQBraT8IfF0oCx4hfeeR2M1OZwFDYF6EE1zOaLtLkf5NzxHMD/vlrswvc34x18pLyLtx406tJEEEUm0mcRkaAQ1WwwjLoyJ3ZoH1StFl1ZTQGnstxeONDFijZXDPn7yN24asfsSlNGYPoWOOii60BjoECP/lCe3Sgy5kXrHdEGtpehlTAx+PplpeOBHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd601a-2d79-4259-dea2-08df4c4ace52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 05:53:48.2493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaOzK/F6Py7IfAHb8hmN8bo63V/O8Xb6ohZ/kGXd+xtrG1rBdaG8mzan+DdWWjEPPphSKnXuDlvGVC39F76+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB662844
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTI0IGF0IDExOjI3ICswODAwLCBRaW55dW4gVGFuIHdyb3RlOg0KPiBQ
ZXJmIGNvdW50ZXJzIGFkZGVkIHdpdGggdGhlIGF2ZXJhZ2UgZm9ybWF0IHJlcG9ydCBpbnRlcnZh
bCBkZWx0YXMgYXQNCj4gQ1BVIGFuZCBjb3JlIHNjb3BlIGluc3RlYWQgb2YgdGhlIGxhdGVzdCBj
b3VudGVyIHZhbHVlcy4gVGhlaXINCj4gc3VtbWFyeQ0KPiByb3dzIGNvbnNlcXVlbnRseSBhdmVy
YWdlIHRoZSBkZWx0YXMgcmF0aGVyIHRoYW4gdGhlIGNvdW50ZXIgdmFsdWVzLg0KPiANCj4gZGVs
dGFfdGhyZWFkKCkgYW5kIGRlbHRhX2NvcmUoKSBvbmx5IHByZXNlcnZlIEZPUk1BVF9SQVcgcGVy
Zg0KPiBjb3VudGVycy4NCj4gRk9STUFUX0FWRVJBR0UgZmFsbHMgdGhyb3VnaCB0byBzdWJ0cmFj
dGlvbiBiZWZvcmUgdGhlIHN1bW1hcnkgaXMNCj4gY2FsY3VsYXRlZC4NCj4gDQo+IFByZXNlcnZl
IEZPUk1BVF9BVkVSQUdFIHZhbHVlcyBpbiBib3RoIHBlcmYgY291bnRlciBsb29wcywgbWF0Y2hp
bmcNCj4gdGhlDQo+IGV4aXN0aW5nIGhhbmRsaW5nIGluIGRlbHRhX3BhY2thZ2UoKSBhbmQgdGhl
IE1TUiBjb3VudGVyIGxvb3BzLg0KPiANCj4gRml4ZXM6IGRjZDFjMzc5YjBmMSAoInRvb2xzL3Bv
d2VyIHR1cmJvc3RhdDogYWRkIGZvcm1hdCAiYXZlcmFnZSIgZm9yDQo+IGV4dGVybmFsIGF0dHJp
YnV0ZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBRaW55dW4gVGFuIDxxaW55dW50YW5AbGludXguYWxp
YmFiYS5jb20+DQoNClRoZW4gd2hhdCBhYm91dCB0aGUgUE1UIGNvdW50ZXJzPw0KDQpUaGlzIGlz
IGFuIGludGVyZXN0aW5nIGZpbmRpbmcuIEl0IGFwcGVhcnMgdG8gcmV2ZWFsIGEgYnJvYWRlcg0K
aW5jb25zaXN0ZW5jeSBpbiBSQVcvQVZFUkFHRSBoYW5kbGluZyBhY3Jvc3MgdGhlIHJlZ3VsYXIs
IHBlcmYgYW5kIFBNVA0KY291bnRlciBsb29wcyBpbiBkZWx0YV9wYWNrYWdlKCksIGRlbHRhX2Nv
cmUoKSBhbmQgZGVsdGFfdGhyZWFkKCkuDQoNCkxlbiwNCmlzIHRoZXJlIGFueSBpbnRlbnRpb25h
bCByZWFzb24gZm9yIEZPUk1BVF9BVkVSQUdFIHBlcmYgb3IgUE1UIGNvdW50ZXJzDQp0byB1bmRl
cmdvIHN1YnRyYWN0aW9uPyBvciB3ZSBkaWRudCBhc3N1bWUgdGhleSBleGlzdD8NCg0KSWYgbm8g
c291cmNlLXNwZWNpZmljIGhhbmRsaW5nIGlzIG5lZWRlZCBoZXJlLCBjb3VsZCB3ZSB1c2UgYSBj
b21tb24NCm1hY3JvIGZvciB0aGUgcHJlc2VydmUtdmVyc3VzLXN1YnRyYWN0IG9wZXJhdGlvbj8g
VGhhdCB3b3VsZCBzaW1wbGlmeQ0KdGhlc2UgbG9vcHMgYW5kIGtlZXAgdGhlaXIgZm9ybWF0IGhh
bmRsaW5nIGNvbnNpc3RlbnQ6DQoNCiNkZWZpbmUgVVBEQVRFX0NPVU5URVIocHRyLCBpLCBtZW1i
ZXIpICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgZG8geyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIGlmICgocHRy
KS0+Zm9ybWF0ID09IEZPUk1BVF9SQVcgfHwgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAg
ICAgICAocHRyKS0+Zm9ybWF0ID09IEZPUk1BVF9BVkVSQUdFKSAgICAgICAgICAgICAgICAgICAg
XA0KICAgICAgICAgICAgb2xkLT5tZW1iZXJbaV0gPSBuZXctPm1lbWJlcltpXTsgICAgICAgICAg
ICAgICAgICAgIFwNCiAgICAgICAgZWxzZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgIG9sZC0+bWVtYmVyW2ldID0gbmV3LT5t
ZW1iZXJbaV0gLSBvbGQtPm1lbWJlcltpXTsgICAgXA0KICAgIH0gd2hpbGUgKDApDQoNClRoZSBj
YWxsZXJzIHdvdWxkIHVzZSBVUERBVEVfQ09VTlRFUihtcCwgaSwgY291bnRlciksDQpVUERBVEVf
Q09VTlRFUihwcCwgaSwgcGVyZl9jb3VudGVyKSBhbmQgVVBEQVRFX0NPVU5URVIocHBtdCwgaSwN
CnBtdF9jb3VudGVyKSwgcmV0YWluaW5nIGFueSBjb3VudGVyLXNwZWNpZmljIHByb2Nlc3Npbmcg
YXJvdW5kIHRoZW0uDQoNCnRoYW5rcywNCnJ1aQ0KDQo+IC0tLQ0KPiDCoHRvb2xzL3Bvd2VyL3g4
Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMgfCA0ICsrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bv
d2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMNCj4gYi90b29scy9wb3dlci94ODYvdHVyYm9z
dGF0L3R1cmJvc3RhdC5jDQo+IGluZGV4IDEyMzA3ODkyNjEzMS4uNGU3ZWJhOGQ4NzUyIDEwMDY0
NA0KPiAtLS0gYS90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+ICsrKyBi
L3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LmMNCj4gQEAgLTM5NTYsNyArMzk1
Niw3IEBAIHZvaWQgZGVsdGFfY29yZShzdHJ1Y3QgY29yZV9kYXRhICpuZXcsIHN0cnVjdA0KPiBj
b3JlX2RhdGEgKm9sZCkNCj4gwqAJfQ0KPiDCoA0KPiDCoAlmb3IgKGkgPSAwLCBwcCA9IHN5cy5w
ZXJmX2NwOyBwcDsgaSsrLCBwcCA9IHBwLT5uZXh0KSB7DQo+IC0JCWlmIChwcC0+Zm9ybWF0ID09
IEZPUk1BVF9SQVcpDQo+ICsJCWlmIChwcC0+Zm9ybWF0ID09IEZPUk1BVF9SQVcgfHwgcHAtPmZv
cm1hdCA9PQ0KPiBGT1JNQVRfQVZFUkFHRSkNCj4gwqAJCQlvbGQtPnBlcmZfY291bnRlcltpXSA9
IG5ldy0+cGVyZl9jb3VudGVyW2ldOw0KPiDCoAkJZWxzZQ0KPiDCoAkJCW9sZC0+cGVyZl9jb3Vu
dGVyW2ldID0gbmV3LT5wZXJmX2NvdW50ZXJbaV0NCj4gLSBvbGQtPnBlcmZfY291bnRlcltpXTsN
Cj4gQEAgLTQwNzksNyArNDA3OSw3IEBAIGludCBkZWx0YV90aHJlYWQoc3RydWN0IHRocmVhZF9k
YXRhICpuZXcsDQo+IHN0cnVjdCB0aHJlYWRfZGF0YSAqb2xkLCBzdHJ1Y3QgY29yZV9kDQo+IMKg
CX0NCj4gwqANCj4gwqAJZm9yIChpID0gMCwgcHAgPSBzeXMucGVyZl90cDsgcHA7IGkrKywgcHAg
PSBwcC0+bmV4dCkgew0KPiAtCQlpZiAocHAtPmZvcm1hdCA9PSBGT1JNQVRfUkFXKQ0KPiArCQlp
ZiAocHAtPmZvcm1hdCA9PSBGT1JNQVRfUkFXIHx8IHBwLT5mb3JtYXQgPT0NCj4gRk9STUFUX0FW
RVJBR0UpDQo+IMKgCQkJb2xkLT5wZXJmX2NvdW50ZXJbaV0gPSBuZXctPnBlcmZfY291bnRlcltp
XTsNCj4gwqAJCWVsc2UNCj4gwqAJCQlvbGQtPnBlcmZfY291bnRlcltpXSA9IG5ldy0+cGVyZl9j
b3VudGVyW2ldDQo+IC0gb2xkLT5wZXJmX2NvdW50ZXJbaV07DQoNCg==
