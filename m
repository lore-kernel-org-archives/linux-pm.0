Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.125.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34013C5837;
	Tue,  1 Sep 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275531; cv=fail; b=EStK77XDkUJHyuCSA2R3EdJng19Dibc/HB7yDx2dAe/M7dvMf34bpoJsfn9iv7AR0c1Aox8fseqgtFKO83GAOvzMwwhsZH6577eXRCt0aUOK9TFlMKZUQqEkXllt9y5XFgItf/7jwTF36O4YXm/YBBISP26kB5UcMX9yo6jcsXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275531; c=relaxed/simple;
	bh=dAoJ2NIUID18ETnh+Gzb4x8JhFXFoa73xmxhg8VJJYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BR7sD4NusfV7yKiV1QkJzNwoswlGgetUlbSaOqDiPaTaTZXmSqc2MNTOFgJLgt+GZSaQXkt+GKAnko0HP2Yf64ybwPkFKuX8njIOCh/+uyDzmG1TqZHMagSiXL4OmVRLIJyFgFEXOyyDC/V51JcRCzPCOfCZzwf14rpchH76CEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Ok9AHlcg; arc=fail smtp.client-ip=52.101.125.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Ok9AHlcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoUIuMoqCxafLJwwHjQ79i8wZgkG0nBUQAYw6Z0x1rU71MAkXLP0EsiPSmAWK7qJetB77EyK/fB9e+7CA8eGb+jsidXdTWLZg6am7+QBS/u6lQxcOO5s4pRXskyIltVnJnvapLS8v34QVneItyi9WW4ONqmqnXooB1UaXjf8ru5/Dcl5pJfvU/AVndnZl/TyllFHqA7dWzQScvRR/RQ/8rpVS2S26x4mZGdEYxpp7h5IliurESKxVAKvjY/3MqILgHf9H0vsUUdS6bsgOM+mphK8c/lltdh4iQiBtYARxzNWSSHwNCK0mKuWDUNbl9h/fVbbjfjCovqeAz+NPEcpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAoJ2NIUID18ETnh+Gzb4x8JhFXFoa73xmxhg8VJJYQ=;
 b=Nvf1s4Eucvz1m1RF6EqiVSqhrMrAB0QPs6/VY2uqWuMsbF2UGkHhpmoINJsKeOSjPfYNVF7D61JbqEHhN8LdyiGJAfd9ub9H8UjFIKDTLSZ6so7fK3p9ZIXfpwthKK9hWTzlJh3KlAzqS9lpBnJcROEzAG5Zp80Wi5lHxdlqdc6XoCcbHk6M4VcIYl+HSTRUL5nHpXKLlu79rzgQUtlqTlW4PHsCKjpOu0MBn1Qm3VchhST/L6zmE/6gFFIGY2kkvuCFaKhvIvBs2a4AXqKzV+OY0WPfUwacRJ3KOn8n5aHIvIfPZSb9vZW/Q1M+AzBhyHssx3ITJNbIOjOAbFoL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAoJ2NIUID18ETnh+Gzb4x8JhFXFoa73xmxhg8VJJYQ=;
 b=Ok9AHlcgORM/PSVl9fKnplq9DDqf13Fr1PpuD7+mh5tw8KfZ1NfYLRAplltPbzBouyqwR1/MmZQuTvvgFw6RdK+x/cjnq0OWyAzqtELyhFbHd3sH2vEMI8fRNIWoyOZ8nn0H1vWXyGsSc+3P/szBZiNt//rpaYzQ+p26TY1XxrU=
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com (2603:1096:400:38c::6)
 by TYCPR01MB11887.jpnprd01.prod.outlook.com (2603:1096:400:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:12:07 +0000
Received: from TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3]) by TYCPR01MB11865.jpnprd01.prod.outlook.com
 ([fe80::981:1b9:f809:a0c3%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:12:07 +0000
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
	<bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf
 Hansson <ulfh@kernel.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 09/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC
 main board support
Thread-Topic: [PATCH 09/10] arm64: dts: renesas: Add HiHope RZ/G2M v3.0 SoC
 main board support
Thread-Index: AQHdMX6TkZe2AwxMVUK/9Q0ThSSnsbaprlMAgBA26SA=
Date: Tue, 1 Sep 2026 15:12:07 +0000
Message-ID:
 <TYCPR01MB11865997D743D30122CF0E6EFA2A82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-10-ayman.chaudhry.kc@renesas.com>
 <69eaebbd-4f24-4167-a8ef-42925a92a4ca@kernel.org>
In-Reply-To: <69eaebbd-4f24-4167-a8ef-42925a92a4ca@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11865:EE_|TYCPR01MB11887:EE_
x-ms-office365-filtering-correlation-id: e55f439e-e51e-4fbc-9421-08df083b6377
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|18002099003|22082099003|56012099006|38070700021|4143699003|11063799006|10067099003|921020;
x-microsoft-antispam-message-info:
 G+AkMItOGAeBA44C/JzUgq/PTO0tqIanXu7ETFgrtV8aVbiNNXEi6FOW19FDk5KrYB7N7tv8oFdJsnA1EpTa8zR4WhO8dAmOiuqi2K1humCy4HnazpDML7KTytsBq7cLc65wo+mNlCx/4ttTwfiQ7523Cv5C67FbJh/5fhBlcH5pUPlfgjRfJcMQwOS50F0+8IxAVBkKOMGUSgYe8qRUWoW82OweuW5TZh6njLzkm5eYTb6XOBA8VYB/L8v8hGLO9niDmyqw+CgKwxnoACz+rak3hdHKPHzzx/MTyg47pHVGGPGp4dSBMTeGMf85CiAp+xpuBuqXTEDbcofCjL+DC+t2y+183QZxZXrNgxqUYPaDPcbdradD9C+DzQLTbIoKFMy+0eFj2vPw87iHxeDuFigjXlVZW8IPeCuSEAFreE0826DDoQaAucy5yEphfhePj5W4zdAxIwrFjhSsQ3Cg0KtitERsE+mxbsoGrGAFXHxPMHVV63XrsheuMX4caDq2Eb97/uVc6LIKOT5enDKgo75vskzzwJ66kKZRdKlOxhl0nokSfToFJAdJWWUHyTUbb7BPznqEbEmEEExwEqqn9L36Ur3MHK8FKgJc46WYENMcs9FRFq+ll28+6ee4e1sORP3ih7rz2kQjF9xtfEqELAj7+YiRrJAr0xWhmwyt8LFScr98QZr5+yPQjmwD9PGB6pRDSiWuGZJ7xYDNkrxkReVqlwMc+nI5OoBuCjc2zxhWk3tONstzWo+JQ5lsOq8D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTU0MW43TTFYdnFqZldwekNyVlI5UE9wVi90N1oybHFvc01ac2JlQ0U1YzBI?=
 =?utf-8?B?R0w0NTNvOHFVTi9ETTlmODRabzFSa2JLOEgyMk5adUVUelBWL0RoeEJhMUhO?=
 =?utf-8?B?ZUl3bUNQUHBBOWVlMnlWM1hyMzd4aDkrT3IweC9NUXB0WkdTYWhvc0thNkdm?=
 =?utf-8?B?QWFCNnVqOWdPNlM5Y2RYZVpuSllDV2NaeFl3dVEwTmEwdVVaOXk4bXF6VUs0?=
 =?utf-8?B?YWptc0t0RjQxWCtrbXRBR2xZVERuNTlHZ0dhZ0t0QlRHc2JKN050cmw1eDNS?=
 =?utf-8?B?MGtnem1LZ1ZWWlY4Ry8rbFZ3NXFBYWpSMWdwRGllRTY3Q0Z2VFRmNHpWd21q?=
 =?utf-8?B?SlJNZ3ZIUVlWcE9oL2s3OFBWZzhwbjR1NVJrbklCdGtmT0txQU8vRUIvRk1o?=
 =?utf-8?B?MmQwclgzZ3lVZE5jMjFwdFNxL25pcSt3OVVoWmRWemw2M2J6MHhIMmtHcGox?=
 =?utf-8?B?eXA2bWNHZ3pTQVdwQklRdTBUaVVwcDR2TmJTNDFyYzNGcENvZGJhNW9mZmRn?=
 =?utf-8?B?aW9IWmthNzhaZGd2WktFZDhRMUtNNi9mUjBLTk96RlV2cXB2ajJlQTNWMEtR?=
 =?utf-8?B?NkdmbjJlNjBwY0g5Q0d1azJGbHR6MWpBcmgwZ1BQSlE5djNZM203czQ0THhO?=
 =?utf-8?B?UHlQR1A5RUJLRzh2Nk1ZRDVUcS9iWGJvb0xKNEVQYWNJYWI2ODZveFNvK2d3?=
 =?utf-8?B?Mkdvb0RUZXhZcUl2VE5IUWEvTUlHR29jK1R4TENSS3M1bVE0bGFJZk01Zmk1?=
 =?utf-8?B?Y2ZkREZralBoVVZRTGNFM3M1Vnk5dDl1MlNXdDlQUUowZUVveDhhVFNyZUdi?=
 =?utf-8?B?N0ZHTGlkeE5tRllKZ3FwdGZHaDh4bDhiNXV2aGc3ZFllNVpMT3FSaTJ1cmdP?=
 =?utf-8?B?VUtOSm1mYkFmUWxOUi9Ca3duQTNlWENKbDhKZC9jeDlNVmlYc3gyZFRFZk9C?=
 =?utf-8?B?RENsdS85a0tRSmZpMi9BZ3AvWUpqUlczUFh0a0NrTTFiMk5iS2NiQzZxb0RQ?=
 =?utf-8?B?R29DdVEvTmVBY2NlRHNzMnVMTDUvMGNXQXpmRE9uRmZVTU1FMnlodmdhaXA0?=
 =?utf-8?B?ZkJKQW1mNFlKRFJKTCtVM3pZV214dFNaaWhFdEtoTEdZTnJYeU9IS0FqWmRh?=
 =?utf-8?B?NVVPd01wZHlubTVrZm9tRXFuTHVGaFJTeUpBUWw0Q29IUlV0T1pNc1VlNlll?=
 =?utf-8?B?VHc5bjVTVjRKaEdJUTMwNUxqb1BZZ3E5ZFRzbWtkNHN5NWxaa3VVNjVyaHF6?=
 =?utf-8?B?WDBRNFFVVVRMTjdSeEpEbnMrbjFqK3VzTWNTYWFlT0xaOFlUT0M4SDdncU9I?=
 =?utf-8?B?cjF1Zkd2d2ZUSjlHTVVrSW1IQkdUU1RSQ3VBblk1Vlp4Tm5oWDZveEk4MUh2?=
 =?utf-8?B?N0hucFpOUXNBaGxRVFdDWDJUdlFnRUh1ZENjdFkxazVIRWp0bFM4ZjNLMHcv?=
 =?utf-8?B?cjZOTElNT2dZVUlEcWV5V09Wdkk5K3IxRm9HSkcvajhuSitoeGhjcm81d1F0?=
 =?utf-8?B?VDlVQldVb2JDMkZwcTF2a3NERk12MTU2NG1mVnJQdzk4dFBOdlpuNEJDVnNT?=
 =?utf-8?B?RlZhRGpQT0x2UVdxNDZLZlErZjBlSVhFQ29Rb3FVc1BUN1Uxa3lrSGdqV1Rn?=
 =?utf-8?B?c21ldnlnckN1V1VySzlNa3k4YUhRRnJ6SUJTdUt1VGI1RFp2aVU0K1JDVElM?=
 =?utf-8?B?WlNDTCtHY09vbi80NHZCTWg0RG9PWjJNdWJzQ24wcjdtZVVQSFlFQU8vUHk5?=
 =?utf-8?B?ZGZTc2kwNy8vMjcwWmZwcGtWNHRKTUd3UkZMRUxKUkxDNnZRMFkyK2R4TGR4?=
 =?utf-8?B?WVQvSWpPNFgwUWxCWDZnZEtoUXp2ME9DWTN1SXlOME04T3NHSWkrS3k4bEFC?=
 =?utf-8?B?M3RJWExVUnoxTlJ3NzhxSEh4QVBCOERtNkRQRDREZ2ZBVkZQMDJxbGdxdHhP?=
 =?utf-8?B?bTJYWkEzUkRrTFFaaC96allhN0pEdk9ta3M4MFgzM0dlcGZrS2hxODl2dDRF?=
 =?utf-8?B?SVBnSXB1ZnpsRFU2YVdOQ016KzV4THhoc3RkZVdsQkZRY0dKWUZrdFZSNzRW?=
 =?utf-8?B?OC9nYUl5TVZZb2FpMzkvLytPRHFMM3hFZElYYkM4cUtQM3pjSmRlWnRoQUpr?=
 =?utf-8?B?OG1BMXpQMThMWERYMmhWUXJsSkwxREZLbmRFcXh3c0FxL3dPQm9hY21Rb2Fw?=
 =?utf-8?B?bGR4S1d0MXZDREQrekRCZFhZYUp5NGRNUytMN3lmNTY3bXhkOC9sOGRFWXYy?=
 =?utf-8?B?Mm81OUtLVmpoUFFwVnRaSm9VUmF5Wk1SYU9rcXdmUXNJS3E5QmRmOEljQmt0?=
 =?utf-8?B?NXMzdTh5eCsxeHZ2bGxXTnh2T3ptVGRVRkNzWG9yTURJNTdHTVdBRFMyODQz?=
 =?utf-8?Q?2YYahb2ShxKmif7I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e55f439e-e51e-4fbc-9421-08df083b6377
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 15:12:07.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/pmvf8M+yAPx5W/hfBAxSzJ32bd4XeQ/QZsafheojLw6SKXnly2+X9S5BPOiDuFBbEHqkUZvjQgzmQMZ5BgAC3p0ksboCTVTIS9KKQ949M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11887

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyMiwgMjAyNiA4OjM0IEFNDQo+IFRvOiBB
eW1hbiBDaGF1ZGhyeSA8YXltYW4uY2hhdWRocnkua2NAcmVuZXNhcy5jb20+OyBHZWVydA0KPiBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgbWFnbnVzLmRhbW0NCj4gPG1h
Z251cy5kYW1tQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YNCj4gS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNv
bm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBC
cmlhbiBNYXNuZXkNCj4gPGJtYXNuZXkrY2xrQHJlZGhhdC5jb20+OyBKZXJvbWUgQnJ1bmV0IDxq
YnJ1bmV0K2Nsa0BiYXlsaWJyZS5jb20+Ow0KPiBVbGYgSGFuc3NvbiA8dWxmaEBrZXJuZWwub3Jn
Pg0KPiBDYzogbGludXgtcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gQ2hyaXMgUGF0
ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47IEJpanUgRGFzDQo+IDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT47IEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJv
Lmp6QHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkDQo+IDxwcmFiaGFrYXIubWFo
YWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDkvMTBd
IGFybTY0OiBkdHM6IHJlbmVzYXM6IEFkZCBIaUhvcGUgUlovRzJNIHYzLjANCj4gU29DIG1haW4g
Ym9hcmQgc3VwcG9ydA0KPiANCj4gT24gMjEvMDgvMjAyNiAxNzowMywgQXltYW4gQ2hhdWRocnkg
d3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBIaUhvcGUgUlovRzJNIHYzLjAgKGEuay5h
LiBSOEE3NzRBMykgU29DIG1haW4NCj4gPiBib2FyZC4NCj4gPg0KPiA+IFRoZSBSWi9HMk0gdjMu
MCBTb0MgbWFpbiBib2FyZCBpcyBzaW1pbGFyIHRvIHRoZSBSWi9HMk0gdjEuMyBTb0MgbWFpbg0K
PiA+IGJvYXJkLCBzbyB0aGVyZSBhcmUgYWxyZWFkeSBEVFNJIGZpbGVzIGF2YWlsYWJsZSBpbiB0
aGUga2VybmVsLiBUaGVzZQ0KPiA+IERUU0kgZmlsZXMgd2lsbCBiZSBpbmNsdWRlZCBvbmNlIGFk
ZGl0aW9uYWwgc3VwcG9ydCAoZS5nLiBJMkMsIEdQSU8NCj4gPiBhbmQgc291bmQpIGlzIGFkZGVk
IGZvciB0aGUgUlovRzJNIHYzLjAgU29DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQXltYW4g
Q2hhdWRocnkgPGF5bWFuLmNoYXVkaHJ5LmtjQHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvTWFrZWZpbGUgICAgICAgICAgfCAgMiArDQo+ID4g
IC4uLi9kdHMvcmVuZXNhcy9yOGE3NzRhMy1oaWhvcGUtcnpnMm0uZHRzICAgICB8IDUwICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9y
OGE3NzRhMy1oaWhvcGUtcnpnMm0uZHRzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9yZW5lc2FzL01ha2VmaWxlDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
bmVzYXMvTWFrZWZpbGUNCj4gPiBpbmRleCA4YmYxNTViYWRkMTEuLjZhZTk2MDI3NjY0ZCAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvTWFrZWZpbGUNCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvTWFrZWZpbGUNCj4gPiBAQCAtOCw2ICs4
LDggQEAgZHRiLSQoQ09ORklHX0FSQ0hfUjhBNzc0QTEpICs9DQo+ID4gcjhhNzc0YTEtaGlob3Bl
LXJ6ZzJtLXJldjIuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX1I4QTc3NEExKSArPSByOGE3
NzRhMS1oaWhvcGUtcnpnMm0tcmV2Mi1leC5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfUjhB
Nzc0QTEpICs9DQo+ID4gcjhhNzc0YTEtaGlob3BlLXJ6ZzJtLXJldjItZXgtaWRrLTExMTB3ci5k
dGINCj4gPg0KPiA+ICtkdGItJChDT05GSUdfQVJDSF9SOEE3NzRBMykgKz0gcjhhNzc0YTMtaGlo
b3BlLXJ6ZzJtLmR0Yg0KPiA+ICsNCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfUjhBNzc0QjEpICs9
IHI4YTc3NGIxLWJlYWNvbi1yemcybi1raXQuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX1I4
QTc3NEIxKSArPSByOGE3NzRiMS1oaWhvcGUtcnpnMm4uZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19B
UkNIX1I4QTc3NEIxKSArPSByOGE3NzRiMS1oaWhvcGUtcnpnMm4tZXguZHRiIGRpZmYNCj4gPiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOGE3NzRhMy1oaWhvcGUtcnpnMm0u
ZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YTMtaGlob3BlLXJ6
ZzJtLmR0cw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAw
Li5mNTFiYTRmZDYwMmUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9yZW5lc2FzL3I4YTc3NGEzLWhpaG9wZS1yemcybS5kdHMNCj4gPiBAQCAtMCwwICsx
LDUwIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8q
DQo+ID4gKyAqIERldmljZSBUcmVlIFNvdXJjZSBmb3IgdGhlIEhpSG9wZSBSWi9HMk0gdjMuMCBT
b0MgbWFpbiBib2FyZA0KPiA+ICsgKg0KPiA+ICsgKkNvcHlyaWdodCAoQykgMjAyNiBSZW5lc2Fz
IEVsZWN0cm9uaWNzIENvcnAuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArL2R0cy12MS87DQo+ID4g
KyNpbmNsdWRlICJyOGE3NzRhMy5kdHNpIg0KPiA+ICsNCj4gPiArLyB7DQo+ID4gKwltb2RlbCA9
ICJIb3BlUnVuIEhpSG9wZSBSWi9HMk0gdjMuMCBtYWluIGJvYXJkIGJhc2VkIG9uDQo+IHI4YTc3
NGEzIjsNCj4gPiArCWNvbXBhdGlibGUgPSAiaG9wZXJ1bixoaWhvcGUtcnpnMm0iLCAicmVuZXNh
cyxyOGE3NzRhMyI7DQo+ID4gKw0KPiA+ICsJbWVtb3J5QDQ4MDAwMDAwIHsNCj4gPiArCQlkZXZp
Y2VfdHlwZSA9ICJtZW1vcnkiOw0KPiA+ICsJCS8qIEZpcnN0IDEyOE1pQiBpcyByZXNlcnZlZCBm
b3Igc2VjdXJlIGFyZWEgKi8NCj4gPiArCQlyZWcgPSA8MHgwIDB4NDgwMDAwMDAgMHgwIDB4Nzgw
MDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwltZW1vcnlANjAwMDAwMDAwIHsNCj4gPiAr
CQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiA+ICsJCXJlZyA9IDwweDYgMHgwMDAwMDAwMCAw
eDAgMHg4MDAwMDAwMD47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCWFsaWFzZXMgew0KPiA+ICsJ
CXNlcmlhbDAgPSAmc2NpZjI7DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCWNob3NlbiB7DQo+ID4g
KwkJYm9vdGFyZ3MgPSAiaWdub3JlX2xvZ2xldmVsIjsNCj4gDQo+IERyb3AgYm9vdGFyZ3MuIE5v
dCBhIG1haW5saW5lIERUUyBhdHRyaWJ1dGUuIFdoeSBzaG91bGQgbXkgYm9hcmQgaWdub3JlDQo+
IGxvZ2xldmVsPyBIb3cgaXMgaXQgaGFyZHdhcmUgZGVzY3JpcHRpb24/DQo+IA0KDQpBZ3JlZWQs
IEkgd2lsbCBkcm9wIHRoaXMgaW4gdjIuDQoNCktpbmQgUmVnYXJkcywNCkF5bWFuDQoNCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
