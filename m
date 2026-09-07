Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B949B67E;
	Mon,  7 Sep 2026 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748348; cv=fail; b=GfZq77fpRwyX5gRQdCU1LwIZ+JB4lWi7IVyukunpXt+nbiJHnfRGb7MRhA9Kbx/AIKGDXDZoHtI7ShX/BrELsdMBDBqvX4IRQAbmukuIVm0QOe2gNN4rB7sq/9VBES7zYjQgVzcKPojDrNziXKs7LlyGqSwJ5J5KTj+LThSJxnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748348; c=relaxed/simple;
	bh=OLLKM7skrrzgbonxLNJvStLfteH+nNFNGHeek3g7ckc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVwtu15cesWlSyDw5lDDTXWInBZViM5nT/gMxgzDaZhiEfVBD4fRqULNMKX6NmkDla3mcpW867rKm/VhmcvAIL35sIZ+FzFfJsWuiv6Q2D8iT+Ir9cRFxSrMhrJh1bJWTXJDMEpmKs0NouaHGH9RoDrkvpW1CcyRlwIbJiY0oek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Yr2LSSDZ; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Yr2LSSDZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb4PPvp8yqeQu0Rd8im+Eqr86Fs7eaRqVHLEViFX01mAUIlR3vqU1rW2aCXD3dKrQkFDZpkkPL0GjRoEsPcE5wM6FTitgFBHA5nQ+DCEinURiLp/vdoCEotdPOwgtEcnTwENkNPq3lRhspR9CwMZa092zm1TW6/+VWOCLvtavPz5hE5Yc8AjPsZojg21lb0hYXNjRpgHrIPT+j/U8OMeRyf/3HqGNx748OyhAQHvjB0Np1JJZhOiRqQwZ9y9P0p/kT2Gf3forpud6nCPH5ie6g4k4Y4+tq1FovHJG4eMMoeEJNBDdHLGU9sHK6s+MXUrUpnK841shNqR0D7GoBS4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLLKM7skrrzgbonxLNJvStLfteH+nNFNGHeek3g7ckc=;
 b=nEHMlM16u1eftH41s6kzVqOhRJaN05PGG7hkDhfekM8uizAGI/crZKH3Emd28vHkIxDWySiSPwB7DTISu5tmXqMQ5QJC1FUUXmE/uTCW+AFzaaUUMGz2/q9I4aL/1NSrXXNzZFK/3IuHNcIRPN2pbJlxqkmRmRVt/knAk31EUcFUQvX87r9uVCHIWK2zGu8u6LUVqrpEoMq3XQQVDomHk6tMIkIIpgbAo9PynPfeuUiMuPfTJmG90yWn/YegOQhcA2kUfRmj1aRiq04MF7Vq5volCB1QEXJpbU8VcqN86vmxAUZHp08XzOA3px5JEZAHFoaT8yUckEhqHmHKaucSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLLKM7skrrzgbonxLNJvStLfteH+nNFNGHeek3g7ckc=;
 b=Yr2LSSDZe3AUbpi5sLEkHH0yDk+dedZ3KOXq8LIKQXhqai9UjO1ohjvgoHLu13fSy9tdaIMeLmGkxxxrzRfDgw1sX4+pZiyYKifRtOIve+5pL3KvBvjHk47YrWBewdIwLOoY4xRBt/ZVhCDyvkqlltMh94c64Y4W8vQ67aNMm2Y=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KUXPR04MB9466.apcprd04.prod.outlook.com
 (2603:1096:d10:9f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:32:22 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:32:22 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: jong wu <jianyong.wu@outlook.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zhongyuan@hygon.cn" <zhongyuan@hygon.cn>, "huangsj@hygon.cn"
	<huangsj@hygon.cn>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Topic: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
Thread-Index:
 AQHdM3mscPSSkrbdG0OLR3n/gvPslbasjrYAgACdI4CAAZIBgIAMSzIAgAANJACAARPYgIAGUTyA
Date: Mon, 7 Sep 2026 02:32:22 +0000
Message-ID: <f38d55b1-68f8-4cfa-8b97-47fe58bd9ed7@transsion.com>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
 <44993024-f1bb-4b4f-802b-a22f95101171@transsion.com>
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
In-Reply-To:
 <SI2PR04MB49315D05AB89CFA3B0E41BF3E3B62@SI2PR04MB4931.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KUXPR04MB9466:EE_
x-ms-office365-filtering-correlation-id: 301d05ad-3c1b-47ad-98ec-08df0c883eea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 TGowMqWg8fDGfCNTAN4dQlAVKwcWqL7uyJMGtb2NhDnfZmO/73rOjHJWI8YlltNZKxqLPWYuUWDCxp2FcXdhjYh9ulgtbQk9hurcuEQBQLBmCm4Nxyo2pnsT6j+5uKjDSTjargEMGmxzX0olUBiHMHJdsgxB/fk7NDgJ39NmEqN5hgR1YJDgAtPQR5uR0xjMxTO8pajd0tt06dZqaIpMqYrz0CLncJQUoxiiUh654IeOtjgHFlZn5rNESYlNueytJFZnbQkNuAxDAQDVs4wUfXpc58CDtyEBI0JzEMhcjXI7+kxBABYpR1SVV+15/VRlSvSSW2TugcsFosGxKlvU18MU1JE9ZRnjbegEKcazH9qvlA0rpsWrZAA5wbFn/+5gV7/bBT0coOVmOp58EkpN7q70PnKqDdZjlZgwCgGTs6xmUbd4lwHBQ4tnhwvsp7L87Dw1k+Wf477uWsGiU9hab9aHSZQGwTHUV+Tvas+5YPdPMiMJF42doWPCgiOLpR6n/tsgtNUQvgtuhMbmHXT8D044ItUKuBV16JIOoreB5U7Qj+EzJUKzWwUm1dMJBrRrWqf49rr9Yu3qvX26ut24cADNgquqmPhNnhxgM2hKa4OxR9t7CYzs45s15Ga3TT1mOYC4pI9zp9bcxKoZsYxOKg0b01pL+KHGS2caoe3IhmKbGUvcJU72AbAh8ioe1Y0iWJJZqlr4x1o6EnLwKkR+1+WUUOtcJcgWYKLRxPLMTGM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXZMdUpPNnNLYjVoK3BXcW1zK2pOS3R0UlVIbTdLOWV5L0QwTytENGQyOEJ1?=
 =?utf-8?B?VFZFZzRsdVJpZW9yNXNCaEdKdWRpNVhoOXRQSE5XbjYwQVpBTUF0MnFhZUl0?=
 =?utf-8?B?MGoyTkw1ZkozWUR5eGZ1UkU3Y0hZUE0ySGFDWTVUQ1B6UnR4eXNLSGJMc1I3?=
 =?utf-8?B?eFFwbDkwc3VBRnhDc0hNUVdyMU8ySTFNOFRHczFmT3piT2V6UmxxanFsd0dX?=
 =?utf-8?B?NUVIWFFDK3lIYURsZCtpQkNnUFVlYWkvNDNZcXFyN1hnN1U1VGQwR28zaU4w?=
 =?utf-8?B?UE45SThZaXV5K1kvcTUrQVMyQUxwbUtuUWpBTllab3FNTlRIb0l3am9Sc05k?=
 =?utf-8?B?V00wVkE0UFdtU2RabVNndDQ1eitLQStvWVMxV3dpc2FzWkdMYUZCeTNVTDN6?=
 =?utf-8?B?bVdlWkJ3RWZVQUVIVU9vRkNHNEErbytTSTRCMEZMWXFLNjZFQU1HQ042ZnFC?=
 =?utf-8?B?TnlUYUdPV2NNN2ZWOFp2YXdYZHo2Y3hieWh3dHcraS9GUmMzSGNieG83YnNi?=
 =?utf-8?B?WitTbTZxLzBvTnE0dFZYWWI4SHVESVlqZW01VSthZkxaTndpODU1ay8vT1Nh?=
 =?utf-8?B?bXhOTmNaU0dDZFdseXF6NE1jZEZGc0FUTnpkNkxuWG4wNEI0cm15UG5jSzRW?=
 =?utf-8?B?ekd3VTFiT0ZqVHZlNFNpd043N1ZjeGxyaXpMS3Y1MnZoZVVxRHQxamNsN1ZU?=
 =?utf-8?B?RWtnTFJEL2lOc29kTjBrMjFBYU5HVzREZDdVNE1YL00zaVlXZUlGcWtVcWhy?=
 =?utf-8?B?VzBBcGYvQ2pGelppYmlib0FKbUNMeVMxNnlnZ2xPYmJCUE5URVR5RitiQW5L?=
 =?utf-8?B?YTRaMEQvK2hsRUxhWTBaeGFHeXNwTXlvWmlKNmJPRXFleTZrckovaWFSb3Qz?=
 =?utf-8?B?UzNKYkFzMFlTemwrczJ6RFVFaG5ucVJ5aHltMFk1T1FDTkxIYm5ZUHRaK3Rm?=
 =?utf-8?B?UVRWajg1LzlRdWM2aXRtY3pUTmZHTlBIUENsSklIaTVkYWxIUXZybzV6c3pX?=
 =?utf-8?B?OUdtRXJpTmNjbjJEclFuZEZNWlVVMlUrOWFOc0hoYUFrM1JLaSsrZFNCUWwr?=
 =?utf-8?B?cGNOT1pjaUo1dmtOdG9sQ2RWbkhmMjBLOU9lakxVZ1ZHQ0Joc1cxQUtzWEZL?=
 =?utf-8?B?b1VIV3hrRnZqSUtMNkpDdmluRGxCYTR1d3YwaGFacFBIajFjNHB3bXRVZlov?=
 =?utf-8?B?T3lvK2V5b1I5VDhVd3JyclNkWFpXL2ZEZ0VwTFdlTThiRG15UlhqdDltTSs1?=
 =?utf-8?B?ZmpTYURKOW1XVkJvSkF0YmZxVDBqcGJxQTZ6VGRjY0RZdFV0STZhNW9MMUgv?=
 =?utf-8?B?OTVpaUlLdU5oRFFjcHV1MDhNMitpK3FKeGZUL1h5emxueDJZcUN6cjhtbWMy?=
 =?utf-8?B?d21HVE02Y3ZEeCtlbUo4alNNNnNKckRmaFFtZ1BRWTdYVFB6Y1Z3NXNObEtP?=
 =?utf-8?B?NzlLd2RQdWZjbTNaWDdpeVM1UVdZLzdkWHZSc2Jubm5lRzRHdmxUeDB1dHJU?=
 =?utf-8?B?S3dRcUtXWVlVUlVjRit2citjZlYxeDFxOUdFQU54SWF5RlEwdzZ3a0RFV1RS?=
 =?utf-8?B?bkxqVm92UjhhVHVXWWIrUnJVTVBMaVlhN2JwTjY5Z1d3a2dZOXhzSWZpY3JX?=
 =?utf-8?B?di81VG1VMHNZcTdoajVma2s4cnhvcyt1R3VhRU5ISmlnSFpyeURHQUhOTUh6?=
 =?utf-8?B?ZlRVbmFyemVOLzE2d3NheXhYQ1J6dHN5amphbGRpZThuWHRUeGIzaFZIV1p4?=
 =?utf-8?B?QmRJNTA3a3BlUDZrUGZiYUxXWWJMcDltSG92bElzR0hQSTcrcVAzNko2anMz?=
 =?utf-8?B?ZVBQY2xhOFpCRkY4MEpYWCtaOEFrV0gzN0l1Z1JiaG1DcUdCRjZqLy9EY3U0?=
 =?utf-8?B?NlFjVkQrS3o3UmxqcjNGYXV5Y256VWRwTXlwMFJwcnJJcmdwMzREYk12ZUto?=
 =?utf-8?B?cjQzNTJ4UnZGT05SS0ZjNTZrT0tEcEZyR1JzazZXaUFNVEx0MUVHcE5xc1V2?=
 =?utf-8?B?bmJKMXo4NE1OV1c3Sm0vK01JdTNib3NmdGVscjJqUStQVEIySlRIQVZ1VXJS?=
 =?utf-8?B?aklnVllJTTlVQVlJMTluaXB0NTJRUml4aTdlQ2xZUEoyc1h4L2VmNVd3ZkpR?=
 =?utf-8?B?ckFDSkxJTzhWQ0I0SERWVDNSVkdDeHNHWDNFUlY0cGg3cVJZSjNlYXVQSmk1?=
 =?utf-8?B?VEtVWGMrN1FKSlYxMUxsMlhjL2Rpay96dzdSZ29FcGdpZVZvTGhXZmd1eUx4?=
 =?utf-8?B?NkIvVm5ISUVjbHZEdWViWHhCclV0eDZ3cVhQSWU0R2xZUlhhS0dKUytMNDlU?=
 =?utf-8?B?Q1g0VVhPdFVrUERNY0pWQmQzNko2cDFZNnBGRmlPdGVHVEJjdFVhMW1hbU9S?=
 =?utf-8?Q?xzehNeSzgAC2lVOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE985160D7BAC649811077A328948411@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 301d05ad-3c1b-47ad-98ec-08df0c883eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 02:32:22.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oFPtR8pD16+AMbDAawrertm1yEV62bg9qZBG3kVSH9zA9e+yccDIq6LShPsYjZHB5af/bMxvVvXyI5mk7SQlu/ik4qbnHioQE2wm7dRZF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR04MB9466

T24gOS8zLzIwMjYgMTA6MDQgQU0sIGpvbmcgd3Ugd3JvdGU6DQo+IOWcqCAyMDI2LzkvMiAxNzoz
NywgSG9uZ3lhbiBYaWEg5YaZ6YGTOg0KPj4gT24gOS8yLzIwMjYgNDo0OSBQTSwgam9uZyB3dSB3
cm90ZToNCj4+PiDlnKggMjAyNi84LzI1IDIxOjA1LCBWaW5jZW50IEd1aXR0b3Qg5YaZ6YGTOg0K
Pj4+PiBPbiBNb24sIDI0IEF1ZyAyMDI2IGF0IDE1OjA2LCBKaWFueW9uZyBXdSA8amlhbnlvbmcu
d3VAb3V0bG9vay5jb20+DQo+Pj4+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IEhpIFZpbmNlbnQsIEhv
bmd5YW4sDQo+Pj4+Pg0KPj4+Pj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPj4+Pj4NCj4+
Pj4+IE15IG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlIGRpZCBub3QgY2xlYXJseSBkZXNjcmliZSB0
aGUgY29uY3JldGUgaXNzdWUNCj4+Pj4+IGJlaW5nIGZpeGVkLCBhbmQgaXRzIGV4cGxhbmF0aW9u
IGJhc2VkIG9uIGZyZXF1ZW5jeSBpbnZhcmlhbmNlIHdhcyBub3QNCj4+Pj4+IGNvcnJlY3QuIEFm
dGVyIGxvb2tpbmcgaW50byB0aGlzIGZ1cnRoZXIsIEkgZm91bmQgdGhhdCB0aGUgaXNzdWUgSQ0K
Pj4+Pj4gb2JzZXJ2ZWQgaGFzIGEgZGlmZmVyZW50IGNhdXNlOiB0aGUgY3B1aW5mby5tYXhfZnJl
cSBmYWxsYmFjayBhZGRlZCBieQ0KPj4+Pj4gZDJkNWMxMjlkMDdlICgiY3B1ZnJlcTogTWFrZSBj
cHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGZhbGwgYmFjayB0bw0KPj4+Pj4gY3B1aW5mby5tYXhf
ZnJlcSIpLg0KPj4+Pj4NCj4+Pj4+IFRoZSBjb21taXQgbWVzc2FnZSBzYXlzOg0KPj4+Pj4NCj4+
Pj4+IMKgwqDCoCBIb3dldmVyLCBpbiB0aGUgYWJzZW5jZSBvZiBhcmNoX3NjYWxlX2ZyZXFfcmVm
KCksIGl0IGlzIHJlYXNvbmFibGUNCj4+Pj4+IMKgwqDCoCB0byBhc3N1bWUgdGhhdCBjcHVpbmZv
Lm1heF9mcmVxIGlzIHRoZSBtYXhpbXVtIHN1c3RhaW5hYmxlIA0KPj4+Pj4gZnJlcXVlbmN5DQo+
Pj4+PiDCoMKgwqAgZm9yIHRoZSBnaXZlbiBjcHVmcmVxIHBvbGljeS4NCj4+Pj4+DQo+Pj4+PiBU
aGF0IGFzc3VtcHRpb24gZG9lcyBub3QgYWx3YXlzIGhvbGQuDQo+Pj4+Pg0KPj4+Pj4gT24gYW4g
eDg2IHNlcnZlciB1c2luZyBhY3BpLWNwdWZyZXEsIGNwdWluZm8ubWF4X2ZyZXEgaW5jbHVkZXMg
dGhlDQo+Pj4+PiBhdXRvbm9tb3VzIGJvb3N0IGZyZXF1ZW5jeSwgd2hpbGUgcG9saWN5LT5tYXgg
aXMgcmVzb2x2ZWQgdG8gdGhlDQo+Pj4+PiBoaWdoZXN0IHNlbGVjdGFibGUgX1BTUyBzdGF0ZS4g
V2l0aCBib29zdCBlbmFibGVkIGFuZCBwb2xpY3ktPm1heA0KPj4+Pj4gdW5jaGFuZ2VkIGF0IHRo
YXQgc3RhdGUsIHRoZSBtZWFzdXJlZCBDUFUgZnJlcXVlbmN5IGNhbiBzdGlsbCBleGNlZWQNCj4+
Pj4+IHBvbGljeS0+bWF4LiBUaHVzLCBwb2xpY3ktPm1heCBkb2VzIG5vdCByZXByZXNlbnQgYW4g
ZWZmZWN0aXZlIA0KPj4+Pj4gaGFyZHdhcmUNCj4+Pj4+IG1heGltdW0tZnJlcXVlbmN5IGNhcCBp
biB0aGlzIGNhc2UuDQo+Pj4+Pg0KPj4+Pj4gTmV2ZXJ0aGVsZXNzLCB0aGUgY3B1aW5mby5tYXhf
ZnJlcSBmYWxsYmFjayBtYWtlcw0KPj4+Pj4gY3B1ZnJlcV91cGRhdGVfcHJlc3N1cmUoKSBjYWxj
dWxhdGUgcG9zaXRpdmUgcHJlc3N1cmUgZm9yIGV2ZXJ5IA0KPj4+Pj4gcG9saWN5LA0KPj4+Pj4g
YWx0aG91Z2ggbm8gZWZmZWN0aXZlIG1heGltdW0tZnJlcXVlbmN5IHJlc3RyaWN0aW9uIGhhcyBi
ZWVuIGFwcGxpZWQuDQo+Pj4+Pg0KPj4+Pj4gVGhlIHVuZGVybHlpbmcgaXNzdWUgaXMgdGhhdCBj
cHVpbmZvLm1heF9mcmVxIGlzIHRoZSBtYXhpbXVtIHBvc3NpYmxlDQo+Pj4+PiBvcGVyYXRpbmcg
ZnJlcXVlbmN5IGFuZCBtYXkgaW5jbHVkZSBhbiBhdXRvbm9tb3VzIGJvb3N0IGZyZXF1ZW5jeSwN
Cj4+Pj4+IHdoZXJlYXMgcG9saWN5LT5tYXggbWF5IHJlcHJlc2VudCB0aGUgaGlnaGVzdCBzZWxl
Y3RhYmxlIF9QU1Mgc3RhdGUuDQo+Pj4+PiBDb25zZXF1ZW50bHksIHBvbGljeS0+bWF4IDwgY3B1
aW5mby5tYXhfZnJlcSBkb2VzIG5vdCBuZWNlc3NhcmlseSBtZWFuDQo+Pj4+PiB0aGF0IHRoZSBh
dmFpbGFibGUgQ1BVIGNhcGFjaXR5IGhhcyBiZWVuIGNhcHBlZC4NCj4+Pj4NCj4+Pj4gSUlVQywg
Y3B1aW5mby5tYXhfZnJlcSA9PSBib29zdCBmcmVxIGFuZCBwb2xpY3ktPm1heCByZWZsZWN0cyB0
aGUNCj4+Pj4gY29ycmVjdCBoaWdoZXN0IGZyZXF1ZW5jeSByZWFjaGFibGUgYnkgdGhlIENQVSB3
aGVuIGJvb3N0IGlzIGRpc2FibGVkDQo+Pj4+IHNvIHRoZSBjcHVmcmVxX3ByZXNzdXJlIGlzIGNv
cnJlY3QuIEJ1dCB5b3VyIHBvbGljeS0+bWF4IGlzIG5vdA0KPj4+PiB1cGRhdGVkIHdoZW4gYm9v
dCBpcyBlbmFibGUgYW5kIGRvZXNuJ3QgcmVmbGVjdCB0aGUgaGlnaGVzdCBmcmVxDQo+Pj4+IHJl
YWNoYWJsZSBieSB0aGUgQ1BVLg0KPj4+Pg0KPj4+DQo+Pj4gRXhhY3RseS4gSSB0aGluayB0aGUg
cm9vdCBjYXVzZSBpcyB0aGF0IHBvbGljeS0+bWF4IGhhcyBkaWZmZXJlbnQNCj4+PiBzZW1hbnRp
Y3MgYWNyb3NzIGNwdWZyZXEgZHJpdmVycy4gT24gSW50ZWwgYW5kIG1vc3QgQU1EIG1hY2hpbmVz
IGl0IGlzDQo+Pj4gdGhlIG1heGltdW0gYXR0YWluYWJsZSBmcmVxdWVuY3ksIGkuZS4gdGhlIGJv
b3N0IGZyZXF1ZW5jeSB3aGVuIGJvb3N0DQo+Pj4gaXMgZW5hYmxlZC4gRm9yIGFjcGktY3B1ZnJl
cSwgaG93ZXZlciwgcG9saWN5LT5tYXggaXMgcmVzb2x2ZWQgZnJvbSB0aGUNCj4+PiBBQ1BJIF9Q
U1MgdGFibGUsIHdoaWNoIGRvZXMgbm90IGNvbnRhaW4gdGhlIGJvb3N0IGZyZXF1ZW5jeS4NCj4+
DQo+PiBQcm9wZXIgc29sdXRpb25zIGFzaWRlLCBJIHZhZ3VlbHkgcmVtZW1iZXIgaW52ZXN0aWdh
dGluZyBzY2hlZHVsZXINCj4+IGlzc3VlcyBvbiBhIFJ5emVuIDc4NDBVLiBUaGF0IGhhcyBhY3Bp
LWNwdWZyZXEgd2l0aCBvbmx5IDMgT1BQcy4gQm9vc3QNCj4+IGZyZXF1ZW5jaWVzIGFyZSBub3Qg
aW5jbHVkZWQgaW4gdGhvc2UgMyBhbmQgYXJlIG11Y2ggaGlnaGVyIHRoYW4gdGhlDQo+PiBBQ1BJ
IE9QUHMuIEkgY2VydGFpbmx5IG1hbmFnZWQgdG8gZGlzYWJsZSBwc3RhdGUgYW5kIHN3aXRjaGVk
IHRvDQo+PiBhY3BpLWNwdWZyZXEgb24gaXQuIEkgd29uZGVyIGlmIHlvdSBjYW4gcmVwcm9kdWNl
IHN1Y2ggaXNzdWVzIG9uIHN1Y2ggYQ0KPj4gbWFjaGluZS4gTWF5YmUgdGhpcyBpcyBhIGJyb2Fk
ZXIgaXNzdWUgdGhhbiB3ZSByZWFsaXplLg0KPiANCj4gVGhhdCBtYXkgd2VsbCBiZSB0aGUgY2Fz
ZSwgYnV0IHNvIGZhciBJIGhhdmUgb25seSBvYnNlcnZlZCBpdCBvbiBteSBvd24NCj4gbWFjaGlu
ZSwgc28gSSB3b3VsZCByYXRoZXIgbm90IGNsYWltIG1vcmUgdGhhbiB0aGF0IHlldC4NCj4gDQo+
IE15IGN1cnJlbnQgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB0cmlnZ2VyIHdvdWxkIGJlIHRo
ZSBkcml2ZXIgcmF0aGVyDQo+IHRoYW4gdGhlIHZlbmRvcjogaWYgYSBzeXN0ZW0gcnVucyBhY3Bp
LWNwdWZyZXEgYW5kIGl0cyBib29zdCBmcmVxdWVuY3kNCj4gaXMgbm90IHByZXNlbnQgaW4gdGhl
IF9QU1MgdGFibGUsIHRoZSBzYW1lIHJlYXNvbmluZyBzaG91bGQgYXBwbHkuIFRoZQ0KPiA3ODQw
VSB5b3UgZGVzY3JpYmUgLS0gMyBPUFBzLCBib29zdCB3ZWxsIGFib3ZlIHRoZSBoaWdoZXN0IG9u
ZSAtLSBsb29rcw0KPiBsaWtlIGl0IGNvdWxkIGZpdCB0aGF0IHNoYXBlLCBidXQgdGhhdCByZW1h
aW5zIGEgZ3Vlc3MgdW50aWwgaXQgaXMNCj4gYWN0dWFsbHkgbWVhc3VyZWQuDQo+IA0KPiBJIGRv
IG5vdCBoYXZlIGEgNzg0MFUgYXQgaGFuZC4gSSB3aWxsIHRyeSB0byByZXByb2R1Y2UgaXQgb24g
YW4gSW50ZWwNCj4gb3IgQU1EIGJveCBieSBmb3JjaW5nIGFjcGktY3B1ZnJlcSAoaW50ZWxfcHN0
YXRlPWRpc2FibGUgLw0KPiBhbWRfcHN0YXRlPWRpc2FibGUpLCB0aGVuIGNvbXBhcmluZyB0aGUg
bWVhc3VyZWQgZnJlcXVlbmN5IGFnYWluc3QNCj4gcG9saWN5LT5tYXggd2l0aCBib29zdCBlbmFi
bGVkIGFuZCBjaGVja2luZyB3aGV0aGVyIGEgbm9uLXplcm8gY3B1ZnJlcQ0KPiBwcmVzc3VyZSBz
aG93cyB1cCB3aGlsZSB0aGUgc3lzdGVtIGlzIHVuY29uc3RyYWluZWQuIEkgd2lsbCByZXBvcnQg
YmFjaw0KPiB3aXRoIHRoZSBudW1iZXJzIG9uY2UgSSBoYXZlIHRoZW0uDQoNCkkgbWFuYWdlZCB0
byByZXByb2R1Y2UgdGhlIHByb2JsZW0gb24gYW4gQU1EIDU5MDBYLiBJIGFkZGVkIHRyYWNlX3By
aW50ayANCm91dHB1dHMgb24gY3B1ZnJlcSBwcmVzc3VyZSB1cGRhdGVzLiBVbmRlciBBTUQgcHN0
YXRlIHdpdGggYm9vc3QgDQpmcmVxdWVuY2llcyBJIGdldDoNCg0KWzAwNl0gLi4uLi4gICAgMzQu
MDk2NDkyOiBjcHVmcmVxX3NldF9wb2xpY3k6IENQVSAxIGhhcyBtYXhfZnJlcSANCjQ2ODM0NzEs
IG1heCA0NjgzNDcxDQoNCllvdSBjYW4gc2VlIHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSBhbmQg
cG9saWN5LT5tYXggYXJlIHRoZSBzYW1lLg0KDQpJZiBJIGZvcmNlIGRpc2FibGUgcHN0YXRlIGFu
ZCB1c2UgQUNQSSBPUFBzIHdpdGggc2NoZWR1dGlsIGJ1dCBzdGlsbCANCndpdGggYm9vc3QgZnJl
cXVlbmNpZXMsIEkgZ2V0Og0KDQpbMDAzXSAuLi4uLiAgICAgNC42OTc3NTM6IGNwdWZyZXFfc2V0
X3BvbGljeTogQ1BVIDEgaGFzIG1heF9mcmVxIA0KNDY4MDcxNCwgbWF4IDMzMDAwMDANCg0KU28g
eW91IGNhbiBzZWUgcG9saWN5LT5tYXggaW5jbHVkZXMgbm8gYm9vc3QgZnJlcXVlbmNpZXMgKDMz
MDAwMDAgaXMgdGhlIA0KaGlnaGVzdCBPUFApIGFuZCB3aWxsIHRyaWdnZXIgcG9saWN5LT5tYXgg
PCBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEsIA0KaGVuY2UgYXBwbHlpbmcgcHJlc3N1cmUgd2hl
biB0aGVyZSBpcyBhY3R1YWxseSBubyBwcmVzc3VyZS4NCg0KVGhlIGNvbmNsdXNpb24gaXMgdGhh
dCB5ZXMsIHRoaXMgaXMgYSB3aWRlciBwcm9ibGVtIHRoYW4gd2UgcmVhbGl6ZS4gSSANCnN1c3Bl
Y3QgdGhpcyBtaWdodCBhbHNvIGJlIHByZXNlbnQgaW4gSW50ZWwgQ1BVcyB3aXRoIEFDUEkgY3B1
ZnJlcS4NCg==
