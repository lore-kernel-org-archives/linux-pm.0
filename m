Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795507211;
	b=RAiZxdw28uGvE4/VyNf/QR/sJkszb4gJ145cxQ1BAe4WNqje0N5IJyYrfGl5AeAhjJWH
	 6bs2E7przs0gAWFBrPOTibF94GB05Ka5fwgeKKNy3VllhH7T/40N1r8NmdqP1v2dSpWkS
	 hMZ7CKcqmop4NQMP/qKb/8R0UxsuFfDRl0N65sHgoGqYOdIvmpQlFXE2HOQueRpXcbWVj
	 Ayns8LtsDwMcd1a/zliMvDRW/z+EHjUo63aQK09oKFpeFCEzCbEE1Vyp8luwVUyOjZ8bZ
	 +Qg/Pg5F3HcTsiG9dhDWhCesA5o3t6zO6N1CFKVIz/YP7EgK5bCrYyIYiecidy77m/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507211;
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
	bh=UCO5IusPSQFfsJuZNL6oX4srsoIrg2JbB1xXoL9W3h0=;
	b=FVStUKWxu2+2H0TgBLKk9erNnBOXv7VS54NLy3U6zGVHgXQOPiD/lRxyA2rTzUdrolIl
	 jQPeoS7LfWqMZiV+qbN6VoIdzH97ar0F2pqzrtqroXg2uJUeTArWBDQfPOE3EjzBBbzPO
	 58tmXj5olNWV7ogDV0l3qVxVdv4TsyKp43sUPstuP+QjtOEvD7n3HYnkRQzYYmMn6rlQT
	 dzJ5E/Craa5JhAc7Wv+qu/UWeMiOlKnJlUIg9I65hgsmHIFQYAeTj+Yu1+DTMHrsORxN9
	 RL3Z+GmN47/idh+claPHEPqP3wvyBWx5GAdPfEXQaWLd+AN7wjtKBMQJDEK2gateyuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=qPw1RBvo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.6
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011006.outbound.protection.outlook.com [40.107.74.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B488606A326;
	Tue, 24 Nov 2026 08:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B488606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=qPw1RBvo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw14uMJQSV6fjEBzK4PK7Hi4zV+q5RqbarDU4yyvAFuGL5S/un8z1bTOEcK5yGdEcQ/fXajDg3Op8Mo5Nare2KK1FTb9KfRxA9A8Bwd7CUeer4teZUoLaFVNRdJs3dvt4qloouT1RWCFi2hUEs7zdgzgrrD+vf0njmOPq+VzOpUNpgVqOyCMK8Zsa68wQSlqeE31OirxkxSJbOW+BCSfV2E5EvLIAH6ozoih2IKUIMSxuuyTHEofTmLfG8xQukwouqaWHnMm/zGLWZNzTlqtgzxsrnbxdGetP7Nk/6IKAIvcvvuYnWCRfFfSU+A0rVpc5pe5AcbtQy8A0nbMLLWTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCO5IusPSQFfsJuZNL6oX4srsoIrg2JbB1xXoL9W3h0=;
 b=nUn+QKOQU2d2e0k3eKFmJ2C8FvxDn9UzVXoYi5kjlUrxnx8+NYnLXsSQVxKAhr65N1ujvNOovIr+sgNJzJXi6CuxtFabfXWBDNnUEZ6Ewe4mthmkqz9+qN9WO2XbLn0/f8EbLIPOJQqI0nF5sYZ8l3pAswiJee/e1Bw5JEUbdK1M8UTf6B/541gm1jiUBXa8VoNB3YTqzbEoiwRs3uW8/JeeW8y8hF04DaU/zqZGzNqYVLr94lAoS/fPnYj8syfyFeEvE8stCcpcYNttPFIYsYOssoHK94fVIoXi2k5+sljbzAUJ9Ay/bVXoqHjmcRNwhApg79Gvjq8wqENvFjafzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCO5IusPSQFfsJuZNL6oX4srsoIrg2JbB1xXoL9W3h0=;
 b=qPw1RBvoExLewE9BIJXXe5McphlBkLvfBisUlwco6k+ulx3b+ZsFLZfHyXNIIQ+6zXUWvgq6rBlaBkQNneQKKyxkZjGJ2Y9Y3gJMO7rlPASNnCDNt2VssKn31yGq9vlcapkq21bX8BzljuLaD+ywEGHK3TO11UVKRIbjCtgveX8=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OSCPR01MB12518.jpnprd01.prod.outlook.com (2603:1096:604:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:00:07 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:00:06 +0000
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
Thread-Index: AQHdez8n11tqWYAHqUqCrqPpCgEtFLc7lviQgAEqKYCAABu/cA==
Date: Tue, 24 Nov 2026 08:00:06 +0000
Message-ID:
 <TYYPR01MB6603B7932D3122DF0622230F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261123113755.3033436-1-wenst@chromium.org>
 <20261123113755.3033436-2-wenst@chromium.org>
 <TYYPR01MB6603FFE6D156C9E84C9891DA86452@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com>
In-Reply-To:
 <CAGXv+5E5fSyU6gEPk7BLQdz6wXpgSxaXShM_zTtjuim5W_pxdA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OSCPR01MB12518:EE_
x-ms-office365-filtering-correlation-id: 85a0f1c7-63fa-45ce-a17e-08df4a00f446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|18002099003|22082099003|261021121427099003|261026140227099003|261022105027099003|261102123227099003|38070700021|261028144727099003|56012099006|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info:
 1KVewtF6rdLJcV+Nj2OnIk5M4MV2hPSdChxo7g/5n0b6auwSeRuTdo4I5mjt26YZ/INFdHF8giKyu8qx8cB5JYIuUUastTYvHIHK3mimHlniN28lbeMgTfX8NTfwCxHlTz+1+bnRECkkUlsKTamFPuoflxz23Rx8hlpWzFpL+Ilp3UZYNTSUS63fec+2HQqhcxXOSqayQ7OaNFc6ijtX62YdjGPvggOCS491mdmud6X5f3clUfIx3v4L0a8xi31l9mSHmNfrCb/xH4xtqdfnVQI33TMuixrpGC7joLQBbURGYEKWJA+dPYZPw9PCNTlEaLDr0+57sjpRhDo3d6J9iSn0OTK4CdZO1kWcMSnuSdV48AR/m5YWki4/jk1X1+b/2EumIYForljFnS+Hr9ZF6gyD/fkbGTGbMVzapNRR7FqGxJRZV5Lv8s4Wrchm5BZPymjLnJHQ9OU9B/PLikbkGDqomIWiJ6G42n8tFT66M/SkdOjmOuPKF+jlkgsOFEnXolVO37rH4aSM+AaRXWF0oKfRQ28IeAc1wr7u0/2i8hPd08eqmAIXdjFdgTJ3jyB4QX5JUPQFmpqLue113vI8B/wbWk0J/6ZQBDG5/IV4HmRxyEIWDHCYV+NMg/TWFcL2p6YMziRu15kkvGPi7x3wJiuEK8u1lmxgD18e76/H5AFg16jh1nGFe3cmmO6C0UMrREphe+dWmQodeyIoq90NQRjRRNOJoB2Oq19rfgnYwRM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(38070700021)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d28vK0JPN29HQ3FTTXNFaEhJaXFKaGZoZitML1psUWZPdFEvcWZSVXcreVh5?=
 =?utf-8?B?Y1FkSjBoTGxETTkyQXgvT1pPc3BJNXdka0cvN2REemZ1Znd4RVVBZlVwZ2Vz?=
 =?utf-8?B?ajh1YzhFWjEwV1FuRTV2b1JmbllWaFlrTzhTRUhwRDhrTGVRZk13dnJQZXJ3?=
 =?utf-8?B?dUNKbHhPZWNOcmhHSGtRaHhJS1hYUFZCanRyT1dmL2NIZXU4OUMrRUE1ZG9k?=
 =?utf-8?B?S1dGa2ZFQVJHdU1yb2NxdmNDSjN2VENxM1ladEhFV3ZTSlVzRFV1RHRvTHJL?=
 =?utf-8?B?dTkrRHNkcFRnbDFLdlRYcC9VN2dXSHFxbzdUWkZuNFhzYm90VXY2cVV4UUx4?=
 =?utf-8?B?ZHBwbjdWazlGMmJ0Zmc4aGZQbUFjUmYvN0x2TEtjU29LYlJvSlAvditmV3g5?=
 =?utf-8?B?YTNlN2dRMThmK1N1Zy81b0V2a3F2Q3ViZ3lQc04wK1AxdWxsbmt3VUwwQXdV?=
 =?utf-8?B?eVgyazFoVE82TXR3WUpnS29udFd4QzRDUk0vQjZVd3lEaGJVdFVyaTJ2NThj?=
 =?utf-8?B?dTlrdmNsb3poZVY0OXFHZk9oZE9ka0ZyaVM0NDRxelRsK2NEQ0NtdUlJa0xy?=
 =?utf-8?B?NE1BQ0JaSWZIckoybFl5T202bTlGZFFhSmdJVTJZTTErVlNaTDExOUJWYjdq?=
 =?utf-8?B?UERwTCtkUXdyalNoWHh4bnBMVWpmVGRTajVqdUYzaFVia2J2d1JrNUJGYzQ3?=
 =?utf-8?B?dmJmY1RoNHh0NVJWQUZZR1I4aElpYXU4aFpncUhEOHl6UEU3RklEN1lnQk5q?=
 =?utf-8?B?WGN4RmZlU05tbWxQSkdpb3VWNXNTbXNOdXFJUXRnOVluRjZSNXZ5bDJEY3N2?=
 =?utf-8?B?UkVFZW0vcklzTHpmemI4OURpNlQ0RXJQNlBDTkF4ZTEzVjVmRHRMWldNcFE1?=
 =?utf-8?B?ZWI3dTNQRmp3RElmV0szT3hTZytUdTVnekw4czYyZnB0cDJzam1haGpNMTU3?=
 =?utf-8?B?Q2ZLSGFvc1RZdTZOTFVDNllUZnJlcEozMFhaU2J0aldqcmNJalA4VFNMKysv?=
 =?utf-8?B?b043N2VBU3h1dEFvSXZxVkRnaEQ0VjdlQmExQUFheUdGZVZUejBYUjNUNVdR?=
 =?utf-8?B?S3U0V2twYzdhMjR4RGhRSWFpL1JqZTU3UXN4VVYyT0R3K1liUTdOaSszaWov?=
 =?utf-8?B?VkhOK2poa3lCZGttL2EyNzFENVA4U0J6Z2MwbGlxcGVLN1gwUEFBbm5sQ1lo?=
 =?utf-8?B?eHI1cU9HT2FobkhTY1FwM2ZLK2tKSDY3SXI0dU5FQzBRMzY4UjU4VEtybkE1?=
 =?utf-8?B?SE5kejladmtqWnBYdkFIRHFncGxBOVVrendlTXBqaHZmTVpVRTVrT0JTM2F3?=
 =?utf-8?B?cE4zcXpoM3FPcE9sLzhmQlpGeXlWQmN0S2dVeGxZQkhzVjFwVlBzUnVvV041?=
 =?utf-8?B?NlZQU2VPajMwZ1NWdmdPQk4wTnJ1d1hwbHNtM2x3anlxdy9NanIvQTdrdG04?=
 =?utf-8?B?RGM4cmplR01oVW83aVMyd3FjSTJ2b2NHa1V5djkxK0xEM2FCNmpWUjFRdzZm?=
 =?utf-8?B?TlIxRnhWdFZhZ2NKN0lybHJvUW8vb0VublRPMGUxSUJuTjdOZm0ySDRBWmdy?=
 =?utf-8?B?SnlWbVdwRzRpQSt2N29ZMTBIQUJxZ0dkNEpJQmwxY21PYXF2R3RLWVdWeits?=
 =?utf-8?B?Z05yMU5zRlpJNVJVTWlGeTNHbUlvaU1hdTU4eEwzUmdqUTJZMnhUVzlKbVRP?=
 =?utf-8?B?RnpGeXFrc3MvYUlDNUdBZ0ZxQ21GN2pTSDY0ZHpjOWpmYkxhTDI2N2ZzbVds?=
 =?utf-8?B?ckdkWHBtRXphaUFFWnpLS3VTQkFaZmVkSE5mbWdrNm9RNS9YRmx6dWhmUWUr?=
 =?utf-8?B?TFplQTRLQXJHOVhrOWZ0M0VyNVFoQVFzcmZuT2k2UGlXcTFWbjNOdmQ3aWdL?=
 =?utf-8?B?RDZUOUdkUGxXSDZxNmc1Y0dWSUlQZThudCsyWnlpVDdXUjRCOUpVeWJMTWk5?=
 =?utf-8?B?djhodVZjRC82TlFDOHFjN2gwUnV6L25YZGtaZUJ3RWk0L3hKTWhxdjJTeFZR?=
 =?utf-8?B?NjBpUE9GdTBHZTdnSDEyQVR5NmppaFg1VDB1UC80bUwvSUNONFR2ZnY4UkhD?=
 =?utf-8?B?VTBxWHN0enowSUhvMmlxeDZ0Z1VQNzVNRGt0Y1RaK1IrdUJtMkFoKzJoY0pI?=
 =?utf-8?B?Vk9HN2Q0Y1pLZk12M012UVBmZzB2KytFa2lqUG05bHUwUTZhUWhmcWZTd1d1?=
 =?utf-8?B?dHhVbi9Kc1d2RWY3QXRWdXA0c244RUtKUzlUbHpnYmxUNWV1cGlIVVhseEJt?=
 =?utf-8?B?SWtPeE1KMFJMZ2Eybng1M2g0ZTZIak9FbXYzMkFSQmdyMzIxYXRkaEJjdkg5?=
 =?utf-8?B?L0oyNi9wZk9QYW01QWhGekNLUTVqS2RBTUF6NFE5RldUMlg5RTBtQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a0f1c7-63fa-45ce-a17e-08df4a00f446
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:00:06.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6bIR//5eSbN6uOQzYD/AZEbQKqxemTwbQ/yoV3KfkRybP5PzqeBdo3JloQvB6vZJUufKasqq7tWPxsj12N7+hOdHFEBahrWwdxvZAjxX/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12518

SGkgQ2hlbi1ZdSBUc2FpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiBTZW50OiAyNCBOb3ZlbWJlciAy
MDI2IDA2OjIwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBwb3dlcjogc2VxdWVuY2luZzog
QWxsb3cgZGVzYz1OVUxMIGluIGVuYWJsZS9kaXNhYmxlIHN0dWIgZnVuY3Rpb25zDQo+IA0KPiBP
biBNb24sIE5vdiAyMywgMjAyNiBhdCA4OjM24oCvUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIENoZW4tWXUgVHNhaSwNCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IENoZW4tWXUgVHNhaSA8
d2Vuc3RAY2hyb21pdW0ub3JnPg0KPiA+ID4gU2VudDogMjMgTm92ZW1iZXIgMjAyNiAxMTozOA0K
PiA+ID4gU3ViamVjdDogW1BBVENIIDEvMl0gcG93ZXI6IHNlcXVlbmNpbmc6IEFsbG93IGRlc2M9
TlVMTCBpbg0KPiA+ID4gZW5hYmxlL2Rpc2FibGUgc3R1YiBmdW5jdGlvbnMNCj4gPiA+DQo+ID4g
PiBUaGUgbm9uLXN0dWIgdmVyc2lvbnMgb2YgcHdyc2VxX3tlbmFibGUsZGlzYWJsZX0oKSBhcmUg
bm8tb3BzIHdoZW4NCj4gPiA+IHRoZSBkZXNjcmlwdG9yIGlzIE5VTEw7IGhvd2V2ZXIgdGhlIHN0
dWIgdmVyc2lvbnMgYWx3YXlzIHJldHVybiAtRU5PU1lTLg0KPiA+ID4NCj4gPiA+IFRoaXMgd291
bGQgcmVxdWlyZSBtb3JlIGNvZGUgdG8gZGVhbCB3aXRoIG9uIHRoZSBjb25zdW1lciBzaWRlIGlm
DQo+ID4gPiB0aGUgcG93ZXIgc2VxdWVuY2VyIGlzIG9ubHkgbmVlZGVkIGZvciBhIHN1YnNldCBv
ZiB0aGUgc3VwcG9ydGVkIGRldmljZXMuDQo+ID4gPiBPbmUgc3VjaCBleGFtcGxlIGlzIHRoZSBy
enQyaF9hZGMgZHJpdmVyLiBPbmx5IG9uZSBvZiBpdHMgdHdvDQo+ID4gPiBzdXBwb3J0ZWQgaGFy
ZHdhcmUgYmxvY2tzIHJlcXVpcmVzIGEgcG93ZXIgc2VxdWVuY2VyLiBUaGUgZHJpdmVyDQo+ID4g
PiBjb3VsZCBiZSBidWlsdCB3aXRob3V0IHBvd2VyIHNlcXVlbmNpbmcgc3VwcG9ydCBhbmQgdGhl
IG90aGVyIHN1cHBvcnRlZCBoYXJkd2FyZSBibG9jayB3b3VsZCBzdGlsbA0KPiB3b3JrIChwcm92
aWRlZCB0aGUgS2NvbmZpZyBkZXBlbmRlbmNpZXMgYXJlIGNoYW5nZWQpLg0KPiA+ID4NCj4gPiA+
IEFsaWduIHRoZSBwd3JzZXFfe2VuYWJsZSxkaXNhYmxlfSgpIHN0dWIgZnVuY3Rpb25zIHNvIHRo
YXQgdGhleSBhbHNvDQo+ID4gPiByZXR1cm4gc3VjY2VzcyBvbiBOVUxMIGRlc2NyaXB0b3JzLCBh
Y3RpbmcgYXMgbm8tb3BzIGxpa2UgdGhlaXIgbm9uLXN0dWIgY291bnRlcnBhcnRzLg0KPiA+DQo+
ID4gQ291bGQgdGhpcyBtYWtlIGRlYnVnZ2luZyBoYXJkZXI/IElmIHNvbWVvbmUgZGlzYWJsZXMg
dGhlIHB3cnNlcQ0KPiA+IEtjb25maWcgb3B0aW9uLCB0aGUgc3R1YiByZXR1cm5zIHN1Y2Nlc3Ms
IHNvIHRoZSBwb3dlciBzZXF1ZW5jZSBpcyBzaWxlbnRseSBza2lwcGVkLg0KPiA+IFRoZSByZXN1
bHRpbmcgZmFpbHVyZSAoZS5nLiBjYXJkIG5vdCBkZXRlY3RlZCkgd291bGQgdGhlbiBsb29rIGxp
a2UgYSBwcm9ibGVtIGVsc2V3aGVyZS4NCj4gPiAgU2hvdWxkIHRoZSBzdHViIHJldHVybiBhbiBl
cnJvciBzdWNoIGFzIC1FTk9TWVMgaW5zdGVhZD8NCj4gDQo+IEkgdGhpbmsgaXQgZGVwZW5kcyBv
biB5b3VyIGNvZGU/IFRoZSAoZGV2bV8pcHdyc2VxX2dldCgpIHN0dWIgc3RpbGwgcmV0dXJucyBF
UlJfUFRSKC1FTk9TWVMpLCBhbmQgaWYNCj4geW91IHBhc3MgdGhhdCB0byBhbnkgb2YgdGhlIG90
aGVyIHN0dWIgZnVuY3Rpb25zLCB0aGV5IGFsc28gcmV0dXJuIC1FTk9TWVMuDQo+IA0KPiBUaGlz
IGNoYW5nZSBzcGVjaWZpY2FsbHkgdGFyZ2V0cyBjb2RlIHRoYXQgZXhwZWN0cyBwd3JzZXFfZW5h
YmxlKE5VTEwpIHRvIHN1Y2NlZWQuDQoNCkNhbiB5b3UgcGxlYXNlIHBvaW50IG1lIHRvIGEgZHJp
dmVyIHdoaWNoIGV4cGVjdHMgc3R1YmJlZCB2ZXJzaW9uIG9mDQpwd3JzZXFfZW5hYmxlKE5VTEwp
IHRvIHN1Y2NlZWQ/DQoNCkNoZWVycywNCkJpanUNCg==
