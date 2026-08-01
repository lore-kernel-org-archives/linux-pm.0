Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4612147E6;
	Sat,  1 Aug 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785589609; cv=fail; b=RL19uU/7ZIyf1l1KsaUEjRjKmRvQ02uSDBk+rBACfvE3sH5fvgXuPl8Csd4I/Z5ax1JNHm+VDQm1OEQPq1fyGbwRx9qhcS1DzN9qVlyyrL4XtHKTeCgRQxckgIyVTQlnCWgqCswoFFnkf8bUIh3wO7GLQ8+i2ZG8KBlT/rKMB8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785589609; c=relaxed/simple;
	bh=uwWQr1ERASgdIz7CvwyKPbSseiiGDCQsy4e5aTMVnps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k7vWPhXarXS57au/srDD4gYzZrKWAr9E9Ab5m3hNeqtSQd3zD5VB/sTdmzws5qtuHGZnwU0LJeyzCmlWZ6IQCz9O/qlYFAt8A8sbAe8JXA8moU5uDtN4eymPa9W5DJ9z42a7N+ciWa5brVC6eqJb8tqiopcRbzqbKJMzbhIqKH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eecbssxD; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eecbssxD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDcOS3jI+FaX7cmIBS8IZ8OgKyJ+ahpXEuhdVaV5paqo7MxyFzbkR8ZGriD7e0NlA6azBCjBmN0RFVBFxOH8uRlDFD7sx3PBR4XGvexy61bIfE0k/Exh3swZPfUMGmIDl+IQ7S0xgM1agvHwfP/GZQWNZc+a5ywUBeDEfy2wQWOR+wHLaxO7d/1Yu7RVGZPGblOBPm3s3PxUIbFgW5AQnKNytLsxmPZfE5rlMilrETTU8xrX0rc46PPY/9b5xvCXaulHWSrl2hnETiKMdEN9wgSIAOkZp1574BOMqpPpr8cDqsO5e4RcFHKPSq0CdxIA4iMSq11wqkOl8DhwR/PS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwWQr1ERASgdIz7CvwyKPbSseiiGDCQsy4e5aTMVnps=;
 b=hgqPtfGB+uXnfsqvOBYKOZ0Hg3IBCqgNvTuM7WSy9mqZdImSB9j71b8g8gy/+Q+E3G/XdnREwdZjNxVT6Hy/T0dSC6zKaT2Mz1i0+Lk+cLnGYWygKTDqG0DYeRkz/eKhUmNlN9AdrNdOAIiSYB/DcNJx6MhcZtKZxicsYPLVSGaHoUS05oxUQsdH0ckKjIdV84Ok4HQ/bzK+weyKyr5jWdeS+y1/zT8KZPi8ZObYVJEZHaxEMzbkqboVaP31IE59fWB0rYJ1Wfib8A1orcD2GPq3Eu1yUj4DInrfA0uPcf8ZyvaldpIml+Z945jbS2Hv9CNjhWD59U23ksaFEC14cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwWQr1ERASgdIz7CvwyKPbSseiiGDCQsy4e5aTMVnps=;
 b=eecbssxD3F8PQ1ZApw8rofy9FbGoylJQBZofLqBdDj8ZRPLR9thj0gnf5XexDGnHk61pMXK3zzDVzcg2n9ZgGhpBCozHpV4tkHd3zXcUt2rOmdxX2nvhSBps9YbpkYukfAFg99rV+7bvvcjbpFt6BBjJA3WMIrV4pPz7vbW8Aio=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB13962.jpnprd01.prod.outlook.com (2603:1096:604:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 13:06:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 13:06:43 +0000
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
 AQHdHDH4W+4o5eb24UWcXtW8HWrP97aComaAgAAFNDCAACosgIAABAbggAAqqoCAAADZcIABfSkAgAAV2TCAATSwAIADa4AQ
Date: Sat, 1 Aug 2026 13:06:43 +0000
Message-ID:
 <TY3PR01MB1134645360B0F4940B71DB80E86D72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
 <20260725123433.162348-3-biju.das.jz@bp.renesas.com>
 <CAMRc=Mf_oNCQK3o5-s4u8zejkVWM4WN_R9YO+NA4od0qqtGjow@mail.gmail.com>
 <TYCPR01MB11332A50145F29D93157A58BC86CB2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <CAMRc=MdU12B-+vQxCuFVuoJLLza_51-bv1o1T9VYEHbkiZF1EA@mail.gmail.com>
 <TY3PR01MB1134633BC06738344A740654786CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MfOk=+dQvdEAY1ah=G1JNM=p7J6=+Tz_uCYDQGBMxXHqA@mail.gmail.com>
 <TY3PR01MB113462C8DE3B70428F113ABF386CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MeybezmErzs9+jYaBgXr+ufsTv5_V5sZjhP6ynuQk+W2Q@mail.gmail.com>
 <TY3PR01MB11346732C04ED0DC52502267B86CA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMRc=MdAsZwqQxJ_G0VXjyFjDzUfT5WSoSW4t0RGtAiyw8FQXQ@mail.gmail.com>
In-Reply-To:
 <CAMRc=MdAsZwqQxJ_G0VXjyFjDzUfT5WSoSW4t0RGtAiyw8FQXQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB13962:EE_
x-ms-office365-filtering-correlation-id: 9451c2a8-1009-4104-3e41-08deefcdbc42
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Yax5dMj34VBjEbfceNWXEJQbrcWTrRdnr8mmXK4NzpAJvSfsqwrLQYHmBswMzWQJUs9sbjow1GbYqVWLL9DiUPQfWvwZ1ESPhv7gFkB3og2IDs8ucvlytgKVcVjE2CCUgkx4hmBB8Hw4Mfmv5ORS6kyfXjBxeN5t/jUmX376Uob0j++SNcgsK2w0ofhr+L/PiYcTIM/y1QBsAwXXkkhXj5cmNmG+ML7n5+ft8QWViN76BMSW5e6UaA0oJN/ApPTFDo8VxeK3jgoTOoC6i+xkWmt9fr+D+0IF2wCrEDIVD2/Z/n5AWWocp66Hojv47R/GIT8dtnzo2QKvsT480eUZcEahB86JZH7gNMIZrGX1OeBAA1etIELg0Bo1T9tnRAmQnLlmM+22g4jDMSlaCnCDPBTk7jOs488T0YpCJE41oBHOv+dGASFOseM8/hfzZjgecgllYK9S1yKHMHjdriB6xf7lNrdSMvB79PL4rjUDd3iqW4sGgcUfqJRzlYTHiLOjnEhGgNzBybnNMuAT6ySpBxJDeY9I2iRSzn5gsAMkS2UlgCgk80BpDf2hO3U5RX3NKlvCvC9QUdbw4PQ6hTb8Gu9BQHR6vAdu5ujpVKds1bTDhoU2yqe8RmCr7qE4HX+WIS9DP6MeP497EEIScggIaE5hhO+lDBcDHUjkeneX/CTK2+3NGCNHZhNTAqN54Cc4jWeXVSrwEUC4t0B6x0xFdMryiv6eq/innshYNQAdnRM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWUzNWZ3UndZcHhETk5KUFhpWU9RWWdnazlwWncvNmZHTFVxd1Fab2JGODFE?=
 =?utf-8?B?T0xRbzhiTjZFNmYrR1Z2SWlqcWhhTHB4VWxWWWFDR3hWNzBzeUhiOGNVRVM0?=
 =?utf-8?B?eTZkWDZUR2U3YWlLaURwdlRoUkdxMHJQNGtqRFhyVzNzSkFTT2F1QW1iYVM3?=
 =?utf-8?B?YWhsRVlyWVo0eHdRSzRkVExSUHZiL0R3VFdvcFBnSytGMFJuT0FkYUJNclZV?=
 =?utf-8?B?SGxhYWw5c05EeWNYUTdtdU1abS8rR1RxTmhSTmJlbVNTUjdKT0liRWZ6Q3Az?=
 =?utf-8?B?UlhGd0RHV1BSS280QkpaRThhSmlULzZRaXp5UEhFSVVEeS9MQTNUY01XUXFu?=
 =?utf-8?B?SU0ydzJLNGpzRE1XK3dIZ0dSNUdvOGRyMkpMMllOUGVNQmpGM1Yya0JuamNz?=
 =?utf-8?B?TjJhMTBOalg3Vmc0d1JINzk1cTY3WlNhdDR1WGIyNGVOb1ZRdHo5WVJhMVRj?=
 =?utf-8?B?K0hvQ0VlK2ozTFIvY0JVNEdERlB1bloxc3E5Y1Y5bVB4YXhKZ3JrbXcxcVhr?=
 =?utf-8?B?d1ZWYi9kajM1cDdnMFF0RkRib0hGM2tKdkJMSkwzbkNMYjQyY1ZtMXBQOUpQ?=
 =?utf-8?B?L3VPMnRLQmFEWnJCTlRtVGVSMkdRQTV5dDJHaHphcU9oTWpiRnJqcVh6elda?=
 =?utf-8?B?YzM1dUhMMUlqTWZ0c2s3TTNkNitOTlhMcDd3WVVrTVNUaUZBVmhTeE5TZGtK?=
 =?utf-8?B?WlB1WGlCV2QzVGRZd3puQm9jYzRYVFFGYytSMEtHenc5K1RwTHVMdXNVMDNG?=
 =?utf-8?B?UWxtZS9mN0RjL1dHUjlrZm44cHFrbThPMjJFMDZxbDlnekprM0RtMmFVNXhP?=
 =?utf-8?B?QmZ3MktpM3Eyb2lZdjZtQXo0cVYyYjJ6bWgzRVRrR0VyQ1d4YWJ6SGhvMTh5?=
 =?utf-8?B?bU1IcW5YcDZkeXNiUUxPd3FSYmlZeGhRSE4yMTZFOHRpZnFzcnNacXB1TUdK?=
 =?utf-8?B?ZHdYSzZ5T1I5WVNzSEVYSG5ScG41bFlMRGlrRmhnQUhneVNXc2NTQTdiVFg2?=
 =?utf-8?B?UUxUazlFZ3BPVGZoTnRwTzZZZUVqUkFleVhxcTBTRXppQ0Q1UklZcW5jcDhU?=
 =?utf-8?B?ckc4cU0yQThKWUF4K3dZcUdkZjhGOWoybnJmWlRucndNVHpkTEZnZkVBZndq?=
 =?utf-8?B?aEJBd2w4dlFFSG1oTHNIdXBPT0ZSR2tKUHphV0lScGVMUHVKSkk2OHlpdmFp?=
 =?utf-8?B?VDJFb0dkK2x3NUk4WG1Oa2JNcmxocHNzeWVJTVlrNEYxdUlyRDh4QnR1UDNB?=
 =?utf-8?B?T0tLTWlQbnFEdDdLaVVaMzZVSXVmQktHeDBPQjkwUk8wM0xiUGpLZFBSUjJx?=
 =?utf-8?B?SHZhSW9oN09XVVA1cDhPRGlaZWUzdU9KTHk4NUl4R1NWNEJmODA0d1BNcklC?=
 =?utf-8?B?TG41Qkw3cDQzRmZaaXVPZXFDQVZaUHZpdEgvV051eTRnU1I4Nit3Z0tQVFll?=
 =?utf-8?B?SkNjR3g1aWlsODUzVzdSeHRpQnNJaVA2WDRGc1NlODh3YnI0TmhwNms3bjVv?=
 =?utf-8?B?YzdBQ2RGRXNSLzBOZk1aRzRJWnRsTUhLb3VaNWkwdEkxOEhjZldsS1FlekQ1?=
 =?utf-8?B?cldsUHlPRmtOYVdSZ09ZY0lPeW0xcm5HSEs5Qy92N2ZqbnpISSsrWHErcTY4?=
 =?utf-8?B?VFFMNGlNTVhJUlh6VUk3NXlJa0IxOC84VFd1VEgzbnptQlNjTDhlYlM3bXgw?=
 =?utf-8?B?R283K2pTL2lkdmtoR2lSVnZ1YURVSk5RdDRLU0JjU2FFdnNPZUxpT1VqRVZn?=
 =?utf-8?B?YmFpN2xhMmJOQmRMa3FRemZGVG1iR2VRdXhJM1JVRmJ1MWEwcitNeUJEaWRH?=
 =?utf-8?B?OTg0YXd4U0d1a0RKNk1qaXZaQXFVVktHaWQ5VGsvbzRyOVE4YWNqT1lnY3NG?=
 =?utf-8?B?czJWRjFERVg4UHhBaE1uanNaQWtsZW9mbXFNa3h1RkVLbFZNZXp2bUsvOTBG?=
 =?utf-8?B?Y0cycWRtR3JxTURpSVN0L2oxMlEzTXltQ2NKaHYyOEQyd29qUEpqMlpKbWZS?=
 =?utf-8?B?bmJURmFNNUlIcnJVRzNTU0N2dm5NeXllTUtkZnFDUHNmUmtIMUx2TkVQUTA4?=
 =?utf-8?B?Umg0UGRndC9vNUtFOU5BbGJrcFBvV1lYeUhtcEppWnBPMmpiZ0tYc2pNZzFm?=
 =?utf-8?B?bDBTREUraHNyM1YwVjdzMnhRUHFEV2IvWGcwQno3N3B1MUZqVFNoV2RTWjZS?=
 =?utf-8?B?MjVOQURWWm9va29RL3ZLa3dKdERmVG1EV2NncE1GR1lzZFBXZFVoRDhIQzgv?=
 =?utf-8?B?b3BrK3ZWVERZV0laVXErZmU4SDVWb052VFA3cDlvM051M1dlS1IyRldTQWw2?=
 =?utf-8?B?ejNpbWcrUkxOME9RcFJZL2lXYzJnQ0lNVnovRnhFWDNxVlFCS1Rrdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9451c2a8-1009-4104-3e41-08deefcdbc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2026 13:06:43.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfPjA5HAQ9KTiQyOD4qRuJ0yGCWrNbSEx48Xs+q7SqQJ4Tqj8aynwbg1lkMN7/64mymMgcTTOKOhAibgDFtUXdiJXlc1qKP/bdLa7Do/cm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13962

SGkgQmFydG9zeiBHb2xhc3pld3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDMw
IEp1bHkgMjAyNiAwOTo1Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gcG93ZXI6IHNlcXVl
bmNpbmc6IEFkZCBSZW5lc2FzIFJaL0czTCBQb3dlciBSZWFkeSBkcml2ZXINCj4gDQo+IE9uIFdl
ZCwgMjkgSnVsIDIwMjYgMTY6MzM6MzEgKzAyMDAsIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5y
ZW5lc2FzLmNvbT4gc2FpZDoNCj4gPg0KPiA+IEhlcmUgaXQgaXMuIFBsZWFzZSBmaW5kIHRoZSBy
ZWxldmFudCBEVCBub2RlcyB1c2JwaHktY3RybCBbMV0gYW5kIGRzaQ0KPiA+IFsyXQ0KPiA+DQo+
ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzI5MTE1MDIyLjIy
MjM0MC05LWJpanUuZGFzLmp6QGJwLnJlbg0KPiA+IGVzYXMuY29tLyBbMl0NCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA3MjkxMjU1MTYuMjMwNzU3LTE0LWJpanUuZGFzLmp6
QGJwLnJlDQo+ID4gbmVzYXMuY29tLw0KPiA+DQo+IA0KPiBTbyB0aGUgc3lzYyBpcyB0aGUgcGFy
ZW50IG9mIHRoZSBwb3dlciBzZXF1ZW5jZXIgYnV0IHRoZXJlJ3Mgbm8gcmVsYXRpb24gYmV0d2Vl
biBpdCBhbmQgdGhlIGNvbnN1bWVycw0KPiBtb2RlbGVkIGluIERUPw0KPiANCj4gSW4gdGhhdCBj
YXNlIHNvbWUgdmFsaWRhdGlvbiBpcyBzdGlsbCByZXF1aXJlZDogeW91IHNob3VsZCBtYWtlIHN1
cmUgdGhlIGNvbnN1bWVyIGRldmljZSBpcyBjb21wYXRpYmxlDQo+IHdpdGggYSBsaXN0IG9mIGRl
dmljZXMgd2UgY2FuIHNlcnZpY2UuIHN5c2MgYW5kIGNvbnN1bWVycyBhbHNvIHNlZW0gdG8gc2hh
cmUgdGhlIHBhcmVudCBub2RlIHNvIHRoYXQncw0KPiB3b3J0aCBjaGVja2luZyB0b28uDQo+IA0K
PiBXZSBzaG91bGRuJ3QganVzdCByZXR1cm4gTUFUQ0hfT0sgZm9yIGFueW9uZSB0aGF0IGNvbWVz
IGtub2NraW5nLg0KDQpPSywgd2lsbCBhZGQgYmVsb3cgbWF0Y2hpbmcgaW4gVjM6DQoNCitzdGF0
aWMgaW50IHB3cnNlcV9yemczbF9wd3JyZHlfbWF0Y2goc3RydWN0IHB3cnNlcV9kZXZpY2UgKnB3
cnNlcSwNCisJCQkJICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwlzdGF0aWMgY29uc3Qg
c3RydWN0IG9mX2RldmljZV9pZCBwd3JzZXFfcnpnM2xfY29uc3VtZXJfbWF0Y2hbXSA9IHsNCisJ
CXsgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEwOGcwNDYtbWlwaS1kc2kiIH0sDQorCQl7IC5j
b21wYXRpYmxlID0gInJlbmVzYXMscjlhMDhnMDQ2LXVzYnBoeS1jdHJsIiB9LA0KKwkJeyAvKiBz
ZW50aW5lbCAqLyB9DQorCX07DQorCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0K
Kw0KKwltYXRjaCA9IG9mX21hdGNoX2RldmljZShwd3JzZXFfcnpnM2xfY29uc3VtZXJfbWF0Y2gs
IGRldik7DQorCWlmICghbWF0Y2gpDQorCQlyZXR1cm4gUFdSU0VRX05PX01BVENIOw0KKw0KKwly
ZXR1cm4gUFdSU0VRX01BVENIX09LOw0KK30NCg0KQ2hlZXJzLA0KQmlqdQ0K
