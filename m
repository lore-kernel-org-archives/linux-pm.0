Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34242CAE8;
	Tue, 28 Jul 2026 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239729; cv=fail; b=siRQ54dWJfsfs48Nkn5F69842YQbxST1wSl/Jwqxf8qWIVTCH2wOg2zoDMA3SjnbkhcHYVYSGkWTOIdoobn6QneTsv2ZvOtf3L2pG9S1gQG9VpYEAb9p25fmqTI0Q1K0/i7dP+TPi22BO2OQW7YhEE+Pkc7rnqlnkSmY00I+QhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239729; c=relaxed/simple;
	bh=mhIkDOrq5aTjgUs3vEwBLpNr/FkvMtW1UgSpnV5qna8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ky80RsJsZKhNv38pjfjjRfFLMG8Coola4FpTVGGg2ybpzUV9iLJKpQlLZoucH/CruwsA/mDo859b7GJ+8Qnua7t+3GZWtdPlF6sgsKN/Vax3els+m/SRZV6V6wgrv/litYCYvX7q4Oj4kQKNduBe2TFAbGpk3biw7VKKSTQBmik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=L0/tFD87; arc=fail smtp.client-ip=52.101.229.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="L0/tFD87"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSdu5pS5aoM0sKZBlE/9F2NUSCiAsRIa93xuMlT0jrH/EAbGVUCvwq/iA5ksxb45qoil3yvSJHzWkZkG94LS8X18ZyXo+IwBbS49DHbRiuziA78ZOEBlZdwCE0dZxxOnJRzaqhhK2mLoPGVPsnF6BE5vIY9XUfayuNCXLGH5vwkzG9JN7sKZkJf+i2AfcS4+wySjziV3YM8iDqKEGHTnJCCPeT5B95CWaummgGowFKSSQz3PHiv/VfCNg/0AudK92m14j/XPl8EfDay7u7V+TH5cnbnyHUJXNWZNmfbqk/3nWKQIEYdHsuxTah673PnYwV2TECCwLT+iiBlPVmOuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhIkDOrq5aTjgUs3vEwBLpNr/FkvMtW1UgSpnV5qna8=;
 b=tTNRBbhn+CUR6Qkz68/HSc7feNOdL5k7ZZZ6TrWzHCUL6J2eNu/+cP/CxhjCKUT/MIFkkn88kvrUYrMcGM4IYC24H39f5wK3DxwLZ6wzZ+MyLNVigmBx0b8bAKK3C16nKamfsfmEiV2kQPGmCvmjVXlUDxNr8B3L3eJlxCz+lQnYctlVp1ZkHJAMe5r2WLCpiPpB05bBl24nQCuSx6QkjKTZALDucznhTIgQOBb/UIwQrHkvcsrDllZSnNmAwSE1zrqBiKtmhQv0Teq7CI9bgBHDNmjf/w5r6w9YCN2kodhA7GFj8Rvobz3CJNETqf7gGzEfQiiGd8bHNJP14x66bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhIkDOrq5aTjgUs3vEwBLpNr/FkvMtW1UgSpnV5qna8=;
 b=L0/tFD87vVJQOoMRuSjEEUR7wjjiNHKhjpyF1V2fG+l3mjzfJ6FFJy1cHF/xQilRrLz5TZOPJ7JaM2mehFozJP47kI+KJI+enFfNn7ZjER6ouv8EXxrKFPzt9BQ0vsHZlyDHPjpN8/CVD3/SxiCtXTlsjRgYCsj+J3R017v0Jnk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB13728.jpnprd01.prod.outlook.com (2603:1096:405:1ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Tue, 28 Jul
 2026 11:55:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 11:55:22 +0000
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
Thread-Index: AQHdHDH4W+4o5eb24UWcXtW8HWrP97aComaAgAAFNDCAACosgIAABAbg
Date: Tue, 28 Jul 2026 11:55:22 +0000
Message-ID:
 <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
 <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
In-Reply-To:
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB13728:EE_
x-ms-office365-filtering-correlation-id: 07244e94-9bb2-42ac-bedd-08deec9f1aa5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 cW96LKpV/vPagkgMPqmx2dGziRKfY9afueXh+y9uRwJV+z90Ic3liPJulKdj9iTB3wtl9G+GnSoH7aFuxyYyQDISd2WgX9nYOMENJC9Dd+1T7aG86OzfH++eSOxHeEqrUP+7rPZhrBqLF6HDDNZpgHSHryxjE58G28LGAiyiRBpBJoVdjYFdShatTdnWQJBcoOmhkrMDpQrqVm5nkC63MaaJsMWPM2h6kKVOTfW98Z2YLCDuqPtmtTTcKLiv0P/ojegmXoLj73k9/nbXPUUT/AanGU280bq5jLLZXuCX1GaS4fmM0bznm/Zdvdtf062u6F3RXjbnZfuw+O5RAskqB1evFUKurVjTzuLbi/Vo0gOyOlt0uwy5hj5ilf+epuiJio2bGGemzvpTOf6ftviMVivF7SQo4jpO1kzFRT+QlUn0Qe7dhn9R0dhOlWSjd3dq+Y9aWnrHyC1oPv8KM+/KgA0IDh7/PY0PayOOLLuOK/XAmsMoGlYIEMAfED/yay8W7PCkpASLm4EWMsBnG7xG9/OPSB5WAkIBExz6XA6ICQJeZE2FY6YFM1paBWvFujwsli8/drhdWwF6pHlH8Nw6cRctk1dbMdhdYG2NJBUm7W2x3bTgVUpeOUPBCylVawI1Fe5QbXbJdhOK7qKljdklpzGpigDnAIMAlehBSym7c9Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qmpqd21TbXZZczVlUEQ3aVVpMUkya0x2WXhhR0wvZndIaHNrdEFUYm14N2sw?=
 =?utf-8?B?ZloyUmtCUlZBZTIrZ0ozSDNvYi9YWGQ0eEhocnN2TWc3OGJEaGNXR2c0NUVZ?=
 =?utf-8?B?MDNGMHUwckVIL01ueDRXQUlzS0wyK0hPU01zRlRLTE4rL2txTTY5cGRDYmxD?=
 =?utf-8?B?NVNUbGM3VFBNWUdMZ2l6OHZVY0dPZ3ZGRzdjZmVuZ0M0dnZwVjVUTXJ3dGNB?=
 =?utf-8?B?MFFBbURRQ1VraTZyMTB6azRkL0ZCaG1rZlVIQkhVcXVvcUozZkRhb1JvOE1X?=
 =?utf-8?B?WDBwMnNwOGhtZWZaTkovcjNlWlBPZyt5OGk4b0E5RHZ6WWlFT3NtZTNNVktI?=
 =?utf-8?B?eDlTcjBZYkxwUWhwKzN3cVozVzhJYW1qQUd2WGhDcWcrVUgrTEg0RTFPQmRB?=
 =?utf-8?B?RDc2NFNqZkRCa1c2eU8zdE5DeVdFNTgxVklwSy9zZysyUFc1eU95K2dLRUVv?=
 =?utf-8?B?OGFrTzhraG50bVZNSngyNVN1UDZ3TE1ZakdQa25LNGhoaU50ZWZrZjFqUjA5?=
 =?utf-8?B?bjdUbFc0azZWdVByMFB2bFRqZUROa29TeTEvSjJQbkdISzFSZGIwbWlTdGVk?=
 =?utf-8?B?cHNaNG9wMU5Sc2JRSHFXNEpBTXFFeEJkVTE3aXVUaUZkcVhiZ3lYRVR3a0dP?=
 =?utf-8?B?WHR2RGpSbExPTDJHSklnWG1wLzJwSUEwelRpdjZYM1RUNHJoMzd4TUdISWhM?=
 =?utf-8?B?azhReEFkbmJZa01wcXhIbjhyVnpYVUVQN3draDBQU2g2YURQd0JEbmVvTld3?=
 =?utf-8?B?aGREVStBNXZrZ3VDaDJMNE50MU5XKzlxOUVsUlV3ZTlSTEFUQ1JmMzhvOUtI?=
 =?utf-8?B?NVMrUlFJaExkdGx1WCtXalVaV1c0aVRVV2xDS0RLcSt4VW1YbUFsYzFLamM5?=
 =?utf-8?B?cUxQL213VElEN1FYNStYTmIyU1k4cmJYVnhaTjNybXNhNnZGSy9GS3h0eUx6?=
 =?utf-8?B?dGRnUGVpOEpMSlJFY3Z3THJxNWJwa2RibEtkK0JNVEkzSktMZWROUkR4eXFw?=
 =?utf-8?B?bUN0eHhpNmlhSWtlcDI2NHVwMXJwTXJoRzAvN3M2dlV5cS8yZDdoTVJFQ0V0?=
 =?utf-8?B?QjQ4cnhJdHY5NFpFSGpkS0FVNXBVeWYvZ3dPbzNYeUFKa29HRmZEWW92d3p2?=
 =?utf-8?B?MklrbThhZDFIREF6Z2dIaUQ1QkZuUitRRHZlbEdyVi9zbDVJc05vZ0paTm1V?=
 =?utf-8?B?SU5mejlMZTBvUThLOSswMmVLL3o3Y282VFdZR1p1Qzd6NFdPV1B6cndwdEtJ?=
 =?utf-8?B?WUlUS1dlSFU4UklCeHZWVzgwSlJJR0VrYlA2c2gzZDVaRUJDQW1SdzJIbE0v?=
 =?utf-8?B?S0JUNndkc29LZlhiOGJzV2c3UnhndmNORHBFMlFZNmRPTlVQbDVpQzVZLzBy?=
 =?utf-8?B?QUh0RTF6TzVxYVhBZFJmZ3dwSi9VcENiczRWYzBXWEJrOFVHUXFkNysrMXBm?=
 =?utf-8?B?REJFc05JdDMrNnd4TWI2YktaeGs0WFlubnE5eU11ZVJudmxLUGJCKzlJTnNz?=
 =?utf-8?B?dzlXbktFUzdtL25hRmViRjlDRmVLbUpraW5jZlpaRTkxQzAvS2l4VTEvNHdZ?=
 =?utf-8?B?anZDdjhPOVFGQTM0dVkxWVhpc0RnbE84UEtra3RNWHNrK1lMRUZsTStZZXpY?=
 =?utf-8?B?THB1Z2JWOTN5Y1pnZkNLUGd0ZEFXVlArUS9wdzRqcGhpRmJaTXhDWGQxMWlz?=
 =?utf-8?B?SmxjN2NIemV6NDFkL2M1R3FMWWc2Yjd0czVDd3dNaDVkVVpYVVJleEk0Qm5T?=
 =?utf-8?B?anZnRWFBWnR2Z3pnZWJOZjJIbG03RkdSQ1U1MmEvN09naTRYYzRnRkV3ZFB6?=
 =?utf-8?B?aDcvWm0zK09YZXRsR3cvcjlVVDQrMGhTeFkwdFMyMk01bjBrRmtLZjV5Yldj?=
 =?utf-8?B?TStWWVU0VVhDTlNMemo3cUdQMlZ4ZmZnM1BrdGp4REI0d1h6c0piaDhYRTVM?=
 =?utf-8?B?QmFTK2R0UGc2ZDE0S2N1Mkl6emh3L3gzdm04MlllcHlQVjczQW9nckxYTlJV?=
 =?utf-8?B?TGRZVmdRVDF5WjUxV05jakJ3cmdZOXViRW5wMVhCMWRVZHBzK2NvQkNGYTV3?=
 =?utf-8?B?K1luU3o2MHVqamFZZVcySmdKQXhSTEJhZTBKOWNTazI0UnBORG9Gdzh6b05j?=
 =?utf-8?B?T1JPeGl1WjE1Mi81WlRwVklOclFyTTg2M1pka1RGdit0QWMzNmFrekZERzlE?=
 =?utf-8?B?VDJkaWJVakVoS0hPazc0TUZsNmhjQ2ZUeXByY3o4STJEb1R5c08wcTNHUmdi?=
 =?utf-8?B?c3NvMWlPVzNibFg1TVkrS3lwVmNZVFV4WTAzNGtPUjk2Qk9Kbis1VURLa3VW?=
 =?utf-8?B?WWZvSkc5ZlErcWxPcStDUWJSajAxYXBkQTRLUnExZVE0ZWJhVE53QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07244e94-9bb2-42ac-bedd-08deec9f1aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 11:55:22.3750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYYiKgt74b1LOZMBgKKS4utbvmi4vyX4t/ePDDvQrXdD18FFmTh99MnSgnGjGuML+riZQxw1ebtIy7Ck4R2hXeW6OTg0MrifheJQPDfOKPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13728

SGkgQmFydG9zeiBHb2xhc3pld3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDI4
IEp1bHkgMjAyNiAxMjozNQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gcG93ZXI6IHNlcXVl
bmNpbmc6IEFkZCBSZW5lc2FzIFJaL0czTCBQb3dlciBSZWFkeSBkcml2ZXINCj4gDQo+IE9uIFR1
ZSwgMjggSnVsIDIwMjYgMTE6MTc6NTggKzAyMDAsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4gc2FpZDoNCj4gPiBIaSBCYXJ0b3N6IEdvbGFzemV3c2tpLA0KPiA+DQo+ID4g
VGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gDQo+IC4uLg0KPiANCj4gPj4gPiArDQo+
ID4+ID4gK3N0YXRpYyBpbnQgcHdyc2VxX3J6ZzNsX3B3cnJkeV9tYXRjaChzdHJ1Y3QgcHdyc2Vx
X2RldmljZSAqcHdyc2VxLA0KPiA+PiA+ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ID4+ID4gK3sNCj4gPj4gPiArCXJldHVybiBQV1JTRVFfTUFUQ0hfT0s7DQo+ID4+DQo+ID4+IFdo
ZW4gSSBzZWUgYW4gYWx3YXlzLXRydSBtYXRjaCgpIGNhbGxiYWNrLCBpdCBhbHdheXMgcmFpc2Vz
IGFuIGFsYXJtIGJlbGwuDQo+ID4+IFR5cGljYWxseSwgSSdkIGV4cGVjdCB0aGVyZSB0byBiZSBz
b21lIHZhbGlkYXRpb24gb2YgdGhlIGNvbnN1bWVyIGhhcHBlbmluZy4NCj4gPj4NCj4gPj4gUGxl
YXNlIGF0IGxlYXN0IHByb3ZpZGUgYW4gZXhwbGFuYXRpb24gb2Ygd2h5IGl0J3Mgb2suDQo+ID4N
Cj4gPiBXaXRob3V0IHRoZSBtYXRjaCBmdW5jdGlvbiB0aGUgZHJpdmVyIGlzIG5vdCBwcm9iaW5n
Lg0KPiA+DQo+IA0KPiBZZXMsIHRoYXQncyBleHBlY3RlZC4NCj4gDQo+ID4gc3lzYyhkcml2ZXIp
IC0+cG93ZXJzZXEoZHJpdmVyKSAtPntEU0ksQ1NJLFVTQn0oZHJpdmVyKSB0aGVyZSBpcyBubw0K
PiA+IHByb3BlcnR5IHRoYXQgSSBjYW4gbWF0Y2ggaGVyZSBhcyB0aGUgcmVzb3VyY2UgaXMgYSBy
ZWdpc3RlciBvbiB0aGUNCj4gPiBTWVNDIElQIGFuZCBwb3dlcnNlcSBkcml2ZXIgaXMgaW5zdGFu
dGlhdGVkIGJ5IHRoZSBTWVNDIGRyaXZlci4NCj4gPg0KPiA+IE1heWJlIEkgY2FuIHByb3ZpZGUg
YSBjb21tZW50IGhlcmUgc2F5aW5nIHRoYXQ/Pw0KPiA+ICJObyBEVCBwcm9wZXJ0eSB0byBtYXRj
aCBoZXJlLCBzbyBpdCBpcyBPSyBhbHdheXMiDQo+ID4NCj4gDQo+IFNvIHRoZSBzeXNjIGlzIHRo
ZSBwYXJlbnQgb2YgdGhlIHB3cnNlcSBwcm92aWRlciBhbmQgdGhlIENTSSwgRFNJIGFuZCBVU0Ig
ZHJpdmVycyBhcmUgdGhlIGNvbnN1bWVycyBvZg0KPiB0aGUgcHdyc2VxIGRlc2NyaXB0b3I/IFRo
ZSBsYXR0ZXIgYXJlIGNoaWxkcmVuIG9mIHRoZSBwbGF0Zm9ybSBidXMsIGFtIEkgZ2V0dGluZyB0
aGlzIHJpZ2h0PyBDYW4geW91DQo+IHBvaW50IG1lIHRvIHRoZSBkZXZpY2UgdHJlZSB0aGF0IGRl
c2NyaWJlcyBpdD8NCg0KWWVzLA0KDQpQbGVhc2Ugc2VlIFsxXSwgWzJdLCBbM10NCg0KWzFdIHN5
c2Mgbm9kZQ0KDQpbMl0gcGh5cnN0IG5vZGUgKEkgcGxhbm5lZCB0byByZW1vdmUgcmVuZXNhcyxz
eXNjLXB3cnJkeSBpbiB0aGUgbmV4dCB2ZXJzaW9uIGFzIGl0IGlzIGdvaW5nIHRvIHVzZSBwd3Jz
ZXEpDQoNClszXSBkc2kgbm9kZSAoSSBwbGFubmVkIHRvIHJlbW92ZSByZW5lc2FzLHN5c2MtcHdy
cmR5IGluIHRoZSBuZXh0IHZlcnNpb24gYXMgaXQgaXMgZ29pbmcgdG8gdXNlIHB3cnNlcSkNCg0K
WzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQv
bGludXgtbmV4dC5naXQvdHJlZS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhnMDQ2
LmR0c2k/aD1uZXh0LTIwMjYwNzI3I242MDkNCg0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9UWTNQUjAxTUIxMTM0NkZBMjFFRkFEQzhBM0Q1M0Q4MUJFODZDRjJAVFkzUFIwMU1CMTEz
NDYuanBucHJkMDEucHJvZC5vdXRsb29rLmNvbS9ULyNtZjI0YWUxMzYzOTI1YTk3Yzg0MGIyNzVj
MTA4YTliNzI5NDJjNDBiYw0KDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYw
NzA0MDkzNDMzLjI3MzY3Mi0xLWJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tL1QvI20zMWM2NzEx
YjU0MDNjNWEzODdiMjI0NjdiYjg4MzcxZGY3M2FlMmIxDQoNCg0KQ2hlZXJzLA0KQmlqdQ0K
