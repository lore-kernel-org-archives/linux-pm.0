Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA225C804;
	Mon, 17 Aug 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978846; cv=fail; b=F9D+lr4Te3e91L84fDVbxBEq/GrdeWgcTJfsgp6/JZu9mBig78x6i1AdXa83MJM/WVhkFwZTsssC2WpXfzpxp0RXYl/oN1SqR1PlXWFt4ChE9PLh27jkltw/YL7pSxuManKUKFc/kYMnXFlKskghNYj5baNgKKSa1om5vP5kx88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978846; c=relaxed/simple;
	bh=uftysfCtNE7arEWriLKNawollBnECNcVPcAeLIZe1BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RX/FeGYglGD9ezj6ZGfh7B9wFcJjOfiGhyUimcJWsl4jfSKEgab63fAj91topFDusEopdyRnNe41AOPlRnNq0FqGFCF0bHqdtJrn8THpzFftcxJHHv1PQmRy66+4IoBaN29MK/Nh2r50JIdCoCYjt8OdVyaqnbuZt/CHHodk7vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PwGV5Vgd; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PwGV5Vgd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGG4BHKqd4Wv/FJbFM33KlWOrs5etA7lCfUbfg88h1+8mfUV2sq/WvXHW8mhxgcpnWN0YGgdWajjR06NnYLb//JIPCHl6/Opbpxk9odCZR8plZHv+Cqd9kCPd+e6WSlYoAvXjutBAaX9v8ls9Ga/k9ZjS6RP2Ka4CVbemkMNd4JPqHZsmD78HzMh59h0IhAYvLm1BTvq7ktf5lT3BlUwDSndmChiwLdPTJIMhE5W2lK9IiVqL9oRq2Zs3sJxAIfwC1H3mHF98sKjdHZOCHnjWEc2FePPByFxl6/ow8TDqIUdw4R62N/77P2FFO8DoiOQ6ePHPGbmyalx9XG3IQ9/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uftysfCtNE7arEWriLKNawollBnECNcVPcAeLIZe1BM=;
 b=gSI6klATaI3u9z/K6jeL4yFPHQ9eWhUy9ZlcBuexABDxaJ/5cimHVR9zMdDoVYI9fML7gB51bSegd3stWZ7moaCgWhT6nmaHBsvWFzs5fwFCC2nx+N/LEyLq3d0Uto22yYEp4lEw7iYOAI517hcyV8NmHTFe6VIpXdMG7/k1qCb9xnQJudWncEt5iEJQbsAtGdXz54xxLwKlq6ieNikGviMb6bUSl5WCoV4hAqpeAhx1CBinjhUXOYKSBrz1LNHjxCmaM60dSQ37ybrOkHz0TCADAP2jMXw4KhNWyAxDZ+985IpDZp77Amc88kxWB0Znc+OinSpM7r5bIFWyZoU0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uftysfCtNE7arEWriLKNawollBnECNcVPcAeLIZe1BM=;
 b=PwGV5VgdRo+Da9TOKbLtVnwG0urTpCYV5FTxmO64grP5MfA/T6JjdBvr9O4vDsKnK2V0CJ2OQNepLbm5flo4mVppDr2Pek4qCLgYGFC5W4eBpZyuYehbV01WzOo4pLrka4j+3Lp0ykJHKZoHQxN29DRcYfaTrWGrwpQFqmIeEOQ=
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by GVXPR02MB10968.eurprd02.prod.outlook.com
 (2603:10a6:150:215::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:00:39 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::7e4e:c249:e481:d43%2]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:00:39 +0000
From: Henrik Grimler <Henrik.Grimler@axis.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: Kernel <Kernel@axis.com>, Alexander Svarvare
	<Alexander.Svarvare@axis.com>, "sebastian.reichel@collabora.com"
	<sebastian.reichel@collabora.com>, "afd@ti.com" <afd@ti.com>,
	"dmurphy@ti.com" <dmurphy@ti.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"pali@kernel.org" <pali@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "chris@lapa.com.au" <chris@lapa.com.au>,
	"sre@kernel.org" <sre@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: power: bq27xxx: document bq27z746
