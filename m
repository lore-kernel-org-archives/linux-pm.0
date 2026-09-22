Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB147A0B6;
	Tue, 22 Sep 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078412; cv=fail; b=eVE1KPjTnAUxYa4fkYfGOWDycL9+mmrplyXwut2anbjZqA+gaN3u7hBL2zKHVQPRr3fh50OkR0WDeWVd9p3o1S7vwMm2vHNVrvxYPPLODM7sBvSoHPX8O6hPVZwQlSvqzmYZLFBDu+xNlGNP1fpRMCOrBWp92p3hfxN4Mh0HcGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078412; c=relaxed/simple;
	bh=KVMDnCqBnydrF3c8EF2SoCAqEPnWDvPE3GAhte3NgU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h3CzloL79PNX0IcaNLsjKLyYXvTEelwI8iNEBkXMMb3QnlzmRInMsZSgWPz9iNYAHTyQAe6s8t/USeSbhrrJ1lM0VOa8IWm2yeXgcEq0gT5USRt4j9yC+8THKgMvkykNtb5nEBNDBL9/UPD8ptpqsbJoRJnmEkVsvRbdeKLqrzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nZJWDMf/; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nZJWDMf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZM+C6lUmYksroLc4VRcMP4NihT28625fSlDyq9fpftpE6xMJC0AOWJfS7I0DR5/Q5O66NCvn7aRjRSb00MYWWNaj1MREdeXt8hS3/S2wv9lMLDxi0WH5Jc+iPZSTM0XMLcq2QRHmqDCTXolA66I6aQpE3vVkW545P6OIvOPX44UBsrcDYvljX/vgwnz8xHX8a+6GpttUFOmVzuHrdeFYvSvIH0XMwqGz+DycCwRDI8lGn1qtwU8ka5srYX6br84Vq4SNi5hKDfXv4vE6Zl/ZQU0k+FH7VKF0IuJHm3TcHXqOHJU9dYp1ZaYfA1RAHPy5CahZtHWMQgSYzHZahMy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVMDnCqBnydrF3c8EF2SoCAqEPnWDvPE3GAhte3NgU8=;
 b=cwkSOSOgluQD9+dNkrbvpuERrIS4trzLfwQktL2SB//dBoxdNA+UilA5lhN2ZF3RgyNeUahGrve6IhHJAlx1S1huppiPQV75ULUerhK806TC8Ri0TVGGV8ax9jPWpnmimYHH7PjVa6RUVeiDNStqNROZduMXv4ha1qzqE4PCj8Mg/ZgDDbzLpvbbqcmUBjulBD/USRH6ShaKJ7XaX1B6Oqjoyq9rsZEOWgBh8kLrXUDpyh9MEXB16J1V8ALy+igVsZcVUosU5+Zh776m/sSteOqvrVtuLRQ2AW94X2OCUFltLn3DZarklNuInw0pLzg01uMBkfPr7d+2Cxn/pkNsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVMDnCqBnydrF3c8EF2SoCAqEPnWDvPE3GAhte3NgU8=;
 b=nZJWDMf/pr6cJSUIiPZPbuBbvUeWXHAny91/auAhmJi1XdiN+ON6X9cEljDeIbHTpT0veI9X+91jjicxXPSOlQQ2cYs1cX1bx9iIP7BtgKYHiTcSK2Vsm/TtXGHc/JSNBL67tW3F786TxOX6hfUtvamBwvFVWuWeEU49hitojvRnIwr16NXgpBM+dZtSq2m5wJNdwFxbfyq3WYyBCGkIcVCAKLLCs+uqGimgPE55lMUEhjXs4WFIijwVG7xvCey/NMhatlGWfEHy+jyCtOjgdmKIX6mAeyjYK5GCjzbP69wlgBC3pcOu+Is3FjD+I5NRceGlNQNdEdYYBIwYtXCWnw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PR3PR10MB4064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 12:00:07 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 12:00:05 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bmasney@redhat.com" <bmasney@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/4] pmdomain: core: migrate to dev_add_sync_state()
Thread-Topic: [PATCH 2/4] pmdomain: core: migrate to dev_add_sync_state()
Thread-Index: AQHdSonnvsHunUAHnkenjuK6BmfuwA==
Date: Tue, 22 Sep 2026 12:00:05 +0000
Message-ID: <4fb0f9cdbeb7c12bb66f7c591d2099ea1faec7a7.camel@siemens.com>
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
	 <20260626-clk-sync-state-v1-2-4156d8196dc8@redhat.com>
