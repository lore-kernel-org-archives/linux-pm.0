Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010005.outbound.protection.outlook.com [52.101.228.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC64E1C7D;
	Thu, 17 Sep 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650812; cv=fail; b=bUWaCDsRomQSp4HxZkZMlAxp4vMYsfZ/f48UCKG3ukV6XvAyJptvQ2BJW+qUrDvAEs+SzMoFOhQkyGmeUHguZW0RMvw5RUGnMP/icWI8Pc2Nnm1xK2fEPQ5r8IC6HZrDbLqi1O46DYPvzqqw0T7ipF9FlfLc2+pCK9ldiPIjQ3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650812; c=relaxed/simple;
	bh=XSsO3tjWUi0AuQqg8K6zGjp289ECzDScLESES1yMaiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TpkD03ZAC3yHRWszNs/O/Zi1nC/lbjplo6shryNMRk/wqsfBr1YS/vGOEmMxRoeT92CmC+9hJBKd4UWgYkDobigu3rTrFkFsWrUrT9n4ReMeRj6YmIccGlJjFqbd9JHIuu0t4N7xUJR5scFZ4Szl2W/oixYJOiz6wdrTnfqbnDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=j90XVMlR; arc=fail smtp.client-ip=52.101.228.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="j90XVMlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwOvf8YH4EizU3kq1ojPONFovKf82qqJ8lgokWvwJkCaWRAMA/Y7A7nDGAgGYnZxEVzOdK2vseGU/OTEzKnpbSAK4ogNUG4TsDFdhbkh6TOBS+mChHzQvIbsBBkAAXyU7k//1J4jLQXXKH+rFvsndN3YPA+5pKJskner1ey/s/DaNVLEfT6HCjocoXVSkDyDcHBt14n7bvlTXs6U6MNB+ZZ9EQJFpTOxakV3TMhE2Cz2pW9XTQWJ+qH355n6xSU1t619zBW/Z4e7+v805x+Yg9ogotHuddm9V3twDy1ZmoOmqRYjBcVRUkeHByu5RfQcUjqoci3wBiv8kITMANMyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSsO3tjWUi0AuQqg8K6zGjp289ECzDScLESES1yMaiU=;
 b=l9EQ4BCgK38qf1W99dt+pLqBWakqxOSl1OGbnklH7q3P3YiNTzif4wGVLKg+q2wb3kjToSQQTE9bJ+jttt9wTTHBjGE621eo6zi8OJ9boXqH+OdudIa8Ne8/jhhdNA+0NOdEGhh5HnExxoOrB/SgtLG0UX/uxM2OOY+vlCMgM9NuzVkrZrmaZbrpH6Ak6GKvLibb2RQw0xF92ma2/HyFduiqoY77MrllrkDSRmTg7MijjxJL87voZQwe9U2i2FvSSpm6BbBf3uO+GsJMOcL/gGupGnTMN7aG4U1/AEZ7/QPlWT9EeYzAgOlKHL6Nl/O8N+FNLzJId/k3LPAU7+75Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSsO3tjWUi0AuQqg8K6zGjp289ECzDScLESES1yMaiU=;
 b=j90XVMlRRjkSKyRFLdT0dkg4xac3HpDZC/LMSIULO/MXmiYeajwMqUb7hV4yCe2PczSfFnSOLibELSSMGNPoWWCJPTRWJrnLUFqqFY6DKdkrdy2Wd5WODWnYY3bYGKjWy8CTOrxa92miiH0mvfbOjLDlCFRjgGRDtH2b1Fhc+UI=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TYWPR01MB10347.jpnprd01.prod.outlook.com (2603:1096:400:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 13:13:28 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:13:28 +0000
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: geert <geert@linux-m68k.org>
CC: "magnus.damm" <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock
 definitions
Thread-Topic: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock
 definitions
Thread-Index: AQHdMX6JOUF0xlBbdUCrikilGbQwXba+nMeAgBRL46A=
Date: Thu, 17 Sep 2026 13:13:28 +0000
Message-ID:
 <TYCPR01MB118656AAFD5E9D035EF7D3E1BA2B82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-7-ayman.chaudhry.kc@renesas.com>
 <CAMuHMdWOLRH5CWwUBkb6odaX=4t6eDnd4onrkgGfvwgPc37i_w@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWOLRH5CWwUBkb6odaX=4t6eDnd4onrkgGfvwgPc37i_w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TYWPR01MB10347:EE_
x-ms-office365-filtering-correlation-id: 5217e563-16f0-4811-ed2d-08df14bd76ac
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006|38070700021|3023799007|4143699003;
x-microsoft-antispam-message-info:
 UwhzBKoc8CoqwwvL+IafVaVYi3CZJxExhb+avgTYSPhjd8ZP4Wgo73WrrMqh36pNE+Zw8Xq31Kjl16BoDbe/P6//xOkrTC6tpTh2wwP3/ve3ZhfoJzosKxiQTcjNRYwFnaSOIfUwXRfO5VyweOMZ0Cnk4XYJK7W9N94Ruu6nxS9/DrRse+UAZyWUv2IB85j+ExYNVNL8jbYVBCkOIv3Y9P1h8z6OrwMzMFjdzCor+dfHi2J8JAkIw3NopiClAK+DYlz8EITBONvCn6EDWML9BiOc596MrUzFCOlD8e97wuTDWLSy2XMYw5lPyFv96sZBMLBUpHid0VYM3iv3479JrbpF/zUhNo26HM31d2N+oXOaomQz0rJE37/Bm+idRb0XHvIhg04g2+syQkzgQBw4jE07dybShtghBHVq4ZB0tODqaNOXpwqJftDxJPD2E7Ipw6cnMSX+XzltaedpmEKnOZP5L/26YITXl4tSexb+Aw2ec+uEEra5GrfSZAmi3wFQe1t71HoiSDBIH+P2pHmOnWSozzjKk4ywmp6m+2SZhoLuWGC0iFlSeMuhToztRhXCtCJngCEGmcHkyqkT/sasftiNUVGVeXyS0uXFiyIhuhCiOYrXuALyFwjK9lMFNDRD6CaUxTQwzaHPkNol4uOxmMO8CeN/mQWr/XaFJVlPKol9PEJbbLJaTAR1kXAZ6+HawrN24nLkMoOnhdrp/NTqPg7EpA7EfJMGg58KrRup+t8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006)(38070700021)(3023799007)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGVuVHg2bGt5QUQ4ZS9ZWHlNVi9UUGx2N2lkcnk0bGhsWGwrajlIdlptaTVL?=
 =?utf-8?B?ME9DLzB6cVBnbmNvZTY0M21naGxBR1NhTW8wNWdMM0dUVUxKd1BBa0xnQ0lM?=
 =?utf-8?B?MXdMTGRHM2tYNjlzOU1LYWtTRnRkamFYek9vamUrY3V3N08zOUh0dHlXeGJM?=
 =?utf-8?B?U0FwajF3WjNLc1VHMXVpTUVBNjBmUGZHeU45azRmRVA0MmQ3N1JwanpvR0Vp?=
 =?utf-8?B?aUI4M0tYV3ZZT2hZNDA2cjlwRjhDU0ZLSmF2aTZBSTBLbGFSTUlVMzVLYWFk?=
 =?utf-8?B?clpleWNaVW9ZaGtETlJsdm9ITXF1TG42WlJrN0FzMTZLRXFIY2VuRG9mMC9K?=
 =?utf-8?B?UEE2b1hNVU1QTVlyTFdqRmEyYS9vL2tzbE1jaDVoMU5XYm5wN2ZOaGlrZVN4?=
 =?utf-8?B?NWwvTUlQcGdLdDlzSUFEcTFlRFBreXliWkV2L3l1WThKdnJDenpONkdSSTE1?=
 =?utf-8?B?NG9WTFZzOC92dnVXSUo4NGFNcjU5N1NiTHVFWjlGZ0NVeGNYVDlQeGxGNTE1?=
 =?utf-8?B?R1lUMlpLL1NEOE9yRFpqeFZGSDBOajhoTVpUSTR0V1JVdmRrWkRCcGtnVGdK?=
 =?utf-8?B?Q0JncjJXNmhKNWxqVTNqaExLUnF4UlVSRW1GaUFISHY0aTRjMFNOTGtZMUxF?=
 =?utf-8?B?RGNOd0pUZmUvZkdUWWpNODlXRERiNWV6cmJLcEZpSW1yYTNEeXBUL1Z5QmJ1?=
 =?utf-8?B?RVBpUER5SGxTSGUrd20rSXlpMmYrVGNsYkNQSDFoOG45azRiZEVPSlVrNnVN?=
 =?utf-8?B?dmhTWVVLQVB2L1J0ZmZ3QndENkVNV3kvVjBxR2czRWxjY25xd2RCZzFTTEtM?=
 =?utf-8?B?Qjd3b0M3dVVLa2xoSFhQSi80M3hQMjg0aEJnV1RhVTZyblpOeHEwOG5Cc1V3?=
 =?utf-8?B?MzJzWFc0blI1RU5YNVNQRDhIMGFrOElyUmtXSkgyRHVKWXFPditkekJlbjc1?=
 =?utf-8?B?TzVIVUtQcUJuQ0NVWjNtQzREZHVteHV2aDFWeWZLdm96M3BjZ3dpVk5MWVRr?=
 =?utf-8?B?MEdkTk4vNTdKTWFYbzhxbEs3VklMRTE3cis5NmxjZFZkRCtGWjZ4RU5PV2Fh?=
 =?utf-8?B?eEx2UUErUFQvZnZBSW1GUmZidnQvTnJ3enQwTm5FdTdIdEVVNlhXTFAvRjQr?=
 =?utf-8?B?K2s4VmJFZHdBaUlUMXF1SGRkSThlczNqU0FwUUdCNVE5N3czeTUxc01ZbmlM?=
 =?utf-8?B?a1h1eUVSVEhodkdxVDRzNDFmSkNyMGJVUXcwUHJkUEpDQ3k0Qzc0c1pvNm9u?=
 =?utf-8?B?c1RtU0JPcE5SZDhibGlidFdwVXpoeFNlQ0oyLytqcWVSeWNvSU00OWF2OG1I?=
 =?utf-8?B?ZHpUc3pHd3Bqbm9XRHlucUZ5U1hxNEtwUTUvWWt4VzVpdGtrYVR4L0t5VEUr?=
 =?utf-8?B?cnhja0FHcVRqN2tjRGJ0Z21IVlRTNlNKMTlMaXRuejlyUmxvQnVzUnp6dXZG?=
 =?utf-8?B?VTN0QzBobVNtang5NWlsd2lWcnN1RmFaK0NTRTJKdGFpV3JydzNGVE9OcDB6?=
 =?utf-8?B?N3p2Z3N4ZnowNVQrd0VNRHgxZFdDY2xsR1ZERVZnNW1TUGVoUThKT1NQOHBo?=
 =?utf-8?B?SkhhMXVGeVplNlMxN2lYVW1ySjY3T3p0OGZKUW1aeGhKeU80S3BZcEdUMlZs?=
 =?utf-8?B?M1NLNWlOM3hnaTROU2loMFZ3OFdPenE2Z3VGZlFsMHdabW1vV1dTNlhTZUhn?=
 =?utf-8?B?TENDSkg1aDZJeDV4bm1ENVp0YVZzYWdPZENpbGZGalN5NkNWUHkxR3kyKzVq?=
 =?utf-8?B?QU1GSmNSVVBiY2grR1RjT2swbDk0K0s5Q2NsZkxSak1hQVZNaUxzMmd0UFdw?=
 =?utf-8?B?bWVFYlJmZm5RUklyMDJXQVlyRjZiOFpCMnNRUlQyQXk3S0VBeExQOTltb3F3?=
 =?utf-8?B?dXdrcWp6QjZhVE9VNnA0amNuMTNrS1pDQVNScmhoQWJzcHlBUWl3dmlkaHk5?=
 =?utf-8?B?N2ZZaDE2a1oxR21wTEw2aHdoT3Z6cmVQa2NjbkVoSHlWWDVGazZXbXhZTDg3?=
 =?utf-8?B?c2JZU3YwbGRrK1d1TXB2dDA5U29EUU5YaFdXQUVaY2xMZGtQMXhET0xhSlVy?=
 =?utf-8?B?OWprY2ZpcnhzN3FIb0JkNWozTnhYNURoekh0ZDF4cVBNa2lOSS9Uamw0czZq?=
 =?utf-8?B?YllLNk13VVY2alB0Mm82NWJnWEVnVnVHL3ptbEt5ckJpUWVjM0plZjBqNWdw?=
 =?utf-8?B?cVRkZ1JEQnV5MmRlNUJGK2gvbGt3VG1ZUCt6UWRXNFJoV3k5U0ZmNTVJU25O?=
 =?utf-8?B?NGVXcmFaSXdJZ3NjOE56QjZVaE9FSE1uUXc0aStwWVJSRkxTa2ZsRENsNGhj?=
 =?utf-8?B?cDlqMS9WVklqRzFlU3hRaGNwcUJSNzJtNjBLcEl0S1BiZjZSRklKWTB1MTZm?=
 =?utf-8?Q?AITT4B0qf08J0cnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5217e563-16f0-4811-ed2d-08df14bd76ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:13:28.1758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXPUhPnDrb3BxfNiX1kbMxtwqWrMlnWeY1/vvscB1p2rlVPkv7QWAR6BFqQjsBA+eVGccLBdD2/h/RPzzLeshE1FUDQ1pXPvePQ7UR1IK/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10347

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gRnJvbTogR2VlcnQgVXl0
dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1i
ZXIgNCwgMjAyNiA0OjEzIFBNDQo+IFRvOiBBeW1hbiBDaGF1ZGhyeSA8YXltYW4uY2hhdWRocnku
a2NAcmVuZXNhcy5jb20+DQo+IENjOiBtYWdudXMuZGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29t
PjsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kg
PGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9y
Zz47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IEJyaWFuIE1hc25leQ0KPiA8Ym1h
c25leStjbGtAcmVkaGF0LmNvbT47IEplcm9tZSBCcnVuZXQgPGpicnVuZXQrY2xrQGJheWxpYnJl
LmNvbT47DQo+IFVsZiBIYW5zc29uIDx1bGZoQGtlcm5lbC5vcmc+OyBsaW51eC1yZW5lc2FzLXNv
Y0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnOyBDaHJpcyBQYXRlcnNvbg0KPiA8Q2hyaXMuUGF0ZXJzb24y
QHJlbmVzYXMuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsNCj4g
RmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+OyBQcmFiaGFr
YXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNi8xMF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQg
cjhhNzc0YTMgQ1BHIENvcmUgQ2xvY2sNCj4gZGVmaW5pdGlvbnMNCj4gDQo+IEhpIEF5bWFuLA0K
PiANCj4gT24gRnJpLCAyMSBBdWcgMjAyNiBhdCAxNzowNSwgQXltYW4gQ2hhdWRocnkNCj4gPGF5
bWFuLmNoYXVkaHJ5LmtjQHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBBZGQgYWxsIHRoZSBSZW5l
c2FzIFJaL0cyTSB2My4wIChhLmsuYS4gUjhBNzc0QTMpIFNvQyBDbG9jayBQdWxzZQ0KPiA+IEdl
bmVyYXRvciBDb3JlIENsb2NrIE91dHB1dHMsIGFzIGxpc3RlZCBpbiBUYWJsZSAxMS4zICgiTGlz
dCBvZiBDbG9ja3MNCj4gPiBbUlovRzJNIFYxLjMsIFJaL0cyTSBWMy4wXSIpIG9mIHRoZSBSWi9H
MiBIYXJkd2FyZSBVc2VyJ3MgTWFudWFsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXltYW4g
Q2hhdWRocnkgPGF5bWFuLmNoYXVkaHJ5LmtjQHJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZv
ciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9yOGE3NzRhMy1jcGctbXNzci5oDQo+IA0KPiBNaXNzaW5nICJyZW5l
c2FzLCIgdmVuZG9yIHByZWZpeC4NCg0KQWdyZWVkLCBJIHdpbGwgcmVuYW1lIHRoaXMgaW4gdjIu
DQoNCj4gDQo+ID4gQEAgLTAsMCArMSw1OSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpICovDQo+ID4gKy8qDQo+ID4gKyAq
IENvcHlyaWdodCAoQykgMjAyNiBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnAuDQo+ID4gKyAqLw0K
PiA+ICsjaWZuZGVmIF9fRFRfQklORElOR1NfQ0xPQ0tfUjhBNzc0QTNfQ1BHX01TU1JfSF9fDQo+
ID4gKyNkZWZpbmUgX19EVF9CSU5ESU5HU19DTE9DS19SOEE3NzRBM19DUEdfTVNTUl9IX18NCj4g
DQo+IE1pc3NpbmcgIlJFTkVTQVNfIiB2ZW5kb3IgcHJlZml4Lg0KDQpBZ3JlZWQsIEkgd2lsbCBh
ZGQgdGhpcyBpbiB2Mi4NCg0KS2luZCBSZWdhcmRzLA0KQXltYW4NCg0KPiANCj4gRm9yIHRoZSBj
b250ZW50czoNCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNh
c0BnbGlkZXIuYmU+DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhl
cmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9y
Zw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUs
IEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJu
YWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
