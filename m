Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010070.outbound.protection.outlook.com [52.101.228.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD8244692;
	Wed, 19 Aug 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129204; cv=fail; b=pUvTu6ZIkDB1e9aAPGQCV0KpA5WJo7XCD/YyUtRAzz6GsIIitlAiGAmYh7wumhOGNktWkQ6P4RPvu3YC6iKLAMivgSPkXIC2px9t382+HzRaPxX9CNX2i7poaXISwFdgoj1G9xextg1r1zx3BE0aitOdewmJ6ec5rodqU/DParQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129204; c=relaxed/simple;
	bh=nimAgccNKgZD4wPtjULMkSEgORLwvlVw9vFZoQ1O3a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8C20Nor0kt9j0WDfvTDpVTAh9pNUm5NI9QupJHpR2Ud4DEJJWcc+kDTyUuFbH2Pw7XapPyBoKAmJerimmok6NZKu1g01Iud3oWUnFAMLJW6s5vXV7x9oW7vic8fnOaI6bmwjZVZ+i+MPDxSMmQP6PYUsBrx77qk8H7+Vlpqw9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lgyImeCn; arc=fail smtp.client-ip=52.101.228.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lgyImeCn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7oKNQXuUL73cOPkeyAGdopP2IInhYGci2IZMYEm4BWaoGxgIVkwkeMBFY73l1/+LFiCaRbJC0XsbWNlqgZgxgc1UmkcmxJ3XaQpR9Ks/h0JKRUblDrUcwLaIsGh4wEFqq3X/O44pp9yEOzee+Y047CT+mbVYnpPvbiC0PFL0V6chObuoTDmwaTYLSce8zh2oaq9bHkNEDxIaotZBfDmvH5RIcmBZoGuURmItVm2mAehsAo0OKKEqW+6vwrDxPok4tFh7zn5P6hShFa65snS4xEliX1InmkJCo7WbP0zxx4xGvMR7Vs7dd+1HnVPiSemyZel6LfKjohorZ+5TVoV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nimAgccNKgZD4wPtjULMkSEgORLwvlVw9vFZoQ1O3a0=;
 b=ZW9oqVa1KBwvPSudCoWIqD78re0ApFI7yIo4gNXvx9T7Fm7p+bIlLjQNz82EHRBFpdWR3SoUxOmLBLgSvn6db7gbb9+6vCRRV/VmhVLwM5hEjtCBFbquVwP1bqI29IjcvpBQR/4zU8Zh1ZI9F2Q2LqLTlNxo4hjXHSymIo3e/Ox9AQnsOa2xqf3S5Kl8hiMbCVsUMnxpjfq7vnOLdthNGekSJm2JULN6wOy51hyX1zCImFqBaETayo9ikVbOeiN87QQM4F9IrtKfiadsnKS+l6+gzzrlNW1sv/NNAWzyEGcs0n+ARLWuPHuqV6cTw9WFMPlGEKV7mjeWcJL8RfAujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nimAgccNKgZD4wPtjULMkSEgORLwvlVw9vFZoQ1O3a0=;
 b=lgyImeCnSEm1vL8kE+WQRFZVxk3OIc5gvGmxqMlCYe39/HgvUUmVxmvZiLekuG/8sMFYx6iRHVpqxpKouToSXFGEv+fLQG5r7Addmi7iHiVQAa3KBGOxtPsf7iZYvD3YbdN2Wy7zwMSjgcr2nrVoIb+2zCYgWhafQRh6c7YyV3g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8490.jpnprd01.prod.outlook.com (2603:1096:604:196::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:46:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:46:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: "biju.das.au" <biju.das.au@gmail.com>, Bartosz Golaszewski
	<brgl@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "laurent.pinchart"
	<laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"magnus.damm" <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Topic: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready
 driver
Thread-Index: AQHdKlDBTVfG4E7tk0C0Oq35AhSxEbadmQUAgAd2NzCAAAlJAIAAAPGw
Date: Wed, 19 Aug 2026 08:46:37 +0000
Message-ID:
 <TY3PR01MB11346FEB6E2C2D06B625FF0CB86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260812115010.108322-1-biju.das.jz@bp.renesas.com>
 <20260812115010.108322-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
 <TY3PR01MB113464399E7C6C5D6B72A423B86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdU2tP-V9H0QthQ8=orDMxXSsLmzv=krkpn7YgYXCR7+Tw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU2tP-V9H0QthQ8=orDMxXSsLmzv=krkpn7YgYXCR7+Tw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8490:EE_
x-ms-office365-filtering-correlation-id: 0085f286-ceab-4aea-8029-08defdce61dc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|10067099003|11063799006;
x-microsoft-antispam-message-info:
 anGOHRH+4r3so5WWfxETxFxTr7+z+CI4i1GhGPciBUH8g3fIAdHsrtpWfLPKt9C3KXmlRD4ulXdCHW99kedP6zs58dgwCZIT46RxkeY9NCCGofOvkAJ3TY5Aaw38bWozG8PyA8yk3wDlIWg191nXWmjkv9RfL6NtYF1kwUulnoEGQNy8JizYXkt4mdYsTVcVaG8qHCgNS/y1pQdmHC/IKv60pBc31P9rPxS3Z2uYRAVMp2u+p34nI/Tx+1w697dAHy5UEMqKWokifYmJptvk8AqiQGZFTDJYUPBzYp7fsg3Fjb5M46hSOmthi+LDLB/94Rpp24Mj+0ggOBoICcVwKs3NslIZNA1ruYvnYB0mdiO1+VToKEHz4B8ppLnLz6VqIzOzRcy5yo+41hb4pFRZvP2Jh7kzmaceOuUtQxdV4ohSuJ4H3fGQ66X44uq+AfpCa5mGGVboFe5FOmPnq51PvEPYqZs24kKpPTz/bOYl4EmZqskGrou8bqrgIwpwvPOxEZYfQuu6yJIqZHu7rdGOrMZv5KW3rAFJXV4eRlxYduwuILFN7aFl5aCXwRGqa40Vm9dXTPrA6Et2oe6Ah2oJ8foj5x7ebNs1qI6Y5/eTasOJOmfJNYqqq4aEdvz9hiiNsMQRZkYo+LNmb54G1khawgUTylcJYbUQcvKeuup7TFHO8bcfxuPPE5ZP/M/Rc37C+frGhzJBzEvsKSR4dPDdew5WKi+UhThdcnsIVkAavjI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHlHRzJXNlJRbm8raG1paVErbHdYb3d0TitaNkRpT1owRDE0UnBOZjI5ajVz?=
 =?utf-8?B?Nm80emVuWmdYQ3ZKRitCY0k1TVhxMGM1cmQ1eFl3MnhTbWRva2tnSnJuVUR6?=
 =?utf-8?B?NEk1Wmc1d3ZKT2FmRWtCWWhPMWJONTg1VHRSOGpMWnB2d24yeGV6QWVGak5R?=
 =?utf-8?B?R0NibjBhdC9LQUdESEFHVUFwdU1KcG00MVRqd293T1F4QTZ0eU8xakdHcERT?=
 =?utf-8?B?Y05YcjFQa3NBSEkyNHVmN012RVRUVWdJM2IySEhmT1pYY1JVTkhqeENScCtT?=
 =?utf-8?B?aWRpQ3E3a1lPTFRUME53dFRORHB4YlJMUThmSVF6QjFtc2NRcGQ5U0t0S2VM?=
 =?utf-8?B?UnZXOGJLTFdoTm05bng5dWFCS0hmTmhUT0Z0WXd5eC9ZemxxTHJDT0pqMjVa?=
 =?utf-8?B?UnlFa1Zsa25WUTZVbFp6eGNQSS9mV004LzcxeTdSS2dGRVZGZEI1Rkp2MTYx?=
 =?utf-8?B?dUVvejJ3MFQ3RmtNK0h6RGVEdGI5VE1jYjhSL0d3eXorQnJNNU04L2phZEo0?=
 =?utf-8?B?MmV2eU1nVkoyaks4TXRUcEZMcnRXVEcyT0Zmb2VnMW1EcGR2b1NRak12a3d5?=
 =?utf-8?B?UGg2UEpSQkdUZlB1MFJjRng2Y1kvQzdKam1saitxU044VktmYTNFSGl2ZC9P?=
 =?utf-8?B?V2N6ZjdVcUNNM1NZRGhvS0YxSTRKcVZXZFN3aDZWdUw5S3QxQ1Q2MTl2ZVU1?=
 =?utf-8?B?aTlqTkpaNjZrdEJyZituWUdnVFRLNkJHMFJ6WGZvSWNQSjNTVmhDTDVRdnFo?=
 =?utf-8?B?RzhnTlA3azZRUUs1Um1EMXNsWkRkV2lKdnRmNjIySUxoS1RNZjA4QnMyM2d6?=
 =?utf-8?B?d3ROOUUzR1VqU2wxdnlwbG1IUkovZjJjeHdGYlo5a2RIUzdGd0hPY3hpUWIr?=
 =?utf-8?B?cHNndDFSclp6RGszZURwTEwyZlhheVFwUDVFM2s0cjcxTHlESXlHRUFVMUMy?=
 =?utf-8?B?bWl3cy9JYkhvdGk2Zlk3T1Bwd3dKVk5ZMldZMm1MMTBTYXVHSEhBMUFsRjN5?=
 =?utf-8?B?YmJkZjdHTnEvNmE3Rk5zY3FueXlEallITlBLTUMyUlBwZkRCb0toZFhtRldj?=
 =?utf-8?B?R0FuM3kzTVpyd1NQQm5pTGtOeTY4Y1hnUHYxR0xQK1VISG5iL3BUazFIWHE5?=
 =?utf-8?B?Qzc5MWpRYTBvVVRwSFN1TUZMdlE5aDJzUnk2bks1ejNWMUNnQmVyYmExaTZ4?=
 =?utf-8?B?ZUNFNHJsakx3TDZFQnc1c1Q5M1VkTU1vSC9YRW00RkJjQ25nbGhkZTNxazd4?=
 =?utf-8?B?Z1RtWGlCRG1CTlp1NEVYNDQyYWJKNEV5L1VIM0xNUDl5NmFPcmdrc3VxS25z?=
 =?utf-8?B?bUlmYzNBb3A5MmZIOXc0dUVLcTJLNDZBU1JibDhTeUZrWXF6dy9tN0N1anVG?=
 =?utf-8?B?QitRMkRWQ3BjRkxJeGc1UmRhRFFhUk13alVodmd0STdDT250bUpmRWNVSjZU?=
 =?utf-8?B?Qk9lall0TDI5ejhhaVM2Z0RmclhPMERGdGNZN0luVHZqUXBwNmhPd24xMFFR?=
 =?utf-8?B?T0hRMmRYcnNEbUhmTDIwdUZxdnltOHRucGJFc0V0VnFnaVFhaTRPTTdYSkky?=
 =?utf-8?B?enl2di9saHBoSDNGcmJyN1ZoWXRrTVd6NldXNlB2SzEvUElIV0swdFNQb0lR?=
 =?utf-8?B?NTkzTi9ESVluMXh4Vkl4S3poanNGOWdUeXB2N283RUdtazRKbExnVjFFczlQ?=
 =?utf-8?B?UUhROFV6MkFYNUFrclF0ZmNhNUtweWdLYmlXZWRMckd4ZlJSWkJtdlRCbm9l?=
 =?utf-8?B?WVJrMVZiRloyYkFEZys2RU9CMXY0QUxvMkg4SGRjeG9jUG1SS0l5UnYzMjJX?=
 =?utf-8?B?OElPNFNSek9Zb1lrVjE3OHFSTXRDMEVEd2pySjJwOWNRZ0orT2xyc1hTeVFv?=
 =?utf-8?B?QzdEOVlRMDlpQ3ArUENLdC8yU2FkWDN4U2pucTdjNU56WlRXeCswMDZHdllC?=
 =?utf-8?B?VlNvMGsyKzIyLy9STUFIbUNVbk1kS0xzSmEwQ09kLy8vZmxIWi9XUy80a28y?=
 =?utf-8?B?UG9CNFUxenJ5azU5dHFjUWw0VHpDTGpHOGRaNEhleStWZjE2Y1lzWHBaMWdB?=
 =?utf-8?B?anVvcURqdUFIejVCTTA1Z0pEVXFLS2hucVFuY1hQNDVpSWxiVmR2WDgyY05X?=
 =?utf-8?B?dThRb09ybDVGVGhuc0RkK1ZxQW84ZnpWc3VNT0pCdyswdGhBd0k0dFU3eTlR?=
 =?utf-8?B?SHFoMXBIQThuUXhoR28yeTZGOXoyNzB2WXNsZW5qYnk2cGFEc0YrUUxJYVJD?=
 =?utf-8?B?cWxxeUdZN3hPRGQzR1ljVk9YbXpHZk8zeEh5OGt2SHB1c1JGSXQ3WWRRV3Bh?=
 =?utf-8?B?UUFVSUVleit0K3NRNmVnQ0J3YzZWOSthYXJ0RWZMcytyZndrZDJiUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0085f286-ceab-4aea-8029-08defdce61dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:46:37.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk8cre2soucMT/ORK/7de+tGre4xBjOXaVwdUo+BOpcSMD+WfmVR8IF7Ru0l1H7R89Qig0hdw/411GD1f2f0IzMWivGN0meKfcbLTy1dzoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8490

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgZmVlZGJhY2suDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9y
Zz4NCj4gU2VudDogMTkgQXVndXN0IDIwMjYgMDk6NDINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAyLzNdIHBvd2VyOiBzZXF1ZW5jaW5nOiBBZGQgUmVuZXNhcyBSWi9HM0wgUG93ZXIgUmVhZHkg
ZHJpdmVyDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gV2VkLCAxOSBBdWcgMjAyNiBhdCAxMDox
OCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IEZy
b206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+IE9uIFdlZCwgMTIg
QXVnIDIwMjYNCj4gPiA+IGF0IDEzOjUwLCBCaWp1IDxiaWp1LmRhcy5hdUBnbWFpbC5jb20+IHdy
b3RlOg0KPiA+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+IEFkZCBhIHBvd2VyIHNlcXVlbmNpbmcgZHJpdmVyIGZvciB0aGUg
UmVuZXNhcyBSWi9HM0wgUFdSUkRZDQo+ID4gPiA+IG1vZHVsZSwgd2hpY2ggc2lnbmFscyBwb3dl
ciByZWFkaW5lc3MgZm9yIHZhcmlvdXMgSVBzIChVU0IsIERTSSwNCj4gPiA+ID4gQ1NJIGV0Yy4p
IG9uIHRoZSBTb0MuIFRoZSBkcml2ZXIgYmluZHMgYXMgYW4gYXV4aWxpYXJ5IGRldmljZSB0bw0K
PiA+ID4gPiB0aGUgcGFyZW50IFNZU0MgZHJpdmVyLCB1c2luZyBpdHMgcmVnbWFwIHRvIHRvZ2ds
ZSB0aGUNCj4gPiA+ID4gU1lTX1BXUlJEWV9OIHJlZ2lzdGVyIGJpdHMsIGFuZCBleHBvc2VzIHt1
c2IsZHNpLGNzaX0tcHdycmR5IHB3cnNlcSB0YXJnZXRzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0K
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3NlcXVlbmNpbmcvS2NvbmZpZw0KPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3Bvd2VyL3NlcXVlbmNpbmcvS2NvbmZpZw0KPiA+ID4gPiBAQCAtMjcsNiAr
MjcsMTUgQEAgY29uZmlnIFBPV0VSX1NFUVVFTkNJTkdfUUNPTV9XQ04NCj4gPiA+ID4gICAgICAg
ICAgIHRoaXMgZHJpdmVyIGlzIG5lZWRlZCBmb3IgY29ycmVjdCBwb3dlciBjb250cm9sIG9yIGVs
c2Ugd2UnZCByaXNrIG5vdA0KPiA+ID4gPiAgICAgICAgICAgcmVzcGVjdGluZyB0aGUgcmVxdWly
ZWQgZGVsYXlzIGJldHdlZW4gZW5hYmxpbmcgQmx1ZXRvb3RoIGFuZCBXTEFOLg0KPiA+ID4gPg0K
PiA+ID4gPiArY29uZmlnIFBPV0VSX1NFUVVFTkNJTkdfUkVORVNBU19QV1JSRFkNCj4gPiA+ID4g
KyAgICAgICB0cmlzdGF0ZSAiUmVuZXNhcyBQb3dlciBSZWFkeSBzZXF1ZW5jaW5nIGRyaXZlciIN
Cj4gPiA+ID4gKyAgICAgICBkZXBlbmRzIG9uIFNZU0NfUlogfHwgQ09NUElMRV9URVNUDQo+ID4g
PiA+ICsgICAgICAgc2VsZWN0IEFVWElMSUFSWV9CVVMNCj4gPiA+DQo+ID4gPiBDb3VsZCB0aGlz
IGNhdXNlIGNpcmN1bGFyIGRlcGVuZGVuY3kgcHJvYmxlbXMgd2l0aCAuLi4NCj4gPg0KPiA+IFlv
dSBtZWFuIHRoaXMgdG8gYmUgZml4ZWQgYXM/Pw0KPiA+DQo+ID4gZGVwZW5kcyBvbiBTWVNDX1Ja
IHx8IChDT01QSUxFX1RFU1QgJiYgQVVYSUxJQVJZX0JVUykNCj4gPg0KPiA+IFNvIHRoYXQgdGhl
cmUgd29uJ3QgYmUgYW55IGJ1aWxkIGlzc3VlIHdpdGggQ09NUElMRV9URVNUIGZvciBBdXhpbGlh
cnkNCj4gPiBidXMgQVBJJ3MNCj4gDQo+IFNvcnJ5IGZvciBiZWluZyB1bmNsZWFyOiBwcm9iYWJs
eSB0aGUgdGhyZWUgZXhpc2l0aW5nICJkZXBlbmRzIG9uIEFVWElMSUFSWV9CVVMiIHNob3VsZCBi
ZSBjaGFuZ2VkIHRvDQo+ICJzZWxlY3QgQVVYSUxJQVJZX0JVUyIuDQoNCkdvdCBpdC4NCg0KV2ls
bCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+ID4gPiA+
ICsgICAgICAgaGVscA0KPiA+ID4gPiArICAgICAgICAgU2F5IFkgaGVyZSB0byBlbmFibGUgdGhl
IHBvd2VyIHNlcXVlbmNpbmcgZHJpdmVyIGZvciB0aGUgUmVuZXNhcw0KPiA+ID4gPiArICAgICAg
ICAgUG93ZXIgUmVhZHkgc2lnbmFscy4gVGhpcyBkcml2ZXIgaGFuZGxlcyB0aGUgcG93ZXIgcmVh
ZHkgc2lnbmFscw0KPiA+ID4gPiArICAgICAgICAgcmVxdWlyZWQgdG8gcG93ZXIgb24gdGhlIHZh
cmlvdXMgSVAncyBvbiBSWi9HM0wgcGxhdGZvcm0uDQo+ID4gPiA+ICsNCj4gPiA+ID4gIGNvbmZp
ZyBQT1dFUl9TRVFVRU5DSU5HX1RIMTUyMF9HUFUNCj4gPiA+ID4gICAgICAgICB0cmlzdGF0ZSAi
VC1IRUFEIFRIMTUyMCBHUFUgcG93ZXIgc2VxdWVuY2luZyBkcml2ZXIiDQo+ID4gPiA+ICAgICAg
ICAgZGVwZW5kcyBvbiAoQVJDSF9USEVBRCAmJiBBVVhJTElBUllfQlVTKSB8fCBDT01QSUxFX1RF
U1QNCj4gPiA+DQo+ID4gPiAuLi4gZS5nLiB0aGlzLCBkdWUgdG8gYSBtaXggb2YgKGEgbG90IG9m
KSBzZWxlY3RzIGFuZCAob25seSB0aHJlZSkgZGVwZW5kcz8NCj4gPg0KPiA+IEkgYmVsaWV2ZSB0
aGlzIHNob3VsZCBnaXZlIGJ1aWxkIGVycm9yIGlmIENPTVBJTEVfVEVTVCBlbmFibGVkIGZvcg0K
PiA+IHRoaXMgZHJpdmVyIFdpdGhvdXQgQVVYSUxJQVJZX0JVUyBlbmFibGVkPz8NCj4gDQo+IFBv
c3NpYmx5LCBhcyB0aGUgYXV4aWxpYXJ5IGJ1cyBkb2Vzbid0IHNlZW0gdG8gZGVmaW5lIGR1bW1p
ZXMgaW4gY2FzZSBBVVhJTElBUllfQlVTIGlzIG5vdCBlbmFibGVkLg0KPiANCj4gR3J7b2V0amUs
ZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0N
Cj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEz
MiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dCB3aGVu
IEknbSB0YWxraW5nIHRvDQo+IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMNCg==
