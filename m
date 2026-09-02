Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023127.outbound.protection.outlook.com [52.101.127.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F541F7F2;
	Wed,  2 Sep 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341884; cv=fail; b=kDxUgIdQSnuQxW7I0W18eOdO+xjxLMO2DpWBAePMTvEEchVp8gfy1NB+1damhYSAThPb1L0qbA70YHeAbERnyL0QrTI/1mQqGtV0h43QvIQGP9neqiC4eE81TcOyVRHdoQ9lOpfts6LdGCJiAbGEBQno8EPOoav0H0vnfaTEh0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341884; c=relaxed/simple;
	bh=Mnf5rl4eaz7qU3SDsLxTMp/OvqocxOQrI/ROEzsAxm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UyPLSjS0T+v+fsW5clpAwP4qHNjlZVaPO6Ui71G44TiS6wk9gGQmbGbH9VTn8Qq6An4n0vjBcm/mVms7BgRpheNuAbxArUQ6/fGiPlKu1zVqelWJj2RhjoguypyIBgrQSXPSzD+SP2E9vKC8H9FLXauVMOKUtBMzIRPFexqF/GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=ZgEYaR3I; arc=fail smtp.client-ip=52.101.127.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="ZgEYaR3I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohwOXmY9AUGiUjcfJ+DuBE64nXL1dBx8XS2oAeVWA2hQk4652mS9743Rl+E1Vvl3IAuw7gg6ZNO/pimHvTFm5Q8J3VsnXa2xlAETzsRM66MGmNDH0QGkqTsCbx5l5n1O23tP9ortfVg1PwU80pFnLesmbNFqCeinKY5Dd4eF8NDWN+P7v8C0gMDtaehdpDaEzTrgXxdZLxEZujN2OK86fPBVPYHl0YwUnYdPbUu5iPkpILoOGeEPpy78Oqfi4pNvfeCP8yv44Nix9y2dTBcATNxaAe0iWzP1zteSJFIgbErLWkFO31nDPIqFNhYs8jsyNWLBoK7NqV2RYKVtg8slZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnf5rl4eaz7qU3SDsLxTMp/OvqocxOQrI/ROEzsAxm0=;
 b=bBbJMklIuFqf598XdM8WX/QEI7UWD7ia01ooCBv8MYqqMUMHcDfIfcse2rOQykLp6iK0iEkU3lvN1geNqt/b1UdU4GCLIVD49otDxWDEIBTWVaXKKK5GOowKbPHHLB0lkqks3I7P409mrIH9TjU1YWT0Br4jdkG+rgTp9AmfSWes0hqqwj60qIJNQhUo+Ivao/Cp4PPOwN8Sza4Igumlknh6dVzjD6S9Y49BkgDvTuS+yBQlRjRswNrO5VcLUauC5oYMkFfu9g851pGlAzZgQozyzMZUfOz2Z0hOQc1DZyxU/Xh6djHG5iaPMheoE/zBrwbIgcZ0IWOU9n2LedH/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnf5rl4eaz7qU3SDsLxTMp/OvqocxOQrI/ROEzsAxm0=;
 b=ZgEYaR3IXWuyZrWezOKIyCuZmJisZjwtcGqFgTKdNrPrGm8R8PjGrea7a1WCOe2IK5nJ7neHBl9gFu6z4xG/3mLFJMCx5KFSDWv77/v6mfLC8k6Za/rCC1llWi5IlE0n1OP9fhItbV7gF1lqVMJMBaCYx95OK8vQVG08/WwVIa4=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KL1PR04MB7123.apcprd04.prod.outlook.com
 (2603:1096:820:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:37:57 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:37:57 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: jong wu <jianyong.wu@outlook.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Topic: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Index: AQHdM3mscPSSkrbdG0OLR3n/gvPslbasjrYAgACdI4CAAZIBgIAMSzIAgAANJAA=
Date: Wed, 2 Sep 2026 09:37:57 +0000
Message-ID: <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
In-Reply-To:
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KL1PR04MB7123:EE_
x-ms-office365-filtering-correlation-id: 5771981d-e44a-469d-50bd-08df08d5df06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 pWwJWEMTkjMHSwO4p2JkhRJORLfzftBubJzVZkdVcEl6w+OOKYbhSaNi1aWpM4nsAu0IporN2nv0AnA2QpeF+z/eFcIn9US3qKI2I5zriAeQclUdm+CP7CXfJ0nIu+oWxlwa7vTr83jD30+4ZJS69wyOzefgRa0/KlMX1XZntB/WwkaLE9pmCRiQtlRnjDbiEsoWiCmSyMLvpvjbgzTg61HBXT3u4hg2eqJf4ktY+6PimvvtVOo4DDx6qhYg06mXt580lG4jobZr/JTw7MhIw6Gh1KxqiuIxSR0K4C1O2twfGMmNyTRzAxy02HN+k04nlbQ1s4cPVYg3R/w+bPSrIoUvFYwsPGyupZqA78TNu4f8R8E36TyGslR6b15FagS5H24LYF8nq+zdJTqJkrp9aai5CJ1p9Ks2c60yWsZI1JQFksuetZiva3cHl5a7sIfCDnPFmeVgSn9MQZsUgt2sT/rKBba/oPubqcPSY1Us8qHVt68TTCqWPadjb4F0otVjQGRke8dQ/euayTrF9Vdub5kP7b/rjESLUAs8A+v3Yt55uu9iBOGoSZUId8dgLT8lWTtdMXG6ARdaCkiQxzD0lRUSPQkv5I5AtanL/7xL/g5sopVMOSdbytVIQ0gAYc5/QlbGRvkoDJxK2V0PWIx7JNZb8YFfmrUZS2ppUMwTAjuVZx/n1p7OFieXXa7Dv/Rg3SEk7YYadUBRf6vUiMCcF9VUwmOaR1cfJ2Z3+2MzSuw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NS8rNEc1VEhYRGRhWHlKN0hJVFMzTzIyVVVkcW9kbWNPQ25zUkRXTWlrekxK?=
 =?utf-8?B?WGRSSTY4SjNGNXF6WE9OdVBSK05ZNDdxcEExQ2w5U1pleFB5akdzdW9HSmJI?=
 =?utf-8?B?UmJvMks3SUZheDVtV3BLdHhadUloYkt4Q2V3dnJveCtkRW11em96MzVOTTFW?=
 =?utf-8?B?WXlXNXhUamFZWUE3bldWemk4RHVBSFFKZTFHUmxUMmpWblJPaytIb0cvK0ZD?=
 =?utf-8?B?VDZ5K0w3Z1RKTGliRXVqY0Z2YTlOVXdvNzRINk5pRFd6NkNPRVZlMmdDL1dn?=
 =?utf-8?B?bVl3SmdOZ0planFxNWhoT3g2TGZmRm51c0lUemxFVWdNa01jR2dLOTJET0tF?=
 =?utf-8?B?Z0V6UnhJMTd3RXloaGphWmxDUjZsVHluUmJrdDRpM2d6azFwQkExc0Y3Z0N6?=
 =?utf-8?B?Z2daeWw5K2xDUUdEMlVGZ3BHNkxoaGtDbCthd3N1WkhEcjl6Z3krcUJYVnVF?=
 =?utf-8?B?a1lTdnkwYzVQNnd1c1BBN25BRitTUUQ0THE3Q1FrZldQaDlkQXlyanM3SjFT?=
 =?utf-8?B?OGVrN2NnZDFoMGhJL0VTRXpvcVpzUTZ3VlhYV1pFemtGVkZmUEpaS1lSMTNU?=
 =?utf-8?B?V3FNc1BjZ3p2TWpNbGFlbStrRGlranZVdmhYTHM1RGJPRFpLZksvREhyUnRR?=
 =?utf-8?B?aUJkbTgzeUt2YzNwZXhMVC9zZ051aWNiRzJQcTFDVCs5QjdTSmpRSStZcm5i?=
 =?utf-8?B?UVBQaVlqS21GMm90cHp0SnVCMnZDMElXbGpWNy9lNVE3U1NzWFQweEFmSUhm?=
 =?utf-8?B?Z2x5QkJVcGF3Z010NXc3VXFGb28yRUJzQzdaOGpxZkN3NzFGQnliRStQUkoy?=
 =?utf-8?B?UUZjQ25uYi9rYWs4WUJoenhtM1JiQVJ0Vk9BNjVZVDh1VmNNWmhHOCtXeXhz?=
 =?utf-8?B?VzV2NGpDejAxMVFKNU5YUElVY3hIZkIzenR3TDZpV1pNSnozK2x0VjVuNWUv?=
 =?utf-8?B?SFAwbkkxcHpLbGtlQUZOSGFLZlg1ZXlQL2Z2R2wyVUZDRjkvMVdEYnpDamNw?=
 =?utf-8?B?a0cyLy9jc2JVMkpOTTZWMU02WVcvWFI4NHVwWFZHbytCazNuT0xLL1JJcExS?=
 =?utf-8?B?WTRKYURGOXFlZWwvU05kMjRpTlVMVktLMWFhbWxDY0x4ZDZxK3dWdzA5MjBP?=
 =?utf-8?B?Wk5wc25GSzRSQWxwN0o1MTd0VUYrYng0WkxzZ0luV21Dc0pkSEJEeXJzNlVP?=
 =?utf-8?B?TTBiTVdZYkV2T0NUb0M2UjI0bTZxWGtNbGw0aGk1MUpxRGhLSWVaeFFhSmI1?=
 =?utf-8?B?ZlduVzEvWVI3YVNNTTQrbXFVdmdpcVlIS1FrdzJNWWFqRDRJSktkUEVvTFBa?=
 =?utf-8?B?SU16REZ6ZmE2VzFqR0EwaTZScUtmTUxVbWpUejJBczNqa09QZ3JURXN6NlIz?=
 =?utf-8?B?bW9lYXFlN2hwNGVQRnpsenF6YlNLU1k2SHk3MUhXSEd0ZUdPT3J1TG9Xc242?=
 =?utf-8?B?NGdCNkVDYkg2YXcwZUo2T0Vzc3o3WCtoNCtFYklSWXVEZjVyaGRxU0pMZ3Uw?=
 =?utf-8?B?MnRYVXFiRzZFQ2padzMwRFV3c215SjVNaHFWVHZKc3c2VGQyN3lhbkZ4Qmti?=
 =?utf-8?B?R2dJRkpEeXdDdnVMVytvL1EzazE1ek9BWCtTTlVSSEZYRWxTd0lDUGVxK2Qx?=
 =?utf-8?B?cWdwbVlqaHZDUjBLcTFSY1N3a3Jxd2tEVkdYUkIvdEx4YjFHbE53U3VMTksy?=
 =?utf-8?B?eXhIZUpJUU14VEhHVjRJaFViL0lxZEpNNkhjQWRFSmpuVWErcnZ1UnkrL2px?=
 =?utf-8?B?YmcxUTk3Q29SYVBjakk3eGwxTEZGYm1yalFVTGVlMjg0S0hRODhzR2R3c2Fl?=
 =?utf-8?B?dmppazBVWlBTbWpTNXdKSHhKemx0VVIxVjduaDE2WC9YYzVqcVF3ZDRRd1lK?=
 =?utf-8?B?NnNQa21mbUxhd3k0SFpRNEx1UUZ5QklLaU1nREJ0dEppeXZXcUJUQWpyUGlQ?=
 =?utf-8?B?eEFHaFdWd3F5ZGxaNmQ5b2gwTHFhK1V6cnpVY2JmN0kwMElIa2FyZnk4ZWFt?=
 =?utf-8?B?cW5kT2k4R0hoa28rcmxtS09hcXF0SUZvQTgvWVM3eitMbkE4ZWpoMk45ZWRF?=
 =?utf-8?B?b2lkTjcwYnk5NlRXdzJXeElXMm15RTNUcFdweUNRUUFUM0V4T2Q2b05vWE5k?=
 =?utf-8?B?V3pqUjNacUxzSmNGdFBsckFZZTJYSG8vOFUrZUpEVGk0YWg0U1gxQ3loMjMx?=
 =?utf-8?B?a2gycjBwM2lkNjBub29UREN0cUNWZTY4Szk3Z0duNlc5dGR3S2N1WnZ4NWVw?=
 =?utf-8?B?bCtEREdtZGFvcEJQek5sTUg5R3pmdXg1ZG9WMERKMUdoWXNoWG5YaEVNUUZC?=
 =?utf-8?B?ajNLZnVTRDRJUkJ0bUZSbE9SblRGMnVBbUszR1pwWmYvK0g5dmp0TWEzWEta?=
 =?utf-8?Q?2MBv7t4oJjXShRwM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3D67F3E4445284FB7E220CBACCF3AB4@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5771981d-e44a-469d-50bd-08df08d5df06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 09:37:57.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYmZwmEsc1L1N0f4KN+Co3oaJDnUaYbFwduVa4WqVSy5K2nO4GCF/ohkVbacE+rLIMvdf/RXdoglZAp21vnrooRnYrKjBeJCsAsvHtMvZjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7123

T24gOS8yLzIwMjYgNDo0OSBQTSwgam9uZyB3dSB3cm90ZToNCj4g5ZyoIDIwMjYvOC8yNSAyMTow
NSwgVmluY2VudCBHdWl0dG90IOWGmemBkzoNCj4+IE9uIE1vbiwgMjQgQXVnIDIwMjYgYXQgMTU6
MDYsIEppYW55b25nIFd1IDxqaWFueW9uZy53dUBvdXRsb29rLmNvbT4gDQo+PiB3cm90ZToNCj4+
Pg0KPj4+IEhpIFZpbmNlbnQsIEhvbmd5YW4sDQo+Pj4NCj4+PiBUaGFua3MgZm9yIHlvdXIgY29t
bWVudHMuDQo+Pj4NCj4+PiBNeSBvcmlnaW5hbCBjb21taXQgbWVzc2FnZSBkaWQgbm90IGNsZWFy
bHkgZGVzY3JpYmUgdGhlIGNvbmNyZXRlIGlzc3VlDQo+Pj4gYmVpbmcgZml4ZWQsIGFuZCBpdHMg
ZXhwbGFuYXRpb24gYmFzZWQgb24gZnJlcXVlbmN5IGludmFyaWFuY2Ugd2FzIG5vdA0KPj4+IGNv
cnJlY3QuIEFmdGVyIGxvb2tpbmcgaW50byB0aGlzIGZ1cnRoZXIsIEkgZm91bmQgdGhhdCB0aGUg
aXNzdWUgSQ0KPj4+IG9ic2VydmVkIGhhcyBhIGRpZmZlcmVudCBjYXVzZTogdGhlIGNwdWluZm8u
bWF4X2ZyZXEgZmFsbGJhY2sgYWRkZWQgYnkNCj4+PiBkMmQ1YzEyOWQwN2UgKCJjcHVmcmVxOiBN
YWtlIGNwdWZyZXFfdXBkYXRlX3ByZXNzdXJlKCkgZmFsbCBiYWNrIHRvDQo+Pj4gY3B1aW5mby5t
YXhfZnJlcSIpLg0KPj4+DQo+Pj4gVGhlIGNvbW1pdCBtZXNzYWdlIHNheXM6DQo+Pj4NCj4+PiDC
oMKgIEhvd2V2ZXIsIGluIHRoZSBhYnNlbmNlIG9mIGFyY2hfc2NhbGVfZnJlcV9yZWYoKSwgaXQg
aXMgcmVhc29uYWJsZQ0KPj4+IMKgwqAgdG8gYXNzdW1lIHRoYXQgY3B1aW5mby5tYXhfZnJlcSBp
cyB0aGUgbWF4aW11bSBzdXN0YWluYWJsZSBmcmVxdWVuY3kNCj4+PiDCoMKgIGZvciB0aGUgZ2l2
ZW4gY3B1ZnJlcSBwb2xpY3kuDQo+Pj4NCj4+PiBUaGF0IGFzc3VtcHRpb24gZG9lcyBub3QgYWx3
YXlzIGhvbGQuDQo+Pj4NCj4+PiBPbiBhbiB4ODYgc2VydmVyIHVzaW5nIGFjcGktY3B1ZnJlcSwg
Y3B1aW5mby5tYXhfZnJlcSBpbmNsdWRlcyB0aGUNCj4+PiBhdXRvbm9tb3VzIGJvb3N0IGZyZXF1
ZW5jeSwgd2hpbGUgcG9saWN5LT5tYXggaXMgcmVzb2x2ZWQgdG8gdGhlDQo+Pj4gaGlnaGVzdCBz
ZWxlY3RhYmxlIF9QU1Mgc3RhdGUuIFdpdGggYm9vc3QgZW5hYmxlZCBhbmQgcG9saWN5LT5tYXgN
Cj4+PiB1bmNoYW5nZWQgYXQgdGhhdCBzdGF0ZSwgdGhlIG1lYXN1cmVkIENQVSBmcmVxdWVuY3kg
Y2FuIHN0aWxsIGV4Y2VlZA0KPj4+IHBvbGljeS0+bWF4LiBUaHVzLCBwb2xpY3ktPm1heCBkb2Vz
IG5vdCByZXByZXNlbnQgYW4gZWZmZWN0aXZlIGhhcmR3YXJlDQo+Pj4gbWF4aW11bS1mcmVxdWVu
Y3kgY2FwIGluIHRoaXMgY2FzZS4NCj4+Pg0KPj4+IE5ldmVydGhlbGVzcywgdGhlIGNwdWluZm8u
bWF4X2ZyZXEgZmFsbGJhY2sgbWFrZXMNCj4+PiBjcHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGNh
bGN1bGF0ZSBwb3NpdGl2ZSBwcmVzc3VyZSBmb3IgZXZlcnkgcG9saWN5LA0KPj4+IGFsdGhvdWdo
IG5vIGVmZmVjdGl2ZSBtYXhpbXVtLWZyZXF1ZW5jeSByZXN0cmljdGlvbiBoYXMgYmVlbiBhcHBs
aWVkLg0KPj4+DQo+Pj4gVGhlIHVuZGVybHlpbmcgaXNzdWUgaXMgdGhhdCBjcHVpbmZvLm1heF9m
cmVxIGlzIHRoZSBtYXhpbXVtIHBvc3NpYmxlDQo+Pj4gb3BlcmF0aW5nIGZyZXF1ZW5jeSBhbmQg
bWF5IGluY2x1ZGUgYW4gYXV0b25vbW91cyBib29zdCBmcmVxdWVuY3ksDQo+Pj4gd2hlcmVhcyBw
b2xpY3ktPm1heCBtYXkgcmVwcmVzZW50IHRoZSBoaWdoZXN0IHNlbGVjdGFibGUgX1BTUyBzdGF0
ZS4NCj4+PiBDb25zZXF1ZW50bHksIHBvbGljeS0+bWF4IDwgY3B1aW5mby5tYXhfZnJlcSBkb2Vz
IG5vdCBuZWNlc3NhcmlseSBtZWFuDQo+Pj4gdGhhdCB0aGUgYXZhaWxhYmxlIENQVSBjYXBhY2l0
eSBoYXMgYmVlbiBjYXBwZWQuDQo+Pg0KPj4gSUlVQywgY3B1aW5mby5tYXhfZnJlcSA9PSBib29z
dCBmcmVxIGFuZCBwb2xpY3ktPm1heCByZWZsZWN0cyB0aGUNCj4+IGNvcnJlY3QgaGlnaGVzdCBm
cmVxdWVuY3kgcmVhY2hhYmxlIGJ5IHRoZSBDUFUgd2hlbiBib29zdCBpcyBkaXNhYmxlZA0KPj4g
c28gdGhlIGNwdWZyZXFfcHJlc3N1cmUgaXMgY29ycmVjdC4gQnV0IHlvdXIgcG9saWN5LT5tYXgg
aXMgbm90DQo+PiB1cGRhdGVkIHdoZW4gYm9vdCBpcyBlbmFibGUgYW5kIGRvZXNuJ3QgcmVmbGVj
dCB0aGUgaGlnaGVzdCBmcmVxDQo+PiByZWFjaGFibGUgYnkgdGhlIENQVS4NCj4+DQo+IA0KPiBF
eGFjdGx5LiBJIHRoaW5rIHRoZSByb290IGNhdXNlIGlzIHRoYXQgcG9saWN5LT5tYXggaGFzIGRp
ZmZlcmVudA0KPiBzZW1hbnRpY3MgYWNyb3NzIGNwdWZyZXEgZHJpdmVycy4gT24gSW50ZWwgYW5k
IG1vc3QgQU1EIG1hY2hpbmVzIGl0IGlzDQo+IHRoZSBtYXhpbXVtIGF0dGFpbmFibGUgZnJlcXVl
bmN5LCBpLmUuIHRoZSBib29zdCBmcmVxdWVuY3kgd2hlbiBib29zdA0KPiBpcyBlbmFibGVkLiBG
b3IgYWNwaS1jcHVmcmVxLCBob3dldmVyLCBwb2xpY3ktPm1heCBpcyByZXNvbHZlZCBmcm9tIHRo
ZQ0KPiBBQ1BJIF9QU1MgdGFibGUsIHdoaWNoIGRvZXMgbm90IGNvbnRhaW4gdGhlIGJvb3N0IGZy
ZXF1ZW5jeS4NCg0KUHJvcGVyIHNvbHV0aW9ucyBhc2lkZSwgSSB2YWd1ZWx5IHJlbWVtYmVyIGlu
dmVzdGlnYXRpbmcgc2NoZWR1bGVyIA0KaXNzdWVzIG9uIGEgUnl6ZW4gNzg0MFUuIFRoYXQgaGFz
IGFjcGktY3B1ZnJlcSB3aXRoIG9ubHkgMyBPUFBzLiBCb29zdCANCmZyZXF1ZW5jaWVzIGFyZSBu
b3QgaW5jbHVkZWQgaW4gdGhvc2UgMyBhbmQgYXJlIG11Y2ggaGlnaGVyIHRoYW4gdGhlIA0KQUNQ
SSBPUFBzLiBJIGNlcnRhaW5seSBtYW5hZ2VkIHRvIGRpc2FibGUgcHN0YXRlIGFuZCBzd2l0Y2hl
ZCB0byANCmFjcGktY3B1ZnJlcSBvbiBpdC4gSSB3b25kZXIgaWYgeW91IGNhbiByZXByb2R1Y2Ug
c3VjaCBpc3N1ZXMgb24gc3VjaCBhIA0KbWFjaGluZS4gTWF5YmUgdGhpcyBpcyBhIGJyb2FkZXIg
aXNzdWUgdGhhbiB3ZSByZWFsaXplLg0KDQo+IFsuLi5dDQo=
