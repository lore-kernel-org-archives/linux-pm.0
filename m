Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58742A78B
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444613; cv=fail; b=AA5loGizR641ui3KUB+FhXGs/TY+F9yIuC+cp0KnJwb9TZroTgHLi1OxebxB8jjlqn7LDgiKUccqRYbTRWAdRQCvLd6qTmtm8dDSH7P7KJVl5UpCBnB+VK01yVYGqiIVS+oko6TNi+LMLnUTNgNBXZjmtOKqOCPBWyAyUKMFKrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444613; c=relaxed/simple;
	bh=+qzf0p3M7ShJz+cYm7kYVd+Gh0Khar1i/wlrxBgL9ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzDtnuXMw/3zwZNlGdNyN0q+HANgG0wpL87zjsjhb3kCOsN9pVEejC/3gh+rPqp1VcuvXEG90oKQwV5MrQhTuaTf7yPlZC7FAzVz/fd18X6Hxwoyr6WjBY1u7EOR2xtJNV2MSPvMCifFPEXbFKLlfWQx7xPEGFG0CNBshfTO7UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDM88E19; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDM88E19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786444611; x=1817980611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+qzf0p3M7ShJz+cYm7kYVd+Gh0Khar1i/wlrxBgL9ss=;
  b=BDM88E19QQOXQUjRHOUPPSX/xuLjel8lZJ53xB0KGvo0HFSFc06cOdst
   gOxcTDzrAC8okf1vwhJ/yszRSHpe7hDYfynN69iaDgp3nFAokQY1SneNN
   a147Poy8+Ufo++zfrlFE5hdNxHOG90+UDGCs+EUEA7MqnuUGTxc1Z8G/3
   BHf481I6HxaO1BD0CK9CjS4YD55i6zpYrxL1X/56NzVrK6L2earE0H8W8
   wZbMcbvTyZTMwPQh+EFO9Puosas/GaIem3mmdSweiRoQcui5gfWhKeLxn
   3rs4sGmBpRBNNOG9GNe9HkxKqULYnJOUBZOcME/BgsSTpxihObhZevsQ1
   Q==;
X-CSE-ConnectionGUID: PdQjCUbNSqiv8W83m6yGpw==
X-CSE-MsgGUID: JpgumLZiQGyVFliRIlzw+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90786207"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="90786207"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:36:39 -0700
X-CSE-ConnectionGUID: +nP3ArwETACkN/DEG3vSfg==
X-CSE-MsgGUID: cjZNHqKpT3CKtANftZrg1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="268463694"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:36:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 03:36:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 03:36:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 03:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH1+yAesDjBrVVYDQf/nqz1eHToqpgG73ngJ8OfOxICm9hGm1IGhGx7uA3BPJBwnS7EMldcVe/kdTHNqe1hSIafBRmx6JNia/8dfXtJJ3lcE2xlyzlWecieCHj1te02LbVw7rcg8wD5M8KhMx4s9Uo13EQkagdP78KK7h4R70blBMzTVusHUZg0UowJgiKehb+lMKQfv1cXT7B0rJX8Avdh/oLsWsINXB+zBJo/AiWSFUoFweIu/QtwXaDK6pANWrLRxbXPaB7sA3oB82X3ENZO0PcvKV0F8ITna/SzbXYOqOvQ86b03bkmCWKL7YxARlJCCK1WFcpTjgpdqO06lMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qzf0p3M7ShJz+cYm7kYVd+Gh0Khar1i/wlrxBgL9ss=;
 b=EM55GJWBf6j/iGRTT//hUIDjZbCFH5KsYXTiykoJaFpshQ7/0xe3bl5N++4lO9Fzb/N9SMxiWsWDmkVKdaCG8D3kJI3gOHRQodank2pBop/7N2YLONodFV4x0Uk56c9KHc6b9FSqhSygv3Bv1WxWbSzNbkdLdpDHQm6A8prItzsKqFUUlQjTeCtyc6VQWa5TYqtDXjtLfuH0iajoyEuwkIS+EbQUOsVg1nDS8gyqUb9ROjvLKlNFLs/VTdf5EFsoZUqzxzY52A//kvSM16ioPvHRGH/ixya+vet6Lzuyf5ZDmQewF5gUuq2sDcIX+x4UIT/Z8DgkG1wguHAprnqrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:36:34 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:36:33 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
Thread-Topic: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
Thread-Index: AQHdKWp0L4olIup+1kiOPKMzhChPqbaYnzAAgAAHyLA=
Date: Tue, 11 Aug 2026 10:36:33 +0000
Message-ID: <LV3PR11MB87680CA8F9B3172110B7EBD0F5DD2@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
 <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
