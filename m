Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865E30569F
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625286; cv=fail; b=GUa7PuBiQwdMHc/lQGzs9y8u1glMStDlRH1iKYL5+Baque7BW80noyoOV4CsPuPbsocCI4vQfAHItBOQjN/n63nEsO3bYB+zch+89iXtMG7y+KkdOeQlJablkQXfAyAeEXo0BUhqwONI20kOaIgqrp213qqdLBkaqIa6bC0nPsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625286; c=relaxed/simple;
	bh=pNjoxYkyQGe1G7od0KOth2K1i04vsD4g8D3GHzwjCws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MI13sUvhyEjaJWJjs2C4B4dWCyy5+N8JFmJbExNbz+R1Ud5lNGL1Uq1DEVwHb0DwpuucYIcAhrmU/dKu2eblkcQkpZUXdVjV8R1U0k+QIBv55at3P8muQngWqT/KM32nXlzqiau3Xa3Ec7EtyKOFVVDnkj/2HXK8cXUi7QsuPo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wc0ENlLZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wc0ENlLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786625285; x=1818161285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pNjoxYkyQGe1G7od0KOth2K1i04vsD4g8D3GHzwjCws=;
  b=Wc0ENlLZAl87gN6EgwJ0+jgbcF7xgY+LikLXxABX6cKTefzvprmj3i/s
   FtQMPZZW8Z32nfNfRXCXXevYvoJ0xm4BXTMUA3Rkd0ApYIzNcvzWMxq+g
   mkP34naY8+sAAVgXWYUVQfnvav69Tya9VnykYX8y49Lm4NC4XrSDkTrew
   yulSuyl31ijyTeBuGIIgwdDcaAzD9q9SP0pT2tzhvh3195FBITdWss6Cq
   TpZGjRmA2xb87ewyxzQkqGLWkkMj3BRUnyVXzemGz2zhkxRMr3sJ9lnuF
   PEqtShniltgxLA5+7mQiKej70tv1ZtFsKAcNXziKBSJ3l/C7CBkBVqwvJ
   A==;
X-CSE-ConnectionGUID: IncfWN4WROS1Xrk3YOoSOA==
X-CSE-MsgGUID: P8xACHCYQouh2g0xMVUdDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86158458"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="86158458"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:48:04 -0700
X-CSE-ConnectionGUID: p8HPMWbHQUW0m2kChn9rkA==
X-CSE-MsgGUID: 1MxBLz6/Rrujb7YVW/tBrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="264515554"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:48:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:48:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 05:48:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPZqpiUujFE0VoV16Pl9CsiiHfyTYP+TX82zYFYpCLgngopiKGIK8CLzDTEtSfSKGV2DMuKy6dofy24TOVbgM/VJt1UqnT4bHtvq89c7/Cc79kJ1ZS1IjYsjYGsfF1Snnd6mHahvQk4EZHkzFoYfgGmnOKLTWxFvmhb0LlF6jHm4AlWOaDKcYvf/p5IQtRAXpo6p2siIyVMwQ7/D5m6zeH0KtcelXgHI4/yggin/fk/NFJ6SRqSmGW+ZuL/lVG/in1hztyfkxZjAj3o1DQKboa/CWUHa1DEjLc+TQ5xC89vZ+x6iEnfVPul5QIljSArXU38hUdbReT2XHYuiMFf/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNjoxYkyQGe1G7od0KOth2K1i04vsD4g8D3GHzwjCws=;
 b=hUWXd4+0F9oN8gC5UqAmpC4NnyYHd8VkdNoAWhwarYalc6OCeIwATXiyWzLruDV8rWY9I3t30oSAIrQF757ZCN2UWgbUbB2wow9NILIoC4RLS2bMf8dlPJJ2mQp8pTTcdlsnJM/SxtS7DbH9xsDMMhPNzfM7KMWh2VBqP9IRlcVGBn9nTo+oEmmfZNUfg9+k1I3I/z2zHP9iqwF7ohzCpgWcAqBHkEJzkTkknpnh/AELI+d5y//POuAMCXdE5W+xI1u53r+8OFTK8k5J0MxBMpJLAvohjMXNi7Hnegde1ChgH+BYl7MqYhppKOnG9BdyHsHi8e4wjEhWXuJTw2PDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 12:48:01 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:48:01 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
Thread-Topic: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
Thread-Index: AQHdKWp0L4olIup+1kiOPKMzhChPqbaYnzAAgAAHyLCAAHMIAIAC0/BQ
Date: Thu, 13 Aug 2026 12:48:01 +0000
Message-ID: <LV3PR11MB8768D2570DBFB916C237F3BAF5DB2@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
	 <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
	 <LV3PR11MB87680CA8F9B3172110B7EBD0F5DD2@LV3PR11MB8768.namprd11.prod.outlook.com>
 <8cdc18896a03d13ebea065ab27991a71e460069b.camel@gmail.com>
