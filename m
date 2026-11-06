Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953703;
	b=NatAhCihBytmsfBPFFm8i79XJagNaqqLctijdPzIL2NMe6hdQrOJPjnCQF27SvYLApWx
	 +L20ejxwcFYybMO0MQGUR0jHHKc6mwOpY8U1/pZ1nhcbOyQ+0Nr4kVf2unQmuCuSg0WN3
	 XhgkHh6Kic0VUspHtxtcfILCUjoj2W/16QxnVLOEt9MIGwn0no1nd4UjqwzmxjA6l5sM4
	 PxcKKXI2Zbp7kmO6lu8QFgBLoGOgYj+mLyUYolo6MU6ZtRd/8W8rh7OXBsNmEsIwfVe+8
	 JT6Ku3ZzoQk4iJT2eOKLYJfT95aaKPPxFLMiAp0NlV8G2EiGBt8HPxGuo9nLqRYb2lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953703;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tVpsJ2n/X4k6FpgujDLFGBpkKOxTMiCTy4/NCKW+Yzg=;
	b=QmNcAAdsmZZ8R75RVjKL6JxHCamPib+NYQp4YxzPxNCioY+hYiUmzsRkF59qm1tOHMCS
	 IVk+fRKei81TNxrCo6M4EmnEyhutEUAvN3lH/0rSyQTsOwo22bYla7Oj23ko871kYojvl
	 ZH4oemgS6eXhj9w0sjyDQlt1P/gPljPDDBXKtuax8z0R9wzdrfpufXNLuRgL5Set32WNo
	 DH5F2d262fryMZ5scoapBUgC3hDjgkxWiYqrLm4ov4GTc1f5eDjRHPbS2VKP7x/oiTsvR
	 HMl8FEmt5yXvGzOWAgw65wppb0DUMtvnY6zwogV7TWxNflc6ibb910J+Dqf6buDKwdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=UjiyUnEO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.27
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955C606A32E;
	Fri,  6 Nov 2026 08:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3955C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=UjiyUnEO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE1mfqQ2VokoL2lF+p5LVjg7V0T9IyjG8vQZESEteUK5k4lcJ/g2ycy2mKaNtqXwFkOanbo8JnUTg7aaaFppjm/L1wM5TyTn8M+pvXmI9sUPJP1BuAt451fB/cBfItcS0BnQAlHpW1tQrwPgGZ+M2cPOZ2E0Z5FECfdmOfJr8PV0+IyPnH15GxBa1HPwtbbCO5cIvVCk81S6km1fN8iZGt3pW2SFZ+prFbcJwzF4tUIkL1aVkzKGHxs8JA2Z5pChQ+pFCY7VxsHHv/5H25Dv51vXdzIsY8GAF1CfSoB/EPdwwIjHD5phum6DRVGXS3SLGSrt7d6NhizMifVLFTCmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVpsJ2n/X4k6FpgujDLFGBpkKOxTMiCTy4/NCKW+Yzg=;
 b=MPbAiuKOMEIdz+JcUquxYshFbHhvltgAReiZUzhKTSy21T/vzKj7YCNyirSUqk8MwLrCLlbWrlewe6oYulmpc6aHpMd9sh5UIIbbf15OY6IxKufQAlQdI0eLk6gBNSAgS+ZJTxWUYIkZD5rMtrXlpXYDtj4iKjvq7vpKs6gGplVUf3zmsV3wdCYqjeRSfPDxFKIxGMUtzIF2vcpw0mbLFEGRG7BA7+6hDq8MmGhdmb3+fht+X2IT1+p4b946yVJs0YKJEV8bgItjs2X6zhLDhPZZrcnnm0oaVIILbg7HUok+1dklho8bQtzwwBzjU0f/K76er8tLOR5ya3gZWFDKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVpsJ2n/X4k6FpgujDLFGBpkKOxTMiCTy4/NCKW+Yzg=;
 b=UjiyUnEO6f6ARWhoqUhu1I/XWiMYdL+Sx5ydE97JkNJTAIwqzxrPLTedN7QFspc9ZAjrQgh+2ie+8/CY1JK7+o0epNBbG5YeYrhEPmd+NpCbknQ0Jvs9M7Vqw09kw3DW1epStKGZsA1K3qMPVy2VZGSMfGOqx9wrCvzMqDUcasw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14590.jpnprd01.prod.outlook.com (2603:1096:405:23d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:28:19 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:28:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, "biju.das.au"
	<biju.das.au@gmail.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH 3/9] can: rcar_canfd: Make clkp local
