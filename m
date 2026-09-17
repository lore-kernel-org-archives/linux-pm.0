Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CE51354A;
	Thu, 17 Sep 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651016; cv=fail; b=JnNv8qXyeBIpDycezw0tF18vmZ0G//bddpq7gJkln7KaFzE8aQk8z0cl/KFWBZ9YtKQeYEyqBeri0V8SPNVwrFWM4UIKS4Yu9EB1yisK2QyFcNkepj8fGW/ZfjZKlInxCG+yvQcU9VBVOyCDEeZ4/myHMHPazpg5Ury+iijJ3tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651016; c=relaxed/simple;
	bh=gW1QMO/haSffdtfmyGa/YEFHUiQSsgG0fS5mjIN/SNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JtaYrCdU0fr41PqdDgYAHtBwMqzuZzN7RnKEV4wKpleYsNYcWn6pWWyHNwUsnTKNh/oeyIlc3GfrABPbFbz42Vzp9wWYRxV+sVcNpEDXzpNYT45tHrOXnGpuf5NTIDVkpHMp3Y4NdJSxow4DuNlgTT6twJzz1tIhwG8AYGO+mtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nRtTiRkA; arc=fail smtp.client-ip=52.101.228.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nRtTiRkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyAi8/YwA4+AvomxdohVWLNZ2AJtumOtO5dI+a8e+1a5TWJbIsKqe5Y2D7HK8CYLcAg5XHwo5g0cyoEZHVEDjfjiI2eypuu7G3oorZAPop0rOWfqGrhdlB8s5NcZYLUkOuS1crDrPvfUEIcQ5aXPiNaun9FtH01IWrinZioJ1h1DMgeI9+QhJZY9c+WZXgjAIzto7s6pr0L36uuSJNmfIm/77UOkRCi3NsG3dlz6I+4Ooi8RotJDlMMESYJzzMkck0B+dnoBpG5/APopIJHeSIdeuiUdqaA22xTINBGh7n4bd0LXFzdkvN1L9s6zP3k7BhbKd9+yexUVjbu+MaH6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW1QMO/haSffdtfmyGa/YEFHUiQSsgG0fS5mjIN/SNQ=;
 b=KxaiDAzznyc8PqFbzZ1rfwVc7nEpC7lz3npYOMBirK92vZ7TgGpzjKwx+7C8rncL+YhZyku1jO9FbCDX4CtrX0iVjWVCMiZmsNnanxvQvWYfYoxUE8p7mQV+h6xXYN7HbVpi+wazBDFpWLCF0pwgAkeFGzs/pyeagx5Pht3mFXbuSqmoPXolBxgcNLZmVffJ9i8D7GYxYe5hWdHaQF7myMBWOlhPVBVAV5ghhJQcR12JbVmQyoi0daiZP5zP1i14u7TGxcL5o8wGPZypespdKbZV8TUVksqgbx3CyXaTuYtkf1Veso6bULneWTTdiMY9teRMahFVjyjbGveeNTQfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW1QMO/haSffdtfmyGa/YEFHUiQSsgG0fS5mjIN/SNQ=;
 b=nRtTiRkAUmYIhppONqEgNSEYC0kIPD1VjdHI5R+cvrLL68/t5HI8juPg/qst7sRrgoCfsjE3DRPfq2h5h7rCF9ZpbfCwNDEVZ4ZaDZsz+J3C7DzWAMijhhZxfadXzrg1lJZzOg3Cv65fXh8t/8drdZgndh9ksz1IbPgWaxYt0l4=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TYWPR01MB10347.jpnprd01.prod.outlook.com (2603:1096:400:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 13:16:50 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:16:50 +0000
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
Subject: RE: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for
 RZ/G2M v3.0
Thread-Topic: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for
 RZ/G2M v3.0
Thread-Index: AQHdMX6RNObc7RKd7U2vgGN3+8lz1ra+oVYAgBRIuyA=
Date: Thu, 17 Sep 2026 13:16:49 +0000
Message-ID:
 <TYCPR01MB11865D6BA98CAE7989B4FE27FA2B82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
 <CAMuHMdWn3BaY3EHeThFo34Z=69OaZb0FQ7Z7Ui9MczDGS4nBGg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWn3BaY3EHeThFo34Z=69OaZb0FQ7Z7Ui9MczDGS4nBGg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TYWPR01MB10347:EE_
x-ms-office365-filtering-correlation-id: e540684c-ddf9-43a6-b10d-08df14bdeeee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|11063799006|10067099003|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 sqZ2tgSb1My6WRrhBcaSn3QIqD7Efk6mSwKj7xvFLGV7zuKIFckWjQFsDTYC+zn2b29Ga5e1wFG+voVrBDendJhEjpAeyudh+4cD/SSadeC+aLX0t9WNhsgfsCiXKj3kEXbj+29X9cL55eMhga1/1prhYC+zqKDC22Gi34TUNRRV21jv6Cx50QkJfsEDbMDEKVdtS+BJ8t0IoNRr3w5Zdq1+Id9X9TM1FmLxrGaIAnJyeusi5OVFQmxQxR1cBJt4XvZwmRLXSbfhVvoBnY+S2mnm/AXjqHF69SmLPLGamOIbxEms4bLSPbFZat4V+pkucefAEsgOfU1fVK7l+PmmPxHuv4L3Sm6x4+AaufIHhMd/QY+2vdXt4eA1YnC0gBn/gnxJKYoSpt3lArsQs25wIcg3qgZfhm0wY6eIZ9zCTW+5Du6r2D0INmv+aVAnNff/1k0d6PMfdX+iRBrHVc04aupSp8JNBQrofx5OOq7M2GMJgPq4Om/h/7lss8fVJigo6pWuBMf7QwICDJccM0S/7pW3SmQCxeidq0OnlID19E3mkfebsPvcEVcFwytmOVlnqEfypVipj902zEp2cXs3ANuo3lxu2OVddbVn/9xBCUk+rLYgITau11HwLkO76y9wiTXoSg87rHklA/oOEqN22iPVn+PQMHAeglCHWmViox/Yu+WSittPfihQsLW0lwoD83wcpfVhcooTa2Rt+DRnoxokiy8L9qy23VkIzAz9IPk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0JQdkkvT2NrZnVwNng4L3BiUy85WUZtRVYwSi9hWGZ6MnkrS2ZHTk5DYXdB?=
 =?utf-8?B?S3Y2SHB0ZENHY1dZUnNnb29NMXFEbmgzS0VEUFlJV2lKMVM3dlg5c0FRN2tZ?=
 =?utf-8?B?STI1WEZQa3BycHl6RXRxbGNoZkRyMHVJNEpzM09acTBDMmhxaXRRQWExbDVj?=
 =?utf-8?B?TkZ5VjBZTzRYNGsrZ3ZBTW1takFybHpJYmZoSDdIL3RIQ1BvbXNFcjhkNkNX?=
 =?utf-8?B?aXAzOHlSazJENGo5MGpwOUdlb1lRZG16RmltZFAvMHJhUUhuQmZoZ2pKV0No?=
 =?utf-8?B?UVVCVlErdTQ4cVNhMFNLWHdBb2VTeDFMb0poN1BBNm5ndVR5OUtVMERyaW8w?=
 =?utf-8?B?YkhXU01BQlVwakQrSi9pNEUwTW1NeGFYWXpWZ2o0Sk0wcGY5Q0JidEpvKzly?=
 =?utf-8?B?UmxoaDV3MnZDbHpGUFExTjBsa0NpaGdYQ1pJMHppZG1WdlcwRjVSVkxiNThm?=
 =?utf-8?B?c1NJemRySng2MUlDVVIvTkhzTkRMZ0Zpb3VuMDlwQTNubHJBc3EwQm9Mek81?=
 =?utf-8?B?UlJ2cGZoZk5CVlBUem4yS0pwMDMyMWJzTUh1N09jL3NBaVdSWUVKaXliYUNL?=
 =?utf-8?B?NFBjeXZwRGtFSjQ1SXg0c05JakkyRmY0cW9NRWlBejhacDdxbVV3RU9sMWJ5?=
 =?utf-8?B?elIySzlyOEZuRzI1OWo4b1RJYzRHNG1xQmNoNEY1NkJPZzN2QmhYdnhROE9N?=
 =?utf-8?B?UUlzOURaV2duZ0lSaDRtcVF2N2RwV0lLQXBySEZGUG1JdzBOU3JDQVpYdER5?=
 =?utf-8?B?a0tkb0ZvUFFsbDZ0MzBsbGdaVWJZczJyUVNLSStObVhtMy95ZGtsLzBTajhE?=
 =?utf-8?B?cFJLTStENmhvVmZVNUk0MVRjME9QNlJsRlROM3UxaTd6cnR3TnFNUnIrSng4?=
 =?utf-8?B?MjNGcm8rUkdrQm94aE1Db3FtbWRKd1M1blYxSnh0MCtPY0JiYW9wSzlJbmk0?=
 =?utf-8?B?aEp3aFo0aDlyWjQrTTNDVURIVTIxSE1FZmx1RUlVbWo2OWdCNXJISkpFNmlW?=
 =?utf-8?B?N0Jvai9tanAwL1U5R2tXRHlLUzdjV2t4cTVPeDFMbDhUWHFUajVtakZDMUpo?=
 =?utf-8?B?RXAycFhvdXZQT1RtQ3JBT1hrZU9FclphMWtyNUF2WkhZa3JBdDl3aGtzcTU4?=
 =?utf-8?B?ZzE2VHl3MStFMUl6UzltUHcvK2htUmVaRXdRVDI4NXU1SEJQNVQ2SndaT0kz?=
 =?utf-8?B?Q0hOVk5jRWlhWjdxQThGT2wyb1Y2emNGYTFGUUhVby8vN21YMitNcGxNbkxi?=
 =?utf-8?B?YXcwZ1c5ZVpTbW1oZ2FORFBjZFRoMkVvRmFTb0d0WUlLcUlIOUh2ZUJMUmpU?=
 =?utf-8?B?cWZJL3IzVnp5WHUxTkM2SEZXVWtkR1JVRTdTZ090ZHp0NE04N0tyYnNLRkpl?=
 =?utf-8?B?MUhtcXdkZnE3aXFLL21vazRXZlNZVFM1YjdyU0JyalNBc2FKRE1tYTBWTVhM?=
 =?utf-8?B?QUxRSzlsajdOMnBFL3hjYmNFYXkvZkJGNVlTSC80Wng3am8xd0psWnFpS0hC?=
 =?utf-8?B?Mk51RzVDZGJpTVNaVjZ5cnl5ZnFGa3ErcTBzUVBGdkcxc1V3UjNJbEZZN01t?=
 =?utf-8?B?QW90UGN3TmIrM0l3WDBWa2tmOTc1TFlxWHh2OVJOaUhSSGZPeHgyOHJxejRm?=
 =?utf-8?B?ZjN5dXlsVFp2cWhudXZZenVqZlcyMmlJV2VadzVaSCtlZUh3Y01vTFlGVUY4?=
 =?utf-8?B?cUMwQTlMUHlNTE0wQWNwbmoyckNKVFBrYTl2bDRsZ0l3a1dQT0dwSDdpOUtp?=
 =?utf-8?B?eGh5OE1NRkU0VHRudU40bkl4a2o3bGhOSXBPcmk3eGk3MndnVDkzVWZVaUxC?=
 =?utf-8?B?SUJFZXBIQ2JHeTBuZUhqa3p3bDFZNjhxUlg3RmRQZlBUNkNGd2Rhc2JtT3ZH?=
 =?utf-8?B?b3F0dHdGYXAwOFJzaVlpYVVuNnNoYWFvMHdhVjhReVljRm9pMlVUdlFXN3JL?=
 =?utf-8?B?WWkwZVNQRCtHT0cwS3N4V2NVQXB6NHFuU2g2QitaL21yNkQ0YkQzd0d5Ykxx?=
 =?utf-8?B?YmFzdElRZXBCT3NENkFOTkN0QUIvVExnOTAyMmxhcGhIbndaN0hUOWhyVnJa?=
 =?utf-8?B?Z0U1eXkxNGVmdmplV1dmS0NNZCs5MzNOb1ZEd2UxeUgwVE9yMW9OM0NIWFpo?=
 =?utf-8?B?WlErbCtCdytTeFIybTZzL1V5RnlhN2lxOTZVQUZQbXlzUExPb1Rhc3l5Y0pw?=
 =?utf-8?B?WGpvRE11UEUvc0J4bUNGUDR6NkJhSHNPV2lWUERQMSs2RGNWaUY1VHg3Tjlt?=
 =?utf-8?B?emdPWTVmbUQ3Wk94YzMwUmNPS0xTZTFqS3kzTHJaajdaTTY5d3c5SDhoN2pJ?=
 =?utf-8?B?WmF2VmptOVFRVys0cFlDRG0zUW0yMzVmOElWa0EzWWtCcmZ1eCtIV3VqS1hn?=
 =?utf-8?Q?v3WmScKVf+ej+8Ts=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e540684c-ddf9-43a6-b10d-08df14bdeeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:16:49.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1663LDQb5AbNuXfED+uxbl+cfZNVag9vG/OI6KWVudbS7+7Ofc071RKIeSV9+vusid3cLSZAwRMsmDsvLGasHUZr8i4ycaYAFEYQF2jZ5D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10347

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNCwgMjAyNiA0OjI5IFBNDQo+IFRvOiBB
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
OC8xMF0gYXJtNjQ6IGR0czogcmVuZXNhczogQWRkIGluaXRpYWwgU29DIERUU0kgZm9yDQo+IFJa
L0cyTSB2My4wDQo+IA0KPiBPbiBGcmksIDIxIEF1ZyAyMDI2IGF0IDE3OjA2LCBBeW1hbiBDaGF1
ZGhyeQ0KPiA8YXltYW4uY2hhdWRocnkua2NAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEFkZCBp
bml0aWFsIERldmljZSBUcmVlIFNvdXJjZSBJbmNsdWRlIChEVFNJKSBmaWxlIGZvciB0aGUgUmVu
ZXNhcw0KPiA+IFJaL0cyTSB2My4wIChhLmsuYS4gUjhBNzc0QTMpIFNvQyB3aXRoIGJhc2ljIHN1
cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBeW1hbiBDaGF1ZGhyeSA8YXltYW4uY2hh
dWRocnkua2NAcmVuZXNhcy5jb20+DQo+IA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YTMuZHRzaQ0KPiA+IEBAIC0wLDAgKzEs
MzAyIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+IA0KPiBB
bnkgY2hhbmdlIHdlIGNhbiBnZXQgIkdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UiPw0KDQpZ
ZXMsIEkgd2lsbCB1cGRhdGUgdGhlIGxpY2Vuc2luZyBpbiB2Mi4NCg0KPiANCj4gPiArICAgICAg
IHNvYyB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+
ID4gKyAgICAgICAgICAgICAgIGJvb3RwaC1hbGw7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMg
PSA8Mj47DQo+ID4gKyAgICAgICAgICAgICAgIHJhbmdlczsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIGNwZzogY2xvY2stY29udHJvbGxlckBlNjE1MDAwMCB7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI4YTc3NGEzLWNwZy1tc3NyIjsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweGU2MTUwMDAwIDAgMHgwYmIwPjsN
Cj4gDQo+IE5vIG5lZWQgZm9yIG9kZCBzaXplczogMHgxMDAwLg0KDQpBZ3JlZWQsIEkgd2lsbCB1
cGRhdGUgdGhlIHNpemUgaW4gdjIuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y2xvY2tzID0gPCZleHRhbF9jbGs+LCA8JmV4dGFscl9jbGs+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNsb2NrLW5hbWVzID0gImV4dGFsIiwgImV4dGFsciI7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJv
b3RwaC1hbGw7DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICByc3Q6IHJlc2V0LWNvbnRyb2xsZXJAZTYxNjAwMDAgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVuZXNhcyxyOGE3NzRhMy1yc3QiOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4ZTYxNjAwMDAgMCAweDAxOGM+Ow0KPiANCj4g
MHgyMDANCg0KQWdyZWVkLCBJIHdpbGwgdXBkYXRlIHRoZSBzaXplIGluIHYyLg0KDQpLaW5kIFJl
Z2FyZHMsDQpBeW1hbg0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJvb3RwaC1h
bGw7DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4g
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0
ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxp
bnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRl
Y2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0
YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGlu
ZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMg
VG9ydmFsZHMNCg==
