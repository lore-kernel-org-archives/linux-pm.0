Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4345A28E;
	Wed, 23 Sep 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151694; cv=fail; b=pDm0E6RRFRYc0pTtRb5SXzPoYhaBUkGSdwcFPbRiu6ZyeAmVTN6zQ+yMT/v5LNoT8yai794P2MriUAmq64kuFHS/fgDLsZ+HqmUGyT1cO+fHusbZKsBZROhU2CIvGpWmcGy4vfldlO0AHZMbxUKVFSukh9kxGGTRHVD6neUFXwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151694; c=relaxed/simple;
	bh=DM8sN8PJXU8d/U29mr9f654cfqN1XrzpVl7onCgy8GQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+7h2r73qwmVr80kOucg7ssg18KwfM60Qvjior6LOvBCpyAeDTRuZdVonJKlkVtlpJYIvq/ywwrBApadrV8R9/Z7yaGHtM5W5b2tlp8AtzOyK/FeOOOX59j900FGTZm6FFWXsfqhFC7UUpc1vI30dEsWeDjOf82nHceEL+AH5jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sqvYLLmc; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sqvYLLmc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU3QZ8x/HKWVW3W1yeAwFzD3Z4/mV0dGz4YKUOna3bSaSRDh/6DauiEB27ngVzPKW5HrSFDL0OmzR9FCujGNqLyHNA68rnFeuvNQxHdPARLr4jsOZLPddu5HETuIOT+Xib0eTtPYGSOb58Gv60c37Vf9ikAZi7OJhcLI0vdFTOtg79pCx451m0FGWTInM6N+tXhGoGngMwaJj2+i3EtdYvF8j9qREpSp0h7AfHWkA2nnyGGJPBlfiB9Zx97CQNMWDfP+4CmJJeoszlTtpnBytasatHps2f556Klq04wqfwpClJAzAg9ca2tEh1hQxQOVUfDc6ZN1hrL0X3TrvB1uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM8sN8PJXU8d/U29mr9f654cfqN1XrzpVl7onCgy8GQ=;
 b=HwOWx0+2MJzGwSEDfta2J6cr7mBnzXJ4jnQq3lqX6R+b7sdNoS1oykDdYKKHVgmBTBodXlP0dwCPXWhE0visSo4pTfAqrHRxIlumwY0GCpqAr0OEv7ZiTtzSNovB0BwJSiwuBSy2+Y3dzg4BMAM39p0mwz2fkryknAMQtvPQt2xO1Vb3ZlYGRthkewzBY5B+1HLcugQUaloGCijRhMoeLTHcKpO1jMMe38HeX/0m9yvI63fPUhuF2aLVjjFCxP1Hg1eD+bP+T3GGtLYYtlZeICoEWJnayl7Lz3BeBxQlLjBhkkUZ+yjpwUlu9u/xOYCKOi5r3tYjfYtNd3CxZlbsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM8sN8PJXU8d/U29mr9f654cfqN1XrzpVl7onCgy8GQ=;
 b=sqvYLLmcIc+HbcZ3T/cOKU4vlzGXA9uMamEBFNlHMUWMs/cX2Xzg41PRdUHruBK07GffqclTtIp0pHrTsCEcPbPu9kmv448uGBP5HbHfWVGY0265U3rSbGqP2x9CT47pz+s7rwXPCRUItNcjHZ6SCJrQD8KMVpG1aCw67c5cK1g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB14933.jpnprd01.prod.outlook.com (2603:1096:604:3af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:21:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 08:21:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Thread-Topic: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Thread-Index: AQHdSkrL3beyFjHg4EWFvzMYrSXvXbbaqjCAgAEpnqA=
Date: Wed, 23 Sep 2026 08:21:29 +0000
Message-ID:
 <TY3PR01MB113468E77437603F4D230FD8386822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
 <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB14933:EE_
x-ms-office365-filtering-correlation-id: 41245119-81a4-4380-c44e-08df194bab51
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 b8HOTOf1PeCiqDw9iEFHw6fNmGjssxYEbvGlWVbtGmMlfJ1Cp5lO0Kc48P5Lln6eYSANfdw7BW7KMMwdBafsl1B0MFAONyO3RuK47n5NcoVnCchb5HswVNuYWWZV24VBEpmzGMxaBywWIDfrOusGo3/YYceMAWu6droIdVTkIYFvTsIxUeL1MK+Pusg0pfW90TgzuRM+EL+oJlOZBGQUGhJBRyCtQOZrxluglgBGnsOAE2sKbwBSIDnwk0kCzPXUA+2sztf34LRHvxC82iY6wjhsgPuOu9JLAta51rjMEVwyPRq2ehd/CyDkPfwGhxhjLDiC2EHVfOomfe+pXz9VzfjEna1L9HQzQhcsLi6t6QYGMO3XO7hXgJ47BwWWeFIRZkQpemc9XkEfuytFtdCcm0wrH3LxYxScuaNwXz1T2VHpEE0iIXHjNrx5lmwjS9Kzmyb20+LL6A1upOuv9nEwflYSFAqGjn0uQviXkIJ5CT+Qw5bfird1w8a7X0N+HfEXjpwQO5/Rjy3PiDV8Y+MDbYVAaRRUYUvkcidsqsXzSJTtuFky+0HXkqtMn0yjH4OU/EVwcL7wZ2hFwQf0ryloRT8Ky/q+GAtSuCxpBNC0siN0V6/OIGeF3jOvySRd+tA+J5RhEiAoyyYjkiezUdycOdrVngaqJ5i/WBQkgJs7igjLIPZOzzSGBGLzIseyibXdIiqTkf3iaJeVihxtcRIUIzAw197uqmxN5rPDmq011sU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlRnTEh6QUQ4VWVMb2dIV3g1TGw5Z3REcnVST3dCR1ozWDhuaXBTU0xHNmZv?=
 =?utf-8?B?NTJRVnJITWs1cDY0QXF1QzNVdGZnY1ljWUJGTmg3d3ZGQVlPV25Ka21QMUhP?=
 =?utf-8?B?VUZvRlNxZ3JKREZyMDlReTdSVWY0NUo0aUdxZnJkdVJ4UnEzM0Zjc25DZGVS?=
 =?utf-8?B?R0xEY0pwV0k2VjhoQU5BVXYrYjg1a016b0tVTXlhMEpGSmRpSk5yR0JWSVVi?=
 =?utf-8?B?alpOWTNUUjJ6R1d4dGYrdkNXZEFDZm9wVmxaRTJIZk9aNXpuSnNJTXhlQlJD?=
 =?utf-8?B?Um1rd2JHc2J1WEowY0NzWWk0bzc0bk1DNzV1ckdDYWZXR0huRlk1WVRpQnls?=
 =?utf-8?B?c1RpeVVkR1JwVTZwVUZxL2lzelVUQlZybTlJSlBPMlFXZWpVTnhZTnNIOEMz?=
 =?utf-8?B?b1lWVUY3MVc3ckZxU0VVdkhpZnh3b3p1Y3ZpWEpTOWdKQlhuT3lydHFIcFUr?=
 =?utf-8?B?SFMwcThRVDJTbWF0TEdQejNnZXJDSXdLaDNNUWt2QWNsT20zbmgraW5WeTlL?=
 =?utf-8?B?Q21PVGRmMXpURXFsV0tGY004Qyt6cWJoYzRGalZWbDhBY3FiWVgxbmxvWlgz?=
 =?utf-8?B?aExSSGxFY1RBL2lPeUhGV0xiSHhNNHpiZ2VEMFFwQWhWc3hDTGY0azRodWJr?=
 =?utf-8?B?d2FHUzlNdWFuY3FrdmZzWU5adThKT01MYnM4OFRtMXVaU2JncTFiSm5CbHMr?=
 =?utf-8?B?NEhxNWdZV3p3OXo0RUV6akdKc2Q0QTFvbTNzUU9VcXZUL0hwRmlTbXp4RWln?=
 =?utf-8?B?eUV3UHdDRHc1VHo3Qi9YZUgyYXhFQkswaVgzckxXQW1pTGUycEhudy80ZHpw?=
 =?utf-8?B?SEZtNkQ4T2EzY1Fnc2MyRFhhZDNpY1hsN3FabTZoRGVzQ3lXL3p3dEFiU3dl?=
 =?utf-8?B?OG8vaWt5R2V4WXZHR0t6eklDcVRiWjZLNmJzQmdYbWRHYW5hWDYzK09rUE1I?=
 =?utf-8?B?c1dRRnlUeE5RSm9Qa2ZpOVBEQnZuc1prMjdrbHlIckhNZ2VQL2NjUGs4NlJW?=
 =?utf-8?B?aHErcU52c2t1ZytXMWdZdlFuMUsyREovT0FMbWJKOUovZmsxRmJjSk91RUZN?=
 =?utf-8?B?Y2lwSy9aUjdUTTFWSUZzWGppR0pCT3g2R3U2bXREempQc1NzQ0lDcWV1RmpG?=
 =?utf-8?B?eXpqRTl2dHAzUHJ5OFVjdVY4RFhNaGdrL2YxalVWeUExc25IeWxadHo5MVho?=
 =?utf-8?B?VVJiR1FNT3NHbnlTdnBTSS8wZ0tSYTZhSit0K3h4ZEtsS2c5RFIySk0vWVpJ?=
 =?utf-8?B?RWlFTlBlYkd4MDBpZkV5eHNmeW8zUEhWL25KVGQwU0UxRHRVRVUwVVhzc3Rv?=
 =?utf-8?B?a1p0TVMvQ2Y3UnZFMFVpbUsrbXBwZnpFZjQxbW8wVHJzbzZTR3ByWWtKR3dX?=
 =?utf-8?B?QWFES0p0RE5zWTlFSmphbDBCZnI2RmVxYjhBbGhrUTU0bElvYloxSkpCYWVs?=
 =?utf-8?B?RWx3ZHlJaXlWTmdFR0VzQzNxR2tXYjJFaUlxamcxZ3I1QjZtdnc5aUFJaHRE?=
 =?utf-8?B?aDVHOXlpalJ0ZG5qVE5BTVgweHVZL2t2SHVrQW5oNFZ3QnFjQk1Qc25mUnZU?=
 =?utf-8?B?bnhPV0VnRDlwM0JXZEUraG9qL2ZQbTh6dEZKUGgwdUdkdVRmb0xSdnFmU0Zs?=
 =?utf-8?B?ZDZqZTdaSUZ0QkxTVXAxVGp1QU5DTE9ZYnc4S1VPQVFsQVlHTTJLODExdnJ3?=
 =?utf-8?B?QmdFb1JKRlRvRnNTWUxqZVFPSHoxV3I0WXg5S0R0TUpDc0I2QTFWQUZnTlpw?=
 =?utf-8?B?YXdWbWgwU3ppS1ZzU2trcHJUdWlaZ3cvcmMwYWpIU04zeVB2QjdxbmlVY3l5?=
 =?utf-8?B?dnQ3TUZDbWdaSURWNXVUR2ZML3hRcjZCeXRISS93QUJOTWJYTUZhVjJqTURG?=
 =?utf-8?B?ZDAwZkZQOFJMTm82UE1TNnJXa2h5MkI1dXg3cHNMcUVBUGw3RmI5Q25VT2RO?=
 =?utf-8?B?R1p0VkJkaGI3MGFJTndkWk4rWGwxcjdjK29vUWQ5dDJBYTlwdnFFOFg2MmlS?=
 =?utf-8?B?N0Jkd0J1dG4zR3pyd3JlVUlGbVE0RkRoZWtSVkRqTExoclRKRkk4WlpJWEhx?=
 =?utf-8?B?Qm10cXpMZHR0dWVLZDNVUFNuK3lpSmJQeUdtS3ZwWk9SOCt0SDBOZFJrYkZ5?=
 =?utf-8?B?V0pnVEloRW11eWovT0FiOXJhZ253cUo4bTlpYjRyZjc4QzBZODBnTE9WYVBH?=
 =?utf-8?B?czZaUERqYTQ0ZjhBcmFITEM3RFNwbE9ia0E4QUp3TU5qZytvV1hsZDZpYW04?=
 =?utf-8?B?VXJOMDl4SHpFb3c1TDgrRGJzVWxCWUFEeE5mcWQvdEFieVB0cmQ5VWNmTmFX?=
 =?utf-8?B?ZVFJOEtGaDlwM3k4Qm5VWE9Bc2o0ejVUeS96a0JRL1ExWXZGSXF2dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41245119-81a4-4380-c44e-08df194bab51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 08:21:29.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jP7Q7iaFaZ03Fe0DUPll2Mk2v/zFf3WgvY7wnMneHeCy2wujcgD/PTZZyk5PQUikwlOzUKY/KiFgB1aL+Xaitqb4LPuQPS4Q6JCB4cz5R3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14933

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDIyIFNlcHRlbWJlciAyMDI2IDE1OjM0DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgNi84XSBpaW86IGFkYzogcnpnMmxfYWRjOiBSZW5hbWUgbnVtX2NoYW5uZWxzIHRv
IG1heF9jaGFubmVscw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRj
aCENCj4gDQo+IE9uIFR1ZSwgMjIgU2VwdCAyMDI2IGF0IDA2OjI4LCBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFJlbmFtZSB0aGUgbnVtX2NoYW5uZWxz
IG1lbWJlciBvZiBzdHJ1Y3QgcnpnMmxfYWRjX2h3X3BhcmFtcyB0bw0KPiA+IG1heF9jaGFubmVs
cywgYXMgaXQgcmVwcmVzZW50cyB0aGUgbWF4aW11bSBjaGFubmVsIHN1cHBvcnRlZCBieQ0KPiAN
Cj4gLi4uIG1heGltdW0gbnVtYmVyIG9mIGNoYW5uZWxzLi4uDQoNCk9rLg0KDQo+IA0KPiAidGhl
IG1heGltdW0gY2hhbm5lbCIgKGFrYSBzaW5ndWxhciAibWF4X2NoYW5uZWwiKSB3b3VsZCBiZSBl
cXVhbCB0byB0aGUgbWF4aW11bSBudW1iZXIgb2YgY2hhbm5lbHMgbWludXMNCj4gb25lLg0KPiAN
Cj4gPiB0aGUgQURDIGhhcmR3YXJlIHJhdGhlciB0aGFuIGEgY291bnQgb2YgY2hhbm5lbHMgY3Vy
cmVudGx5IGluIHVzZS4NCj4gPg0KPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMNCj4gPiBAQCAtNjIsNyArNjIsNyBAQA0KPiA+
ICAgKiBAYWRzbXBfbWFzazogQURDIHNhbXBsaW5nIHBlcmlvZCBtYXNrIChzZWUgQURNMyByZWdp
c3RlcikNCj4gPiAgICogQGFkaW50X2ludGVuX21hc2s6IGNvbnZlcnNpb24gZW5kIGludGVycnVw
dCBtYXNrIChzZWUgQURJTlQgcmVnaXN0ZXIpDQo+ID4gICAqIEBkZWZhdWx0X2FkY21wOiBkZWZh
dWx0IEFEQyBjbXAgKHNlZSBBRE0zIHJlZ2lzdGVyKQ0KPiA+IC0gKiBAbnVtX2NoYW5uZWxzOiBu
dW1iZXIgb2Ygc3VwcG9ydGVkIGNoYW5uZWxzDQo+ID4gKyAqIEBtYXhfY2hhbm5lbHM6IHRoZSBt
YXhpbXVtIGNoYW5uZWwgZm9yIHRoZSBBREMNCj4gDQo+ICJtYXhpbXVtIG51bWJlciBvZiBjaGFu
bmVscyIsIHRvIGF2b2lkIGNvbmZ1c2lvbi4NCg0KQWdyZWVkLiBXaWxsIGZpeCB0aGlzIGluIG5l
eHQgdmVyc2lvbi4NCg0KQ2hlZXJzLA0KQmlqdQ0K
