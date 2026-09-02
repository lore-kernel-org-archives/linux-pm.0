Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0941922F5;
	Wed,  2 Sep 2026 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329077; cv=fail; b=HINCKstD9E2r8koDZJlokn02UwERRcUh2zUez3xqfg7riKgIvjjXPbw0OtKZyjnpLfhfGJvkQ5OqZlEMG61fw3YR4EEBK4qGcJ3aTNmfJho0sN2F3gqpEUmWdEuuNgqpRxFMqES4hesifmrXg6Y6sM+fcgDP77YBujcyWiutfac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329077; c=relaxed/simple;
	bh=9W50qoam1oXPlKxbkd3YwlyjSSDiqawUllMPpt8qWx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+prt/d/8bYjaiEdzMfWzTfaw35S+mEsbWeGjfBB/QKYMGThXCYEsE9xlAOl1yMi+eDSI/b8C7z3LrXBwhmLhMM4mDERs1i1v4S5MU/q0oNrZ6x2/NinJGRmW2cls4DL3b8B/hUbA+SPZ6wxBJ0tCc2VePkWQpTcT2QMzt5uH0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7MtLONkFXGMcrjMTgNYMfW1E3p38g1LLViJEr4FaQYYcJi6/eee0I7C71EiPwPokFq0DRMpF9fRBKdFrF2wy9jjK6QUz4uoMJvaFUC2PdfCNU56Rx/ChrHOPwfoPYuykF1JZN18IcSFxRihBHNAuN8slPE/zmSyYx8AEZd0/RkhUpnFbmx/7HBjdAfkg/3XDkpxDGoCHE2Wd2MF8nDEK6N8PSSL1nwTFKGKDh6YgeB3ShIzr6865012ehEag2u+7xyxBzSn+nRdP7WQ9nXVhPsDxx5r5B54oyQB/ErR09MmgDcsTkAW/euMIaCqDiugrOaDfOmbK5rD4KQlzkDKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W50qoam1oXPlKxbkd3YwlyjSSDiqawUllMPpt8qWx0=;
 b=LX1lzbs3eADkv+cL5mZgyvwF4EDIWORsEvj0QhHHsxP2SjwhIMQsfX//7u6sf29KlnQFy5JWBx04YKU+K8Llt2AQDQ2+4ha/9crL+23o0xtG2iENxmOdECjH/0lfgrfXMTrQ8oawqAyuDz7zXPMJ9Z8Ixp8ZPvD92+Gt7gkjvHE05y9pEAg2EYlsgZvQNJOuY9Vbfasue7jIxupqWUt1cGj29v368h6CmR2K5vzXgwPaaiGbWL9PPxM5eTddvgdvMuuibd8vu4OHDZdibmAvZOAsEqA3c4OJC/RhD82LBGVO/xRQm2SlCxqbLCveG9Y4BS0/uYMH9Rpg41bWH1Az8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.19; Wed, 2 Sep
 2026 06:04:21 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Wed, 2 Sep 2026 06:04:21 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Ulf Hansson <ulfh@kernel.org>, Nicolas Frattaroli
	<nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Hiago
 De Franco <hiago.franco@toradex.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pmdomain: core: Honour pd_ignore_unused in the sync_state
 power-off
Thread-Topic: [PATCH] pmdomain: core: Honour pd_ignore_unused in the
 sync_state power-off
Thread-Index: AQHdN+/MgocB5Rquc0Kyh8m/FRCf/7a3xEyAgAML4LA=
Date: Wed, 2 Sep 2026 06:04:21 +0000
Message-ID:
 <BJXPR01MB0838232B3814ED371B8E0F0DF9B72@BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn>
References: <20260829195105.4173953-1-joshua.yeong@starfivetech.com>
 <CAMuHMdU_3WoqOv_gsFnTpC61A48bQsmO_9FMT6PVAZ4bduedtg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU_3WoqOv_gsFnTpC61A48bQsmO_9FMT6PVAZ4bduedtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0838:EE_|BJXPR01MB0552:EE_