In-Reply-To: <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: 15fde519-a4ee-4f4f-ead9-08def79469fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|38070700021|3023799007;
x-microsoft-antispam-message-info: nMVD3pdQ7+HSalBmmAfAu0vg1lJY7PGxaWTSgP/1EwwB9cxf4cwKa/3hmEOKkWXGVzlTwogOGrKQY9lZUI5/sUhHFklvEqF9JYyFloBTJGRC6Tem+/u+36lGn4yRwSYc9TkfseQsdO4UJpmOf9rp8hQjuFxh7z1iAxhngjNhvk7P4oOmfpfla1oxyxr9zPP7IMf4vcC2OxrILNHDV6blZ9sy7Jfr9ezyfihAtPoco7QLlXoXD7/bMYlg0mMQHw6rnvfgrwOE+TvUyANd0/48ebM139vD7takIjelUxziEsD3vqDRTUCtLlPIK2vOtgLN2GvWVvk6u98FTuYK8KToAOSKm0NVEdNhrrt6OTL+cGCUZ8PuPswG1oJ7yijnNcJN1T/hkMYgXOuLbIR5E6E+BMUxVxU6MtR914O+Dkyw33Fm5PN1jeSWje1S44Dn2AyvwaGLJgCXyvwtJM4gXrRGnMEDP2n6syncdjzv82fqccaLUZyjFcDsVGatmjqwDCWCjhvS1e1CUKJjGCagWF/n1Z1OVE8e0el4nUrvh3zP0qsjcjrZYw2KuL5vz/QxrjH2kni0XK02RHWSYLe7iSl9WYBR25UnHtb4FbLNSTyyZO1V9YeGLCBqDgfamh/pUZzZcgVGY1AgLR6x84lZdiID8lY0BTS3ZR38s6On1FY8Yfny/HLT+xU9r8Ng9YrqKq4Zoq9RPU+yRAuD2UeZJuaR1oTZ5GSjvw+Qe3ynMdIpztY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(38070700021)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNaQkhRZzNHVDdmNDMyWTVsT3ZGVHh6NFRjbWtIMHFCQ0hDSERHYUdvbzRE?=
 =?utf-8?B?SHlzajR6SEJ6MFFBTlowRWNXWVNRY1BwU2VONHRRK3ZVVVFIdkh2UWJqdWx5?=
 =?utf-8?B?U3N4M2hmNEQwREVYV3hoTWxxWEt1QmdkZWY5QndSRWRxZWdLdGpia2xZSUVO?=
 =?utf-8?B?Y2ZUNFJna2YvYjNoeDZjNjZ5cHN1NjhNMkwrSDc5enA4MkJLTEtoZ3crcjZ6?=
 =?utf-8?B?QzZFNjhPTzNnK21ibU1UakE5dTRWcGc3bXRRTmQwZWhBUFZZRXZpLzJ4NG05?=
 =?utf-8?B?cFgxdU9lN1N4VStSVEdFdy9GdTY5TFR4VkpPWXdVNkxKaWhyMXNtWUhpbkkx?=
 =?utf-8?B?eWlmQjMyakErZFArc09KTXpROFgzdEVDay81eTZ1L2FsVmZ5NjM4cU54NFBD?=
 =?utf-8?B?UDlXNEorejZJaHpTa21rM2Q5cnByckpudzdHYmNzVGVydFliRW5mVWJQS2Rn?=
 =?utf-8?B?aWZGRzh5cmt5bHlBTDJTbGZRQWRxY0tPM2RTazJJellseVFDNzJ3TVVjYUlm?=
 =?utf-8?B?S0R2S05ETnFCUEE3T3NkM0JNT3Mvc3lIZGdGTktlM0xTR3FlUzc1dWprSU5r?=
 =?utf-8?B?Ry8zUElic3hBVWhLeTdNb2pmVHh3RUZGTXJRMjlxRmc1MS80SVlHbWhPRkNQ?=
 =?utf-8?B?OXV1Mktuc3B3Y2poQWZkTXRpV2xXRE5FVkkvMlhSdDBBNDFHeXk1aUlEbVBp?=
 =?utf-8?B?bmdBd3lPeU5DanR3cWJtcUdRbWxRZi9MaUY1UVhpdDZMVWV2bEFGR3l5UGZk?=
 =?utf-8?B?OS9DTjJmbFBUZUMvK1ozdjFLb1lJUVEydWNRaDVXYTcydm5jREtRNlBFUE8r?=
 =?utf-8?B?eWo3UE85UGFyTEtjNVBYelBWY0pHcGt6ZWZ6MTJqaFp0b25ReGpOY1UvWTZS?=
 =?utf-8?B?Ynh2c0lseTBxaGw1NU1EdHNWMXZkTVRqWjIzcDcyZkozZ2Z3T1QvdEZncXdU?=
 =?utf-8?B?ZitGWXRiSGpxSEdhVTJoKzg3MkNnUzIrcE5zNHdjSzlmSXhlWmlFYVV2bFB4?=
 =?utf-8?B?em5weEVnUHZXYVpkWFFpYUZnT0ZqdFNDQllxTGwzK2tRbWV5cy9SRU80VGVn?=
 =?utf-8?B?WG55WUE3UkdkR04ybUNKSERta2VyWGI3QVRhMXNXK3VSWGR0S3MwKy9SV1Vu?=
 =?utf-8?B?TUduN3BKVXJ1SlB0ZlZTNXpCZUFkZ1FzRE1Ic2QrRVBucWlibzJSWUJsWTlj?=
 =?utf-8?B?a2pSZWpOL1k2VGdtL3BGQVVGT0xpM1hRV0RIdWlyOE5rRm8zdlBuWW9WRU5k?=
 =?utf-8?B?UXROQ0NwcWcraDV3MWJIY2prZ25oajVKbG90aFlwQmFKcjk0ZTh5L21DNFJY?=
 =?utf-8?B?WHF5QVpqRFBDZ05JcjlmOTM2dmYyekwyeGU0QWJHYTJEelJZRDNmT0NzSW5H?=
 =?utf-8?B?OGN5S3doRytKSWNpNko5V24ybUJwRWwvWWlzN1ZzT1JEUFBxYlZWVUdHVDJ4?=
 =?utf-8?B?d0ltcm1DMzZaS3o1aWVRVjBGWndpQWsrNkwrRFFvNVVabDJHSll3NWQxa3Ur?=
 =?utf-8?B?dC9qem9MTitDSzBpSENrb1lsR0U2ZE11dUUwUlEybDhZVlhSdHJyN1A1amN2?=
 =?utf-8?B?TCtGVm1PRkd4eGtScjRJRXUvV3RCcGxUVEs0YnpqV0h5MkJQaC8zZ01JZVEv?=
 =?utf-8?B?dXNiR2xmc29ZR1RkQUoybTBwbHNKOXBuWDEvYXBBNko5ZVIrbEhJdkVWUlk5?=
 =?utf-8?B?dUszcS9oM01xUlRVRTZ4SEl6RzUxNDBRcWltS01meE56SDNxak45elNMeEpi?=
 =?utf-8?B?U251QW03UGZwKzF1UC9LeTAxVkdYY1BPaHY0UmxnaFVTdCtOVFhOaGFDTVlI?=
 =?utf-8?B?dU9BWkEybWNvaVV6a0hmK3ZkSGcvMXBMVGpMb2lIb0YzSFc2M24wYkMxeUNz?=
 =?utf-8?B?ZzlENlowRm5CU2Q1SGdaVGJqR25TTDVzc0VaWkpHUTU1TmxVSE9YM0ZEU25t?=
 =?utf-8?B?UWxKemtSQ1FWVDBNc1FxMUt3ZHBHczBrekx6MURXdE5IMld1YStraWtVU25z?=
 =?utf-8?B?cHV6LzlNcnR3VzZwQXpla1hwNzFCa2R0MGJvdUsyU0ZYZE1wS2cvWU14M3BK?=
 =?utf-8?B?Q0xHY0EvSDZWb1BiQW5RdFF2NDBNZDF2RFZVUDVkR0hua1VaN1gyZTU2Rmdp?=
 =?utf-8?B?RUxtMUxvV2U1RjgwRTBPTGdYeHFzaEphb05KN0xpOUozbnFtOW9qK0lNWFF0?=
 =?utf-8?B?c05TMU4vVEY4ZFpZc0dSZTRMajhrTHhGYkVQZkxtNGduaVJDcGh4UGRhREli?=
 =?utf-8?B?eUpsRGNyVmVWY2NONjFTbkZ3WXptTWcxZ0MyN21aV1FBVFdqNmkyNGFJbWNp?=
 =?utf-8?B?WUxOd1NsNDZzcko1cnB2SmF4ZmViYkVCaGVmZ2RDUUNRU2dpL0U1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dLj5BpT0KRIp0hoCSivHaFAnrgGtSkkTKS2awe+Yy+UemImSQ8IB9s4WK6n4kmR2mMP072/ZEfEL0vrScie6PjQI/tl7HnXTMezuqmyGcnXESzO2KQfCGeyUPzyOji9mCCIN6Io+jvICdbZLPtl81K7PH7KxRbxwPUb3p/0WPYAbQ4V55IYFoE7csapi2hWJMP1Vo1i+Mi20Nd1KLQiHGJt1HDFSnpulbBAdehenrsHezXdVXSQU4nnTMeTyNKfGOdPaIdenwokMHhd6G9dFZIzzQLQcT1lKorX7iTaIIaH4QFkHczlJ/kDKOfYWjrI7ppRKrbF7hXwmaFEjg4p8GQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fde519-a4ee-4f4f-ead9-08def79469fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 10:36:33.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLfNyhhDl1H1h8/Pm9k7XWfgkGF7rmQ7JD5SbjhmaUZPq4Y2B4DLtWMW412vv3oWU/LTpiKhs9bQtiEth8efNLxIeWxxbjtXzDYBFBzQ/wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDEzOjQ3ICswNTMwLCA8cmV2aWV3ZXI+IHdyb3RlOg0KPiBU
