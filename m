Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011067.outbound.protection.outlook.com [52.101.125.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BD2D73B8;
	Mon, 21 Sep 2026 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955078; cv=fail; b=a1Ep/Uc+l2hBv3T8QtliYraz/4we39EPz6C7htLNOp/LiH81LDeqBA399w4s/wHQhJni7jghvTL8+ZVP484wyWaj/gYKTTxlZHDVUbUZCwUQVX7wBfKNAz3bGdLEJErAsYlIKJKvFPZwA/TUAZIbT25D/+EZps22rcU5DX50U2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955078; c=relaxed/simple;
	bh=LGhf+F/Eiexa+uQTfvXUA3sbs5EVCI3Xfze/AEO0epY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FwJTqqfdxCpDv717B7cervTwdwdW30e0PCwAMBSDEs8/FZBc12W3KSOCVgI773AL4jc0lbTCrSQdUwCkKzNeyrxJO3B2v6nrkv2CtDqdDsnFPliwPSCguqv8babxSfOZ3H0O2LR8eESV9HNgdCsqT6dCZtcIvjy28qcnHYqirTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pt9YRHje; arc=fail smtp.client-ip=52.101.125.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pt9YRHje"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihf8fW3MRuzrjeJm6ovxMIGYKuP3HvUh2E1mgDr2CUHmfq2a6edrbD0BRL1p75XlCsAbuQZoFRNvnyQVixHbsFtr3OEp14prp91eKOwfAKFqmT5b7WkLiop5FHcKraabdkH32wLSF95bMaajDt/YlZO1yaGBMtMQGnlotQ/8uUqAmnxrP3MllVTfWAy9RjtBomFb45myauzDU0GvkTaoMroK26lI51T/FVMbZs+2AYsEr9oGvM0vAeCnJHXIwGKzPF/eC3joyy8pj4K83U8x/Za5COBJV6QHuVjGpXUw8HdIWy3GtkHpwCvdrbBBXykVA5kSkB5DSKscIYFjRQuqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGhf+F/Eiexa+uQTfvXUA3sbs5EVCI3Xfze/AEO0epY=;
 b=aGXBxYsJMUZ/a2U8BM/yTOfuy6Xad25wFFp1dLRO4N5LaTp51BE4Rpxm+d3tLEh0l/i17UIx2O6KXSu//6yQ7SR0C+eEzw3l+4E0Tdt2ECB4+975vJddKl773iuO30cAJRYJkuoIycmoCgegkbw7uBXsvD1W1/HhAPPyT1840b4+Leo/oE4uylej9uKAzrWWiYuqI/D5rKZiRxN9oKE4+sIX9QpolutIoD+XEY+gj2SatnvQdm0ySbg3pgr5tRJvqjHF0jIHuVRYASTYWLEOIGnehmH5MB+psFzrzcVNPg+ovCN754zu3RCszuxgzqcVI9tVhbQX5WQUm8JjMed4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGhf+F/Eiexa+uQTfvXUA3sbs5EVCI3Xfze/AEO0epY=;
 b=pt9YRHjeG8xwmkzB6IPwBByfKmRIc/PQ0odNFyK9Ch/lbB4tyD8GOFw1Xv1DTgMw98jLmYcwbrGAouYxV47fb5pMAq0Ti1/OonFV2rWCCHNb4xrcBMOnbTWD2zrY6E3zwgsK6rz3xfqYgshqHXAxCeJTNEP+idBdnABHQhSinms=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB16129.jpnprd01.prod.outlook.com (2603:1096:405:2ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 01:44:31 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 01:44:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
Thread-Topic: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
Thread-Index: AQHdR3+gbYQYz7FwNE+VCb83YQjWtbbXvvYAgACCoQA=
Date: Mon, 21 Sep 2026 01:44:20 +0000
Message-ID:
 <TY3PR01MB11346ED0D17722AB3821E3F4D86842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-5-biju.das.jz@bp.renesas.com>
 <178992596603.706584.10389874816454714845.b4-review@b4>
In-Reply-To: <178992596603.706584.10389874816454714845.b4-review@b4>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB16129:EE_
x-ms-office365-filtering-correlation-id: 922dfb97-8596-4bef-45bd-08df1781db42
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|10063799003|38070700021|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RibV2CFqHlYyYAjC7z47TZfFwDdIvQ6dGq5DMxAAI0csiegHHaTQ6sdlm+SCch5DQu98kNBJF/B+D0Xbn1m5JmFVLwgZ1+0tI4PLPMH98MUYDgNHoA89G8bF7GsYHxX6SA0VQq1qgX2s3FLIxaVDnC8bl1tNrSL/NqI/w5Shp+DblyApJlZfjeIa+XVgLKtINJIaLibE5G7+s9ZXlVa8ImXKhIIUsmIsWVTY+cjzR+2qSX7vlfspY5jrYjhC4PtCWMLZ+Vd4oQ74aaXO82J7DvKg7tnUVO60iEbDgq/kfqkXE3gG+jyWb38T89a8XiJRy41iuoSf/TsjJ4HxVggn88nfQafFaw1q/zQ8fCDbAk0sfSmplNDyJzZo8NJIBVgPZ2EELJm3Q1FCZg2pCtuuCqbt88lURICSBbA8CFGVtPgs5nIeA9twzweBaTQIW/Dgw6vlF2nxvH7lK5UcTR7tE0dO6gnUW6m6wz6yrNUjx77C/TXEEP3Wg54Yp6malg8D93e6NWwXbcUndOYsHVBHBFYlf4fw1V9VEx0ZjRFdfEzFeeq7F9l9QcC8FXgkR5nHo/dXGfRib0iOyehXMhcMkcTiR09l4+g7/3gvkIQ7vgTKZH3xnij/yhwOkCipzVe2ZRarCFMkbRqJcp4NhehCLZztWElEZ5Yd/VzuTZtfyszFnmWLLnEAmaJcFPxniI8zlhvQynI2ZEyxg1kmPLWbAfbsw4NqHMzour1n+FT/V6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10063799003)(38070700021)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TURkKzVCTFZ4T3d0NXdTYm5xc1JvSjllejc2d3pZdVhIWmNHNS9ISHBhVUEv?=
 =?utf-8?B?TGcwY21DSk02cStWMUpoaHA4S3lRMmZoK1V2VTZ6RlFleDdGQTJKMHEvd2p0?=
 =?utf-8?B?OHJ6M2Q2Y0VtRFFCU0ZQazRBUkVIWGVyV2UwY0lDL2hIalJyV3lFS3Vzb1p1?=
 =?utf-8?B?VVJZeDgwQ3g2VzJGSmIvVWhqYWkxQ2xKQXV5K3NGTVhFQkdEeGxDaWkxais1?=
 =?utf-8?B?Um5EMHcxMzU3UTlwQVFyTS9QNEdZUUZvNXdRM0JRTHRaT1h3S1hPRTVPbjl0?=
 =?utf-8?B?TTl1U3VqamMwSlpOSDQ4Q2pDZmFGTERtSWZMYVZ2elIrMWY0ZnlPS2FHZ0Vw?=
 =?utf-8?B?Q0ZZRnM5RXplQVNDbHB1NEZmNUhjUit0VHMxVi9jTUxLUVlvL0tlUXZjRmlF?=
 =?utf-8?B?WkRzaEo2dFZYaGxDZVYyUDZyRVVnSk9BcGRKU2dEdmRrWmx4OWVHZGZJcFpK?=
 =?utf-8?B?RHUvMUdXSjIrUlUxWmlJRVowbjczdlJFZk96TnhYemJURDFtZkdvSFZWcVp6?=
 =?utf-8?B?VkEweDhtQ2YrOFZLOUFOb05ndzJaOUtqdTF0RVhuQW9aaGQ2K2JsUVNjK0hM?=
 =?utf-8?B?ZXBYUlNWWEVMb2ZBWmUzcHdxRjQzR0hWZDFpb3ZLOERCWTZoRnhrSHJ3OHF4?=
 =?utf-8?B?Zk5aQ1FvaTJJbXd0TzF4L1dqMm4yY2owazdBb04rbndNT01HQ3owQ25zTHpy?=
 =?utf-8?B?ZGczMGprMm1QNG1nV2hwZXBhbXAyTEJYWmwrQ1N3MDI3K1ZETEFpY3dGaVhO?=
 =?utf-8?B?QU1YdjdLUjdOQit6QTZ0eDgvcTJMbHdTQjZRNFhzY1BueEJvYURkdWJWOWJU?=
 =?utf-8?B?MXVZbDZrOGJBYlV1UFFRT3Jyb3dzVkEwcmFZT250WmF5SHFVeUtxeVRhY2h2?=
 =?utf-8?B?RUdWMENPZlpXSUx6RzhzWFZ3QkVxc0hUNi91WjRheW9hR2tWZmVSTHkwZkZH?=
 =?utf-8?B?VUYrbFlTRExUdUZYcEN5VXRSRUozbGkyYmlkak5pcklLSSt1ZFZyUzJJbnlN?=
 =?utf-8?B?RVNHc3JmV1lHbmY1Y1lKUzZnZHU5K3cxOWNFTndUTkpMWVZ0ZkdxT0xRMFFI?=
 =?utf-8?B?MkQvMmJaWVA2bkVGYVlaWU00NWlvRnIrV2t3dSs2WmpDR3FrdVZGblI2a3Jy?=
 =?utf-8?B?MDNTVzg3QkdCY3RUeEV5WmlyWkZGOTl1d1drZ0hrQUJqeWhvNUEwcjVzb3Z6?=
 =?utf-8?B?WDQ0RVlGSzE2Z2RUK1htV1l5aHpEWnYwWkxjaXZnVi9YWXd6eVdUV1o1cnMv?=
 =?utf-8?B?WklxWVRZMEY1SDgzY2Jrb0s2WU00TFphbndrT05mWFNiRDRKMGh4YS9HM3k2?=
 =?utf-8?B?bXVyQ0hEeHhWNE9NVmZ0RUdpK2E5cGRCQTZVcVdHbVZPelAxTnFWQzRmRjVM?=
 =?utf-8?B?czlqZWJsYnA4eDl0THUrcVFMYlVxbjc2cGhkemFPeUsvYkF0Vk8vYkUyODlo?=
 =?utf-8?B?T3pYME9waC9FTk5RNGU1ckVwS1RKMXBUN3lnNThDRm9VTkRwbm9vNStvZFdi?=
 =?utf-8?B?bzZaNGJtaVBjUW1JbkNYcFJMMEtIZ292dnFGS3pYa1ovY1l3SkVTY2pTRFho?=
 =?utf-8?B?cnJYYitiUi9hZGxhRkVpUmFKZWViZUNpZlQ1WlFXWnNJNTMxMFI2V3BJSmtJ?=
 =?utf-8?B?TXYzZVNNM1J4M0xuaEtjU3kvL0RiRVloeGJoMjY1K3d2emVTNWZnc01aTXA5?=
 =?utf-8?B?blB6Q3VxVDBTRjNwUHpFN0pHelRPb0c3RmRsNE9pR25KTUkrak1BMlZKM2hH?=
 =?utf-8?B?TTVGRlBrcGwvU2hJQXpjb2dZMnRLN00vS05NYzBGa3piNEwxM3pIbGN0ektG?=
 =?utf-8?B?RGYwQWswandtMHRtdHJ5Qm9iMWt0aG02NThIU2wva3dybjcrZHQ2eEo2V3Vi?=
 =?utf-8?B?bCtqeWNSdDR0Yyt0NUYyaXU5U1RUTW5MU0VIMHhDOXc0SVFwUW1SaWRheC9G?=
 =?utf-8?B?SkdMbWdzQmRFbS9FNWwrcUpVNnNNeG9Yc0tET1ZzeFk3SjcydXptcHFraFpN?=
 =?utf-8?B?LzBkSGFKWG01dkpzUFRIOFd3dzhrOEJLQ2ZDc0lpWW9FdndTTTUwcmRvTmFG?=
 =?utf-8?B?UnYxUllaUU94Q1BlSWdXdHNXSFhzZlVHMjZjUElEVzMySk1YSjk2REw3TEND?=
 =?utf-8?B?UCtOMmZ6dm4rbHhuT20vSXNJQUNyUnZiUWpFblo1TVc2SEJDd295MmR5ZENC?=
 =?utf-8?B?OEZZNEl2M0g0Wkc2dW1ZeGJydVczR2JTT09iaVJ0ajdBbWRqZ0dkSVB5WmFW?=
 =?utf-8?B?Unh6Y05wRXd5YjFGaUlOZFFrb0ZGL3Rhek9oYzhGdkZVZUNoQ2ZwM3RGdGdL?=
 =?utf-8?B?anhZY2k4MlFRNkgyZE0zRFZqeDhaUE1yYVY2bXpXTkpyeThEaEF1UT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 922dfb97-8596-4bef-45bd-08df1781db42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 01:44:20.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4EonPaDpClk+ncMgywZCISxWhqZRdcD4rvlO/ScNJwwdhhsgk0hGTzVXzLqAdQKL7GCzodGwpNfbqXYODHLbTTMXIu6dsbEYVlgrOXbyYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16129

DQpIaSBKb25hdGhhbiwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz4NCj4gU2VudDogMjAgU2VwdGVtYmVyIDIwMjYgMTg6MzkNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA0LzhdIHRoZXJtYWwvZHJpdmVycy9yZW5lc2FzL3J6ZzNzOiBBZGQgUlovRzNMIFRT
VSBzdXBwb3J0DQo+IA0KPiA+IEFkZCBhIGNvbmRpdGlvbmFsIHNjaGVtYSBjb25zdHJhaW50IHNv
IHRoYXQgJyNpby1jaGFubmVsLWNlbGxzJyBpcw0KPiA+IHJlcXVpcmVkIHdoZW4gdGhlIGNvbXBh
dGlibGUgc3RyaW5nIGlzICJyZW5lc2FzLHI5YTA4ZzA0NS1hZGMiLg0KPiA+DQo+ID4gVGhpcyBp
cyByZXF1aXJlZCBiZWNhdXNlIHRoZSBSOUEwOEcwNDUgQURDIHNlcnZlcyBhcyBhbiBJSU8gcHJv
dmlkZXIsDQo+ID4gYWxsb3dpbmcgZXh0ZXJuYWwgaGFyZHdhcmUgY29uc3VtZXIgbm9kZXMgKHN1
Y2ggYXMgdGhlIFRTVSkgdG8NCj4gPiByZWZlcmVuY2UgaXRzIGluZGl2aWR1YWwgY2hhbm5lbHMu
IFRoZSAnI2lvLWNoYW5uZWwtY2VsbHMnIHByb3BlcnR5DQo+ID4gbXVzdCBiZSBwcmVzZW50IHNv
IGNvbnN1bWVycyBjYW4gY29ycmVjdGx5IHNwZWNpZnkgdGhlIGNoYW5uZWwgaW5kZXggaW4gdGhl
aXIgJ2lvLWNoYW5uZWxzJw0KPiA+IHBoYW5kbGUgcHJvcGVydHkuDQo+ID4NCj4gPiBGaXhlczog
YTMxNTJlNWM3NDJjICgiZHQtYmluZGluZ3M6IHRoZXJtYWw6IHI5YTA4ZzA0NS10c3U6IERvY3Vt
ZW50DQo+ID4gdGhlIFRTVSB1bml0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBJIHRoaW5rIHBlcmhhcHMgdGhlIGRlc2Ny
aXB0aW9uIHNob3VsZCBpbmNsdWRlIHdoeSB0aGlzIG9ubHkgYXBwbGllcyB0byB0aGlzIHBhcnQg
LCBhbmQgbm90IG1vcmUNCj4gZ2VuZXJhbGx5IGJ1dCBvdGhlcndpc2UgdGhpcyBpcyBmaW5lIGJ5
IG1lLiAgVGhlIGNvbm5lY3Rpb24gd291bGQgYmUgbW9yZSBvYnZpb3VzIGlmIGl0IHdlcmUgdGhl
IDA0NiBwYXJ0DQo+IHRoYXQgeW91IHdlcmUgc3BlY2lmeWluZyB0aGlzIGZvciBnaXZlbiB0aGF0
IG9ubHkgaGFzIHRoZSBvbmUgY2hhbm5lbC4NCg0KSSBndWVzcyB0aGVyZSBpcyBhIGNvcHkgcGFz
dGUgaXNzdWUgYXMgeW91IGNvbW1lbnRlZCBvbiBUU1UgZHJpdmVyIHBhdGNoDQooInRoZXJtYWwv
ZHJpdmVycy9yZW5lc2FzL3J6ZzNzOiBBZGQgUlovRzNMIFRTVSBzdXBwb3J0KSBpbnN0ZWFkIG9m
DQooImR0LWJpbmRpbmdzOiBpaW86IGFkYzogcmVuZXNhcyxyemcybC1hZGM6IE1ha2UgJyNpby1j
aGFubmVsLWNlbGxzJyByZXF1aXJlZCBmb3IgUjlBMDhHMDQ1Iik/Pw0KDQpSWi9HM1MgQURDIGhh
cyB0b3RhbCA5IGNoYW5uZWxzIG91dCBvZiB3aGljaCBjaGFubmVsIDggaXMgJ2lvLWNoYW5uZWxz
JyBwcm92aWRlci4NCkkgd2lsbCBhZGQgdGhpcyBpbmZvcm1hdGlvbiBpbiBjb21taXQgbWVzc2Fn
ZSB0byBtYWtlIGl0IGNsZWFyLg0KDQpDaGVlcnMsDQpCaWp1DQo=
