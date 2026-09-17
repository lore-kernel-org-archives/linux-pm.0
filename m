Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FF3328E6;
	Thu, 17 Sep 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650005; cv=fail; b=p+9aZOP7JJnBbF0jhrtl+vYpG83wk+rDATZJC3XKiLfhD3NNq8gcScfEgLdXx89wPo7pOrKuekb5JUkF0yoXL9fPqfqwq3mcpxySPQO3YVcUq9UcJYhXYM7FkBkkQwvUKtHVAvg3IRWC7+/SpWSKmR8+k1+u90SlUwXJ2UiyR5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650005; c=relaxed/simple;
	bh=rcO+1VR0BDbihJ3r9s721z31PesKpK6W5+JkiKjGkXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RiCPnwif04cWpwE98qIpj6rKVLPAjH6Dy++Jd5vm3cjLlVafOqfiw2C8lGnFhK/q+ltscpfisokL6PFap79Maxe1Gf7WIBA8WC5o1iQChv1rXiQXMtQCb7kASL4tB9cTQWLtcwD6HQD7eLumQcZvuVvrSpNl1sEqajGsQlvj5fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=HsQoVj7C; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="HsQoVj7C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCSRJqVXWxYZgyo6wPbB4622qq099B8NIFL2tb5lWvlvLGUiMb/XHlk/RR/RazMNs1AyYfJ1vONzjJsBQSWSHcjinwGF8IpZUmjLGq5WAJ+e+JkK8S0QPwPdTq/MG/S3i2vqwJm/ruBQ2ZNBPxI8fm+/P9DSrBOKVDA8dkYJ2pZkf2QKzj3wchX2PUKrwbj7F3btZy2gDcHi+W9Wu4Q+0qEXLt9WfrvZbQdCumuWFR91gh+Z5TxJoLKT1LA1GZKlmCHTorvYHV6iRDR/xr7qFw6Fb0VYkKQMxjR5jhO8IgG5amA2DSQgYnQ3cRc9eNVVQVwksTOcb/+eSnHGK3cUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcO+1VR0BDbihJ3r9s721z31PesKpK6W5+JkiKjGkXY=;
 b=eaUf9y7c2I7xqNXFQHv2r2TxN5ogQkARrhojmSvZwFkj7ngfIdfj+WRYL0wf3BlLjBtpU3uV+oftNsa0g+/YcKJ9E5KJLeBPHNmOT2Hf/G89rBpdrjbZgHGCMFEIn/hWVP6yLdJwU40gJgAu/IoGfKlY4DLG3vP4Y6yECveX56YzUz31e5ekj0mLXefZT/XyW14hnxUsXx4TO61mlBRwOCBO2AG9QbhVFZvZ4ogoLwxIgE0mzBv9YS98EFaVZ7RULgQBMq8D8vGJHysLprP0sSz7BViHl1ZCMTQPpZ3/qIHBvTHHiUvI+dID8jsI1AJtUaBgCj/dnBxQx7zpiBTvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcO+1VR0BDbihJ3r9s721z31PesKpK6W5+JkiKjGkXY=;
 b=HsQoVj7C5294XI2Y7NRwsUOhJaotYECQ7n5vqVcTb54+VPCibQmj9xKUffx4SSOd1LgNRx0s5BG2BRPO9JLb8syJPX+5fLutgSX6AjALvJaIW8L8TR+Q91ZQ2eWpMqQK710YZ8i412YBc2csTualHHxEDjFQtxjl7YUjNW0lcL0=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TY3PR01MB9916.jpnprd01.prod.outlook.com (2603:1096:400:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 12:59:50 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 12:59:50 +0000
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
Subject: RE: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain
 definitions
Thread-Topic: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain
 definitions
Thread-Index: AQHdMX5892WN4kO9QE20wnaOSC1ofra+mVOAgBRLDHA=
Date: Thu, 17 Sep 2026 12:59:49 +0000
Message-ID:
 <TYCPR01MB1186533A53DEEC93DD2E64774A2B82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com>
 <CAMuHMdWkkKnEsCKTcNMyr-WMvp7o5++Yg3rPR2f4wao=-weRoQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWkkKnEsCKTcNMyr-WMvp7o5++Yg3rPR2f4wao=-weRoQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TY3PR01MB9916:EE_
x-ms-office365-filtering-correlation-id: ed6eb768-5faa-4d0e-4aed-08df14bb8f07
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 xDsyur3+nQKe2YMZoYAdTlqSML4XNhCCSdsLWa/MXovgrEAVr3ihvO1a3RRzbGp3k07UuNB7Ak3Tj7rdcNlL9pTxE0NoO7qV/ij4S25cbKsaYjv67NxeU2YPHbm0O4TgPNv2YD3yWh16BlbyApkm54qAfo+OzH/clTzxEED31pculrtEGGg12k3dZgJu5FA6dy0+9m3Ik8SCKyxo3WhsI/HkphSvlJ2fNs/Q9L6QI/DXQwrBWnX9CKUAHA74U49InT/B/a3pWQkxlonpN/gUtd0pc1xiGRMBowV4Km2tqVdRiFjTy+jrWDRvWqTonpFXoUpD1T78fPWIzJTdXhfrGNgDtgP19kcnpv/FWVDA7XFi4RnJQl76pvixlrQ9/LIgQLa/y2Yw/7Yxg0DI+LnBD9Up2fDpS8ZYRyHyCkmN3hgJddfucUxc4Smfr3nP6DAaNOocFqhQlv1JAMctMAiox2iqZnH9s26VcV9z4lG+YW3YB/unDiHPy0HqNY+671H2O43bNLGTSPE572yUxlCaceWC2RWNScK8EcCwaim/x8M1ljVhRe0CBANmt9+eQ6bOzDxJ35AlvMjj55c0KDQhHD/3XmrCArYxVB38USoxk6WHiN3YPxVab02vr2m1oItKBW6L4cSHaPXllXMKZr8uYBNfDZWQ8NFxH6xZxeyFkV8yq70v+vLRGJ8YLrbpy3vG6sFxIpfaB15kMnLEoYv2g7Y/XYVUJn3hkrtfwdEQQi8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFVTT2ZOUlZRUHJwYWErM0xyOWUyaVZHQjRMZ0ZPTGpNRWRXRTErNlJ2RUpu?=
 =?utf-8?B?amhVV0RnOHY3cnNIUGg4aTJzNnlURnFoQUNoRVd2Sjg2dlFhS0Z6VGRLNUo0?=
 =?utf-8?B?bC95MmhvcGJWYUhGZllOK3JBQTEvSXZjRFoycUd2RFRQSnU5WWNPaWVuZXZj?=
 =?utf-8?B?dmVWU0NiYkczdnNZYjdLWjljb09RSmpzSVc4MlA0Q2V0akNTaFFtdnNaU3RQ?=
 =?utf-8?B?TWVob2tVK2xQQ2R3ZEpUZzU3THRQZ3B6YmNvc0VRYzhBU2JtTmdtNE1OK2Zj?=
 =?utf-8?B?bEhMM0xMRHBBVmlyZ3A2NU1IbHNZbEkrRjR4L3JQUlFUUEpWVHJDVjdsQzE4?=
 =?utf-8?B?MHdndmdiYzlNTzR2a0d6MnptaEpvKzBtSDBIZG9ydHVtM3FVWjlEUXJVWmR1?=
 =?utf-8?B?S3U0SEF6S3lFdHZwdUV1TEZKdElFdHB5MDFCSUQ2b3A0dXBxT0drTTgyQUdB?=
 =?utf-8?B?a0FMR0dhaysyRlVDckxDSi9wQ3RvS2w1UWphK1ByeCtKcEg2SnlNVTdoNXdM?=
 =?utf-8?B?UWF6a2RTd3kxaG5WNUhFWDdhWHFGR0dRTU13VzNzYnNsZVUyTC9sMjd0cVZQ?=
 =?utf-8?B?V0ozTlU1TFNnbVVUanFIK21SRzNkT3NaREJqTzJzRUFHT1VOTFJGVnNrUVFt?=
 =?utf-8?B?dGJmR0dIWVVETUxQcTBIM0VzYXo4cW9FZC9Wc092ODhrZFBNMCtWZjg4Qm4x?=
 =?utf-8?B?VVBYK2E2VWE2OXN5bDBpZFhKYVBYTFhTYzdOc2hCVmNoWklOODIzdHEwRlNn?=
 =?utf-8?B?QXF0VFR5enMvQytEbVpzcXpjY0YyTkdGb09HbCtpdHJ0dW5aQ3prWFkzS1hr?=
 =?utf-8?B?SWoybzBWbHplZjk0dXcxcVZqTnZ0Y1QweWhOWGlPbjhuYzIxTjMwMi9WVVdt?=
 =?utf-8?B?RlBFU2Y1YnZqNzdJZUZTRWlzelZDcXVWaVQvODl4UG9SVFBaZHJtbUcrWmlm?=
 =?utf-8?B?MStRNFJyZHgzRnIxT0JmNFhjSzJSckJ1Z3R6dUVOa0RMZHUrc1FXcFRrMW1Z?=
 =?utf-8?B?bjdsTkQzMWxRY29EMkhkZXYxYlorUkxHWERIN21RUUtBY3M2aGk1RE9ob2dG?=
 =?utf-8?B?cFJDdjd6SGZUbXIrUzZ4WVh3d0QyVzk4L0xKY0paV253Ym1WcjF6bHNGSnIw?=
 =?utf-8?B?TlFOblg1OHZDbU5XOVJHWFBQU2lTT1BlekFNLzJmakJTK2JhQytQRlBuYWl1?=
 =?utf-8?B?TnRTR1RMUis2K0xuRDNBRGxEdmo4bWRxcGorWEpVY251NFhPTjdwYmp4RzMz?=
 =?utf-8?B?bG9tdW1MVUxCdnppRGtYYnFod0VtblE5QlRiQ25jV0hhMFRLUmZsdTBBNkVX?=
 =?utf-8?B?N0J3WWVRc2VlNnNQOUV2em82UW5waE1PV3JlbW1WZzVYWFVYMDVUSGhoOHQw?=
 =?utf-8?B?ZE01MjhmUzF0RW1yQytlYXNEd0phTWFMVmw1VlBlcE44QkE5cVdOR3pVR3ZX?=
 =?utf-8?B?Ri9mdzZLRCtwcDUwTm1ISjdlMlBsV1JGU01lamwwY2xSMVhWWGpnLzNOeHlQ?=
 =?utf-8?B?T1ZlYklrNW42WUYvc2ZXZHJyK21XV1FLUjhGUjlPMjBWUDk0Y3pZWkJZeWpl?=
 =?utf-8?B?aVgrcGlONDNENUxZb0hSeGdFSlNZOVlTOTV1SmlvVGJaMTVFSjhqb0t4R3Jw?=
 =?utf-8?B?Z3F6NVlFbHBjbUxVTW1IeVYyN1YyMFIwdWVNMTJmYnNJTVlKVXBNeEwwakNh?=
 =?utf-8?B?Qm5DQXAwLzJRcFZab3pVdXdYUmJ1UW1OZk9WakRQV2k5SE1tVytnMXJTRXpZ?=
 =?utf-8?B?OFZvSjNob1RMeGtQSi8rbjJ1Q1Q1NWFrMFZQc3l6S3RhL1drT0ZvUktZVyt1?=
 =?utf-8?B?M3F1TXdKUmtMSnAwWW5CT3NYZ09jaXFuSUxxSkFUMGFBMER6RmR6ZG5weS9h?=
 =?utf-8?B?T3dxeEJQRHRmbGZsS0RoaEpIdE9jWGs0S0sydlRVbm9ncnVsQmVaejJCN3U5?=
 =?utf-8?B?bklqWjVqeTl3OG0vam9XZkZhT3ZVaG0rQ0JIWUJCT1BnRFFZNkhVdGEwc3dq?=
 =?utf-8?B?N0tGRHVsNnNwTEQ3SDZqQTY3K1FvYzk4Ly9FeVBzR3FGYm1NcHh6YXcycnhl?=
 =?utf-8?B?VEdNWGhSNmRRWFFjanFrU1JUR1ZhVWM3UC91K21nQmJrQnNNOFY2bys2SkIz?=
 =?utf-8?B?QktkRTdvS3FoUUZ1ZnRBbjhaK3ZPQkFvU0QvWWN1dHRjcUd2cE5wWkUxSHl1?=
 =?utf-8?B?M212eHRLNEJPYXRRaDdvbUZzUVUvb2ZPYy9vUUxobDN2MVp4TzFsUnFQa2ds?=
 =?utf-8?B?ejQzelZzcEErQnVPQVE2Tm4xMVozY05ZMUxNelBueDVtazdFMUkyang1L256?=
 =?utf-8?B?SDY1RkNlOXNoSnhaU3pjVlE4Tjh4aVMwNDZsRUhvRlFoR3crNEt4bERZV2U3?=
 =?utf-8?Q?KdJM8KdyWCwrgwxU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6eb768-5faa-4d0e-4aed-08df14bb8f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 12:59:50.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiRjaeG0OcaGC3/Zh2dk2OU9E1s3E8+2eKo7KA7WS/kuOdQYhKN4K9DMmkFTc63mFTUNUQpJIwiRB26gzJs6EJ+5PIb2lan3T2y908SEsLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9916

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNCwgMjAyNiA0OjAxIFBNDQo+IFRvOiBB
eW1hbiBDaGF1ZGhyeSA8YXltYW4uY2hhdWRocnkua2NAcmVuZXNhcy5jb20+DQo+IENjOiBtYWdu
dXMuZGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2Vy
bmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9y
IERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2Vy
bmVsLm9yZz47IEJyaWFuIE1hc25leQ0KPiA8Ym1hc25leStjbGtAcmVkaGF0LmNvbT47IEplcm9t
ZSBCcnVuZXQgPGpicnVuZXQrY2xrQGJheWxpYnJlLmNvbT47DQo+IFVsZiBIYW5zc29uIDx1bGZo
QGtlcm5lbC5vcmc+OyBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBDaHJp
cyBQYXRlcnNvbg0KPiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsNCj4gRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm8uanpAcmVuZXNhcy5jb20+OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQNCj4gPHByYWJoYWth
ci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
Mi8xMF0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgcjhhNzc0YTMgU1lTQyBwb3dlcg0KPiBkb21h
aW4gZGVmaW5pdGlvbnMNCj4gDQo+IEhpIEF5bWFuLA0KPiANCj4gT24gRnJpLCAyMSBBdWcgMjAy
NiBhdCAxNzowNSwgQXltYW4gQ2hhdWRocnkNCj4gPGF5bWFuLmNoYXVkaHJ5LmtjQHJlbmVzYXMu
Y29tPiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgcG93ZXIgZG9tYWluIGluZGljZXMgZm9y
IHRoZSBSZW5lc2FzIFJaL0cyTSB2My4wDQo+ID4gKGEuay5hLiBSOEE3NzRBMykgU29DLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQXltYW4gQ2hhdWRocnkgPGF5bWFuLmNoYXVkaHJ5LmtjQHJl
bmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9yOGE3NzRhMy1zeXNj
LmgNCj4gDQo+IHJlbmVzYXMscjhhNzc0YTMtc3lzYy5oDQoNCkFncmVlZCwgSSB3aWxsIHJlbmFt
ZSB0aGUgZmlsZSBpbiB2Mi4NCkkgd2lsbCBhbHNvIHVwZGF0ZSB0aGUgYmluZGluZ3MgdG8gc3Vw
cG9ydCByOCotc3lzYy5oIGFuZCByZW5lc2FzLHI4Ki1zeXNjLmguIA0KDQo+IA0KPiA+IEBAIC0w
LDAgKzEsMzAgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9u
bHkgT1IgQlNELTItQ2xhdXNlKSAqLw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MjYgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3JwLg0KPiA+ICsgKi8NCj4gPiArI2lmbmRlZiBfX0RU
X0JJTkRJTkdTX1BPV0VSX1I4QTc3NEEzX1NZU0NfSF9fDQo+ID4gKyNkZWZpbmUgX19EVF9CSU5E
SU5HU19QT1dFUl9SOEE3NzRBM19TWVNDX0hfXw0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyNlbmRp
ZiAvKiBfX0RUX0JJTkRJTkdTX1BPV0VSX1I4QTc3NEEzX1NZU0NfSF9fICovDQo+IA0KPiBfX0RU
X0JJTkRJTkdTX1BPV0VSX1JFTkVTQVNfUjhBNzc0QTNfU1lTQ19IX18NCj4gDQo+IFdpdGggdGhl
IHZlbmRvciBwcmVmaXhlcyBhZGRlZDoNCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KDQpBZ3JlZWQsIEkgd2lsbCBhZGQgdGhl
IHZlbmRvciBwcmVmaXhlcyBpbiB2Mi4NCg0KS2luZCBSZWdhcmRzLA0KQXltYW4NCg0KPiBHcntv
ZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0K
PiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29u
dmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIu
IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dy
YW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
