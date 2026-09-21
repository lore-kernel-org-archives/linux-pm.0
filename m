Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010061.outbound.protection.outlook.com [52.101.229.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA1175A80;
	Mon, 21 Sep 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956203; cv=fail; b=nBQJR8CrwwasrFeHDv25cQuPS5kuo6Wnq9r2IfGzyHtfSQgcfqqHBrhfl/Ea/SNFbf+qhQrH/rca7aAqXOwWcmGChWCpWee0RWG+firVNpp0sav2JjzOKaoBeztaCtBG+RI5bBr5kltal9pj+Uy6XOh/vG+4Uh9BInMklSW/GQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956203; c=relaxed/simple;
	bh=2L2va3bsv6NxzQh/+pSfM/94Rq9LwhgSz+HuWvlraJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVzKNoI8raqHB3SC7X0j0VjAvZedIW7FVue6bztmOSydeTMxOZzzgSneMeR+wx2OhiNX2MBD0WTGS+uW8D5x73+AfsiLTuJMIHXdOhs3eBqeJXKgYQgSQ3FLZv1moa47c0V+LfhI/3S5zTsJ+QtfyXKlLri3iaNA6i8twOmWf94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iyoe6Xdp; arc=fail smtp.client-ip=52.101.229.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iyoe6Xdp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIsa6ZUaOXx2R71nfiull8JCuJgYfEtVsyPoQ8SU1EY+WfeBfkL0WWSjhbDw11tJH9VTJwGmGafb2xxm+l6hupNARa2jdNXfNpwVIydBtShkgxDuR2AOaTvwtCHrcOSByrnvwYx6VOjM/tTA/jviztrEem1y6p8OZZfdqQQ7vAGuQCMjnh2EE31OswWYU2di4DZejP/55LB/PVQ4LC4ZM4bDVNPJt7F335UZGMxSV/b/ki6yc2JiSyBGpEktDuDIrvRycC8T0AA3ySSFP64N0qscJzKAakdUar8ZnRmff4RwiRWf2hYTNWk6tqRM+zzs4OIUquRZEoJ9BpzPZ6SZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L2va3bsv6NxzQh/+pSfM/94Rq9LwhgSz+HuWvlraJw=;
 b=laIPkXqhLG6VkSKcAYnxzUGbCZE98GTNKWsCPJfQKPecjcnn9ELB2PqFWr0sg6LjofPfcjBF3GXRHO7iZJDfi4xaD4Pr+3D9ABkA0g0OlbZ0MaK5V3POfYjfgfFOJx/fYpUyhkmVYRne3FBwY9vsj/SiQ67Vc7kC7bgukZW3WG+Ym3XqFwAZBZIXwKqT0z+AI0K7TS73+85IZcZoaTJCawO9kqSMpBbBtlYmFlRV9358lZgnxS9u4xyBUYYsZBKBFgzS8XZVXXq7HH3USMRn4Qovvx3SAQH4YHuc2+wBiIWLU5EAICIQomd76TTctln/9V0/oksziNotox6zMYNWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L2va3bsv6NxzQh/+pSfM/94Rq9LwhgSz+HuWvlraJw=;
 b=iyoe6Xdpmze+m65AG7a1AgYSne27pzU5MFFcvN5cPbRwBCK8p+2lytkjrnJNddgPsXMv6TTc4O4NxkaXwisPr3AyyeFXSGNW5WyaB0WgiB1uUpjkNTg5K823hILFSuWfaZ+UpUurHmTonEA+7j3890eQ92jenthpfwJVKTKnf/c=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15778.jpnprd01.prod.outlook.com (2603:1096:405:2ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:03:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 02:03:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, David
 Lechner <dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Topic: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Thread-Index: AQHdR3+mk+uISRMiQkaZ58GDWCu11bbXvvYAgACHuFA=
Date: Mon, 21 Sep 2026 02:03:18 +0000
Message-ID:
 <TY3PR01MB113466E3B9C0DDFC619C2549186842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-7-biju.das.jz@bp.renesas.com>
 <178992596604.706584.10451227613547984363.b4-review@b4>
In-Reply-To: <178992596604.706584.10451227613547984363.b4-review@b4>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15778:EE_
x-ms-office365-filtering-correlation-id: b70ad9e7-b227-49d6-0052-08df17848145
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 gMIjoRSxyN4+0nQbdh0Tz1qZVCSl/C/FeU5LpEACX8pmeyFEYoRkF0rV07rp+EWMr7s+77fXB9RgwZEnwvBnrk+Srr8yz7BBGUOJdJmwjcEkpNsbneTAkIjR2jxvSoz9bmeQoUYJUbIAJ1ToIOhNktIsAexEHEdfCJEPNewNQnekWXiRbf3dkH/ofymEZV0k1rULpNnLbIfENCcSGozEinjfmBaHUTc68Wy9k5RbaQUYSesbG6Tz+v4dc1O4xvRd8Js5v8tGaZCPKBebRrAmtaJwgyZqq3YFdJAktvQH4BqL0IYiCkn2VmlxXA6JKVbLOD8tqo6Nh9MU84tXeBoJ/DJBPh5PiwSrpKtga7+bX7+1LCCJAnJySUfMS8uWkgD188T/0c5Wf4nA2lU1p0EWXhbDaH+/7Sr/vAw7dSH7Djp1vJVlnUctDLannenQdoSd3O7zrBHjLxnG5/Sn216fQuoG4LnJWtpc87m8DldsaBsgwWI/qdHWT+FgiezKMD+KNrQ100B0l8UHv1JUeyN7mGAyp8fHWmasBnAo2mvrSMgEBWSEc/Mwg1UVfo8y+tDCzfc1ZY+8JhaNdyGmRuzrO01WvmkK1+xD6bbwrFyccoSh9tPWBEAv4kSn9rvknugDLB+pHY5vXB+7dSvWOMibRiBdbiFwsEAHmi/9cg19NJv+/GUdoX2Mybt+GAkXEnl1U6MC0B35RqLQDkADQiKp3Jl4cgXCy/tfDyLb/URH/Qo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDlnUWZqelRQOEN4Y0I4bWU0TVpSRVBsSXU3WjRITElMUnNzNWVhQnZJd1Zz?=
 =?utf-8?B?TVdQYXM4MTBIY2NCZGE3VUQ2MnEwb25GbkdsWHpEYm1oR1R1bUdHYzhqVFA4?=
 =?utf-8?B?NmJwbUNLaExyUVdPUTFNTTZQYzEvck4zSDdZZzM5dlhyV0dqcGVYUEQxcnRk?=
 =?utf-8?B?QSswWElyQjZzQ0hUSXNkeVJ6cFdMWHArNzAxN1BHV256REpacFI1T3lCaWs4?=
 =?utf-8?B?MEcrQjRrdWhYUTYrcENLZW1hMlA5N3pzdk9JaENQVWlBTnk0TFZBRWczT3hG?=
 =?utf-8?B?UjU1YTVBOXBlZm5ZSnJjSWkraDVnOFUyVXdOU2NPM1hkZjFrT2w5b0cwYldI?=
 =?utf-8?B?WXJGOUJPVTNLQk9mQU9xeHZWTjU2MDc3aTVkNGprOEdKM29UQjhHVnZsWmYz?=
 =?utf-8?B?UXVBVXdiR3J1cnNXTldIM2NLNnh2Rks2MTlGbkU4UFNxOHhxQjhxWDBFbWtY?=
 =?utf-8?B?TnhwQWtoNnVxNXBHUWVEQkRENXNQN0pXQlIwOUFXektXbGlTc2EzWXR3Qzhq?=
 =?utf-8?B?Z0tmZkRCelo0NW4zVzBtTVQxclFvd2Q1eWhGcHZNWGVaYWFOTzV3MkZHV0xq?=
 =?utf-8?B?dE55aUtodWpxYzNCU2I2b29mSmJyMFNteDh5YmRkSk14RHRaRWFDSldiTzVZ?=
 =?utf-8?B?UXAzTzE2dHR1Z05HejVjSFkwckRUUXpudzkwcTc1VkJtVFhVT3BIYVRHMzEw?=
 =?utf-8?B?OUZvM3hqRTZSemNZK2VDVUxYdXdSN04ySS9qVG8xNDR1emZIOElWeklrQ0ly?=
 =?utf-8?B?TCtZYUhJZ2FtUkRtMXdOSGR0YmhaM0tFdW9reTdMckdETUw1UzlvTUlwY3pB?=
 =?utf-8?B?SUhTUUVOMFJHSWRQWkhKVHdIS1c4aVN6b2h0MnZCOCtVdHQxQlo2c201NFUx?=
 =?utf-8?B?OFIvbGNPQlljSnJZZ3R5U2RJRmtmT3VwV2RjT3lZQVJNQlB5UHErNmMvU1pB?=
 =?utf-8?B?MWdmSmo2WEZ3Smh3eityaTQ3SnhFUmdCSHNidnZ1cEQvOS9pcTEvYUZhNzN5?=
 =?utf-8?B?RlE5Z3l4ZmpjSndYd2FMSjR6Yi96TDZyQlo0cUlmRzRpaTRYdEVsMTB4OXZO?=
 =?utf-8?B?bzIxc1N3QklqdTJEYnRTaVRGUC8vVXg4RlhqT1Z5R0ZBUDdpWUJ4b05WR05k?=
 =?utf-8?B?M3lUZWRhcEtKdFYrenROMDl2RjNwR05yOGVnNjNzbHVQOExtMU9lQS80bHQ5?=
 =?utf-8?B?RUtlcmJKYVAySzBpeHUrTTZldHlmWmsrdXFUWmdRTm5BSnNqV3B0QWdXR1FL?=
 =?utf-8?B?MFRZaW9kS1ZiNkhra0d1VW4zZ2VPanpReHZ3TjNxWmh1WW1mZmdyNGNMcTZL?=
 =?utf-8?B?T3hpQ095V3I0cXh5R0dVTldvVnpScUxGWlllRThSekRUWGRzcHp5ZG9nTEdx?=
 =?utf-8?B?d1lPUTVtUSs0REpmMEJVOVBwVG9OVHpnUkZja2x4bnJ6RWhFNDNQelNFc3pO?=
 =?utf-8?B?MEpsWTdXa2JuTkNROHRkZXVwN0NtYnN0VXJHMEE4bXY3ZlBORFhHc2IyN25U?=
 =?utf-8?B?UmNQOE9EUzF5WWJuNmxWSE1hZm85ME5VVkZtcUR5Z01uUnlYTjZ0dFBFb1Bp?=
 =?utf-8?B?UGhLYVp6YS9LQmVTNFY5bFlaSVhQazVFU2VqMzg5NkZrNnd3Qk5RL2ptenAw?=
 =?utf-8?B?SlRRc2VsZHBTWWd0T2prNjh2NDhDQ3I4SHFQOXZpOWZ2Z0lwL2hyS1FiQVZ6?=
 =?utf-8?B?aldqY2ViSHRFbjdXT1ZFdFNtWU9ncDk4M0JFQWt0YXVBZlY0Q0lxaDhzWGhO?=
 =?utf-8?B?YWpEREdKMkJKMXFRRjhCRkVEU0VQTzZLS1FDZ2NMbnpQNDlyck11bVliTjRT?=
 =?utf-8?B?Y1JYOE5OeGkraGk5Rk15dVFtSSt2dWNORjhMYURCVXkrVFNDUzNVMG85bElL?=
 =?utf-8?B?SU53ZXJaTjVDUEV1SWUyRGZFY3Q0U0NoUDBXa2p5bkVFNFZJZUxhakhGU0Nz?=
 =?utf-8?B?bHM3YmhOY1FWUUdSZW1ES0g1Q2hXQVFqYjE3MmpicFo5QXZhaCtEYzdFVVl0?=
 =?utf-8?B?S1lQOUFPVmZPaGlVaUhJL3pzN1V6UHAwY2JYMmI1a1Fkd2Z3NWhGeU9aNjdT?=
 =?utf-8?B?eFdDZVpzOXRkdUF3V2UzMll0Y0FQdFg2bjdMZlBjVG13UUlzdnovVkhOTkRH?=
 =?utf-8?B?ZFNtSTVQVDRQMGxCZjdhR1hGcmplMGovS1pHOFoxZHBGdlpaUmFkc1dRb3lR?=
 =?utf-8?B?UXFPQzJzSFZNSFVGcEw5d29wMzNhSjRMR0RxbUI4OS9OblZYREw3VjNzd0kz?=
 =?utf-8?B?VGh4dTBBQmg4YUtIQUVob0hUTm5vR1NBMDRyMjdlVDdFYzROazJ2L21STXpy?=
 =?utf-8?B?OHg0NEVWU1k2c1Rlc0pJSHoyUGdRT1JzTzBzRVlIeXpWWnBwVmdVdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b70ad9e7-b227-49d6-0052-08df17848145
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 02:03:18.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TFd0iVUZuRjvlvDD9MTRHwPwySkOLoCW1n/nYg+iCIm2V6hULiZXRLAbAo+rXK2WsagKzw7j0mn16ANjCWscYHhZpQpAjStjmB+K3XquJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15778

SGkgSm9uYXRoYW4sDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IDIwIFNlcHRlbWJlciAyMDI2IDE4OjM5DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgNi84XSBkdC1iaW5kaW5nczogaWlvOiBhZGM6IHJlbmVzYXMscnpnMmwtYWRjOiBEb2N1
bWVudCBSWi9HM0wgQURDIGZvciBUU1UNCj4gDQo+ID4gQWRkIHJlbmVzYXMscjlhMDhnMDQ2LWFk
YzEgY29tcGF0aWJsZSBzdHJpbmcgYW5kIGl0cyBoYXJkd2FyZQ0KPiA+IHBhcmFtZXRlcnMgZm9y
IHRoZSBBREMxIElQIG9uIFJaL0czTCwgd2hpY2ggaXMgZGVkaWNhdGVkIHRvIHRoZQ0KPiA+IG9u
LWNoaXAgVFNVICh0aGVybWFsIHNlbnNvciB1bml0KS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvcnpnMmxf
YWRjLmMNCj4gPiBpbmRleCA0MDhmYmY4YzI5Y2MuLjM1ZWFlYmZiZGQ3NyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvcnpnMmxfYWRjLmMNCj4gPiBAQCAtNTAwLDggKzUwMCwxNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHJ6ZzJsX2FkY19od19wYXJhbXMgcnpnM3NfaHdfcGFyYW1zID0gew0KPiA+ICAJLmFkaW50
X2ludGVuX21hc2sgPSBHRU5NQVNLKDExLCAwKSwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHJ6ZzJsX2FkY19od19wYXJhbXMgcnpnM2xfYWRjMV9od19wYXJhbXMgPSB7
DQo+ID4gKwkubnVtX2NoYW5uZWxzID0gOSwNCj4gDQo+IFRoaXMgbWF5YmUgbmVlZHMgYSBjb21t
ZW50IHRoYXQgb25seSBjaGFubmVsIDggYWN0dWFsbHkgZ29lcyBhbnl3aGVyZS4NCg0KWWVzLCBp
dCBkZXNlcnZlcyBhIGNvbW1lbnQgYXMgaXQgaGFzIG9ubHkgMSBjaGFubmVsIGFuZCBpdHMgY2hh
bm5lbCBudW1iZXIgaXMgOC4NCk9yDQpjaGFuZ2UgdGhlIHZhcmlhYmxlIG5hbWUgZnJvbSBudW1f
Y2hhbm5lbHMgdG8gbWF4X2NoYW5uZWxzIHRvIG1ha2UgaXQNCkNsZWFyLiBTaGFsbCBJIGNoYW5n
ZSB0aGUgdmFyaWFibGUgbmFtZT8gb3Igc3RpbGwgeW91IHByZWZlciBhZGRpbmcgY29tbWVudC4N
ClBsZWFzZSBsZXQgbWUga25vdy4NCg0KUlovRzNTIEFEQyBoYXMgOSBjaGFubmVsc3tBREMwLi5B
REM4KSBhbmQgQURDOCBpcyBjb25uZWN0ZWQgdG8gdGhlcm1hbCBzZW5zb3IgdW5pdC4NClJaL0cz
TCBBREMxIElQIGhhcyAxIGNoYW5uZWwgQURDOCBhbmQgQURDOCBpcyBjb25uZWN0ZWQgdG8gdGhl
cm1hbCBzZW5zb3IgdW5pdC4NClJaL0czTCBBREMwIElQIGhhcyA4IGNoYW5uZWxzIChBREMwLi5B
REM3KS4NCg0KTm90ZToNCkxvb2tzIGxpa2UgY29weSBwYXN0ZSBtaXN0YWtlLiBZb3UgY29tbWVu
dGVkIG9uIGJpbmRpbmcgcGF0Y2hlcyBmb3IgDQpEcml2ZXIgY2hhbmdlcy4NCg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwOTE4MTUwNzMwLjEyMjA1Ni04LWJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tLw0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
