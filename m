Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023143.outbound.protection.outlook.com [52.101.127.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3727281E;
	Wed,  9 Sep 2026 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926992; cv=fail; b=O6JLYz9aO75lGMM4V6Wpr+QLujQAGyMGEFCTnacZFa+RU809Lg7KkKM9wBDAwipCR/O3NBKwtpT/hAIkiTHqcoMm2CQCYHBLUjNNQjnTU8TuMFRom1uC3at/bMvsZGtILTp/BAsTeuclXHN4j4eE9aJ4VTjJBtmECpZ6PGTaL0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926992; c=relaxed/simple;
	bh=ghIqFlWg05TD9lbO8b+g28rBnO4FrU8XAyDf1tAVCf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQjM27zhO9Hr4bVx4QmBEcz8VDfwQTKnCFatAUOjaI+cY6ryFQucvwNV5qt/tftLTXsJxfalZNlYYD7kV5RJMT+yPUWyY0w3GhmvmFJV2fNjOLgHKJR6k7LDXD6qbOZ/ELqiQjaehgxjxvTsyjAYY6UzTXHE1miatC0SQ+8W/l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=rV57pFuX; arc=fail smtp.client-ip=52.101.127.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="rV57pFuX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZkiBPXAOSdOjABHewmUHTOXqAZqwqef3nOoZAecLHjda3LrzYOQY0QLbTm14WFhoN8+UzTQDCNKyjrTGU6vsUB/fFvN4Dg2n4UQOlX2HME0oHsTHgjigUuW/K05UHSazfyAbploHGQOCdyany1FAdTAhYZpd/hQ2Nx4JL+o0Kw5OePI+FCaMHy0MYQcjE6ErYy0VIabyTxuU93CGwHuTN5gYuWJVY3v91/95g1kGtzuwWgdHDnjxKRZrcVg3Paj0Pi6B00iS98pXdLj92Duh/+eJRd2cxszDcsyUfOlKy/MFJjz8KQLTxv9cGo+Uwa8PyHTrHYlum6XmnkydfOFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghIqFlWg05TD9lbO8b+g28rBnO4FrU8XAyDf1tAVCf4=;
 b=JDzmzZCBwdgLoQa23Chzyu4BlyDgZFGnYLIRP2MF1dxaR4sToih9G45Ne68Sl7izDd0f1gx5h5BEq8oHqTxwGdTJqYTLpi6Jii2SZrgbfnFhaN6GFYx4JtPR/6hrFTgCutvAqi+eGMVY052y+Q3rkE/W8eull2QXgeq+sp3FouKqBTczV8FTSH94OaPBbzz3xHcH8/YTBva9LRSKsU1Kyc7PfUBKLOqHGnGsP7uhD9+beLS5GVL8z+ekRcvvr1EkV5ICRamG9rqyeSHXeoIls7/QdYWIvh2C+vmvwXAoOjCwx6+F/OWIFB+uNYYTWs4Po92lfvsb+D5reFe11qVLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghIqFlWg05TD9lbO8b+g28rBnO4FrU8XAyDf1tAVCf4=;
 b=rV57pFuXCkz9srX8j5yPb68HhzVL4LqtOoGPvOwgwxhzazSCS2Crpq7ZCZHrhCEoUFrNaeivEofPhnTlFD7PFFhHGUi4+Sr54cSvVkLIOSzn2zFcyGWgglkYGhlDWItVrUByIfcGv85DnWpDziyGCF1LIEhMER/yxBb5JV2jQxs=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by JH0PR04MB7203.apcprd04.prod.outlook.com
 (2603:1096:990:36::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:09:47 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:09:47 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, jong wu
	<jianyong.wu@outlook.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>, Vincent Guittot
	<vincent.guittot@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Topic: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Index:
 AQHdM3mscPSSkrbdG0OLR3n/gvPslbasjrYAgACdI4CAAZIBgIAMSzIAgAANJACAARPYgIAGUTyAgABdtYCAAAhCAIAC2eoA
Date: Wed, 9 Sep 2026 04:09:46 +0000
Message-ID: <a9dc111b-21cb-4bcb-ac91-f6be04bc2e06@transsion.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
 <d709498b-9572-44bd-a93e-bbed23fd7372@amd.com>
 <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
In-Reply-To: <4e39e935-2339-442b-8b14-a688b605c35e@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|JH0PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: adbfa37b-a221-4cc9-ace3-08df0e282f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info:
 ZFoTrK+SxNAlvf1oUyZ7COOpR3qjZ5fWpcSvlNqnYrr+KNa2IRk6HvD8wbP8LwyuGKzduqnPN5Id1HxDBqYfp+LVPeLjCQ2xiJ1LbrCCTIXhhdU0kCTknkiUVKSw24wyNyX50sAqj1SrlTwMU9cTX4Gx/NyriYr/MEPivFzlkWU5iSi5uqPoRQ0f53HvJ4Ec1GUTvKRhLxXOikAu1FwoDYA/HxGwV7EJeDqp//VAHxKZpO+hKHarc/PkKbkvcTw9cVG6C0O9G3ePdh+lwx/aVsb5HimoTgPsW86N478l6QiakS6JPMshEv/74fU5RGeiD4LvDZ56Fsyycy7zuNincty+2la5K2FTWNiGh6u0ZRwYrfgAw7Il9aqBQyn54Rl+X2aPPALyIauk9dFrhn1Wmli9GskujD8vv4GnpWlqULmmGeLQLqiSUso/XUZAZqhOeVwXPziC44cW/k59R1raawi1tuVWP75pFjTzotDFrr2Id2uuflo1ZjAGPEQ4HQRLW6XK3No9/+AKQ7sm2Cbka1lWGml7A3/LvdgNkU7rr+pS/uFKSRRNnkljcQ4dW+hoRddx5cSoVZZnnYdHT08K00rZRn3Hwyulvk2Gvi+56dUvET1uL8W/2FVJ1XmvIohv7qsKnQnDxgQhM+uOE2zr6LwSYFRY8fXqT3I9ASDN/5ppSdID399BNRdH2fT3oUHfInmdUSuHn2uj9gVHHe1FArVpUAGYGbeQFyHFFkm9mq0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHRJVHd2cUQ2dDVMVmhGd1U4aFFCaGVrYjFBOEZLeWxOTENxWEVidnloVllD?=
 =?utf-8?B?elBDdGZ5TjlWbnd4WVh4ZCt6QjNraVVTUVR1bWhsSGN5dW9CRUdBcmVlaWp5?=
 =?utf-8?B?VDY5QkRRTmdCTTlyaTRvQlBlS3RLdlBSRDBMK0p2cENzbUlaRDR4MWJqVm5m?=
 =?utf-8?B?SWNsOWZUQ01OYktjRG9rOXNxaEFQU2RXekZrMFV1RW5nODhqU05kamxrd0JC?=
 =?utf-8?B?SXR5UUJCQWYvSEZ3M05YbzJtak1udTRHMGIrY253NzFsRnF3NU9KM2VaY0N3?=
 =?utf-8?B?N2hPVEIyT2xRd3RBVlRtdFdvU3Q4enpibW1xL1dXbGtsRWFDcFNJZUV3elpa?=
 =?utf-8?B?VktLNmFzZDVDNnFHOVloM1hISGFHSzd3eUhpbTNxMWFkbGZkTVhmQlQrRmxa?=
 =?utf-8?B?Nm1qZWJoUzlYc3NmOEwwZTFoNUJveUszK3ArTk5yMS94eDhRTlBSYWd2MUNa?=
 =?utf-8?B?OFF3cjJoRVEyREIvNFliM01vNFdkUUZZaEo0Sk8yMWRMemJnQ1JBRHhIdHpE?=
 =?utf-8?B?bEdDendSWm92VkFlNjBWYTdDOFNsSTJSRUNCOWdtUFdXOWM4d1F2c0twNWR6?=
 =?utf-8?B?T21pYWphM2QyVmJ6SzVHNjJYZXpqdDNxckpmOE9lUVFPZFd3Wml3dEZrcnVW?=
 =?utf-8?B?UkNTQ2h3K1RtY2lOa2h3c1QrRTZaVjZBem14T25mTU1TTHBRMW0zQ1ZFY21v?=
 =?utf-8?B?T0c2YkRKZGV2Mk1zK3BtVm1ld2gwMFZBS2tXVndVVFhKNk8xaGgrQjB6R0Jk?=
 =?utf-8?B?VWNVaXlsZFdmelBRSXJRSGJnd09LY3htR1JtRTVxTUtvU1Awbng0ZmJicTN4?=
 =?utf-8?B?Y0Jkakk4VTNZbitJcVBzdmhnZSs0d2hYVk9pSjVKcU9mU1NCRzhzZlhtK2ZS?=
 =?utf-8?B?aFM3YVMyQ3N6c0pXNnNZdmM1OXhHMTA2bm1mWHdhajdobWszZmt4Mnp2NWU4?=
 =?utf-8?B?dUpaOS9qMUlkdlUxdW8wZ0xnZGZ4S2hoR3E3bzRybWlFVy90Y2V3aVNQVGdi?=
 =?utf-8?B?aXBvOEpjTnNUdFhOaWhjZi9VYVByeStsb3ZqVGZDWXdNUDk2S1FlUDgxVmNG?=
 =?utf-8?B?NTNoZzFubG5qSjNSd0hlbUlZZHA4Q2NWODM1V2NLdnR2NGdFT3ViWHg0bitW?=
 =?utf-8?B?aEl4ZFpUbXBTM2VZSGt5MFE2ZTVCN0lWbGVmVVArMG44czkwN3F6WmxrNHBp?=
 =?utf-8?B?LzJKV1hyNGFXdHJHOVh5ZWlxcjZpZ3FRckRtTUVJRXVDTDBJNzE0M2psb2FI?=
 =?utf-8?B?eWRXWDNKaHNKUzBNMGlZU0pXS3U5N2pxWk9Gc1Q3bTRHMDdjc09EaEFmOENN?=
 =?utf-8?B?d242aG9MVTNDQjNRU2tYaFFxWndzT1A1Y095bUo1OXBwVVU5RElsbTJpYWlI?=
 =?utf-8?B?MXVLejhWRTYvZHNXTE9FcGQyd252cmx1aUhJbjlDTlg4dDh1S2hVNXVON1E5?=
 =?utf-8?B?dm9HMDBPYjdJNkdqcFRzeXI1OHhZZ0pPYnNNR0pmR0dSMzdZOVZzM3U5VHUx?=
 =?utf-8?B?OVBFQXZ6Y0xzanN1YjZMZ2pNWisxNUVZbWtUVjlacmQ4eStnRmo1WVhBWFdp?=
 =?utf-8?B?b3hjNGtMdi9nUjZzK05ocWFIY0thb1hDUHQ0ZXI0dzJCUE5CQVp6NGVhNk00?=
 =?utf-8?B?eHZIbG1HS2NXNXR5OG9jTHdKZEtCYkMrTEtlREE2bUhsd2NSbkxXUHVXUVg3?=
 =?utf-8?B?eU5Ud2xYZUo5alB2MmpQNjRCaVg1VElJZmkrQVdsU3Jmc1NoTGlKSWNoeDV6?=
 =?utf-8?B?U0VWKzkvS1NwMG1JS0hmQTVObWdSU24rMmhqdSsxNklzeEVFK1VOYXRvbnVh?=
 =?utf-8?B?UVAreU03TE5JVkg4WmhoMVFmR3pZWTcwRDlxMUllVHdFRklvdCtHdTVRNTJQ?=
 =?utf-8?B?V0lKdjR0ZDdoaXlWQ0Z5aDRTTDhIa25haFIyb2haSlR5dmluY3dGRURGRmpj?=
 =?utf-8?B?RjRZblF3anhzeEt2M2p1eGdqSjdnSC9OQVRUNjZrQVYyTS9uSk1YZnNqc3VE?=
 =?utf-8?B?MDB3OXZDWE1JU2UrdmNDNmxYUXgyQXFPVFd2Ukx2WWlmK1Q2dTRjN1V1TkdL?=
 =?utf-8?B?NkQyTlluRTlkMW0wdk00SzM4V0svd3Z4a0g5V05xTDV4cWZHU25zUWxPUm5z?=
 =?utf-8?B?OGc5TjRrZVJHVnVFMkh3T3A1bEdhT2J1QUhsdFZvRDVycFFLdzJNZFhJTXo1?=
 =?utf-8?B?Smw5UXlWVW96djYra0ZnWk8zV1BRQmFWTGI1UW0vWWt4SVlHa0V4b3MyYVF4?=
 =?utf-8?B?eXU4Rk5iQUtINTl5eEpoaGQ5MS9pWTZGdGRQSkQ5ekQyVTBDdzhFQml5ODdF?=
 =?utf-8?B?QzkvY0VhRkZHRmRJMDVSaWZveGM4aUxyZ1ZMemduNjFQM0JoN0ZXS1gxM2Iz?=
 =?utf-8?Q?opwYk4AFDkcKwo4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE3CAC9407347247A16D4436DC9F98D4@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbfa37b-a221-4cc9-ace3-08df0e282f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 04:09:46.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILN14TNBSDyJbT29s53W4DvyCefcZYcbscLMG+EMJJtwx9fCt67or8+f+NkGJ/rlYQGcmGFU1VwSwVfjrF6Iz0yedg/otJ8Zis2Ywrbl00s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7203

T24gOS83LzIwMjYgNDozNyBQTSwgSyBQcmF0ZWVrIE5heWFrIHdyb3RlOg0KPiBPbiA5LzcvMjAy
NiAxOjM3IFBNLCBLIFByYXRlZWsgTmF5YWsgd3JvdGU6DQo+PiBTbywgSSd2ZSBiZWVuIHRyeWlu
ZyB0byB1bmRlcnN0YW5kIHRoZXNlIGJpdHMgYW5kIGxvb2tpbmcgYXQNCj4+IGNwdWZyZXFfcG9s
aWN5X2luaXRfcW9zKCksIHRoZSAicG9saWN5LT5jcHVpbmZvLm1heF9mcmVxIiBzaG91bGQgYmUg
dGhlDQo+PiBmcmVxdWVuY3kgaW5jbHVkaW5nIHRoZSBib29zdCByYW5nZSBidXQgSSBzZWUgY3B1
ZnJlcV91cGRhdGVfcHJlc3N1cmUoKQ0KPj4gYW5kIGl0IHNheXM6DQo+Pg0KPj4gICAgICBtYXhf
ZnJlcSA9IGFyY2hfc2NhbGVfZnJlcV9yZWYoY3B1KTsNCj4+ICAgICAgaWYgKCFtYXhfZnJlcSkN
Cj4+ICAgICAgICAgIG1heF9mcmVxID0gcG9saWN5LT5jcHVpbmZvLm1heF9mcmVxOw0KPj4NCj4+
ICAgICAgY2FwcGVkX2ZyZXEgPSBwb2xpY3ktPm1heDsNCj4+DQo+PiAgICAgIC8qDQo+PiAgICAg
ICAqIEhhbmRsZSBwcm9wZXJseSB0aGUgYm9vc3QgZnJlcXVlbmNpZXMsIHdoaWNoIHNob3VsZCBz
aW1wbHkgY2xlYW4NCj4+ICAgICAgICogdGhlIGNwdWZyZXEgcHJlc3N1cmUgdmFsdWUuDQo+PiAg
ICAgICAqLw0KPj4gICAgICBpZiAobWF4X2ZyZXEgPD0gY2FwcGVkX2ZyZXEpIHsNCj4+ICAgICAg
ICAgIC4uLg0KPj4gICAgICB9DQo+Pg0KPj4NCj4+IExvb2tpbmcgYXQgdGhpcywgSSBmZWVsICJw
b2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEiIHNob3VsZCBub3QgaW5jbHVkZQ0KPj4gdGhlIGJvb3N0
IGZyZXF1ZW5jeSwgb3IgeDg2IHNob3VsZCBpbXBsZW1lbnQgYSBhcmNoX3NjYWxlX2ZyZXFfcmVm
KCkNCj4+IHRvIGtub3cgd2hlbiBib29zdCBpcyBlbmFibGVkIHZzIGRpc2FibGVkLg0KPj4NCj4+
IElmIGNwdWZyZXFfdXBkYXRlX3ByZXNzdXJlKCkgaW5kZWVkIGhhcyB0byBkaXNyZWdhcmQgYm9v
c3QgZnJlcXVlbmN5LA0KPj4gYW5kIGFueXRoaW5nIGFib3ZlIFAwIGlzIG5vdCBjb25zaWRlcmVk
IGFzIHByZXNzdXJlLCB3ZSBjYW4gc2ltcGx5DQo+PiBkbzoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMNCj4+
IGluZGV4IGI4OThiNjU0NDA2OS4uMDY4ZTZkNmUxNWExIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9jcHVmcmVxL2NwdWZyZXEuYw0KPj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0K
Pj4gQEAgLTI1ODYsOCArMjU4NiwxMSBAQCBzdGF0aWMgdm9pZCBjcHVmcmVxX3VwZGF0ZV9wcmVz
c3VyZShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCj4+ICAgDQo+PiAgIAljcHUgPSBj
cHVtYXNrX2ZpcnN0KHBvbGljeS0+cmVsYXRlZF9jcHVzKTsNCj4+ICAgCW1heF9mcmVxID0gYXJj
aF9zY2FsZV9mcmVxX3JlZihjcHUpOw0KPj4gLQlpZiAoIW1heF9mcmVxKQ0KPj4gLQkJbWF4X2Zy
ZXEgPSBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7DQo+PiArCWlmICghbWF4X2ZyZXEpIHsNCj4+
ICsJCW1heF9mcmVxID0gX19yZXNvbHZlX2ZyZXEocG9saWN5LCBwb2xpY3ktPmNwdWluZm8ubWF4
X2ZyZXEsDQo+PiArCQkJCQkgIHBvbGljeS0+bWF4LCBwb2xpY3ktPm1pbiwNCj4gDQo+IE15IGJh
ZCwgdGhhdCBzaG91bGQgaGF2ZSBiZWVuIG90aGVyIHdheSBhcm91bmQgYW5kIHVzZSB0aGUgY3B1
aW5mbw0KPiBmaWVsZHMgdG8gcHJldmVudCBjYXBwaW5nIGJhc2VkIG9uIHBvbGljeSBsaW1pdHMu
IFVwZGF0ZWQgZGlmZjoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJl
cS5jIGIvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0KPiBpbmRleCBiODk4YjY1NDQwNjkuLjk3
ZjRhM2JhNTEwNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYw0KPiAr
KysgYi9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jDQo+IEBAIC0yNTg2LDggKzI1ODYsMTEgQEAg
c3RhdGljIHZvaWQgY3B1ZnJlcV91cGRhdGVfcHJlc3N1cmUoc3RydWN0IGNwdWZyZXFfcG9saWN5
ICpwb2xpY3kpDQo+ICAgDQo+ICAgCWNwdSA9IGNwdW1hc2tfZmlyc3QocG9saWN5LT5yZWxhdGVk
X2NwdXMpOw0KPiAgIAltYXhfZnJlcSA9IGFyY2hfc2NhbGVfZnJlcV9yZWYoY3B1KTsNCj4gLQlp
ZiAoIW1heF9mcmVxKQ0KPiAtCQltYXhfZnJlcSA9IHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcTsN
Cj4gKwlpZiAoIW1heF9mcmVxKSB7DQo+ICsJCW1heF9mcmVxID0gX19yZXNvbHZlX2ZyZXEocG9s
aWN5LCBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEsDQo+ICsJCQkJCSAgcG9saWN5LT5jcHVpbmZv
Lm1pbl9mcmVxLCBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEsDQo+ICsJCQkJCSAgQ1BVRlJFUV9S
RUxBVElPTl9IKTsNCj4gKwl9DQo+ICAgDQo+ICAgCWNhcHBlZF9mcmVxID0gcG9saWN5LT5tYXg7
DQo+ICAgDQoNCkxHVE0uDQoNCk5JVDogSSBkbyB3b25kZXIgaWYgd2UgbmVlZCBhIGZ1bGwgX19y
ZXNvbHZlX2ZyZXEoKSBlYWNoIHRpbWUuIFdlIGNvdWxkIA0KY2FjaGUgdGhlIGhpZ2hlc3QgYWNo
aWV2YWJsZSBPUFAgb24gbWF4X2ZyZXEgdXBkYXRlcywgYnV0IHRoYXQncyBmdXR1cmUgDQpvcHRp
bWl6YXRpb24uDQoNCj4gLS0tDQo+IFsuLi5dDQo=
