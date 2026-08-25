Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022077.outbound.protection.outlook.com [40.107.75.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03050383329;
	Tue, 25 Aug 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643659; cv=fail; b=LSGxw71Q0ZNkht0IWPhHnesnLvMMxBfCLkZw0uNjkax9LwDQw9ev8Q25MqrOaSTeZgFSeTHXcQCQgTHb0iNP+fJIelhHrPrILfMQ1pPHzTI5T7yvoJpJOHQqw7V1K142aIhKeebzk8H0cSLnH0VyYqCH9xvtKUho9GNE6xg7Ylg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643659; c=relaxed/simple;
	bh=4aGBRQLiDYxT/mtqnJMwLeyOdwZepWRO3zJtjJZgv2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qsv9yK8ql1zuAa12PobSuW4HhlZ0c0FOF4xLIFxDFrE94bJM0Fl1yBGFnI1qqTrkCzthRDtPm2Is0ctC1Kt+8iXr2dkV9KCkMHHdcFCpoEGkxhay90Ejshl2f0HzyFXCuuaI5UkbpKEcLjuVtkNYg1rVt0AO5IQoylTfAAo9MjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=kXnkqPw5; arc=fail smtp.client-ip=40.107.75.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="kXnkqPw5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjnUoyUVe8NZp9a4taXcO5J1x0FMnAz4IWXFVN2f2xwMwLM81oVbawK7laXtr/QNribPQ0kcQBukqYQ5hwQWovP9D0y8RZp0EA9xThr667YP8Dsnz2a+DCi3TXEUhDvdGi0EkMaYfre9M6PJaKtBlSkvcRqnicjKeJV/P2lnSLdAe1nEtRhXKFDwJn7RZ6L48QBhfh5TuPmqpIQvb1iuSIS2jleBrhMFcSlvRBEok0IRj6VwPSOaRBoiOYIIe3+887x9mJTJLe0JYA0WX1d9TC3LvOW9owo0vL/jnWhWx4hQh83vuqRS6T4dN31VWJaU8AW4Kz8kIrG0yffSZdk8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aGBRQLiDYxT/mtqnJMwLeyOdwZepWRO3zJtjJZgv2M=;
 b=IyhZJBSIvloHUcf4oTV/D5oamWi8cBlghMWUnVgdtZiZj+daxR0XtwnlQ/Kkua6LKPkSiKqeAj7zh3yMUGUCXoL2GlEvfbo7DZo2UbNOdAXq3lLjsGQuu0J1WpUvLoMfBcN9YdEwKaz3gy4wc5HCI/TdBqYC5vMopzOadAa9CAffWeRivE1F00IgDBK82aMx0vy0PTNAx5Dg3bMs65xbij01V05w7N24eaNCOiVAN4dSIR/RQoBB7xRzMTC/q1z/YY0w69DKhIHG81zlmbY45ZJdQXDUTZB4xpbMfCuoBpg9Pcjxy/Qhc1JI1/hfNVJ3aTZZY6oZho703FEJ/bbJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aGBRQLiDYxT/mtqnJMwLeyOdwZepWRO3zJtjJZgv2M=;
 b=kXnkqPw56Ba5fx00266QG9c3aDao6lHKFVVZaVEM6NPLDU/SSjmyl8ljTR4V8K5Q6BrIwWT+A3K4wxJsoK3ur8JLCN73QyEGZYJFQrqOnrybZaaI2O2hVQwMSqZpKQQCH0Xb1wqBcNh6jF+6fEdRBB8VOmWilYcPrioCI2QzTb8=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KUZPR04MB9099.apcprd04.prod.outlook.com
 (2603:1096:d10:59::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 07:40:54 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 07:40:54 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Jianyong Wu <jianyong.wu@outlook.com>, Vincent Guittot
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
Thread-Index: AQHdM3mscPSSkrbdG0OLR3n/gvPslbasjrYAgACdI4CAATcZgA==
Date: Tue, 25 Aug 2026 07:40:54 +0000
Message-ID: <49233994-f46f-4d41-99b3-b40cc23bcbc7@transsion.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
In-Reply-To: <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KUZPR04MB9099:EE_
x-ms-office365-filtering-correlation-id: 630dbfeb-7921-4c9f-6552-08df027c319e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|56012099006|11063799006|5023799004|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5QIP1BnTXREe/76ZzAKS2GPlf37Tp7WmZS26DOfsYQUfVoBCqbbzvibpSpS26+lFRMG2AG/Ameks/yQuWpU8WWb7tJO725OgqQeljj1eVLRjutRUaYWDd4ltibNpCKyA+L+2qAAVRTYlpYDWehi3yJFhaYMgyPVIWg3z5s3yWIG5guh4BVQfwNMC2RyS5OhvpEc/M9kdEurI6VEGwAvxd/6bW4RaLozQTn4wCMJYsZHGVpNjG+c8umwtHNSneexMj5D02hmtnKYJseaphDYcGyKgougGv36sj+Ca1WR2HVI2vL9fue/u+NNx8g7UNTLGd8Xki+1nZah8CUoUFwtwDQWUa37rwkK2k/k2hdNnXLx4qgzUlmYpFgcWUrOhM+z3FwPRzBY2eiQYPpuGVYPVUlyeZ/Xoq+8p8vTRhKUvdDxc/22YkbiEkw3yp897j5DFXbR2krZJPy8ecRudweD8QpBXF+1b1dgwXbxVh6L+EXJZpN1EH2XDMTxDKJ095PqU10rBD0StTAsc4W12G2hMCtF/lsAMkq6vfWGvoWzZJXwOmqtuV/0tqyMveDUU0iyNVjxJ7hxMSkl/vk8ed1BJsT/mUaMHg8vGWoSCaxbVBfpYRGSHYhwvlS2IAtVMfqqxTXjYS14Mi4oeiy2GXqIqmgfJ2D7w9CaMtWpP4a03saUqUwZbswfIhsI1QOQ+mhoR88I42eRm82pzOV8xQ0ljddI/Qp4aWkEumJ9OH4KXF/Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aE41U3hNZVAvMkJJa1ZTR3pFamY0UkdNV3ZhV2VITXNqYW5BUFhLQnVIcXpt?=
 =?utf-8?B?MFh2RHQyMTJkSGlLSUppOUt3SUprdlpkV2RLSU9rS0NBNXFoelBTd3lWVFZz?=
 =?utf-8?B?SEoyU0pOaE1TRzExUFFhN2Z5VWtsd2JsbVJhVldhN2Vnb3BMK28wVDRDVHFH?=
 =?utf-8?B?S0E5V3VHMGtNM0RKbjBrNXFFeVh1QUp5dVowaENDUkdxWGp5ODVVVVo4S1Vr?=
 =?utf-8?B?WjVPWFJGV0hRYmFXQXVzRjUrVnE2d1ptTlNob2d0blhiQmZMVURKSXRuaUlh?=
 =?utf-8?B?RmJaRGVsL1dobERxNVFSTXNVbjZ5aVJnb0RYc29MNXlJbWF6TTNmNVFWZ0Ni?=
 =?utf-8?B?LzJyRnRGUTRqY2xEL1hxZFpSbEdSTnlXSTVFWFJ4bitTTml1b3o5RGpCaVBL?=
 =?utf-8?B?Wm5sL2l0MXhKOUl5NEV3VHA4blJ4QWR1anJHSy90WGJnZXNZSW1yaU5hMmpo?=
 =?utf-8?B?d0ttQmJ5MTArMHVwcERCdVU2bzVBZ0QyRG9BYVBQbVpxWVhrN1Jud0xuYTBD?=
 =?utf-8?B?bjJPLzY4RTVPaDR6eE1MSGFWejdIYUhRSktIcGg3aXpqRFcrdSttdDRXYVpa?=
 =?utf-8?B?OHVGcytJcUEvQytmZFk3QXJoVFJRMGthRHdEWGE5SFRaTjdCT3BKczdFRXZZ?=
 =?utf-8?B?K29meWViallUcjZoUU05dHVVSnBoTldKOUI1RXVuaFRVVXFiYnZPbWJkQnRj?=
 =?utf-8?B?ZFVMZlFEazVGN3VaT3VKTjVneUVJaVZiVVExbGh1dGVpTEFoR00rUkZQSVZi?=
 =?utf-8?B?QXdMenMzTk1nbnF0Rm8wMUVTZ3dINE1ZalY3M3dyU29ReWJYZ3FnNWdsV3ZY?=
 =?utf-8?B?aldkUUJLUFp4bEp4M0R4S2Jxc0Q5cElpQ0U0bTI4c2RvQzIveEhobTlYUmJE?=
 =?utf-8?B?MDdkZ29kQzBsYy9XWkFFVm5jaVAvZE1YMEprS1lKLzB2ZGMzQmNYaFY4RTZ0?=
 =?utf-8?B?b2xlVjlXZlV5VzV4QVJHdmhLNm9CdkcwUndJdlFyTUpvQUxVNUN5Sm9pVUZU?=
 =?utf-8?B?bm56YTY2Y1QvM0xTSkVHK29QbkpUYkY3SFJJeitiZWtDaHB3TlJwanJjSFIz?=
 =?utf-8?B?T1pwQlA5MlhYd29vZmVUMmhHYkpvWXRQNi9YSmZYV29mYUJrMjFtTzJpZjQ3?=
 =?utf-8?B?d1pSNzRBZ2ovYUVlNDhFa0lLVE9IT1B0cmg2U3F1ZnNHclpmOGQ1UnZncHJ5?=
 =?utf-8?B?QmFNODhHQURXckdLZTd3SC84N2ZkQ0NHWGt1bmk3VzMzZEI1cGpNclN2WXlq?=
 =?utf-8?B?TTgxNDJYM0RxeXJUM2Jlalk2cWZOWkZFR2c3bDdjK1dYZ2NoYzlFT1NhOC9y?=
 =?utf-8?B?Qm9nWm14emRSWDBqZHhrUGc3Mkg1ZW1SS1Q5ZFd5S3NNZTV5S3F2VTNmaXdB?=
 =?utf-8?B?VVM1dFczRDVLVlZJeXJBS0k5Zit4dUVZL3M2YXZtenNvUVk0cnJqUnBkYmty?=
 =?utf-8?B?YksrUi9UQXMrcGo3ZmI2eGFDVWs1eEhDQldXNEUvSXFxZmFyeDZweFY4MytE?=
 =?utf-8?B?TEQ3U1ZWQkZYMUU5STlwY2ttR0l5OXB4TS8rZ29jVGc3VVROWE9odlNWdWo2?=
 =?utf-8?B?Wm5KT1cyYWRQbUNSMnh5S0VJaTg3bXg5Q2tSL3I3djFEdlExTnVhNG41UGdF?=
 =?utf-8?B?TnJiSkIzR3hOVFFoOElpT0s0S2VIek1rNE1DRmVPSzNGa3kyRFFCODNXT0xu?=
 =?utf-8?B?YmF3ODgwbjFZaTlyOEtjRnhnd1VBTmM0Mi96MlNta0sxelpINVdzaFU2aFk1?=
 =?utf-8?B?cHdhaHBwSysvaGhqb05DaHZVRlU4M2tuZkZ3VWpybHg2WnU5UExtOVdncE45?=
 =?utf-8?B?S0l2SGVFTXlSbzNCcG9abDV1WXFiRWtUMW05RitkLzdOMi8vUjV4VFA5Snll?=
 =?utf-8?B?NWw4dVJWZ3pObE1aQzdiMEU1aDc2eTV2QXpzSWlkNmVwUDVaTC81TU9OU0Rx?=
 =?utf-8?B?WU9YZ1hiYzJZK2V2VEgxdzd3aUY0SEtCdThCUHpaMkNySnp1MTROTHhUUmZC?=
 =?utf-8?B?TnhQUDlqU0RBOGt1eVFjY1g0bUltaDdnRjhiNWpBWWYrQzZ6VUpHZ0tZeVVI?=
 =?utf-8?B?bzVhajR6WCs5QU96L3p3eTdKN21Pak1sZ1IyNHJaQ0gybFF0MzVyOWZ6ZmJM?=
 =?utf-8?B?eWlzSENVeGE4SHJOYW1ZRmVaQ1IvOG1GVnFTMzNvSlQ4WUluY3dRbzljNS9B?=
 =?utf-8?B?UVBLRTV1cVlBR1RjdHZ0cE5lWG9WbVdxcm8zZEhFNXI1M1Q2bWtpdnJaWkJi?=
 =?utf-8?B?bmdqdEJPWkx5T1FuM3ZhTklvUExJNEx1WjFxM2trVG12amhjRDdCZ3l6RjFD?=
 =?utf-8?B?K3lNNFJaVW5yN2NOOEVDNUc5RFBNODZJZ1E5TzNLL0syLzZWRjJ6UHAyZkM2?=
 =?utf-8?Q?NznTj5I1fr+gOyhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57F67C6AC722C4C99C05CB11959AB03@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 630dbfeb-7921-4c9f-6552-08df027c319e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 07:40:54.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXwqrmY9vajaip/C45lYWJwE/6k93wwrOVpj2IJBYe7vRctSz7rucltsxR7ydtZYk8rs9wU7pnbkx5INScq2nDp8jqXrnT9dx5xi6Es8wms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB9099

T24gOC8yNC8yMDI2IDk6MDYgUE0sIEppYW55b25nIFd1IHdyb3RlOg0KPiBIaSBWaW5jZW50LCBI
b25neWFuLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiANCj4gTXkgb3JpZ2lu
YWwgY29tbWl0IG1lc3NhZ2UgZGlkIG5vdCBjbGVhcmx5IGRlc2NyaWJlIHRoZSBjb25jcmV0ZSBp
c3N1ZQ0KPiBiZWluZyBmaXhlZCwgYW5kIGl0cyBleHBsYW5hdGlvbiBiYXNlZCBvbiBmcmVxdWVu
Y3kgaW52YXJpYW5jZSB3YXMgbm90DQo+IGNvcnJlY3QuIEFmdGVyIGxvb2tpbmcgaW50byB0aGlz
IGZ1cnRoZXIsIEkgZm91bmQgdGhhdCB0aGUgaXNzdWUgSQ0KPiBvYnNlcnZlZCBoYXMgYSBkaWZm
ZXJlbnQgY2F1c2U6IHRoZSBjcHVpbmZvLm1heF9mcmVxIGZhbGxiYWNrIGFkZGVkIGJ5DQo+IGQy
ZDVjMTI5ZDA3ZSAoImNwdWZyZXE6IE1ha2UgY3B1ZnJlcV91cGRhdGVfcHJlc3N1cmUoKSBmYWxs
IGJhY2sgdG8NCj4gY3B1aW5mby5tYXhfZnJlcSIpLg0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdl
IHNheXM6DQo+IA0KPiAgICBIb3dldmVyLCBpbiB0aGUgYWJzZW5jZSBvZiBhcmNoX3NjYWxlX2Zy
ZXFfcmVmKCksIGl0IGlzIHJlYXNvbmFibGUNCj4gICAgdG8gYXNzdW1lIHRoYXQgY3B1aW5mby5t
YXhfZnJlcSBpcyB0aGUgbWF4aW11bSBzdXN0YWluYWJsZSBmcmVxdWVuY3kNCj4gICAgZm9yIHRo
ZSBnaXZlbiBjcHVmcmVxIHBvbGljeS4NCj4gDQo+IFRoYXQgYXNzdW1wdGlvbiBkb2VzIG5vdCBh
bHdheXMgaG9sZC4NCj4gDQo+IE9uIGFuIHg4NiBzZXJ2ZXIgdXNpbmcgYWNwaS1jcHVmcmVxLCBj
cHVpbmZvLm1heF9mcmVxIGluY2x1ZGVzIHRoZQ0KPiBhdXRvbm9tb3VzIGJvb3N0IGZyZXF1ZW5j
eSwgd2hpbGUgcG9saWN5LT5tYXggaXMgcmVzb2x2ZWQgdG8gdGhlDQo+IGhpZ2hlc3Qgc2VsZWN0
YWJsZSBfUFNTIHN0YXRlLiBXaXRoIGJvb3N0IGVuYWJsZWQgYW5kIHBvbGljeS0+bWF4DQo+IHVu
Y2hhbmdlZCBhdCB0aGF0IHN0YXRlLCB0aGUgbWVhc3VyZWQgQ1BVIGZyZXF1ZW5jeSBjYW4gc3Rp
bGwgZXhjZWVkDQo+IHBvbGljeS0+bWF4LiBUaHVzLCBwb2xpY3ktPm1heCBkb2VzIG5vdCByZXBy
ZXNlbnQgYW4gZWZmZWN0aXZlIGhhcmR3YXJlDQo+IG1heGltdW0tZnJlcXVlbmN5IGNhcCBpbiB0
aGlzIGNhc2UuDQo+IA0KPiBOZXZlcnRoZWxlc3MsIHRoZSBjcHVpbmZvLm1heF9mcmVxIGZhbGxi
YWNrIG1ha2VzDQo+IGNwdWZyZXFfdXBkYXRlX3ByZXNzdXJlKCkgY2FsY3VsYXRlIHBvc2l0aXZl
IHByZXNzdXJlIGZvciBldmVyeSBwb2xpY3ksDQo+IGFsdGhvdWdoIG5vIGVmZmVjdGl2ZSBtYXhp
bXVtLWZyZXF1ZW5jeSByZXN0cmljdGlvbiBoYXMgYmVlbiBhcHBsaWVkLg0KPiANCj4gVGhlIHVu
ZGVybHlpbmcgaXNzdWUgaXMgdGhhdCBjcHVpbmZvLm1heF9mcmVxIGlzIHRoZSBtYXhpbXVtIHBv
c3NpYmxlDQo+IG9wZXJhdGluZyBmcmVxdWVuY3kgYW5kIG1heSBpbmNsdWRlIGFuIGF1dG9ub21v
dXMgYm9vc3QgZnJlcXVlbmN5LA0KPiB3aGVyZWFzIHBvbGljeS0+bWF4IG1heSByZXByZXNlbnQg
dGhlIGhpZ2hlc3Qgc2VsZWN0YWJsZSBfUFNTIHN0YXRlLg0KPiBDb25zZXF1ZW50bHksIHBvbGlj
eS0+bWF4IDwgY3B1aW5mby5tYXhfZnJlcSBkb2VzIG5vdCBuZWNlc3NhcmlseSBtZWFuDQo+IHRo
YXQgdGhlIGF2YWlsYWJsZSBDUFUgY2FwYWNpdHkgaGFzIGJlZW4gY2FwcGVkLg0KPiANCj4gDQo+
IFRoZXJlZm9yZSwgdGhpcyBwYXRjaCBjaGVja3MgdGhlIHdyb25nIGNvbmRpdGlvbiBhbmQgaXMg
bm90IHRoZSByaWdodCBmaXguIEkgd2lsbCBkcm9wIGl0Lg0KPiANCj4gSW5zdGVhZCwgSSBhbSBp
bnZlc3RpZ2F0aW5nIGEgZml4IGZvciB0aGUgcmVmZXJlbmNlLWZyZXF1ZW5jeSBmYWxsYmFjaw0K
PiBpbiB0aGUgY3B1ZnJlcSBzdWJzeXN0ZW0uIE9uZSBwb3NzaWJsZSBhcHByb2FjaCBpcyB0byB1
c2UgdGhlIGhpZ2hlc3QNCj4gbm9uLWJvb3N0IGZyZXF1ZW5jeS10YWJsZSBlbnRyeSB3aGVuIGFy
Y2hfc2NhbGVfZnJlcV9yZWYoKSBpcw0KPiB1bmF2YWlsYWJsZSwgYW5kIG9ubHkgZmFsbCBiYWNr
IHRvIGNwdWluZm8ubWF4X2ZyZXEgZm9yIGRyaXZlcnMgd2l0aG91dA0KPiBzdWNoIGFuIGVudHJ5
Lg0KDQpJIHNlZS4gU28gYmFzaWNhbGx5IG9uIHlvdXIgc3lzdGVtLCBjcHVpbmZvLm1heF9mcmVx
IGluY2x1ZGVzIGJvb3N0IA0KZnJlcXVlbmNpZXMgd2hlcmVhcyBwb2xpY3ktPm1heCBkb2Vzbid0
LCBzbyB0aGUgcG9saWN5LT5tYXggPCANCmNwdWluZm8ubWF4X2ZyZXEgYXJpdGhtZXRpYyBjb21w
YXJpc29uIGdpdmVzIHlvdSAncHJlc3N1cmUnIGV2ZW4gd2l0aG91dCANCmFueSBhY3R1YWwgcHJl
c3N1cmUgaW4geW91ciBzeXN0ZW0uIFlvdSBtaWdodCB3YW50IHRvIHJlLXBocmFzZSB0aGUgDQpw
cm9ibGVtIGJldHRlciBhcyBpdCB0b29rIG1lIHF1aXRlIGEgd2hpbGUgdG8gdW5kZXJzdGFuZCBp
dC4NCg0KU28gdGhpcyBpcyBub3QgZnJlcXVlbmN5LWludmFyaWFuY2UtcmVsYXRlZC4gVGhpcyBi
YXNpY2FsbHkgYm9pbHMgZG93biANCnRvIHRoZSBkZWZpbml0aW9uIG9mIGRpZmZlcmVudCBwb2xp
Y3ktPmZpZWxkcywgd2hpY2ggbWlnaHQgYmUgYmV0dGVyIA0KY29tbWVudGVkIGJ5IHBlb3BsZSB3
b3JraW5nIG9mdGVuIHdpdGggYm9vc3QgZnJlcXVlbmNpZXMuDQoNCj4gRG9lcyB0aGF0IGFwcHJv
YWNoIHNvdW5kIHJlYXNvbmFibGU/DQo+IA0KPiBUaGFua3MNCj4gSmlhbnlvbmcNCg0K
