Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010061.outbound.protection.outlook.com [52.101.229.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C640096F;
	Mon, 24 Aug 2026 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585023; cv=fail; b=P6NRGqLb7ehGEvJGoq1JWFk5HKT5iNunyE3ZCaZsEN9xIuTt+lgS0uGZ4WDyGGpmCR5cpk3i5grjq3WTmD1k0hMYaOmfbQaFXV1iPEGQZji/KP9AXqCbzg5ZxadoDJD3KgLg0PjiXXyo/kxE5c3X38WQkpEwnZ12yjtD5pAqXW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585023; c=relaxed/simple;
	bh=kI2bawpCm/VLtu0lgNlftdvUhR5KDqYklbW+MBt2m6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CgIwr5upkoNuk6TmfZNkTTZxgoG8gAuE3ribFGE1asTGIg0F9A0dc0CH5r/P1Xl5Zpx1hCH+Mwiga5wyaO4nFD8Ed/Ac2m3xTFczdbQx1sZxhshR2ANmPTfiJ6tPQb1P3Tvbw2jbFbK6NAz9RB5/eYPpZkP1uJdh/cAluCGvDdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=A8jo3Dx7; arc=fail smtp.client-ip=52.101.229.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="A8jo3Dx7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipbc57bdmE1kAVe9B7xj7C3c228paVX0R9tafUeXi7ad+Ep9zFZC3wn/WdXWB+X9FMX5bHoZJKiIOWhFMrjo+0VMsh+JMaUkH8KnR6g8gRmzkBNV66i9rlmjViaMQlPeA5BVspqg0qu2IrYWkJg0S7rE/rlyNbHVJuStDx+TZdcW8Pdw0xdpuq2Q/QI/yqVumXxqkDSAW3Fkh8gylr5mP7tlddeVVbPshPOXR8q3L9T7vrambsfTrdoKZPVFawL1FFTDNGuVTHG2bglNQNDszJT+3+OSqJvhb+fonVylr607iXZOwmk2EviLVNRs4WwFi8GuECOUU2TLkFPJpdpwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI2bawpCm/VLtu0lgNlftdvUhR5KDqYklbW+MBt2m6Q=;
 b=IvaxSY637yE14pOMqq4vI6Hr+RP6a5IFbXz8jodwSogoblPeu17oTuZ3GAk8KIr/NTPyrtm78KzvaD1b/U3KHGj5NyfW49vDzfmucANK8Pn6Wabz9ZqgHlfBYpt3BSo1iMX09Cmnz8UBP3Vh+yAwMzX0qadD8YuwXBV5BRLklsp0pqVJddy1+BCFxi26/R+F6Uylrsq+i+G5Um5lz08MW5Y2UtAzaiudRO6Jfmfn0Q4zYsTWYqzKOs5KMmuHOLlJ/3VE3WnMc9jv1G2paQOmWpYUAVGe0P+3/CwmnQJmTExvFkJrB5KcG9z1+5VmCFfIMRp8m4iSpKiCHGu/Eii3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI2bawpCm/VLtu0lgNlftdvUhR5KDqYklbW+MBt2m6Q=;
 b=A8jo3Dx7co1Q4IEWtwHnoGbck8R+lhfPeP+PHIHH8epkTHVL9pWgotbBGl2vC/oKJ5lwtkpEPHGanZFba0gZDF5zm+O8sh6mNroQmFsZdhflkkf7jn7NVI49oMuB1wAbXommwY7CPOEBzOhgJy7UfP/xs4WzuI+5TogHsrOa3ro=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12399.jpnprd01.prod.outlook.com (2603:1096:405:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:23:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:23:39 +0000
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
Subject: RE: [PATCH v4 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Topic: [PATCH v4 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Index: AQHdMA7WUgCeKshv/ki9d0DbBlsPpbatTskAgAAJyPA=
Date: Mon, 24 Aug 2026 15:23:39 +0000
Message-ID:
 <TY3PR01MB113467630111474706CE4196186A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260819191325.217809-1-biju.das.jz@bp.renesas.com>
 <20260819191325.217809-4-biju.das.jz@bp.renesas.com>
 <CAMuHMdXCjiTOw0XqQvcUd1So9v0+8PO6KAqpqWTX5xk6r26GnQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXCjiTOw0XqQvcUd1So9v0+8PO6KAqpqWTX5xk6r26GnQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12399:EE_
x-ms-office365-filtering-correlation-id: 862426fd-59d9-42fb-ec49-08df01f3ac96
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 //68ISH4Hb6WyyT/OV76fbCJlYtxcAuC06N+qaqeMFkdszEewYzSOqw/kR2aOSba/HCwZysQd/mVPEQeBYiS2GnyFc6bwnGb4D5rTyxVxOGhHm2FF+VTL2xkb0drGz7DU0hhlTjwrYzf6IKHwWLHjZiw2WiG6fFAv1lWKqVvTzobeTjU+1jYimtWaaz4F2SQqbpm7aSdgp6p8/8S1lNlFt6BXQqvUSBEJdvSC+6qOQL4rSp4ZiCbpm8EJkizk5BqwCB4H5gzR/VMDjuw4kLnQELZHBxlhws9eKMg/9/Zsfpf76DUD9sT0G3srfAHVYriKWfc3qxrs7225CufW+njADLgpCkxp9wMdJjDS0PwD1RDn8cNxBfg3bl9PvuaXLQB51HjPulYz/InRvPP0yNwgqJuIFUiIG4514ht+sN0bIRUFtEGbTdXf5npvNOIf4yYEN0qoWah1FMXNh93ZV3IDwz9CC+D08Yqe8vKgbsjrXMO1F3pRSKlkCSsou0PP4Yk00yCxuXWazRcle/b+JJSHuvc+c3H8Y4sa5qe/bC240GosYUrxrXy1GNxbi0bkmlUEUaFGlOx6XkHygKMsRHIPa6xALFo20Vn9OBmsL50ixrC7X5yqsrwOMbdJLgzorNy6gR0SEyW/lrnhMoHNsj0smg7545Tukubtmnw1IIWh+BiZCociWyvqD6KYtN246rlPDkTTg1XNK5my4Nn7S1+RA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDJGQS9tejNvVHNyYjhFdkgrUzdhLzJ0UlNGRzRQMXl4Q2ZKNUt1QVpGQ3lE?=
 =?utf-8?B?UHhIKzZrczBTWHl0Mk9abk1BS1NJSHU3MHFQSHpQWGdUbUk0VjJ4dHlpcThW?=
 =?utf-8?B?VWN3YjlhNVFQdjYrUzk0Z1dQdVd6d2YzQlJuRlFkMGF1VWpGQmxmcEFPYmtl?=
 =?utf-8?B?T2VzNmNtQWxXNTdwbjN6RTdvZ29uQmRlamVDa3VlaWpUR1U5V3AvTHl1Y2xQ?=
 =?utf-8?B?dFhIamFyRTdxZnJ4WDREdzBPSTB2UHdpSG9oVGgxSkoyMnFGYmlrcEVVeFYy?=
 =?utf-8?B?RDVwYVZ3clZaQmJ1UVRZK1RZc0Fja1c1MFJKSi8vN2xzVXMzaTN2ZHVyaWFR?=
 =?utf-8?B?Q2FMcERpcWVkb3JSeXZ2VW95T1BhSEtJRnVnV0pJempLMnRjbjhBMlVvRDl3?=
 =?utf-8?B?dTMrRWh0MUNaMGpQQkVtakFhdmZsNXBmM1JZNzFja2FHMXh1dGI0WEVWRm85?=
 =?utf-8?B?MWpZNTZGcjdzNlRRT2Z0T2NxbUdmQ2tGSzVGZHUyczhBOTd4R0dZN3c3MWJz?=
 =?utf-8?B?T1NzdkhEREIwbWNhSWM0ZWdhcUNHWTk4WHVQOCtGMVNFWXFQVnJSQ3dZb1ZU?=
 =?utf-8?B?M1FabFdxUm81U29oOG44YjljazM3d1YxSDZKTzFFcFFPRW9WRGc5Q2VpV0p6?=
 =?utf-8?B?M2x2SGFHR2pYcUhLandmM04ydGpseXc4TFhaaVNBQThtZWtJVkcwSXRGbDAz?=
 =?utf-8?B?MzZLZ1VSc0dQcTN4LzFVQUNBR0pqckk1cEk5QWZpcVBqV1JjcEVnREJOWmlD?=
 =?utf-8?B?UFpvU1pTUXg5R0sxNEFSdnRsYmxVVFdUMXNzTEI0eitmNm9GNUZGWjBycXh3?=
 =?utf-8?B?TXFhNlRlSGJ0L0N6TTN1Z0lzQkpzWHpudyt1SThyd2JrTnU3VDNKUXgxZkJu?=
 =?utf-8?B?WHkwd2JncEFFbFkvbmRqQ0dDRmVMWlRhQXRjeWRPb0ZYQ1hHNURxczAxTVEv?=
 =?utf-8?B?anFmckl0bUhFeVYzY1h5SHhjS3d2VlVRYUU0OGF5L0ZOSTZTRkRUNHUxaHkr?=
 =?utf-8?B?MHdDQ25WbWtldkJEZUU1a3ZDYTdKa0J4R2pIQUs0KzF2dDE2TTNrZ3FYU0lo?=
 =?utf-8?B?NmQrOGpZL2djZUlNVEVuejJJNjdmQm9ueTU0eVNCRlc1MkF6TVRvTmYzOGkr?=
 =?utf-8?B?TU8wZlRTdUtZbFVUeWFIY0ZEQkxra1hMT3ZOR3U0V1NBYnJrR0hHekQ2VkEz?=
 =?utf-8?B?RE5QdTNveUkzN1JUWlRVUVd1ajlDNkZYYzRRWDVSM3JpNFhYWVh5dW9tMk9l?=
 =?utf-8?B?OGxjVm9CVUlRQjg1UG5JQitSeGtTaUJLemRGN2NiRlVVcDFDK1kzU1RBYVpo?=
 =?utf-8?B?VHJvVVQyVERINEtZVHBNenloY2JpVGNtSXlnV2pHTEVGKzRicm8va0FrSzI3?=
 =?utf-8?B?cVRVUVJaVzFtaTdTdEpTdlhOeXQ1dXR4a3Z6QzByYU9aMmFYMEx5MFdmQTky?=
 =?utf-8?B?enplNEhURWtEdVcrd3RtTTMydTRETExjOVYxM1RxN2RxSGdWVzF0R2RwcnlN?=
 =?utf-8?B?ckdlb0kxUHBpcjNHeC9HK3MxNzF3RlN3TTZGaWRobldMY2xNbE9xbjRsOVdk?=
 =?utf-8?B?SG15ckovOHE3dGNFcXQyaVBKNzcyb2pPdmd6bDFYcnlVSG9QQ3hDb3RDb2JC?=
 =?utf-8?B?UXFtN1FmUWM3S2Q4bjRXMmtRdnBINlJZcmxzYVdDanRRcCtldSt4THNycGRN?=
 =?utf-8?B?ZEs3aUxtTFhLYk9IZjYxb0tuNjN5SnVEcEJ4cnYvdDhqeXlYQnBNV2xzb3Mz?=
 =?utf-8?B?ZUhrK2xHV0puUkJaRzNMRHN2aWQwQVFnWllrdGM4d2gyMlJDNDVTRUlva09U?=
 =?utf-8?B?R3NzODAzcjRSREpFZXVKV256eUtDa0phdlZFTGNzTnBYK1IzV3pFelRCcE81?=
 =?utf-8?B?NzR3ck9GSmhJUzNKZlpmSVFKaU9BUFdISGlPRXBJSCtWdXdmMWNncnhieUxZ?=
 =?utf-8?B?ZXZTQ0tPb0RhTzk4ZEZ1UkFSNnFlanZ5SFhNcDJPOU8xRjJLNUtmMnhlbkkz?=
 =?utf-8?B?UjBLckJLd0E4d2JHcDhQNDFOV0tBQktxU0l3ejEwSkVhQTdlZ3BlblhlWkdx?=
 =?utf-8?B?MFhPT0ZRcFpuT2pqZjdkbjY2c2JXbFlZRG5mWXJlYXJLbkhoNEVnbDBtWnJn?=
 =?utf-8?B?K2pkK0pHT3ZMZ0c3aEtMYzU2MGRBeGpSU05nVUlXREFqMjlPYWt5U1B3bGR1?=
 =?utf-8?B?TFpEakI5VWhLeHNESlQ3TXdYOEo2TVMzcnVZNjBWYW1xT1JZcFEwMXlBdVdo?=
 =?utf-8?B?MUtNem8rV1hBMGhEMGMrdFNIb0F0MXM1RTRoVitEaXpXSVVHSjZzWFZDU1N2?=
 =?utf-8?B?VzJQbWVCdHk2OHRMNllVaG1mdEpYaU9kT0drd0RaTkcrWjRDMnBBUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 862426fd-59d9-42fb-ec49-08df01f3ac96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 15:23:39.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9tlhRGiplvr76VvoTK4T+YXgkvnMIJoHAxS1hmsqBFJPJTJof5hgMZ4ngAmyKPzJnLgaN+PcPQhwEGAVn+HeKmmXUDisvJqpCtAqN25G50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12399

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDI0IEF1Z3VzdCAyMDI2IDE1OjQ3DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjQgMy80XSBwb3dlcjogc2VxdWVuY2luZzogQWRkIFJlbmVzYXMgUlovRzNMIFBvd2VyIFJl
YWR5IGRyaXZlcg0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgMTkgQXVnIDIwMjYgYXQg
MjE6MTMsIEJpanUgPGJpanUuZGFzLmF1QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gQWRkIGEgcG93ZXIg
c2VxdWVuY2luZyBkcml2ZXIgZm9yIHRoZSBSZW5lc2FzIFJaL0czTCBQV1JSRFkgbW9kdWxlLA0K
PiA+IHdoaWNoIHNpZ25hbHMgcG93ZXIgcmVhZGluZXNzIGZvciB2YXJpb3VzIElQcyAoVVNCLCBE
U0ksIENTSSBldGMuKSBvbg0KPiA+IHRoZSBTb0MuIFRoZSBkcml2ZXIgYmluZHMgYXMgYW4gYXV4
aWxpYXJ5IGRldmljZSB0byB0aGUgcGFyZW50IFNZU0MNCj4gPiBkcml2ZXIsIHVzaW5nIGl0cyBy
ZWdtYXAgdG8gdG9nZ2xlIHRoZSBTWVNfUFdSUkRZX04gcmVnaXN0ZXIgYml0cywgYW5kDQo+ID4g
ZXhwb3NlcyB7dXNiLGRzaSxjc2l9LXB3cnJkeSBwd3JzZXEgdGFyZ2V0cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAt
LS0NCj4gPiB2My0+djQ6DQo+ID4gICogUmVwbGFjZSB0aGUgbGFyZ2Ugb2ZfZGV2aWNlX2lkIHN0
cnVjdHVyZXMgYnkgQyBzdHJpbmdzLCBhbmQNCj4gPiAgICB1c2luZyBvZl9kZXZpY2VfaXNfY29t
cGF0aWJsZSgpIHdpbGwgcmVkdWNlIGtlcm5lbCBzaXplLg0KPiA+ICAqIFJlcGxhY2VkIG9mX2Rl
dmljZS5oIC0+IG9mLmgNCj4gPiAgKiBEcm9wcGVkIGxvY2FsIHZhcmlhYmxlIHB3cnNlcSBmcm9t
IHB3cnNlcV9yemczbF9wd3JyZHlfcHJvYmUoKS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0
ZSENCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcG93ZXIvc2VxdWVu
Y2luZy9wd3JzZXEtcmVuZXNhcy1wd3JyZHkuYw0KPiANCj4gPiArc3RhdGljIGludCBwd3JzZXFf
cnpnM2xfcHdycmR5X21hdGNoKHN0cnVjdCBwd3JzZXFfZGV2aWNlICpwd3JzZXEsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldikgew0K
PiA+ICsgICAgICAgaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwgInJl
bmVzYXMscjlhMDhnMDQ2LXVzYnBoeS1jdHJsIikgfHwNCj4gPiArICAgICAgICAgICBvZl9kZXZp
Y2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25vZGUsICJyZW5lc2FzLHI5YTA4ZzA0Ni1taXBpLWRz
aSIpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gUFdSU0VRX01BVENIX09LOw0KPiANCj4g
Tml0OiBvZl9kZXZpY2VfY29tcGF0aWJsZV9tYXRjaCgpIGhhbmRsZWQgbXVsdGlwbGUgZW50cmll
cy4NCj4gDQo+IFNvcnJ5LCBteSBmYXVsdCwgSSBhY2NpZGVudGFsbHkgY29waWVkIGFuZCBwYXN0
ZSB0aGUgd3JvbmcgZnVuY3Rpb24gbmFtZSBpbiBteSByZXZpZXcgb2YgdjMuDQoNCk9rLCB3aWxs
IHN3aXRjaCB0byBvZl9kZXZpY2VfY29tcGF0aWJsZV9tYXRjaCgpLg0KDQpDaGVlcnMsDQpCaWp1
DQoNCg==
