Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14B3B0AE1;
	Tue, 21 Apr 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765556; cv=fail; b=LFTOyE9kEH+zEFj0gOUgO8DTJfYXxx9HQjcEzAdaeLaHVhy9XhYKoxS5beGIkNd4BvvuIoVx0uLPg4O7pbLTkZd93ZJyPf5Oz0D98YtP90owveSQ5kzyzQawQW6KjOjqOg/ev7xZSeKVBUUMo/e6hFgAPg27Oub0UbRftMqcNMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765556; c=relaxed/simple;
	bh=QGorCPcjKlE4IhqY5ryVvGzoDNAfj1qbm/FeSce6Boc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBckRnh34ctyuLylBZqoKG91qE1bXmujja6GAPAiYzHaQuMb1gYxVhIXC7V4VvleZEj5kKlFTDpq9pLgLrofpJaRXPozw+mGdq0OndpOiJtn6KdfEZDiCaPQ7G/3qIXycfCqMVt5225rzStD+jexgvziBEzOmm86DNt14DUPCZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xn/U0V9B; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xn/U0V9B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edq8lrLG4asvzXb19nZ9qSWeTP5g3omzS3EdQ4rcv4FfnvFT2Gc7i6bRbYXpXdXoW/rYnEEiO2Ldkzv/bv2segtvb0qXYD3EgpkjrCXbA1GJlayscA3EfJ+8ZezU0chc31JbbEyPSnwtkdBSwOto/vluMmuYOyc3mzvmhRcIcjzfTdb5bVtxQrSASJNqWwxoWPi9wARdjj8m/rMUPcLEn8Io3spZtnxEU1NnU7l5OGXz8i1vwqeq+n/TbTZ7v7/BrnrggriKJ63BDlzm5WkZewfiqNINxMhNAkGqLccemsroYhitrgYEnA6gfl04+JJxO68Hu2yAEMNZDzsjSllSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGorCPcjKlE4IhqY5ryVvGzoDNAfj1qbm/FeSce6Boc=;
 b=LbroFvmWOhYUhh7I77MHo6wCsCjMdcEyj9YIe7moyt8Qa1PAmpw2zTI7mbd4kYSTrAjaBRhYabmFi0Yp+UrniO81kMhFEbuJnC0nzM31zkn6tUiO87av3otzzzgboR5YhyicQwOtg6ovHedcG8MKaBrI9qf5yAy36uT6NJ4gYyydcTF71vJhgy5CKVngGfYXiPonfD/GtZrfwLG/icxj8XJb5aJ9a1RzfWFpuoIIWLGhmJgjJgZpDwywwfi+/IAnsagPOcUMaBPUK0nP4fTzXxj5OvpPkC1wWJTDTAgvLRAkVKKTnO2sB7BOciOA0+4WzZb26vCpE6+A2APcVtxNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGorCPcjKlE4IhqY5ryVvGzoDNAfj1qbm/FeSce6Boc=;
 b=Xn/U0V9B+ExdYR9EYZX1JhBrivNsYux9kK/TegpEUkf1EUlDQUzGSgNCMQtuNJLX5R+dbYa53sNYbIvA6WwtWtcU0SbXRH6gQR0iBSudAXunGTY+SUqRNSoyTb7zOFHNu39YCeFjVbQPgaRWnvlqytnuw/MBhe/uxPpUJ5IKeoOf6TsAbdCw9ec4WV7tVqTOKdy6TUvrNAd8SZOT5k2QOgWnjtRDKxMfFYGwqWE91RnsXOwz3nNunj+/e8Q42wRfb5zWf1483Hd2e3lpNuLqb0YuTfDB1xAxMGhzavedmfAKQewi7zJX2ebsdG0Qi14DCrzH+qGbsUyzv2feu9IpQQ==
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by AMBPR04MB11811.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 09:59:10 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:59:10 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH v5 2/4] thermal: qoriq: add i.MX93 tmu support
Thread-Topic: [PATCH v5 2/4] thermal: qoriq: add i.MX93 tmu support
Thread-Index: AQHc0WIVFO1HfoxvXkSUy3V2NeuxqbXpPLKAgAAKwtA=
Date: Tue, 21 Apr 2026 09:59:10 +0000
Message-ID:
 <VI1PR04MB686125B8BA37966E1603FF32872C2@VI1PR04MB6861.eurprd04.prod.outlook.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
 <20260421-imx93_tmu-v5-2-05ea1969bb9f@nxp.com>
 <2d1bbd53-1f03-4432-8681-939e0c638d37@oss.nxp.com>
