Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023092.outbound.protection.outlook.com [40.107.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E723F4822;
	Tue, 15 Sep 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464787; cv=fail; b=BgJfaJxriu8S6vW6id7dRX+wPLWl0k4qAwd0cPM1G1rr39VESLhjb7h2OLJyWuGo+bOnc2xVGeKhpfVPPJiFpV7bjSj2rwnxPb1l3rxUUA9gJvNF0bR8iY1N3wYxnHvES3QcHLC0WyI878APbHWyvskIzsAz7ltimuma/8VPA94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464787; c=relaxed/simple;
	bh=CFEm9FWtQ4VhfIvoRyKJbrIACl6HNMBBAGQD2TwSfgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doFfOmI/zZw8jxaIW2DlapE4DR9jRzsW0u/qut4ZC2v9ra9w911xIJX2X+WZ/tgPPPOEbIk3bii16ujIE6Sk4rRg9fx/UKovmrfZjKr95l9tRl9C92alXGaPuw4/PDxS+/tw5vTy7hm7xOqm5qS1Tobol6xV+N/nvuE8pFUfY68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=btWDh7QZ; arc=fail smtp.client-ip=40.107.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="btWDh7QZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rirXX4ePzgyY5mhpy/d1VSWdXUpRfieHVYxeLgJtXX+FskDSodTJBEF10SgoLCT6QQa8LlV7I4ukP3hzPSVwGYBfvUvJkWFrnbyQOIVq8wTrdVIv6bkhDTh6Seq4GDSRWoQc1f4VUsmfBLSoMD0Eik79WEufJwP08aG4kQsCHxzgXUKylijoNmZhwvmd4/69H8OFigqWi3sbppRlYXioPSq/03wqHNWyXHo/i+DggIwe+ngZoW7dfsNTqylodweyJbojM5NdktuTRWcRjZrF9qTidbLUlZ90ZYKk+Km4kH1wVJo0SScUUeZAebCuKRPCS7RdDbpnW+yh7TxfwANLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFEm9FWtQ4VhfIvoRyKJbrIACl6HNMBBAGQD2TwSfgQ=;
 b=NSangvVu8ILtAnxY8f1WcJCTHsYtW7pCjinOkSFvCikfrAgWaBoG1E0VPEuBaDfrs7iBQyJbXhXxqbSHP322gK2KtB8OSjLq52f2TDYaQKxVkDAwqyM8mDxhaP2my4+p2k9SwZC+Se9+X6Tk4QmtC4zwtHK+dsfm9BY8l6b4Hjwxib3ZWOYYAc3gIA8Eu4dy51uHZNCT+Unck2q/n5tAzfj51vRLmghRXiU/GJpXbGoFfQGwTu6aj9thwqw3kMTp6Y0gByhFiKPWwyYBvc8W3E2BdMXqAqyBH4SXr/q4sUWWsztFJ5iScXsAmDnnltfzd/4dA3eM5ab/U1PS7AIfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFEm9FWtQ4VhfIvoRyKJbrIACl6HNMBBAGQD2TwSfgQ=;
 b=btWDh7QZrZITZG2emUVlKS74l9IqSaNAx8mancbarODa8pWNHJuPO7mxkrk3DKwjWOHFSISrmikVHjgTStMElC7C7tj65sxvxRpvIl0GpzknqxLN/+P3dK88OtX0EVPBU01iOebU5Oxhf8yAxGzTjlb/S2+5Nsr7gbKnTIsbN7A=
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com (2603:1096:400:32b::10)
 by KL1PR0401MB6612.apcprd04.prod.outlook.com (2603:1096:820:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 09:32:59 +0000
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb]) by TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 09:32:59 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Jianyong Wu <wujianyong@hygon.cn>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ray.huang@amd.com" <ray.huang@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
	"sumitg@nvidia.com" <sumitg@nvidia.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "zhongqiu.han@oss.qualcomm.com"
	<zhongqiu.han@oss.qualcomm.com>, "jianyong.wu@outlook.com"
	<jianyong.wu@outlook.com>, "wangfengyu@hygon.cn" <wangfengyu@hygon.cn>,
	"zhongyuan@hygon.cn" <zhongyuan@hygon.cn>, "huangsj@hygon.cn"
	<huangsj@hygon.cn>