In-Reply-To: <20260626-clk-sync-state-v1-2-4156d8196dc8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PR3PR10MB4064:EE_
x-ms-office365-filtering-correlation-id: 74edfcd8-921c-4fab-8fa5-08df18a10a6e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info:
 aVaCfFSyv6IsUuaj7Uycdpd2I3pFv6C1DngTDnx4zaaYjY1KJdgbzBKFtcks/5/veaqDILx60M5oVeamWShJG0Hk9lYXQ5Ws/A+VTavlZBH1tGrrpuhaMA3R38Hy5wZPSMVYoSOtPryP9P+PF0vcjvEpRQWnUe4mJ+Nj+E7D/YjNSJ5SYY5iaV6bZjKLvFF5FNkVu2Zq0Vr1RziY9h04jXuLE5gcdqFYo9p/ALKjp5JsGNxfPayQ0+wsRtM3SbOp+MNXWUiSa9lY7uubnxsYCVZ2F7hsZsMpQn0YpllFxJyXJdtJone1D85dKNtFCsq7oHPprT/q3z1fvr7qcnbjoyL/8ZCRtN1C4BZbOFRAM2BdvNYlZb0r6rF5ZIiimRImYBUw88punk6cEQwuqncZpTUbBACrmcBSKmpOrleeU0eR41k1pODKUYNV3Jvz7oO3Cmt9Eem0Z7haRFeEsuOh7cBUvV6TYutNeUHGAGKaqrDSa1Si690gYTRY1u8s3c9wOIDQ4JQGLNMvzcBgLq9Oo+9jfKBDGftc26q/0qKyG9djXDMENEd/ejfwzj7Rn5HjsMX0/sgkAeGh4/lDjEkGwMq9D5QMUkKEgUg//eux84//36nKCRi3DwzFEwb4AcCxCY2U+u3s+dYur3bIYX/wIL6LG0JhdMeXY9UfYNl+FOs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkNpRlN1N0dzVVc1Z3hBUkcvRTJkZ1lodk9GNjVjK0JhM0VHeGhjRFNhZGRR?=
 =?utf-8?B?OGJrbFhBMHIyTHF5bGxudTFUaStlK1BCZVVHKzl1cWpVWEVtZVFpTXg4S1Jx?=
 =?utf-8?B?MldCaG1CMm9KZC9meUlTblRiWFhhR2xQdVNsMEQ1b2M1eWxTY0JBRmxXa2Ro?=
 =?utf-8?B?OFI1cUtQb1NlTlRuSnRIanJWSVdJRkV0V1hobUtxMlUyd2hTdDFvT0dtRlNX?=
 =?utf-8?B?UnR2QW1qMy9JZks2RzlqNmNsakFRWVRvRUJqQWYvZ0VucFFrSXN2UVorODdh?=
 =?utf-8?B?VmI3ejVldjl5VGxOSTFDMDY4M3dqQjNmL3A2SHVtWDU5eW5sWU5UczhZL3FI?=
 =?utf-8?B?Z1U4OHNzMlVvTUFuc1RNVk05QnVLWmpYZGJIRTZDNUI5U21sSUdLS0s3ckZF?=
 =?utf-8?B?TUMwY1NrY1FqN3p0eEV6SjhXa1I1MkNMTlBwUmdlM3owaVhSVGMvNVBKWnhi?=
 =?utf-8?B?MUpQbkxtQ04xK0hQaCs3enB0TlE3VTY0WDhLUWFxeGpCWUdqcldJamlTbk1E?=
 =?utf-8?B?Nm1MUGV3Z21LTW9zWkJPNXFQa3FadUhla0hvaVdpM0JDczBYMlFReklSMXVN?=
 =?utf-8?B?ampWb1pFTjFUTjZlcEtpYW1BSjc4bEUvd0FVdjBxcXdKbCtGMlJnWkVFMi9m?=
 =?utf-8?B?cURNclJtTVlWVS85L2RqYnhuUDE3a1dDMmlQcndpMU1zdDJ1cFF3NkJJcyto?=
 =?utf-8?B?U09GUkU3UFRsMWZnbENvNXBxK1NyZEJMcjRUMVFaNXd5YjJIRmFjL3BkN1ZC?=
 =?utf-8?B?L0FNUUVoZ1VHTnZPNC8ySFVYbVl4aGlvekpucGhkQWp6TXlhSW5nT2R5TnZv?=
 =?utf-8?B?OEdQbDlJK2xqVmFUbCtJU0VsSTE3eFRBR3F0QzNOV25uTWtuNCthQnN2NHZ1?=
 =?utf-8?B?Mi91cmVXaEJMdis5V0xMdzBzTXZDVCtxdXBieG4vK0NGejA4QkNZM0phZ3hz?=
 =?utf-8?B?aHREb2R2VHJ0UHZ5eFZ0bXRmaVF4bk1kVDhOR1VGTjZBS2xUaSsvUHNYSzUv?=
 =?utf-8?B?TUJCWjZQU1FobVZnSnpGTml5b0FOSU9UckpFUTdQekxXREg4bDJnVGhuUjA1?=
 =?utf-8?B?eGZzOXRvV3NLczBIRW9raC83TGxVQ0dnR1pBeURka0xla1RMN0JJVUVjZ2Zs?=
 =?utf-8?B?eExkaS9hM0FHeW5rOS9zSDNYdDJnL09IZEpSMkdKWEljK2NXMWF1Z1lGUWNv?=
 =?utf-8?B?NTFNTXByQ0NFLzBpY1VwV2MvV0xnWFRpRnJzZXVyVHJwNUs1SUFlOXFQTTlP?=
 =?utf-8?B?L2lHQndUa2VFTmRDbnlRNmhNN2htTUk0Y2dENE4vZXFVdUZ1SFFmMTQwWXJE?=
 =?utf-8?B?a1FJelVoeVIzeWJnWGtIRzlqUFN2YWtxYlVzYnMrcEFSRTRtRWJDcXl2amk2?=
 =?utf-8?B?MzBFbGthelNVbWhveHl0MjBMUkdka0x6Q1VtL0Y4ajBKY3BTbEJQTThaTUVX?=
 =?utf-8?B?bHFGbUI3RXVYVER6QkMva0piR00xSnFuK2luVzl2eFRhcTV6Wno5S1Y1Tmxo?=
 =?utf-8?B?WThSdXlXbUdsMDE3bXNheU4vNlhlMk80b0pLNFMveG12YUpjRnFoSnIwaGVJ?=
 =?utf-8?B?QVl5MFFIUlVqY3kzTHoxbVBqd0ZOTkpDOWczdkVtRWhQcldzY0x6U0R1WklZ?=
 =?utf-8?B?YzJBVTByV2JLV3U5eC9uNk5DeGZGRE9pQmZTRlduSm1zYldlazFsNE51aUtp?=
 =?utf-8?B?TzYzMjBFZTVUTXc5L0djOFE3TDRnMTNlcWlsemh0YXpUVm5ram5leXhKYUNJ?=
 =?utf-8?B?UXd6YjB5SDB3WGpieWFZNFdPaFVWak56bk53QXpJSm1MRWtBTjNLOWpUYi9I?=
 =?utf-8?B?RTFIUHZhOXJDK2JyV0pBbXIxMFlPTmJORVhNU3hYTjBPWTc2a1Z4TlkyV0Vy?=
 =?utf-8?B?NjBDWHZaeXE1a2sxOEhnT3N2cjQvaW55bWE1NGlNZWozNEM4dEt1NSszWEVB?=
 =?utf-8?B?MG1ndHQzekpBTWlVUGlIZHdyYmNZZW5EUGF3SFFyRjFYU2dNT3NYalh6M3dR?=
 =?utf-8?B?Y1p0VUZ0NFpiRlFjMEE4RjlHTGpjZDJyS3FmVy8vN2VFTWQxUkExOVFNaFpW?=
 =?utf-8?B?UW5hNXkzTWFkMFFTME5sVjBLbEZkd1FVcUJIRmtHdWJTRTBnUWJvTFd2OVNJ?=
 =?utf-8?B?dDhCeHhwSWl4UkQ4YVFGU2NUZUZIZVpEQXVqNzVORWMzWlRCdFU2am1iTHFw?=
 =?utf-8?B?MXFYanpYMVhzWnJqN01HUE5DNWNCa3J0Y0pDZG51YlR1dFcyVllYOFZtdFRl?=
 =?utf-8?B?bkxFNnZqNjJrY3NjSTNJanlMNGF4blpVYTVkVkY4SStEeW5oUkxkd0MwVmh5?=
 =?utf-8?B?ZGVMQU1VNGh1NVZnRkN2R0MyR2Z5d3RrUXdmS3U0bjVLcFNoak1VYUlpdmpa?=
 =?utf-8?Q?5pozdmhV9PyjQwY8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB766E0ED2EB6A48ADC2584F427939DD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74edfcd8-921c-4fab-8fa5-08df18a10a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 12:00:05.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMd79w874H4xEppka5KEHK3KtuBFjtQ3jybFqHElnz68Eh9CyQN31WuWwhna0bwnOXWs5g+o1J0mOV3qvcEczj3LakGygFNj+xonEpYlOEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4064

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEyOjMyIC0wNDAwLCBCcmlhbiBNYXNuZXkgd3JvdGU6DQo+
IFdlIGhhdmUgY2FzZXMgd2hlcmUgYSBkZXZpY2Ugbm9kZSByZXByZXNlbnRzIGEgcHJvdmlkZXIg
Zm9yIG11bHRpcGxlDQo+IHR5cGVzIG9mIHJlc291cmNlcywgbGlrZSBjbG9ja3MsIHBvd2VyLWRv
bWFpbnMsIHJlc2V0cywgZXRjLiBIYXZpbmcganVzdA0KPiBhIHNpbmdsZSBzeW5jX3N0YXRlIG9u
IHRoZSBkZXZpY2UgaXMgbm90IHN1ZmZpY2llbnQgc2luY2Ugb3RoZXINCj4gZnJhbWV3b3JrcyB3
aWxsIHdhbnQgdG8gYWRkIHRoZWlyIG93biBzeW5jX3N0YXRlIGNhbGxiYWNrLg0KPiANCj4gTWln
cmF0ZSB0aGUgcG1kb21haW4gY29yZSBjb2RlIGZyb20gZGV2X3NldF9kcnZfc3luY19zdGF0ZSgp
IHRvDQo+IGRldl9hZGRfc3luY19zdGF0ZSgpIHNvIHRoYXQgdGhpcyB3b3JrcyBuaWNlbHkgd2l0
aCBvdGhlciBmcmFtZXdvcmtzDQo+IHRoYXQgd2FudCB0byBhZGQgdGhlaXIgb3duIHN5bmNfc3Rh
dGUgY2FsbGJhY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcmlhbiBNYXNuZXkgPGJtYXNuZXlA
cmVkaGF0LmNvbT4NCj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00LTYNCg0KQXNz
dW1pbmcgdGhpcyBpcyB2MyAobm90IHNwZWNpZmllZCBpbiB0aGUgU3ViamVjdCksDQpSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9wbWRvbWFpbi9jb3JlLmMgfCA0ICsrLS0NCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcG1kb21haW4vY29yZS5jIGIvZHJpdmVycy9wbWRvbWFpbi9jb3JlLmMN
Cj4gaW5kZXggODQyYzQxNjllMjkwLi4yMjc5MTM1MzI0OWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvcG1kb21haW4vY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvcG1kb21haW4vY29yZS5jDQo+IEBA
IC0yNjk3LDcgKzI2OTcsNyBAQCBpbnQgb2ZfZ2VucGRfYWRkX3Byb3ZpZGVyX3NpbXBsZShzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiDCoAkJZ2VucGQtPnN5bmNfc3RhdGUgPSBHRU5QRF9TWU5D
X1NUQVRFX1NJTVBMRTsNCj4gwqAJCWRldmljZV9zZXRfbm9kZSgmZ2VucGQtPmRldiwgZndub2Rl
KTsNCj4gwqAJfSBlbHNlIHsNCj4gLQkJZGV2X3NldF9kcnZfc3luY19zdGF0ZShkZXYsIGdlbnBk
X3N5bmNfc3RhdGUpOw0KPiArCQlkZXZfYWRkX3N5bmNfc3RhdGUoZGV2LCBnZW5wZF9zeW5jX3N0
YXRlKTsNCj4gwqAJfQ0KPiDCoA0KPiDCoAlwdXRfZGV2aWNlKGRldik7DQo+IEBAIC0yNzcxLDcg
KzI3NzEsNyBAQCBpbnQgb2ZfZ2VucGRfYWRkX3Byb3ZpZGVyX29uZWNlbGwoc3RydWN0IGRldmlj
ZV9ub2RlICpucCwNCj4gwqAJaWYgKCFkZXYpDQo+IMKgCQlzeW5jX3N0YXRlID0gdHJ1ZTsNCj4g
wqAJZWxzZQ0KPiAtCQlkZXZfc2V0X2Rydl9zeW5jX3N0YXRlKGRldiwgZ2VucGRfc3luY19zdGF0
ZSk7DQo+ICsJCWRldl9hZGRfc3luY19zdGF0ZShkZXYsIGdlbnBkX3N5bmNfc3RhdGUpOw0KPiDC
oA0KPiDCoAlwdXRfZGV2aWNlKGRldik7DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
