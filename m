Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8342264C0;
	Wed, 29 Jul 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335616; cv=fail; b=rOFMbw7dc9ofmJ+g6HDf76PSeirHynCiCph7y+izqg8wFdQOLkAWuFmBxGxz204e9CrZVbZ+T3NPU+SU8hUlVShAE5aA6XSrJ4YuavtGgSliTiP2MawBv95GYfopv94fdn0rZ05jb5KqJBK/QlVhgbrxMItgo2PQfGxfttxWt9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335616; c=relaxed/simple;
	bh=5s6fjgejGyMCPUEaRhNJoJlHR4RrGo6ZvejHU2aKChI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvnRkSMmTlKLNXnGyMY45DkMAFgedvEpYz0uO0jGYOZek+E9twH0AMTPVg5AJzUqYNYnQmaZp4Z2p4lF6rPnkkMovBtsdBwZmhZ3mzcEiRlqfWrL9yj1cr+kiJPdNV1o4LzVJX245qFNpymryvcFLecKhYW4FdFTr5w8n8NwDTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oYvtpLpQ; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oYvtpLpQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj5R+UD9pEjn94z6cCNPi6iGSI3gi//VXTcJfsi6DxL62rtnSes/an02meEXIUv+5Par0kSvHJFd+snJZYGP0Kzxvp1Bz/fzlbEe/+XpZck/eF0Lvbsmvi0YwlU93GLtMwkSh6OB+1PycgZDFRMqJZ9212Mu+cqN6f95/IyR9WjKPnEMF2gU9+dsSGua/D4+li5qdN7HAvK7cObZxpqpavJLmvzbZkqIBNqsn0RlL7JZ0a1ufdeTHIh9bRlIYvf4k+SZe8v+XpXA9X7CNGjndoEZqTFv2K+tb9VcaINWlp7R4QGU/c2BQFnpTk1u6824Yiz6laKnR/0w0oLlb97Xzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s6fjgejGyMCPUEaRhNJoJlHR4RrGo6ZvejHU2aKChI=;
 b=GzH2YbMsKTJ3kGw9I4t9dSVkteG7WjQyDG+STcw52eVQ/o9PXk2Ojuawb1niRN3xaEa2nEApvTG2wAME4OPDP8iiCPLjC+hGKkZeDsYe/jbnt3BNW6TWU68dCJhsAZH8Lu/n8pGAQudTYjPJON7CFCsEqzlByfZLKkkj6/IdCQhtYPmtqLtQfdSA3Bw7DkjwMik/JFVTQENiPaEWisFT9DTRVLGD22NXDbMAYuOVwbrOgyM2Y/hzhwmbYya50AHLL4pAKw+z7rNmwtENM98TCaeRMv8/27vztnz1iD12+sXzQWdERGSDeWZT8yeid/G9k8OhwsnfeZLySL8VEurZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s6fjgejGyMCPUEaRhNJoJlHR4RrGo6ZvejHU2aKChI=;
 b=oYvtpLpQwm8I0Dh5HTE0zG2cjctHiVAINJuA7sNd19riY3ST1mAYQNs2fczSJ3gLlj+BIiQe7+R25xvIylhd00VuBlMV5elgWbWg8N7I1nt3aL7n/u3AsUVLHNbnLA78mnqBFRdjSFYnwgqMQfcDsjzcDkAd43j1i7ailq9YbvA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14123.jpnprd01.prod.outlook.com (2603:1096:604:360::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 14:33:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:33:31 +0000
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
 AQHdHDH4W+4o5eb24UWcXtW8HWrP97aComaAgAAFNDCAACosgIAABAbggAAqqoCAAADZcIABfSkAgAAV2TA=
Date: Wed, 29 Jul 2026 14:33:31 +0000
Message-ID:
 <TY3PR01MB11346732C04ED0DC52502267B86CA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
 <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
 <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
 <TY3PR01MB113462C8DE3B70428F113ABF386CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MeybezmErzs9+jYaBgXr+ufsTv5_V5sZjhP6ynuQk+W2Q@mail.gmail.com>
In-Reply-To:
 <CAMRc=MeybezmErzs9+jYaBgXr+ufsTv5_V5sZjhP6ynuQk+W2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14123:EE_
x-ms-office365-filtering-correlation-id: 6024800c-9a02-4b9d-18e4-08deed7e5cc7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 z7E4JbklJibHzquPK0cgt0jzEWZ3D/BOrBrDrP03heZpfchvtufRwBFyrzqAiXk2XNvLUU/Lqa1YhkerZeMgbti1WGGxH3iCYoyfBdGBIawu1gML1cQ9cnae0kQ21q4RHERhi0pv5GM8WgLnbObQPMN7QKOb4BIVGUU3JRbD/QI7LL2knmQo+iLY9wJS8rnhYlQjg7Q20Wf2VlJXVHRHey9JHR6GP7B4mPG9sl4bNE0OZOt5ypxIEW1g+fOL8wffSXaaL978Ti+NrImdpyK2D2Y4sFJBabfbG6WJcSHxuyce3XjOKbAbIE6v+3T/bUDIN4OFppWxraRBhN9n/Yw21YmbxfWaBdr7jhto+LBuCgVADQUcR05K8Sn6fWGgCOk6+TCn4fSaK+vwq4nnbct//ica4FkSBLngEi3Cw+89WuD2d3nx3RqKPW3707EpsVZrScW92qK4c8GcYjrQaQpUbSZXNWMvYBAQBadvI/dN0STvZk6JUyslsTSZo7jhOzRREQLKrQl/vCpcd0dRLaAONpaJOpknppFpAD5cw2caYpI2j1gCLzvCZays/QbiYwXQN0dkg8Yj/a3gNCPcG0ebgPLvEbI63lC2kA1mSRhNctYiZDb5gs6wI1voPz5qB7odvjRKcfeTM2u8o414rl99WYEMIOtzmArNYpDuw848+Klj/qqZHzUZU4uVlHpV/QeT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmcwbW5lNUFFYkxMR1hTRDNQcGpVRTVrazF4WDFkTUV4MlpJQmtFSjlWZGNF?=
 =?utf-8?B?VVpJUDlqRnFTUHplNTZXRlZSMVVoZFBMZDMrRWJGU1pOOTFXbWtsYWtxSnkx?=
 =?utf-8?B?VmZHemt0YkxHc3c1WHc4SkxlQUp3Z1N6dENyTjBwdW9PZk5yU09WT0ZLckhW?=
 =?utf-8?B?dks5Y2RzcDdtaXVjd0pvRWNiMlhPOXIrVUd4blhPTlU0a0xscG1mZUVzRGh0?=
 =?utf-8?B?SXROd1JkVEtYMXZIVFVoY2JqM2dkcHlYRmhramlWMjZhUWNuL1RZaGgyL1Zk?=
 =?utf-8?B?QWxHamZlWUhpMWhKOEZ6ZkNWSlFMbmtGVEI4UUtlS2RHbGYzdnkyL2VDb1NX?=
 =?utf-8?B?cFJZSCtJMU0zK0x4VGZsNDV4S20zaDcvcGFSWnU5NEZMQ2EzRW0yUVRMelFV?=
 =?utf-8?B?WlVlenVEVnNuN0cwSjZXcHpqUnhpMGduQlJXOWVHRDV6WEFqbzllM1labUpL?=
 =?utf-8?B?bE1uVmx2cVkyVDl0VkovYzJ4d0p3REgvUkN1OFo3KzE5bTRlenVUOFRtb1p1?=
 =?utf-8?B?N0UyS1hCOTJya1lVU2ltTUNHQXQxWkgrcnQ3THZZeExqM1Y5U3ZRYUFzSGwr?=
 =?utf-8?B?bHhnck1pN2lnUHErR0IvVmFIU1J0TTlmN3ZtRTJ3ajhtdGlzQUpBcjBtZUs5?=
 =?utf-8?B?L2d6SVZaTm0wSXpyR0JoOXV6U3RBZHFRSlF1b1I5ZWxoTTlxVzhmQy9zZUZG?=
 =?utf-8?B?MVNpMGhURU1HWjFBZUdtQ2h6ZW5uWkxGS0trdlpXVWxwbm55SGs0WFBTMUJU?=
 =?utf-8?B?T0l3enh4cE9lOFJJZnJ3L3V1RGM0NVRnZHgvWUVsZy9uVTFVcUdLQSt6dGNE?=
 =?utf-8?B?bVFHR1YzcnlGOHhDdDBMb0d1V0NySFdPdTg2RUxGZUZuMVc2NDVnUGYwek5k?=
 =?utf-8?B?eG5IMzF4ZXlJWUF2dm4zVmZabERQUU94Y2k2WmkwaWZ6NmZYUExZY1ZGWWl1?=
 =?utf-8?B?TlhzSzVNVDh2VW9jd0xGK1hSdjVaK0FUMHhTMUVzWElXcU1DVHRJeER2Uzhj?=
 =?utf-8?B?RGtRUzMvMkJoT0x6amx3bDlOV2RsSXR2UUxOMkxYMWNRemJWZU5ab2lUMTM5?=
 =?utf-8?B?U0ZsK1dMenMwZ0YxbVdOTE5rRDd0clF4RjVqaUoxWitpSXlJRk95ZXg3MlNV?=
 =?utf-8?B?bzRjc2hOWTdYTVppN3FEUWRkbFhnck5qc09ybUJrdHNubTVCYldDY1RIMzYy?=
 =?utf-8?B?VVhBcUxqVnY4QVBrWjE1TXE2cFUrSGF6aEgzTkZxbXRJY28xaGU3ZWQrL3pZ?=
 =?utf-8?B?NVJ0TXFuVWdxVCtQb1Ezd3pVZmpXVmM4NEZDQlFGZHNGSHEzNDh5WTl1eGdK?=
 =?utf-8?B?c0pDUDA5YlQ1djgyTnErclpMa0lQZFRuMVZNQjQ5S3kyREViS045TzdyZHho?=
 =?utf-8?B?TU03V05oWVVWMTk5R29wMjhtRVdZSTdwb2UvWjNueThYZFo2Y3l2Szd0TjZI?=
 =?utf-8?B?OCtxelExZXAwV1hOTG1tQWlxejRtc01aemplRmFBckxzQnE1OU80UFdBd3RH?=
 =?utf-8?B?cWJsNlB3WS8vdFgwWVoxQU1FVlBnVGJMV05QK1hEeFNHODh0Z2E0M3dGMXdJ?=
 =?utf-8?B?Szh0L3hsZ2RFcFhVdXZ1UkZBYVBzUTFYU3RTMVhrSGZTMXJyZkxmWGVPN2tN?=
 =?utf-8?B?SmtuclBUdWRwUEszMVRtYytDUkxDV1dYYW9EZk85RCtiMFNFYXJvdDNNeFJ1?=
 =?utf-8?B?eDZJZkpvcEptaVRSdmlZQjlVSGsxRXBxVUkwRUNUY2dWVmFHbWhOVDB4V0JR?=
 =?utf-8?B?SDV5MHBmVTZJUE8vUFBPSVFzR0I1SW1JNCtUNXgzSGRBR21hQVdxVEpVV25C?=
 =?utf-8?B?NjhjRXYxYVJreFdVbGt3V2dsTTZueURPc1ZOU1JsU0FGS3RzSE1VU2NLSkZJ?=
 =?utf-8?B?dTdRdkN4bGJRL1J4aWVrVWM2WUpnMXJwRzAyTnl4K3lBUTgzZEt1bXUwVTJ5?=
 =?utf-8?B?eXhSdU10WjNobTdlMnJoRm9EZCtZTTlVcWtQQnFnZ1hRRmRIZGFkTXpDYkxG?=
 =?utf-8?B?WExuWUgyT2p0SWNPRS9RMG81WnEzMDcyOS8vQ3VGM3NNRno1K01sS2NIOFpK?=
 =?utf-8?B?WE9OSEF0ei9NcENVeVdRWDNJN242WDlYVEdDWVpWWHN3VERtNXVtSktuZ0Zy?=
 =?utf-8?B?OVYvMWxGYjNvclZ3WEFJcnkwbUJYc3NsWEN4ZnNsNzRxREdBSnF1d1ZpRXIx?=
 =?utf-8?B?MzgvS092NnMyYXQwYlQrcTN2dUozd2ZOWERncSszK2pnNmY1RlBCK3VWNC9D?=
 =?utf-8?B?ZXV2em95WEVEWFF3Y2dmTDIxOUZiRmJ5dENMdE1uendFRHEvNUpnYkw2blMy?=
 =?utf-8?B?U2tPc1RnODFsREVubEY3Y1BVNDFRMU9VU0x4czZsNzlpU1JOK1VCQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6024800c-9a02-4b9d-18e4-08deed7e5cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 14:33:31.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4dqvcsjhf7FmSyIhbdJ220+31FAYWbnguJChuT2k2Ta6vosTUIBBdX821GmfV0/OTCuu/bjm+VJWNPDbNXlnWKglbzO1RhzXBVmV+CHh0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14123

SGkgQmFydG9zeiBHb2xhc3pld3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDI5
IEp1bHkgMjAyNiAxNDowOQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gcG93ZXI6IHNlcXVl
bmNpbmc6IEFkZCBSZW5lc2FzIFJaL0czTCBQb3dlciBSZWFkeSBkcml2ZXINCj4gDQo+IE9uIFR1
ZSwgMjggSnVsIDIwMjYgMTY6Mzg6MDAgKzAyMDAsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4gc2FpZDoNCj4gPiBIaSBCYXJ0b3N6IEdvbGFzemV3c2tpLA0KPiA+DQo+ID4g
VGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBrZXJuZWwub3JnPg0K
PiA+PiBTZW50OiAyOCBKdWx5IDIwMjYgMTU6MjINCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzNdIHBvd2VyOiBzZXF1ZW5jaW5nOiBBZGQgUmVuZXNhcyBSWi9HM0wgUG93ZXINCj4gPj4gUmVh
ZHkgZHJpdmVyDQo+ID4+DQo+ID4+IE9uIFR1ZSwgMjggSnVsIDIwMjYgMTM6NTU6MjIgKzAyMDAs
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gc2FpZDoNCj4gPj4gPiBIaSBC
YXJ0b3N6IEdvbGFzemV3c2tpLA0KPiA+PiA+DQo+ID4+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+ID4+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xAa2VybmVsLm9y
Zz4NCj4gPj4gPj4gU2VudDogMjggSnVseSAyMDI2IDEyOjM1DQo+ID4+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8zXSBwb3dlcjogc2VxdWVuY2luZzogQWRkIFJlbmVzYXMgUlovRzNMDQo+ID4+
ID4+IFBvd2VyIFJlYWR5IGRyaXZlcg0KPiA+PiA+Pg0KPiA+PiA+PiBPbiBUdWUsIDI4IEp1bCAy
MDI2IDExOjE3OjU4ICswMjAwLCBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
IHNhaWQ6DQo+ID4+ID4+ID4gSGkgQmFydG9zeiBHb2xhc3pld3NraSwNCj4gPj4gPj4gPg0KPiA+
PiA+PiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+PiA+PiA+DQo+ID4+ID4+DQo+ID4+
ID4+IC4uLg0KPiA+PiA+Pg0KPiA+PiA+PiA+PiA+ICsNCj4gPj4gPj4gPj4gPiArc3RhdGljIGlu
dCBwd3JzZXFfcnpnM2xfcHdycmR5X21hdGNoKHN0cnVjdCBwd3JzZXFfZGV2aWNlICpwd3JzZXEs
DQo+ID4+ID4+ID4+ID4gKwkJCQkgICAgIHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+PiA+PiA+
PiA+ICsJcmV0dXJuIFBXUlNFUV9NQVRDSF9PSzsNCj4gPj4gPj4gPj4NCj4gPj4gPj4gPj4gV2hl
biBJIHNlZSBhbiBhbHdheXMtdHJ1IG1hdGNoKCkgY2FsbGJhY2ssIGl0IGFsd2F5cyByYWlzZXMg
YW4gYWxhcm0gYmVsbC4NCj4gPj4gPj4gPj4gVHlwaWNhbGx5LCBJJ2QgZXhwZWN0IHRoZXJlIHRv
IGJlIHNvbWUgdmFsaWRhdGlvbiBvZiB0aGUgY29uc3VtZXIgaGFwcGVuaW5nLg0KPiA+PiA+PiA+
Pg0KPiA+PiA+PiA+PiBQbGVhc2UgYXQgbGVhc3QgcHJvdmlkZSBhbiBleHBsYW5hdGlvbiBvZiB3
aHkgaXQncyBvay4NCj4gPj4gPj4gPg0KPiA+PiA+PiA+IFdpdGhvdXQgdGhlIG1hdGNoIGZ1bmN0
aW9uIHRoZSBkcml2ZXIgaXMgbm90IHByb2JpbmcuDQo+ID4+ID4+ID4NCj4gPj4gPj4NCj4gPj4g
Pj4gWWVzLCB0aGF0J3MgZXhwZWN0ZWQuDQo+ID4+ID4+DQo+ID4+ID4+ID4gc3lzYyhkcml2ZXIp
IC0+cG93ZXJzZXEoZHJpdmVyKSAtPntEU0ksQ1NJLFVTQn0oZHJpdmVyKSB0aGVyZSBpcw0KPiA+
PiA+PiA+IG5vIHByb3BlcnR5IHRoYXQgSSBjYW4gbWF0Y2ggaGVyZSBhcyB0aGUgcmVzb3VyY2Ug
aXMgYSByZWdpc3Rlcg0KPiA+PiA+PiA+IG9uIHRoZSBTWVNDIElQIGFuZCBwb3dlcnNlcSBkcml2
ZXIgaXMgaW5zdGFudGlhdGVkIGJ5IHRoZSBTWVNDIGRyaXZlci4NCj4gPj4gPj4gPg0KPiA+PiA+
PiA+IE1heWJlIEkgY2FuIHByb3ZpZGUgYSBjb21tZW50IGhlcmUgc2F5aW5nIHRoYXQ/Pw0KPiA+
PiA+PiA+ICJObyBEVCBwcm9wZXJ0eSB0byBtYXRjaCBoZXJlLCBzbyBpdCBpcyBPSyBhbHdheXMi
DQo+ID4+ID4+ID4NCj4gPj4gPj4NCj4gPj4gPj4gU28gdGhlIHN5c2MgaXMgdGhlIHBhcmVudCBv
ZiB0aGUgcHdyc2VxIHByb3ZpZGVyIGFuZCB0aGUgQ1NJLCBEU0kNCj4gPj4gPj4gYW5kIFVTQiBk
cml2ZXJzIGFyZSB0aGUgY29uc3VtZXJzIG9mIHRoZSBwd3JzZXEgZGVzY3JpcHRvcj8gVGhlDQo+
ID4+ID4+IGxhdHRlciBhcmUgY2hpbGRyZW4gb2YgdGhlIHBsYXRmb3JtIGJ1cywgYW0gSSBnZXR0
aW5nIHRoaXMgcmlnaHQ/DQo+ID4+ID4+IENhbiB5b3UgcG9pbnQgbWUgdG8gdGhlIGRldmljZSB0
cmVlIHRoYXQNCj4gPj4gZGVzY3JpYmVzIGl0Pw0KPiA+PiA+DQo+ID4+ID4gWWVzLA0KPiA+PiA+
DQo+ID4+ID4gUGxlYXNlIHNlZSBbMV0sIFsyXSwgWzNdDQo+ID4+ID4NCj4gPj4gPiBbMV0gc3lz
YyBub2RlDQo+ID4+ID4NCj4gPj4gPiBbMl0gcGh5cnN0IG5vZGUgKEkgcGxhbm5lZCB0byByZW1v
dmUgcmVuZXNhcyxzeXNjLXB3cnJkeSBpbiB0aGUNCj4gPj4gPiBuZXh0IHZlcnNpb24gYXMgaXQg
aXMgZ29pbmcgdG8gdXNlIHB3cnNlcSkNCj4gPj4gPg0KPiA+PiA+IFszXSBkc2kgbm9kZSAoSSBw
bGFubmVkIHRvIHJlbW92ZSByZW5lc2FzLHN5c2MtcHdycmR5IGluIHRoZSBuZXh0DQo+ID4+ID4g
dmVyc2lvbiBhcyBpdCBpcyBnb2luZyB0byB1c2UgcHdyc2VxKQ0KPiA+PiA+DQo+ID4+ID4gWzFd
DQo+ID4+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bmV4dC9saW51eC1uZXh0LmdpdA0KPiA+PiA+IC90cg0KPiA+PiA+IGVlL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcmVuZXNhcy9yOWEwOGcwNDYuZHRzaT9oPW5leHQtMjAyNjA3MjcjbjYwOQ0KPiA+PiA+
DQo+ID4+ID4gWzJdDQo+ID4+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1RZM1BSMDFN
QjExMzQ2RkEyMUVGQURDOEEzRDUzRDgxQkU4NkNGMg0KPiA+PiA+IEBUWQ0KPiA+PiA+IDNQUjAx
TUIxMTM0Ni5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tL1QvI21mMjRhZTEzNjM5MjVhOTdjODQw
YjI3NWMNCj4gPj4gPiAxMDgNCj4gPj4gPiBhOWI3Mjk0MmM0MGJjDQo+ID4+ID4NCj4gPj4gPiBb
M10NCj4gPj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MDQwOTM0MzMuMjcz
NjcyLTEtYmlqdS5kYXMuanpAYnAuDQo+ID4+ID4gcmVuDQo+ID4+ID4gZXNhcy5jb20vVC8jbTMx
YzY3MTFiNTQwM2M1YTM4N2IyMjQ2N2JiODgzNzFkZjczYWUyYjENCj4gPj4gPg0KPiA+PiA+DQo+
ID4+ID4gQ2hlZXJzLA0KPiA+PiA+IEJpanUNCj4gPj4gPg0KPiA+Pg0KPiANCj4gUGxlYXNlIHdy
YXAgeW91ciBlbWFpbHMgYXQgODAgY2hhcmFjdGVycyBhcyBwZXIgdGhlIG1haWxpbmcgbGlzdCBl
dGlxdWV0dGUuDQoNCk9LLg0KDQo+IA0KPiA+PiBUaGVuIGl0IHNlZW1zIHlvdSBoYXZlIGEgcGhh
bmRsZSBmcm9tIHRoZSBEU0kgbm9kZSB0byB0aGUgc3lzYyBub2RlOg0KPiA+Pg0KPiA+PiByZW5l
c2FzLHN5c2MtcHdycmR5ID0gPCZzeXNjIDB4ZDcwIDB4Mj47DQo+ID4NCj4gPiBCdXQgdGhpcyBp
cyBubyBtb3JlIHJlcXVpcmVkIGFmdGVyIG1vZGVsbGluZyB0aGUgcHdycmR5IHNpZ25hbCBhcyBw
b3dlcnNlcSBkcml2ZXIuDQo+ID4NCj4gDQo+IFNvIGNhbiB5b3Ugc2hvdyBtZSB3aGF0IHRoZSBh
Y3R1YWwgRFQgbm9kZXMgYW5kIGNvbm5lY3Rpb25zIGxvb2sgbGlrZT8NCj4gDQo+ID4+DQo+ID4+
IEluIG1hdGNoKCkgeW91IGNhbiBjaGVjayBpZiB0aGF0IHBoYW5kbGUgbGVhZHMgdG8gdGhlIHN5
c2MgZGV2aWNlDQo+ID4+IHdobydzIHRoZSBwYXJlbnQgb2YgdGhlIHBvd2VyIHNlcXVlbmNlciBk
ZXZpY2UgYW5kIHJldHVybiBNQVRDSF9PSyBpZiBpdCBpcy4NCj4gPg0KPiA+IEFzIHBlciB0aGUg
RFQgbWFpbnRhaW5lciBLcnp5c3p0b2YgS296bG93c2tpLCB3ZSBzaG91bGQgbm90IHVzZSByYW5k
b20gcGhhbmRsZXMgZm9yIHB3cnJkeSBzaWduYWwuDQo+ID4NCj4gPiBBbHNvLCBJIGNvbmZpcm0g
dGhhdCB0aGlzIHByb3BlcnR5IGlzIHVubmVjZXNzYXJ5IGlmIHdlIG1vZGVsIGl0IGFzIFBvd2Vy
IHNlcXVlbmNlci4NCj4gPg0KPiA+IEZyb20gQUJJLCBwb2ludCBub3cgb25seSBtYXR0ZXJzIGlz
IHRoZSBwd3JzZXFfdGFyZ2V0X2RhdGEubmFtZSBpbiB0aGUNCj4gPiBwb3dlciBzZXF1ZW5jZSBk
cml2ZXIgYW5kIGNvbnN1bWVycy4NCj4gPg0KPiA+IGRzaS0+cHdyc2VxID0gZGV2bV9wd3JzZXFf
Z2V0KGRzaS0+ZGV2LCAiZHNpLXB3cnJkeSIpOw0KPiA+IHByaXYtPnB3cnNlcSA9IGRldm1fcHdy
c2VxX2dldChkZXYsICJ1c2ItcHdycmR5Iik7DQo+ID4NCj4gPiBGcm9tIHRoZSBleHBlcmllbmNl
LCBJIGRvbid0IHRoaW5rLCBEVCBtYWludGFpbmVycyB3aWxsIGFsbG93IHRvDQo+ID4gZGVmaW5l
IGEgdmVuZG9yIHByb3BlcnR5IGp1c3QgZm9yIHRoZSBkcml2ZXIgbWF0Y2guDQo+ID4NCj4gDQo+
IFlvdSBwb2ludGVkIG1lIHRvIHRoZSBub2RlIHNvIEkgYXNzdW1lZCB0aGlzIGlzIHdoYXQgaXQg
d2lsbCBsb29rIGxpa2UuIEkgZG9uJ3QgaGF2ZSB0aGUgZnVsbCBjb250ZXh0IGluDQo+IG15IGhl
YWQuDQoNCk15IGJhZC4gU29ycnkgZm9yIHRoYXQsIFRvZGF5IEkgaGF2ZSBwb3N0ZWQgcG93ZXIg
c2VxdWVuY2UgY29uc3VtZXIgZHJpdmVycyB3aXRoIERULg0KDQo+IEkgc3RpbGwgcHJlZmVyIHRo
ZXJlIHRvIGJlIHNvbWUgY29ubmVjdGlvbiBhbmQgdmFsaWRhdGlvbiBvZiB0aGUgcHdyc2VxIGNv
bnN1bWVyIHNvIEknbSBpbnF1aXJpbmcgYWJvdXQNCj4gdGhlIGFyY2hpdGVjdHVyZS4NCg0KT0su
DQoNCj4gDQo+IFBsZWFzZSByZXNwb25kIHdpdGggdGhlIHJlbGV2YW50IERUIG5vZGVzJyBmaW5h
bCBmb3JtLg0KDQpIZXJlIGl0IGlzLiBQbGVhc2UgZmluZCB0aGUgcmVsZXZhbnQgRFQgbm9kZXMg
dXNicGh5LWN0cmwgWzFdIGFuZCBkc2kgWzJdDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjA3MjkxMTUwMjIuMjIyMzQwLTktYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20v
DQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzI5MTI1NTE2LjIzMDc1Ny0x
NC1iaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbS8NCg0KQ2hlZXJzLA0KQmlqdQ0K
