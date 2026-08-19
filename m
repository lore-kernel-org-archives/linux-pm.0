Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011060.outbound.protection.outlook.com [52.101.125.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9D417BD9;
	Wed, 19 Aug 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127494; cv=fail; b=G1j4b0vab05xDBr+zKN+TLDvBXVyV9Fe/4I5vsNI9tIYWN1svuvhsY8LPHzIidyVJiHUFGSaBQG1r4+h0BFTy8eUsUXTIfx580XGABNMWB5lBeawdXEi7a/qO4QW74GT7Xna/KOt7UZNJYtg6TgmJMSbAjIi1QUdW+fgWwGQKGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127494; c=relaxed/simple;
	bh=IIsqprW8zac6h3BUrnFGM33sRx7JbVrlxOuhEb28Nyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPGr4bZ4G+LUd1LnFVoHDowgSMAtpbtjWBkJCrxi07dDjv05vm/qRzDnIehyvBJX2g/SB6E7SPMqXpxp5+ikEeXqCWBJ0fTUEEsmjLKFU91SOAxzM5ljP5SYaU5NrauKl0JtFv6629LDMnCXPUDZ89BGKnG3ydx4yAUnAcurMWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Tm7Ue/9D; arc=fail smtp.client-ip=52.101.125.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Tm7Ue/9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGcyXzwxwvGBftOKmgTbdQcMPESYE8nDAMaqq1EVJOsjo3SoZxNT3YllfpvFgQP07bVMMv35z8NLlhqLMn7SJvT2fz/Ytzxxdr/NKrRJu+DOEDs8sHcCfBtif3xjTH2DrLn9WzO4b8OpEliKJbH/a7drallCc3tR+AuoGqLuwZ2H9FrurkWarewmPV3Rije7oGU1ZKTMYnZkFyT86YTFsXPUEBsodXGvkvrVzjL1OSAfyoiWNWNVBbuAzvB8Uj+DePhy6j3tjcGnBUeFlTMfi2TXo6aKDUemN02EXxI/TMcETGd3Xg6CyBrx/7LhDfzNmTw7uuzERGj7kNYtWt/KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIsqprW8zac6h3BUrnFGM33sRx7JbVrlxOuhEb28Nyg=;
 b=cdS45nAPt4Z75bMRNL9PuecRPR+4cCj1GNpRPKGWok7TndSc4kzV1rXQDNLX6rQkT1YoPThdp/wfU6TAgW/sMuEC7g+0VgvsM63iJzhAjjkUaRPLJUKXSM1Ey1KNrcSfIY27LgzRWwGLZhpYiYEh8Qmj9TEKpxGDdXPLrp2gwxX8rVsXiRyRlZR+3goeHh4s4pCMBYo41ZwXIlsYaln0j9oe5dluNJUr9nii1n1SqvyIhCQkZM+BufMT5dbKswh8oCDC3K30WLAyIFU+7UgQavTR+UYMyx289T8s/8jHpqPS6gMAYLDC/QLBTO6fpaWjlYzD46x75gNpoKuoWOngNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIsqprW8zac6h3BUrnFGM33sRx7JbVrlxOuhEb28Nyg=;
 b=Tm7Ue/9D2zlO+G9XOOBNl5KA5T8UZDu46m3wPquerMQUwyZzYJB20X478RYZwrjZQ1bQf/22Niszp7ofMhMXB5/TDuVRKjSSL4rIIJCfngfCIyKqGkh986I8sFXYYbTt14Wrqt6ML4qmUOiykXY4uz4T66lnfruH3DXJASFPGMc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB18359.jpnprd01.prod.outlook.com (2603:1096:405:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:17:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:17:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, "biju.das.au" <biju.das.au@gmail.com>
CC: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, "magnus.damm" <magnus.damm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Topic: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Index: AQHdKlDBTVfG4E7tk0C0Oq35AhSxEbadmQUAgAd2NzA=
Date: Wed, 19 Aug 2026 08:17:59 +0000
Message-ID:
 <TY3PR01MB113464399E7C6C5D6B72A423B86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260812115010.108322-1-biju.das.jz@bp.renesas.com>
 <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB18359:EE_
x-ms-office365-filtering-correlation-id: d4b165e9-8768-4d85-8a91-08defdca61b5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 2NNKZbGEf/hH9eqH/qOh3PYi5ZXg3oydmayks09z5KQZGH/IGZ/Mfr0dTe9nQzuFf2cz3BTwWekCjZLL09vcTken8ZfaE2nW62zc9lWRkJYeNbgZCAQI+jHtnOCEsFhaULNbfdzjnYCDPqG6iPDcnk5BEgha6QwWmucDXS18S95IVyTEWIciXpBAgF8w7z6NZLaNeCKIuQWZmN/gtmv9Zh8Y+t0zWgNwsy3lKVmo17pmBpbSypIpfPdr055UMT1s+CMkT5vb3fzbAH6XwRkP5JK0HLJbZffeAVDUv5oWg6YY4NR7TkaQfonauP6P0Xs81N6Bx+w6fTeDR33RkgT9Wp93Bo/DVj0YP0HFspLh1NyyQsEM5NxvkGJ94v7YkaUgiZMNj3kEJlVqVwkRca0ggF2D7q4df6ASdQDeKrAOXspkOVy1ncOUu+Iw7iNxIt3/gi0VOyf60h67MiVPdC863xcr4+Echu6GTRjycQ3gcrkSskX3qNHLR3koygwmCrJkTWFLxvQvtaQCpD/k+9auqIzsHoo61MZl4yJg4IQ4HCsmrYicMkX/UZIfv0S4oQ/HFTGCqldbRvkpRe3Wx8P7kqGZGcm1O1NRAxRMlBXyMXcm2XMbjdo1P9obe9IOm2WB+yC/HC42wxvFh0osM08Fv7Sl9LINqwDPVHedPgOg7xMZgH2QvbtZ1YqFruJ0fIQaq4bXx6rqYQKJBsi3GsVc+e+YJ76sl/e9X4Sp2SOsXPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmFrZ3Q3Zmd1dXBpVDVIeG9ramZBWDEwcjJNT1lKeSswdms3eDVTMlh4M0Fa?=
 =?utf-8?B?N3BXZkR0VklIVHAwN0J5d2NWZm9hakxIUWwyTlYyWEJITFhCV2xzYSt3OVp5?=
 =?utf-8?B?eFg4UVdydW9KMXAzMlBKUXpUSGZ2U0YxRzQ2MDhNcXdPWjg5Mkd6Qkw2Mk1U?=
 =?utf-8?B?enlEV2cxa2ZzT0JueTRIRm5Lbit3bi9MY0hYclFTaTAyVFFGeVlBOEVWV1Ri?=
 =?utf-8?B?ZFRWempZMXpQSkNCelNONFRvRWsramRFOGpLOEVmcXd6M2RBakFuSm0vUDVS?=
 =?utf-8?B?L3QzNjhaUDU0aHhTNUpmRmwyYTdqRVdubCt5U1kxNUpnZTJRUzllaXpadGow?=
 =?utf-8?B?SmZCanc4QkRRZDFoNTdiTlk3UkRRSDg1ZFEwNk1tMFlTMldsME8wYnRIYVRB?=
 =?utf-8?B?b0FNeDdXY2N0Z1k1K3NrUm41NWY2blhxN0dHbFp0N1NUK3ZIU256K2NQTGQz?=
 =?utf-8?B?L2Z6MW91VFhsWG9vV3lQdExFTUdqejc4b2tzMVZFSEVrTHhVYUxmQmp4b0JL?=
 =?utf-8?B?M3BkNFE5QmltMzBPZG92VDdXa3JZK01wM0xRRUx3ckVVWWlqenEvTy8vZENR?=
 =?utf-8?B?K0JGZlJKSkt2emFpbnRVTlZ1STJuMEhIVXJLNXQrRTJxekVxUWxwVi9oOTR2?=
 =?utf-8?B?Zml0cWtIVHkyUnJCKy9HYjEwZEg3dXZMclc0TmM5OHczVkRwOEdhN083NHBu?=
 =?utf-8?B?U0tRQXZVWTZvMzM0SmR6TXVIZmgvM2dVaUp6U0NlbHpXdFh0L013SVpvMGRL?=
 =?utf-8?B?ck40bFBWQTd2d2I5ajBVaTRPdXRaTldlV2VxWWREVmZheVhONHpYTm1uMVYy?=
 =?utf-8?B?OTVyeWc2TzlMWkxTOTJ6R0JrRHkwdDlkWHY0cndJK1FGbDB0UTVGczVYWEJq?=
 =?utf-8?B?aFhnMG0zQ2ZIRm0zRDZqT09KbFlVdGxsa20yUmk0b2Q0UEg2YjZhYTlVY2dF?=
 =?utf-8?B?NUp2NDgxZVdOallEODNoQWlDd2tCUlg5VjVWYXphYURsZnZ3M3YzMHBQTEJ2?=
 =?utf-8?B?TkdyN2ppeGJQTE1Vb0tRK3hwKytNQi9uVjI0ZmhGUDZWTnordVRrNUxNUW1D?=
 =?utf-8?B?WnRMeU5rSWVrWG1hRkdxejk2T2d5cUJjZG1kMWlTcjZ0WUtKdUM0dkNla28z?=
 =?utf-8?B?bUpYOFU4WXBNUklaL1luTnF2MmZWOEZGVmNmcFE3Z0NVaTJnaE90Q2JYbkNH?=
 =?utf-8?B?eTZHVlpYOVZEb3k4cEJHeUpMaVQxbzlIcnZiSVRGVlZPbFpZZFRlQk4zWmN1?=
 =?utf-8?B?MXlRbHg5bmxad1dkajVuMlRSbTFUd2dEZGpIYXg4eUh0WklwRXhwTHlJaTRv?=
 =?utf-8?B?WTlZb3ArOXk4QTVacmsxRUdheTkyN3Y0VnNDRWpWSENBZkJBWkduLzd2R3Rw?=
 =?utf-8?B?MHR4QklyTXlwQUpGa1pkaGpmYmcvOHNMN00xRDZRc0k0ekdEOGhkUHZjM3N3?=
 =?utf-8?B?bVI0WU00OUh3eWg5cVZzN044SmtrVEJUejZ1bFVTVHFYMDFQdnhHUHdGcm5X?=
 =?utf-8?B?ZUNZYmJrY0dqQnRNcmVMM1lsdkwrNU1QcWhodFFzMUlMcTVYM0NGUkdxbUpQ?=
 =?utf-8?B?TC9WTkRNdm1RcW02L2JKTEJJTnJROTNiTThabGhXenlrRzIvQm5uTmxnZUhR?=
 =?utf-8?B?ZHFCMDduV2szWk85RnJuYk9oc1V6SmFpS3dPc1pwL3ZGNWlQODRJdVB5T3Nj?=
 =?utf-8?B?WlBXRnhWUHNUTVI4RzNDUm42b0NxMjJoSmFBcmkyTDZJRWVxRmpBVFdLblNr?=
 =?utf-8?B?Yi9pYUdQdUZzNTZaWjgyeC8rV1FLL211U2VYS2dXYjcvRDFKMW9uajF6cC92?=
 =?utf-8?B?UDVTUzAxa3paeldTeHZBZ3lOcHY1NnZPRkZHYUVoMjh2RHU2aFpHVFZiT2VX?=
 =?utf-8?B?NU5veHhjaFJGSExqckRaV0QzQ2hIMlJWS0lLZnhVcnFmeG1Odnl2UEtidy93?=
 =?utf-8?B?UElXeUQrUWZzcEVGR1pXQ2VOUEhSWTJ3NUs0b0VveHpCQmV0RGdlbjN5L2U5?=
 =?utf-8?B?ZEdnK094ckZ5M1dmREJ2Y2RQRkJjck8yLzJJdkI2L2gwRUtlTUtPQko4cEZH?=
 =?utf-8?B?aC8yTlAyLzVXVlpDY3IxWVRiN01sLzk4UXVmUTFOYjJqNDVDbm9RbGlXQzdI?=
 =?utf-8?B?K0FYVHlYcmJGb2o5b25aL2x0c2U0bFUvc0o2TFhMZDU0RWVib2xzNFc2YVg1?=
 =?utf-8?B?VUFLNk40WG1RMjFyZFN6TlRWQ0RKbVJhVnh5RDQvY293cm5DZ1ZIZWY1VGdO?=
 =?utf-8?B?SHI0THc3Q2xROWtsNGRnaHQ1MklqRXd4SWNpQmdBei8xTnZMOVQwUzRVT0d3?=
 =?utf-8?B?aWJwN3J0NFVyaFdJVVFqWVhkMXQrUHJ0MGRRNVV5dUd2Ui9FTjQzZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b165e9-8768-4d85-8a91-08defdca61b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:17:59.7101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmQOH/7caZQmrcXIpAoV5MCiv0HvlqN9hRm/L4WOaPxCbERxY5ZyrLG3H/RUbzTS/WMA2P3EE8lCexPAw9nyqV0WaheldOSRCGlX8mNEj08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18359

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE0IEF1Z3VzdCAyMDI2IDE1OjEyDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMi8zXSBwb3dlcjogc2VxdWVuY2luZzogQWRkIFJlbmVzYXMgUlovRzNMIFBvd2VyIFJl
YWR5IGRyaXZlcg0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgMTIgQXVnIDIwMjYgYXQg
MTM6NTAsIEJpanUgPGJpanUuZGFzLmF1QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gQWRkIGEgcG93ZXIg
c2VxdWVuY2luZyBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czTCBQV1JSRFkgbW9kdWxlLA0K
PiA+IHdoaWNoIHNpZ25hbHMgcG93ZXIgcmVhZGluZXNzIGZvciB2YXJpb3VzIElQcyAoVVNCLCBE
U0ksIENTSSBldGMuKSBvbg0KPiA+IHRoZSBTb0MuIFRoZSBkcml2ZXIgYmluZHMgYXMgYW4gYXV4
aWxpYXJ5IGRldmljZSB0byB0aGUgcGFyZW50IFNZU0MNCj4gPiBkcml2ZXIsIHVzaW5nIGl0cyBy
ZWdtYXAgdG8gdG9nZ2xlIHRoZSBTWVNfUFdSUkRZX04gcmVnaXN0ZXIgYml0cywgYW5kDQo+ID4g
ZXhwb3NlcyB7dXNiLGRzaSxjc2l9LXB3cnJkeSBwd3JzZXEgdGFyZ2V0cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+
IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9wb3dlci9zZXF1
ZW5jaW5nL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3Bvd2VyL3NlcXVlbmNpbmcvS2NvbmZp
Zw0KPiA+IEBAIC0yNyw2ICsyNywxNSBAQCBjb25maWcgUE9XRVJfU0VRVUVOQ0lOR19RQ09NX1dD
Tg0KPiA+ICAgICAgICAgICB0aGlzIGRyaXZlciBpcyBuZWVkZWQgZm9yIGNvcnJlY3QgcG93ZXIg
Y29udHJvbCBvciBlbHNlIHdlJ2QgcmlzayBub3QNCj4gPiAgICAgICAgICAgcmVzcGVjdGluZyB0
aGUgcmVxdWlyZWQgZGVsYXlzIGJldHdlZW4gZW5hYmxpbmcgQmx1ZXRvb3RoIGFuZCBXTEFOLg0K
PiA+DQo+ID4gK2NvbmZpZyBQT1dFUl9TRVFVRU5DSU5HX1JFTkVTQVNfUFdSUkRZDQo+ID4gKyAg
ICAgICB0cmlzdGF0ZSAiUmVuZXNhcyBQb3dlciBSZWFkeSBzZXF1ZW5jaW5nIGRyaXZlciINCj4g
PiArICAgICAgIGRlcGVuZHMgb24gU1lTQ19SWiB8fCBDT01QSUxFX1RFU1QNCj4gPiArICAgICAg
IHNlbGVjdCBBVVhJTElBUllfQlVTDQo+IA0KPiBDb3VsZCB0aGlzIGNhdXNlIGNpcmN1bGFyIGRl
cGVuZGVuY3kgcHJvYmxlbXMgd2l0aCAuLi4NCg0KWW91IG1lYW4gdGhpcyB0byBiZSBmaXhlZCBh
cz8/DQoNCmRlcGVuZHMgb24gU1lTQ19SWiB8fCAoQ09NUElMRV9URVNUICYmIEFVWElMSUFSWV9C
VVMpDQoNClNvIHRoYXQgdGhlcmUgd29uJ3QgYmUgYW55IGJ1aWxkIGlzc3VlIHdpdGggQ09NUElM
RV9URVNUIGZvcg0KQXV4aWxpYXJ5IGJ1cyBBUEkncw0KDQo+IA0KPiA+ICsgICAgICAgaGVscA0K
PiA+ICsgICAgICAgICBTYXkgWSBoZXJlIHRvIGVuYWJsZSB0aGUgcG93ZXIgc2VxdWVuY2luZyBk
cml2ZXIgZm9yIHRoZSBSZW5lc2FzDQo+ID4gKyAgICAgICAgIFBvd2VyIFJlYWR5IHNpZ25hbHMu
IFRoaXMgZHJpdmVyIGhhbmRsZXMgdGhlIHBvd2VyIHJlYWR5IHNpZ25hbHMNCj4gPiArICAgICAg
ICAgcmVxdWlyZWQgdG8gcG93ZXIgb24gdGhlIHZhcmlvdXMgSVAncyBvbiBSWi9HM0wgcGxhdGZv
cm0uDQo+ID4gKw0KPiA+ICBjb25maWcgUE9XRVJfU0VRVUVOQ0lOR19USDE1MjBfR1BVDQo+ID4g
ICAgICAgICB0cmlzdGF0ZSAiVC1IRUFEIFRIMTUyMCBHUFUgcG93ZXIgc2VxdWVuY2luZyBkcml2
ZXIiDQo+ID4gICAgICAgICBkZXBlbmRzIG9uIChBUkNIX1RIRUFEICYmIEFVWElMSUFSWV9CVVMp
IHx8IENPTVBJTEVfVEVTVA0KPiANCj4gLi4uIGUuZy4gdGhpcywgZHVlIHRvIGEgbWl4IG9mIChh
IGxvdCBvZikgc2VsZWN0cyBhbmQgKG9ubHkgdGhyZWUpIGRlcGVuZHM/DQoNCkkgYmVsaWV2ZSB0
aGlzIHNob3VsZCBnaXZlIGJ1aWxkIGVycm9yIGlmIENPTVBJTEVfVEVTVCBlbmFibGVkIGZvciB0
aGlzIGRyaXZlcg0KV2l0aG91dCBBVVhJTElBUllfQlVTIGVuYWJsZWQ/Pw0KDQo+IA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3Bvd2VyL3NlcXVlbmNpbmcvcHdyc2VxLXJl
bmVzYXMtcHdycmR5LmMNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcHdyc2VxX3J6ZzNsX3B3cnJkeV9t
YXRjaChzdHJ1Y3QgcHdyc2VxX2RldmljZSAqcHdyc2VxLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArICAgICAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHB3cnNlcV9yemczbF9jb25zdW1lcl9tYXRj
aFtdID0gew0KPiA+ICsgICAgICAgICAgICAgICB7IC5jb21wYXRpYmxlID0gInJlbmVzYXMscjlh
MDhnMDQ2LW1pcGktZHNpIiB9LA0KPiA+ICsgICAgICAgICAgICAgICB7IC5jb21wYXRpYmxlID0g
InJlbmVzYXMscjlhMDhnMDQ2LXVzYnBoeS1jdHJsIiB9LA0KPiA+ICsgICAgICAgICAgICAgICB7
IC8qIHNlbnRpbmVsICovIH0NCj4gPiArICAgICAgIH07DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCj4gPiArDQo+ID4gKyAgICAgICBtYXRjaCA9IG9mX21h
dGNoX2RldmljZShwd3JzZXFfcnpnM2xfY29uc3VtZXJfbWF0Y2gsIGRldik7DQo+IA0KPiBBcyB5
b3UgZG9uJ3QgdXNlIHRoZSBhY3R1YWwgbWF0Y2ggZW50cmllcywgcmVwbGFjaW5nIHRoZSByYXRo
ZXIgbGFyZ2Ugb2ZfZGV2aWNlX2lkIHN0cnVjdHVyZXMgYnkgQw0KPiBzdHJpbmdzLCBhbmQgdXNp
bmcgb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoKSB3b3VsZCByZWR1Y2Uga2VybmVsIHNpemUuDQoN
Ck9LLCB3aWxsIHVzZSBvZl9kZXZpY2VfaXNfY29tcGF0aWJsZSgpLg0KDQo+IA0KPiBIb3dldmVy
LCB5b3UgbWlnaHQgbmVlZCB0aGUgbWF0Y2ggZW50cmllcyAoYWN0dWFsbHkgdGhlaXIgbWF0Y2gg
ZGF0YSkgd2hlbiBhZGRpbmcgc3VwcG9ydCBmb3IgZnV0dXJlIFNvQ3MNCj4gdGhhdCBtaWdodCB1
c2UgZGlmZmVyZW50IHJlZ2lzdGVycyBhbmQgYml0cz8NCg0KTGF0ZXIsIHdpbGwgc3dpdGNoIHRv
IG1hdGNoIGVudHJpZXMgd2hlbiBhIGZ1dHVyZSBTb0MgaGF2ZSBkaWZmZXJlbnQNCnJlZ2lzdGVy
cyBhbmQgYml0cy4NCg0KQ2hlZXJzLA0KQmlqdQ0K
