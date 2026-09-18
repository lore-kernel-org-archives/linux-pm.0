Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011013.outbound.protection.outlook.com [52.101.125.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E844E2F1A;
	Fri, 18 Sep 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729416; cv=fail; b=KznmBG8e7noj7gIUe4Jy7LyV2pSYM9JNwo2+9oy5oYByBl2/DqM79iu8NDV3eab8rEqigWQ3MVC+nzqg5ueUr4stvlhsBme3fK/v+F2zay30WYS2IwaWlEKXluuYYbHN0FoFPJlLYJAbFkxORDB9C0zfRWEZs1uXL+q72h5ePaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729416; c=relaxed/simple;
	bh=ZbK06od7QrPIbetUkZ0yyP+JrFbpeUndNuyW9NsCJsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KY0Xn8T1BQ9aB5Ayrme1GEcoiiZLIaiL1tH3Yrnfkd9utT01xPezIdKWxWw1wQbxWWYIDkWwtvHy/MS8bSJAg8R6Xmvqd79rYR6I6Qltghs+q5uUhOj84ReKnhLUnNoFjX3h+HZFZQZu1M4F+twFN2cfq9uPMVjKaMllLhfxIf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Vgd6To8a; arc=fail smtp.client-ip=52.101.125.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Vgd6To8a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpcBqzqjvTRlrXTUVxyUTs5s/NVhjCocXryHpFZcvjLIgrhqoYwwWU4+n1CmS49psGooMrotF6G4KOc4k3i7yAUwuNwa1x0wXTzgZMO7eneVZ/BWoHQUfHgW0QrkF1m6X/Ttxta41jFfk0VLfptg5mDMwu4c8+3Akyemy9yyapAjgseXBBg/mD+yw6wk5ctpp7mSvpOli15Kn8uYUItbm1PhFXz72Kq5I0b9fIM5uzj0Gy2+x9Ye9hv63dc2Fc2CuRO9XdSxpgPzMT3neLzaYJEwoDxT3WwaWWq2AL7zaCwiWKnvxFe5z16BiDLaLLKW3v3WhrV5Kf3rby/YmMMyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbK06od7QrPIbetUkZ0yyP+JrFbpeUndNuyW9NsCJsg=;
 b=Vz1TY5XkSvViTCoeg36Ie5Jp0iEpHSmzEBfrUxiogOIb6o4PPDBzE4y8t+yjWrPWg8zwrLIfUoIV9OISTgVAHIq7YMbTcJYy/a7bjvbX4CXKSNjwKEWS8N3hbRzn+tBXPIpoSkMPfH8iK68wX8fc5CVegRWxJiN/HRb3jSgCfF1j4mZy7dh7r179BE5WQUGei6Ly7KfTqrKzhfElvFjeExcEdrd59wvICKNxAyGS2NdAUpX+Qbgn9gVX3baArqePu3EmFZN/Ly3/AzEW4JvmHml7q96U0hATUEvlQgsGfN/ZG+okna7H8o+XcK6Vs4QamknGOqFHNkOVZxftdEL4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbK06od7QrPIbetUkZ0yyP+JrFbpeUndNuyW9NsCJsg=;
 b=Vgd6To8alYjtInf2UcSAjRNl9v1NPz9SyiT4Tr0vaEF6LuUUWKLseQqTKu0V4KfBDy7vk3qmO1hvcLkmOVcoZEUN6wW5wRRNu+0+DTCDh9wb44+xxXAAFN31XM09Muj9l1+2rPvSGcMu+296wLQRdzEGIUs7XPXhtHT8ed9HALA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7852.jpnprd01.prod.outlook.com (2603:1096:604:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:03:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:03:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
	<bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, Ulf
 Hansson <ulfh@kernel.org>, "laurent.pinchart"
	<laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: RE: [PATCH 07/10] media: rcar-fcp: Handle resets
Thread-Topic: [PATCH 07/10] media: rcar-fcp: Handle resets
Thread-Index: AQHdRp3mCxXFrz2IzU+X9ezmKYJ2XLbUK1MQ
Date: Fri, 18 Sep 2026 11:03:25 +0000
Message-ID:
 <TY3PR01MB113464309AC8B77BA471A31DC86872@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-7-4c72d4e086dd@ideasonboard.com>
In-Reply-To:
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-7-4c72d4e086dd@ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7852:EE_
x-ms-office365-filtering-correlation-id: 68355663-c701-49fb-c9ec-08df1574764e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|4143699003|5023799004|11063799006|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 fHZcQIZfMLXCk2bAPa9lpDYrNuuyXxLMCvUPS9Bmfm0ULtxbX7spBGWaPA4a9jI8gWU1NBpKYAYAQRf05qrP9cnQM0qblKPa1aBfxtTalBm9R5GQX1lbeQGTWSruDj8EUBsiyG3mi52AC4xO9c2ZtnCfM91jQlFLdeoLcCN7aIKUlJhaRbPXCG0PS6yYyo2hrtggC+3D9ZUPEsxnrrjvI2pevA9sZKQvSwv07ZdtGUIJUEa16gg8kGx4IwoV3xrwYqpWTXSR9l189c7hiI7KAQc0ws/3DTD7X/2VHEwrNGq2R1aWBUXabS1tzAhtXdUQOkND7/wHHiqzuqyPLL2hFLQQhgh+oAiVsnckON4k6ZN9tx6cV6iS2I09XhK2cCzsd+HW/FpBQUx6YpgJGCKG1UljEic3N6z5478QXJm7ot+ve9IKfIDxlwhzo1ZENnT/kqT3qN7qr7gvMX5obsnhRhZtigH7KCIMetkENTBOZKtvePO+Bbpv7h4WnGO0cJXxfNi7AoTw2yAAC8jdUPs1aOoeovd3S8vg2LUaCBVW+mwrlai39gWBINk1jkEXSOiIeGEX+XHu4jDW8uVprc4U0vJRYNlGfbmqGPymnv9rlyPZsurnqFLONCAQzkMjomccOBTBLZTM4uFaZBV5z+K4pARUigkLzS8US48FFchOwhN8jj7mxMsLPS2JamKyakNHZlJojJCm5t4+nCEpRWxiKGHfTdvXw2F1q+xTCc4JydI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(921020)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekRDUzVQaDQ3d2dCNXB3VTcvbHBWeGRMY3pyN3NnOGZ5bFZxZHM0UmRyVlhT?=
 =?utf-8?B?U3doOW5RM1RTNUhNUEVReVpOeTRpMVdyc0FZQkg3MDlJSW1mMHVhclViU3Aw?=
 =?utf-8?B?KzRrVzd4c0dZM0puak16Mm8raHVtZ25COEx2UWEzcjdNOTl5QUZ0bHlyT3lF?=
 =?utf-8?B?RFdWbFVWMDNYZ2lxdEF2WFhjNlI1Qy8xdk5iRktMWGJqc3ZLcGRxN2dORjBo?=
 =?utf-8?B?SnFoREVWRnhxYUxoRFFFclFJdjN2aWx6ZkhtWSt1Vjhhc05hc1RsUTBweWVF?=
 =?utf-8?B?K0kweHJOeTJ3NVoxRDg4ekFPMWJrVmFTWEdRSEp4R3JVVkkrUjBDMGN3dVh6?=
 =?utf-8?B?WWo5TElJc0tRUEFJU0RQT1JiQTNURXlEc2dHQnVEN3ByTGhWZDNDV3JYREVC?=
 =?utf-8?B?TEIzOFRuODFmWmsvdFBaejZLMTZhQUFUc2FqTjMvUk1uVkZ5UmViTjNwcE4r?=
 =?utf-8?B?VjN1WXZWeElBQ2ZZa3phQzdjWVZlWTRFckIvcGNjR1QxR0RVL1B6czF2L0ll?=
 =?utf-8?B?bUhQRzFNSWFsRDJzTzUxcDR2NkFnc24xWWJ2Ty9KNE9CWW1reVRpREVsaUJl?=
 =?utf-8?B?anBVUlRLdXJjOW5sZjRTWFVGWGVVNFd2UGxFeFgvQmNwREIxeDNkTHZkZnVD?=
 =?utf-8?B?elVpdDI4b2JxaTUxYnhHMC9xWkd4dlgxaHdIZ3JvRVIxWHptOERBOWxib1dm?=
 =?utf-8?B?bTJQYk1vSzZHRWE3U3VaSUQ1MG9mZ2txNGhIQS8vampGeUUzZC9GRkgweWlB?=
 =?utf-8?B?cjJxeEtLcGV0cmQxeWt6Q3JKUEI2cVV3UUdqa2hpT2RlTVhWMG1Oa213ZlZR?=
 =?utf-8?B?dXlhSWtta1BrODVhT2xMRitITUtuc1IzK2t5K3VudlRDN0l3SDAzclJvR3Vt?=
 =?utf-8?B?RnVQUmc4OUhpM09QS2FsR1EwYW1jN3drc1RZSEk4czZ6KzF4RW1makpPYk5T?=
 =?utf-8?B?dlRMc2Z3amNKMHdOSXoyR2JQdFdsU2QvS05pd0pkZFhjZXhCdlJMUTA4K3ZY?=
 =?utf-8?B?RXE0ZXBWRkF0MXZDT2ZXVksrczQxTnkvRGp4VDQzb0FiZlpCaFllNFFxSm5S?=
 =?utf-8?B?L2lxeU1CQk9xbnVhZHYyNERuS0RxUWVvVzQ2TkwvUXcrUGU2bVVjZVowdWpj?=
 =?utf-8?B?dDAvdmFrU3NSOWRrNTZqdVBXSW5PalVxbmhZNmowb2ltRVpnS1lzRW4xRXlj?=
 =?utf-8?B?R3J6WUlEUVF6YXByakRTSjRja3FsNFRVZllLTktxWlh4RHUxQjRPaGV2dzA2?=
 =?utf-8?B?ckI5V2FWWWttaEFKRlp6ZHViR2JrWXpaNDV6aVRLN1ducUlSSjNjYWVvVGhi?=
 =?utf-8?B?NkExNFpKbXhsV2VpUGV3SlFBZkFGUTFPV3FCNFF6K09zUGpmaWxGZTAxLzJK?=
 =?utf-8?B?Z3NjeWNNV1ZMelEzWFk0bmJYQmZTWDZrcFEwYkZTOEh6WjNjSTVQR1BSMEJS?=
 =?utf-8?B?R0tmUlFLZzFkT09MYUhlWFRPbFJvSERxWFV2Q3NrS3ZENS9nK2EzUkJ1bFdF?=
 =?utf-8?B?OWFzTjRSTjJTK0JEeHRUSEFWOHhsNUcyNGxYS0VISnlKKy9IUlRqTkpuSWNn?=
 =?utf-8?B?MS9Yd29OQzNGT3ZYY3pwc3NQYTVUek9rNVNHSHZ5a0U5TzFHTFhwWGx3WHlH?=
 =?utf-8?B?b0syOUdCczJST3h6WkYxc2U5VzRXSWNrUkFkSzNHd0V6MjR1M0lCWjcvODEw?=
 =?utf-8?B?V1RuY3dvbndCWlNMejNKZTZucWVUb2xKRFQxYUxJNkNTRkZiaUUrNHB6NWRz?=
 =?utf-8?B?dmN0V000c3JZaGRYbE9XTVFQMEp6VTZQbldUZ2tzc1dvL0QzdUJMSG5KODU1?=
 =?utf-8?B?dVVWTGVZSkFMVlJYZlpJT3VDWFlHanJ0R1VSVDRZalRnQ3duamt2M2l2NzJp?=
 =?utf-8?B?UjYydGZ0TUtaVjYvM1VhSkR6U1M3Z2F4YjMwQWQ0ZnlEUWdnbjRZMllNMkJu?=
 =?utf-8?B?YmxRQ2FUK1NuYjZidnF0cm5ieHpWVU8wZ1Yrc0YwVlFiTTU1d0hmMFpDZFhu?=
 =?utf-8?B?OERBWGNJMFREZDdsdndOWVErWmdjV09KNDJySmVmZHhrRkxtQ09OYlpsUGRV?=
 =?utf-8?B?TUMrSWdsdEEydjZyd3JzNnJ0NCtkZm0rSGFnNmlTNkxCRGF0US93Si9kV2w5?=
 =?utf-8?B?MW1ZVkZ2Rk9OWFlNZVFWV0FoRVd0cUpEcVhOZXpiTWcrNUtkc2JNY3BQQ1pJ?=
 =?utf-8?B?ekF0S3N6WmZoYi9MOFBiM3YxcERmd2hHTHl0Q2tCam9pM29LbW1qRVczZDZj?=
 =?utf-8?B?NTZrV1lORTJ6dENWZW1CK25jUUoyTjJNNnhGcDZhRlBkR2M0b0h3Yk9rSi94?=
 =?utf-8?B?MkU1S29VMldFaVkvZlVoeklkSlJyYWlRSlMvRWExZ0hreFFNUXZVUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68355663-c701-49fb-c9ec-08df1574764e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 11:03:25.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7yAyXBX7Jw65epxuQffJeO/cgz90K6YrFmL6RdUB1AMqREBakAsexIWQu29PLnBPG6FdMNwROyaMwil8P0YdVbHd8aoEfq3mZDfe9zVpuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7852

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUGF1bCBFbGRlciA8cGF1bC5lbGRlcityZW5lc2FzQGlkZWFzb25i
b2FyZC5jb20+DQo+IFNlbnQ6IDE3IFNlcHRlbWJlciAyMDI2IDEzOjA1DQo+IFN1YmplY3Q6IFtQ
QVRDSCAwNy8xMF0gbWVkaWE6IHJjYXItZmNwOiBIYW5kbGUgcmVzZXRzDQo+IA0KPiBbWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHBhdWwuZWxkZXIrcmVuZXNhc0BpZGVhc29uYm9hcmQu
Y29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4gaHR0cHM6Ly9ha2EubXMvTGVh
cm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE9uIHNvbWUgdmVyc2lvbnMgb2Yg
dGhlIEZDUCwgc3VjaCBhcyB0aGUgb25lIG9uIHRoZSBYNUgsIHJlc2V0IGNvbnRyb2wgaXMgcmVx
dWlyZWQgdG8gb3BlcmF0ZSB0aGUgRkNQLg0KPiBBZGQgc3VwcG9ydCBmb3IgaGFuZGxpbmcgcmVz
ZXRzIG9wdGlvbmFsbHksIHRvIGNvbnRpbnVlIHN1cHBvcnRpbmcgdmVyc2lvbnMgdGhhdCBkbyBu
b3QgcmVxdWlyZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwgRWxkZXIgPHBhdWwuZWxk
ZXIrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vcmVuZXNhcy9yY2FyLWZjcC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9yZW5lc2FzL3JjYXIt
ZmNwLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3JlbmVzYXMvcmNhci1mY3AuYw0KPiBpbmRl
eCBkOTliM2ZmOTc2ZTgwZjI3NWFmMTllNWRjMDJjNmUxZGU5OGMzOGEzLi4xNWJjYmJkYTNiODUz
ZjcxNzgwYWFlODc2ZjY0NDBiMzNhZGRmMTkzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL3JlbmVzYXMvcmNhci1mY3AuYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL3JlbmVzYXMvcmNhci1mY3AuYw0KPiBAQCAtMTgsNiArMTgsNyBAQA0KPiAgI2luY2x1ZGUg
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0eS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3Jl
c2V0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiANCj4gICNpbmNsdWRlIDxtZWRp
YS9yY2FyLWZjcC5oPg0KPiBAQCAtNjMsNiArNjQsOCBAQA0KPiAgI2RlZmluZSBSQ0FSX0ZDUF9S
RUdfQkFfUkVGX1kyICAgICAgICAgICAgICAgICAweDAxMTgNCj4gICNkZWZpbmUgUkNBUl9GQ1Bf
UkVHX0JBX1JFRl9DICAgICAgICAgICAgICAgICAgMHgwMTFjDQo+IA0KPiArc3RydWN0IHJlc2V0
X2NvbnRyb2w7DQo+ICsNCj4gIGVudW0gcmNhcl9mY3BfdHlwZSB7DQo+ICAgICAgICAgUkNBUl9G
Q1BGLA0KPiAgICAgICAgIFJDQVJfRkNQViwNCj4gQEAgLTczLDYgKzc2LDcgQEAgc3RydWN0IHJj
YXJfZmNwX2RldmljZSB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgICAgICAg
IHZvaWQgX19pb21lbSAqYmFzZTsNCj4gICAgICAgICBlbnVtIHJjYXJfZmNwX3R5cGUgdHlwZTsN
Cj4gKyAgICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0YzsNCg0KWW91IGNvdWxkIGRyb3Ag
dGhpcyBnbG9iYWwgdmFyaWFibGUuIFBsZWFzZQ0KU2VlIGJlbG93Lg0KDQo+ICB9Ow0KPiANCj4g
IHN0YXRpYyBMSVNUX0hFQUQoZmNwX2RldmljZXMpOw0KPiBAQCAtMjYyLDEyICsyNjYsMTkgQEAg
c3RhdGljIGludCByY2FyX2ZjcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgICAgICAgIGZjcC0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gICAgICAgICBmY3AtPnR5cGUgPSAo
ZW51bSByY2FyX2ZjcF90eXBlKWRldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4g
DQo+ICsgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZmNwKTsNCg0KVGhpcyBjYW4g
YmUgbW92ZWQgYWZ0ZXIgdGhlIHVzZXIuDQo+ICsNCj4gICAgICAgICBmY3AtPmJhc2UgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ICAgICAgICAgaWYgKElTX0VS
UihmY3AtPmJhc2UpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZmNwLT5iYXNl
KTsNCj4gDQo+ICAgICAgICAgZG1hX3NldF9tYXhfc2VnX3NpemUoZmNwLT5kZXYsIFVJTlRfTUFY
KTsNCj4gDQo+ICsgICAgICAgZmNwLT5yc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRp
b25hbCgmcGRldi0+ZGV2LCBOVUxMKTsNCg0KcnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRf
b3B0aW9uYWwoJnBkZXYtPmRldiwgTlVMTCk7DQoNCj4gKyAgICAgICBpZiAoSVNfRVJSKGZjcC0+
cnN0YykpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2
LCBQVFJfRVJSKGZjcC0+cnN0YyksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiZmFpbGVkIHRvIGdldCByZXNldCBjb250cm9sXG4iKTsNCg0KDQogICAgICAgcGxhdGZv
cm1fc2V0X2RydmRhdGEocGRldiwgcnN0Yyk7DQoNCg0KDQo+ICsNCj4gICAgICAgICBwbV9ydW50
aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCj4gICAgICAgICByZXQgPSBwbV9ydW50aW1lX3Jlc3Vt
ZV9hbmRfZ2V0KCZwZGV2LT5kZXYpOw0KPiAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiBAQCAtMjgz
LDggKzI5NCw2IEBAIHN0YXRpYyBpbnQgcmNhcl9mY3BfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gICAgICAgICBsaXN0X2FkZF90YWlsKCZmY3AtPmxpc3QsICZmY3BfZGV2
aWNlcyk7DQo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZmY3BfbG9jayk7DQo+IA0KPiAtICAgICAg
IHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGZjcCk7DQo+IC0NCj4gICAgICAgICByZXR1cm4g
MDsNCj4gDQo+ICBlcnJvcl9wbV9wdXQ6DQo+IEBAIC0zMDUsMTEgKzMxNCwzMiBAQCBzdGF0aWMg
dm9pZCByY2FyX2ZjcF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAg
ICAgICBwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ICB9DQo+IA0KPiArc3RhdGlj
IGludCBmY3BfcG1fcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiArICAg
ICAgIHN0cnVjdCByY2FyX2ZjcF9kZXZpY2UgKmZjcCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
DQpzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAr
DQo+ICsgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoZmNwLT5yc3RjKTsNCj4gKyAgICAgICBy
ZXR1cm4gMDsNCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGZjcF9wbV9ydW50aW1lX3Jlc3Vt
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gKyAgICAgICBzdHJ1Y3QgcmNhcl9mY3BfZGV2aWNl
ICpmY3AgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArICAgICAgIHJlc2V0X2NvbnRy
b2xfZGVhc3NlcnQoZmNwLT5yc3RjKTsNCg0KQXNzZXJ0IHRoZSByZXNldCBpbiBjYXNlIG9mIGZh
aWx1cmUuDQoNCkNoZWVycywNCkJpanUNCg0KPiArICAgICAgIHJldHVybiAwOw0KDQoNCj4gK30N
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGZjcF9wbV9vcHMgPSB7DQo+
ICsgICAgICAgUlVOVElNRV9QTV9PUFMoZmNwX3BtX3J1bnRpbWVfc3VzcGVuZCwgZmNwX3BtX3J1
bnRpbWVfcmVzdW1lLA0KPiArTlVMTCkgfTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgcmNhcl9mY3BfcGxhdGZvcm1fZHJpdmVyID0gew0KPiAgICAgICAgIC5wcm9iZSAg
ICAgICAgICA9IHJjYXJfZmNwX3Byb2JlLA0KPiAgICAgICAgIC5yZW1vdmUgICAgICAgICA9IHJj
YXJfZmNwX3JlbW92ZSwNCj4gICAgICAgICAuZHJpdmVyICAgICAgICAgPSB7DQo+ICAgICAgICAg
ICAgICAgICAubmFtZSAgID0gInJjYXItZmNwIiwNCj4gKyAgICAgICAgICAgICAgIC5wbSA9IHBt
X3B0cigmZmNwX3BtX29wcyksDQo+ICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBy
Y2FyX2ZjcF9vZl9tYXRjaCwNCj4gICAgICAgICAgICAgICAgIC5zdXBwcmVzc19iaW5kX2F0dHJz
ID0gdHJ1ZSwNCj4gICAgICAgICB9LA0KPiANCj4gLS0NCj4gMi40Ny4zDQo+IA0KDQo=
