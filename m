Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514477;
	b=l5rjb3xH7EoKoc6ecYW/H7pFVNuxP8pHgiZrkP0NuWwcHzf/BWqr7/8VXkeUHiBCWj9V
	 CxuqQ4BMIYVVDA9FX6wXduijyXBceCNMyRWgxaZ8WinjfGSMuIELvqgRNXxCtv76VkJg0
	 gajNmyQqRBATn0KxDSnmqtgIQYuLvGNWx6egJriXJ8Uwix2m45onq/0lDgycbmGRXz6qt
	 XzJsst5f096RYsHIbacliBzPN0OjtKThSxxlkBDOoBPqYENoms/3rPX7OVBA8UAa6Xi7A
	 dGxPkgxx1/J0ib6iR/9YQxMNNLE1VNWvTSIy8AtBchLfkr84DeoXcVIAKnqWHlpiA9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514477;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=0FgPsFtypClOYFAMfW/GuDT+97N3OvYYWljLNhJ/gkM=;
	b=IENnUzAeIaZW8e2gVBpWtgDuvhilskYVonHX3VDXI+kc6CIlZ52GuMc+UKLUst6T7p7I
	 Hy2bxrt+7EAj2EQ0b/kZo566Vhf8wks+R80abiMEBt8Oa1yMQ/svCknsoUqjdFTm3I8t5
	 fDp7JzJsfh4oo7aTVu+9kUyZMpbdvzx6fQd5K1LzUnqXkOfxG4fQtrnqvj2FEoAPgERX/
	 TtX8xuJ+psl0xNbomwY/FWQrnKbO6z/ZchgiwDfS36LrUszvq3F/18mqEj7yFLekGPBPJ
	 2vm46J9VrRiMxss5dq/E/VZXHW3Clm/+/a4sSEEDbjxdsvy4DBNm14bqNgul+ZmUvng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LiJ0YZh7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.30
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB7606A32A;
	Tue, 24 Nov 2026 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBEB7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LiJ0YZh7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnxD/WLWcsW6wafoBL6It6UxXT9DXaRD4AzIEkcHtl6q4yA7zum+8ANqtqHkanP2YM627BMJZKD9upEMz++mhbm0455vPVigir8oKDvSrqMxc8rYfF4/glZ+l8kC4YVaGwylcQg7KzXPsruAHwlwVtuIqcPrPPGuOx4eJZNntazNp0eIvtTpfALR6VXlat6KrnYnpfPCjsBLL0gXnz/Vbwa1esEjLhRstotnSNvKXgLE4LcJ/Boji9Wz5nNJpu2TUWvCHAJzTi8l0L7AImv8R9fC5yPPwl6rsVDYYXZr76I5hsaCtr2joNqpkwWz8bugVLOi9DsgqBwuQd1zYQ6gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FgPsFtypClOYFAMfW/GuDT+97N3OvYYWljLNhJ/gkM=;
 b=r7+EC9yAAe5PvEk+EseUKFKYcaX13+sR4xB9AOOYthFXibLGL1ih3OeVbHRFr+H8iNdkf3JPGFBQkoxXTp/cIfYmTKH9MUhSQ4uQ3DiuZXlNOu1xSQECeeXLDye3PRtYZiDZ6W+Lz0XNTJU89u5MVq/ayleUJ/YPJnkTWSw1M+p9HuNX7UGliXUtQRHKbJDq/FaBxzI4eyZWvjJNMNM3DVzqPluwLZxB55j+CFxaqqv2JmWI+b/O6TtWWQsVdLpzsbqoywcKsf/XumL4/qZxfsunGKjbTaf0kW7IV3Y7L/R1J+V8Pv2fDj2o5KgN/8lsuosS5LQ8uO/uDaVDf3u+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FgPsFtypClOYFAMfW/GuDT+97N3OvYYWljLNhJ/gkM=;
 b=LiJ0YZh7EBHEX+sCSQkp/pvwuGkpxek0VOQ+aEh33edNLo1TIfxfh43PUopqE8z89bA3tTbhTwqswsbAdo+UimBu4YqE5jrkNMJOtTGxWfQBrpEV4A2PcE6yItK6YakmprndbfSs/8wJcKv0o5OssmgHNYoHYC2GTekC25/gQgg=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY7PR01MB14856.jpnprd01.prod.outlook.com (2603:1096:405:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 10:01:12 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 10:01:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Chen-Yu Tsai <wenst@chromium.org>
CC: Bartosz Golaszewski <brgl@kernel.org>, Cosmin-Gabriel Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
Thread-Topic: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable
 stub functions
Thread-Index: AQHdez8n11tqWYAHqUqCrqPpCgEtFLc7lviQgAEqKYCAABu/cIAABViAgAAcWUA=
Date: Tue, 24 Nov 2026 10:01:12 +0000
Message-ID:
 <TYYPR01MB6603B16FE5158C3B38EAFC7186442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261123113755.3033436-1-wenst@chromium.org>
 <20261123113755.3033436-2-wenst@chromium.org>
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com>
 <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <CAGXv+5HmXyVn6dY3Ve6ot28p=08giJ00SoXmpfcaSLoZVgbCyw@mail.gmail.com>
In-Reply-To:
 <CAGXv+5HmXyVn6dY3Ve6ot28p=08giJ00SoXmpfcaSLoZVgbCyw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY7PR01MB14856:EE_
x-ms-office365-filtering-correlation-id: 3f65985e-6d59-46cb-de33-08df4a11def9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|4143699003|56012099006|5023799004|11063799006|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 EQ1zdWYyxQUFhNHJgfgBjt4hxQaf+Nwi6YmNoUO8n6DOiJRcmQUalHLeNreZMYA0icqimcOYcxDaS8duCQtBKI0rPV9SPphtuazvA6gAc75j4+imEbIY1NDhCHW0pU5LXoGEyRFy92eli3r5Edf5ogm1RYd1R2DGSHtWUADQBPk2eGWtMBl+TUR4pFViuQEsdLfItMPdoAnmNGO27ybROwaOgm8DYia7Wtei9LhECKzrJPb0yVZjX1LSKseBKOjPhtrd2qFP3TyMeO9MMbx1v5Y9R7NUwfkTrA4CbMwENmiWBJPr6apbBsItcPig4ebpL4vuQq9MzgvAoxxc0BOS0D+kHHZhJTXLlr8oXWOTfhWG62oS5pLWD1AN804O97ThLhT02QgXAYf1PpJ5VSnLY5dafDCoE0r3TTumFR1aRZtpCT61HpagQaxQa4YskrPeYCmiWCfE877hlD8mXsHpaySeHfm48B9yfQQXwGQzMAHvJ6SE9CrLnbO4KTjlkfu+YJJWpsoJCPqysphtOYeYeg+tgeHc0Ogqi+CQ9EuyW4YZg9H/2aRK6FJZc02MvnyYV+msJX4hAnTdrOXC/H6ggNJCB05Jdh2xrxe2Iu1C2fqoJUNo4aB6ig6XF8s5Ta+KPJY3D+2o3htuG3gDlNlMlvhs3cu0wfRoS1Oy9iNlCbAsxO078TsMHkjRkrNr3i094YLOarmICOy4UB6rk5t8qtbgFFSU+50D5voCylP+jAk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajRRZzU4TTNRUXlMakRTbE90OWtVVzcvS2tqLzNDVVYzSWlLcGY4MzRHS2JE?=
 =?utf-8?B?b2UvRGsyUjR1NWNXWkhDYnU3WnJhSVhHRWtKQStFcFhpSTdSZkZDanNPeFRU?=
 =?utf-8?B?QStQRGlmSk41OWI1RXErRG1wc2p1L1JvQjFWdm1OcE9XRVRFc0hycWs0eTF5?=
 =?utf-8?B?VjZxQkdPd0NkYm9iK0o3SjkrWlBpMzZ4TnlzbHpCckMxNGZqSnpnK0JoZGZv?=
 =?utf-8?B?MFA0V2hBZml4bDhQZDF2MEVib0N6ZWJGUU9GZXVGTXc3d3hSajNPSFhWa0Js?=
 =?utf-8?B?dGdHQXkxMkJMdkUwbmUwQXlKcFlaemRqYnFHK3lVUi9qRWtGTjQrUzNMODJa?=
 =?utf-8?B?SGl2a0NaUzNVRElGdkdlRUsxTXdkTWVZKzNNV0lLaXhOWVV0ZVFnZVVVT2tU?=
 =?utf-8?B?djFoalZsWENjanlCM21uN2Jia0lqcnBJQWJuWGs0M2ZBRGxmc1pBV3hOb3hE?=
 =?utf-8?B?bGY3S1lReWpkR280VWVLUTB5VnZIZVRvcmZSQ2VKZ1l1aWdraklKc2xOY085?=
 =?utf-8?B?SW9meVJWekNSd0VFTTlJbFArWHV6MjI5Mk9MVFZYWFJGeTQ0T0tJUU9tdk44?=
 =?utf-8?B?clUrbXQwRjFOVmphN1BXOW5MaDc1Mm44b1ZSSklqVk1Wd09mTkU4MHFiWVdB?=
 =?utf-8?B?ZmRneHJHS0NYazhoSXRPVEx1TzNDc1VaUjU0cDNLSitya01BNUg3Z05CQzdM?=
 =?utf-8?B?ZFdnUUNub2dFZ3hSRTlLY0hTdU1MT0I5QkM1UWNrK282ZmcrWXBwazFWeVBk?=
 =?utf-8?B?cS9GTVhLYlFqb1NteGZucHE0OTVmSms0TFJQd3Y0SjJjKzBTMVhpenFqTzRk?=
 =?utf-8?B?OGp4dHY1MElBVlFWU0cvbmlOZU5EVFhiM1pHUDkxeG5xZ1BQZnhycVYxZzJD?=
 =?utf-8?B?SVB4c1ltcllIRjBwV1JHa2lvRnVCdmR2S25pOUFvTlpzc1gyRjBZUUJEeG9z?=
 =?utf-8?B?RW4vdU41RGFhZVdhR0JTVkxoTFJReFZCcGh6Z25zdStyMXh2bXpweWJ2MjVi?=
 =?utf-8?B?MmdtYjlYd0NjYW5PaWdDNlY0Wm1VTWY4UVB1b3lWdDBndjJIUEZad3lSS1py?=
 =?utf-8?B?MHFQRzhDVnlGNERxMk1aNGg2QkJ5RzBkdGlSZXJVNDVPbHgxUFN6c3RpczJN?=
 =?utf-8?B?amtTTGN6bUhVbGVma2Y1dU9CTFcwYkxtdmtTS3lQZGVIMHRMMFVPV3JDcGNq?=
 =?utf-8?B?OVlNV3YwektuVnF1RVZXdXBrMUhXMDUvZDFRUU9qb1RKTGhhWjI4YTNtcnFs?=
 =?utf-8?B?RU9IbHlxcitFenVrM1NZdXo1UmR4R04rcUJqakc5L0MwcUs1bWxUK25RKzdt?=
 =?utf-8?B?QVNuWmlKYWhlTk51VTZRK3JVUTFmNzNIaGR2dWU1WTJCSUpGaHhOZ2lueGxa?=
 =?utf-8?B?djR2Q2puai9ZQ2xuT2FQQkl4a2xOTHNvSm9YblpoZ1VZQUo2bTNiUGl3bng5?=
 =?utf-8?B?NUhMVnlmSFJaZ2NvMXFVZURxRWlXVmMrZ2c2UEhUdWFZSFRPZ1cxVEMyb1pa?=
 =?utf-8?B?THhBTkdlcWlQVGVHVWM3N2xZSVdEbFU3UGI5Ymc1Y2I0dFVRcWorOXIwWU5M?=
 =?utf-8?B?djJ6akhmaWRoNzN1OTJpTThjS3UwSlJzcnJNWXI4ajkwTTViMnFvQzQ5MUNt?=
 =?utf-8?B?SXpoM09WKzRkZEkwWGt4djF5NUtXWkM5SjRSWjdnWHZ1MENVNXA5WG81bysv?=
 =?utf-8?B?Q2dxK2Y4UldNSVkxOVREY2NlcUpHd1JHT3k1cUUyM0lBcTRsT0NSTXdVeU5h?=
 =?utf-8?B?N2JpUmJvSXQwODRvdlBYNjkzNmJkaS9uZU43Rks2YWFibm1JM1NzMllxdUM3?=
 =?utf-8?B?dlRncHVzbkJnVi9KVnM0TW9SWVcyWlN5Z01vbzgyelpneGNCRW9GUmhocUti?=
 =?utf-8?B?czlQamg1c1FDUXRXa0t2elRwZ2EydjgvWmxyR0FMRVlBOWwvTDN6MlBRODRV?=
 =?utf-8?B?cTdaZzFNcldVSmRpTW5HK3pFVVNWeURKZ0lvZVhzeFQ1S1VNc25yTE02YTBw?=
 =?utf-8?B?NE95bzlWOUlRUnZPaEZGUFdiZjJYZE5SV3Z5MkhuZGVQY1dUQ0MrVytqRzJ3?=
 =?utf-8?B?NWJ3QXRtV0lZTUpMVVh1dEtsT1BWby9HNnBJL01RZWRUVVJTL0NBWUtkTFNH?=
 =?utf-8?B?ODFUOEgveUhueDBEQ2NnY1pnMFBpOVhtM0NaMzR1a2tWSk9qKzlpN0dMMnBZ?=
 =?utf-8?B?U202UnFOa3VSTlB2R1pVSU42c0NxdEtGWFNpcXc1azhVL25YNTZTYmpGd01v?=
 =?utf-8?B?RUMwQVFrNFdldFRadTRyZkd4K1diNzl4K2JBTFNCaS9iQ0dXdnlaSmdOODNk?=
 =?utf-8?B?UVdCbEpaTGlTcFJhSTZBeWorV2JoUzM2R21UaDFMWXFWZ3hxRkhRQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f65985e-6d59-46cb-de33-08df4a11def9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 10:01:12.5142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qs5lNRpfxVqlL9zZWSgzCokpUCbpuzTbK6yvuUT17aKtDBd1XNng+Au/9IsslEYQpy7ydm9Rv8igQNsydUOxcFdTWcZ7QX73cxEKRGr0HN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14856

SGkgQ2hlbi1ZdSBUc2FpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiBTZW50OiAyNCBOb3ZlbWJlciAy
MDI2IDA4OjE4DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBwb3dlcjogc2VxdWVuY2luZzog
QWxsb3cgZGVzYz1OVUxMIGluIGVuYWJsZS9kaXNhYmxlIHN0dWIgZnVuY3Rpb25zDQo+IA0KPiBP
biBUdWUsIE5vdiAyNCwgMjAyNiBhdCA0OjAw4oCvUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIENoZW4tWXUgVHNhaSwNCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IENoZW4tWXUgVHNhaSA8
d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiA+ID4gU2VudDogMjQgTm92ZW1iZXIgMjAyNiAwNjoyMA0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBvd2VyOiBzZXF1ZW5jaW5nOiBBbGxvdyBk
ZXNjPU5VTEwgaW4NCj4gPiA+IGVuYWJsZS9kaXNhYmxlIHN0dWIgZnVuY3Rpb25zDQo+ID4gPg0K
PiA+ID4gT24gTW9uLCBOb3YgMjMsIDIwMjYgYXQgODozNuKAr1BNIEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhpIENoZW4tWXUg
VHNhaSwNCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiA+IEZyb206IENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiA+ID4gPiA+
IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMjYgMTE6MzgNCj4gPiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBwb3dlcjogc2VxdWVuY2luZzogQWxsb3cgZGVzYz1OVUxMIGluDQo+ID4gPiA+ID4gZW5h
YmxlL2Rpc2FibGUgc3R1YiBmdW5jdGlvbnMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBub24t
c3R1YiB2ZXJzaW9ucyBvZiBwd3JzZXFfe2VuYWJsZSxkaXNhYmxlfSgpIGFyZSBuby1vcHMNCj4g
PiA+ID4gPiB3aGVuIHRoZSBkZXNjcmlwdG9yIGlzIE5VTEw7IGhvd2V2ZXIgdGhlIHN0dWIgdmVy
c2lvbnMgYWx3YXlzIHJldHVybiAtRU5PU1lTLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyB3
b3VsZCByZXF1aXJlIG1vcmUgY29kZSB0byBkZWFsIHdpdGggb24gdGhlIGNvbnN1bWVyIHNpZGUN
Cj4gPiA+ID4gPiBpZiB0aGUgcG93ZXIgc2VxdWVuY2VyIGlzIG9ubHkgbmVlZGVkIGZvciBhIHN1
YnNldCBvZiB0aGUgc3VwcG9ydGVkIGRldmljZXMuDQo+ID4gPiA+ID4gT25lIHN1Y2ggZXhhbXBs
ZSBpcyB0aGUgcnp0MmhfYWRjIGRyaXZlci4gT25seSBvbmUgb2YgaXRzIHR3bw0KPiA+ID4gPiA+
IHN1cHBvcnRlZCBoYXJkd2FyZSBibG9ja3MgcmVxdWlyZXMgYSBwb3dlciBzZXF1ZW5jZXIuIFRo
ZSBkcml2ZXINCj4gPiA+ID4gPiBjb3VsZCBiZSBidWlsdCB3aXRob3V0IHBvd2VyIHNlcXVlbmNp
bmcgc3VwcG9ydCBhbmQgdGhlIG90aGVyDQo+ID4gPiA+ID4gc3VwcG9ydGVkIGhhcmR3YXJlIGJs
b2NrIHdvdWxkIHN0aWxsDQo+ID4gPiB3b3JrIChwcm92aWRlZCB0aGUgS2NvbmZpZyBkZXBlbmRl
bmNpZXMgYXJlIGNoYW5nZWQpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxpZ24gdGhlIHB3cnNl
cV97ZW5hYmxlLGRpc2FibGV9KCkgc3R1YiBmdW5jdGlvbnMgc28gdGhhdCB0aGV5DQo+ID4gPiA+
ID4gYWxzbyByZXR1cm4gc3VjY2VzcyBvbiBOVUxMIGRlc2NyaXB0b3JzLCBhY3RpbmcgYXMgbm8t
b3BzIGxpa2UgdGhlaXIgbm9uLXN0dWIgY291bnRlcnBhcnRzLg0KPiA+ID4gPg0KPiA+ID4gPiBD
b3VsZCB0aGlzIG1ha2UgZGVidWdnaW5nIGhhcmRlcj8gSWYgc29tZW9uZSBkaXNhYmxlcyB0aGUg
cHdyc2VxDQo+ID4gPiA+IEtjb25maWcgb3B0aW9uLCB0aGUgc3R1YiByZXR1cm5zIHN1Y2Nlc3Ms
IHNvIHRoZSBwb3dlciBzZXF1ZW5jZSBpcyBzaWxlbnRseSBza2lwcGVkLg0KPiA+ID4gPiBUaGUg
cmVzdWx0aW5nIGZhaWx1cmUgKGUuZy4gY2FyZCBub3QgZGV0ZWN0ZWQpIHdvdWxkIHRoZW4gbG9v
ayBsaWtlIGEgcHJvYmxlbSBlbHNld2hlcmUuDQo+ID4gPiA+ICBTaG91bGQgdGhlIHN0dWIgcmV0
dXJuIGFuIGVycm9yIHN1Y2ggYXMgLUVOT1NZUyBpbnN0ZWFkPw0KPiA+ID4NCj4gPiA+IEkgdGhp
bmsgaXQgZGVwZW5kcyBvbiB5b3VyIGNvZGU/IFRoZSAoZGV2bV8pcHdyc2VxX2dldCgpIHN0dWIg
c3RpbGwNCj4gPiA+IHJldHVybnMgRVJSX1BUUigtRU5PU1lTKSwgYW5kIGlmIHlvdSBwYXNzIHRo
YXQgdG8gYW55IG9mIHRoZSBvdGhlciBzdHViIGZ1bmN0aW9ucywgdGhleSBhbHNvDQo+IHJldHVy
biAtRU5PU1lTLg0KPiA+ID4NCj4gPiA+IFRoaXMgY2hhbmdlIHNwZWNpZmljYWxseSB0YXJnZXRz
IGNvZGUgdGhhdCBleHBlY3RzIHB3cnNlcV9lbmFibGUoTlVMTCkgdG8gc3VjY2VlZC4NCj4gPg0K
PiA+IENhbiB5b3UgcGxlYXNlIHBvaW50IG1lIHRvIGEgZHJpdmVyIHdoaWNoIGV4cGVjdHMgc3R1
YmJlZCB2ZXJzaW9uIG9mDQo+ID4gcHdyc2VxX2VuYWJsZShOVUxMKSB0byBzdWNjZWVkPw0KPiAN
Cj4gSXQgc2hvdWxkIGJlIHRoZSBjYXNlIGlmIHRoZSBwb3dlciBzZXF1ZW5jZXIgaXMgb3B0aW9u
YWwsIG9yIHJhdGhlciBvbmx5IG5lZWRlZCBmb3IgYSBzdWJzZXQgb2YNCj4gZGV2aWNlcyBzdXBw
b3J0ZWQgYnkgYSBkcml2ZXIuDQoNCg0KWWVzLCBJdCBzaW1wbGlmaWVzIHRoZSBjb2RlLg0KDQpS
ZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVl
cnMsDQpCaWp1DQoNCj4gDQo+IFRoZSByenQyaF9hZGMgZHJpdmVyIGJpbmRpbmcgdG8gInJlbmVz
YXMscjlhMDlnMDc3LWFkYyIgZG9lcyBub3QgcmVxdWVzdCBhIHBvd2VyIHNlcXVlbmNlciwgYW5k
IHRodXMNCj4gY2FsbHMgcHdyc2VxX2VuYWJsZShOVUxMKSBpbiBpdHMgcnVudGltZSBQTSBjYWxs
YmFja3MuIEknbSBhcmd1aW5nIHRoYXQgaXQgKnNob3VsZCogd29yayB3aXRoIHN0dWJiZWQNCj4g
cHdyc2VxX2VuYWJsZShOVUxMKS4NCj4gT2J2aW91c2x5LCB3aGVuIGJvdW5kIHRvICJyZW5lc2Fz
LHI5YTA5ZzA1Ny1hZGMiIG5vdGhpbmcgaXMgZ29pbmcgdG8gd29yaywgYmVjYXVzZSBzdHViYmVk
DQo+IGRldm1fcHdyc2VxX2dldCgpIHJldHVybnMgRVJSX1BUUigtRU5PU1lTKS4gQnV0IHRoYXQg
aXMgZXhwZWN0ZWQuDQo+IA0KPiBUaGUgcnpnMmxfbWlwaV9kc2kgY291bGQgYmUgYW5vdGhlciBl
eGFtcGxlLCBleGNlcHQgaXQgd29ya3MgYXJvdW5kIGl0IGJ5IHB1dHRpbmcgdGhlIHB3cnNlcV9l
bmFibGUoKQ0KPiBjYWxsIHRvZ2V0aGVyIHdpdGggdGhlIHB3cnNlcV9nZXQoKSBjYWxsLCBhbmQg
Ym90aCBhcmUgZ2F0ZWQgYnkgYSBoYXJkd2FyZSBmZWF0dXJlIGZsYWcuIEFuZCB0aGUNCj4gZHJp
dmVyIG5ldmVyIGNhbGxzIHB3cnNlcV9kaXNhYmxlKCksIGluc3RlYWQgcHJvYmFibHkgcmVseWlu
ZyBvbiB0aGUgaW1wbGljaXQgZGlzYWJsZSB3aGVuIHRoZQ0KPiBkZXNjcmlwdG9yIGlzIHJlbGVh
c2VkLg0KPiANCj4gQSB0aGlyZCBleGFtcGxlIHdvdWxkIGJlIG15IFVTQiBwd3JzZXEgaW50ZWdy
YXRpb24gWzFdLiBQb3dlciBzZXF1ZW5jaW5nIHN1cHBvcnQgaXMgb3B0aW9uYWwsIGFuZCB0aGUN
Cj4gcHdyc2VxX2VuYWJsZSgpIGNhbGwgaXMgY3VycmVudGx5IGdhdGVkIGJ5DQo+IA0KPiAgICAg
aWYgKCFJU19FTkFCTEVEKENPTkZJR19QT1dFUl9TRVFVRU5DSU5HKSkNCj4gICAgICAgICAgICAg
cmV0dXJuIDA7DQo+IA0KPiB3aGljaCB3b3VsZCBub3QgYmUgbmVlZGVkIGlmIHRoZSBzdHVicyBh
cmUgbm8tb3BzIHdoZW4gZGVzYyA9PSBOVUxMLg0KPiANCj4gQW5kIHRoZXJlJ3MgYWxzbyByZXNl
dC1yemcybC11c2JwaHktY3RybCwgd2hpY2ggaGFzOg0KPiANCj4gICAgICAgICBpZiAocHJpdi0+
cHdyc2VxKSB7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBwd3JzZXFfZW5hYmxlKHByaXYtPnB3
cnNlcSk7DQo+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgIH0NCj4gDQo+IA0KPiBCZXNpZGVzIG1ha2luZyBj
b25zdW1lciBjb2RlIGVhc2llciB0byB3cml0ZSwgSSB0aGluayBhbm90aGVyIHBvaW50IGlzIHRv
IGFsaWduIHN0dWIgYW5kIG5vbi1zdHViIG5vLQ0KPiBvcCBiZWhhdmlvci4gSWYgImRlc2MgPT0g
TlVMTCIgbWFrZXMgdGhlIGNhbGwgYSBuby1vcCwgdGh1cyBpbXBseWluZyB0aGUgZGVzY3JpcHRv
ciBpcyBvcHRpb25hbCwgdGhlbg0KPiBpdCBzaG91bGQgYmUgYSBuby1vcCBmb3IgdGhlIHN0dWIg
dmVyc2lvbi4gRGlmZmVyZW50IGJlaGF2aW9yIGp1c3QgbWFrZXMgaXQgaGFyZGVyIGZvciB1c2Vy
cyB0byB3cml0ZQ0KPiBjb2RlIGFyb3VuZCBpdCwgb3IgbWFraW5nIFBPV0VSX1NFUVVFTkNJTkcg
YSBoYXJkIGRlcGVuZGVuY3kgYW5kIG5vdCBkZWFsaW5nIHdpdGggaXQuDQo+IA0KPiANCj4gQ2hl
bll1DQo=