aGUgY3VycmVudCB2YWx1ZXMgYXJlIGJhc2VkIG9uIHdoYXQgSSBtZWFzdXJlZCB1c2luZyB3dWx0
L3BiZSB0b29sLg0KPg0KPiBJIHRoaW5rIGl0IHdpbGwgYmUgYmV0dGVyIHRvIGV4cGxhaW4gdGhl
IHByb2JsZW0gYW5kIGhvdyB0aGlzIHBhdGNoDQo+IGZpeGVzIGl0LCBnaXZlIHNvbWUgZGV0YWls
cyBhYm91dCB3b3JrbG9hZC4gQW5kIGlkZWFsbHksIGFsc28gcHJvdmlkZWQNCj4gdHVyYm9zdGF0
IG91dHB1dCB3aGVuIGl0IHJ1bnMgaW4gcGFyYWxsZWwgd2l0aCB0aGUgd29ya2xvYWQgYmVmb3Jl
IGFuZA0KPiBhZnRlciB0aGlzIHBhdGNoLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4N
Cg0KTG9va2luZyBhdCBvdGhlciBwbGF0Zm9ybXMgaW4gaW50ZWxfaWRsZSwgQy1zdGF0ZSBsYXRl
bmN5IHZhbHVlcyBhcmUNCmdlbmVyYWxseSBzb3VyY2VkIGZyb20gQklPUyBBQ1BJIF9DU1QgY2hh
cmFjdGVyaXphdGlvbiBkYXRhLiBGb3INCmV4YW1wbGUsIE1UTC1MIEM2IChleGl0X2xhdGVuY3k9
MTQwLCB0YXJnZXRfcmVzaWRlbmN5PTQyMCkgYW5kIEFETC1MDQpDNiAoZXhpdF9sYXRlbmN5PTE3
MCwgdGFyZ2V0X3Jlc2lkZW5jeT01MDApIG1hdGNoIHRoZWlyIHJlc3BlY3RpdmUNCkFDUEkgX0NT
VCB0YWJsZXMuDQoNCkZvciBQVEwsIEkgb2JzZXJ2ZWQgYSBkaXNjcmVwYW5jeS4gVGhlIEFDUEkg
X0NTVCBvbiBhIFBhbnRoZXJsYWtlLUwNCmRldmljZSAgcmVwb3J0czoNCg0KICBDNlM6IGxhdGVu
Y3k9MTI3dXMsIHJlc2lkZW5jeT0zODF1cw0KICBDMTA6IGxhdGVuY3k9MTA0OHVzLCByZXNpZGVu
Y3k9MzE0NHVzDQoNCg0KQ291bGQgeW91IGNsYXJpZnkgd2hpY2ggcmVmZXJlbmNlIHdhcyB1c2Vk
IGZvciBvdGhlciBwbGF0Zm9ybXMg4oCUIEFDUEkNCl9DU1Qgb3Igd3VsdCDigJQgc28gd2UgY2Fu
IGFwcGx5IGEgY29uc2lzdGVudCBtZXRob2RvbG9neSBmb3IgUFRMPw0KDQpJIHdpbGwgYWRkIHRo
ZSB0dXJib3N0YXQgZGF0YSBhbmQgd29ya2xvYWQgZGV0YWlscyBhcyByZXF1ZXN0ZWQuDQoNClRo
YW5rcywNCkthdXNobGVuZHJhDQo=