x-ms-office365-filtering-correlation-id: 7e5b6d3d-c6ed-4c45-2300-08df08b807fc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|4143699003|6133799003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 XCwrFeeLLQaEfjftr76552NIRT+96O+mbihM+mASw3x64+un08pw+DAJxGcyxSBsHpCUd4TnAF9z0TMGe9Nn3rpB4czl0nrVbSaz/PONi+KyWvb4O6oVuW36dOIGGoz/Igq2Hf+2Pw6qFZ9M81sKCmzIXEEzJdWwLeoeeIQWe0Skb94JzGwV+AAk1K8unGuEC3IeU5flD62biirJwpZqu9Vjzk4zCdB8mA20y4VoOnmoV1pQPxhFqDcN/MORxCQhkFjCztD4qrBSRP2clsf+KxFxe1XCJzNljwK/HQ6CAxRdB8Eg/sxRYm5trUVLRH4hw8/gE9+GcU5wsfzR6eSc1pUjOxUDOxVyfbof1KrStsevL7fWx7WBGWRj4xI64DRnyVOlQ842CAW/xH04px+M+i8HM6YkoCxKkOmXGDzgrIfTDQSfR5yAZ5L5UEghswalgjlWZ3Cijz5wr8t6524yd1ot6cS0sGHYO4aD7k8CT0UJIfEkJ60ofgziYS6XWzwujujqRjj0Na6lQ8gyWbOGpePLS5UpI8n1qMKt8OiZR0Dak3JbFIInPkzqbX30WBWA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUlUMFlaSUMrVVRUMmlDUk9tNzJIMkRmMUwrWEVPKy9pdlVZTENBdnBvcVZq?=
 =?utf-8?B?MTcyVHAzOUxWVmd1Y0xHcmlKbUxSRENZT3RRTkM5SjhkeFNLRHBUN0ZQTTJi?=
 =?utf-8?B?M3VrekZ4ZnhmeXYzdFF4V0RzZUNjUG5uRVI0QldnNWtlTnRveHVmeXJxWEF2?=
 =?utf-8?B?Y2VqaTVOeHU4K3paMkNvQUY1N0dGVEpmTEprWHFWVWtlRkFkQ2pMN1NvRGwx?=
 =?utf-8?B?N0puQmdHOFhwbzByQS9WQ2JRRDJkL3A0Q0dLbk9NOTBIQUZEL1hhNHFJNFFs?=
 =?utf-8?B?R2o2b0VnM1E2d08vaW1Hbnc2NWY4a1o1a1lIN2NlbGxiL0kzcHppcUJ6ajVD?=
 =?utf-8?B?dUF0SEFSZ2Z0RTFCVXR2ZzNqN2d2V1NLeWVaV3Nmc1R0SW5UUHNGbHNsZEZp?=
 =?utf-8?B?NkdabmFJSHNvRVlTYmZQeEhXbHZBTmlGWWQvRHp5Z3J5VXFieEtSZGN5d2dv?=
 =?utf-8?B?cEtwNkI2OEdZbXRlTkRBMGd4ODdrOHFSY1FQVC9lQjV3UmwxWDRiODQ0cy9z?=
 =?utf-8?B?MW9qL1E4Qm5HMDNGWVZaMnZjT3RNaWZwZHk2V2trRW40NGlkR0VBTHYvWlRY?=
 =?utf-8?B?aGQrR01ocE1Xd28rZG1vV0FxdlUvamV2OStDVitiWHdMTHQwdU93RTA0S3ll?=
 =?utf-8?B?Yk9ocE5tLzl2TU4zYnQyYm5zTkMyZnFjSVdXWEIrdHBzL29FTDdSR1JVTmwv?=
 =?utf-8?B?aFRoellPSVZHMTRRL2VtYktXT2MrNE9pWUdVbUQxWnF0cFM4Y1JiTElSTjhY?=
 =?utf-8?B?UExmMGFIVmU3U0U2NlJWeU1vNEpCT3ZYUjloMW5yZWFSdEk1cjFzUGU0MzRz?=
 =?utf-8?B?R0Q3RnExZnNSb2pUa0pXVXNad2NYQis2ckFFV0V1aHB3Y1E2M2puYTdCTnpx?=
 =?utf-8?B?dnZmcHJnQ1dwd2Rva0x6V25yZlhoakdEdlZEN2c2bDJGYVp4dDZFZW1NOGFQ?=
 =?utf-8?B?bjdPazZleWRLRG13TlBSVDdVMm9MVFBmQ0I5Q21qenYwM1lyOVZwTW9HY3NV?=
 =?utf-8?B?cVp4R09tZ0JHc1ROUnFFM09naHZWZlowT2lrU0RacmtIV3JxMXhlWmVOaWtW?=
 =?utf-8?B?aTBTVWRsQW5yelY4MmNMaWFXVC9XSHU0N2xXZmpXOGdGVGx5RUgxcVhWUWlw?=
 =?utf-8?B?L29uNVJjazZjUVZLRno1TUpRWFFvc3hTU0JzaFBpWFY5UVpiZEd4S1JJVC83?=
 =?utf-8?B?WlJuRWN5M1kvU0lVa0tXTkJJeXZIY1JpZlJIUGtGNlpPMCtDQlY4OGZtbzE1?=
 =?utf-8?B?WjB2aTVRMk9qOEsxWCtRelRNSkxHdDZUL3N4Q1VrSHUzMmJEcjhza0p2MUh0?=
 =?utf-8?B?MEtORXFoTzB4RDFzVHd0UFFidVJmbDNSNWF3OFJtenlTc21CNTNJb3k5YndS?=
 =?utf-8?B?dFcwaENxU0pvWmFVMG4yYmRiVHBWTmRFV0JjWTdMb3AwZzRxSXdzOEtqelhQ?=
 =?utf-8?B?dUZwN053dnRZME1nYVgyL0R6Zk5GdVpDOXAvdGhjSkJrUXVQTjA0c001aFZL?=
 =?utf-8?B?NXB0d3YwNFJscnBZT3FoRFNDSnhyd3BlSEpYTFU4RjBVREdoZjJwMGlHd1hx?=
 =?utf-8?B?M2VDYnFNV1VkS0FqQ1BMcmJadzVkZXJXeVNSSnNhTlpJMXJub3p3NmUyUm1H?=
 =?utf-8?B?ZlgrWmhzL2Z2dmNQQmxCR3UwQ2I5bUJjcEl1TmJ4bkQ2ZlVnNFFDaTlveEFh?=
 =?utf-8?B?a0IwSWx0Q1BrU2xPTkYvZEg4TzhsSnRGb1R3N29tRkJjYjhwRjQ5UDNnVzBr?=
 =?utf-8?B?c0d0bm1mcC9qWGRKeGd1WWtITTh6ZFVLOXhtdGErbS95WTlUYnI4NVpuUkRt?=
 =?utf-8?B?ZE4vTjRNMzhOUlpDVlF6Mi9SZlFERkVqaW1razAzVmI2WTE3Y1BEQVp2dG02?=
 =?utf-8?B?VmoxRlF5UkVwNldUOXdtYS9TZndqMlZIeFRQbDNVRXhDeGErcEJQdGJpazZv?=
 =?utf-8?B?SUFESlV5N1FjL21vVm5NbU4vWGhGVDhBWk5rRk9EcktzcUxLV0RzNmgzRnhz?=
 =?utf-8?B?N0NMeXBDdEszdklObmttSmJ3K0EycVZzNGJsakFtblJzNzlJOWxleUtnekcv?=
 =?utf-8?B?UFJ2M3FudWt4Z2lpM1BHNXVTb3pkSUJzL1lOdHVoOUc5cGh6WjJNSG45ZlNj?=
 =?utf-8?B?cE42RzBuMzJhQkJRdmJuVWtDR0pYc3h1TTVqWnNtWWVYanZVSkIrNWxhRVpG?=
 =?utf-8?B?eTRtdjVKNUJBb0d5MHZicVRubnduWjJQTk5QU01pSnZzSE1WcVoyd0VPeG5k?=
 =?utf-8?B?bHRsT2F0MmtjODRXT0wzQ0ZHSWZzczJheUxzS2pFL2NHNUpPNnZ5NjBTZm5U?=
 =?utf-8?B?eHljZWhaYi9wN3FSbzFjNWtaQmhhMnhLK011ZjBGcDlRTXFNQWtBV3VYY2R5?=
 =?utf-8?Q?OrVX+hvI8CEMF2J4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5b6d3d-c6ed-4c45-2300-08df08b807fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 06:04:21.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXC9X8uchh0di6g/2CxEyIhehvuV4UneqIuEnzoxWL83rQMP3X3nGDqhvji+uah8CCUf4CpEydrNGsBk3Z4MRRdCpYUdBEd0PVoqvn+WJpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

