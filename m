Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022116.outbound.protection.outlook.com [40.107.75.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AADF76;
	Mon, 24 Aug 2026 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543062; cv=fail; b=UprS9+gMojshAVr5jzY//h4tIwU0SuLSGHl4iDYz3I8cWss6b5OGQUeuezbvOd476r/yIDDU2nDEZnZQAfL7VGk4fA1g5OBleTxKO03IXnJ+N4OPYjt666lx1y9vLfKIE77N0q9LTrIrdvvZBgoIMS8m3lAtqMwwBYrXsh4yIRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543062; c=relaxed/simple;
	bh=DgflyNDHzfdYicEEzJlOh6ruZvRq3OVPPs0YkJA1VSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=plBJ76iRqqHmwkpVB0yTmDhsLI8rCMmm6QXxr7W0bI+Z9gO4xp3EMdCdFlrjc3WE8SdeprAzqo4Wdv5L9QN22aXCeGw0OINFtVbdPQxH6oV+B8fb/070CtawZIpPTEycjmcjmiOPbfxo/LvYFnVpcM5VEreds9rCjKlYtuK3V7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=lfWIwgCL; arc=fail smtp.client-ip=40.107.75.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="lfWIwgCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lje0A8EtdaUIUwFmyC33pch3TnULSq4psELbU5b4mtyIlg5jsqob1/Nk27ru0kWMaA2hmpqtaHfhZQc29tnISSlgKBK9vKNHcQP9YWwKjioj4p0vCd7VgSHfjgc1LGftU5vY19bxP/eVZfVitb/tLZgbnxA+PB7O3Co8Z15n6/GzzOpql5yGI0yKDHyjv4rvsst3TYNczXX13afhriftM64T+NpWq2BwQ7j+imoY/O9aTEqxQPYrOxLDRsSgwKRN+vm8aKiuxms2el2VEcmGxG35bHxw+B9Gfz4+4cUaNfEyZACZwbXQy/VO50Ry3hapiXPfDmyp+DQBUhKTiS0tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgflyNDHzfdYicEEzJlOh6ruZvRq3OVPPs0YkJA1VSs=;
 b=HCPiZ/fD5kPJ3uuU7379srhRCxfkYFuEMBnTFBMq7DZxuCoyaCgSXB3taoQ76URLXsvIidNkFUv/s6b0druQpGOmkdVPhhwltbb2INd9YWzjz9qERdDbNV3/ssh/gmk9lbPuAUtltC+NyLyRwSMQ868PVxpoO1gmj5bmK8GHdckZrg+j5FuMVgb1ah2ezoYfiRm39O8Qd9pNfapCCFw0N/CjdLd7HGuMh438gcrENWkFQW25z0DPGHdZPnGJ3JPDC/TBopmWrDa0r6pRHTKulRCk67Uw/7OYHxgmL6u6zDSeMr2UDm6o9QqaR0X5fOy7BNCFi5YRjsTJxRxoppMdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgflyNDHzfdYicEEzJlOh6ruZvRq3OVPPs0YkJA1VSs=;
 b=lfWIwgCLxIXtYk3bsrbwUpBiCKWv2Q0CKqWIWw7Q65PPLxZzCZqvw+9zxRwnNd6hC6f+GEOGzPwpNlsKpdi4QlPq7nMxL5cqBJ1ef7bTWkWP/O/TAq/dt1yhXVebBbFkJqVsxcprg7wOu+p0zUG0wOzmv/eNv3TY+guj293Od7Q=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by OS8PR04MB8280.apcprd04.prod.outlook.com
 (2603:1096:604:2a5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 03:44:15 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 03:44:15 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Jianyong Wu <wujianyong@hygon.cn>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianyong.wu@outlook.com"
	<jianyong.wu@outlook.com>, "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
	"huangsj@hygon.cn" <huangsj@hygon.cn>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Topic: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Index: AQHdM3mscPSSkrbdG0OLR3n/gvPslbasjrYA
Date: Mon, 24 Aug 2026 03:44:14 +0000
Message-ID: <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
In-Reply-To: <20260821073927.455475-1-wujianyong@hygon.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|OS8PR04MB8280:EE_
x-ms-office365-filtering-correlation-id: f629be79-f8ba-4d52-89a8-08df0191f7dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 NPgnDZd1hhCOuUPJO3Yf6p5zYz0nUvb33QJv9nNAJUaYAGwTpkIbpL2W798dp5il2gD7YuZ1etMmcyEtMPwqRwGT3YryqN4JNp92gypC0vVTLhJ3LXKYVISLIY/DYH0We11jrwC/zvQ2kWIqKBeeXL+NcpOwSdo8y0f9PLxih1HBF+pKO8bfd3URnXdQdNDx+nysmcd5Sz1zUBe3qzSdhQamo5798ESCZ0aM+KkwK3eOhSlVZK9YfWICZAOvAKWs1R+p14AQXggxJZG/UvgLMUkpz/tjf6FvJEDFWk4COayU3l3WfaDqx4laUgAg59Zv0kuvM3XmCkWmmDwWA8uHGVGZrqYqjOYCKskT3qinpEBpiiy/DAu3fUuVLqYkqfDypNvw+VNgQvcFjiXsKHG0MbDO5O/pPkgCoP9yEVsaG7ZXnHAeBtyapp9JCtei2eaJBMp5uFZTde+Cin1TWe1RcKYtQTDvGlHfc0+gBzDptQTvvhpyOrQyCrB4iQ0dCqzWB/jQfSR/oGCFZYo6u9/aA33a9G6tiTFUw64fSV3Yy2OBcugfNgTloDJHnOdz6vVP2i/pNitB4oU75MrkzyJi4P30XYFbelfTMZG0mvSWqzxh5wpYZLA3TjQo+2kUHmoqlVguJaIDU6wwfRHeVgPvqABYWsk1KQcvJaIEtG631vP5RlQ9gbzocDCz6EBHg6oY58EjyIkbdt/Do/waB/SgjnoohQl3hpYBboXSNrJxvek=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUxxWUlGS3RadmF1SG55aTRFSGhvYWtaQzNSV3doTG84TnJsWlNZU1dTZlp2?=
 =?utf-8?B?V0JCYkRHVkxWY2xQRUlpclFpL0hsU0RFbTFyUENDRzdrNFdiZ0IzYU9BSUJV?=
 =?utf-8?B?WjdjYW9xbi9VZCtFekd0Y2NRUXhxUWRiVldkeStQOVVPYlllUTlQaWVsZWkr?=
 =?utf-8?B?bWZKZElucjRkb0tIbS9CZS8rbnRpZzZQWTc0ZlJ5dHFiSkUxZ05XWmo4WUVE?=
 =?utf-8?B?dHRrTkcwR2pkOUJBZXI4ZVMxd2tzQ05SVmhmM01ERFhTcTZjWVd5K2dEYVpP?=
 =?utf-8?B?U25kWjZXV2s4QUljL0ptSzlieWxvMnA0SGlNNmFEeWowOUM4a3RDWDl3RG1n?=
 =?utf-8?B?cGdCbjFMQmx6UHpURnpxdGtPT2pTK1c5NjdIMkQ3bENmNUMvVVBoQnQrNXZ6?=
 =?utf-8?B?VFNZREFVRnhnVDFsNmNYSVY3NkZVazFhTk13SENpYm11ZU0yTkpNcUxwUytV?=
 =?utf-8?B?ZUlZOGkwdTlSUUNqNWdYbVJWTUM1RWh6YmhOSHpxcHFwNVFaRmVkMTRPVm5m?=
 =?utf-8?B?SGl1NVo3MmtNeUdGWG9JWTlxS05STEFkZG5QdkZqZDZCOThValUwOVc2TkVP?=
 =?utf-8?B?K0dLaUE2eWJ0VEFzQmVLdkgwUzU2T293RXhRdFF4M3BYTVB6dVh6alJSUmRM?=
 =?utf-8?B?REFxaHBBVHdxNldubDZWZUs0YTVwaUxBSjRzNTJCbGlqRDZLZ1YwNUxrZWx6?=
 =?utf-8?B?TXFZMUN5ZElOSjRQVUNyaFhrWXNrTzArTWxzYjkyMElYdXJBUGhpejNyL2hu?=
 =?utf-8?B?U0toOVI0RWNqU3RiaG8vMnhPdlg2Yldtb1BZWjFpNHlnQ21UMkF0bXRWM0ZM?=
 =?utf-8?B?UGF3Z3pId1NYWWJMeDRldnJDdXdSYi9wWGhyRHdJNkU5WGl3NC9kQnNMMTJO?=
 =?utf-8?B?ZHB2bFNqUWJ3UkNVM0dJcWVoVHRnazZDUDVHMWpYUzFCMWM5ZjVLOEN0ZVkx?=
 =?utf-8?B?WVYwVmgxeHM2TThoOG5ldGNKRlVLQVF0N2ZQVlZMVnhMQ2Voc0tJdHRIS1l4?=
 =?utf-8?B?V2pXR2JENWtWZ3Exc3dlK3VKMm9ZRTZYbzVCRU5lSTFRM1dRR0EvRGxGbTRw?=
 =?utf-8?B?Q0pFZHNPY0ZWNWNYQmt0Q3ZnNTJXblV4Vi9CZWloSG5KcTNHWWhWcks5T0NV?=
 =?utf-8?B?VW5tMzBqNlgvaFhOdHRBWDdkTUljR3NpTVBzTlBHSDJDNHAzVnBhclJDdGg0?=
 =?utf-8?B?Mkp5YnFqOUpGZ3QxQlVRK2xaZHJwWHIydS9xQTA5NjNGdG4rakJjN2NRVzJw?=
 =?utf-8?B?Lzc0Mm9uajgvb1MrbUFzaDFVV2FvWWZBQnR3R3Q2d09ucTZENTkzSmN4ejdE?=
 =?utf-8?B?YzlKT2NGbFpoWUFHVmMvWC9NY2ttSmZIT0t6SHdVMHRVak5mSlR1VmhzMCtY?=
 =?utf-8?B?MXBPL05NdVRLV1A0OGdKT0VGUXRzRjJMZGlkVFFha3RQT3BGV01ZdlVmdTc0?=
 =?utf-8?B?WlhncTlxcXhVYStwcmNTOVdURFh0aTI5YVhHYmNhRk03U1RhU2U1ZnlmVWRy?=
 =?utf-8?B?dUoxVnFFalFBb3RzRnNBS0xtWEJGRFlRMzR5NHpsMnNUYWV5SVF1SE8za3l3?=
 =?utf-8?B?MFpSa2RzNUp3M1k4MC8zamh2dU5lTHd3a0VGUUU2Q0dZdk5yUGxVY3BzeUNT?=
 =?utf-8?B?RG85cHBxTjVkNlNNMlBwcURleEorVjZWaDd5SzNWRVpiZEViTTVFSUtlU05y?=
 =?utf-8?B?OWNtY1Q2d2docU9rSnRjb3BqeUpPcWs5QUhnUDNPbmVUOEhpZTVBd2ZIUU5J?=
 =?utf-8?B?b2FQODBsdkcrc29GME1PQ3IxSXoxNWFraXdaNXdUNEl2a255dW9ISGhPUlh5?=
 =?utf-8?B?VFJKWGJvd1h5dDY2bmJtOE5uZTBXWGZvUWpDeVh6RmRRcDVqT0JhZmZmQTBL?=
 =?utf-8?B?Um51Njhlb0psdVNDZEp1QmhxbWtBVk5laFRJUFAxRGxmRkNNSERBcWtRaTNo?=
 =?utf-8?B?ZGIxaW5McUx2MkNzYTJBbkEyTWVDRzBVNWlzUnRobTVCN0ozN0wxSUkwRXBo?=
 =?utf-8?B?ZWpuUzhkL1YremUwTE1lcmZuY0ZsenVRZzFSOHJWM0U1blV2Q1Rtc25YVVM4?=
 =?utf-8?B?aEtpMVV4R29TSmhjSm5xU0lNakQxK3FkL0dKd0NsRFlCeXA4SHExdFFnWWxq?=
 =?utf-8?B?SnVqUjEwN2pEeElrc3M1cHFBUHhoMEFwb3J6SEs5UGU2ZjNQY25zNXB6bHEx?=
 =?utf-8?B?NVFyQ01TTHlKbVd2dXAwRlJCT2NBZ0FNY25OQ0R0bTBERWFvc056WHlMbFpN?=
 =?utf-8?B?dDVnMU00elFlTDFSZHpSYW5EdFVnZklnbUFNbmtkZ0doQ1pYS25uU2lNZWVI?=
 =?utf-8?B?M2VJRUw2aVhhcWNhY3dtclNWQ2liTkdpV2Q0RnEzK3UxWmk1MnJRcUM4azFO?=
 =?utf-8?Q?KZvDXsz/hcJ5pD4Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7A87E112CE418488DA292BA26D280FA@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f629be79-f8ba-4d52-89a8-08df0191f7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 03:44:14.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr4FRmGt842Fck2UOhJZrWQnEHh36cmFwZSRA85e03F/7onT8vqbs8d8SwOnoX2olQXfPNNC5fEIimA6/rct0tSsD1hdwOSLFF5Q6nggw1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8280

T24gOC8yMS8yMDI2IDM6MzkgUE0sIEppYW55b25nIFd1IHdyb3RlOg0KPiBjcHVmcmVxIHByZXNz
dXJlIGxvd2VycyBhIENQVSdzIGNhcGFjaXR5IGJ5IHRoZSByYXRpbyBiZXR3ZWVuIHRoZSBoaWdo
ZXN0DQo+IGZyZXF1ZW5jeSBpdCBtYXkgcmVhY2ggYW5kIHRoZSBoaWdoZXN0IG9uZSBpdCBjYW4g
cmVhY2ggcmlnaHQgbm93Lg0KPiBVdGlsaXphdGlvbiBjYXJyaWVzIHRoZSBtYXRjaGluZyBzY2Fs
aW5nIG9ubHkgd2hlcmUgdGhlIGFyY2hpdGVjdHVyZSBpcw0KPiBmcmVxdWVuY3kgaW52YXJpYW50
OyB3aXRob3V0IGl0IGEgZnVsbHkgYnVzeSBDUFUgYWNjdW11bGF0ZXMgdGhlIHdob2xlDQo+IFND
SEVEX0NBUEFDSVRZX1NDQUxFIHdoYXRldmVyIGZyZXF1ZW5jeSBpdCBydW5zIGF0Lg0KDQpHaXZl
biBob3cgUEVMVCB3b3JrcywgYW55dGhpbmcgdGhhdCBpcyBhbHdheXMtcnVubmluZyB3aXRob3V0
IGlkbGUgdGltZSANCnVuZGVyIFBFTFQgd2lsbCByZWFjaCAxMDI0IGV2ZW50dWFsbHkgcmVnYXJk
bGVzcyBvZiBpbnZhcmlhbmNlLg0KDQo+IFJlZHVjaW5nIGNhcGFjaXR5IG9uIHN1Y2ggYSBzeXN0
ZW0gc2NhbGVzIG9uZSBzaWRlIG9mIHRoZSBjb21wYXJpc29uIGFuZA0KPiBub3QgdGhlIG90aGVy
LCBhbmQgYSBmdWxseSBidXN5IENQVSBlbmRzIHVwIHJlcG9ydGluZyBtb3JlIHV0aWxpemF0aW9u
DQo+IHRoYW4gaXQgaXMgY3JlZGl0ZWQgd2l0aCBiZWluZyBhYmxlIHRvIHJ1bi4NCg0KU29ycnkg
SSBkaWRuJ3QgcXVpdGUgY2F0Y2ggd2hhdCAnY29tcGFyaXNvbicgbWVhbnMsIGFuZCBpdCdzIGZh
aXJseSANCm5vcm1hbCBmb3IgdGFzayBhbmQgQ1BVIHV0aWxpemF0aW9uIHRvIGV4Y2VlZCBjYXBh
Y2l0eSB3LyBvciB3L28gDQppbnZhcmlhbmNlLiBXZSBqdXN0IG1hbnVhbGx5IGNhcCBpdCB0byBD
UFUgY2FwYWNpdHkgaW4gYSBmZXcgcGxhY2VzLiANCkNvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmlj
IG9uIHdoYXQgdGhlIHByb2JsZW0gaXM/DQoNCj4gVGhpcyBiZWNhbWUgcmVhY2hhYmxlIHdpdGgg
Y29tbWl0IGQyZDVjMTI5ZDA3ZSAoImNwdWZyZXE6IE1ha2UNCj4gY3B1ZnJlcV91cGRhdGVfcHJl
c3N1cmUoKSBmYWxsIGJhY2sgdG8gY3B1aW5mby5tYXhfZnJlcSIpOyBiZWZvcmUgaXQgdGhlDQo+
IHByZXNzdXJlIHdhcyBhbHdheXMgemVybyB0aGVyZS4gV2hldGhlciB0aGF0IG1hdHRlcnMgZGVw
ZW5kcyBvbiBmcmVxdWVuY3kNCj4gaW52YXJpYW5jZSByYXRoZXIgdGhhbiBvbiB0aGUgZmFsbGJh
Y2sgaXRzZWxmOiBhIHN5c3RlbSB0aGF0IGhhcyBpdCBzY2FsZXMNCj4gYm90aCBzaWRlcyBhbmQg
aXMgdW5hZmZlY3RlZCwgd2hpbGUgYSBzeXN0ZW0gdGhhdCBkb2VzIG5vdCBzY2FsZXMgb25seSB0
aGUNCj4gY2FwYWNpdHkuDQo+IA0KPiBGaXhlczogZDJkNWMxMjlkMDdlICgiY3B1ZnJlcTogTWFr
ZSBjcHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGZhbGwgYmFjayB0byBjcHVpbmZvLm1heF9mcmVx
IikNCj4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPHd1amlhbnlvbmdAaHlnb24uY24+DQo+
IC0tLQ0KPiAgIGtlcm5lbC9zY2hlZC9mYWlyLmMgfCAxMSArKysrKysrKystLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCj4gaW5kZXgg
YzE5YTAyNWQ4ZDY4Li5hMTYzZTAwYzk4ODIgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9zY2hlZC9m
YWlyLmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiBAQCAtNTg1NCwxMCArNTg1NCwx
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdXRpbF9lc3RfZGVxdWV1ZShzdHJ1Y3QgY2ZzX3JxICpj
ZnNfcnEsDQo+ICAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGdldF9hY3R1YWxfY3B1X2Nh
cGFjaXR5KGludCBjcHUpDQo+ICAgew0KPiAgIAl1bnNpZ25lZCBsb25nIGNhcGFjaXR5ID0gYXJj
aF9zY2FsZV9jcHVfY2FwYWNpdHkoY3B1KTsNCj4gKwl1bnNpZ25lZCBsb25nIHByZXNzdXJlID0g
aHdfbG9hZF9hdmcoY3B1X3JxKGNwdSkpOw0KPiAgIA0KPiAtCWNhcGFjaXR5IC09IG1heChod19s
b2FkX2F2ZyhjcHVfcnEoY3B1KSksIGNwdWZyZXFfZ2V0X3ByZXNzdXJlKGNwdSkpOw0KPiArCS8q
DQo+ICsJICogVXRpbGl6YXRpb24gb25seSBmb2xsb3dzIGZyZXF1ZW5jeSB3aGVyZSB0aGUgYXJj
aGl0ZWN0dXJlIGlzDQo+ICsJICogZnJlcXVlbmN5IGludmFyaWFudC4gRWxzZXdoZXJlLCBsb3dl
cmluZyB0aGUgY2FwYWNpdHkgd291bGQNCj4gKwkgKiBzY2FsZSBvbmUgc2lkZSBvZiB0aGUgY29t
cGFyaXNvbiBhbmQgbm90IHRoZSBvdGhlci4NCj4gKwkgKi8NCj4gKwlpZiAoYXJjaF9zY2FsZV9m
cmVxX2ludmFyaWFudCgpKQ0KPiArCQlwcmVzc3VyZSA9IG1heChwcmVzc3VyZSwgY3B1ZnJlcV9n
ZXRfcHJlc3N1cmUoY3B1KSk7DQo+ICAgDQo+IC0JcmV0dXJuIGNhcGFjaXR5Ow0KPiArCXJldHVy
biBjYXBhY2l0eSAtIHByZXNzdXJlOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgaW5saW5lIGlu
dCB1dGlsX2ZpdHNfY3B1KHVuc2lnbmVkIGxvbmcgdXRpbCwNCg0K