Thread-Topic: [PATCH 1/5] dt-bindings: power: bq27xxx: document bq27z746
Thread-Index: AQHdKYdPx4xKzsHqq06tiSD7QGyPOrah5vMAgAB4UIA=
Date: Mon, 17 Aug 2026 15:00:38 +0000
Message-ID: <bbd0548a01d7020947f025f0632a0994f4acd77d.camel@axis.com>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
	 <20260811-bq27z746-v1-1-3a4fa38205cc@axis.com>
	 <20260817-talented-brave-clam-f5e6e6@quoll>
In-Reply-To: <20260817-talented-brave-clam-f5e6e6@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PPFBD14D17F4:EE_|GVXPR02MB10968:EE_
x-ms-office365-filtering-correlation-id: 6412e388-5ee6-464c-3579-08defc704cf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|38070700021|10067099003|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Kgn9H8/AfI+5CoRwat+UtbtMixQLG5wEaXTNFdLV13uPRX+o08y18u4jgoUdk+KZwb4M/vewUMcPhziZ7EfESLqy6pu0Wc4h1bTB5NB9o6gv4WEb3bz/OotybwuqIqqBM3JP7B1JXMrmUbYhb4OFGYjQ1HSK/5ePy9SMI/59IkV7n/UdBdeU1rCybh0RKXW5YptHmuG1n2k/cFCwkHXfjdNx7gVJfn+Jyrg0CdJnzN3AsZvRbHKf8zWbeYpKhPn7fY80lXsFpmWYT1JVSUqwZyY3dMTJr68FUZSDfvG7uhLSY2kdl1MNrTYK6U/8OvIBbYtPHT9bkUXq9pIOrro2IGGUYxw7ifcQby7TkaxVEHZyBXyCmGNgA1VZBOl4x7YIqKpP61y+Uicq/UwiD+3woXuBxEqEQ4L6Fp0PeSmri60AJPJVAsgzkksXGzgttwlS3jiJ7IM7ISCEU7Pq8Ze3Dz0KJAVEvpKF5BgHw83buTwuJBfPt3PDBPCW8/8fvouUyp3g5wE1OJ8rPF7Su3i01tgXtzq458l9++8Rs55nmhsjeb/kiw0R1ZEMChoH45MAE7qPpCMihItbIG84tLryFl1Pr/icWX/PAJQgKDMbkI6joVS35+/E3iuS7UCB9jS8enhJpyTmotxScvyzPYd/eTEreLcQbGZ+wagzbVGmEjz+xD55R5JXQHDvmRopf1tJjKCj+ItCiOM1JS3Hq4JrD1z8MWmeA8iXSWybSQm6qeU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0RIeTdtSThvTW1oYkdmYURpamhtZm5TSXhzRWptSlpjaVlpazE3WW9XdStq?=
 =?utf-8?B?UnhaWXVmTEZJTFkwNlBjOUdYdlZ3QVdvZUNZc0RqTkNYSGZqL2R3ZEZOOTd1?=
 =?utf-8?B?ZGIvRElxRG5CQnI1Nzd6WmwxMndma3RyWDR1RGF6UHUwVzVjY0wyWnpFeFNP?=
 =?utf-8?B?c0IrK1JJVVFLeGR4b3VUbHBneThxZGxwM3ZTRXlWNEtRVGl1d1pQd3J1ejZ2?=
 =?utf-8?B?Ykc3bE9VTUcxUzFBd040NVZJZ2piNkxJb1IvZEdhekR5bFNRbkgyR1BPQm9O?=
 =?utf-8?B?UkRCVHFMQk45bW1GRVlwTTRtNmRxYi8wQW9UNllCaWN0dCtQekRPTGZaK2FX?=
 =?utf-8?B?WjdHR1VkcXMxNUN4NEpjck81eng5V2RqR1FIRkxNdlRzZ05kejJ5aFFJMHI0?=
 =?utf-8?B?aUpTYm16QkpQOWt0c1cxcnZTaTNmdjUwVWdQZUdhcDRFNGMrdHFUVGxGajZl?=
 =?utf-8?B?SVp6SDQ3L01LVmh4eGdPeTI4Mk94SmsxMThFU3NkNzBSMnU2OEg1dkc4TFBC?=
 =?utf-8?B?S0pYN09UdHJBdDFPQ0s0dUJMNS9FWXIzY0YyM1paeG9veDU3ODBrMWhYVUFw?=
 =?utf-8?B?eURlcTRtdlpmWDVNaUtxeU0wY2tBTjdtY2tsZHkvRmhhNkNxNm5qd2luZGpx?=
 =?utf-8?B?dnVRYVBNb3FGRWdPRHNwWmR1UFdab1hWUGljVFo4NU45Y29GamFUWUZidjg3?=
 =?utf-8?B?eG5PV2hEMXJSSWJRQk9YTU81TEtTQmFZb1NGVndqVk9aT2V5dzFDZTJ2eEhX?=
 =?utf-8?B?dWZ3d0QzZUtzOHVHaWxIdVVOcWZBeXE5KytzNGdqUGM0YjZ6YTJSdWJrTjJq?=
 =?utf-8?B?ekdZUDZuS241aURJckpET0tYbFlwOGQ2cFJlZGZGekJTcHJuUjRMWkNLTnBs?=
 =?utf-8?B?RE4rUzdmbGFiSHB1eUtKWHZWOTZET3VnTHB3WTVkQ1hIbG1SQ09FVW9icngz?=
 =?utf-8?B?dUVsU0FzMldNWjJrQVpTVkhTRnZUdVNQb1BjbDM2VzZZeWpiK1g2eTcwUGhD?=
 =?utf-8?B?YUpTUHQzamVBQzczZzRIVzBFM3RZRlAzU3B1M2NWWTAzdXVpam85ektCZWFJ?=
 =?utf-8?B?akdNQkFrK05qdncwMkh1bEozUmNsUVE0YVRlWXBMZmVZV1ZkN2tZRFN1QmtE?=
 =?utf-8?B?cVRpemRzaHFTejV1ZVhOMC9YRGl2K0JZVmNJcnpGYmZBVEJ5YU8rMHVabEZo?=
 =?utf-8?B?cXFXU1lpUGpkanIyM3FteENrWnVFU1dZYjk1dVlqSHIxL2NLY2grSS9yTm04?=
 =?utf-8?B?cmV0anhCSG9DWnBMWXlHZGdZTkRKdlhENG1VMGdvQStBSXlpTDZZeGtKN0Vs?=
 =?utf-8?B?NU91MWwwZUZTOEZHcG5sRFB0aXVHVXN4d1Vzc1R2bHBPaFp2clRYYytpYkdz?=
 =?utf-8?B?bkhscjRlbTlsaHVnaDFpMjR4SFQzMFNmU2xDRitvNDBSRmJRKzVHQmdiZzdF?=
 =?utf-8?B?T1RaRTQ2Z2VadkhEOC9PQ2RNODZTbmt0QTVlVXZhUms4eHJ5Ujk0ZTNyaWdL?=
 =?utf-8?B?TzZ2amZ4dXhNaVRZTG16a0NGVm5Wa3BCVWk1ZUtTbTF4R3RhRmRaMythZXZu?=
 =?utf-8?B?NjFFZ3FXZnNtZWJ1WjQycTJzeHFrZjFOdmd2TEQrSWt1Szg5aVRJOS85UVRW?=
 =?utf-8?B?M2dwWHpQcVVQSWtzNlFBMDA0ZjdCTmZuWkRsU25UdnV5SG1Kb2haUXV6ZnFI?=
 =?utf-8?B?UnJtWGowWUpWczRlNXlqY0oyemR2dGxEanlPcnpuS2xiSUpna3BBRkFaUFRQ?=
 =?utf-8?B?eXNVM01DQWVmVFpmMXFOTEd4ZUMwdjZyWWNzNlhJVEhwMU9OWjltZFJEUW11?=
 =?utf-8?B?UEJ0bHRVUDFQVStOVVFmZytLaG54RzFYN1ZTejl0Y2xwU0JibjBLSFJFVjhZ?=
 =?utf-8?B?VHk0Y0YvQ3Rvb0RuOTZIVFV0L2Q3bHQ3ZGFaUHBpSmZ0NzVsSkdpY2htVk9P?=
 =?utf-8?B?QkVzbmFxMjRGREFoOGppd1J5bmtJUi9oTW5rVnd2c1Y5eCtmTENzVit6M0NW?=
 =?utf-8?B?Mm1oYlFOWUNSc2pqbjJMb3RWdEg5UjJGT3lnUGRndnUxeWpnY3ZHRktYYjhH?=
 =?utf-8?B?RHp2a1RtMTMzekxLVjV5YmVUamE0QU5hWVJ1OTVqVkZTeXBhTXhCd2FaSm5C?=
 =?utf-8?B?ajIxcFdOdkVza3FVSml0a2lvcU5SWmlLbkUrb2FlUmFIMGNSTWtEck9tWFI2?=
 =?utf-8?B?MnZxWHJMUjBpbXRLd3JjUzVvOTZDNUdxY2x2dTlHLzFXQXROSTJFcDZHTGFr?=
 =?utf-8?B?bjkyczBBK1Yva2JDd2FDaXE1ZFVnVEd1bzVZM0NDVzFsZ3VEN080S1BkNnlK?=
 =?utf-8?B?Q3dKZ0VmRHJWRUw4aEpZT2tCb1FVbEhyS2t3RDJpTjJ1b3RsbXhlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F15A6153C2EC140A3AB8B72F31E3D58@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6412e388-5ee6-464c-3579-08defc704cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 15:00:39.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUzPj626s0/Spe0c9tPQJfygCLwaMhnBbcYfK/eds1TT00wj+/zPaKzroSSD0rqFbeclyBrw1TgVb2jMZ3a0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10968

