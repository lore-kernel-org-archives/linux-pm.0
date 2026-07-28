Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3717BED0;
	Tue, 28 Jul 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249487; cv=fail; b=lOcs5Y4BMoPUl/iaRM+4I0drdV2SMLKJsxWLTfKn16uEJbDPu2rCCAhGUyt006GwpItwxNQ1UhtH8pz9US+gD5Yy3xHvBDRDa+vgrhP57aHz7CQmGlHazfloRvI7MpGl1nANDAFxdCcdzoQ02So2ga5HFIeKSr+WyFr9IgzWjks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249487; c=relaxed/simple;
	bh=nj7QcPDe+2stmnsNNipCsRJPiaemmgxtXVMR63EieX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pap8vB/VDhGgVxgswqRdsubwLdBVoBgfcEKr/JJBDZ0Z7VBD8Gf8Vtl+4WNVbk7D2n20n895zyWydDzXnZNdHzhiCt8ey9Z7srmAq47s1CF4TNRgmYvX4+OD4ix8OaE1YQblY5T/bhO5zEBmN4SNGbNNBIVD6Bqma0BDMW3VqNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TP4rMJRY; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TP4rMJRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph4XuG1+h93dc4DP2Dv+F2kK8w0L0muvMyDuFHEsdIbSlES5u0UE4Vb6gBxWLipPhD5wiVOiaWt2QMwgeeNSqEtqmaiABGjXXI6WBC5JLirE30KtJ2R00O3CN7TbmKZ5Wgrb7h4rEKMk/ByQnSk+oRIJK0moWM6B9/ffX8e2U3BGYMoyT8SAf9gX+6oCHrbK61JZNobzsBcnjS8yOdniYFHPIBpmrd8Pvd1Df8xA/MiJkAdeiIRWn8hb+GQfyr/PIxGckC8ujcY4mYpshzBOVeETkLNPc4h3FE6TdlEhTox0eluqJF4eRJHSTANUJl2hvG7QFmgbimC6aJVlawuOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj7QcPDe+2stmnsNNipCsRJPiaemmgxtXVMR63EieX8=;
 b=jMjgRG0Kv0KW6DoPb+X0F9emd/2C0wLBot3JuSl3Lvm/KHmOTZpAjSC1QxgCUzMBPsbG9HbOsRya7Z/x1pTH5KqoUvfpgskut+mOZ4OnmmBmqywkwXCA91Ce+wd5QXyQOLU9WBIvnrjJ6Tj+zqDKIXhF8+BEJ4MqCF7EMh3va92v7XPZrldAMAX9xt02T4G1kNe7WqdrGySKAbc8+P9MUCELQ0wV8iM6UqTrj4Y67oKrDGenFgUvRvQNNdTt2OElwGyjKoDBIdvb9e5b/CPh+di6WnFwnU3t/39mE1mv+31FQhaVdn7LmICAtCBT7+pUldwv358MHzM4RHZv8FUNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj7QcPDe+2stmnsNNipCsRJPiaemmgxtXVMR63EieX8=;
 b=TP4rMJRYzI14qrUt66luqoZiP+Nvsq1Xkvy6zIg+LAH0D8BUx1CNh8O4Ho7I/i1QBbVJQ0Q4YOjOAgzdeL00r8EzlgtNTWrwpnwj6df2/WHxpcFsq3CuP9xI2ubN8VnUK38MYkqTqO/JDV59EMA061vzaQjZ5X2p/9ogDl/woKg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11418.jpnprd01.prod.outlook.com (2603:1096:400:3b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 14:38:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 14:38:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, "magnus.damm" <magnus.damm@gmail.com>,
	"biju.das.au" <biju.das.au@gmail.com>
Subject: RE: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Topic: [PATCH 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Index:
 AQHdHDH4W+4o5eb24UWcXtW8HWrP97aComaAgAAFNDCAACosgIAABAbggAAqqoCAAADZcA==
Date: Tue, 28 Jul 2026 14:38:00 +0000
Message-ID:
 <TY3PR01MB113462C8DE3B70428F113ABF386CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
 <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
 <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
In-Reply-To:
 <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11418:EE_
x-ms-office365-filtering-correlation-id: ff69bc98-a9ed-47be-54ba-08deecb5d2ca
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rBiW4hYWHYQmJjnaNvWPHSir+b4T8Gm+pMmnqgwW+4of/lGHNRUL8t37o812B9NatpW/OuTdWEtzLBth0apxRMOwVcweUCmDp9wpkBtIV0r58LYSM3vpL0/5vd++DewMp78hDn9lEoJ/zjEFH58kJtfZy9i32UT9myf0j3Ohmq2KkJH1QDbdSXLHC/fRy2LCKSqK54rrVnNT6DCMWYAy8wzJqoq3nAY0y6tM49Dkm+8Ca6cAACUAKghjY7wCJn+U0Yy0NpfzP7Z7C4vidkrz/r1LA0aDRmXocSB5FxvsZmnlV0sZu90elw3lTeGD2s51XuCVGdvNehTYG/KtdIjenviXoFuC6hEyZsYVsjOlOW0mIydhzk+zdxdFcBXgejdvem7nJWOUIUMZEVgGxSjsIJL5gpXXOoGtxrGUzZtUq5Wo45Xr+YYl7XBdD8s+coJyQmU4jhbeJvX1bsPZqmvDr/in40QPi7+z8tCblD/SgB+8C3yPgFvgxCaQqBNSGNgc5njIp/BffXN0hOvcujJBcfF4KmF3QX1yuZZm6RJBvb724uIpyFwRdD1IvnsB8PWAjRuLP2mPhq8vk4AV+ixEc17gr5qa0Y1EcidF6eIInOlGhjLe2Tzsvy54TrxyvCGMPBCQDb8j7A0M0cHxvyzWZM/5YL4CEhi4qsXxB0/zea8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFBhWUJaWkVkR1E4dGxHbGxFM0dwYkZaZjZTWUdUTGFUM3RudkNQVzFpWXU3?=
 =?utf-8?B?UDVDRjJIWkJpMjlvUitWUFZUWkdvT1VUUEVIbE9wMlJWM0Z0TXR6RDRkQmcw?=
 =?utf-8?B?eHpIcnN5NFhLaFlGSDF1YUNCOWtCaFRsZmJtNkNNamlZUzRrMmQ5T1FZUjZy?=
 =?utf-8?B?RU5NRlZOU0Y5REtuNFRNcXB1M0lkazRnMVR4Nm1yTElmZDBTa1VQWkNFSUd5?=
 =?utf-8?B?em9jYlBxa2JPYkdxd3BwV1dxMDhxUmpCNldUSHhpbjBjSHRaSXozN3I4M3N4?=
 =?utf-8?B?QVA5WU5JVzdvbzVWaExvbFBaSGt2STJ1TWN0RUQrMmVxdG5IaG9KeWtIQnpK?=
 =?utf-8?B?UWJncmNBVW9Zbmw0QnN5bzVMR1NLV1dhYzZCYjQ4WmRxSUFnQ0xYUFBGWktn?=
 =?utf-8?B?aE04a2hKemIvYWhWVHJmRHFvOXN2bjZ4c1BNNTMzdlB1M0hKbHJWaUg1cm00?=
 =?utf-8?B?Ym5laXViRlI2TFFSdUJTaDhrTUFiTUsrZnM3VjBzOG5QOHhEcmZCNHl6ZWFp?=
 =?utf-8?B?KzdrVnBueXZjcVZSVnNZUmlaSmJleVY3UnhnTEFwMVoxY1ZoaHVIMEFpa2Yx?=
 =?utf-8?B?aElCTXBRNUY4TGdKNkZZZFdyM3krZHR0TmFYWFBldnJwZnlZMUNlYVdrM25I?=
 =?utf-8?B?cVJsK3NrQzd0V0JLV1E4UUFPTXZXQ0hHWHBkbmFnWnpvby9PY2FDMEljQlhD?=
 =?utf-8?B?TnlCdkJrOCtOUUZpR3RRZFA4dHJFRk12aTlzNWZkeG9nbXRTT1dVY3BqQlFQ?=
 =?utf-8?B?Q1JWUVE5alhEbW9KSTZsd2hVQjZHMVBtb3laZjAwMHQvUlJnVUJhVzF6WFpJ?=
 =?utf-8?B?Y0JiQkY2dHMydjRjL0NlK3Y5MGoxN01xSmZIcXNvUFd2RkR4ZkxwcSt2MjJv?=
 =?utf-8?B?ckptb3kra0lKNXJ0cUt1L0lBdGVIWXRTL1Fra0c5ME9neGswbzRycStYcm9y?=
 =?utf-8?B?TDd4YnAxZXNSaVZGN0c5bEY1OU05SnhwS01obUZMVmJITW1zOXB1SFlaNmdS?=
 =?utf-8?B?T0JsMDJ3aVk2djIyaXVTa1dyWEExbUZ5NHgwS3ZQYXlOYkJIN01GUXpBNjZL?=
 =?utf-8?B?YXVjMC9vQlpIcWJWR0U2aEl2azlua1dVcUlvNmNlR1NTVzVtMzNVUXZmVFln?=
 =?utf-8?B?Sm5LR0JnSmNaeGpSTDZobzdJVHJyakhMUFhBMFQxd211cWYxM1dUSmxBUkVD?=
 =?utf-8?B?N1VEd0srT0ExNkluR0tHOVYwZEZ3L1NGVzJPc2VGdkVKc1UwUzVMdGc5amRo?=
 =?utf-8?B?RGM5Y3ZOL3VqYkxSVUozTmRTKzRTVXdIb01lNEhRYU8xM1Y4N1l4WUxDcWpl?=
 =?utf-8?B?Y3FuMEFheUxoai8xZ2dMQm8vQWtRazhrRWNWWkFnM2xETXVXOHNVRDNDbWtJ?=
 =?utf-8?B?aHVrV3NNeXllRXVtM0ExbDZ5MW4zVnBXN0lJelFWcmxxNWp6RjUvQnVpNHkv?=
 =?utf-8?B?UUFGZmVxSHRXQjEzT2dvNTJGRVFGWFcrbndiY0hZMitXemRxanFYSGFLdkR5?=
 =?utf-8?B?d2lROWxsZXlCVDhCaWg1dGxGQmRhOHNFTUkzNTcrRlB4bVBuVUNmcHNLVzAw?=
 =?utf-8?B?akNPQjNIQzJCNjlRdUw2NFJNSkhxei92azdsY1p0UENuRVRLQllpUlNHaGNQ?=
 =?utf-8?B?NDdxNkd6bk0zOWxCQnVCaUprYVlkNjhvMGFEcUhmOXZ0UWxHZWdJc0l1bmVy?=
 =?utf-8?B?aEtQYXZKYmlMNkJlVmcwN2ZScmxFSHlQN205MVAzOG1EdmI1eVBlaUdNQXQ1?=
 =?utf-8?B?a0FWbGVRcGlFQko4SHlWSVhVUWZYUURQeHdJdWZseE4xTmdON08rckxaUjRw?=
 =?utf-8?B?K1I1VUVpaU1YM3JhQ0hXSmt5OGY3OTliWjhMcFFGV00rb2c5ZGd3TEcrN2dG?=
 =?utf-8?B?SU0zcExzZWJ5Tjc2RmhoeDFZRTFhMm1HS0dWZXllOGFVeTFlT2l1b2h1UVkz?=
 =?utf-8?B?U25OdzBRWjFRK0Ryd3FRcG9VMWZrNzUwZHh0cStPd3MzaVNpQ3JDYk5kK2Yv?=
 =?utf-8?B?eTZDSnBSU2RjVUdrWU1BV2ErSVhSMisvRjd1dTRvWHhVREdnVldqcjBQSTBC?=
 =?utf-8?B?WXRLMVVQU29RT1ZaNHRiZE01bWdadFMzcnBwMHovQmM2UHJNSVd6cTcvalZj?=
 =?utf-8?B?ZnZrb0Y3bjIwd3BOd2lpNTRyQ1pWZU90VnRXRkZBTjBCcEx4RUJzcFhNck4z?=
 =?utf-8?B?RUpJVnNhWnljMnoyMWx3SGRmcmVBcHd3Sm4xTFlhRGdCeHdMeGVVR3dhaEkw?=
 =?utf-8?B?dERsT3BuZW1ydHl2TDBQQWZ5M3dhWUpWOWc5UkwvaVRKbmJiTFdBWVlxUzJo?=
 =?utf-8?B?S1lIZmdveGFjTnpLSDA1Zjl5dzl4eHpma0MyTWV3UFE1cWY0MDg1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff69bc98-a9ed-47be-54ba-08deecb5d2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 14:38:00.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgK70kCLDF2U/tzBdvognMQWb0eJMXUDgwIzpGVFt/D5gpt/3D2vZPvluPAYjyVFul28Lu7GNeQq81bWJQP3UtpatXdRzdMPicTGa5nRxS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11418

SGkgQmFydG9zeiBHb2xhc3pld3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8
YnJnbEBrZXJuZWwub3JnPg0KPiBTZW50OiAyOCBKdWx5IDIwMjYgMTU6MjINCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzNdIHBvd2VyOiBzZXF1ZW5jaW5nOiBBZGQgUmVuZXNhcyBSWi9HM0wgUG93
ZXIgUmVhZHkgZHJpdmVyDQo+IA0KPiBPbiBUdWUsIDI4IEp1bCAyMDI2IDEzOjU1OjIyICswMjAw
LCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHNhaWQ6DQo+ID4gSGkgQmFy
dG9zeiBHb2xhc3pld3NraSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+DQo+ID4+IFNl
bnQ6IDI4IEp1bHkgMjAyNiAxMjozNQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gcG93
ZXI6IHNlcXVlbmNpbmc6IEFkZCBSZW5lc2FzIFJaL0czTCBQb3dlcg0KPiA+PiBSZWFkeSBkcml2
ZXINCj4gPj4NCj4gPj4gT24gVHVlLCAyOCBKdWwgMjAyNiAxMToxNzo1OCArMDIwMCwgQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiBzYWlkOg0KPiA+PiA+IEhpIEJhcnRvc3og
R29sYXN6ZXdza2ksDQo+ID4+ID4NCj4gPj4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4g
Pj4gPg0KPiA+Pg0KPiA+PiAuLi4NCj4gPj4NCj4gPj4gPj4gPiArDQo+ID4+ID4+ID4gK3N0YXRp
YyBpbnQgcHdyc2VxX3J6ZzNsX3B3cnJkeV9tYXRjaChzdHJ1Y3QgcHdyc2VxX2RldmljZSAqcHdy
c2VxLA0KPiA+PiA+PiA+ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+ID4+ID4g
K3sNCj4gPj4gPj4gPiArCXJldHVybiBQV1JTRVFfTUFUQ0hfT0s7DQo+ID4+ID4+DQo+ID4+ID4+
IFdoZW4gSSBzZWUgYW4gYWx3YXlzLXRydSBtYXRjaCgpIGNhbGxiYWNrLCBpdCBhbHdheXMgcmFp
c2VzIGFuIGFsYXJtIGJlbGwuDQo+ID4+ID4+IFR5cGljYWxseSwgSSdkIGV4cGVjdCB0aGVyZSB0
byBiZSBzb21lIHZhbGlkYXRpb24gb2YgdGhlIGNvbnN1bWVyIGhhcHBlbmluZy4NCj4gPj4gPj4N
Cj4gPj4gPj4gUGxlYXNlIGF0IGxlYXN0IHByb3ZpZGUgYW4gZXhwbGFuYXRpb24gb2Ygd2h5IGl0
J3Mgb2suDQo+ID4+ID4NCj4gPj4gPiBXaXRob3V0IHRoZSBtYXRjaCBmdW5jdGlvbiB0aGUgZHJp
dmVyIGlzIG5vdCBwcm9iaW5nLg0KPiA+PiA+DQo+ID4+DQo+ID4+IFllcywgdGhhdCdzIGV4cGVj
dGVkLg0KPiA+Pg0KPiA+PiA+IHN5c2MoZHJpdmVyKSAtPnBvd2Vyc2VxKGRyaXZlcikgLT57RFNJ
LENTSSxVU0J9KGRyaXZlcikgdGhlcmUgaXMgbm8NCj4gPj4gPiBwcm9wZXJ0eSB0aGF0IEkgY2Fu
IG1hdGNoIGhlcmUgYXMgdGhlIHJlc291cmNlIGlzIGEgcmVnaXN0ZXIgb24gdGhlDQo+ID4+ID4g
U1lTQyBJUCBhbmQgcG93ZXJzZXEgZHJpdmVyIGlzIGluc3RhbnRpYXRlZCBieSB0aGUgU1lTQyBk
cml2ZXIuDQo+ID4+ID4NCj4gPj4gPiBNYXliZSBJIGNhbiBwcm92aWRlIGEgY29tbWVudCBoZXJl
IHNheWluZyB0aGF0Pz8NCj4gPj4gPiAiTm8gRFQgcHJvcGVydHkgdG8gbWF0Y2ggaGVyZSwgc28g
aXQgaXMgT0sgYWx3YXlzIg0KPiA+PiA+DQo+ID4+DQo+ID4+IFNvIHRoZSBzeXNjIGlzIHRoZSBw
YXJlbnQgb2YgdGhlIHB3cnNlcSBwcm92aWRlciBhbmQgdGhlIENTSSwgRFNJIGFuZA0KPiA+PiBV
U0IgZHJpdmVycyBhcmUgdGhlIGNvbnN1bWVycyBvZiB0aGUgcHdyc2VxIGRlc2NyaXB0b3I/IFRo
ZSBsYXR0ZXINCj4gPj4gYXJlIGNoaWxkcmVuIG9mIHRoZSBwbGF0Zm9ybSBidXMsIGFtIEkgZ2V0
dGluZyB0aGlzIHJpZ2h0PyBDYW4geW91IHBvaW50IG1lIHRvIHRoZSBkZXZpY2UgdHJlZSB0aGF0
DQo+IGRlc2NyaWJlcyBpdD8NCj4gPg0KPiA+IFllcywNCj4gPg0KPiA+IFBsZWFzZSBzZWUgWzFd
LCBbMl0sIFszXQ0KPiA+DQo+ID4gWzFdIHN5c2Mgbm9kZQ0KPiA+DQo+ID4gWzJdIHBoeXJzdCBu
b2RlIChJIHBsYW5uZWQgdG8gcmVtb3ZlIHJlbmVzYXMsc3lzYy1wd3JyZHkgaW4gdGhlIG5leHQN
Cj4gPiB2ZXJzaW9uIGFzIGl0IGlzIGdvaW5nIHRvIHVzZSBwd3JzZXEpDQo+ID4NCj4gPiBbM10g
ZHNpIG5vZGUgKEkgcGxhbm5lZCB0byByZW1vdmUgcmVuZXNhcyxzeXNjLXB3cnJkeSBpbiB0aGUg
bmV4dA0KPiA+IHZlcnNpb24gYXMgaXQgaXMgZ29pbmcgdG8gdXNlIHB3cnNlcSkNCj4gPg0KPiA+
IFsxXQ0KPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L25leHQvbGludXgtbmV4dC5naXQvdHINCj4gPiBlZS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVz
YXMvcjlhMDhnMDQ2LmR0c2k/aD1uZXh0LTIwMjYwNzI3I242MDkNCj4gPg0KPiA+IFsyXQ0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWTNQUjAxTUIxMTM0NkZBMjFFRkFEQzhBM0Q1
M0Q4MUJFODZDRjJAVFkNCj4gPiAzUFIwMU1CMTEzNDYuanBucHJkMDEucHJvZC5vdXRsb29rLmNv
bS9ULyNtZjI0YWUxMzYzOTI1YTk3Yzg0MGIyNzVjMTA4DQo+ID4gYTliNzI5NDJjNDBiYw0KPiA+
DQo+ID4gWzNdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzA0MDkzNDMz
LjI3MzY3Mi0xLWJpanUuZGFzLmp6QGJwLnJlbg0KPiA+IGVzYXMuY29tL1QvI20zMWM2NzExYjU0
MDNjNWEzODdiMjI0NjdiYjg4MzcxZGY3M2FlMmIxDQo+ID4NCj4gPg0KPiA+IENoZWVycywNCj4g
PiBCaWp1DQo+ID4NCj4gDQo+IFRoZW4gaXQgc2VlbXMgeW91IGhhdmUgYSBwaGFuZGxlIGZyb20g
dGhlIERTSSBub2RlIHRvIHRoZSBzeXNjIG5vZGU6DQo+IA0KPiByZW5lc2FzLHN5c2MtcHdycmR5
ID0gPCZzeXNjIDB4ZDcwIDB4Mj47DQoNCkJ1dCB0aGlzIGlzIG5vIG1vcmUgcmVxdWlyZWQgYWZ0
ZXIgbW9kZWxsaW5nIHRoZSBwd3JyZHkgc2lnbmFsIGFzIHBvd2Vyc2VxIGRyaXZlci4NCg0KPiAN
Cj4gSW4gbWF0Y2goKSB5b3UgY2FuIGNoZWNrIGlmIHRoYXQgcGhhbmRsZSBsZWFkcyB0byB0aGUg
c3lzYyBkZXZpY2Ugd2hvJ3MgdGhlIHBhcmVudCBvZiB0aGUgcG93ZXIgc2VxdWVuY2VyDQo+IGRl
dmljZSBhbmQgcmV0dXJuIE1BVENIX09LIGlmIGl0IGlzLg0KDQpBcyBwZXIgdGhlIERUIG1haW50
YWluZXIgS3J6eXN6dG9mIEtvemxvd3NraSwgd2Ugc2hvdWxkIG5vdCB1c2UgcmFuZG9tIHBoYW5k
bGVzIGZvciBwd3JyZHkgc2lnbmFsLg0KDQpBbHNvLCBJIGNvbmZpcm0gdGhhdCB0aGlzIHByb3Bl
cnR5IGlzIHVubmVjZXNzYXJ5IGlmIHdlIG1vZGVsIGl0IGFzIFBvd2VyIHNlcXVlbmNlci4NCg0K
RnJvbSBBQkksIHBvaW50IG5vdyBvbmx5IG1hdHRlcnMgaXMgdGhlIHB3cnNlcV90YXJnZXRfZGF0
YS5uYW1lIGluIHRoZSBwb3dlciBzZXF1ZW5jZSBkcml2ZXIgYW5kDQpjb25zdW1lcnMuDQoNCmRz
aS0+cHdyc2VxID0gZGV2bV9wd3JzZXFfZ2V0KGRzaS0+ZGV2LCAiZHNpLXB3cnJkeSIpOw0KcHJp
di0+cHdyc2VxID0gZGV2bV9wd3JzZXFfZ2V0KGRldiwgInVzYi1wd3JyZHkiKTsNCg0KRnJvbSB0
aGUgZXhwZXJpZW5jZSwgSSBkb24ndCB0aGluaywgRFQgbWFpbnRhaW5lcnMgd2lsbCBhbGxvdw0K
dG8gZGVmaW5lIGEgdmVuZG9yIHByb3BlcnR5IGp1c3QgZm9yIHRoZSBkcml2ZXIgbWF0Y2guDQoN
CkNoZWVycywNCkJpanUNCg==
