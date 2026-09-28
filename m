Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D3426419;
	Mon, 28 Sep 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577145; cv=fail; b=XY+gXRQrV5K60Fg73c5av2B6JohufjO7OHUjyVAxC8qSggqoSrVcws+BysjeEdVxSn0/bUHpR4KRaldt0kyDt0LK2+eUJsKeEIaITxiLF4VfpILqwIBFToL8v9f/5wGRoZ63yDiEO++w5q7hifV/OkBVgu6lbx0w4wk/V5a9+nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577145; c=relaxed/simple;
	bh=mfaDzlpW1V849aiVqnR+xjW2/uUkpNLOFb0JuQ7ly7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pNKyIEbjj4zRsMjMPKbBofeFW4SkGEAlPTAW85ybaWaTN5vBLSmGbQFnIR/ViljrpdljF66fStgBWth6tbXzSstRPFt/wKizyqTYK/kk6Y4H0jK4a+qfjzaLWNx0qa8r3LIwRzEyTg/dBtG8+wSyFPgJA3DANT6TD7dfWvHDboo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=SH8JoAvu; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SH8JoAvu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBkMSCC8hoHsHd6augh/aqIfrmEKHIWX5BW1aLsg56bFlWgPRcmzrF5BVkCcB428X/pid4zPSbtIiHThFuUtr5ozQJEdn9Yd6/YCqn8S5ymNPWAyfIYss3z//GrJ5zoynKgwoy3rv0jwf9T+Wc58yJTCAa6iksA7OVxKi/T57dUimSSKK84YPZCLQRQWL5UzTIJLgOwudGJw6V4WuOT2q+wknheX3eLERcZLJZxxtmtdwPdoSDTCLPb+gorrD3de3m+a6u8HBU5+r864gR+AuMK8M9fjPM3tMliJMXFKFjaINCXMoQlfm4/OoOpdrntDICBi2UD8Vn2HqwONFaQ3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfaDzlpW1V849aiVqnR+xjW2/uUkpNLOFb0JuQ7ly7Q=;
 b=Eaz322FwvRr7gJksE3yWUrugUhyNgzLHaAbp3LuL5ZDGaTbYKcM9FaAthlF/yUjzNlkeQk3LhQGqthQ771H2HzJko8Vhfuq3lGALkBN+Cw//adbCDISeMjTc5kSE0H7U1Ase6bEIELQjNqGKP0QsREfB7b7qSO7hMPTITMs5a2ikTi15eE5kOer6cASvoE6XURQMn8Ki5jkqKL0czPWEmt25QkqWPVOWFgiCM3dkNHHTiyNCNIlIUq1t8Ai2jIU//Hduz7DYBaSGqd+aN8O5qbzv0xbniWCrM2Zuud3OeZ/Mqf6GIsekvqSZZIPFB0UuNd97UFCnUhLBtnPT6+PYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfaDzlpW1V849aiVqnR+xjW2/uUkpNLOFb0JuQ7ly7Q=;
 b=SH8JoAvujed2BhMfQKXRHEdFMLYPJbVFawjKurAznnwAYNticmmHz8uMMjXIl+R0wJYDnGDPu0URPGWtHiUUJO0YCJhiOnXwyQ06yNDSVkJoAlWVMWVZ4/O57zwP/SUFD3BrnVEspRDgvCTep4tHvE9pZCu0YCTkf5IC/f5jRhc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9602.jpnprd01.prod.outlook.com (2603:1096:400:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 06:32:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:32:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Topic: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Thread-Index: AQHdSkrFUKNDtUT8O0Gh2LmYzN+hKLbjihqAgAADpvCAAAKDAIAAAKwg
Date: Mon, 28 Sep 2026 06:32:21 +0000
Message-ID:
 <TY3PR01MB1134683049EEF8C533BF87FE3868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
 <20260922042707.116378-6-biju.das.jz@bp.renesas.com>
 <20260928-controversial-foamy-tanuki-7fef04@quoll>
 <TY3PR01MB11346192394192932538FABD3868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <22665427-69de-4402-b4da-947ffeba9f9f@kernel.org>
In-Reply-To: <22665427-69de-4402-b4da-947ffeba9f9f@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9602:EE_
x-ms-office365-filtering-correlation-id: 6dfda240-3644-4134-d1c2-08df1d2a403f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 OtZ98VLjIFflvVzN/P1UrVA1jRMggyhmGopbvZPWj8VKDYJLQncow1lBC0vTYSAlH2hANykPRRn28hNzNInqR+81n0YTVEOuiI82cX+UEpgyMHQmr+abvd+USnvPe951mcbIyH1mTiUR9dtyAOqPSOEdoWPuMj1thftEyQOcwUSJMoYCemZM10zzF2u/EurlX2d/nW+VLnP0ByjQZ2YCY7om9dNZrXo7ehH8auw+tARZ9L6CFJrkKxr/P7ae9NBYy8W1fJcvFNm/8y5HfohuW+F0/2IWkUfEvVvBrSFn2SK3X4NyIdm0SVD4bIPOfn9YL3TZfv2DGr0+VcOhYZpxOZov5s382+UNlSgPlI7d3rZjr8Y3Y6oqM6cilvnwEC6aIJlwwGA2gkZJjpWWhWzkFh6CRZ3RW5yXgNJExZWkZ8Q63RjAdjaVZAAVwT3izuVgjESF93/DFBeMzKXQAbmQ29+V56+FxL4EeOl3mOj0d9+auDOiZwN0wi1/0AxpOcOBfV6xYyzCMrSXwqARajRra1Vo2WOsa2yoZ8JdHybJsKeJ8XmVnvgpgDUKUVz+4TOwa04HsxetSSRUzZuM3klxxOUCmTFgSDQftFZAyoAWLB3gUIaHfeRiP4zJt7PNBMKYcU+0fIOuxoXIpsdX8BSWrCh24ZocoRGqNw+h/kbKEJyGPfII9u3vT04U2eAYnflPs+IhhssZwckrFb3fGmWX5bI2fr46ybDJWyq1J2zdK3E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmZGWkJIRHNRN2djWEUzdVY3RXJaMDVMeGdvak1YQUg2c0FYV05WRTNWWDlx?=
 =?utf-8?B?NXdFWDJQSlpzS1dCK3JONmlobUJ3N0JzbWxJdStZUG9KdnJIQUtBNzY3MFYw?=
 =?utf-8?B?RXdGdEtVK0VmS25ZSFRpOFVPc29aV0FxcVBWcXZrV1RUOUVrcVgvUFFFKzJY?=
 =?utf-8?B?d0RiTzRUVXhiTlhrU1Y2UXBuL1BvQXZjdEIvVkc4S2JnQlozWEI5Wit4YmRP?=
 =?utf-8?B?SkJyeFlDUnRZQ0ZSZVpHblp3ZXJrN0lKVHUxVUs5eStYaTFBb1B0cllmRFhS?=
 =?utf-8?B?THI1VGh2WGZ5a3JWcnNHV2VaTTNxU2FGQ2NpS3NwcUhiRlBvamZiU0xmNGpr?=
 =?utf-8?B?dVh5RmtNeHV2OWpsQ0tTVGZLaUlkQ252ZVJ5emtZd1grUGk0YWxXMU9ZeHpx?=
 =?utf-8?B?clVaK0wzL2RaelVwY291U0FwdGY2YmJKYnhYMTVsWEw0MVJYNG5raFR3bG1m?=
 =?utf-8?B?a1BZQmsvbFE1RlA1aXdQcDJzSEFJclAxbGtXY1ZqR3BTaGlFbUs3Q09ySTZi?=
 =?utf-8?B?aG13K0dLdDB0d3d1aUc5L0J2ZWdCYnlsS2VVY1hJMjdxWktkeEJQb1o1c2sv?=
 =?utf-8?B?dlIrcGVSemRwNVdaUkp6c3RwdnFhVTFRbjlBeHRLcGhycXNtNThnQUlOSmtx?=
 =?utf-8?B?bkhCcHNkckhaV3JpYUIvVGVZMEM0d3VPU3NBYW4rbjBzbmNPeStDZDVROFZS?=
 =?utf-8?B?NU1vSm5KdjNBOHRCU2krS2U3SzErbk1kMldhSzE0VVFlQUY0K0tWNHZrL2Ux?=
 =?utf-8?B?b0NLRm8rbGFudXNhVjh6SE1wdklyYStiVUtMYkpRMEtTOHJCTnFmejNUdXdB?=
 =?utf-8?B?WkE5QnZoSzNuamJmbUxzRm5ESUI4bHl6NXFLZnRsZk44QWp3QVpzZDRTZFZT?=
 =?utf-8?B?aTZPK1ZmOTcyYVhEYUR3cXpoMlpWUVovNElSRC9veThKN3BBMnpYVzdWRmpm?=
 =?utf-8?B?V0MrZ21YTCt1WXpaQ05TNGxmQWZmTFpFTms5MHc0cGxPNmtLUXVNdFkrRVFY?=
 =?utf-8?B?UFZ0VzYxN0xod0tSWEwxNlpONmtCdkVWV0l2WEJJbnFhSTRkZENVRmVVZW4z?=
 =?utf-8?B?c3ZncHQrTG4zbkxDb0xUNTZKVm83dGU5b3d4VVh5dVJLOXlCWEIwbnAramor?=
 =?utf-8?B?ZDJIelVDR2h1bE9NbzAzN2VSV0cySlJSZHBjcTJRRGJDUXdTS1VEa0ZYM09B?=
 =?utf-8?B?NCtob1NEQjZDNFlZa0ppUG43OTVWZ0xkRDh2R1lkTWpiRjh2eGQweURwNjd2?=
 =?utf-8?B?c2xsUkR0Q2tqUk1zcDgxa0FTYzVDT0taOXA0eUZHSnY3bFR5OTBKeGhDb0pC?=
 =?utf-8?B?REpoZElYaVdjT2ZUMWtINFJUNFNCL0pvdU5HcHlHMlhDR3JOMjIzUEhNVDJS?=
 =?utf-8?B?RTNGTm94Y0c3K2d2ZHR3OGNad2Ivd1V5UDFaSG9vb2taNTRTcnR2eDZOT2hu?=
 =?utf-8?B?WTQyUFliUkN3REhkU0xXcW83cm1wRElZWFRsMFg2a2YwY3diMU51VzFhL2NX?=
 =?utf-8?B?QWV4elgyODhrQ1dsRWgyenZRL2R3SEFsbnFEZVloUjJxbHJVcEdhVVZlRlB2?=
 =?utf-8?B?VHVYRHlhQ2s1Ujh5cWJtVmo2YU1tQ3BGMFQwMmFWZFA1d0FBaW5MREEzMnI2?=
 =?utf-8?B?RGhmR1MyWFJqWmRuNTcxakVmVVVuUDVtLzUydEFJNkl4TG50NC8xMm0zY2Z6?=
 =?utf-8?B?blNlMFhBWDNLSlBaM0lsM0ZPcTVrZGg0UzQ5U1pRYmJnRDlRK0FpWjZLeDly?=
 =?utf-8?B?V1NIcHdYUjkraU9Ib3FpZHFqRjVqTFQrUVpsWmYzYU9SY2FaNFNaMWlQbEFU?=
 =?utf-8?B?SU9yYnhxTkJzUmFYVkcvZnZWamZXb1JHRjRGa1FJbi9ndXlGU1hSbTJkZEJl?=
 =?utf-8?B?Q2h6cmVPQUdndEdlL1Q5cG5VbDhlQVFMSkpLRUxXamFEUHR0RVovODJGNm5m?=
 =?utf-8?B?V0h6NEZGMnF4RVVpVC93Z3F4cmxnbUFMaW1qd2oyYzBWSCs1MVlKOG14eWUw?=
 =?utf-8?B?dDNxV2V4NkVaRTZINzg5eFNPV0M5MEhpamRVWENqSUpyQzREQVllVVpPSUVS?=
 =?utf-8?B?a2wvZ2JXR1ZmTUNkYkp6bnRPVDF5YUVYL3BBQlBiYUJyLy9Td3JRMmd5aUly?=
 =?utf-8?B?Z2RHZEZkTldJUlpBWGFMMlFTVmNGZzZTSXhmWnE5RisrY3hxdW1NM1hsaCtu?=
 =?utf-8?B?Nkc2SzF2bkRoL1RiVG9vb1NsZWVpUzNKb0ZaWDdmSG5KNjVPNmc2LzdVc3Z2?=
 =?utf-8?B?cFVvamJOQTZlL0cxdWhjdjljaXRHb0tPUTVjd0UvN24rQ3M2Vk1Qd1J1dTEx?=
 =?utf-8?B?eCtDZFpmY0V5ZXJuZHBMUCtQemFncm13d3FNckE0Tk1TVXY5TnRnZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfda240-3644-4134-d1c2-08df1d2a403f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 06:32:21.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTS6VyfHdcQPtdLmnC5ea0puHKe9Bnva8+7qray11nFvmMigQtzAYOJ68ibaLRSDtngUXg0seMzlT8iGde7KB7FVPOIBZ5R0MNqVWsXDP7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9602

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDI4
IFNlcHRlbWJlciAyMDI2IDA3OjI3DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNS84XSBkdC1i
aW5kaW5nczogaWlvOiBhZGM6IHJlbmVzYXMscnpnMmwtYWRjOiBEb2N1bWVudCBSWi9HM0wgQURD
IGZvciBUU1UNCj4gDQo+IE9uIDI4LzA5LzIwMjYgMDg6MjUsIEJpanUgRGFzIHdyb3RlOg0KPiA+
IEhpIEtyenlzenRvZiBLb3psb3dza2ksDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFj
ay4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IDI4IFNlcHRlbWJl
ciAyMDI2IDA3OjA1DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNS84XSBkdC1iaW5kaW5n
czogaWlvOiBhZGM6IHJlbmVzYXMscnpnMmwtYWRjOg0KPiA+PiBEb2N1bWVudCBSWi9HM0wgQURD
IGZvciBUU1UNCj4gPj4NCj4gPj4gT24gVHVlLCBTZXAgMjIsIDIwMjYgYXQgMDU6MjY6NTdBTSAr
MDEwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+PiBBZGQgdGhlIHJlbmVzYXMscjlhMDhnMDQ2LWFk
YzEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIHRoZSBBREMxDQo+ID4+PiBpbnN0YW5jZSBvbiBSWi9H
M0wsIHdoaWNoIGlzIGRlZGljYXRlZCB0byB0aGUgb24tY2hpcCBUU1UgKHRoZXJtYWwNCj4gPj4N
Cj4gPj4gSXMgdGhlcmUgQURDMiBpbnN0YW5jZT8NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIEFEQzIg
SVAgb24gUlovRzNMIFNvQy4NCj4gDQo+IFRoZW4gSSBhbSBhIGJpdCBjb25mdXNlZCBjYWxsaW5n
IGl0IEFEQzEgaGVyZSBhbmQgaW4gdGhlIGNvbXBhdGlibGUuDQoNCg0KSGFyZHdhcmUgbWFudWFs
IG1lbnRpb25zIHRoaXMgSVAgYXMgIkEvRCBDb252ZXJ0ZXIgZm9yIFRTVSAoQURDMSkiDQp0aGF0
IGlzIHRoZSByZWFzb24gY29tcGF0aWJsZSBoYXMgYWRjMS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