T24gTW9uZGF5LCBBdWd1c3QgMzEsIDIwMjYgMzoyNiBQTSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDMx
LCAyMDI2IDM6MjcgUE0NCj4gVG86IEpvc2h1YSBZZW9uZyA8am9zaHVhLnllb25nQHN0YXJmaXZl
dGVjaC5jb20+DQo+IENjOiBVbGYgSGFuc3NvbiA8dWxmaEBrZXJuZWwub3JnPjsgTmljb2xhcyBG
cmF0dGFyb2xpDQo+IDxuaWNvbGFzLmZyYXR0YXJvbGlAY29sbGFib3JhLmNvbT47IEhlaWtvIFN0
dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+OyBIaWFnbw0KPiBEZSBGcmFuY28gPGhpYWdvLmZyYW5j
b0B0b3JhZGV4LmNvbT47IFRvbWkgVmFsa2VpbmVuDQo+IDx0b21pLnZhbGtlaW5lbkBpZGVhc29u
Ym9hcmQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwbWRvbWFpbjogY29yZTogSG9u
b3VyIHBkX2lnbm9yZV91bnVzZWQgaW4gdGhlDQo+IHN5bmNfc3RhdGUgcG93ZXItb2ZmDQo+IA0K
PiBIaSBKb3NodWEsDQo+IA0KPiBPbiBTYXQsIDI5IEF1ZyAyMDI2IGF0IDIxOjUxLCBKb3NodWEg
WWVvbmcNCj4gPGpvc2h1YS55ZW9uZ0BzdGFyZml2ZXRlY2guY29tPiB3cm90ZToNCj4gPiBUaGUg
cGRfaWdub3JlX3VudXNlZCBjb21tYW5kIGxpbmUgb3B0aW9uIGlzIGRvY3VtZW50ZWQgdG8gImtl
ZXAgYWxsDQo+ID4gcG93ZXItZG9tYWlucyBhbHJlYWR5IGVuYWJsZWQgYnkgYm9vdGxvYWRlciBv
biwgZXZlbiBpZiBubyBkcml2ZXIgaGFzDQo+ID4gY2xhaW1lZCB0aGVtIi4gT24gYW4gT0YgcGxh
dGZvcm0gaXQgbm8gbG9uZ2VyIGRvZXMuDQo+ID4NCj4gPiBQb3dlcmluZyBvZmYgdW5jbGFpbWVk
IFBNIGRvbWFpbnMgdXNlZCB0byBiZSB0aGUgam9iIG9mDQo+ID4gZ2VucGRfcG93ZXJfb2ZmX3Vu
dXNlZCgpLCB3aGljaCBiYWlscyBvdXQgb24gdGhlIG9wdGlvbi4NCj4gPiBDb21taXQgMDAyZWJk
ZGQ2OTVhICgicG1kb21haW46IGNvcmU6IFJlc3RvcmUgYmVoYXZpb3VyIGZvciBkaXNhYmxpbmcN
Cj4gPiB1bnVzZWQgUE0gZG9tYWlucyIpIHN0b3BwZWQgdGhhdCBsYXRlX2luaXRjYWxsX3N5bmMg
ZnJvbSBjbGVhcmluZw0KPiA+IHN0YXlfb24sIHNvIGl0IGNhbiBubyBsb25nZXIgcG93ZXIgb2Zm
IGEgUE0gZG9tYWluIHRoYXQgd2FzIGZvdW5kDQo+ID4gcG93ZXJlZC1vbiBhdCBpbml0aWFsaXph
dGlvbi4gVGhlIG9ubHkgcmVtYWluaW5nIHBhdGggdGhhdCBjbGVhcnMNCj4gPiBzdGF5X29uIGlz
IC0+c3luY19zdGF0ZSgpLCBhbmQgaXQgbmV2ZXIgbG9va2VkIGF0IHRoZSBvcHRpb24sIHNvIGFu
DQo+ID4gdW5jbGFpbWVkIFBNIGRvbWFpbiB0aGF0IHRoZSBib290bG9hZGVyIGxlZnQgb24gaXMg
cG93ZXJlZCBvZmYgdGhlcmUNCj4gPiByZWdhcmRsZXNzLg0KPiA+DQo+ID4gSG9ub3VyIHRoZSBv
cHRpb24gaW4gdGhlIHN5bmNfc3RhdGUgcGF0aHMsIGZvciB0aGUgUE0gZG9tYWlucyB0aGF0DQo+
ID4gaGF2ZSBubyBjb25zdW1lciBhdHRhY2hlZC4gVGhvc2UgYXJlIHRoZSBvbmVzIHRoZSBvcHRp
b24gZGVzY3JpYmVzLA0KPiA+IGFuZCBvbmNlDQo+ID4gZ2VucGRfcG93ZXJfb2ZmX3VudXNlZCgp
IGhhcyBiYWlsZWQgb3V0IHRoZXkgaGF2ZSBubyBvdGhlciBwb3dlci1vZmYNCj4gPiB0cmlnZ2Vy
LCBzbyB0aGV5IHN0YXkgb24gYXMgZG9jdW1lbnRlZC4NCj4gPg0KPiA+IFRoZSBzdGF5X29uIGNv
bnN0cmFpbnQgaXMgZHJvcHBlZCBlaXRoZXIgd2F5LCBsZWF2aW5nIHRoZSBsaWZldGltZSBvZg0K
PiA+IHRoZSBjb25zdHJhaW50IHVuY2hhbmdlZC4gVGhlIFBNIGRvbWFpbnMgdGhhdCBkbyBoYXZl
IGEgY29uc3VtZXINCj4gPiBhdHRhY2hlZCB0aGVyZWZvcmUgc3RheSB1bmRlciB0aGUgY29udHJv
bCBvZiBydW50aW1lIFBNLCB3aGljaCB0aGUNCj4gPiBvcHRpb24gaGFzIG5ldmVyIGNvdmVyZWQs
IGFuZCBhIFBNIGRvbWFpbiB0aGF0IGdhaW5zIGEgY29uc3VtZXIgYWZ0ZXINCj4gPiAtPnN5bmNf
c3RhdGUoKSBpcyBub3QgbGVmdCBwaW5uZWQuDQo+ID4NCj4gPiBGaXhlczogMGU3ODliNDkxYmEw
ICgicG1kb21haW46IGNvcmU6IExlYXZlIHBvd2VyZWQtb24gZ2VucGRzIG9uIHVudGlsDQo+ID4g
c3luY19zdGF0ZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9zaHVhIFllb25nIDxqb3NodWEueWVv
bmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+
IEkgZGlkIHNvbWV0aGluZyBzaW1pbGFyIGluICJbUEFUQ0gvUkZDXSBwbWRvbWFpbjogY29yZTog
U3VwcG9ydA0KPiBwZF9pZ25vcmVfdW51c2VkIHdpdGggc3luY19zdGF0ZSJbMV0sIGFuZCBVbGYg
cmVzcG9uZGVkWzJdOg0KPiANCj4gICAgIlJpZ2h0LCBJIHRoaW5rIGl0J3MgdGltZSB0byBjb25z
aWRlciByZW1vdmluZyBpdCwgdW5sZXNzIHBlb3BsZSBzdGlsbA0KPiAgICAgZmluZCBpdCB1c2Vm
dWwgb2Zjb3Vyc2UuIg0KDQpJdCBpcyBhY3R1YWxseSB2ZXJ5IHVzZWZ1bCBhbmQgc2ltaWxhcmx5
IHRvIHRoZSBwYXJhbWV0ZXIgJ2Nsa19pZ25vcmVfdW51c2VkJyBlc3BlY2lhbGx5IGR1cmluZyBw
cm9kdWN0IHBvd2VyIG9uLg0KSW4gUklTQy1WIFJQTUkgcHJvdG9jb2wgY2FzZSwgdGhlIHBvd2Vy
IGRvbWFpbiBpcyBkaXNjb3ZlcmVkIGR5bmFtaWNhbGx5LiBXaGlsZSBpdCBpcyB0cnVlIHRoYXQg
ZmluYWwgcHJvZHVjdA0Kc2hvdWxkIGhhdmUgZXZlcnl0aGluZyBjb25maWd1cmVkIGFuZCBtYXBw
ZWQsIHRoZSBpZGVhIGhvdyBoYXZpbmcgYW4gJ3VudXNlZCcgZmxhZyBzYXZlIHRpbWUgZGVidWdn
aW5nDQpvbiB0aGUgYWN0dWFsIHNpbGljb24uIA0KDQpUaGFua3MNCkpvc2h1YQ0KDQo+IA0KPiBb
MV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvMWNmYTg2YjcyYjJhNWFhMmFkZTkyZjI0N2Rk
MzE4YzljYjZlZjJhMS4xNzcNCj4gMTI2NzUwNC5naXQuZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmUN
Cj4gWzJdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL0NBUER5S0ZxMml0NVRBRUJCS0JoK3Er
VWlSc0dZYU9SYXIwUV80MkxDdXh5DQo+IEtSTFlqMEFAbWFpbC5nbWFpbC5jb20NCj4gDQo+IEdy
e29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4g
DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5
b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBj
b252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tl
ci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJv
Z3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
