Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011035.outbound.protection.outlook.com [52.101.125.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04030374195;
	Fri,  7 Aug 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115776; cv=fail; b=NOo/fmLf74EYv6iPwzZ68bhs49u03c0p50N/G0VUrIOIFTj2GpMp1ooHfXSP3EZ7gYFNFhXEhSEgdlYsMQPih2BOWgaSvfzWZ3pKyS/F/x99s4x4kqIRN2Y4JfxBfgCWAh0Db3KtYqTDdPCj0fylcKJ4BMz50xX86LxYnjTD7SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115776; c=relaxed/simple;
	bh=B/LaQiZzCJFukfKXNzQEguUZ9To3XZJ9hdGdomFwbNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bWjLh6SjwI2tM7tBcUTw8uFmFJBGN1RIQpaXuUIsYbqV9G6qt8wCMfcUpLqcX7JBCY0SPFFOE4xWeO/FGKT1GZvicW+VuZ6K6LkKLhEQpdknOsPNiVxhm9+kDuLVSItZ/9d9tZ5BJDM+f1jdZuDspQB5+0meeTkJg4NSNFrz+AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qPkNr2Tp; arc=fail smtp.client-ip=52.101.125.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qPkNr2Tp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TE0W0D40IF5vuUAtTZSSMPLxHjlT8Q9AkInIcqFsC92b0zCYYaPIHX+zYaO/MNYEuxIZVEqhGEnPVNWcAixUd5EYYmwI2BVMt3LJk58beKT1mT82yhFG+2ANr2VRRZoniZt5YEttqW2SPyBJnaA15Wc3S0kr+Gt4HOiXgT350ayE+CJQQBCcop9ZyyTCg4ykzR/aH2oUhvWWG2kQA2HIupfX0oToVRB7V5AOXV7oblln/PuWdnh0dbavsBd3lA9JwE3hIb7wmVHH7UqWbqf83kYJiNnSu4UUWqdRFCv9aidxL8XY4+DBgP6IXNvQQaZJqk+s3Ema2fsNxNyTI4T5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/LaQiZzCJFukfKXNzQEguUZ9To3XZJ9hdGdomFwbNk=;
 b=Fp4ZFOYnzW/R4khn/vHNNt2isej95MnzPI6OBSTO/gMd09i5ljyFFsaa8yhHt5xsfukfxmn4STXqVw9Ky12UqeBZmrb3qddVtif7tcHAxKLQk9zgD+UbuCHmEJAGwSfsiiSP8z7RjBzEQJRQyBZddT+cHAWrmccrSQUrCKr3H9GaeBrbcVXhLh/CNS7G7yjcDQHTCOQBt8KJb/k7Si55Lx+81R41TcvGnfQCfaq3owAqq1Lf1OgTx2YTKmxdB4V7ChFwAkS+9vo85QFCkrRHxAzelo3p1nA3PjSTbHoJDhX42vkbZnfkFugC2UhGAE2IB4zZHxXyak4xWHwZqoZTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/LaQiZzCJFukfKXNzQEguUZ9To3XZJ9hdGdomFwbNk=;
 b=qPkNr2Tp9+TJkABbE6noW/kJ5aWxmDrqzrYy4ukbnkeQRqs+kAzO0Lv4Aa1AM5uklscaKGvLdMFKo0JA5Wm4mb/KN6pHKyaUbV4cHbnjzHk4KQ0a7J5Hn4tyNR5CMX1fydaACXDndyBmt4qJ1yP/IPeNUD5YBDGqzhgtrtW5Q6s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB15061.jpnprd01.prod.outlook.com (2603:1096:405:227::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 15:16:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 15:16:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park
	<kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] PM / devfreq: Convert to seq_buf
Thread-Topic: [PATCH] PM / devfreq: Convert to seq_buf
Thread-Index: AQHdJlP+dKr7m3MvwEm5hlwffGj15baSgUMAgAAu1fA=
Date: Fri, 7 Aug 2026 15:16:08 +0000
Message-ID:
 <TY3PR01MB11346F56AC074292B976E47FE86D12@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260807100320.121108-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVGfR58UodRRjr1=vzsxLBiNsNkiwu8A7FNi-dXVSMH+Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVGfR58UodRRjr1=vzsxLBiNsNkiwu8A7FNi-dXVSMH+Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB15061:EE_
x-ms-office365-filtering-correlation-id: 7073b220-9455-4544-5223-08def496ce8a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|5023799004|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 lV3iPiVVF/BSbJuinutfDBR0bOFRuP8kjrtOSVK/N3na2tF8KmxVG3jDGV08gLnBmY7L7+UDklmERby6qq6vnEOOiYstQ8woP+3AVGEJEgKo9p2dRLmv1kDiQuEXSYbBKYl7ynE/VqF3GfE0pbBHVa+4eHhqFNlLed22wKOX3kZ9M4SWBNg+fD1TslOJBXh57U4lPerfvqkrM5tsqmh0fbuDdhlTH8FMpn0EcbD2CAWbfyzaZhp8Z8/gEgO1GiYwHcq7kuhqPd/LoUWwbdWc++9qn/CJORNr+wH8jaPFKTcT+H4zUkFE/ljIafLB4Qd1Xn8Ttg9HjNSXI3aXykmeGjDioTRYvvEdnxiTDTtrxritrnL6tNRE1ZNChnKhk5RAA1z8PYMGDn/ZdAf+O1s6cYsnH5xhktKG5Bruk5/eV4gephK0DcurckJlrH0Fj7BJrp0BtgoQ4p2aMXnAaBvs3Vl3Be6GuWmnzTQYTt9r+Pru2X8KuR23dtEoruLlAXMZkL/P207ciNwNleorIuY8xrCgKz3asgmwP0m9xukD0EzDRUK0Cq0YIe8U9W/JvQc8VqH+HjX31Sm1HzHx1AxLXZNhz03MTjvjdhEO3KOFV6l0QPd8ZAn1+d3mvHsbH05po1aExPiRck8sJcMXgg/yYE3JakC98TovyjZS/vp9XyUp9pS3teq4Ws3dBc/lhSy4iezNZWGfbTV6b4DgONM99QJfEw+6TyMS7QfQ0ohQk5k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmwvamRMaFhKNmE5ckFiTS80SGp4RW1XeGJEUjNHL1hHdDZGMWxHbmFCRTh1?=
 =?utf-8?B?RUFpdjAwNmxBczlkeUI3cEtBWmRoYXpmYlNyajEzWWhYSmJLVXVMRGZOemcy?=
 =?utf-8?B?MmxDSVN6UVdKMlBZZUdqWStMWlV6Z3BPR2xoSTZKbm55Z0JWM1JxOEtXek1I?=
 =?utf-8?B?SjdnMm9paW5pWERmUFVaMG1YODBBWkpON3dBT3NiUytsN2xOaFBNSFA0aGxw?=
 =?utf-8?B?RTU0TWFrV2hweHNaem1DVHRMMTlOUnlaMThQL2t4OXU1NmNYUkNsSmxlV0cr?=
 =?utf-8?B?MWxRaUk3SjB3NDI2cld0eXV3TXNjNmIxd2Z3RW5qQ2RleFpIWkVOelRXRFVs?=
 =?utf-8?B?QVllWXVVZVBuU0lGUDRxam1UdG1kbEtFb1o3S3FTUEY5eTRKSjMxb0w0WDA5?=
 =?utf-8?B?UFFieFNzeGcrN3Z6eVpkSS9GZklJSnVneENDZkR6TjJoSnJVdHRrZy9LbjVi?=
 =?utf-8?B?NHVUa2xvRStRSGRZT28vQ1FUZUVaYkZMMVBlTXlzbTV4dXdFMU9SUHQvVkFN?=
 =?utf-8?B?cWxQWUQzVE92Y0lSbzE5MmdMYXZBQ1Nyd3A3YnEzUzZFczJzOElaa3p2L093?=
 =?utf-8?B?TkNFSHJscm1tZ0xwV25abEVqNzljRkxUNVJHaERERU1ESXpvTnM3OE5rY1pu?=
 =?utf-8?B?UkVZWU4zUllwc3cwa2JhTTlESzZHV0JBOU12dHJvTnFxTk5Db016cm16cWZZ?=
 =?utf-8?B?STVtWEpVTWwzdFdyRFFDb0x0bVZaWDBjcG5JdW9lN25EOUhZQ0J0NzdkNThK?=
 =?utf-8?B?eW9yS3BMeGlzZnFkY1p1ZFBOWjFBenpTaTJVYUNNNlRoNHlqV1lDK1EzQmpq?=
 =?utf-8?B?Z0JKai9MNnNMT2x0aDMyYzZQZENMZGx6UmFuU09VVTlXeHdMYml2RzUraFgz?=
 =?utf-8?B?T2hPWFZjc2pBODJkN2R0aEE3L1krWWgyTWlWVklTNkhOd2hYVGgvU2d2T3Nk?=
 =?utf-8?B?R1R0VWRMZzJPd01QN0p1WVR6ZW5zZzE4TXRJV2VEUmhCa1ZuY01mK3c3S2Jj?=
 =?utf-8?B?MGxOVmorWlE0VFB5K2pneE5NeHVYZjNDT1dFMHVMK3FFVnFqVy8zVWx3MDNw?=
 =?utf-8?B?Y0MwdUxnZGxlTlhpN3hsU2dmNDhudHBBODRRdjM1eXI2dGtKZW9OQjNsNWpU?=
 =?utf-8?B?NWNSZ253eU83WE10QU1YUXVaQzh5aTIyWnRiallDcmxPSjREQkJVRG5MQkdz?=
 =?utf-8?B?cnBpTk44NFcyZlVPZWViSE1vbEo0bXN3R1hPUHBKK3hiT2pKdlFKWFNPY2lB?=
 =?utf-8?B?SW5aNkdVUk5XbDlZSlRjckNNSzhuRnpDNjZvNnUzZlJlQ2VrUlBOaHNmTXNR?=
 =?utf-8?B?eDYybVp6Mnh1TDRZMS9kdGlpRE5hbWR1Uis4QlREdWJHRktvNFpLaWd1dkZD?=
 =?utf-8?B?L1VOY3p1OTZiNmNHeHdVd2dyZGRMUHU3NkJlalFIOXRmY3lkYU5CYnQyQUpy?=
 =?utf-8?B?Z2JWUzR2TGxhM0g0aXhIVHBKSVdqdkl1VUFTbFRaMER6OEVoOWYvMXJST3lX?=
 =?utf-8?B?K243ZithWFFGcTNBalVjS090RGh3OTVVb2EwYkl6RmJkdUZkRzFNcmpjbDFG?=
 =?utf-8?B?QmZSU0pPaUFzejJWc0cvbVZaZ1M1RUZVQ3JXQ0ZSWDRGWE9RbnExUVFra1Fn?=
 =?utf-8?B?Y2QzTVMwRnFtTklXZm9FbVhUVk5DZUEwL2g1TUtDUVRPNUN6bFRNa3RWc2Ru?=
 =?utf-8?B?dXN1S0xhTWFWK1BlcWhrYktwZE9sZ1g1YzJOSlB3aUJ1bXFzTElUK2ZUYm9D?=
 =?utf-8?B?RzNWUXVrQWxBdk8yWlFWdzR2dDJFalNYcXc4UEZiRkpSQzIrYjFwYU82alNx?=
 =?utf-8?B?RXZRNlNRMEVoWlNESFgvNkgyUERjL0d2K0V0TVVxWitYWHM1Z3ZmTGVqditk?=
 =?utf-8?B?Y3ZTWisvZjNaL003T25DR3AybUcyWXR1aXJmSEJFUDY2cUgyRCtWTjN5L0FG?=
 =?utf-8?B?Ky9UamVBRENrZDEyVklnQzVQYnlGcmEvUVNQdXlhZXdvYlZ4MlFlVmorNVk0?=
 =?utf-8?B?U0J1aGt5WWprM3pmWFF0R0I3bHNQS1pBK3dVdEluRjZVNWJLTW1mZGF0Tmpm?=
 =?utf-8?B?dTNaK3YwcFRmVDI5VGlSRGxTcUYwck5DOUs2NnJWMDJad2ZTR2t6R3ZnQkg3?=
 =?utf-8?B?OGxDWlNlNmwyZnVlTlZTaTNNOXY4VUhwb3o4VVVzTG9TM1FabFRzQmJVNTNK?=
 =?utf-8?B?aWlCM1ZtcHo4VjRKMmY3eEFtN3hIVUpDMFMwVU5nNkVqSkpNcmIwSTJGR3Jh?=
 =?utf-8?B?Ty95RFB2NUFSZS9ZbGNnOVRUbU5nbjE1TmNjZ3V3M0dGVHVDd3BuMHhyNFJx?=
 =?utf-8?B?SXJNZmZlMlFpaW9PUHVkQStXTGlxU0pPQlYwWnVsd2ROaXFMV3dUQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7073b220-9455-4544-5223-08def496ce8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 15:16:08.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSKO1PxJykCghqRv9GZ1a2I9SmTQiukN8CBy0sqcheDz2HnQXTWymqoNLxD+FBD6zoyJpCIZOy0WiXsPaHt+yeIByZCmJkXIfjicx5npjck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15061

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDA3IEF1Z3VzdCAyMDI2IDEzOjE5DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIFBNIC8gZGV2ZnJlcTogQ29udmVydCB0byBzZXFfYnVmDQo+IA0KPiBIaSBCaWp1LA0KPiAN
Cj4gT24gRnJpLCA3IEF1ZyAyMDI2IGF0IDEyOjAzLCBCaWp1IDxiaWp1LmRhcy5hdUBnbWFpbC5j
b20+IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNv
bT4NCj4gPg0KPiA+IFRoZSBkZXZmcmVxIHRyYW5zaXRpb24gdGFibGUgc3lzZnMgYXR0cmlidXRl
ICh0cmFuc19zdGF0X3Nob3coKSkNCj4gPiBidWlsZHMgaXRzIG91dHB1dCB1c2luZyBtYW51YWwg
c3lzZnNfZW1pdF9hdCgpIGNhbGxzIHdpdGggaGFuZC1yb2xsZWQNCj4gPiBsZW5ndGggdHJhY2tp
bmcgYW5kIFBBR0VfU0laRSBib3VuZHMgY2hlY2tzIHNjYXR0ZXJlZCB0aHJvdWdob3V0IHRoZSBs
b29wcy4NCj4gPg0KPiA+IE9uIFNvQ3Mgd2l0aCBsYXJnZSBmcmVxdWVuY3kgdGFibGVzLCBzdWNo
IGFzIFJlbmVzYXMgUlovRzNMLCB0aGUNCj4gPiByZXN1bHRpbmcgdGFibGUgY2FuIGV4Y2VlZCBQ
QUdFX1NJWkUuIEluIHRoYXQgY2FzZSB0aGUgZnVuY3Rpb24gYmFpbHMNCj4gPiBvdXQgZW50aXJl
bHkgYW5kIHJldHVybnMgLUVGQklHLCBsb2dnaW5nOg0KPiA+DQo+ID4gICBkZXZmcmVxIHRyYW5z
aXRpb24gdGFibGUgZXhjZWVkcyBQQUdFX1NJWkUuIERpc2FibGluZw0KPiA+DQo+ID4gd2hpY2gg
bWFrZXMgdGhlIGF0dHJpYnV0ZSBjb21wbGV0ZWx5IHVudXNhYmxlIG9uIGFmZmVjdGVkIHBsYXRm
b3Jtcy4NCj4gPg0KPiA+IENvbnZlcnQgdHJhbnNfc3RhdF9zaG93KCkgdG8gdXNlIHN0cnVjdCBz
ZXFfYnVmIGluc3RlYWQuDQo+ID4gc2VxX2J1Zl9wcmludGYoKSB0cmFja3MgdGhlIGJ1ZmZlciBw
b3NpdGlvbiBhbmQgaGFuZGxlcyBvdmVyZmxvdw0KPiA+IGludGVybmFsbHksIHJlbW92aW5nIHRo
ZSBuZWVkIGZvciBtYW51YWwgbGVuZ3RoIGNoZWNrcyBiZWZvcmUgZXZlcnkNCj4gPiB3cml0ZS4g
SWYgdGhlIHRhYmxlIHN0aWxsIG92ZXJmbG93cyBQQUdFX1NJWkUsIHRydW5jYXRlIHRoZSBvdXRw
dXQgdG8NCj4gPiBQQUdFX1NJWkUgLSAxLCBOVUwtdGVybWluYXRlIGl0LCBhbmQgbG9nIGEgcmF0
ZS1saW1pdGVkIHdhcm5pbmcgcmF0aGVyDQo+ID4gdGhhbiBmYWlsaW5nIHRoZSByZWFkIG91dHJp
Z2h0LCBzbyB0aGUgYXR0cmlidXRlIHN0aWxsIHJldHVybnMgYQ0KPiA+IHVzYWJsZSAoaWYgdHJ1
bmNhdGVkKSB0YWJsZSBpbnN0ZWFkIG9mIG5vdGhpbmcuDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6
IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJl
cS5jDQo+ID4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiANCj4gPiBAQCAtMTY2
MSw5ICsxNjYyLDEwIEBAIHN0YXRpYyBzc2l6ZV90IHRyYW5zX3N0YXRfc2hvdyhzdHJ1Y3QgZGV2
aWNlDQo+ID4gKmRldiwNCj4gDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogSWYgYW4g
b3ZlcmZsb3cgb2NjdXJzLCBzZXFfYnVmX3VzZWQoKSBjYW4gcmV0dXJuIGEgdmFsdWUgZ3JlYXRl
cg0KPiA+ICsgICAgICAgICogdGhhbiBQQUdFX1NJWkUuIENsYW1wIHRoZSByZXR1cm4gbGVuZ3Ro
IHRvIFBBR0VfU0laRSAtIDEgYW5kDQo+ID4gKyAgICAgICAgKiBlbnN1cmUgYSBudWxsLXRlcm1p
bmF0b3IgaXMgd3JpdHRlbiB0byBwcmV2ZW50IHRoZSBzeXNmcw0KPiA+ICsgICAgICAgICogImJh
ZCBjb3VudCIgb3Igb3V0LW9mLWJvdW5kcyB3YXJuaW5nLg0KPiA+ICsgICAgICAgICovDQo+ID4g
KyAgICAgICBpZiAoc2VxX2J1Zl9oYXNfb3ZlcmZsb3dlZCgmcykpIHsNCj4gPiArICAgICAgICAg
ICAgICAgcHJfd2Fybl9yYXRlbGltaXRlZCgiZGV2ZnJlcSB0cmFuc2l0aW9uIHRhYmxlIHRydW5j
YXRlZCBkdWUgdG8gUEFHRV9TSVpFIGxpbWl0XG4iKTsNCj4gPiArICAgICAgICAgICAgICAgbGVu
ID0gUEFHRV9TSVpFIC0gMTsNCj4gPiArICAgICAgICAgICAgICAgYnVmW2xlbl0gPSAnXDAnOw0K
PiANCj4gU28gc2hvdWxkbid0IHlvdSB1c2Ugc2VxX2ZpbGUgaW5zdGVhZCBvZiBzZXFfYnVmLCB0
byBsaWZ0IHRoaXMgbGltaXRhdGlvbj8NCj4gZGV2ZnJlcV9zdW1tYXJ5X3Nob3coKSBhbHJlYWR5
IHVzZXMgdGhhdC4NCg0KSSBoYXZlIGV4cGxvcmVkIHRoaXMgb3B0aW9uIGFuZCBnb3QgdGhpcyBy
ZXNwb25zZSBmcm9tIEFJLg0KDQpIZXJlIGl0IGlzIHN5c2ZzLCBub3QgZGVidWdmcy4gDQoNClRo
ZSBsaW1pdGF0aW9uIGNvbWVzIGZyb20gc3lzZnMncyBvbmUtcGFnZSBidWZmZXIgY29udHJhY3QN
Cm5vdCBmcm9tIHRoZSBjaG9pY2Ugb2Ygc2VxX2J1Zi9zZXFfZmlsZS4gVG8gYWN0dWFsbHkgbGlm
dCB0aGUgbGltaXRhdGlvbiwNCnRoaXMgYXR0cmlidXRlIHdvdWxkIG5lZWQgdG8gbW92ZSBvZmYg
c3lzZnMgZGV2aWNlX2F0dHJpYnV0ZQ0KZW50aXJlbHkuDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQg
dHJhbnNfc3RhdF9zaG93KCkgaXMgYSBzeXNmcyBkZXZpY2VfYXR0cmlidXRlIHNob3coKSBjYWxs
YmFjaywNCm5vdCBhIGRlYnVnZnMgZmlsZSBvcGVuZWQgdGhyb3VnaCBzaW5nbGVfb3BlbigpL3Nl
cV9yZWFkKCkuIFN5c2ZzIGF0dHJpYnV0ZSByZWFkcw0KYXJlIGZ1bmRhbWVudGFsbHkgY2FwcGVk
IGF0IFBBR0VfU0laRSDigJQgdGhlIGJ1ZiBwYXNzZWQgaW4gaXMgYSBzaW5nbGUsIGZpeGVkLXNp
emUNCnBhZ2UsIGFuZCB0aGVyZSdzIG5vIC5yZWFkKCkvLm9wZW4oKSBWRlMgbWFjaGluZXJ5IGRy
aXZpbmcgcmVwZWF0ZWQgLnNob3coKSBjYWxscw0Kd2l0aCBidWZmZXIgZ3Jvd3RoLiBTbyBldmVu
IHN3aXRjaGluZyB0byBzdHJ1Y3Qgc2VxX2ZpbGUsIHdlJ2QgaGF2ZSB0byBoYW5kLWluaXRpYWxp
emUNCml0IG92ZXIgdGhhdCBzYW1lIGZpeGVkIFBBR0VfU0laRSBidWZmZXIuDQoNCkkgYW0gYWdy
ZWVpbmcgdG8gQUkgcmVzcG9uc2UuIFBsZWFzZSBjb3JyZWN0IG1lLCBpZiBpdCBpcyBub3QgdGhl
IGNhc2UuDQoNCkNoZWVycywNCkJpanUNCg0KDQo=
