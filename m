Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBF370AE0;
	Mon, 28 Sep 2026 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576761; cv=fail; b=ZjYb2AefkBh46lEuE1N9nAbvqnsFfMlU8Gu/LW0b6MpUOsDIwOigoy0oHyKaHkGcZYdiKGWepoRb2vCpPkDv9o3p+ejls9vinYFsfW6sRK50HHTbbgOke5OgL+IO/FCrSy0dvuC51gt67ltaENMYqrOtxEyXwqAn+R6LGJlB+Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576761; c=relaxed/simple;
	bh=jLE5trAGQNS8FPpMJy5KmoAm6vkQhG7/P9X++CVb3iM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FglsMXO+h6YRLJraYNLO3PuBk8mNleAzKJDNSB2IybSlzZ++pFhZ3o+4ARfHHWrz7uNVfcN6lG14sypyFiGncvRu2FWMOSKZJuDEuNrTHSnU4XHkeMhwYcaKmPbFknMtyioHnJnZbbUYF2YvYoxTxO/H1aFqh16uLzMV+SlgoFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=scnjr/ux; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="scnjr/ux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vepUIoeLMzYwj8+SfqXxotDrWXTNnSZ3AUc6ZXpSyETUTi5HPkNPTrCujLAiPHXXKaQcv7QGhpCF9ZZW8nRKTLdEcgb9UXzNqDRizf28/qlrzflbZGMIhf4ooUl+IG3f6djK3uafpUIg7FL2YQNmGYarW4DS3hrYeSHXkgUUt121mCWKCF0kZE7s3vtFXQKsAVDdh8vtZ1wyix4CX843YRYuovMjklBJfiYXvyrcneMU8rprr6xfXtvhszDD28M2yqA4oxiRXeGjkK+2ms5oRg3wugNfSVc5eWAb+RJMK9XnV1ZlhHdeB7g7fhLW0SoBHsIoK2g4+8IcbjcNZLQ9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLE5trAGQNS8FPpMJy5KmoAm6vkQhG7/P9X++CVb3iM=;
 b=J8Mn+hPDAs9cKNm+nJTWsOdqFII8Kqs1j1LHdeSxzNrfXkz4ilBPVmPH+wDQEZOdkJXerAyPrvOxJfmn7BSBcWfWN4KvXGX4snTpZpDFWYNbPtk2Ye0MJV2zGtNbDJozkZ2CwtzvhOCsUCkmm3+uWZLgyzBvdxCdan/J70qTRhrP6NEyIx7vhvq/K13Jw4tCit//6VZl/YF1tfwR9VNuwB/Ma+EMHQAz2h4j+gDJaY0vc/TBCtOllgIdAJLCU3eZ/H8Rz+6aajY+RWcDYL0xmxtq+L3iFr/abmUeN9XuO8sejfet1qatf5/y+Ta+hxyi69dBSMdvJKyiXJXXsjE85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLE5trAGQNS8FPpMJy5KmoAm6vkQhG7/P9X++CVb3iM=;
 b=scnjr/uxjb5OCCSe+WRQAds0KssntQyDc9q7uenpmUkhHilEVVoF6I69UfB1/8jzqW5HqhhsqNGsFRlyImUjF1Xu7y+Kfzj8rlLmuh207RLSlUepn0cAfo/+z7zAM40Ts4hoSj6ub1qvqNu9mMxDahg4Ndug5N5funFdURBw3so=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9602.jpnprd01.prod.outlook.com (2603:1096:400:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 06:25:55 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:25:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Topic: [PATCH v3 5/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Thread-Index: AQHdSkrFUKNDtUT8O0Gh2LmYzN+hKLbjihqAgAADpvA=
Date: Mon, 28 Sep 2026 06:25:55 +0000
Message-ID:
 <TY3PR01MB11346192394192932538FABD3868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
 <20260922042707.116378-6-biju.das.jz@bp.renesas.com>
 <20260928-controversial-foamy-tanuki-7fef04@quoll>
In-Reply-To: <20260928-controversial-foamy-tanuki-7fef04@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9602:EE_
x-ms-office365-filtering-correlation-id: aa0bac19-3f15-43c2-0f44-08df1d295a10
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|38070700021|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3onrzVfK4pu03PCFWAMX2Rq+0lBUKQaVGPo7Iaq+u6d7qOEHOEwc4gox3HeE2+vFbGYr3x1Af81XQdf2oIqnB7XSAHFunBhNXCsGxoQeGu/g12t0Z2dhDz9V6rdaU27LbWqsvS2kOQodsvo6ZuPelFUS6nuQ7POBHYuBUNeD+FodHwGR+m1OQ+eOo8wimN+PJd2IvLF3ADN/EfpMYCe7Fp7y3ytingiZQ+Pzi5ScSwo5Nm48fY7PYouBkurMG2h0+8ponPCYCExvThFpEszU2c4Jki6/6/pjAgT2BCFEmMBA1hMUyvYCRoy7n4qeLh4KAJ9b0DYsf0bory+NVFLqPbNc0lPcXnIp4NyBY3FcDhjBh4yffDXGbKm8sP63FGaI+sOEBzWn/EJ03c5hJ/fiSvffQycvzMZ5R+wBgwQLsj3tvZdLp8qX8f6a1IOHo4TfqZELfWa2L2L1X9stCFsVVOb3Pglccf7YukfaRD9X+OyKrEZVJfpggZl9F6KfZrlqTn5yuNNDjZo8zEQp42TlxE+XKo8taAPEdbSOFRikZvkC5NhFTAEsRlKzxlmDh1HdcMmMCamwoaJUYQDQVP5lESAdBFI6jFaALngO2rJNm138svj+OrSBQ4nbBIh+kndKxdB7dcYVhoj9jksn8nB43Us7X7c9EYvXpUbnGR5/1ZH/u6CHhzWeHFeqixvr6ufBs5V5cvPMict4X0wbADOprlPI5KUUPua7qo4yJ0FiagE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1gxZXdmeG8zeGE5L1M4dGl5a2xOV1grWldpbTVseEc2Tk1WQkp6NDhxWlor?=
 =?utf-8?B?SEZWd1lQcW9ndnYvT3c1MXRQZUI1enV4OGh4OSt1SUtJSW4zR1hBVTdLeHpU?=
 =?utf-8?B?ZW01NDdYekZNL05NUHVJZjdMMGx0WFZiM1hOYmdQaVpoWXRwdkhmRTFtRzVK?=
 =?utf-8?B?VGc3WWxOVStad29NTkdjWjRwSkY0cUlzMWt4RjBlMGVnRlJUWURpK1FDY1ZS?=
 =?utf-8?B?aWpwTXlDN21QdFBNQVlBa2VreGdBRWRnSTNwY2QxV3VSKzR0Z3ZRMm1Sd2Q2?=
 =?utf-8?B?YzZ4NktIak5GRkdJVTJFdjNwWk5ZN3ZPVWp6cUJSdk0yVXJyOFZrdTVERlVj?=
 =?utf-8?B?d1kySXJ0VWJpTk9xamxiL1ROOXFQU2ZqdDR6eFEySzJnSTE1eWgvSE9TTklJ?=
 =?utf-8?B?VmRqS0hyOXdoNnA4WktGSllHaVJHN0Y5L0JweDJyejlwUFdEblpiVFcyTUZQ?=
 =?utf-8?B?cXRNL2NaN1pFNkliMUNySVpqSWdwemt3bzhCVEtJWlRGcm8wSkFXWmJxeGVV?=
 =?utf-8?B?UGhwdUljcnY1NUF4cWw4NFhQUHQ2Q2F1YlJITUZIOWJ5dlhrdUpFQjRzU2Y0?=
 =?utf-8?B?c1QwWjYwNmwyajZ0aEtWOVdsNmJDZm9BT3doUWIyZ2NhZDB4bU1BZEdGWEVQ?=
 =?utf-8?B?bzhYeHZZRVdTQTdHVEhWZCtubm9CMTl4NGMrRWpMbmM1alpiRlRZMTMyeXJr?=
 =?utf-8?B?cjFqVjJKeEl6WGc1TGxSY1JpQmh5dWxNME15eENOQlRXQm5VUngzRkppV1kw?=
 =?utf-8?B?cnNUclZidk9HYU5aU2FhcExwUmVSL3VNTk55SG5Ea0F0N1NVOWt3YkdLN2Z5?=
 =?utf-8?B?ajl0aTlBSG9iMUdRMUdCWnZCWUxjVThaRlhQU3RCckw1STBEdG5SUm1CTG9w?=
 =?utf-8?B?OTZpZFA2R0V4Z3UrNkFoNXVPR3N3Q3RyODArbDZtRjNSL2c5VHkwdHQ3VkVM?=
 =?utf-8?B?ZGpSS0pUMUZvZ1p2TWEwOWpqdWZGb2RrRUFUS1VYVmtJMGVZcVBnT3BuL08v?=
 =?utf-8?B?a0Z2U09HMnN3eHZuRkNhREI5R1M2dDJVS1gwcXM3bTNpL2hBQWRFSDVDUHlx?=
 =?utf-8?B?bFJUYUxXTEpRQnVHMHM1U2pIUCthSXdUeWhrT1NKTS9XQlFnNkVZQ1VUck0y?=
 =?utf-8?B?Wm9OVnBUa0EwcnQ1dTNlYzRmV3ZjYXJnMjhLOTYzd1hvT1J3R2JYWDgza2w3?=
 =?utf-8?B?T1ZqQ0FtUjh4SVBTalAvWjdiTTdURVAwRjVETGRzMW9FbXc2L2dmQWNGbmJq?=
 =?utf-8?B?aGxicExvSlNxa1pGZC94eThkMkVqRWJUL091QWh0bVZOUk83YWVJRm9BT1hG?=
 =?utf-8?B?ZXQxRExpaGkxVGd6TndlSHU1OTRTMVlZVjV2OG1QcDZEdHRpbjJCSTJPdDhi?=
 =?utf-8?B?am1Iait4YjIyRFZ3dWtRREdsdlVxNENWNmRwZ05aNWFXSUQ5aHNLUWt0a2NJ?=
 =?utf-8?B?aHdkbStsNTM5NHNMMEg4Vk1NRFV0czVLV1J0V2t5Z2FjbmZkNlFDSUdhMzZE?=
 =?utf-8?B?NzE0dU01WEFodmFrNWVHcXFNWHhoOHpEejBVYnNLc3drcUlLNjdFQlBnWktM?=
 =?utf-8?B?SzdIVmFiTzNJbkVXbTVKMXBmZmtJM2lBdnA2Vm10dlZtVlVNMlJ3UG9GMlor?=
 =?utf-8?B?N01aZ05GM0w2VTZpR1llZEhlTHg4RC84NjRMMlRLUzM1NVVkNllnanZKUVZL?=
 =?utf-8?B?UnJMZVZyNlFQbWlBWHFhRVh2Sm1KMzdWMnNBRSt2bTc3T3FOVVcyb2hrVEVx?=
 =?utf-8?B?TEM3cnJsaHVzYU44ZGpRRngyMjJ0VDFDMUw0dUo5czNxU3NVdnJhT3VQS2Nr?=
 =?utf-8?B?dG1wZGpqQWVWOTVTNHVMaDc4VS8xdlQ4YmV3S2JCdjArQ3J3OHV3MkRYZXJI?=
 =?utf-8?B?cHlXcU5qeWliaFp4UDJmV3lTRGFzdTJCa0VBbGxUaVBZUTR2ZGMzcjR3N2Mr?=
 =?utf-8?B?V2pxV2NMaXRNUThEYldhdXZFSGVud1BsQU8rbXJoRnVnRWxwVk5JNUpOUG5I?=
 =?utf-8?B?VWRaUjAvOVZRd2NidlJpaloxR0FhNTVrSkV0cGNhVVRYZ1J0bS81MXo3QS9r?=
 =?utf-8?B?RTVpN1BPb0VxWHZ2bTBtWXMzdU9zYUY3aUpsenlYaFU4dzBBSzZKRmVONFFM?=
 =?utf-8?B?ME5iNTN0N1RlWFByVmIxZHlRZnFzQkFRWlhIYmJ6Wm1hOEQ1TWdzU1hhc1Rm?=
 =?utf-8?B?YkZSV2ZpcDVpZTVLWFdtWXJrd2owQ2dTTVgrSks1M0xXdm55ZS9uZmlMS2M3?=
 =?utf-8?B?UldRaTFqUkJsaDQrTkJ2Wk1lWGxtenNrWlYwNkJYLzFnSkdCYmJtQjlNd0xX?=
 =?utf-8?B?UFdhKzJQVjQ1T0xQa3YvSFJyYXRUbHVnalJkMVBiZTM2L1U1TVovUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0bac19-3f15-43c2-0f44-08df1d295a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 06:25:55.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4UbOBUJGggOw3/cTqwxXNDrKyJICsbfW/1SnQmJqyF3AQW55qdKzRJqqTrH+0RmIQut9yKQr0vFCWR1oZYmQq3agZro236jzHNJ+rBz3lcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9602

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyOCBTZXB0ZW1iZXIgMjAyNiAwNzowNQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDUvOF0gZHQtYmluZGluZ3M6IGlpbzogYWRjOiByZW5lc2FzLHJ6
ZzJsLWFkYzogRG9jdW1lbnQgUlovRzNMIEFEQyBmb3IgVFNVDQo+IA0KPiBPbiBUdWUsIFNlcCAy
MiwgMjAyNiBhdCAwNToyNjo1N0FNICswMTAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBBZGQgdGhl
IHJlbmVzYXMscjlhMDhnMDQ2LWFkYzEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIHRoZSBBREMxIGlu
c3RhbmNlDQo+ID4gb24gUlovRzNMLCB3aGljaCBpcyBkZWRpY2F0ZWQgdG8gdGhlIG9uLWNoaXAg
VFNVICh0aGVybWFsDQo+IA0KPiBJcyB0aGVyZSBBREMyIGluc3RhbmNlPw0KDQpUaGVyZSBpcyBu
byBBREMyIElQIG9uIFJaL0czTCBTb0MuDQoNCj4gDQo+ID4gc2Vuc29yIHVuaXQpLiBVbmxpa2Ug
dGhlIG90aGVyIEFEQyBpbnN0YW5jZXMsIHRoaXMgb25lIG9ubHkgZXhwb3NlcyBhDQo+ID4gc2lu
Z2xlIGNoYW5uZWwgKGNoYW5uZWxAOCksIHNvIHJlc3RyaWN0IHRoZSBhbGxvd2VkIGNoYW5uZWwg
bm9kZXMNCj4gPiBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFz
IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiB2Mi0+djM6DQo+ID4g
ICogRHJvcHBlZCByZXF1aXJlZCBwcm9wZXJ0eSAnI2lvLWNoYW5uZWwtY2VsbHMnLg0KPiA+IHYx
LT52MjoNCj4gPiAgKiBObyBDaGFuZ2UuDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9paW8v
YWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwgICAgIHwgMTcgKysrKysrKysrKysrKysrKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9paW8vYWRjL3JlbmVzYXMscnpnMmwtYWRjLnlhbWwNCj4gPiBpbmRleCA0
MDM0MWQ1NDE3MjYuLmYwOGY1NDM5ZDEyNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9yZW5lc2FzLHJ6ZzJsLWFkYy55YW1sDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvcmVuZXNhcyxy
emcybC1hZGMueWFtbA0KPiA+IEBAIC0yNSw3ICsyNSw5IEBAIHByb3BlcnRpZXM6DQo+ID4gICAg
ICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA1NC1hZGMgICAjIFJaL1YyTA0KPiA+ICAgICAg
ICAgICAgLSBjb25zdDogcmVuZXNhcyxyemcybC1hZGMNCj4gPiAgICAgICAgLSBpdGVtczoNCj4g
PiAtICAgICAgICAgIC0gY29uc3Q6IHJlbmVzYXMscjlhMDhnMDQ1LWFkYyAgIyBSWi9HM1MNCj4g
PiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDhn
MDQ1LWFkYyAgICMgUlovRzNTDQo+ID4gKyAgICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA4ZzA0
Ni1hZGMxICAjIFJaL0czTCBBREMgZm9yIFRTVQ0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAg
bWF4SXRlbXM6IDENCj4gPiBAQCAtMTIxLDYgKzEyMywxOSBAQCBhbGxPZjoNCj4gPiAgICAgICAg
ICAgICAgcmVnOg0KPiA+ICAgICAgICAgICAgICAgIG1heGltdW06IDcNCj4gPg0KPiA+ICsgIC0g
aWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4g
PiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBjb25zdDogcmVuZXNhcyxy
OWEwOGcwNDYtYWRjMQ0KPiA+ICsgICAgdGhlbjoNCj4gPiArICAgICAgcGF0dGVyblByb3BlcnRp
ZXM6DQo+ID4gKyAgICAgICAgIl5jaGFubmVsQFswLTddJCI6IGZhbHNlDQo+ID4gKyAgICAgICAg
Il5jaGFubmVsQFs4XSQiOg0KPiANCj4gV2h5IG51bWJlciA4PyBEb2VzIGRhdGFzaGVldCBhY3R1
YWxseSBjYWxscyBpdCB0aGF0IHdheT8NCg0KWWVzICwgSGFyZHdhcmUgbWFudWFsIG1lbnRpb25z
IGl0Lg0KDQpGb3IgQURDMSBJUCwgdGhlIHNvdXJjZSBpcyBBRENfQ0g4KFRTVSkgZm9yIHRoZSBB
bmFsb2cgSW5wdXQgQ2hhbm5lbC4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=