Subject: Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Thread-Topic: [PATCH] cpufreq: Use a non-boost reference frequency for
 pressure calculation
Thread-Index: AQHdROBDKtjLqx+ThE2CyMvjl0e+m7bPYKOA
Date: Tue, 15 Sep 2026 09:32:59 +0000
Message-ID: <b10f5ad9-c91d-446d-a382-e6b2ce0ff7fb@transsion.com>
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
In-Reply-To: <20260915065747.1671965-1-wujianyong@hygon.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6192:EE_|KL1PR0401MB6612:EE_
x-ms-office365-filtering-correlation-id: 6f7fc880-5123-4695-bfe5-08df130c5502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|22082099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 DQzCtGi7gqU1p19IO8SlBEZJSbOM4X1kR6eAjjkOSQjwabIr8JWcCdqkiG8Y2vh7vMJKKO9QJQc29OC7G7Ga1LEKHW9Bi2aQDP7mqtkSniZ6IhJxZxyuJvxEouY0Q06kiuSGswDdiUiVBTnrVXU2c0APXWkw2JOYpC6urtebfmahUZxmPX2VpgYj3pYM1mpn1Lo534HqkSDDCfob1MW2AQIfrWqbbgPy/oc1vPjjzwA43z9awUavmU+RQV8siWstXcjgNQIPo2vF3rXKELysB1Xlg6o5gvqL2HuOFkchXZCukO6chs0WjMly1Tj5wmka5P9DyDLDOjcqFfGZEMhmrKL/6YSHlV0uguu3aR/DucEigp0/c8gQErP/DRW+sa3rwaVdu2RkMBPgHloMfgLESrmyyhBHryqHr50mQ407mk6f4Lczl+ttvvIckTWlAbfY49ZQTmgMGlsI45069beFQKcc+mok6vD7V1i6Gh8o2DL8JIuzfpgixcAK7acdkzTNvT7zWWu5ElntlickI6cMSokgjf997oJn+BOfC4FiBeVzw3LwnSMLlV8p95ORJbpXAPrlKe1dOMmfeBLnz9izQVfzkO3Oj2DhMDf5hjmPqvrxQn2Qmi+W2ZsszAgBDNOhtD//GEhY59FPA9OiT3zO83Cu0OQGjh299XBEcf+UITt+rT1lv5GZvLeJpxT63gsGHJYJ1bZIsTVu0XjDhbykG77hScn5McZxgoWCmBYPm5Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6192.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlllM1VzLzEvQ3pWRTFmMnloNFBRNDZvNjJ3YW9aT010TkRadzFRc3N4aWVE?=
 =?utf-8?B?WkdYSWlpdG16NmVnNTZKK2pjTHN1OGRSYWE5SHJXc3RzYlNLbTh3Y2hhMFdW?=
 =?utf-8?B?bFh1MC9aTUdiUnNibFZCVFZHdWVFaENoMXNYL0p5VWJMNmJBbWNwMUVadm1R?=
 =?utf-8?B?RnVhTTMyL2xvYkVjMjluVk1Zck1nMEJJeU54MU41clpQV1AvOWNSMEJlZDF1?=
 =?utf-8?B?bnpDK09TN1MrdXcwU2ZTMzZ6WEVsK2NmSmlncitOY0xXUldXWW9oSzFoNTd4?=
 =?utf-8?B?dWFmSmxhSmFDODYwRnBicFdyTGw2dkxXWXB1dU0renF2eWdhalVkUnlpUnU5?=
 =?utf-8?B?T085aDlSMlJGb0lqRU04V3lQSmdoY1BXcmExQW1NT21qcjRUb3kvQUVuYWRH?=
 =?utf-8?B?QklKbWxPcFU3K1RmVDVzSE8wR2R0UXlycEFiT2FqYVJkNmpiQ3ZWUnlmVVg2?=
 =?utf-8?B?SHoxKzlzc0NBcEdKSWxzWDBBZ0hQNnhqRjhjN3R2dy82UE52Q1NsdGtybzFU?=
 =?utf-8?B?d29wdnB4UThvRUhxZDFGQmcxU2NmYmFpWUtNd3lLQkR2OXpteEtSc1JrNThr?=
 =?utf-8?B?WEtMYk51dzRNeTkvOU1RdHZrTHdlM3BjNk9Mb1BxSkNBSFQ0bnI3RFpnUWt2?=
 =?utf-8?B?NnhoMmRKcGptRm13UHZTQkJiVVdxdWoveWNZZmovNUNFeVFrRlVSUE9aTmxH?=
 =?utf-8?B?bFR0UkR5TW92L3QyTWlWZTlkbnY4V0tWdFBKZklkY3hWQXptY0dhS0FnVkVN?=
 =?utf-8?B?YkJWaXRaRW91dUZ5bjk2MjZjTGQ2VU91OStmQWUrckNvWU5heUFrcUJFS014?=
 =?utf-8?B?M3ErM2wzRnFkREttSUpyZjF3Y1MvTlo1RnRoYTk1aDdHNmpJbE1CYWdvaVUx?=
 =?utf-8?B?aWpjU2VGMGVSb3lpbWlCRTZ4K3F6clVSZGhDeDNmcVBwaXhSVHpkN1BUc3hY?=
 =?utf-8?B?ZlpraGx4cTEvWkYvcDlsb1ZmODQySnRTVWFtTm9UMXFRMUZHWm1KV09yamJ3?=
 =?utf-8?B?Q3hmejl2djhjdU51bFllNkdIeCswcnpSejJoTTNYY1MwSWF6N2xLMm4rcEZK?=
 =?utf-8?B?M2UrTDJCcEZKYTViU3pSVUdNZGVoNXZiclArU0Y5dmRXZGFtT3hLWkd4ZytV?=
 =?utf-8?B?SGVEUTZpVFNHR2ZCNVNJRXhnb2d6MFdRSzZmV2NZd2ZWYnZkREZ4bzFxZ2ty?=
 =?utf-8?B?RnJ3L1lGMmRnaEFzRjFQcEU2NU9BLzdBR1Q5VENiQ0ZrWGRwWEMrZWhJRWNV?=
 =?utf-8?B?ajI2N3owdlhmYXBDS3lUQlltTnZLMGlFYzZUVjBNWWlYRjR4a1FvRDJnTmxL?=
 =?utf-8?B?Tnk2NTVtQmFmbHV3a0RoV1ZGV1ZjWnIrTFlkdTlGNjlITW1zSGdlSTYvQzB5?=
 =?utf-8?B?bXI0K0RHbStyOWlvMnhOS2pKOEpJeGFDR1lqTWpHQ1A4b1dUQlhxWkFKNFhK?=
 =?utf-8?B?UGNpbGl3eXdkTG84RzVPTWIyRnh4OCtxN3RLcFNnVnVYOS9NejE2SmNOR011?=
 =?utf-8?B?bUFRalU4c0o0Mm5WRDB2SXNNcngvL1M0VU9adllQK3hUQ2RHZ1UyNEUxVkJE?=
 =?utf-8?B?UEs4MVlnVGhWQzBBbDZTRGZwVXJaMlNRVU9Fd09oenJMYzNUL1lIb1YrNWhv?=
 =?utf-8?B?UmEvYjZYZC9RaFRQaTI4TnRscDBCcFpJY3NOOVpoNy9DdTBrSUxLMHFMZ21M?=
 =?utf-8?B?ZGo3eVFZZTZYWjREUlNLOHQ1MHNMVC9SaFZqOVlRc2ZoYkhEOHFEZ2k1Rjli?=
 =?utf-8?B?UDErUCtrZTRhYzRHM0YySndsSmtYR1lwYVYvdTN4ZXdWd00xZmR1RzEzQkVC?=
 =?utf-8?B?a3VyQUxYbVpGMEhyRWRqRCtSOUpsdnk2VXV4djIzV1AxbUp0SVpOYmxaUzc1?=
 =?utf-8?B?RkdQRGd3MXBIY241QjRPYjlRZFBLT01xZzFkQldJcVFhUzJlZTY3THJMZTVj?=
 =?utf-8?B?cDFTV3dWVXI3V3hHR1BiKzcrQlBoL0xzblVtU2JyL2NWeCtQenRzckpINnZM?=
 =?utf-8?B?b0FybXVGRzFReUNSSGdRUmt3ZmJndksrVGRmNmpXYVdVdm00SC9VcU5JMndN?=
 =?utf-8?B?WWFvUEpTL0ZQUTdQajI5WXJhcTVmMmsxZnJ2T0ZLZlZQcE90Ulc1ZnUzSzJ1?=
 =?utf-8?B?Z1hkRExPc0xnSTNTdnBDZWJCQzdNaGNlR0xhREpxMWRLSWxRV2YxYlZsMWJo?=
 =?utf-8?B?WlRUUHdQTHBPa2NybVVWUjJOSHc2VG44UkRpMW5lYmF3ZGhXbTBRbEFyclFL?=
 =?utf-8?B?ZDcrN3dsVmhzWGZ1ajhMakRnbzVlYjY3bE9rNWt2SHphdzBEMis0RHk3Vis1?=
 =?utf-8?B?cWp4MVk0alJHd0s3SEV4ZGdUbVRHWUdCa0V3N0tqZ0xWSTZRMmxrYjNRUTlp?=
 =?utf-8?Q?/JXk0Sgw0egeFB3Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB0C0D391BD02C4F967B756088154ABD@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6192.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7fc880-5123-4695-bfe5-08df130c5502
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 09:32:59.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrvZsnb+oz+dGTfOc3KZqO02WJT91PKLRVp45BMD7CzQ7XDd1nEF1WXF7JrZF2iP1GbXvoClYFnnHx4/h5id4A9pNFTeUTQr3j64YLF66Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6612

