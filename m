Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F74F85A0;
	Tue, 22 Sep 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078529; cv=fail; b=npbRns61PAoNyusVxhErJYSr0xB1R3tvcGPYglz1y7sGQPdiF2d8IwITbGovxuU1TMfHt292bkV1lOpW6SoByt4U4SuTi8oiSzJygv9n3wjFOn0FbcJ+iODDdb2Ng4aCR4d/8q/+c3OYovQcR+iJIfbpmzdn1VWcKcme7sIVf6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078529; c=relaxed/simple;
	bh=tnSoSGnslUooeiIJxmfzk8wCL5Vnr/nNAAVwmFaaHAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffAkhweIWlEZORt17olYHw8Wsovyv7A4GkInUDNFanL8x+nf/kV87p78/hw1q3L4XxOt1BF8jnwi5RVUT9shPKBUNlCYR5ZbuUvEwHK7P64jm6inRU5LjBJtUoswEf4tyvZ9rfgzAZR+iLYVm0AA9dayiVGNndQ6pOZ7ADyi6zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nuDRvYcT; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nuDRvYcT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9NP1v8HrhiJKEx45jk1Es+L9113otcigUgM/E4OAsYpZxjm6M07J3cgTk+ynBiyXjDRyQ6EkjzWtCWxuKgsUtb+r0TH/xLk0xw8ynzcip31PRipUu0P8PVe51NbNsNqvv91GqLu5dT1m7C/iTS+W/Id7+BtW5cGgjKWZyTlPl9k83AJg8P+9p28+2jbR/1c22eAH+9RalkkmNgM/hWZXqOQa9d5jqonSf21b1Em9c1TOC96IQKrc4hGh71a1a2kZDrv+H96qLAsnrMuOZy9vseMnre1Jn2xhFw4giSa1wjmn0h0IheLL4YjZbCynbcMAH+63V8njWJeQuyzcxhcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnSoSGnslUooeiIJxmfzk8wCL5Vnr/nNAAVwmFaaHAY=;
 b=fPb3Ns5TghVocfKQXea9KctxN0BJpAgbZkz8ylf6uikj0AXoOHVXcdljniD55SIFUPKubIqOm5zxeRCWrEJvFWJdhTIv+KCvp2k4vXy+i2kbTiIwPpkte+ETqr/FCFx6kdWCad0vTwyXmc7MUFl79Cj1kqdIBcyqdy4veUD3jQGycwlBbfBP4ILGcWyjW6TFbDKdXML1QEbX0tPTOxW7sIO1e7Cvn4UnCOXU/w85MlakGCSpADzfPnmGtY/Y3jP+vd7J4tYFQXRl9AeAqy6yrMvEel0LQhkJBL9ruoZ0/+ZmasMV9dz6wuLJQqSnu//iHmmLKhgXDIRwgHrsb9e0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnSoSGnslUooeiIJxmfzk8wCL5Vnr/nNAAVwmFaaHAY=;
 b=nuDRvYcT3cCz3lC5yLvPz96jpja/jWZguMIGXlCZdh1hLpTNNTVK0uRblM2K0mx8vrsGYvghvUw7KJlbG1rSEZYyR8NmKigK/C9mwVGFKd59bxQzMOCpCfdR5jD7lSL30ShGB8KaYgpKfdE0537m7QbYUg1VXpieiEqxn8sKYkF6HweNGTBKJ2eWwAxVMianoEy3SzIywOU8yUQUij2tuA2hqb9MyZIvUtM+qTRJbVXnjGONBJl5KNGzuADvymY9T9GaaM55jltZSzcy7uYg8tlWN+9RKvQ8S/cu6XZuqL0XhuC218SdP1BS3p1jB+q04+KIgnih2TlPz2CJTdp9og==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PR3PR10MB4064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 12:02:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 12:02:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bmasney@redhat.com" <bmasney@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 3/4] driver: core: remove dev_set_drv_sync_state()
Thread-Topic: [PATCH 3/4] driver: core: remove dev_set_drv_sync_state()
Thread-Index: AQHdSootqSqtWqfmIUyFPC0Fb+v8SA==
Date: Tue, 22 Sep 2026 12:02:02 +0000
Message-ID: <d36835c319b8c92e20d981b1e59c169416da3f9e.camel@siemens.com>
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
	 <20260626-clk-sync-state-v1-3-4156d8196dc8@redhat.com>
