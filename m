Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CE442FDB;
	Wed, 29 Jul 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321618; cv=fail; b=jKQW0JC3Zcc7rUgJaB7Jzd98hEFsUssrg0RSsnzu+pMiVPTNVlkSAEq41FebOG74Nzn/mhB8WFKcIhhPp9kBpkMQkwYRipErtZKiHvS195HT85QdfeCrIpn4n2ROVMvAJIbFsyx721cXXZDpjwtcRZ5vNHoUEGWOYyA5lXniDf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321618; c=relaxed/simple;
	bh=YONH9dBZgUuizy5t0vrG6oo6TFMCNVi3lJ9YKQfsYUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2gv4f7cd5u4rIMx1aHE9oAWWw1a1NwhKP2LpOACX5zJl2Aq5BvujO6xj0pCijKxvm+8IUvfA1eCv/fvwSPAI1RT3+C37wtdT88OTwQQDJBKC6RrRo/ZlpJwPFw9y/jnTW75rTUthDxKjm57ZNVyu2zoiBMyGMRrUgGoCLNT/rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NJU0dHNA; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NJU0dHNA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORE4A+upzU3WnF253kMgjQVE82DwK5pBEovMrFaOhQf+5ubsLPGIq97HkHGPybYztIwcwCoHfMbqq4KWo2sre4GoCXqBDS8cXrMVsPI/Crad/j4d7fSRqLmux3YhzFudb6jM+9lckcUzGAhAPlh6ASZ/USYMKsEk10rTzY1Cq0ea9y5mtFcteTNUGt6zSdR1Jhq6dSe7ETmAokRWD8qMi2/4izqFJtOM5+ioSy2o9R4I3AJRzqyW46WBm7JlpQapbdbgXJ44WNqWIV3U+RyopEkPXeK3pheeTJY+rwm5ARTqgD6N9HxSh7FyLsDGbEbnEJD8BzKfAkJ836VT8x9glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YONH9dBZgUuizy5t0vrG6oo6TFMCNVi3lJ9YKQfsYUI=;
 b=nH7Av7dv4M/Wz+eGZ6tMUsdzoTrvqsE/fLoLsKkZ4cAH1vbEZINXRqU66kMC/R66s2Q3Y+2ofvRaZgBjPjBzEdsddSpeOJ9vRANVpKWc43JVxxtrrBuaPAvRPRiSXXAeDDkQzXweKKA+YcZ1/BCF+lzbRixNRudxYw48/vjppEb+qGv6IknMnXMFKCpHwAJTVeXWxuU4sOBEAOK8MYHx1ABSavYGLv0uTC6PC/+9Rrc3G/+wwaurX95jYIAt0Is4uTa+aadlX3KmcS+xd5joobguQYdaqaE+G69a7T/CdeaMv+JrUe0RkSMTD5jGMUTGwHa4lua3YtgDzXAQzIBJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YONH9dBZgUuizy5t0vrG6oo6TFMCNVi3lJ9YKQfsYUI=;
 b=NJU0dHNAcbT264qWUHPZYa+/pqWJdjJtzg3gJTp44uDgWLtIVGHXhAeXq5/AVJIb+73MZGziW1WcwLXMlEKqt5d/r8/oY6gb0cihUYllsk1qZAy3614BBfdQMxbUYj9ONfGowaPc0VhYH7kZYhxT31sREBlnbDR9H4P5hacg6kk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB15064.jpnprd01.prod.outlook.com (2603:1096:604:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:40:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 10:40:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "biju.das.au"
	<biju.das.au@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, "magnus.damm"
	<magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Topic: [PATCH v2 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Index: AQHdHz0G64tSZXEuqkGIBILeZ7ZvR7aERa2AgAAHDfA=
Date: Wed, 29 Jul 2026 10:40:06 +0000
Message-ID:
 <TY3PR01MB113466D22C84727EB98FB917D86CA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260729093112.98324-1-biju.das.jz@bp.renesas.com>
	 <20260729093112.98324-3-biju.das.jz@bp.renesas.com>
 <25ce87017f0871e10bebd5fd43194b16026aaa04.camel@pengutronix.de>
In-Reply-To: <25ce87017f0871e10bebd5fd43194b16026aaa04.camel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB15064:EE_
x-ms-office365-filtering-correlation-id: fc356cfc-4525-43a4-c085-08deed5dc129
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|38070700021|6133799003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UbB7DKkdeW7KMHns7vuxHBG4xRfMbI0LMcP8wAaa0bec+U1V70N77m+YmELA7dbcRdxXPX+A4dT5OgnYuBK5Y5O3Z+l6zfmYRq6j6Nj7gR0QfR5Amt4JJ+bM5OdB2oOJ5fBGAZmabaXRnxx4zojE0wmgbf6iLH4pYHhEEHHcB+GOuX3MU2ssFp5tFdgXVF4JtYWu83907wnyABQouxhoskA/0YhcC7dGcbOXxtC2n/9LvBC9Va5xCnD9muuWZb5/OOKLnLvLZ1AL3plFDgxo8ragBgjjaE4betbPH5PTtQEYfHAM8xHx3J1mAoKHuphSyKxu1tUBg+aRjg/WieJngWlNRRaDrcIm395icYNPd9OTuVT5Ci2lRyqT+ybmy2CLR2Y0Em/0C8U9QyRk0xVGsS/rgSfZWQ5hoYkZglIs0D+ymyEqff3QrVwWyKVuzA+F9Ajj5YbKJWVauYmY9AHNWaGpCnLTgPiBQYL5ZhUqNv5+YEV7+yHglw5LnuPkRDfSBKCKkU8DKK9wz8RRF+ReFtzNBMvp8Av16apnKxm+L9Rnty1ju6Msu0I7gVc9JCpk+6o0jXTtTtrS3qV8DCh9e+VyU2qV+LvG5gS0HJ5hZ1zKQydknhOUyyLzUaauhyG5lkkY0VlKsXGhrfkkuWJ6zzlHflETY0IQ2jwbmDryqx6bSAmi7z7M5epdVv/6fFYgfBY9UrWbvu5duq9wGs27Iw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXpZQ3lyWU0zeGFteUdHa3lQM1BBR1VnK0tHTEFDRFFONjRNdnZxRWdVQXVa?=
 =?utf-8?B?M1NNQ3JDdWRnTVRuK2dwbklHeVlJV1cxMWttYXhTL3N6ZHN1WmJEVkRPRkll?=
 =?utf-8?B?ZDFsWno1SnBvRUlNM3dxK2RtUHpEUHV5bFNBQU1vUW0ycHJkTSs5WWlUcXZy?=
 =?utf-8?B?R0J2RU9BWWVyMDNQVStSS0I2Z2RGdzJ0VzNuKzVkZlNFRk9qenVIZzBrQ2Jy?=
 =?utf-8?B?bmlKNHpMS1lPdjd0eklNYklpRGVYd3p2THJBYWxSOTE3eXFoUlNnNzU4NGJv?=
 =?utf-8?B?Szc3RFc2QjhZc0paSHJDTmQ2SXBBVjRxc1pnQk1DQUNuQkxQMHZFSUdvUk9F?=
 =?utf-8?B?LzdUaTk5WkNvZmJaeElyazhaK3E0eHpOUkV3bjNMRzBqN2s0MWVMSVkvdU4z?=
 =?utf-8?B?WkxOclJwNm1Bc1lBVTM4bEtoQWpEOXFhSmhzQnJ5RGY5SUM4WmR4Vk9BSzBu?=
 =?utf-8?B?RVdocGtHZkltZzk2QThHL0N3MUt4WFIvVEY4T0hwcFBFUDRaYm83SmNxeHRQ?=
 =?utf-8?B?MER1WXdDaHZCTDF4aEozdFZ2SkRRSU5aTlpJdFlYdTY5bU40N3VTTmJ3bjNL?=
 =?utf-8?B?UmM3Q09zTEI3dEJzQmp3SHBIZlpEbHJOK2lRVFhJTGdJQW54aHJMWm1DcEZQ?=
 =?utf-8?B?RUl1YXhsZTFtamM1dWRieDlOczc1MkNDUTdkVU81TUJYbjFCM2FSVTg1aGJm?=
 =?utf-8?B?ZUNKVU4xUnhOcEIwWWx4Q0o2Q0FVZXI2ekJqK0pCaVpaNUgwYVJmMDQxeWpo?=
 =?utf-8?B?d3VmTU9vOE5rMy9FemJqc1FydEptendzVllkTEo3and6eDRJZWE5NWd4VSto?=
 =?utf-8?B?Rm8vR2JFMVpjY1p6T0R6ZXNQMjFoNjU0U1VmblhXays3c3lzWUV6dGRndDJF?=
 =?utf-8?B?QnlFUyt2RzlUQXdMazhaV09UMUIxb2hibjdwUFQzL2p1NTRTdjNXT3ZSNmdv?=
 =?utf-8?B?WWZkeWV6OHI3eXV6TDNqN205ZGIvVEtjRmRlSmVzYkFLVUJiOFZiLy9XTi9Q?=
 =?utf-8?B?ayt0dUpXcmQ5aFB0Mm5kaGE3V0ZGUDhXYkpQRmFDWUw3OXljOERacktGVFM2?=
 =?utf-8?B?QWxuK0MxQkxLV2U4WDFqVU90elZPaU91MjlCMGZneDBCWjRRTkpiU2xsdjBx?=
 =?utf-8?B?K3VQUjZrdU1Cd01TZHpLMENPTVFXbVdBZ1hmS2J6aWZHQ2xmbjV1dUxlWE5r?=
 =?utf-8?B?dzAvcnc0VEhPRmVBMHZqRzIwNG9ZSGZRbHBVczhDV1VJNy9wQWxPeFlmZjB0?=
 =?utf-8?B?YzlQd0NGWHkvb1lLK2xORk02TytiZ2I2SkdvbHQzWlJFYkNkdmFoQWd4aDdS?=
 =?utf-8?B?RXcrcEE3b0o1YVk5bVU0N0RpMDU2b29PcWVqWDZLMFF1YkQ4M0VmRXpjdDhx?=
 =?utf-8?B?Tzcwb1Jrb1d2bXg2cFVCdjhzRkhpbllvcm5qYWhUTE0zalg0a2N3UEw1czJZ?=
 =?utf-8?B?Z3dTSVl2OEw2VG9SRW1keTAwaFo5REJFTjRCSnVZWUFFRHoya3RXeW5LVzFi?=
 =?utf-8?B?UTd4TkRlWk9XY0R6WmltUXkwaTl1NS9DbmF2THFBd3M5YVB2cWx1cXJiQkl6?=
 =?utf-8?B?Sm9iZHRCY2g3TC93SkduSGZtbTBrN3JxWERNdi9aWnMzV3NIZnpuNjhjYmtJ?=
 =?utf-8?B?aHpEN0szMWlaays4NXd0TkNVRWk1bUUwb2F3WmdzeitrWVN2eGNwMEFDeUJR?=
 =?utf-8?B?VURwalFYeC9nU0RZSkFKazIzREJ6VDZuTFBPc0N4TG1VcEVtbWtmQ0NrSCtO?=
 =?utf-8?B?QnpXSE5mL3RYZVNITXhHTEVxK0NWMjB0MGlQaTcrcXZXbmwyUEV0Qms2WGF4?=
 =?utf-8?B?MWxOWDUveERsYnF3RFRRR3RRc1RROERMQlVIaExvNTVxK0MzYWh0ZkFkSHZI?=
 =?utf-8?B?SlZlekl3TnVJd3poWkNZcjFBMFFUcm5NenpsbFVHTkhmY1R6YmkyRWdyNzBu?=
 =?utf-8?B?WlhyeFlZczJhM3JaL21ST1NrZU84U2hBMVhIZnRNMXlBQWp6ZW90aDVBV05J?=
 =?utf-8?B?SG5kbXNXSU1rRGJvaDRHQTN1SGlQeUpxRFBxbmtLQzlOSEJvOFpRNHlKMVRO?=
 =?utf-8?B?VEZVUVFWdkRVTzEzd0xTNmJtaDlKWUhHc091VlY0VU5LQS9tdXZqTDMvYUNp?=
 =?utf-8?B?alBjU1lsSGtzaGlOM01KOHJFcWVjYjhmNTYxNUc3ZFRXeFFpS29zbWU3MFpH?=
 =?utf-8?B?UFBxeVJPSXNPU1A3RDg2VzE3bzE4OFc3bkZ6RzRmc1FVUS9Ha3VveERWZjF4?=
 =?utf-8?B?WUNxM0JtdmpRdEJ4bEpEMllhdzJ4QlM2VkdMTTVHZWwwK1dWd2FvRXJZNFU5?=
 =?utf-8?B?aERUWU5lMFZUMm44WFlyR1hpeGxEbFhzZzlMM3Fnd01JRWtiZEcxUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc356cfc-4525-43a4-c085-08deed5dc129
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 10:40:06.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkshyaopnTDsf0dQT7Irhc0XfYMq+rFvqFxgGfj1bgCmxWBWgyUm5TlxD5stP71X8lsjk3pYLbqn8K4c8AlWx5ZtbHK3ZIROkJ3qa9r7/uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15064

SGkgUGhpbGlwcCBaYWJlbCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5n
dXRyb25peC5kZT4NCj4gU2VudDogMjkgSnVseSAyMDI2IDExOjA4DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi8zXSBwb3dlcjogc2VxdWVuY2luZzogQWRkIFJlbmVzYXMgUlovRzNMIFBvd2Vy
IFJlYWR5IGRyaXZlcg0KPiANCj4gT24gTWksIDIwMjYtMDctMjkgYXQgMTA6MzEgKzAxMDAsIEJp
anUgd3JvdGU6DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+DQo+ID4gQWRkIGEgcG93ZXIgc2VxdWVuY2luZyBkcml2ZXIgZm9yIHRoZSBSZW5lc2Fz
IFJaL0czTCBQV1JSRFkgbW9kdWxlLA0KPiA+IHdoaWNoIHNpZ25hbHMgcG93ZXIgcmVhZGluZXNz
IGZvciB2YXJpb3VzIElQcyAoVVNCLCBEU0ksIENTSSBldGMuKSBvbg0KPiA+IHRoZSBTb0MuIFRo
ZSBkcml2ZXIgYmluZHMgYXMgYW4gYXV4aWxpYXJ5IGRldmljZSB0byB0aGUgcGFyZW50IFNZU0MN
Cj4gPiBkcml2ZXIsIHVzaW5nIGl0cyByZWdtYXAgdG8gdG9nZ2xlIHRoZSBTWVNfUFdSUkRZX04g
cmVnaXN0ZXIgYml0cywgYW5kDQo+ID4gZXhwb3NlcyB7dXNiLGRzaSxjc2l9LXB3cnJkeSBwd3Jz
ZXEgdGFyZ2V0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2MS0+djI6DQo+ID4gICogQWRkZWQgYSBj
b21tZW50IGluIHB3cnNlcV9yemczbF9wd3JyZHlfbWF0Y2goKS4NCj4gPiAgKiBEcm9wcGVkIGRl
dl9nZXRfcmVnbWFwKCkgZnJvbSBwcm9iZSBhcyByZWdtYXAgaXMgbm93IHBhcnQgb2YgcGxhdGZv
cm0NCj4gPiAgICBkYXRhLg0KPiA+ICAqIEFkZGVkIGEgYmxhbmsgbGluZSBiZWZvcmUgZGV2bV9w
d3JzZXFfZGV2aWNlX3JlZ2lzdGVyKCkgaW4gcHJvYmUuDQo+ID4gICogRHJvcHBlZCB0aGUgZXJy
b3IgbWVzc2FnZSBkZXZtX3B3cnNlcV9kZXZpY2VfcmVnaXN0ZXIoKSBhcyBwcm9iZSBwcmludHMN
Cj4gPiAgICBmYWlsdXJlIG1lc3NhZ2UuDQo+ID4gICogRHJvcHBlZCBsb2NhbCB2YXJpYWJsZXMg
ZGV2IGFuZCByZWdtYXAgZnJvbSBwcm9iZSgpLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bvd2Vy
L3NlcXVlbmNpbmcvS2NvbmZpZyAgICAgICAgICAgICAgfCAgIDggKw0KPiA+ICBkcml2ZXJzL3Bv
d2VyL3NlcXVlbmNpbmcvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAuLi4vcG93
ZXIvc2VxdWVuY2luZy9wd3JzZXEtcmVuZXNhcy1wd3JyZHkuYyAgfCAxMzkNCj4gPiArKysrKysr
KysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNDggaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wb3dlci9zZXF1ZW5jaW5nL3B3cnNlcS1yZW5l
c2FzLXB3cnJkeS5jDQo+ID4NCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dl
ci9zZXF1ZW5jaW5nL3B3cnNlcS1yZW5lc2FzLXB3cnJkeS5jDQo+ID4gYi9kcml2ZXJzL3Bvd2Vy
L3NlcXVlbmNpbmcvcHdyc2VxLXJlbmVzYXMtcHdycmR5LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzIzZDU3NGMzZjEwDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcG93ZXIvc2VxdWVuY2luZy9wd3JzZXEtcmVuZXNhcy1w
d3JyZHkuYw0KPiA+IEBAIC0wLDAgKzEsMTM5IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIFJlbmVzYXMgUlovRzNMIFBvd2VyIFJl
YWR5IGRyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9hdXhpbGlhcnlfYnVzLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3B3cnNlcS9wcm92aWRlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
cmVnbWFwLmg+DQo+ID4gKw0KPiA+ICsjZGVmaW5lIFNZU19QV1JSRFlfTgkJMHhkNzANCj4gPiAr
I2RlZmluZSBTWVNfUFdSUkRZX05fVVNCX01BU0sJQklUKDApDQo+ID4gKyNkZWZpbmUgU1lTX1BX
UlJEWV9OX0RTSV9NQVNLCUJJVCgxKQ0KPiA+ICsjZGVmaW5lIFNZU19QV1JSRFlfTl9DU0lfTUFT
SwlCSVQoMikNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcHdyc2VxX3J6ZzNsX3NldF9wd3JyZHko
c3RydWN0IHB3cnNlcV9kZXZpY2UgKnB3cnNlcSwgdTMyDQo+ID4gK21hc2ssIHUzMiB2YWwpIHsN
Cj4gPiArCXN0cnVjdCByZWdtYXAgKnJlZ21hcCA9IHB3cnNlcV9kZXZpY2VfZ2V0X2RydmRhdGEo
cHdyc2VxKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKHJlZ21hcCwg
U1lTX1BXUlJEWV9OLCBtYXNrLCB2YWwpOyB9DQo+IA0KPiBEaWQgeW91IG1lYW4gdG8gdXNlIHJl
Z21hcF9hc3NpZ25fYml0cygpIHdpdGggYSBib29sZWFuIHZhbD8NCj4gU2VlIGJlbG93Lg0KDQpO
bywgT3JpZ2luYWxseSwgSSBwbGFubmVkIHRvIHVzZSByZWdtYXBfdXBkYXRlX2JpdHMoKSBidXQg
dGhlcmUgd2FzIGxvZ2ljYWwNCm1pc3Rha2UgYXMgeW91IHBvaW50ZWQgb3V0IGJlbG93Lg0KDQpJ
IHdpbGwgdXNlIHJlZ21hcF9hc3NpZ25fYml0cygpIHdpdGggYm9vbGVhbiB2YWwgaW4gbmV4dCB2
ZXJzaW9uLg0KDQo+IA0KPiA+ICtzdGF0aWMgaW50IHB3cnNlcV9yemczbF91c2JfcHdycmR5X2Vu
YWJsZShzdHJ1Y3QgcHdyc2VxX2RldmljZQ0KPiA+ICsqcHdyc2VxKSB7DQo+ID4gKwlyZXR1cm4g
cHdyc2VxX3J6ZzNsX3NldF9wd3JyZHkocHdyc2VxLCBTWVNfUFdSUkRZX05fVVNCX01BU0ssIDAp
OyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHB3cnNlcV9yemczbF91c2JfcHdycmR5X2Rpc2Fi
bGUoc3RydWN0IHB3cnNlcV9kZXZpY2UNCj4gPiArKnB3cnNlcSkgew0KPiA+ICsJcmV0dXJuIHB3
cnNlcV9yemczbF9zZXRfcHdycmR5KHB3cnNlcSwgU1lTX1BXUlJEWV9OX1VTQl9NQVNLLCAxKTsN
Cj4gDQo+IFRoaXMgaGFwcGVucyB0byB3b3JrIGNvcnJlY3RseSBzaW5jZSBTWVNfUFdSUkRZX05f
VVNCX01BU0sgaXMgMS4NCg0KT0suDQoNCj4gDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgcHdyc2VxX3VuaXRfZGF0YSBwd3JzZXFfcnpnM2xfdXNiX3B3cnJkeV91bml0
ID0gew0KPiA+ICsJLm5hbWUgPSAidXNiLXB3cnJkeS1wb3dlci1zZXF1ZW5jZSIsDQo+ID4gKwku
ZW5hYmxlID0gcHdyc2VxX3J6ZzNsX3VzYl9wd3JyZHlfZW5hYmxlLA0KPiA+ICsJLmRpc2FibGUg
PSBwd3JzZXFfcnpnM2xfdXNiX3B3cnJkeV9kaXNhYmxlLCB9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBwd3JzZXFfcnpnM2xfZHNpX3B3cnJkeV9lbmFibGUoc3RydWN0IHB3cnNlcV9kZXZpY2UN
Cj4gPiArKnB3cnNlcSkgew0KPiA+ICsJcmV0dXJuIHB3cnNlcV9yemczbF9zZXRfcHdycmR5KHB3
cnNlcSwgU1lTX1BXUlJEWV9OX0RTSV9NQVNLLCAwKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBwd3JzZXFfcnpnM2xfZHNpX3B3cnJkeV9kaXNhYmxlKHN0cnVjdCBwd3JzZXFfZGV2aWNlDQo+
ID4gKypwd3JzZXEpIHsNCj4gPiArCXJldHVybiBwd3JzZXFfcnpnM2xfc2V0X3B3cnJkeShwd3Jz
ZXEsIFNZU19QV1JSRFlfTl9EU0lfTUFTSywgMSk7DQo+IA0KPiAxIGlzIG5vdCBpbiBTWVNfUFdS
UkRZX05fRFNJX01BU0ssIHNvIHRoaXMgd2lsbCBjbGVhciB0aGUgYml0LiBFaXRoZXIgc2V0IHZh
bCA9IG1hc2sgb3IgdXNlDQo+IHJlZ21hcF9hc3NpZ25fYml0cygpLg0KDQpUaGFua3MgZm9yIHBv
aW50aW5nIG91dCB0aGUgbWlzdGFrZS4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBwd3JzZXFfdW5pdF9kYXRhIHB3cnNlcV9yemczbF9kc2lfcHdycmR5X3Vu
aXQgPSB7DQo+ID4gKwkubmFtZSA9ICJkc2ktcHdycmR5LXNlcXVlbmNlIiwNCj4gPiArCS5lbmFi
bGUgPSBwd3JzZXFfcnpnM2xfZHNpX3B3cnJkeV9lbmFibGUsDQo+ID4gKwkuZGlzYWJsZSA9IHB3
cnNlcV9yemczbF9kc2lfcHdycmR5X2Rpc2FibGUsIH07DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50
IHB3cnNlcV9yemczbF9jc2lfcHdycmR5X2VuYWJsZShzdHJ1Y3QgcHdyc2VxX2RldmljZQ0KPiA+
ICsqcHdyc2VxKSB7DQo+ID4gKwlyZXR1cm4gcHdyc2VxX3J6ZzNsX3NldF9wd3JyZHkocHdyc2Vx
LCBTWVNfUFdSUkRZX05fQ1NJX01BU0ssIDApOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHB3
cnNlcV9yemczbF9jc2lfcHdycmR5X2Rpc2FibGUoc3RydWN0IHB3cnNlcV9kZXZpY2UNCj4gPiAr
KnB3cnNlcSkgew0KPiA+ICsJcmV0dXJuIHB3cnNlcV9yemczbF9zZXRfcHdycmR5KHB3cnNlcSwg
U1lTX1BXUlJEWV9OX0NTSV9NQVNLLCAxKTsNCj4gDQo+IFNhbWUgaXNzdWUgYXMgYWJvdmUuDQoN
CldpbGwgZml4IHRoaXMgaW4gbmV4dCB2ZXJzaW9uLg0KPiANCj4gWy4uLl0NCj4gPiArc3RhdGlj
IGludCBwd3JzZXFfcnpnM2xfcHdycmR5X21hdGNoKHN0cnVjdCBwd3JzZXFfZGV2aWNlICpwd3Jz
ZXEsDQo+ID4gKwkJCQkgICAgIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJLyoN
Cj4gPiArCSAqIFRoZSBwd3JyZHkgcHJvdmlkZXIgZG9lcyBub3QgcmVseSBvbiBhbnkgZGV2aWNl
LXRyZWUgcGhhbmRsZS9wcm9wZXJ0eQ0KPiA+ICsJICogbWF0Y2hpbmcsIHNvIGl0IHVuY29uZGl0
aW9uYWxseSBtYXRjaGVzIGV2ZXJ5IGNvbnN1bWVyIGRldmljZSB0aGF0DQo+ID4gKwkgKiByZXF1
ZXN0cyBpdC4NCj4gPiArCSAqLw0KPiA+ICsJcmV0dXJuIFBXUlNFUV9NQVRDSF9PSzsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBwd3JzZXFfcnpnM2xfcHdycmR5X3Byb2JlKHN0cnVj
dCBhdXhpbGlhcnlfZGV2aWNlICphZGV2LA0KPiA+ICsJCQkJICAgICBjb25zdCBzdHJ1Y3QgYXV4
aWxpYXJ5X2RldmljZV9pZCAqaWQpIHsNCj4gPiArCXN0cnVjdCBwd3JzZXFfZGV2aWNlICpwd3Jz
ZXE7DQo+ID4gKwlzdHJ1Y3QgcHdyc2VxX2NvbmZpZyBjb25maWcgPSB7DQo+ID4gKwkJLnBhcmVu
dCA9ICZhZGV2LT5kZXYsDQo+ID4gKwkJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ID4gKwkJLmRy
dmRhdGEgPSBhZGV2LT5kZXYucGxhdGZvcm1fZGF0YSwNCj4gPiArCQkubWF0Y2ggPSBwd3JzZXFf
cnpnM2xfcHdycmR5X21hdGNoLA0KPiA+ICsJCS50YXJnZXRzID0gcHdyc2VxX3J6ZzNsX3B3cnJk
eV90YXJnZXRzLA0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlwd3JzZXEgPSBkZXZtX3B3cnNlcV9k
ZXZpY2VfcmVnaXN0ZXIoJmFkZXYtPmRldiwgJmNvbmZpZyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IElTX0VSUihwd3JzZXEpID8gUFRSX0VSUihwd3JzZXEpIDogMDsNCj4gDQo+IAlyZXR1cm4gUFRS
X0VSUl9PUl9aRVJPKHB3cnNlcSk7DQoNClllcywgaXQgaXMgbXVjaCBzaW1wbGVyLg0KDQpDaGVl
cnMsDQpCaWp1DQo=
