Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022098.outbound.protection.outlook.com [40.107.75.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F53C2796;
	Fri, 22 May 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442611; cv=fail; b=Dkw7A21e3FPoeEZwLGiYdxFJ4mD3LZevFcKIyiNxevsKWvW462az+omDPY/OA38545xF4bqfDuJpLpFawOWJBgXwASaf8TEIhll/ZwADPmqxGURtYM0QCZ0GBaWJC8umxUFMsfHNc0XfL9y330BcE+wfNen9svpkcB3eaP7Teo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442611; c=relaxed/simple;
	bh=BuwpnzULz5EnihkhTc9y6cOOdItILnpaQHGHdWHkgy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKqPX4IpxNQNqB/7E0cantC/E2uchxr6WNFK5w3FlWm/+wLEJU1TYREZ9iGKN9I069EFSIROXfegG+y+Ge08/UOx2T+ZERep7vYHJmRoK5NgIJOyzMkbDOeVkXpE/gk9NxXf2WX0SooRt5Bt6qakdtQUSs+0w5LArP91EF/17Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=KyjDHkJP; arc=fail smtp.client-ip=40.107.75.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="KyjDHkJP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOvlDDk/Zq1/dkf5eQOJjRtZwHZVTjO1dQ+gLhTywtN6vYA8og35Fn/7hPyH/Axc86WCtNZ8fqwLQ4ZV6RfRhriWe7Ok2O2l7yriVT0SaVqQq4Ac5K1iW909xeuwPVeiT6sf/ZmdZtEYfJbatjkF6WgOorqc7havRcwgOKD3Q3Yx2t9+XRRvvqYuMHf5a64L07jGbOlEcStVu/4jnO46Ew5dfmIri/prizKVuCSRJ6f/9bUciFgTDcolGSLSJ0H9xu4bs/0oGQss1Hl2ESqTHR8qkZVzaCoUObDJx/yb4+7JWvDGlZZbaWa2aeDmaBv/f9JnwcB5fFNUaT1nyKKxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuwpnzULz5EnihkhTc9y6cOOdItILnpaQHGHdWHkgy4=;
 b=KlykD9GhnG8xAXFer82sKaKQUNSc5/lUEd/S2AxCpJ0MY7zqEX2mAc4tIjN68QxD0vo4LSTZyffr6Seb+BlCWzePqlY/PaNxsryOK6wrG+S5F6xfecm9JsFH+9LooSGsb2dUEU+HU/+TB/zV3yfzStyV3h6f2/YZqkvVqB5FuMGJduQAQuFKFmsaeTuoWFTXau+bXFx5zJlV8+fp29M+IMjsmZXyD9PkCgn3MK6neQbEo7r3Oq5UjDhSJRQWx+QELkZaUVjMIk7cJ28ku3SDWmrqkirOJZEsrt8Tc2MMKGnXdSon+bVUNjVWbeg6HIqfJSuNJPaqGfimHh9jJwdHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuwpnzULz5EnihkhTc9y6cOOdItILnpaQHGHdWHkgy4=;
 b=KyjDHkJPQ6lfzNcCWxmakixakjxK6gMcUsVD15OhxJsMzP/K/3KVxWW8oiph0E99UfCH7GSS1zHXp7OmBgo86UpzhAj+ZGa9gvBr8TjvRx6Hy3d7MN/hEUvZVTJYQ11xmQRzeQ9mTlP9w+ies5qNbk6AGBfx4vsQ6f0FNAosOjE=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEYPR04MB7629.apcprd04.prod.outlook.com
 (2603:1096:101:1de::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:36:47 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:36:46 +0000
From: hongyan.xia <hongyan.xia@transsion.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: hupu <hupu@transsion.com>, jiazi.li <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYZshaAgAAd/AA=
Date: Fri, 22 May 2026 09:36:46 +0000
Message-ID: <bc7720fa-012c-4f0e-add6-4db526fdaa2d@transsion.com>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <0f7dd656-5ee4-4c14-a27c-fa30c12a676a@arm.com>
In-Reply-To: <0f7dd656-5ee4-4c14-a27c-fa30c12a676a@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEYPR04MB7629:EE_
x-ms-office365-filtering-correlation-id: df609641-2143-4f37-358d-08deb7e5a47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|11063799006|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 hvbXfAaDnrkMfm987NrCPUizeqdWoBBfX3ZxTGy44rOOR1MQ9dGihs7FFUvjodyLfRajmISFm7Je5MFcBEYya/djoQQg36FEBaDSfUYcL4/kfFD4ejg8X3JzKnleDcL1u6SAbogJHSLP5DD8QiTwCuj0xyXqj6YwNwB48QJMraj+p1KxkgJcoEaUfWV7BVXtCT8osSC6bmSRfwZeNrQytXWorfRRiOYHKwTF+JreL+welsdFQ43LfZWsAxdqn3WvB/VUs7mnTPFkWNHfm2dWPWH/22QaDlULn+lFRZwMRENXIGmVwOU+RklgfoWUC71IoqQNNadRBTBDiXlQKad2wqnLG323E2JPPq7Wz1b/HrR0M50KCW7NtcXjzyLizfEzoaZ2/qilNv4lbQEfPj09hYYNiKH/c8tfEoCuFVWbHkC2PwQDVm3xf3nyfL6bY/KhAXjbmQwtV5jXPSGvso7FybqMy5vPKjqgBkh1TaX/QMqi/oY12aKjwOaezzAYruUICc5iHm2NWg/3uo4qTSGs/PLvUZJC5ilaAvoyb92LrqZfwhTUubjkmUWZKfmnbTtBcmlDbuqoaM5lQ7GhxElqCEuALqrcFKlf/reMKqUJm/moDPPV6OBo0jMy5cVlUAb9wn1tDwIYyRulIcEAB9lbSERfB76nQUccZh2hNsnmlZm3pADQzw0hs345zjgeIQooSuuCTEyfjmUzIyhjvXTSYJ6CS1TUBoGnAH5QpE4hRiqtxxVcwKjoPul6S69gSYRmIvFf4q/nIynnNx1/GNnkQw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(11063799006)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW5IREcycHRmYkJtS0xXajVvMlJrVzRXTHF5MjhObnF5SS9SZlVoRnpFYVR0?=
 =?utf-8?B?cUFKOWp5VzRDcWZ0WDdBZzBsVzhGTitsT3RsTzFpUURncU1PVUVuN0NoZXVZ?=
 =?utf-8?B?QkJBZ2VNRkpBZXdSWDhuOWR5eUJ1allINW9zY2R6QXFHOTY2RDJmaE5waFlY?=
 =?utf-8?B?YzVQVEkvQXZ4L21VWUtRL1VDYTNxV0g2RnVFQVlvTUNUQ2FwUnRaSWV2cklN?=
 =?utf-8?B?dlB2SG83L2dHaFJEbkZTVFRiTHJhQmI2bFV5SFdPTGpSRko3Mm5hOWRudEJy?=
 =?utf-8?B?QkdlbTNndndwQVJWK0ZlSXpwSmtERytCeUdaNmhLQlRrNVpqeEkxd3lRTjhm?=
 =?utf-8?B?RkUvMWFtdlhkaU9nU1hWU2VzYm1zQzZlcmt2MzlTQkNRTTBJdmltOVhRblgz?=
 =?utf-8?B?YTN6MEE2aXZ0ODdZZUZmZVRVUzJ0YXlFalhUWUJDeEk5aCtwbXdMS0VsSVJW?=
 =?utf-8?B?OXdnRE9kRVVLRTlyK3VXbVhUZ2xNb0s2cDNLb3JwQVVRK3FmTDZzWERZUnJ0?=
 =?utf-8?B?TW9DRmJmcjdsS2ovK1FsMUgrTUJ0NUY5YWM4dWhlRUxaWGRXZ0Z6SElVazdy?=
 =?utf-8?B?UUw0V054WlVYMURncGxzRWhFTkVQVXVHL0M0Mm1Bc0tXQWFPN2pZVXAyUFpp?=
 =?utf-8?B?S1pESkZTQWJYYkNYSzV5b0tYc0NKQlNQYVVIYk1aRnhNbmRMZ3M3ajVtTzUw?=
 =?utf-8?B?blhzcUsxNlZLVC9VQmhzYWR0N1NISGY0ejB5LzZnMFZLWWVwTW1MRlRKb3VV?=
 =?utf-8?B?Z2xUUFVJL2tlUHM4Vm5KNTM5UkZkTVI4N3QrNFVmVXVTSTlzYWFLTWx4cXFJ?=
 =?utf-8?B?YlVMU3pDU2lrdUFoVmtsbUF1SzRiR1doMGVzOEp0UDQ2czAybGpEZUV1eWJI?=
 =?utf-8?B?Q0lyNVNZdTRoZC9tbmVWcDdjWE45RHZodW5UUUdIV3R3UnFUZ1o5NzFoZkt4?=
 =?utf-8?B?L01MMEFjd0toWHZyNyt1eElsWWYxMVM1N1JucGJrTTYrUm9kbU1JWlNUcGJI?=
 =?utf-8?B?L3VYU1RITWFLMnZCRHJBVjJ0Umg4azZmbnhpcGN0SWZCMkJ0Ky9yVERnMjVH?=
 =?utf-8?B?MFE3RUc4L1ljNER2aWNpWDJ2VkNHSXNrSVJLQk9RMDh3aW9rcUhtNzI1ZWJx?=
 =?utf-8?B?SzNOQmVZeEVPN2orUGRKOVUxM0RzOFVpRURZelc4c1p5cXA3NDg0dVVteVVJ?=
 =?utf-8?B?UDV4bXM3TUl4YWpaR0Zsa3Jod0J1WFJjc1Q1M1lPYjZQU25DSkZMUkV0RDF5?=
 =?utf-8?B?ZUJoYjV1alQ0VHRzYkh2SjNGQU8zNGdzN0tVdXVBSjA1RjUvY1psRlFZZXh1?=
 =?utf-8?B?TVFIRXF1cXJ1dGE0d0Jpb2J2eFlpL0pSUjd2K0FKY0syeGZTYTNCKzdTamp3?=
 =?utf-8?B?eDdKMm0rbUpaTytPSXR5dHpKQ0dJaEJhMzF2dFVPYU45T1l3d2llL29sQ1dv?=
 =?utf-8?B?TUhDaDBJd2IrT05uaDl4VTBTZkFSSzJ4MW9yOXhiemFDaGtLUFQ3VVl0MUxx?=
 =?utf-8?B?QXZuWHo2eDBTNXhCOWF5UHhBVjVhRGxLd0sraFQ4SS83WkMwMFlnQndCSkpO?=
 =?utf-8?B?QzZjcnFqOGFmTCtoSU9ib2dBSHBzZHlHUW9ocktoK3dhZWN0a1ZZcmhPUWdl?=
 =?utf-8?B?T0FFMFYralBhNVJkR3V0L2ZzRUxPc2x0Qk45NnF5SUYvSFByVjJNZENJa1Ar?=
 =?utf-8?B?bGpkWThhS29zT1JVcGNNSzFYaG5kMnhSaTd0bjE1UGVtd0p0L3hTTTd5dHFB?=
 =?utf-8?B?U0pxR1dYZVFGTytmYXFPazdzWGIremswaVVYUmNNQjZ2VGpZK2IxdFB0anhp?=
 =?utf-8?B?ZXQ5M1lZRG8zOHRBZG5oUVlqRWJ0Vk5MZDlNdU1EZzhoaFd1Nk84OFU5ei9N?=
 =?utf-8?B?ZkYrNEMySU5yNEJUUUsyTXVmQ2FZbWkvcTVLc1RSb1hGUU5BOWVxQ0doTUJn?=
 =?utf-8?B?M1JYaW1WTTFyZXdvd0VEcG50K1hadkJyOHZUM295WUx6RnEweEs3dmZSRlV1?=
 =?utf-8?B?NFZJWDBTcmE4a2hBajR3UDNzems5NmF4ckNWdVJPa05UMGp2UkZBWjI4elV6?=
 =?utf-8?B?d1FMTVJBNEtwU3Q0dCtVcTNLclIwbEVDZWFyeUFSRVhRL0xjaXloV3BpOTRH?=
 =?utf-8?B?NDdXZHFhYm9OVDdoN2RhdVJIUUF3MXgrd1VEWkx0UDJ3ejhWY3oybDltQzYx?=
 =?utf-8?B?VTNGUDJmSGhaTS81TVJpY0hDZzBmM01ERThqTVNEMUsrYlZTbjd6UFhORXVK?=
 =?utf-8?B?ZW1xMWU1OWRYSFN6NTM4aU9yUThEVGpkODJ4Uk9EcXVtS2NNbXpJN0lMRTRV?=
 =?utf-8?B?ekREbGk4VHEyektVUFB1bkdxMnZPL2c2eGlOUmtaT2dkU0E3MEJ5emp6RVNH?=
 =?utf-8?Q?7ZpILYxRJdkkT3Zg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C55D249ACD32684C949F5DA5BA0675A8@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df609641-2143-4f37-358d-08deb7e5a47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 09:36:46.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxXZ8g7xiwfeQOa1IUbMeQWE0hbnUvjoULD630hhzxIOTvUIU4v8I5b1HV/suebWFYT83z1MJN8auCNeKkdBJcLXVW66F34C8WQCAUCf4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7629

T24gNS8yMi8yMDI2IDM6NDkgUE0sIERpZXRtYXIgRWdnZW1hbm4gd3JvdGU6DQo+IE9uIDE4LjA1
LjI2IDA0OjQwLCBob25neWFuLnhpYSjlpI/lvJjlvaYpIHdyb3RlOg0KPj4gRnJvbTogSG9uZ3lh
biBYaWEgPGhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+DQo+IA0KPiBJJ20gb24gdmFjYXRpb24g
dGhpcyB3ZWVrIHNvIHdpbGwgaGF2ZSBhIGNsb3NlciBsb29rIGJlZ2lubmluZyBvZiBuZXh0IHdl
ZWsuDQoNClZhY2F0aW9uIGNlcnRhaW5seSBtb3JlIGltcG9ydGFudC4gUGF0Y2hlcyBjYW4gd2Fp
dCA6KQ0KDQo+PiBXZSBoYXZlIHNlZW4gYSBtYXNzaXZlIHBvd2VyIGNvbnN1bXB0aW9uIHJlZ3Jl
c3Npb24gKDIwJSBTb0MgcG93ZXINCj4+IGluY3JlYXNlIGluIG1hbnkgYXBwcykgYWZ0ZXIgdXBk
YXRpbmcgb3VyIGtlcm5lbC4gQWZ0ZXIgYmlzZWN0aW9uIHdlDQo+IA0KPiBXaGF0IGlzIHRoZSBr
ZXJuZWwgdmVyc2lvbiB5b3UgdXBkYXRlZCB0bz8gV2hpY2ggb25lIHlvdSBoYXZlIGJlZW4gdXNp
bmcNCj4gc28gZmFyPw0KPiANCj4gQXJlIHlvdSB1c2luZyBBbmRyb2lkIG9uIHlvdXIgZGV2aWNl
cz8gSSByZW1lbWJlciB0aGVyZSB3YXMgc29tZQ0KPiBmdW5jdGlvbmFsaXR5IGFkZGVkIHRvIGF2
b2lkIGphbmtzIGluIGRpc3BsYXkgcGlwZWxpbmUuDQoNClllcywgdGhpcyBpcyBBbmRyb2lkIGJ1
dCB3aXRoIHNjaGVkdWxlciB2ZW5kb3IgaG9va3Mgc3RyaXBwZWQsIHNvIGtlcm5lbCANCjYuNiBz
Y2hlZHV0aWwgd2l0aCBzb21lIEdLSSBwYXRjaGVzIG9uIHRvcC4gVGhlcmUgaXMgInNvbWV0aGlu
ZyB0byBhdm9pZCANCmphbmtzIiwgYnV0IHRvIG1ha2Ugc3VyZSB0aGUgcmVzdWx0cyBjYW4gYmUg
c2hhcmVkIHVwc3RyZWFtLCBzdWNoIA0KQW5kcm9pZCB0aGluZ3MgYXJlIGRpc2FibGVkLCBsZWF2
aW5nIGJhc2ljYWxseSB2YW5pbGxhIHNjaGVkdXRpbC4NCg0KPj4gcGlucG9pbnRlZCB0aGUgcmVn
cmVzc2lvbiB0byB0aGUgY3B1X3V0aWwoYm9vc3QpIGZlYXR1cmUuIEFmdGVyDQo+PiByZXZlcnRp
bmcgdGhlIGJvb3N0IGZlYXR1cmUgdGhlIG1hc3NpdmUgZW5lcmd5IHJlZ3Jlc3Npb24gaXMgZ29u
ZS4NCj4+IERldGFpbGVkIHRyYWNlIGFuYWx5c2lzIGRvd24gYmVsb3cuIFRoZSByZWdyZXNzaW9u
IGlzIGZvdW5kIGFjcm9zcyBxdWl0ZQ0KPj4gbWFueSBhcHBzIGJ1dCBZb3V0dWJlIGlzIG9uZSBv
ZiB0aGUgd29yc3Qgb2ZmZW5kZXJzLCBzaG93biBpbiB0aGUNCj4+IDEwODBwNjBmcHMgdmlkZW8g
YmVuY2htYXJrOg0KPj4NCj4+ICAgU2V0dXAgICAgICBGUFMgICBTb0MgUG93ZXIgKG1XKSAgZGlm
Zg0KPj4gdy8gIGJvb3N0ICA1OS45NCAgICAgIDkxMy42DQo+PiB3L28gYm9vc3QgIDU5LjkzICAg
ICAgNzIwLjQgICAgIC0yMS4xNSUNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIb25neWFuIFhpYSA8
aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiAtLS0NCj4+IEFuYWx5c2lzOg0KPiAN
Cj4gWy4uLl0NCj4gDQo+PiAyLiBVc2luZyB0aGUgYWJzb2x1dGUgdmFsdWUgb2YgcnVubmFibGVf
YXZnIHRvIGRyaXZlIGZyZXF1ZW5jeSBpcw0KPj4gICAgIHRvbyBoaWdoIHRvIGJlIHJlYXNvbmFi
bGU6DQo+Pg0KPj4gV2UgdXNlIHJ1bm5hYmxlIGluIGEgX3JlbGF0aXZlXyB3YXkgdG8gdXRpbCB0
byBrbm93IHdoZXRoZXIgdGhlcmUgaXMNCj4gDQo+IElzIHRoaXMgcGFydCBvZiB0aGUgdmFsdWUg
YWRkcyB5b3UgcHV0IG9uIHRvcCBvZiBtYWlubGluZSBrZXJuZWw/IEFyZQ0KPiB5b3UgYWJsZSB0
byBzaGFyZSB0aGlzIGhlcmU/DQoNCkJ5ICd3ZScgSSBtZWFuIHVwc3RyZWFtIHNjaGVkdXRpbCwg
bGlrZSB0aGUgY29tcGFyaXNvbiBpbiANCnV0aWxfZXN0X3VwZGF0ZSBiZXR3ZWVuIHV0aWwgYW5k
IHJ1bm5hYmxlIHRvIGtub3cgd2hldGhlciB0aGVyZSBpcyANCmNvbnRlbnRpb24uIFRoZSByZXN1
bHRzIEkgc2hhcmVkIGluIHRoaXMgdGhyZWFkIHdlcmUgYWx3YXlzIHJ1biBvbiBhIA0Kc2V0dXAg
dGhhdCBkb2Vzbid0IGluY2x1ZGUgb3VyIGludGVybmFsIHN0dWZmLg0KDQo+PiBjb250ZW50aW9u
IGluIHNldmVyYWwgcGxhY2VzLiBIb3dldmVyLCB0aGUgX2Fic29sdXRlXyB2YWx1ZSBzaG91bGQg
bm90DQo+PiBiZSB1c2VkIGxpa2UgdXRpbC4gUnVubmFibGVfYXZnIHRlbmRzIHRvIGJlIHNpZ25p
ZmljYW50bHkgaGlnaGVyLA0KPj4gbWFraW5nIGl0IG11Y2ggZWFzaWVyIHRvIHNhdHVyYXRlIGZy
ZXF1ZW5jeS4NCj4+DQo+PiBGb3IgZXhhbXBsZSwgaWYgdGhyZWUgdGFza3MgZWFjaCB3aXRoIGEg
dXRpbCBvZiAxMDAgY29udGVuZCBvbiB0aGUgc2FtZQ0KPj4gcnEsIHRoZSBycSB1dGlsIGlzIDMw
MCBidXQgcnVubmFibGVfYXZnIHNob290cyB1cCB0byA5MDAuIDkwMCBkcml2ZXMgdGhlDQo+PiBD
UFUgYXQgdGhlIG1heCBmcmVxdWVuY3ksIGFuZCBpdCdzIGhpZ2hseSBxdWVzdGlvbmFibGUgd2hl
dGhlciB0aGlzDQo+PiBib29zdCBpcyB0aGUgcmlnaHQgZGVjaXNpb24uDQo+IA0KPiBTaG91bGRu
J3QgdGhpcyBiZSBtYXggNjAwLCBpbiBjYXNlIHRoZSB0YXNrJ3MgcnVudGltZSBvdmVybGFwIHBl
cmZlY3RseT8NCj4gSW4gY2FzZSB0aGV5IGRvbid0IG92ZXJsYXAgYXQgYWxsIHJ1bm5hYmxlX2F2
ZyBzaG91bGQgYmUgdXRpbF9hdmcuIElzDQo+IHRoaXMgYSB0aGVvcmV0aWNhbCBleGFtcGxlIG9y
IHRha2VuIGZyb20geW91ciB0cmFjZXM/DQoNCllvdSBhcmUgcmlnaHQsIHRoZSBmaXJzdCB0YXNr
IHRoYXQgY29tcGxldGVzIG5vIGxvbmdlciBhY2N1bXVsYXRlcyANCnJ1bm5hYmxlX2F2Zywgc28g
dGhlIHJ1bm5hYmxlX2F2ZyBvZiB0aGUgdGhyZWUgdGFza3MgYXJlIDEwMCwgMjAwLCAzMDAsIA0K
c28gNjAwIGluIHRvdGFsLg0KDQpUaGlzIGlzIG9ubHkgYSB0aGVvcmV0aWNhbCBleGFtcGxlLCBh
bHRob3VnaCBpbiBhcHBzIGxpa2UgWW91dHViZSANCnBsYXliYWNrIHdlIGRvIHNlZSB0aGUgYXZl
cmFnZSBmcmVxdWVuY3kgaG92ZXJpbmcgYXJvdW5kIDEuNXggdy8gYm9vc3QgDQp0aGFuIHcvbyBi
b29zdCwgc28gaW4gcmVhbGl0eSB0aGVyZSBpcyBzdGlsbCBhIGJpZyBkaWZmZXJlbmNlLg0KDQo+
PiAzLiBSdW5uYWJsZV9hdmcgbWF5IG5vdCBldmVuIHJlZmxlY3QgdHJ1ZSBjb250ZW50aW9uOg0K
Pj4NCj4+IFdoZW4gdGFza3MgYXJlIGRlcGVuZGVudCwgdGhlIGJvdHRsZW5lY2sgaXMgb2Z0ZW4g
dGhlIGRhdGEgZmxvdyBiZXR3ZWVuDQo+PiB0YXNrcywgbm90IHRoZSBjb250ZW50aW9uIHNlZW4g
YnkgcnVubmFibGVfYXZnLiBCb29zdGluZyBmcmVxdWVuY3kgd2l0aA0KPj4gcnVubmFibGUgaW4g
c3VjaCBzY2VuYXJpb3Mgd2FzdGVzIHBvd2VyIHdpdGhvdXQgcGVyZm9ybWFuY2UgYmVuZWZpdHMu
DQo+IA0KPiBUaGF0J3MgcHJvYmFibHkgdHJ1ZS4gQnV0IGhlcmUgYW55IGdsb2JhbCBmZWF0dXJl
ICh3aGljaCBkb2Vzbid0IG5lZWQNCj4gcGVyLXRhc2sgc2V0dXApIHdvbid0IGJlIGFibGUgdG8g
Z2l2ZSBwZXJmZWN0IHJlc3VsdHMsIG9ubHkgcGVyLXRhc2sNCj4gc2V0dXAgY2FuIGZpeCB0aGlz
Lg0KDQpPdXIgb2JzZXJ2YXRpb24gc2VlbXMgdGhhdCBmZXcgdGFza3MgYmVuZWZpdCBhbmQgbW9z
dCBvZiBvdXIgd29ya2xvYWRzIA0Kc3VmZmVyIGZyb20gYSBiaWcgZW5lcmd5IHJlZ3Jlc3Npb24s
IHNvIHB1dHRpbmcgdGhpcyBmZWF0dXJlIG9uIHRoZSANCmdlbmVyaWMgcGF0aCBtaWdodCBub3Qg
YmUgdGhlIGJlc3QgdGhpbmcuDQoNCkNocmlzdGlhbiBkaWQgc3VnZ2VzdCBzb21lIGdhbWluZyBi
ZW5jaG1hcmtzLiBTYWRseSBvdXIgc2V0dXAgaGFzIGEgDQpjb21wbGV0ZWx5IGRpZmZlcmVudCBn
b3Zlcm5vciBmb3IgZ2FtaW5nLiBJIHdpbGwgdHJ5IHRvIHJpcCBvdXQgDQpldmVyeXRoaW5nIGFu
ZCBwdXQgZ2FtZXMgYmFjayBvbiB2YW5pbGxhIHNjaGVkdXRpbC4gSG9wZWZ1bGx5IEkgd2lsbCAN
CmNvbWUgYmFjayBzb29uIHdpdGggZ2FtaW5nIHJlc3VsdHMuDQo=