T24gOS8xNS8yMDI2IDI6NTcgUE0sIEppYW55b25nIFd1IHdyb3RlOg0KPiBDb21taXQgZDJkNWMx
MjlkMDdlICgiY3B1ZnJlcTogTWFrZSBjcHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGZhbGwNCj4g
YmFjayB0byBjcHVpbmZvLm1heF9mcmVxIikgaW50cm9kdWNlZCBjcHVpbmZvLm1heF9mcmVxIGFz
IHRoZSByZWZlcmVuY2UNCj4gZnJlcXVlbmN5IGZvciBjcHVmcmVxIHByZXNzdXJlIHdoZW4gYXJj
aF9zY2FsZV9mcmVxX3JlZigpIHJldHVybnMgemVyby4NCj4gDQo+IEhvd2V2ZXIsIGNwdWluZm8u
bWF4X2ZyZXEgbWF5IGluY2x1ZGUgYm9vc3QgZnJlcXVlbmNpZXMgYW5kIHRoZXJlZm9yZQ0KPiBk
b2VzIG5vdCBuZWNlc3NhcmlseSByZXByZXNlbnQgdGhlIG1heGltdW0gc3VzdGFpbmFibGUgZnJl
cXVlbmN5LiBPbg0KPiBzb21lIHN5c3RlbXMgdXNpbmcgYWNwaS1jcHVmcmVxLCBjcHVpbmZvLm1h
eF9mcmVxIGluY2x1ZGVzIGJvb3N0IHdoaWxlDQo+IHRoZSBmcmVxdWVuY3kgdGFibGUgb25seSBj
b250YWlucyBub24tYm9vc3QgZnJlcXVlbmNpZXMuIENvbnNlcXVlbnRseSwNCj4gY3B1ZnJlcSBw
cmVzc3VyZSByZW1haW5zIG5vbnplcm8gZXZlbiB3aXRob3V0IGFuIGFkZGl0aW9uYWwgZnJlcXVl
bmN5DQo+IGxpbWl0Lg0KPiANCj4gRnVydGhlcm1vcmUsIGRyaXZlcnMgbWF5IHVwZGF0ZSBjcHVp
bmZvLm1heF9mcmVxIHdoZW4gYm9vc3QgaXMgZW5hYmxlZA0KPiBvciBkaXNhYmxlZC4gV2l0aCBh
IGZpeGVkIHBvbGljeSBsaW1pdCBiZWxvdyB0aGUgbWF4aW11bSBub24tYm9vc3QNCj4gZnJlcXVl
bmN5LCB0aGlzIGNoYW5nZXMgdGhlIHByZXNzdXJlIHJlZmVyZW5jZSBhbmQgaGVuY2UgdGhlIHJl
cG9ydGVkDQo+IHByZXNzdXJlLCBhbHRob3VnaCB0aGUgbm9uLWJvb3N0IGZyZXF1ZW5jeSBsaW1p
dCByZW1haW5zIHVuY2hhbmdlZC4NCj4gDQo+IEFkZCBtYXhfc3VzdGFpbmFibGVfZnJlcSB0byBz
dHJ1Y3QgY3B1ZnJlcV9jcHVpbmZvIHRvIHByb3ZpZGUgYSByZWZlcmVuY2UNCj4gZnJlcXVlbmN5
IGV4Y2x1ZGluZyBib29zdC4gUG9wdWxhdGUgaXQgZnJvbSB0aGUgbm9taW5hbCBmcmVxdWVuY3kg
aW4NCj4gYW1kLXBzdGF0ZSBhbmQgY3BwY19jcHVmcmVxLCB0aGUgbWF4aW11bSBub24tdHVyYm8g
ZnJlcXVlbmN5IGluDQo+IGludGVsX3BzdGF0ZSwgYW5kIHRoZSBoaWdoZXN0IGZyZXF1ZW5jeS10
YWJsZSBlbnRyeSBpbiBhY3BpLWNwdWZyZXEuDQo+IA0KPiBVc2UgdGhpcyB2YWx1ZSB3aGVuIGFy
Y2hfc2NhbGVfZnJlcV9yZWYoKSByZXR1cm5zIHplcm8uIFByZXNlcnZlIHRoZQ0KPiBleGlzdGlu
ZyBjcHVpbmZvLm1heF9mcmVxIGZhbGxiYWNrIGZvciBkcml2ZXJzIHRoYXQgbGVhdmUgdGhlIG5l
dyBmaWVsZA0KPiBhdCB6ZXJvLg0KDQpBY3R1YWxseSwgd2hhdCByZW1haW5pbmcgcGxhdGZvcm1z
IGFyZSBvdXQgdGhlcmUgdGhhdCBjYW4gaGl0IHRoaXMgcGF0aD8gDQogRnJvbSBhIHF1aWNrIGxv
b2sgSSB0aGluayBubyB4ODYgb3IgQXJtIHBsYXRmb3JtcyBjYW4gaGl0IHRoZSBmYWxsYmFjay4N
Cg0KPiBUZXN0ZWQgd2l0aCBhY3BpLWNwdWZyZXEsIGludGVsX3BzdGF0ZSwgYW5kIGFtZC1wc3Rh
dGUgaW4gYWN0aXZlIGFuZA0KPiBwYXNzaXZlIG1vZGVzLiBXaXRoIG5vIGFkZGl0aW9uYWwgZnJl
cXVlbmN5IGxpbWl0LCBwcmVzc3VyZSBpcyB6ZXJvLg0KPiBXaXRoIGEgZml4ZWQgbGltaXQgYmVs
b3cgdGhlIG5vbi1ib29zdCByZWZlcmVuY2UgZnJlcXVlbmN5LCBwcmVzc3VyZQ0KPiByZW1haW5z
IHVuY2hhbmdlZCBhY3Jvc3MgYm9vc3QgdHJhbnNpdGlvbnMuDQo+IA0KPiBGaXhlczogZDJkNWMx
MjlkMDdlICgiY3B1ZnJlcTogTWFrZSBjcHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGZhbGwgYmFj
ayB0byBjcHVpbmZvLm1heF9mcmVxIikNCj4gU2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPHd1
amlhbnlvbmdAaHlnb24uY24+DQoNCkxvb2tzIG9rYXkgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBI
b25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCg0KPiAtLS0NCj4gWy4uLl0N
Cg==