In-Reply-To: <8cdc18896a03d13ebea065ab27991a71e460069b.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|IA1PR11MB7941:EE_
x-ms-office365-filtering-correlation-id: f8b5c96e-ce2d-44bb-0de0-08def9391bfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|38070700021|22082099003|56012099006|10067099003|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 5S1s6ITAGDzvBg0mTRPKEYlI9WTPhCXQANfT8URFgajMmWETwkj3mCNlOBvGoe8sEM/ObblaNKbYhTSslX+bViaQ1BiJEuzuecuHoymxoZJ0lJV7YP9eIO3pM9Qlrrt8eQ/HPmtgj3W+me07N+kCHFhyWtnXpWYHu2Ac2mDpuwAEai7BnL+zD44aexL/nZdxpoHuQ5XCXzPUpJeVI8n0E+BhCLtETf9VcXzrCaydRi2L2F1D262ywqOeZBCNwVIp//FjJ4yEKgHPdxyQmJcqAOt9yB53Ipv3d5gcBKMoBvQWovn3JZmtC4BL7vQOQ1tJzA4B9iFpBwohaRwPItWTCDDT9Dk0vpa702hC+SqHB+U/yJCDwXr5w6aay6TLmtXL3XFW9GAxVPGsueEl4aFRa0lkTQPnXj9zZuFOOKUQ2csYX0W3n3kyiJxjsPVU6M5OASekG2VrW8R+5gHEVw3mgOjddhxfQFOoIn8zj2JnF0z0D+wUTO7VMbasjRGluK/DpMbEqCNt86c7ZSJNz3uvOyzAZNiI99sUbuwyOJbpbHySWNDFht9YySOm2T+rV/uHZv6ZN6+BOh65pYpxyjw0gEQ0E4cX75nzrbLeUj8x50x550/T4C7NRbmbWhN5P44kM1e6wnB1j5k0aSY4YfJ2T5RuihlW9yC7SA70VLqcn/4z+VUk9l2iWV07yseLAiETSuOl3d7zMnx07c3WIHcWDgn2dHzjO3BQrjM86ZgbQ2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(38070700021)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bERNMjhydXVoeW5UemNsVVVvTXBRQmFwR0liQ3V0R2o4SWd1K3M5NitYbG9h?=
 =?utf-8?B?d0hFN0J5alVnVUdKbFlncEdRd2hJTWw1UDdzYTA4VUFVNlRqdVVicWcxS0Fh?=
 =?utf-8?B?c2piaElEdkNNTEovQlBxQWoxVnRBS0w4UTZkeS8rWGVtbnBueE9mMmFObE5V?=
 =?utf-8?B?RHVjT3FYemdjQXZvVUtrZktGd05iWTcyVWVpcFp0SkFGM09yT0U5b2oyWlp2?=
 =?utf-8?B?QU8rUGVtNnBEZm5ORTYrNytxL0hqbEttS3JUNmkwa3hVNUVuL29UMTF5UDM0?=
 =?utf-8?B?b09hN2JSVXh1aG5DellvVEkvVWlHRzk5bGFjNyt3R1F6R2tKams5VGVGajhD?=
 =?utf-8?B?eEZSK0crWGNmSFlDV28rTCs3U3hMNHNjVStDTjRiOUE1N01ycWExQzZHd1Fy?=
 =?utf-8?B?V09Lb0RBZ0Z0cVM5WkZGcDBtSUM2c25mbmlRV2YyRVdHanF6R05RQ0t3akpK?=
 =?utf-8?B?b3N5WUMwS25GNUczUzIyMXdtTVFPRnBKMzZzV0xGMDJqSXFRNGtiTnFDZjRr?=
 =?utf-8?B?YjFJSVVSMC9HOWFmQm5BdWlOSXhPVW1uQmVZSHhUTUh1UmpHNjl3NE53TStE?=
 =?utf-8?B?a2ZFNXQrd051THFJUlNkTk8vZXZVRHA2SUIvTDRRRjYreHI2QXYwV1QwaWJD?=
 =?utf-8?B?QkZGWnNTZndjd0U3WUc1MUJYbnFqbC9iOW9FV1J1N0dCaHJQT0VMVTJEeEdF?=
 =?utf-8?B?NHRNbG8vbXZGbDVhQlc5YTRIU3gwbGJiUVVEanlJK1M0YXN4cGFDY1U4cWVE?=
 =?utf-8?B?ZExvbityRlJ3UGtTaUV5a05oMWN4V1VMVDlMR1laSisxNXZsSng3S3JPY3Z5?=
 =?utf-8?B?VnVlTjV2UTUrQzB1dmxEaDZuSnZrWnduakJWS2Q3OVk1WDJBTWRWVmt6L1hM?=
 =?utf-8?B?V2RyUk1ObXVNZTJVMUVPTzdGNnpLcXpNSXpqaE94K2QrcXVOdHRCdHlQTzQv?=
 =?utf-8?B?UHVmYXphSFNCVzRwVkN5d0ZodzJvMjM2TnYyclBtTjFNeXVTN3FoaWN0L2NY?=
 =?utf-8?B?NE1NWnRPU1B3NUNrZ2x4OC9PcnB4d0p1dk5ZRk90bXhRUXNxTHRVZC96VVUw?=
 =?utf-8?B?MmxxVHMyODNIZ3NvOW9SY3JLbXd2SUE2MmVrQnRHWUFjRlBVMS9jaWF3Q01v?=
 =?utf-8?B?T0RGQW5pcWxaN25aclYyTWlMNHRIMENabUhFb1k0RDZ4K0lIbzJUMUdYNE45?=
 =?utf-8?B?RUwrQ0Fxcmp6TFZkZTZsZzUvVUpPWDFOV2xscTV5S0pGTExCL3FVZUNGUEg2?=
 =?utf-8?B?WU5RcmpZVlZicGNBTU0reC9NK1dHeDdsamxmcnpITlZUUjVmVG9uSS9takto?=
 =?utf-8?B?SENaTW0yejRsR1VEOWtITTI3OU4xUFFUQTc2cUh6RXJaUW5GaUdZMDA4RUVz?=
 =?utf-8?B?WHBrWkFJNkZxRDZuN1BQQ1k2YUhSRGI0K3luSXlUUUs5dzVWSG8vR0svbWJl?=
 =?utf-8?B?RkZYL1ozVmVKdXpyOXdrcnlMVEhUd3NDbGprRTd1bXZPaWpiRnVzaXVrNnBJ?=
 =?utf-8?B?elNYQ1NlU0VRb2hLN3NyczJuTVhHMzBvRnZqRnRESzhiYnFZcmNsZ2hHVmEz?=
 =?utf-8?B?d3BoRmhGSmg0YWFzdis3VWtWbTA3aHJvM3VTY1YrZnBZSFZMNmtuZlMyK3Iz?=
 =?utf-8?B?NGxteDMxdkJ1dzEzdWhmOWUwQ0FRdlU1SHJkOEQ5N2YxRkwzQmRiZHJJWDAx?=
 =?utf-8?B?SEU1UDJKekxhNDdjUTlJMWI3R0ViUWFHNUZQUmF1OXh6aURSV1JMUXNYcHEz?=
 =?utf-8?B?a25wY3RBR0FTUkovM1YzQ1oreHlNMW5hVzdVbnBZdVlPSGN0UUxHSTFKcDhH?=
 =?utf-8?B?NUlhakwraW9VZEJqUjlBdTFSdU1IbU11cE8rZUxCeUpmOEU3MVcrYmhxYlgx?=
 =?utf-8?B?b2lJRDNuK25UeS9yeDQvWStZbTBzN0J2WFBZbmdGNDB0cHBVejRXRlVZOHRE?=
 =?utf-8?B?QW0zaHRZWVJXaUcvSWVKWUlrQ3AvWmU2eWFYMVNIbGxielVDU2RmdEgxcU1N?=
 =?utf-8?B?OWJXSmxSVFcrTnNwRDhkUUlSZXFhR1V1QkZIdkFiUS9yN1AwWkhjTmFIb2Qr?=
 =?utf-8?B?MGZhazBKbDJUMjB3QWs5elhmZkYvOVNyWk9Vd0VacFZOVVl1VzdNYWVyRkcv?=
 =?utf-8?B?R2lQRjJwU0s1QlEyZWdrQVYzdkF3L01XWUswbWRQekY3ZzhFK0R5OE9qbmVi?=
 =?utf-8?B?M2RDUW9WR1BuVkl0ZXp5cHQrMkVpMlVWcG1wRUdEVUJKKzNhQ1ZiNmt4SVFJ?=
 =?utf-8?B?Wlp4SnNFQi9QczAxREF0Q3ZLNDJRQnRRRW1QcEFEeTN0Z2dpaWRMb3BIcm0z?=
 =?utf-8?B?UDZ1LzJnM1Rkdmt3RC9IUTN2UzlKNHFscmhOVjRrbm5DeFpHUTRWSk96M1pB?=
 =?utf-8?Q?DIEj4RY2bHXHqiUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aEtsfN9Lg0GaZof5/cJG34fc4sHrbJ7snvNoank9NXX6nIHgw3ScCZuHiMicC4qQ6+O+28IFocYnAgKJw7OKGY7UVezE8GyHYN7EbK6d/dm0COxo3Z3KVoyvGtQIH0FEFGUsMAg3H/BRFsFLm0q5y5Wk79WWOAvfBYWoJo+kisvwMaPDfAe8NCFJpKxsvxZwEn+K7Ik/okLZFa+FtiJSUGtSU9cl+5JuyrdpkdfL3RIC7TjAbHKb8hM/NpPi6peFi9whD+wrZtevAFWHRDvV73R4ud2qIs/4V+R7ksJhKCC6DXOCjadErdIDhHEjVwXjXNh+L4P74JgSRlZKbwDwWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b5c96e-ce2d-44bb-0de0-08def9391bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:48:01.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kR/er/SeRrwYNmgiFCfqPNCakBMu48gTXiYvtafbcV3hjdyhkD8sE/TPDW1AkAlUd0nCRKQLl32hGuN8wOL6xefH/lQ2JRDz02Zo+VZFb4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEzIGF0IDEwOjAwICswMDAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBQbGF0Zm9ybXMgdGhhdCBkbyBub3QgaGF2ZSBpbnRlbF9pZGxlIGN1c3RvbSB0YWJsZSwg
