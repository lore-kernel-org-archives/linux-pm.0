Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010062.outbound.protection.outlook.com [52.101.228.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475C47F773;
	Fri, 18 Sep 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732051; cv=fail; b=RmVC+YexC3o6mz9sl+V+uT/4GSMi8+GswwXJV7DaksZvhfajEUzyry4YxMcQpbrNayKWdueKhJugydZ9TPzyfhAMM5LFy/tJ7K1ND9s6EmiusHsnLpKUeXBdUUhpQwFw2JqBivJyKT2j036TOZ2cssrCIfN2J4k7o2s0cLPynEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732051; c=relaxed/simple;
	bh=AJBVyKydl4avZlT1RUy7wmn+wYiZxH8gZLF12H6jiyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V3sqYM2Q6y/svrzpvagCcXW0/xsTjrBSNkuHql/6QGDBYAe2VXu8aIOGbr4wYXZjrYLxQpi3eRWTf4om2BLpvjjNY5yT+OdoJiZUX50honNUba6TMCq1UTJe5y7j1iMjhr5PQOOmKpNai0mOzw1+rJDUGyIyveq3qTXB1H/ZRHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NdLY99H4; arc=fail smtp.client-ip=52.101.228.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NdLY99H4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHJGw3Y5JceUrUgpO2HvG9oB3JmDTUc3NcDC+SEE8lc1easZAkifMQmPQx2qR1gdiVEjE22xYgjLY+Kc8K2bRHhr9RCEzY16FeoRJANY9h9Ld/bPHhoxKj3DXFy4hOgaaTF2ej9pnEWfxb6jhYdifN9iTfin1TMaHTkuX4E+Y/TQL205ON5+IMEcBhMZTY3JKjofc3qXUGgiDto7nO8y+F3C1HXlN+iNvAMoEfDIlpnFqRWvBE/egrbpy642oC2md9sFoyqeTSksitPhNmgnGoWv17cOD4vgeTAP717cj8OICJloUbzRuQw6KHMyuOYYCSoflj1cn7XjAx+TNJvILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJBVyKydl4avZlT1RUy7wmn+wYiZxH8gZLF12H6jiyg=;
 b=zJZS94w6UqHjrs+j+zCEDg20PvhZSuKHC8wINpDYBKayHKxLD/SIQLIqu94ubzX/RwjeqGKM5Tljtv+ApAqfhb0rrv+IqlUlalIrWTwyMmD4wDWCFNw3sO4HHBc9zYWKvPyhQZqtHcr5lj9e0KxWpRQkKJNDcSqRGtQ3Zs78U1yHk1elJ5dcCqIio2DZLDI5O7REQjIdv3wj1L9ignQKYhl/erfAYaqRWS1WmxqXNi3VJLVKfFrBTkFBpuaKlggJPapMa2UqwWf5peXRPXSP7UVHS8d68ocLzw6pBzeoTf/Fsmor1wrkzKkR+iQ1FbFomNgN1GhvdigUWKfGSkd9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJBVyKydl4avZlT1RUy7wmn+wYiZxH8gZLF12H6jiyg=;
 b=NdLY99H4H1ocJnMJBY1+0ysK2qiT7i4md3vH26RRIOvItJ2Xh8LD2/hD3sNCK0m9aVEvWC4ZiMIaJzDYq4eVPJKmQvqbH2kpS9y9Oxu/ZWT3p7qYBmzGeOqAuTbc22ma4c7lgbQlkKtdMIM1iXQfiiVXshx3ijiYg2HEFXHViw0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10660.jpnprd01.prod.outlook.com (2603:1096:400:2a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:47:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:47:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "laurent.pinchart" <laurent.pinchart@ideasonboard.com>
CC: Paul Elder <paul.elder+renesas@ideasonboard.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
	<bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, Ulf
 Hansson <ulfh@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [PATCH 07/10] media: rcar-fcp: Handle resets
Thread-Topic: [PATCH 07/10] media: rcar-fcp: Handle resets
Thread-Index: AQHdRp3mCxXFrz2IzU+X9ezmKYJ2XLbUK1MQgAAETYCAAAmpwA==
Date: Fri, 18 Sep 2026 11:47:24 +0000
Message-ID:
 <TY3PR01MB11346DA80F07E2FC76110984886872@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-7-4c72d4e086dd@ideasonboard.com>
 <TY3PR01MB113464309AC8B77BA471A31DC86872@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260918111119.GF59058@killaraus.ideasonboard.com>
In-Reply-To: <20260918111119.GF59058@killaraus.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10660:EE_
x-ms-office365-filtering-correlation-id: 993da096-ddf7-4d22-0edd-08df157a9b2b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10067099003|11063799006|5023799004|18002099003|56012099006|4143699003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 V+lpikGDQTJWlSTdPNMZ90/doMaH+fV0h38tGp3+9KRCXQm6QA/01nGqiFGoiOob+NK5SWQERN+OR/8fqUuW1MmU/B03gkmFreMash6u659VQf8ZN0tFmXuLTQpdHKbilFUSgTAa2O84/9Z/XazuCeEMOXZNV3/c+iFJoUWtV7d3HrdjMoECzpgnccokBbYvOO25J2ex8HKm12yK2DYygDq/4x1l0wO+3os58+5A3SWFrofhfxuv+gsCsISdNqaqqAauPTpG0XkqKmHY2xy4zt7FlreSe8b4KuO4DdICUlfL8qycM9Fo1Sb9IR3C0In+MqXPBrNDUR7YsaPQvuGLM1UP3bkLrF3bWutf73ofJ2QkFakyX6wvuhog7q4jUd8NBBwi/+9aV4PySZQnMOTNdlItZs3gIuXZFOvXLJ3K2fMz5kFVPuU2NJ2nUz2E2L7jqN8ZmQwBFdi5kRua8pZPsi3ay6Km+Zon9s6fk2PjUCAVv1F69D6fM+HzTsgWGJD3pMFisUD+4geftsTovslfYD5RlVE2WM/yupF4v830t92Dn+eqpd55MmlukIwMx+Tvj4WMdzg5pnhdL7VAdd5i8WMEgDEHPaLwYa/PoNU4IW212gHHg8cPvRIAHR5cMoVo31RByFnNAZCjjakmOpX7o8D/DKaK0nkKykC/OrlDecTmZ9egEmANqN6FDDC1Iqw3vYFANxjCmaC73qAza/pZBQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10067099003)(11063799006)(5023799004)(18002099003)(56012099006)(4143699003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L01qeDFxUUlJcmpBbzZ3STA2cEJXTlZpK003R2psRFJQTEhmYXRySUpUZ1lW?=
 =?utf-8?B?Y2cwVDVTRjRPWk83M0FqaDlrWjBiNXdrdnpNNFdkbGMwU3dNUVhMUzAxdWFo?=
 =?utf-8?B?eVZKQ1lTMlEwYXVZVTh4SkJOMGFqZnR4eUZpTW50eXdIVG9JSVdrVnBaTnls?=
 =?utf-8?B?dW9qbmtKWm84c0ZDNjJVS0hUamZ6aUZPc01oUitXTmVtcUUxTDc5THI5S281?=
 =?utf-8?B?eXNvdEFwNHFZbTVzUWFvSGRJdE9BM0F5UmUzSmxTeEhUVENJVVZSUnVuODAy?=
 =?utf-8?B?TDY4bHVDcDI4Z09FN01XNi9LblF1dVg4b2hpTjlyT29sKzlaQ2dpMWZWbjFl?=
 =?utf-8?B?OUljcGloRUpuQTh1Z2RvRDAwUTBJYlJ3NDE2TnJDNXJ2MTJoUndlTGs2RVBp?=
 =?utf-8?B?NmpUeVVNMy9hdmsrWlcrZ1loeWhPTit3M1EvNkQ1ckl2VWNGTEcyY2NFWVE4?=
 =?utf-8?B?cnFxRzA1UytCRlVsZ2J0SEZmM0M5MytNNkFnNmVtTmRWR3J6MmRxam5mdkxW?=
 =?utf-8?B?VDJxb0FTS0wyWGZkTEhrZWM1ZkRYTTBKTkdLcFFtOStwQ1R4RldadDY1MGVR?=
 =?utf-8?B?NjNaYWhvcHJhN2VyL0FBeWk0MWdFWTAzOFZyL01XK2J5cU1EWkFFcmN1R1NC?=
 =?utf-8?B?M3pCVGtVWmR1Uy9EY3N4RGc5V3BpNmhqWFdSQWFZU2VlcCtodi9Xd0dxQ3Rs?=
 =?utf-8?B?SE5XZC9IaS8yNFgramRwd2VHamJIY1pQaHYzNS9UM05iTS9zNFZ4MW5NM1RN?=
 =?utf-8?B?MmFtelROK2UzeGRWcDY0VzhleEU0THU3ZDc4RmhEbWlueVIxY1R6dE5lVmxN?=
 =?utf-8?B?RnlBUzcrZ29FZEI2VU14dURtaWt3V0s2OWE1VjVHWkJ2S2sxTzlTNlNBMG1E?=
 =?utf-8?B?c1A2V2l6UHhsT1FjcXhjcE5DRHE5L3VSeGp4cjRyRmxNMEpreUZ6QVgyUmFX?=
 =?utf-8?B?dEZxeW1RRHM5QkorYlZueFpOQ1lHUDhUTnczRHpKc2ZmU0ZXQWM5STdGcjVD?=
 =?utf-8?B?akxkTUhqNnkzS05IaWdtOE1CM3V4dEYzUit0d0hyNWFyUmZ5T1VKWE1qRWR2?=
 =?utf-8?B?dkhzSlE3MHVjZlBUOE1yZVpXSjRyT2ZjWk5BaEdqaW9wOVc0cnl6cFRtV0do?=
 =?utf-8?B?TE81eWJRcEhudGhyYmN3RUtiVFZZM1pyaHg2bVdsdW94WVRLMWlrL0doMURP?=
 =?utf-8?B?UytoQWJ0Sk1zb01OUXp6WEQveEQyL3gvelFlcFBJQ0V0ZmIxS245bjRPTTVm?=
 =?utf-8?B?aXREZk11Zmp3RnNpZStpNGZrOWs4dlo2QkpPTzcwWTRTUkdHaFdJcEdnTWJR?=
 =?utf-8?B?c1RtM3NNSVE1QUNTM0pZZWNUNFc3dkRBS2RqdGZVTzFhc3ordmgrT0JobXhU?=
 =?utf-8?B?OUphaXRES25oK2xnUmw2RHBnRjBhMkdSNXh3T3BzcVQ4TWpDTVl6K1VTTVFx?=
 =?utf-8?B?bVdEcUJXYk9VcWdNUlh6OGI4bHJTQ1VOWEJlQXpSaG9UMDY0Z2x1WGNCdUYv?=
 =?utf-8?B?RzgxdDNFT2RDOTJRS1dvOGJ4YytJaXExOFRXa1VYcUU4K2MzS0JzVllZdlp5?=
 =?utf-8?B?YXRES2hQbzhZMDdyVk13YzVraEpLNE5tdFR0OGNFSng0aUlMaEZEL2pLTnFF?=
 =?utf-8?B?WnpVaUpPR0JFckxKZmdtZXE1ZUZhTnBidDVjZmhBZTFBdGI2eEY5bVN6NDQ0?=
 =?utf-8?B?V3NyY3NPTjFlRitQT2hXdFBXZUpOM0ZGOUxuTXZDMFRUSTVrRHlkQXdLQ0Np?=
 =?utf-8?B?dWU5TWl0bi81TDlXZHBrbEcxY1Uxb0tSY1pIS3hpVUYvU3NZeGtEYWpOQlN2?=
 =?utf-8?B?K2d2TXdWUU9KeWFQR0hjRGFuNGFzb0xMSWZxRmswK09Hb0xta1dTbXZzVUky?=
 =?utf-8?B?U0NtRmsxdTFXQUw1VDh0Q3YyMHZ4a0pGQXg2NzNEL0pxb3ppR2hxWlZ5cUxW?=
 =?utf-8?B?ajFCSzJCWE91SEtFallOSkJvdG9leUY1R0RkUDIrT1UvK1l3SmZJKzlCeHdM?=
 =?utf-8?B?R3huYXQxTzJxR2RNYVJBdVhKcEMrOXFlY2ExUUJ3dml1UXpBdVdramlSSjgy?=
 =?utf-8?B?dW5WTWw0M2hCejJCdDB5ckIzT0p3bTVRRUJHNFMySFoxWkJSWDN3TDZVNG85?=
 =?utf-8?B?MVk0UEtrMEJUTTVzQXZzeVhhZmZ0RU80YWdXQ1hqZEZaOU4xczFvRGhPQXhy?=
 =?utf-8?B?eWVScVN0alN1U1l3NWs0ejVrbE45QjF0NVFUM1U3eWxXUDBiaStPTW9vYVFH?=
 =?utf-8?B?TStlRGtIaUdrcHZGTmFkNVZ3MXZ0U1IvRyt0UEF2QVhDSSttaCtyVjBxZThu?=
 =?utf-8?B?d3JLdzZzd0llbVFLR3psd3RSc0hNVXV6SjZTOTI0YWwvNUsyMWRlUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 993da096-ddf7-4d22-0edd-08df157a9b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 11:47:24.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: us3Fym9PlDhJ62V1/hN4fU30MSyEgW7VDQqXBUg1Qf60sC61EO+ja+o2o0N/pLlrSmrBkx/ZJyFtNmn7mGddS5Ct5+BtAQ/NSyWVr/Z66i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10660

SGkgTGF1cmVudCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVy
ZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+IFNlbnQ6
IDE4IFNlcHRlbWJlciAyMDI2IDEyOjExDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTBdIG1l
ZGlhOiByY2FyLWZjcDogSGFuZGxlIHJlc2V0cw0KPiANCj4gT24gRnJpLCBTZXAgMTgsIDIwMjYg
YXQgMTE6MDM6MjVBTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gT24gMTcgU2VwdGVtYmVy
IDIwMjYgMTM6MDUsIFBhdWwgRWxkZXIgd3JvdGU6DQo+ID4gPg0KPiA+ID4gW1lvdSBkb24ndCBv
ZnRlbiBnZXQgZW1haWwgZnJvbSBwYXVsLmVsZGVyK3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbS4N
Cj4gPiA+IExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPiA+ID4gaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IERvbid0IHdvcnJ5LCB3
ZSBwbGFuIHRvIHdvcmsgb24gVkNPTiBzdXBwb3J0IGZvciBYNUgsIHlvdSB3aWxsIGdldCBtb3Jl
IGUtbWFpbHMgZnJvbSBQYXVsIDotKQ0KDQpPay4NCg0KPiA+ID4gT24gc29tZSB2ZXJzaW9ucyBv
ZiB0aGUgRkNQLCBzdWNoIGFzIHRoZSBvbmUgb24gdGhlIFg1SCwgcmVzZXQNCj4gPiA+IGNvbnRy
b2wgaXMgcmVxdWlyZWQgdG8gb3BlcmF0ZSB0aGUgRkNQLg0KPiA+ID4NCj4gPiA+IEFkZCBzdXBw
b3J0IGZvciBoYW5kbGluZyByZXNldHMgb3B0aW9uYWxseSwgdG8gY29udGludWUgc3VwcG9ydGlu
Zw0KPiA+ID4gdmVyc2lvbnMgdGhhdCBkbyBub3QgcmVxdWlyZSBpdC4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBQYXVsIEVsZGVyIDxwYXVsLmVsZGVyK3JlbmVzYXNAaWRlYXNvbmJvYXJk
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcmVuZXNhcy9y
Y2FyLWZjcC5jIHwgMzQNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yZW5lc2FzL3Jj
YXItZmNwLmMNCj4gPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yZW5lc2FzL3JjYXItZmNw
LmMNCj4gPiA+IGluZGV4DQo+ID4gPiBkOTliM2ZmOTc2ZTgwZjI3NWFmMTllNWRjMDJjNmUxZGU5
OGMzOGEzLi4xNWJjYmJkYTNiODUzZjcxNzgwYWFlODc2Zg0KPiA+ID4gNjQ0MGIzM2FkZGYxOTMg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3JlbmVzYXMvcmNhci1m
Y3AuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yZW5lc2FzL3JjYXItZmNw
LmMNCj4gPiA+IEBAIC0xOCw2ICsxOCw3IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3Jl
c2V0Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiA+DQo+ID4gPiAgI2lu
Y2x1ZGUgPG1lZGlhL3JjYXItZmNwLmg+DQo+ID4gPiBAQCAtNjMsNiArNjQsOCBAQA0KPiA+ID4g
ICNkZWZpbmUgUkNBUl9GQ1BfUkVHX0JBX1JFRl9ZMiAgICAgICAgICAgICAgICAgMHgwMTE4DQo+
ID4gPiAgI2RlZmluZSBSQ0FSX0ZDUF9SRUdfQkFfUkVGX0MgICAgICAgICAgICAgICAgICAweDAx
MWMNCj4gPiA+DQo+ID4gPiArc3RydWN0IHJlc2V0X2NvbnRyb2w7DQo+ID4gPiArDQo+ID4gPiAg
ZW51bSByY2FyX2ZjcF90eXBlIHsNCj4gPiA+ICAgICAgICAgUkNBUl9GQ1BGLA0KPiA+ID4gICAg
ICAgICBSQ0FSX0ZDUFYsDQo+ID4gPiBAQCAtNzMsNiArNzYsNyBAQCBzdHJ1Y3QgcmNhcl9mY3Bf
ZGV2aWNlIHsNCj4gPiA+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ID4gICAgICAg
ICB2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gPiAgICAgICAgIGVudW0gcmNhcl9mY3BfdHlwZSB0
eXBlOw0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0YzsNCj4gPg0KPiA+
IFlvdSBjb3VsZCBkcm9wIHRoaXMgZ2xvYmFsIHZhcmlhYmxlLiBQbGVhc2UgU2VlIGJlbG93Lg0K
PiA+DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAgc3RhdGljIExJU1RfSEVBRChmY3BfZGV2aWNl
cyk7DQo+ID4gPiBAQCAtMjYyLDEyICsyNjYsMTkgQEAgc3RhdGljIGludCByY2FyX2ZjcF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gICAgICAgICBmY3AtPmRldiA9
ICZwZGV2LT5kZXY7DQo+ID4gPiAgICAgICAgIGZjcC0+dHlwZSA9IChlbnVtDQo+ID4gPiByY2Fy
X2ZjcF90eXBlKWRldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4gPiA+DQo+ID4g
PiArICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGZjcCk7DQo+ID4NCj4gPiBUaGlz
IGNhbiBiZSBtb3ZlZCBhZnRlciB0aGUgdXNlci4NCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgZmNw
LT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ID4g
ICAgICAgICBpZiAoSVNfRVJSKGZjcC0+YmFzZSkpDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIFBUUl9FUlIoZmNwLT5iYXNlKTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIGRtYV9zZXRfbWF4
X3NlZ19zaXplKGZjcC0+ZGV2LCBVSU5UX01BWCk7DQo+ID4gPg0KPiA+ID4gKyAgICAgICBmY3At
PnJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsDQo+ID4g
PiArIE5VTEwpOw0KPiA+DQo+ID4gcnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9u
YWwoJnBkZXYtPmRldiwgTlVMTCk7DQo+ID4NCj4gPiA+ICsgICAgICAgaWYgKElTX0VSUihmY3At
PnJzdGMpKQ0KPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2
LT5kZXYsIFBUUl9FUlIoZmNwLT5yc3RjKSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiZmFpbGVkIHRvIGdldCByZXNldA0KPiA+ID4gKyBjb250cm9sXG4iKTsN
Cj4gPg0KPiA+DQo+ID4gICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHJzdGMpOw0K
PiANCj4gSSdkIHJhdGhlciBrZWVwIHRoZSByY2FyX2ZjcF9kZXZpY2Ugc3RydWN0dXJlLiBXaGVu
IHdlJ2xsIGFkZCBjb21wcmVzc2lvbiBzdXBwb3J0IHRvIHRoZSBGQ1AgZHJpdmVyLCB3ZQ0KPiB3
aWxsIG5lZWQgdG8gYWNjZXNzIHJlZ2lzdGVycyBhbmQgb3RoZXIgZmllbGRzIG9mIHJjYXJfZmNw
X2RldmljZS4NCg0KQWNrLg0KDQpDaGVlcnMsDQpCaWp1DQo=
