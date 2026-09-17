Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259251FCC0;
	Thu, 17 Sep 2026 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651130; cv=fail; b=kvmjjwg9QOYQR4RYyv92tWETU3EWZO8Co6lFAwxkWekVgcr25zHjpnvwoB1tcI1Jv+3cVrcFHoTukwTn+brzBuKWDaAKMZYnJf+1pkpB5cZzVcNqSAfqz9Jujq5Xe3/N/q1UhT0ZV4zxnsZCCsEcllfev2ab8u3cOYxejbim+sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651130; c=relaxed/simple;
	bh=oZCHjQPm66ntknFIi5xR0IAFGNXs7FyhafsqsvCoc2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bpj71/mNEI7utAs439b0+qQiOM2uCFquev0WJedrFoJWE6rrMq0x34UmtdwVjfT0ppA8VmiGEb9d9/+GKoTG1SM28Iw8jMyLhztTZjDw9XYEp2t9xA5XKw/UG/UnDLGwMVL3UfHI1yjaJjk45f8K5Hfm2sQQL2VmqWjYQ6MD5yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mAqbWEXu; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mAqbWEXu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNc6bCxZG5bqHX4HXuUMqe3Ii6dLFE24IBFW9ToeFDdnuLsNX9ApY2j79qcfeNyvaq0T91LSv3byjB5cW1KfFbHVaKJyP70AnyzPsLNVHw2k0Ok8QtGKlrDDF3lTUhfbunhSC1BSuPRRE+R5jIkP4jc9yuNMglPFPxK4/+nfoMiauT8X4U3gYC3+OACH+zt2RDrqAAZeaed0v6IhDSQFaLCFpBoEHR7Wkaj2SkaRKwxJvquJUblsexrOnG6qFG9MiAz0GF/+G9d1MIEUeRAL3DVdTfHxImWIWihKPxI/GOPoCwQyLftBklRy6kfQx3jy/sX0fxMlG4DNAFDUAY67ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZCHjQPm66ntknFIi5xR0IAFGNXs7FyhafsqsvCoc2I=;
 b=gwez/IDZD6+zhFFeBH0EgB0pa+S8O8mRC5Nqd+7Kyq3fLPPyAUyo0p7q+T8DSjUT9udFXsiqJw74G3MRtLD2AZCuEX5jQiqfu/5K9mukzZeQivbcJQRe2XcbIF6g5A8beI0ouD9sScL4U+AYr/kyCH9H7iEqf1y6XK27zyFyvvDFFACOrg4bvImR3dNqc7ig7OiYbGA8nZWFrpcknBBB3Qtd/IeHRxmnehd9U4N8WMP/jp2acvr2myOqFSuEFtwOm0oPg+Vr/1PUcabidvDKV6xsPK8jz9qa0LClwXK6Vb9AeAzmCIl/p8wbLkAKIcSFT7Qofmx4ulosab1lwPTYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZCHjQPm66ntknFIi5xR0IAFGNXs7FyhafsqsvCoc2I=;
 b=mAqbWEXuP6x2sfcLDPQvbOrf02c8YIwXkegQQYX36x9hk/V9Y6qNrPVx4rXgvN1N5nqvXpImQi42ajQh7zWGRXPSr1+MIu4uADKejktvZ59EtmUSekAHZhmGFj4WYZ+/bbjQRrhAaV+LSaHYG1JaTv3JcKBXfqORS3i307R7Ukg=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TYWPR01MB10347.jpnprd01.prod.outlook.com (2603:1096:400:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 13:18:45 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:18:44 +0000
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
Subject: RE: [PATCH 10/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC sub
 board support
Thread-Topic: [PATCH 10/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC
 sub board support
Thread-Index: AQHdMX6W+Xk/L9+97kedDa0yiRZj17a+o0OAgBRHZoA=
Date: Thu, 17 Sep 2026 13:18:44 +0000
Message-ID:
 <TYCPR01MB1186527EC20E50E2A85EED8C2A2B82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-11-ayman.chaudhry.kc@renesas.com>
 <CAMuHMdV3uLdyr+VOW-_eN3QMFpq9KV-O3HQsKY6GPpixeQhcKA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdV3uLdyr+VOW-_eN3QMFpq9KV-O3HQsKY6GPpixeQhcKA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TYWPR01MB10347:EE_
x-ms-office365-filtering-correlation-id: 0d13aabc-ab39-4427-2c67-08df14be3361
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|11063799006|10067099003|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 97cye+ndE3xvCqnDcXSog6/5li99kj9RSqwljA+x+F8Zmt/sm/LseWCQB0R+ueOqEQVnw8HALQgNHE/4KuOmRZDkOjqpvWpJieDOV23ijKmoVCX+aWqLm/pKrvsJhHryhDZoEGZPbMgsESXtw5IATUaQ67IDjJU1Jpxg7pchLOvbOjMiPh0XcizM9kSomdIbW98dvt74W8Y+6e5aP+RYhuwMmEHXZxpB3EKYtR3sRZufxi9I3I4dw/152mtvP/T572pnK1edPp1yZCM/KwpWwjN6sYwPosPMSpRYHmamN44r/OU6WknRZbJBGMLGw3yeqKzwgLt7K8FqUje935wzU42VnLjdc4PoPXCLsTqORxeZSsa8lPYEm9+dPGilNc3THTikgACvnkQ4jdkLOqYkUFQibVucZbd4j49PlF/ub57pVaV8FbyvlLrqb4MYRIqnEST+TzjRxacDVgnw0XgB/1G6HZHMRF5/a4AK3VI06itP9zGI1cgfqQxER2ZnI8UrOOjtIjxMsjV5Eyqe09/54YxtxtoJKIdZ6iQgxxPYKOU+dfw2KWb3X628J9ehJ20QRi/+/nAt2vqyZbvk5CM2EM0qDmDp8FY/lKYY47K6yhBw0BUH/Z/Rw7qFu4zXt0yEiRC1eIj/R+r3vWeVRSInXAB8yz2iyeobWXhCSg4qp5CFD1kGJOqQwuuuN+UTZeGDoy7thvX9T26cjKi6I6BmZ4IK6uFudn5OsXt/DBZDOo8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmdqWnNDVkw4QzlXeVcySUk2V2hVRHQ0b1BFR2JyTDVzSGo2M1RuNUQwcTNW?=
 =?utf-8?B?dzJpNWo5T3hMQ3NnR2IzRXd6Y1grZnZ1a2RRWW9QNVVsNTJOTzB0RlRGMFF4?=
 =?utf-8?B?bFBMdW1pU05wSVdSVmEyVGI5NkFtazFua0ZjSzRLMHV0Z09Wd2NyeEJFYitZ?=
 =?utf-8?B?MjRkell5d1Y3d1kwaFlRYy9obkZpbStaWkxiQTc0Y2tZRHpnSVBQeVNIeDBm?=
 =?utf-8?B?aERVNDdCS1Qva1NJQ3dvMUtYRHlySFFXRkhkZlBGTFlFOGZiQk9YM1hUeUlE?=
 =?utf-8?B?T05OL1FKRmxWb09MMTl4MEE4N0lRcUU1OE5zc1ZORWpzTWx6anc0QVh6ZlJt?=
 =?utf-8?B?UVZWNnpjTWt2UlY3L240ZVBrTEdDbWVoN3g0NHpldXRuV2dDN2NEakpTL3NC?=
 =?utf-8?B?bkswZmVjWC9MVENnTSt1WkRtT2hTWWNxWlZ1UE1ES3ZKMFR5RjBrUmFXcVkx?=
 =?utf-8?B?eHYxeWRUcWtKNVh1ZjlRSG05YVhLTFdBYmtZTmZFQ09iWEoyWTd0ZlFVOG1p?=
 =?utf-8?B?WWc4SWhDOE5STEhZQkJVdGZyS3Bqd3craEh2Ri9TNTBYOTlxVnRtajg4ZGdr?=
 =?utf-8?B?N3JpWnpWZ1RxU3llNTBVUzlXcDk2NUUvNi9SV0txdUlUU01FMGdxRUFBcW1K?=
 =?utf-8?B?cFQ1NTcvVGhuWW1yQ0l0SU9qeklLajBaVEdYNHJWLzl5WENVTUtvY1VZZUsv?=
 =?utf-8?B?ZE9JWEhKVVBySjVGaEZZTGU1YWNWTURPd1pCRUhsenAxRlFrSXhlc2VsNWVR?=
 =?utf-8?B?WkYyenJ4SUlOR1dFcHM4K2t3bmZhQ3ZJeVdvZ1JxeGhvVmRZM0UxY0w2cTh3?=
 =?utf-8?B?aVppNmJ1cGNmNWNwRTFJT3dOTXM2OUltZkN3Zk5yYllMaG92ZHNMT0E2Y0JJ?=
 =?utf-8?B?Ykp3K3RjdUFRbFRZL1hac1M5bEpMRTBLc0JFQXZtd0pCUmtlNWJrYzFyQjF2?=
 =?utf-8?B?TCtmcWp1TGN4elJNL0hmeTlzcEhrOHNiRTZBNENKcnNWZzIycmtqSGwxZm00?=
 =?utf-8?B?OGgyVFFKVU1ZR0R4OVFMdzdkNEpDZXllUXFDb1NwNXp1VU40S09ISWRHSGhJ?=
 =?utf-8?B?Y0YzMmxRTHJ3VG0yMWVrT1FHRXhJSW5BekkvM0RWVUNJOHExWlNtUEh4dXVq?=
 =?utf-8?B?YUFCOS9pYjVpUFZXNGdPbzA3YThXVUQ4SU5nSk1FbVUwVTFsQ1BERjBYQTlQ?=
 =?utf-8?B?RDAzV1gzZjlsWDhFMGpmbjk0OUZaaWJTZERHNVJYeURuYUwzbFZrWk1BdVd2?=
 =?utf-8?B?aGpjaWZseE5mOVJpWUE3ZkJMb3NGU2V5K0xISUN6T1NkRUN1SjhMMVFPU0RE?=
 =?utf-8?B?MmJyNGdsVldhVTFLWDFtU1lScU5UMXM5NXRRazVaMnAvVWV6bzVaS2ZkMm93?=
 =?utf-8?B?azNVRmM5TzZ5YVcxSFRKNncyNnB3N2dtY082VkI4RXhxdC9OSnJXMG52N0hC?=
 =?utf-8?B?VlBKOXFHaG9LSThEYWNRazM3bUlqMjQ0M0lGaytVdkMrbG01cy8rQk4yUmJ3?=
 =?utf-8?B?WTFZTGxWakN5L2w5RmU1QlJoUTNhVFdWZXhyeVpwRGNHMDBLZk1HN3J3c212?=
 =?utf-8?B?dTVsaW9XWTNZN3FsRmYxaGZUSGIwQVpsa003NGpzVWw2TnJXNlBET25veVMv?=
 =?utf-8?B?eWtYRnpTNHZZK1pYdGNrTlpIZ3VhTkwrWFRHZ2hEMFVOeFdxVGovQ01wOFNw?=
 =?utf-8?B?azdJNTdVL1RtdmdUVStnSkRhUFhFQ0VjVWIxRzdOOFpldjZhbEtrT0RyVUZ2?=
 =?utf-8?B?QVZ5U2VxNjQxZG9KVWdBVVIzZndBVjd6ZDlEZk5UVnRKMjF2TzFxOEp3MEw1?=
 =?utf-8?B?ZWZFSlBtQVY4Z0RtYWtUc0FWN1luTFpEUXlTZTR6djg4QWFkeFVyRkl1cHNY?=
 =?utf-8?B?UWdwVXhmdmh5SkprL0NUQ0lqUmpiY2gzS0daeVkvSjdFNUEyVkhYSm51YTd0?=
 =?utf-8?B?cmtFYzhNbVZXTnJHbjN2OGE4ZE1pbWN5SWpkQWVZdlRHeVJMcWxPRnhVU295?=
 =?utf-8?B?TFlrTElVdUtvK25ORCsrYWR5Q25lY1V1cmtnMlBTa283Vm1qM0VnYUlIa09V?=
 =?utf-8?B?NnYyYWp0NEtadmRRR1NMVGl0T3dhQlNjb1psb2Y2ZkVEL28rTUNONzE1czNM?=
 =?utf-8?B?ZFZrRWpuZ0ZLT01LMTg3ZWxQL1JTRjBNSEZPOE5rRkRSQVdDVTk0ZWw0TitT?=
 =?utf-8?B?cjdNeTM3MGRvU2l0WHlhVStuN0F4QncyYTZtaWJiR3NEQVloMWkrQkNEeEk3?=
 =?utf-8?B?T0dzYUYwVFR5bldFL2tXOWtzTTRTYXJGY1lVVmxIeFhlTzBhdE01TVU0MnVI?=
 =?utf-8?B?RVlDUTVwRHAyZXRQb3pzQnV5Rk1NcUtVYjhuaWdMYUJYZkJHQ3Fqa3Y2dWlv?=
 =?utf-8?Q?I0nHAMcJfCCGS8wI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13aabc-ab39-4427-2c67-08df14be3361
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:18:44.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/PL0x6SYiYUtCqgurxDkAyBTQgrX5BYOJH0PqEGX51F0oOlRdvAQ8MK/V+RmDXO3SP+GpoJCnd4MU1hxnGm9lpWcNchBQt4BbcOK5lB/44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10347

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNCwgMjAyNiA0OjM2IFBNDQo+IFRvOiBB
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
ci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAx
MC8xMF0gYXJtNjQ6IGR0czogcmVuZXNhczogQWRkIEhpSG9wZSBSWi9HMk0gdjMuMA0KPiBTb0Mg
c3ViIGJvYXJkIHN1cHBvcnQNCj4gDQo+IEhpIEF5bWFuLA0KPiANCj4gT24gRnJpLCAyMSBBdWcg
MjAyNiBhdCAxNzowNiwgQXltYW4gQ2hhdWRocnkNCj4gPGF5bWFuLmNoYXVkaHJ5LmtjQHJlbmVz
YXMuY29tPiB3cm90ZToNCj4gPiBUaGUgSGlIb3BlIFJaL0cyTSBzdWIgYm9hcmQgc2l0cyBiZWxv
dyB0aGUgSGlIb3BlIFJaL0cyTSB2My4wIChhLmsuYS4NCj4gPiBSOEE3NzRBMykgU29DIG1haW4g
Ym9hcmQuDQo+ID4NCj4gPiBUaGUgUlovRzJNIHYzLjAgU29DIHN1YiBib2FyZCBpcyBzaW1pbGFy
IHRvIHRoZSBSWi9HMk0gdjEuMyBTb0Mgc3ViDQo+ID4gYm9hcmQsIHNvIHRoZXJlIGFyZSBhbHJl
YWR5IERUU0kgZmlsZXMgYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwuIFRoZXNlDQo+ID4gRFRTSSBm
aWxlcyB3aWxsIGJlIGluY2x1ZGVkIG9uY2UgYWRkaXRpb25hbCBzdXBwb3J0IChlLmcuIENBTiwg
UENJZQ0KPiA+IGFuZCBldGhlcm5ldCkgaXMgYWRkZWQgZm9yIHRoZSBSWi9HMk0gdjMuMCBTb0Mu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBeW1hbiBDaGF1ZGhyeSA8YXltYW4uY2hhdWRocnku
a2NAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0
YTMtaGlob3BlLXJ6ZzJtLWV4LmR0cw0KPiA+IEBAIC0wLDAgKzEsMTQgQEANCj4gPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gDQo+IEdQTC0yLjAtb25seSBPUiBCU0Qt
Mi1DbGF1c2U/DQoNCkFncmVlZCwgSSB3aWxsIHVwZGF0ZSB0aGUgbGljZW5zaW5nIGluIHYyLg0K
DQo+IA0KPiA+ICsvKg0KPiA+ICsgKiBEZXZpY2UgVHJlZSBTb3VyY2UgZm9yIHRoZSBIaUhvcGUg
UlovRzJNIHYzLjAgU29DIHN1YiBib2FyZA0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMjYgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3JwLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNp
bmNsdWRlICJyOGE3NzRhMy1oaWhvcGUtcnpnMm0uZHRzIg0KPiA+ICsNCj4gPiArLyB7DQo+ID4g
KyAgICAgICBtb2RlbCA9ICJIb3BlUnVuIEhpSG9wZSBSWi9HMk0gdjMuMCB3aXRoIHN1YiBib2Fy
ZCI7DQo+ID4gKyAgICAgICBjb21wYXRpYmxlID0gImhvcGVydW4saGlob3BlLXJ6ZzItZXgiLCAi
aG9wZXJ1bixoaWhvcGUtcnpnMm0iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICJyZW5lc2Fz
LHI4YTc3NGEzIjsNCj4gDQo+IFBsZWFzZSByZXBsYWNlIGVhY2ggZ3JvdXAgb2YgOCBzcGFjZXMg
YnkgYSBUQUIuDQoNCkFwb2xvZ2llcyBmb3IgdGhpcywgSSB3aWxsIGNvcnJlY3QgdGhlIGluZGVu
dGF0aW9uIGluIHYyLg0KDQpLaW5kIFJlZ2FyZHMsDQpBeW1hbg0KDQo+IA0KPiA+ICt9Ow0KPiAN
Cj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51
eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNv
bmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEg
aGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