SGkgS3J6eXN6dG9mLMKgDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQhDQoNCk9uIE1vbiwgMjAy
Ni0wOC0xNyBhdCAwOTo1MCArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMTEsIDIwMjYgYXQgMDE6NDc6NDNQTSArMDIwMCwgSGVucmlrIEdyaW1sZXIgd3Jv
dGU6DQo+ID4gQWRkIGNvbXBhdGlibGUgZm9yIFRleGFzIEluc3RydW1lbnRzIGJxMjd6NzQ2IGZ1
ZWwgZ2F1Z2UsIHdoaWNoIGlzDQo+ID4gc2ltaWxhciB0byBpdHMgc2libGluZyBicXoyNzU2MSwg
YnV0IHdpdGggbW9yZSBwcm90ZWN0aW9uDQo+ID4gZnVuY3Rpb25hbGl0eS4NCj4gDQo+ICJNb3Jl
IiBtZWFucyBzdXBlcnNldD8gRHJpdmVyIGNvZGUgc2F5cyBpdCBpcyBjb21wYXRpYmxlLCBzbyB0
aGlzIGhhcyB0bw0KPiBiZSBleHBsYWluZWQgDQoNCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBt
ZXNzYWdlIHRvIGV4cGxhaW4gdGhlIGRpZmZlcmVuY2VzLiBNYWluDQpkaWZmZXJlbmNlIGlzIHRo
YXQgYnEyN3o3NDYgaGFzIGludGVncmF0ZWQgcHJvdGVjdGlvbiBsb2dpYywgYW5kIGNhbg0KY29u
dHJvbCBleHRlcm5hbCBNT1NGRVRzIHRvIHN0b3AgY2hhcmdpbmcvZGlzY2hhcmdpbmcgaWYgYW4g
aXNzdWUgaXMNCmRldGVjdGVkIChsaWtlIG92ZXJjdXJyZW50IG9yIG92ZXJ2b2x0YWdlKSwgb3Ig
dG8ga2VlcCB0aGUgcmVzdCBvZiB0aGUNCnN5c3RlbSBmdWxseSBwb3dlcmVkIG9mZiBpbiBzaGlw
cGluZyBtb2RlLiBicTI3ejU2MSBkb2VzIG5vdCBoYXZlIHN1Y2gNCnByb3RlY3Rpb24gY2lyY3Vp
dHJ5LCBzbyBiZXN0IGl0IGNhbiBkbyBpZiBpdCBkZXRlY3RzIGlzc3VlcyBpcyB0byBzZW5kDQph
biBpbnRlcnJ1cHQgdG8gc29tZSBvdGhlciBjb21wb25lbnQuDQoNClRoZSBzdGFuZGFyZCByZWdp
c3RlciBtYXAgaXMgYWxtb3N0IGlkZW50aWNhbCBiZXR3ZWVuIHRoZSBkZXZpY2VzLg0KYnEyN3o1
NjEgaGFzIDYgZXh0cmEgcmVnaXN0ZXJzIGF0IHRoZSBlbmQgdGhhdCBicTI3ejc0NiBsYWNrcyB0
aG91Z2gsDQp3aGljaCBJIG1pc3NlZCB3aGVuIGNvbXBhcmluZyB0aGUgVFJNcyB0aGUgZmlyc3Qg
dGltZSAoc28gYnEyN3o1NjEgbWFwDQppcyBhIHN1cGVyc2V0IG9mIGJxMjd6NzQ2J3MpLiBOZWl0
aGVyIG9mIHRoZXNlIGV4dHJhIHJlZ2lzdGVycyBhcmUNCnN1cHBvcnRlZC9oYW5kbGVkIGJ5IHRo
ZSBMaW51eCBkcml2ZXIgdGhyb3VnaC4gSSB3aWxsIHVwZGF0ZSBhbGwgdGhlDQpjb21taXQgbWVz
c2FnZXMgZm9yIHYyIHRvIGNsYXJpZnkuDQoNClRoZXJlIGFyZSBhbHNvIGFkZGl0aW9uYWwgIk1h
bnVmYWN0dXJlckFjY2VzcyIgcmVnaXN0ZXJzIHdoZXJlIHRoZXJlDQphcmUgc29tZSBtb3JlIGRp
ZmZlcmVuY2VzIGJldHdlZW4gYnEyN3o1NjEgYW5kIGJxMjd6NzQ2IG1vc3RseSByZWxhdGVkDQp0
byB0aGUgYWJvdmUgbWVudGlvbmVkIE1PU0ZFVCBjb250cm9sLCBidXQgdGhlIGN1cnJlbnQgTGlu
dXggZHJpdmVyDQpkb2VzIG5vdCByZWFkIG9yIGhhbmRsZSBhbnkgIk1hbnVmYWN0dXJlckFjY2Vz
cyIgcmVnaXN0ZXIuIE9uZSBvZiBteQ0KY29sbGVhZ3VlcyBoYXMgc2VudCBhIHBhdGNoIHRvIGFk
ZCBzdXBwb3J0IGZvciByZWFkaW5nIFBST1BfTU9ERUxfTkFNRQ0KZnJvbSB0aGVzZSBhZGRpdGlv
bmFsIHJlZ2lzdGVycyBmb3IgYnEyN3o1NjEgdGhvdWdoIFsxXS4gVGhpcyBtb2RlbA0KbmFtZSBy
ZWdpc3RlciBpcyB0aGUgc2FtZSBmb3IgYnEyN3o1NjEgYW5kIGJxMjd6NzQ2Lg0KDQpJbiBzdW1t
YXJ5IHRoZSBjaGlwcyBoYXZlIGRpZmZlcmVuY2VzLCBidXQgSSBleHBlY3QgaXQgd2lsbCBiZSBm
aW5lIGZvcg0KdGhlIGRyaXZlciB0byB1c2Ugc2FtZSByZWdzIGFuZCBwcm9wcyBmb3IgYnEyN3o3
NDYgYW5kIGJxMjd6NTYxLg0KDQo+IChleHBsaWNpdGx5IHJlcXVlc3RlZCBpbiB3cml0aW5nIGJp
bmRpbmdzIGJ0dykuDQoNCkkgd2lsbCByZWFkIHdyaXRpbmctYmluZGluZ3MgYW5kIHdyaXRpbmct
c2NoZW1hIG1vcmUgY2FyZWZ1bGx5Lg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
ClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjAyNjA4MTQtYWxleGFuZGVy
LWxhZGRjaGlwLXBhdGNoLXYxLTEtMTYyNGQ2NzI1MTA4QGF4aXMuY29tLw0KDQpCZXN0IHJlZ2Fy
ZHMsDQpIZW5yaWsgR3JpbWxlcg0KDQo=