In-Reply-To: <2d1bbd53-1f03-4432-8681-939e0c638d37@oss.nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6861:EE_|AMBPR04MB11811:EE_
x-ms-office365-filtering-correlation-id: e1b3e650-b952-4d27-0c04-08de9f8ca255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 UiGtddef4KnhDjzB5iRG8AuwpX2xSyrNJ024RCYR70zenZeMdKcnEXM5m1WkimPGFUkGHJy90nH3O5zcpmDzMi7rIeBrtfk/7eqfgFrhOIFE+sBvZe3PM/oXJEbvuKPo1SorO953TzBXDyh1icv28FhEC8ba0VJkiYGcL75A2ggkbtCsiYlWojKTO19U/H2HJQGzJz2+6fAkg58RhuS6AlHr2qBY4D1zp7WHWXD2P/hoWEiPD/nBrSwCXy08WODiPPWrn90aqdqdt6ny41XFqOoT2a73fvhTJsqMK9JMm1PW+vWc3N7aS+IdJjTVli9Wf5+bt67kNliZOVKeMslBMYDKQwwKWJ9qOqlDrA79K7fn7stZpRGAhFhCgWyQyTO7WrUs055tl5/DldnfHAK0VQLnEWswp5HBNpZ9pfKB2rYrt1eI/RnyXXskjMPXsJlRE9dDaEodi6Q3BFsZxv22jBzzHSY2rKb1fqHWJqfFJ8kHOU6MMQLQ5zw5z1VA71WuGJFp0/ydHxtwQryxchDv8O6z7qW7PMEqXmpikEw+Pa1iydr1ye0iPuXBisoYVjGqX/+Aa9PGGl+MenFR1IfHtH9tCj1WBcgkpb3KhyYq1WizfeTq5XJdBomdrI4t5rj+/vcbDeh76B15j1GfP+406KKLBa13CjViiobKr/H5F133/Hp8rNS2Pjzy1FVgklk3NhvQBTiBYptEuUJOMrgSleSZFyYXtQBVcZN+nI6MrgioM9WhJM+cpkHoIUGToO6zp6vqJe+1rTiWGgsWvPsmny/gZ9KVSlbf78++sMmM7o1Tbktjw/lAILuysFog/SWm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjI2cGFpUmRrVnd5QlhQeVNHU0NpVWlYb3BPLzdQV3llMjhXNm13cjRpNkpT?=
 =?utf-8?B?ZlNTYWx2M3Z3N1l0RWhrcUErdjFoSzNnTTRkMzhzbmxVZER5RDM2eFNDS3VD?=
 =?utf-8?B?ZzhyODBVS0g3ejFtd25lemFGZUoxekExcXhCZXJ4bjNyRmQ2Ykwwb2tNd054?=
 =?utf-8?B?b2pHaW1wblJCTFFlcnpmTWtOL0lTRG9HS2VHMWRSVWlGNW1ocCtqVUJnMTNm?=
 =?utf-8?B?aFJHMXdtaGR6emhlQnUwNUFrc052TXJDcnVLRVRzYTc5K0xGUEY5RzZMaTBY?=
 =?utf-8?B?YVY4VU9ZZGx3VGs4RGp4eGovNFZhclkvNFVNeFJYVnF1c0ZFR2REN1gwU1Vq?=
 =?utf-8?B?aks1YTRCakE0V3o4VUh4NkZGUWhBVThXNE9YdHdhWTZLSzc0Zzd4dFpYbDVF?=
 =?utf-8?B?S2FiM1dWcm1YK1IzVmhiRS9HSEFTRm5meG9tV2pLMEwrbDcybCtyMVFBR3BU?=
 =?utf-8?B?OUVOM0RnRlNLQi84a0dtMUlqNWhDZGZrU3VjUml6WXdwdzJvVW4yNzBwSDNu?=
 =?utf-8?B?RVVmZDVyQ29hY053MnE3YzRIakhHMGsxV0x6bTY2dG8xUEljUFh0Z0NGNmh5?=
 =?utf-8?B?ZFN3U1QvVFRKaEQvOGJacjczbEFRWG1pK0FkM0x5NmFNbXU0bkI4UVFUamxD?=
 =?utf-8?B?NVpYQ3pRSGhnWlR4VWxTM3ZCZHo0K09HMktia3pWWWlZOC9sM3Nqam1zQy9S?=
 =?utf-8?B?SmZHWmp3U2FQWDdCazhaRmYxazNGM05yZitYaTNjaVQvZUxGbldPUEZhY0o1?=
 =?utf-8?B?QkJibm9DUExDSWhZcWtjem82Nk1MeENCY3p6Q2dVQ1NDdytuZU1lblF6cjhD?=
 =?utf-8?B?VElaWXZIWVNlOGxWNGRUSHRGREgrY3ErbWFoODl0aVlmSnJldTlkbTlDaWMw?=
 =?utf-8?B?amw3dW9XUXIweEdOVUlXa1RsRDNQSmVRT2txdGVnVjh4cXpCTVZFN0RqWEJT?=
 =?utf-8?B?elMvTnhnVGs4d1N3dnBmN0hPdWtKVTRmZ21LeFBNNnE4ZVQzYzhWWUM5VE4y?=
 =?utf-8?B?U0RSUW1CeFg4NDk0QldxOFJKY05oa3dDSGtlR2sxS3R6STgyeWoyazN5TCt5?=
 =?utf-8?B?Y3lRTFBiT2FPcEN5VjBRR3EraHdDcDg1eER3MS9nUEdFRlJ1bVdhanlRcXJ1?=
 =?utf-8?B?aXhYWUozUGZYNi91QWxNZzJlenRDMlhmT0gyZkcvY0RNLzZXU0FLVzNoaGZQ?=
 =?utf-8?B?NUZxb3ZncVlGaFVBTzNLZmxlOXIzb1M3NFhmK0ZyZnptYjQzdEhqRm45eXk1?=
 =?utf-8?B?emFubmZERnZDUG4zc2k2VHZEcUYvcXNZTk13YWx6UXlwVlQ3S3gxaytpRHkr?=
 =?utf-8?B?WlA4NTJ0VFhIVDg4Z1VJd2Zib1phdFZNWkdvUTRYaEFDZkpPUWJmTHRDakNr?=
 =?utf-8?B?WmI0T1UzR2dqNjJRTG5KOFovOGxiWE9rSHYxVU5xNWl5MFRrR0d6bEVkR0FC?=
 =?utf-8?B?QVdVRHhQUmRwUVNPVzFMOTRwNXd0WjhCTkMzeGNQb2dwWWNVUFJPc3ZBdWdO?=
 =?utf-8?B?WDJHaVpZbC9ac2NNSjd6NG9ZY2M3UFJRUGZ1d3UxN3hlSUg3TXRwUjZYTk1O?=
 =?utf-8?B?dlVCMG5OV3NjOHpqd29mR3ZpZ3ZLVHZWWEM4QUZSaDN0TGZ1cUxTTXJsUGoy?=
 =?utf-8?B?L0trMmpCbGpjTXM5RTQ5S3YxRTRsOHJkQjZGYlBqN2NQKzdBNDhIMEhrWTJY?=
 =?utf-8?B?b0ZzSkNoR2lhcytoSWtSd0Rjd2Zmd2M1N2dXTE5FZTVGRjJtZEVXSFV1VXA2?=
 =?utf-8?B?VnJTR01BU2Y0MG9MYVR4ajZ6KzZSMCs1WXhYVXNMajBkTG1WdmZkOCtkYk5t?=
 =?utf-8?B?bFVacldTcUhNQ0wxVEM0RXVSeDZOTEg2TTFwcTIyZU1YUjFHQnVMTzN5L2Rh?=
 =?utf-8?B?bHBsOFM1ZnRlNERmdHJZN2tib1luZlkrb1hzREpzNXlYeGRianA5TTI4VW5F?=
 =?utf-8?B?NWRGa2x1UXhVSHF2ZXZBeTZ3Tm5MVkFJR2tjcE1IV1VHNDRJQy9NNFJ0dDJh?=
 =?utf-8?B?aFB1UXBLQ1BlSkErOVhoMGtvWm9pSVkwdFBlelJWVWNHK2JYUjVsU0R2bjJU?=
 =?utf-8?B?NWsrbGRydHNScVVDNXJka3ZoK1g2L2ZMNTRSM2ZWN3Vod1FtLytPSFRZSEVU?=
 =?utf-8?B?WE9DUnF0YUZxQldhNk50eThad3RucTAzeU8yMkxwR0JvOXhvbnNNMDR2KzI3?=
 =?utf-8?B?eWtyTFE2WHJ6eWhtSkgxajJNYVYzMlBmaERMeVRUS2gzS2FKakZybm0yMm5I?=
 =?utf-8?B?ZmhqMzhXT2t1cFl5SU9MaU9mUjNuZHM4V1o2M3NwMDF1TG0wWkF3KzZvTnNS?=
 =?utf-8?Q?9No+Hq+YIgJDaHVVC+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b3e650-b952-4d27-0c04-08de9f8ca255
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 09:59:10.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnkYIp4eW/YHc/kE2SPm/PKR/mf51AfYPIVvugC3LjiZgAsLOqoTZwc4/KIiX6XiH2PpsXNcU+O3mg2pZyjYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11811

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvNF0gdGhlcm1hbDogcW9yaXE6IGFkZCBpLk1YOTMg
dG11IHN1cHBvcnQNCj4gDQoNClsuLi5dDQoNCj4gPiAgc3RhdGljIHN0cnVjdCBxb3JpcV90bXVf
ZGF0YSAqcW9yaXFfc2Vuc29yX3RvX2RhdGEoc3RydWN0DQo+ID4gcW9yaXFfc2Vuc29yICpzKSBA
QCAtMjI1LDYgKzIzMiw4IEBAIHN0YXRpYyBpbnQNCj4gPiBxb3JpcV90bXVfY2FsaWJyYXRpb24o
c3RydWN0IGRldmljZSAqZGV2LA0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHFvcmlxX3RtdV9pbml0
X2RldmljZShzdHJ1Y3QgcW9yaXFfdG11X2RhdGEgKmRhdGEpICB7DQo+ID4gKwl1MzIgdGV1bXIw
X3ZhbDsNCj4gDQo+IE5vIG5lZWQgZm9yIHRoaXMgaGVyZSB5b3UgY2FuIGp1c3QgdXNlIGRpcmVj
dGx5OiBkYXRhLT5kcnZkYXRhLT50ZXVtcjANCj4gDQoNClRoeCwgd2lsbCByZXNvbHZlIGl0IGlu
IG5leHQgdmVyc2lvbi4NCg0KQlINCg0KPiA+ICsNCj4gPiAgCS8qIERpc2FibGUgaW50ZXJydXB0
LCB1c2luZyBwb2xsaW5nIGluc3RlYWQgKi8NCj4gPiAgCXJlZ21hcF93cml0ZShkYXRhLT5yZWdt
YXAsIFJFR1NfVElFUiwgVElFUl9ESVNBQkxFKTsNCj4gPg0KPiA+IEBAIC0yMzQsNyArMjQzLDgg
QEAgc3RhdGljIHZvaWQgcW9yaXFfdG11X2luaXRfZGV2aWNlKHN0cnVjdA0KPiBxb3JpcV90bXVf
ZGF0YSAqZGF0YSkNCj4gPiAgCQlyZWdtYXBfd3JpdGUoZGF0YS0+cmVnbWFwLCBSRUdTX1RNVE1J
UiwgVE1UTUlSX0RFRkFVTFQpOw0KPiA+ICAJfSBlbHNlIHsNCj4gPiAgCQlyZWdtYXBfd3JpdGUo
ZGF0YS0+cmVnbWFwLCBSRUdTX1YyX1RNVE1JUiwNCj4gVE1UTUlSX0RFRkFVTFQpOw0KPiA+IC0J
CXJlZ21hcF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR1NfVjJfVEVVTVIoMCksIFRFVU1SMF9WMik7
DQo+ID4gKwkJdGV1bXIwX3ZhbCA9IGRhdGEtPmRydmRhdGEtPnRldW1yMDsNCj4gPiArCQlyZWdt
YXBfd3JpdGUoZGF0YS0+cmVnbWFwLCBSRUdTX1YyX1RFVU1SKDApLCB0ZXVtcjBfdmFsKTsNCj4g
PiAgCX0NCj4gDQoNCg==