Thread-Topic: [PATCH 3/9] can: rcar_canfd: Make clkp local
Thread-Index: AQHdZ6ey9BsKmfUrHkS11C+eIKXt7rcgvtnwgAABdgCAAAE9kA==
Date: Fri, 6 Nov 2026 08:28:19 +0000
Message-ID:
 <TY3PR01MB11346D9A55FCA3F226334FA9D86762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1793278754.git.geert+renesas@glider.be>
 <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
 <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14590:EE_
x-ms-office365-filtering-correlation-id: 040b6eb0-7ae0-4647-76ae-08df3bdfe9b8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|38070700021|11063799006|4143699003|56012099006|261022105027099003|261009223027099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 LvFzTSDr+xACdVBDpVjZmxXMfktT8q9O4P4UjwAVKxneQhFzttYJ6ghwwo0QaunN7NfyEaJSquzhpBVyFQ0UyGw5htJdSaCK8ioCpdZmKZv0zw51eQAd2DhpjBVNraoS/3pNkcZzTpCy/ojFbJaCFlhLXOe0U9haL6w3nMdoB55INO2vwEsz/CyF0uILcyYCqt3LTuSRyFWaWE0PMpkXGZ7h6gFEzHmDZxgyTXW01cnQnW3XxJxGZ/V7Dystkma91qM/TlCcxCc8ezJQgwJ/Pog1WczG3ta8CO5Jtegd6JinfqxdTYXIydoXsoc7fWJa5pqZf9lT7FC2/rO68sBl2myK2PCg2Vbg2+VO5SzldXUKzescvk3XB62dFA29WRdavqecGewCa+888nfiloYwBkDDxVPR6ZaKzMRz6pd0+GuLy7XS9zjAqRjBluohA+/tSp3RZi0Os10vVtBxPOgCozfH43OdANkp7urJRaD3BMLjBMnxkAbV+nlhmbiseDaOGxXJm5//A+QZRbv30op9uhKqfByqL+h7fP047lRqonmm0tQDlD2JFG6172nh89ywJXi1dUJZfaGj0nOtNhcvB+ryMYDHBOAaEmAmEU+M2O55NJ7KUor+ZG4CiH0c8VVkkAqX1kxU7GUESyLFa9wYJjvCgEeaz+1q3l68iMPvLVhzd6h94VARqEANEgtlFGGV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b05KbmRMZm1jNllQbmJ5bVRNWnBuR1V0YUFEdkxDdTFFNFBWMUx5MHNtQXRr?=
 =?utf-8?B?Wkg1cmJYL2I3OURPcjlMeEs1V0JUS2dVR2hISFp2amNaWVdkWnEzMFJXTjMw?=
 =?utf-8?B?UUVhQ25OWWFqV2NoRDNvNzY5eWJFTGk1RTMxemFRQXZxN0JxbWJPZ2ltbVBy?=
 =?utf-8?B?UEdMNnpxTERHaEtlU2FyMlZQVmpRNHhiNEROeGgzTlQ4dnd0cFAwOTkwczR3?=
 =?utf-8?B?VGlGQk0xNGpXYnVHSlJsN2FkaFlhM0RlL1hLU0NQRmJqS2FBcTBPRXpMa0w2?=
 =?utf-8?B?bVRQMkR0ZlNPT0Z3a1ozcDZ0VmRaN0dlS1YycnNTNkMzcDBzM3Vjc2xTTnRs?=
 =?utf-8?B?NWJnYUFKTHhjMTdJOGhiY3diOEJ5RDRCeG81NXRWcHJkTkJKYmUwZ1NBZS9C?=
 =?utf-8?B?SlhUbnRPNEI4VUJ0NVU3Q0FOUThSemlaLzRUaFNmME9salN1L0FNcUxDMTlN?=
 =?utf-8?B?RStFODF2dGxabDBJTldMckcxdkRNTWgwVmo3dHA0eU91OEJxUThRL3dSNGph?=
 =?utf-8?B?ZXRuTllkU2dEczEwYURyVVlFcFg1dVVOZlJtalM4WEtBdEZPYk5YK1ZXSTFG?=
 =?utf-8?B?dVJMaCt5SDZVVnhwWmpySFoydGJCazJqYS84M3dzUE1LZ0Q4U2M3cnlQRm9v?=
 =?utf-8?B?b3YwNW4vYUExaHJ2VVN6ZWVVWldhRGJJL3hRZ0MzY21FRENWYTRQbVlhVDBF?=
 =?utf-8?B?UHZCYzdEbjFIUSswdVk2MzFLN1F6WmtZdFRDZVBzRHJtdTRYQWwyZmRwQldT?=
 =?utf-8?B?L3BFRndPWnhOMEhoY2hia2VIYjZvQjBvLy9ZUmVuZ3YrNkExaDh3V1AvVFhv?=
 =?utf-8?B?YTEybS85UmJlei92d3UwU1VxNmVNbTBDY2VlWTRqb09iTGVKWEFuZU5Kd21Q?=
 =?utf-8?B?Y0dwcWxlalB1cllvNG5EcGN2U3VPc2pLQTB6WHkxWkgrUWVwQUJ2T0lOYkd1?=
 =?utf-8?B?T2VpSEJrWUQwbitJcTBkSlNoVG1NS3FRVjViUjRqKzFJTGVWdEcveE1MWjlH?=
 =?utf-8?B?R3BvdFQvYnV5U29VVFNYamIrb2p3ZnNnS2pObldMcDNHS1doeTRLVDZVZTJx?=
 =?utf-8?B?VWRSRXFkUU96R0w5VFI1Q2tFVWpyc2ZzWlNaK2JpTEdGL3B1RXRkdjN4TG9p?=
 =?utf-8?B?UWt5SFRZVWdEZlBKSVU4czlueENobEdkbDk3NDFnWWxKQUMzUTh4aEV5NFRJ?=
 =?utf-8?B?bzFrZHB0NWhwLzNkdkgxLzlEV1I2Y1VSZGwxYTlrQ2Jld1NqNi9SSnBQOWJs?=
 =?utf-8?B?blFWUTlwNWY1OG5UTFoyL3JrYlp2RG5sRW1xYnQ0QTVETVkzOHF0N2hVRG5R?=
 =?utf-8?B?T05kbnRqb2o4MTl4Q3N4TGJmdlg3czEwckNFWDBVSk0zU0p2NldPNzROVzR4?=
 =?utf-8?B?QU1OVWtaNGhJUHBwWXNoWHNESVZDRzF2SEZvU1BqdXJQakVkalBUNWxoeHNY?=
 =?utf-8?B?OEtCbGd4N0RobzZ4Z0ZHMlE4QndhWjVOKzJmTnE0aWwrOWVaWmp1S2pta3Y4?=
 =?utf-8?B?ay9vWlREakd6bG1HTmovUTViT0xSdGkrb0ZuZ2dTWTRENlkyTUtMRjBhSzU0?=
 =?utf-8?B?K2NGdThjZVBQL1c0NzZMZ0xtZUh1Y2swa0hBRWF0bFBicGQ2ZHFqYVlPSWJE?=
 =?utf-8?B?R1YvZW1pY1dzRmdRdGN1aW9iMjhROU13ano0anpLUDMzbWlaTjllU0hJbzJS?=
 =?utf-8?B?dWZPTWcvRE8rQ20raUlITDQwMUg0Q2QxOW1ucGV6ZW9DRVlqZzNEdkt2ZWph?=
 =?utf-8?B?czBMMVp4dzRWMlJFY3F4WkN0ZUI3Vm9yd2tUM0EwMUIwYlV6MWNxbzhnaDJz?=
 =?utf-8?B?c1dEQ1JDRm00SlhHdFVzMFN6MERrS2lWdzVxeDRFSlpPbUtkVFFjNzZLVXFs?=
 =?utf-8?B?NjNqR1dnVXAzeE16dUdXWkVReUlJRVZvdnVTZFA5SGJsS05lWXBtNGtUUGoy?=
 =?utf-8?B?QW01VEJtdDRZWTFUdTVtbnZkQ0lWLzJzWUZyb1J6S0tGUU5JOVp3WldVRmN4?=
 =?utf-8?B?NFg2M016NFlFcXFyakp1N0tEOHBORnZjVU83dlR5QVoxcmlvU3pyV0ZLc3U1?=
 =?utf-8?B?Nm1sb0NrRjlSWEN5bDlIald0UWZFMWZWbVVUa2UwOXg4cllHeE84b2l2c3FM?=
 =?utf-8?B?VVZGcTRNS3VtZmp1QmUzUWJ2TnByL1ZSUWpPN3FNeGtPSmhWUERKVXYvTWxB?=
 =?utf-8?B?NW5XWnhMY1JXQjZTWnlYZ0dKeWVRVU80UmxQSTVCZnFnUHlTVDY0OXJUVzJy?=
 =?utf-8?B?amlzNWtJM2VPdWd1TSttRXEzUThOVG9HcHNVMEZnVGZuMFhaWE9nNUhWRkdI?=
 =?utf-8?B?bTZmUmdQSElZSnBLV2ZYYUx2aXBsODRXWElGZUtRN1NqRkdvSGJMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040b6eb0-7ae0-4647-76ae-08df3bdfe9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 08:28:19.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4a/kU7KE7NrA8y1NuTho9/yJsqwz7AeibtGJabDBbeGV6AQDMrsqYYybzUVyufHEgzRkmTYxpVSIUhaCoNuQHEzgoZGePcEDDUZyyg1a7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14590

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDYgTm92ZW1iZXIg
MjAyNiAwODoyMQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvOV0gY2FuOiByY2FyX2NhbmZkOiBN
YWtlIGNsa3AgbG9jYWwNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIDYgTm92IDIwMjYg
YXQgMDk6MTcsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+
ID4gPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0K
PiA+ID4gU2VudDogMjkgT2N0b2JlciAyMDI2IDEzOjExDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0gg
My85XSBjYW46IHJjYXJfY2FuZmQ6IE1ha2UgY2xrcCBsb2NhbA0KPiA+ID4NCj4gPiA+IFRoZSBw
ZXJpcGhlcmFsIGNsb2NrIGlzIG9ubHkgdXNlZCBpbiByY2FyX2NhbmZkX3Byb2JlKCksIHNvIGNv
bnZlcnQgY2xrcCB0byBhIGxvY2FsIHZhcmlhYmxlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZkLmMNCj4gPiA+IEBAIC00NjcsNyArNDY3LDYg
QEAgc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsIHsNCj4gPiA+ICAgICAgIHZvaWQgX19pb21lbSAq
YmFzZTsgICAgICAgICAgICAgLyogUmVnaXN0ZXIgYmFzZSBhZGRyZXNzICovDQo+ID4gPiAgICAg
ICBzdHJ1Y3QgcmNhcl9jYW5mZF9mX2MgX19pb21lbSAqZmNiYXNlOw0KPiA+ID4gICAgICAgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsgICAvKiBSZXNwZWN0aXZlIHBsYXRmb3JtIGRldmlj
ZSAqLw0KPiA+ID4gLSAgICAgc3RydWN0IGNsayAqY2xrcDsgICAgICAgICAgICAgICAvKiBQZXJp
cGhlcmFsIGNsb2NrICovDQo+ID4NCj4gPiBVbmxlc3MgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywg
SSBnZXQgYnVpbGQgZXJyb3INCj4gPg0KPiA+IGRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2Fu
ZmQuYzogSW4gZnVuY3Rpb24gJ3JjYXJfY2FuZmRfcHJvYmUnOg0KPiA+IGRyaXZlcnMvbmV0L2Nh
bi9yY2FyL3JjYXJfY2FuZmQuYzoyMjUwOjU1OiBlcnJvcjogJ3N0cnVjdCByY2FyX2NhbmZkX2ds
b2JhbCcgaGFzIG5vIG1lbWJlciBuYW1lZA0KPiAnY2xrcCcNCj4gPiAgMjI1MCB8ICAgICAgICAg
ICAgICAgICAgICAgICAgIGZjYW5fZnJlcSA9IGNsa19nZXRfcmF0ZShncHJpdi0+Y2xrcCk7DQo+
IA0KPiBJZiB5b3VyIHRyZWUgaGFzIENsYXVkaXUncyAiW1BBVENIIHY0IDMvN10gY2FuOiByY2Fy
X2NhbmZkOiBBbGxvdyB0aGUgQ0FOIEZEIGNsb2NrIHRvIGJlIHNvdXJjZWQgZnJvbQ0KPiBmY2si
LCB5b3UgaGF2ZSB0byB1cGRhdGUgdGhlIG5ldyB1c2VyIG9mIGdwcml2LT5jbGtwLg0KDQpUaGF0
IGV4cGxhaW5zIGl0Lg0KDQpDbGF1ZGl1J3MgcGF0Y2ggYWRkZWQgdGhhdCBjaGFuZ2UgYW5kIGl0
IGlzIG5vdCBwcmVzZW50IGluDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ta2wvbGludXgtY2FuLW5leHQuZ2l0L2xvZy8NCg0KQ2hlZXJzLA0KQmlqdQ0K