In-Reply-To: <20260626-clk-sync-state-v1-3-4156d8196dc8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PR3PR10MB4064:EE_
x-ms-office365-filtering-correlation-id: 17beb6b0-b58a-46af-e284-08df18a1502f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info:
 0//oUsRmHrHFgXiPYbHIxgh8IEojiKybS487pWfjwpmKQdNdDyUZg5f3JmbUZf0FkQXHfSNHXSEXAAP2zLUp+1Vfxek0qTbVCr1SzO57Q9Xw9JS1Y9OuGyGgHKOsNU517ZPYnkAH0CSMam8uW7Hj7Q9owN0p9Y5INrldwruRPzfak8QrMM3eZKd3rNm9rQRQpcc5k1VAwJ9BfHkLkWGsbc/+bdOt0J+mK5XcPU5NSpstOK/MbUeHWzQDgFmQafEh6woL+jU7u2xq8yIe+vjAsF3148dc2Nx+Io/nsO4tnGUYoP9489G7293W5sqiEFYytEBQCR0tobV5lBQFn2x2WRWiZkqluABcjuVEBQe8pKy8wXEi3Q6DrWMN/L6Mp21Jbpdxyy2haOcZIn2SDGR0z+gZ0FHCMWFYXbFiWJfuJEF04MKtGIiOD5aChqYX+LJz9cqIMEEsaBMWJnkaQ+tKqG5FpbC9+D37/ECCfW8aVx8DYQExDz94XeK2ZMo3U79fiU2maXk0oI7BxK3qL2c7i2zCI2Alc6pStM6l6KzDYpmBUYg8AXOVD8htq7LSCVx9tftljNUPx0NPWbqesXx1pNRvWRO4QTruXBfqDgLaZxvWYy4M8SlJcD9mKv2yeDmcDPpXmCeArQVmC9rxQfG+J9/l7gNFWE1njpjb/34WomI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nnlza3NMclcxK2ZHY2U5WlhQdzJ0a09JYmgyc2ZoZ0hBODRRT3BoaklwNU5r?=
 =?utf-8?B?cHYwWXdOemdlc2I3MmdXZnl1YlJSWTBtWlFhVTJSNVNrdVJ3b0twSUZtNzBX?=
 =?utf-8?B?QzlsZVo1V2hiQ0RWSURMa21SWjk4MlZWRWdkTThmazkrdjdHV01vRmJHRjlh?=
 =?utf-8?B?bm9qWllCTktsNFMzSHAwMFhaR0lVNDEwQkFEb2pua3lIOFBFWjQwNnI4dkNv?=
 =?utf-8?B?a01GS0VzcWtrTEc3bXR0QWxwL3NrZ3l0UmQ0TTVLYS9QM2FtNUdvZGhsYXBy?=
 =?utf-8?B?NGlUeG5JbWRSOGp2Ly9wS0NPVXRyaHc1YzdQSXlDSjFZVER6TTh5aUZlZS9U?=
 =?utf-8?B?UUVJWVlJZHpFYldqMzYvUVZOWFhIQ0dTemErdnRlT2xzbEwyOUoraVRTVkI0?=
 =?utf-8?B?NnlyZWpVTGNGL0Exbi8zOTNBQ1k1dk9oTXVFS3Z1VEdNWnFJb1owNjFmRWRu?=
 =?utf-8?B?M1RKNmxucnI0WFd0d2NhY0FUcjZCcERLS0tKNkdvRHVqbFFJV1VEVHZvKytB?=
 =?utf-8?B?TVpTMlRvSEVjWVlxNjhUZHdCbE4xYjdFbERFK0VJcEpFTUZuVFpDcHk2TlhY?=
 =?utf-8?B?ZXN3UUFWaVNOU3llWGpiWTJjQlRRTHQ0RlFHRUNZWkhVU0RvRHpzN0kxclBk?=
 =?utf-8?B?dFRlQ0s2NXJqTkRuOUU3b1M4QUdmQ1ZVNEZEaURqajRxd252OTEyNktTUnRN?=
 =?utf-8?B?czZZcnI4d2RoOXJUWDloenNxK2RUdEpQQVQ5UTJidi9VekRid2N6dEZDbVg5?=
 =?utf-8?B?RWgybHRxS0doTWZGclJUTzJuME9FaFNmeGpsbWpaVTVsT0tmUkc4a0IreHZj?=
 =?utf-8?B?dksweDFUSExWdk1rNnhFNVc5SU9GM01SMDJaMmV3SnRaM1pMeWpuM24wRTNh?=
 =?utf-8?B?NEY3N1FOd1BmVzc4THA3OWZzRmpvR3hFSHhDQTBwczY0ZDhLOURmMEs4UEtO?=
 =?utf-8?B?bkVvTWhrUFRYRVllMUluZlhqVFNOWkk0WmpYQ0tzNEhpY29mektkSTFseTRt?=
 =?utf-8?B?YXc0d2RNQVBSQXBIbUVEY0d1cGFyVEFSVGVMVE9oSURXSFByUUJqSHVuZ0s5?=
 =?utf-8?B?RjU2S0htNHc3YlBWMHl0V1hCR25YREpyNXkrWGpkTXdwUXc0UlVsSytscVR1?=
 =?utf-8?B?WU1SYmtHS1pLdVlzRE1LTUJJVW1zZFNMSEIxR0R3ajAyUEsrRjZMa0h0WHZZ?=
 =?utf-8?B?Q09Ba2NaMEkyMFpFUC91cTFiVWFSUVBhMHdTdTNydCsxOEhrTGlhNU5aQTBz?=
 =?utf-8?B?YTZQQ1YzQThHaExqWVY3ak1tNyt0MFVtMUpyc3BSdnFXQWRqeWp1a3g0VU4z?=
 =?utf-8?B?VFc3ZkpRdFYvUVY5NTlhaUFpVWlFT1l6M2JEdWpNUjhKVjVtaFJieUxnSExv?=
 =?utf-8?B?MlUyZEV1cnZIclliNEN6WURMUXN3NUh0RUx1V3pDYnBuUjhHUEJTRklIMmxm?=
 =?utf-8?B?Z1VCdzR0aEZJUEZjbXM4ZG9CNTFzVjJkU1RRV2U1Z0wrWCt5OGxxNWdhZ0hP?=
 =?utf-8?B?VE4yOENZb2ZOUnRKaUsyTlp4a3RSRUZuTkpEVTFpeWZWZ2tVQzdBQXRKS0ZT?=
 =?utf-8?B?Njl5ODYvc1pza1BkMGNmZnhTUFRVVUs0c0Nyc2hyNG5qeEY4VW9ndTNCclpY?=
 =?utf-8?B?QlFCdW9odEFhVE9HZlpORzRnT21DZFk1Tkg5OFFYRVRCWjRNODMzdVA4Slk4?=
 =?utf-8?B?VXNuUnV0MklZaWtMNUdFbWR4VVRRQ2V1VStTSEkyNmI5eXdhdllEMGR1ZkVR?=
 =?utf-8?B?ZTFrY0RadTZmZGluNkhjTWNBOVBIT09pRXdKL0RqcExvazBGRnh1V3Z1ZTla?=
 =?utf-8?B?em05UlVvUFBjYTFOdktSNEE4a3RLcEFKb1dFVEpJUUpjZzNQOWFzaGVzcGtu?=
 =?utf-8?B?Mm8xWVlhSWNRVlZDaTBpMU9CSXliQ0JFUVhzSUQyczdJbk5abDl0a0c0SlI1?=
 =?utf-8?B?SFkxVjl5VjVUMXBNZHNsemtRMjRuNzNtR0w3SFBiOVphd2s2R3VDc0Q2VmlU?=
 =?utf-8?B?dUdIWHBRdEgyYjhGT1ExaE56WGMyL0VWTlgvQ0RVSmxPbVN4Q3ZGRWZsbFlJ?=
 =?utf-8?B?dnRWRGZpRG0rYnVCdTF0UVRsaWRpNDVhdWNhRldRS0NHcDJQN2ZvUlZ6T2w3?=
 =?utf-8?B?R1RCVjJPNE42dVJGdldDQWhSVUN6ZkZvSFFBMVllWmxBTXFSMGxLNnNEN1Js?=
 =?utf-8?B?TUFzNkIxeitER0dsUlFVV3dMMFExallzc3F0dnJleVJncGY3K0lHWXk4b3kz?=
 =?utf-8?B?STRWazc2VGhGSWJxdG1YOU5IWkJJK1VJYWIwd1VFK1FtMTJVSnFTWkduaExz?=
 =?utf-8?B?ZGQ2SkdIOXhjWk03TWN6SjdpeWhhYzlVOWR5eGR6NlBPOU5pS0ZJbWN6MHpv?=
 =?utf-8?Q?pUwu/u/BGNHjCH+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82EF54846908EF45B947FD9F6A9524C4@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17beb6b0-b58a-46af-e284-08df18a1502f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 12:02:02.3959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEEiyTM3udpF72lrP1AfWnp/W0nFIWgSZJpEkF2D1GERhJnMvmbJ0q81e+qSeGgRpIVlUwWJtoC/VcWqj769Kgd2x9FBRa2Z92sxLu40EkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4064

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEyOjMyIC0wNDAwLCBCcmlhbiBNYXNuZXkgd3JvdGU6DQo+
IGRldl9zZXRfZHJ2X3N5bmNfc3RhdGUoKSBpcyBubyBsb25nZXIgdXNlZCBzaW5jZSBhbGwgdXNl
cnMgaGF2ZSBiZWVuDQo+IG1pZ3JhdGVkIHRvIGRldl9hZGRfc3luY19zdGF0ZSgpLCBzbyBsZXQn
cyBnbyBhaGVhZCBhbmQgcmVtb3ZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJpYW4gTWFz
bmV5IDxibWFzbmV5QHJlZGhhdC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9w
dXMtNC02DQoNCkFzc3VtaW5nIHRoaXMgaXMgdjMgKG5vdCBzcGVjaWZpZWQgaW4gdGhlIFN1Ympl
Y3QpLA0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGluY2x1ZGUvbGludXgvZGV2aWNlLmggfCAxMiAt
LS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZpY2UuaCBiL2luY2x1ZGUvbGludXgvZGV2aWNl
LmgNCj4gaW5kZXggYjdhM2RkNGI1NmVkLi43ZjcxMjE3ZWNkNDggMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvZGV2aWNlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9kZXZpY2UuaA0KPiBA
QCAtMTEyOCwxOCArMTEyOCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkZXZpY2VfbG9ja19hc3Nl
cnQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiDCoAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZkZXYtPm11
dGV4KTsNCj4gwqB9DQo+IMKgDQo+IC1zdGF0aWMgaW5saW5lIGludCBkZXZfc2V0X2Rydl9zeW5j
X3N0YXRlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gLQkJCQkJIHZvaWQgKCpmbikoc3RydWN0IGRl
dmljZSAqZGV2KSkNCj4gLXsNCj4gLQlpZiAoIWRldiB8fCAhZGV2LT5kcml2ZXIpDQo+IC0JCXJl
dHVybiAwOw0KPiAtCWlmIChkZXYtPmRyaXZlci0+c3luY19zdGF0ZSAmJiBkZXYtPmRyaXZlci0+
c3luY19zdGF0ZSAhPSBmbikNCj4gLQkJcmV0dXJuIC1FQlVTWTsNCj4gLQlpZiAoIWRldi0+ZHJp
dmVyLT5zeW5jX3N0YXRlKQ0KPiAtCQlkZXYtPmRyaXZlci0+c3luY19zdGF0ZSA9IGZuOw0KPiAt
CXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IMKgc3RydWN0IHN5bmNfc3RhdGVfZW50cnkgew0KPiDC
oAlzdHJ1Y3QgbGlzdF9oZWFkCW5vZGU7DQo+IMKgCXZvaWQJCQkoKmZuKShzdHJ1Y3QgZGV2aWNl
ICpkZXYpOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1l
bnMuY29tDQo=