dXNlIGxhdGVuY3kgZnJvbQ0KPiBBQ1BJIF9DU1QgdGFibGUuIEl0IG9ubHkgcHJvdmlkZXMgbGF0
ZW5jeS4gVGFyZ2V0IHJlc2lkZW5jeSBpcw0KPiBjYWxjdWxhdGVkIGFzIDN4IGxhdGVuY3kuDQo+
DQo+IEkgZG8gbm90IGtub3cgYWJvdXQgX0NTVCBudW1iZXJzLiBJIG9ubHkga25vdyB0aGF0IGlu
IG1hbnkgY2FzZXMgdGhleQ0KPiBhcmUgbm90IHdoYXQgSSBjYW4gb2JzZXJ2ZSB1c2luZyB3dWx0
IHRvb2wuDQo+DQo+IFBhbnRoZXIgTGFrZSBpcyB0aGUgb25seSBjbGllbnQgcGxhdGZvcm0gdGhh
dCBJIG1lYXN1cmVkIHdpdGggdGhlDQo+IHRvb2xzIEkgZGV2ZWxvcGVkLCBhbmQgc3VibWl0dGVk
IHRoZSBudW1iZXJzIGJhc2VkIG9uIHd1bHQgYW5kIHBiZQ0KPiBkYXRhIHRoYXQgSSBnb3QuDQoN
ClRoYW5rIHlvdSBmb3IgdGhlIGNsYXJpZmljYXRpb24sIEFydGVtLg0KDQpCZWxvdyBpcyB0dXJi
b3N0YXQgZGF0YSBmcm9tIGEgMTAtbWludXRlIGlkbGUgcnVuIG9uIFBhbnRoZXJsYWtlLUwgDQp3
aXRoIHRoZSBjdXJyZW50IHZhbHVlcyBhbmQgd2l0aCB0aGUgcHJvcG9zZWQgdmFsdWVzOg0KDQog
IE1ldHJpYyAgICAgIEJhc2UgICAgd2l0aCBQYXRjaA0KICAtLS0tLS0tLSAgLS0tLS0tLS0gIC0t
LS0tLS0NCiAgQzZTJSAgICAgICAgICAwLjI5ICAgICAwLjYwDQogIEMxMCUgICAgICAgICA5OS4z
NCAgICA5OS4wMA0KICBQa2clcGM2ICAgODcuODQgICAgODkuNDgNCg0KQzZTIHVzYWdlIGRvdWJs
ZXMgYW5kIHBhY2thZ2UgaWRsZSBpbXByb3ZlcyB3aXRoIHRoZSBwcm9wb3NlZCB2YWx1ZXMuDQpD
MTAgcmVtYWlucyBkb21pbmFudCBmb3IgbG9uZyBpZGxlIHBlcmlvZHMg4oCUIG5vIHJlZ3Jlc3Np
b24uDQoNCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHJlLXJ1biB0aGUgd3VsdC9wYmUgbWVhc3Vy
ZW1lbnRzIG9uIFBUTD8NCiAgDQpCUiwNCkthdXNobGVuZHJhDQo=
