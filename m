Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022084.outbound.protection.outlook.com [52.101.126.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401D4192E0;
	Fri,  5 Jun 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651584; cv=fail; b=ekJU/DOmwHD7rVLutPZbP8hWCCngoLc2Y8hyEfTPjp9I3P3cKw6uPCIaRuUvIp1ev7kIHrVaSCRwFY2KOrEjhV+Q8jcAX/1uErAgiD+uEympDMKzBxEZ4YG6qJOA855OTEe4hKcHWSLKpXzY9MZTuce4xkv6jMrQxA8lP+/NLoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651584; c=relaxed/simple;
	bh=ZPE9Myk0m2F6jRutLcZwde59bRjG4/KcLzXwz7KCTmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m6vvJAi8zild10pMqQ0n302Hbcx5SVCjZ8YYQsvIh70H5LeWmymwDCTv1kszAqDRUB6LNxAevOH6l7UCPKRpua8ntZ9ABPAo1En7mTXsPSRloGH2vI3oHw+rnydTeVe5Od1+Uh6L/OSco4wP9Z4wQEk1brKNA5BG0cQQ4P8pJbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=E9dhNTkQ; arc=fail smtp.client-ip=52.101.126.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="E9dhNTkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0NZkXFdmlpalkvtU0V+4X1puKoL1kuVyvu5vMu6AIGSL8drI6dN7ziiCJTIlrzW5aFZ9b0b1eUDE87EpdoXs3K6hFAIk1et/c4hgkiAchPkYCTkqx5P8+K5C3ne4b/Ue9kyA+DuT+scRxLL9rGypUpTu+kpfZlXgbUUdh7Eey18mJksv182PXbr9sbphoN9e7lRtz91ZsSZi38gXZVmqNCDEyic1YOaloEoZgeMwy8U1RYRK52olOfTLmJ/vvIpwMLX/CXsri8GeQSwwF5wmRRcvOgcL/KnUQ6YutUUN13UC2fW2x028NhIkVub6CbPG6bHvlYolH/5UixDuIsYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPE9Myk0m2F6jRutLcZwde59bRjG4/KcLzXwz7KCTmU=;
 b=xi6fw2TXe6QbBUCiKj1YREIS3jn/tnEpVVWy/LVkoTyBsyBP3ZFATfKWAIaIFhS24WZ9ALxsTs+u5T8dMiJd0pArP7gA+WGD94X7vVxV55lSR+OEgmNPXYqIK/YOa0g8kiP+rxKm3ufTOtYIbs4wR0guSbQpsYHetKPQKeIsxsG1/upN0j/nbN9q7qaGX0hkHl1vI4dZwG6rg0eOS17nYHgcwDhZLweySQykAooOOiT3L+yK0/nqUx1Y3M8Fbni4DNaUIdWcLGOd+ua/79+QajbrtAWhumsnZ2TxBtwh5ZF7r0XBT9056tHuqW5wBk8Gk6afhk5IH15hVRkDqaBkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPE9Myk0m2F6jRutLcZwde59bRjG4/KcLzXwz7KCTmU=;
 b=E9dhNTkQCMt+58eI0bRPSdXcDe9wdrOOinxMfBFwYwqpUN61Sx04P/uer4GCLPrSySbURT+bKKSIefqL8+uJgUSyYLDVgCnMJTQ6bd7aopNOtxlOjYY6wVuMlbY9i6koXgQZwOtZ/buBx9ySOb/hM2mhYVSusIg5wq/lFGqa7+c=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KL1PR0401MB6348.apcprd04.prod.outlook.com
 (2603:1096:820:c3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 09:26:19 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 09:26:19 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Christian Loehle <christian.loehle@arm.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Pu Hu <hupu@transsion.com>, Jiazi Li
	<jiazi.li@transsion.com>, "qyousef@layalina.io" <qyousef@layalina.io>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH v2] sched/fair: Revert boost in cpu_util()
Thread-Index:
 AQHc7krMD0BpqZESjE6npLVWtH3psrYuDsMAgAAK1wCAAAedgIAACWIAgABDDYCAAOFkgIAAaIWAgAAGfwA=
Date: Fri, 5 Jun 2026 09:26:19 +0000
Message-ID: <dbd0c5e9-3a20-450a-932a-d0591ea66326@transsion.com>
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
 <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com>
 <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com>
 <CAKfTPtBJOtgMJLm1PhiLPFup9OWYLPCChumy5EKuLuEEbu2gYg@mail.gmail.com>
 <2886fddf-8f58-491c-ac27-e4d9b34b66ad@transsion.com>
 <8f5f944e-b150-47a3-b1e4-bcaac6151b7b@arm.com>
 <4adbab4d-f9e4-4354-aa1e-48f11b1fd208@transsion.com>
 <a92159ac-2fca-48bc-8efc-442b5924b3c4@arm.com>
In-Reply-To: <a92159ac-2fca-48bc-8efc-442b5924b3c4@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KL1PR0401MB6348:EE_
x-ms-office365-filtering-correlation-id: 9fbadd28-3cfe-4ffe-8745-08dec2e48062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6133799003|38070700021|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 zPUZOSzrEQqxyrBXTE3WdOpZkGwoMOukgMBg78zI70uTrEVOumwS4OZ8KvNZxCeLN4Z5oJk4zptEGK16m4B0gvJSAD6SJzec89+lJ4umctZKGWxlmNmV378SDQ5jMOajKg2XnDGeruC0mNIg+adLGbACsprMdXLoRrMkCKzb7VA+Bpp+QCksd8pWn5jkJHLaaXVKPDL59g980wEgxFM7jMFHc3JMI3e2cya6oa2GAp/7En/zgiErG0rKNcq3TS1I5gDwLObLRrZsRvey4AU+ADi7gTkdvoK4Z9SytKvFXCfmjcYhAs/xGSkwKCRIdxtgzjHmlc8DzU5BLbRCuSDfBVJXUFb4ragcVPAzBa8/9iotti8oKEJ+mCj8DKg3+YEKHaxQsfHUgCIdTlXJak9c9OUJ049qTOaAzECHsIZdu22abJWtU+MduTXpF2MUe6ghGr2/JyNWkmxWzxQIkG0HEnKbRU4YiV2CAawrUGp3BSVGm1txFsUWEmqUQD6hoqDNa4AhAiZEuRioZTrzudm1bqUUnFpWpr9Vdb+6Tdbhs7f0MIbJx/McDHQaQHgCtZvfB9nb7IvLrsk/XPYxXHlout0UGMfOG2oEKAY5ilrqwptbMU7f5uD4O5VECzks3PNzh6nmKS/iAWMq02a2e3Mv63ufaJ4jKCwUKh1ph3tvBnwRIgnjaOHRIQLYWMEOQh5w2KM1LWC9x25QpSaPvUHOx+uPAs87D75gEcwy7Liu/DR0BC1s97/KXfTpRbee0o+6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6133799003)(38070700021)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2JnOXhHYzFqcDBvb3pXSW1vNmU4VjMwNnV6enZhNkc1OXErb0dRZlJXUkxt?=
 =?utf-8?B?TjB1RnpCQlBhV0FRQm4rSXVSREhGaGhpeGMzbUlwU1crT0ZrQUVlV2dmUERk?=
 =?utf-8?B?eUNLaXc1SG83SzVPbXFaOWRuY3NDeGZaaXJmRm04bWlQVUFwRmVCRDBwMW9w?=
 =?utf-8?B?NTBFOFZ3dk9TTG5CTFRtSXpPdkJMcUg2dm0xVWdBSzl1cjZQaE54RlFCOUo1?=
 =?utf-8?B?Mm1oU1BFdEJTMUgxRkNlYWhxUklBbnQxRUIvWGdKM1NwdXpmY0tJSUtqYUxn?=
 =?utf-8?B?QkwwaW9JVVR4dDVYdEJrVUhyWWUwdTcwTlhHOHUrVmI4TjMwMWttdnV3TkNK?=
 =?utf-8?B?ODRCZzAxdXQyNzhGeXV3TkYvbzI2TmVFUWNzbEpJa1JZYlpWRDJQVzZGcFJV?=
 =?utf-8?B?Uks3bWV4YnFjbU84V3BWdDdDWUtPV0lvM3ZCVXZyZm5IMGxsR2JLL0dIcUc0?=
 =?utf-8?B?S0g5VURuVUwwVTdGYzF4czNodzlMYlRQRGxSQjJjaUFRK2JIOSt5WG4xak5W?=
 =?utf-8?B?TUJla2s0UFA4YXFGeHN6SFFTRHluUUo0bmxTZ0xLOGgxRXk3UHZUL2p5aC9h?=
 =?utf-8?B?TmlDbnIzQ3VsdUNacHJOOGRNM0tMMXh1RUJ6L3lmY1BDRmdQRW9KZzkydXh3?=
 =?utf-8?B?V3Q0TEx5UFo5Nm1vUlpaY2pJYzQvZk5SaDlDVzFZRTVkK1drdHpIUkt3TlBS?=
 =?utf-8?B?ME1vNjhrMzBEdjJ3OTdVUHlpelA3eElUYlZ5a3R0NS9UL3B2OWtwZCsvVHFa?=
 =?utf-8?B?NzNJaDB5UlFCZ3VzNzV2aUZUaDB1L2hUTVozMFR3VGdmVHIzRDh4ZGpiK2pM?=
 =?utf-8?B?VlRMVUp0bDRQK0FWR0MwcytUUGJwQy8waW9kWnRxa3UrbGZYK0wrbnRYRXQ4?=
 =?utf-8?B?RFpCaHZVMDJoUFBSMEdva1JacFJDNXR2OWpBVU1zczR6RjVjd0E3enNkK3Vy?=
 =?utf-8?B?Y01FZ0ZReG5DWVVIbHBzd0hQZ0pycjB5c0JxWkR0V2NQNnByNFVsTmI5SHRG?=
 =?utf-8?B?eHBTemlUZzlJQnh3c0c3MUdVcWozLzZRbjQ2Uk9JYm5QNFVnelpsYzQrTUFN?=
 =?utf-8?B?VzFLVVFmTS9ScXRMb1hWTmZ0TW84QmZGZnQxYVBqTUxHNXpJVEFHREx3L2U3?=
 =?utf-8?B?eU1KampUYzVUWkRQS29US1ByN2tLNFNLRmoxZ1dGZmNqcHFEVTdzajJtNm9W?=
 =?utf-8?B?YlJJa1VldERIMjhvSUJCdEFnS2dKaU0rK0lpc3RPZTBLUHZMaWdLUTZPWVpr?=
 =?utf-8?B?N2U4QWU2SFFVZ0w5TjFFUi93N1d0alhXOGZXQWg4aGJFWVVJZi9YRWpDZHM0?=
 =?utf-8?B?NGYxQjZBNlBDcTV4SEZZenE2U2NpU3ZoMGw3cHlSRUZCRndhWlFub280UER2?=
 =?utf-8?B?L0pneXFBQzFSRjRIMytnNE1KMVFMdkJ1aFArZlBGcXl0UldKVVlsTlREMHZG?=
 =?utf-8?B?WHN4WS9jTHZtME1JWkdJZk1BcU0vbUhqOHBxOVVFV2VCRHY3c0RiVkFlaXlj?=
 =?utf-8?B?aDhmNUdZTld5L1JxeE1wSUNxa3NNWVFvSnErRVFJTHZacklpS2J4MldtSVND?=
 =?utf-8?B?NXcwbFlHWFlqdGxvUDlROXFhUWxaZjBhWlJqbDBtS0twUXdiMTYzZlFlUitk?=
 =?utf-8?B?UU1uNDRocENGbGVYNzFiZmttaDRVRHVkczJtQkowT0NUTjIyNFVuaXdiYTJG?=
 =?utf-8?B?SkIyQnFtODZvN0gwUGp4d2RyMkxqd1YyTTd5VlVpeVZGeG1ZWmFBaUdyZHJ2?=
 =?utf-8?B?eWo2S3hYdVF6dm5vWVU1MitjR0k0Y2wzTE5SR2RPS2dSVE9sbHdlVWhvdHZr?=
 =?utf-8?B?djVJaExiU1dBMXBET1RkeWc1UC93UUtla1pIMjg0R1BTNlQ4ZFVDYUd1OXB3?=
 =?utf-8?B?UmovYm5TRUZyTDZidlRXaDAxRnBCRDRoYW10TzRaRHBUaXBISEU1RVN3SXpM?=
 =?utf-8?B?dGsvTnZjZDIxd2hpaFpPbkxnVlBjcHg3N1JiczIrdGtoNjFhTXhERVBScWkw?=
 =?utf-8?B?dnE1WWZCajg1OVBSY1FLSFZkcktSeERXdlRrMC9PVFU0RGpIc2dhZnlRT2FJ?=
 =?utf-8?B?SW53b3RDa21hZHhVWitHYVpqUzAxVzZKS3ZBa3dsVk5HTkZvazcvKytWc3hU?=
 =?utf-8?B?SkYrcnJOU2Myei9SVmlOK2NCKzlRMzBHRHd0K0I4K3d2WEdLTUdHRXhldlIw?=
 =?utf-8?B?T3IvMDNVekZUWWRpdE1oT3ErWDR1MEtzQzNBZUFEQ3JPSGRZZWVUbGFGZEQ0?=
 =?utf-8?B?RHJXZ1RwUHM3QmNjQTViRzNrTkFFME1WY0lnSWg0YXd4Vm5MMFcyN0JPdTNa?=
 =?utf-8?B?TFdRQzVzSUZiSDNTTFVkcGN2K1ovdTZHV3FHbCsydUVUTlUzSkNLN2k1RTBT?=
 =?utf-8?Q?mosz3eqzSdnZD8vU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <496F4165A0ADD34C8FA0B4D4B984BE41@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6196.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbadd28-3cfe-4ffe-8745-08dec2e48062
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 09:26:19.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK3SKg5F77FYBdbR5bswyJw7xN9QNMsunRnOvRlsmzjOrowofbcnfQermXKM47mfwo/sPhPvKV8FmO6XPwZoELH1TGP/eDwtGdRDjqtEuZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6348

T24gNi81LzIwMjYgNTowMiBQTSwgQ2hyaXN0aWFuIExvZWhsZSB3cm90ZToNCj4gT24gNi81LzI2
IDAzOjQ4LCBIb25neWFuIFhpYSB3cm90ZToNCj4+IFtzbmlwXQ0KPj4NCj4+IEhpIERpZXRtYXIs
DQo+Pg0KPj4gT24gNi80LzIwMjYgOToyMSBQTSwgRGlldG1hciBFZ2dlbWFubiB3cm90ZToNCj4+
PiBPbiAwNC4wNi4yNiAxMToyMSwgSG9uZ3lhbiBYaWEgd3JvdGU6DQo+Pj4+IE9uIDYvNC8yMDI2
IDQ6NDggUE0sIFZpbmNlbnQgR3VpdHRvdCB3cm90ZToNCj4+Pj4+IE9uIFRodSwgNCBKdW4gMjAy
NiBhdCAxMDoyMSwgSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+IHdyb3Rl
Og0KPj4+Pj4+DQo+Pj4+Pj4gT24gNi80LzIwMjYgMzo0MiBQTSwgVmluY2VudCBHdWl0dG90IHdy
b3RlOg0KPj4+Pj4+PiBPbiBUaHUsIDI4IE1heSAyMDI2IGF0IDA0OjM2LCBIb25neWFuIFhpYSA8
aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gRnJv
bTogSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+DQo+Pj4NCj4+PiBbLi4u
XQ0KPj4+DQo+Pj4+Pj4+PiBBbmFseXNpczoNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBXZSBmb3VuZCBz
ZXZlcmFsIHByb2JsZW1zIHRoYXQgcmVzdWx0IGluIHRoZSBwb3dlciBzcGlrZToNCj4+Pj4+Pj4+
DQo+Pj4+Pj4+PiAxLiBBcml0aG1ldGljIHNob3VsZCBub3QgaGFwcGVuIGJldHdlZW4gdXRpbF9h
dmcgYW5kIHJ1bm5hYmxlX2F2ZzoNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBBZnRlciB1dGlsID0gbWF4
KHV0aWwsIHJ1bm5hYmxlKSB3aGljaCBwb3RlbnRpYWxseSBwaWNrcyBydW5uYWJsZSB2YWx1ZQ0K
Pj4+Pj4+Pj4gaW4gY3B1X3V0aWwoKSwgd2UgdGhlbiBhZGQgb3Igc3VidHJhY3QgdGFzayB1dGls
IHZhbHVlcyBmcm9tIGl0LiBUaGlzDQo+Pj4+Pj4+PiBwcm9kdWNlcyBhIHZhbHVlIHRoYXQgaXMg
aGFsZi1ydW5uYWJsZS1oYWxmLXV0aWwgd2hpY2ggaXMgaWxsLWRlZmluZWQuDQo+Pj4+Pj4+PiBU
aGlzIGFsb25lIHNob3VsZCBiZSBhIHdhcm5pbmcgc2lnbi4gVGhpcyBicmVha3MgRUFTIGNhbGN1
bGF0aW9ucyBpbg0KPj4+Pj4+Pj4gbWFueSBjYXNlcywgbGVhZGluZyB0byBzdWItb3B0aW1hbCB0
YXNrIHBsYWNlbWVudHMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoaXMgY2FuIGJlIGVhc2lseSBmaXhl
ZA0KPj4+Pj4+DQo+Pj4+Pj4gSSB0aG91Z2h0IGFib3V0IGFkZGluZyBvciBzdWJ0cmFjdGluZyBy
dW5uYWJsZV9hdmcgaW5zdGVhZCwgYnV0IHRoYXQgaXMNCj4+Pj4+PiBzdGlsbCB3cm9uZy4gR2l2
ZW4gdGhyZWUgdGFza3MgZWFjaCB3aXRoIDEwMCB1dGlsLCBpZiB0aGV5IHdha2UgdXAgYXQNCj4+
Pj4+PiB0aGUgc2FtZSB0aW1lIGFuZCBydW5uaW5nIG9uIHRoZSBzYW1lIHJxLCB0aGVpciB1dGls
IGlzIDEwMCwgMTAwLCAxMDAsDQo+Pj4+Pj4gcnEgdG90YWwgdXRpbCBpcyAzMDAuIFRoZWlyIHJ1
bm5hYmxlX2F2ZyBpcyAxMDAsIDIwMCwgMzAwLCBycSB0b3RhbA0KPj4+Pj4+IHJ1bm5hYmxlX2F2
ZyBpcyA2MDAuIElmIHRoZSAxc3QgdGFzayBsZWF2ZXMgdGhlIHJxLCB0aGUgcmVtYWluaW5nIHR3
bw0KPj4+Pj4+IHRhc2sgcnVubmFibGVfYXZnIHdpbGwgdGhlbiBiZWNvbWUgMTAwLCAyMDAsIGdp
dmluZyBhIHRvdGFsIHJxDQo+Pj4+Pj4gcnVubmFibGVfYXZnIG9mIDMwMC4gSG93ZXZlciwgc3Vi
dHJhY3RpbmcgdGhlIHJ1bm5hYmxlX2F2ZyBvZiB0aGUgMXN0DQo+Pj4+Pj4gdGFzayBnaXZlcyA2
MDAgLSAxMDAgPSA1MDAsIHdoaWNoIGlzIHZlcnkgd3JvbmcuDQo+Pj4+Pg0KPj4+Pj4gU3Vic3Ry
YWN0aW5nL2FkZGluZyBzZS5hdmcucnVubmFibGVfYXZnIGlzIHN0aWxsIHRoZSByaWdodCBzb2x1
dGlvbg0KPj4+Pj4gYmVjYXVzZSB0aGlzIGlzIHdoYXQgd2lsbCBoYXBwZW4gaWYgdGhlIHRhc2sg
bWlncmF0ZQ0KPj4+Pg0KPj4+PiBPbmUgZGlmZmVyZW5jZSBpcyB0aGF0IGJlZm9yZSBydW5uYWJs
ZSBib29zdCwgcnVubmFibGVfYXZnIHJlYWxseQ0KPj4+PiBkb2Vzbid0IGFmZmVjdCBFQVMgYW5k
IENQVUZyZXEgbXVjaC4gUnVubmFibGUgYm9vc3QgaXMgdGhlIGZpcnN0DQo+Pj4+IGluc3RhbmNl
IHdoZXJlIHdlIGRpcmVjdGx5IHVzZSByYXcgcnVubmFibGVfYXZnIHZhbHVlcyBpbiBFQVMgYW5k
DQo+Pj4+IGZyZXF1ZW5jeSBzZWxlY3Rpb24sIGFuZCB0aGlzIHZhbHVlIGlzIG9mdGVuIHRvbyBo
aWdoIHRvIGJlIHJlYXNvbmFibGUuDQo+Pj4+IEknbSBtb3N0bHkgYXJndWluZyB0aGF0IHdlIHNo
b3VsZCB1c2UgaXQgaW4gcHJvcGVyIHBsYWNlcyAobGlrZSB0aGUgb25lDQo+Pj4+IGluIHV0aWxf
ZXN0X3VwZGF0ZSgpKSBhbmQgbm90IGhlcmUuDQo+Pj4+DQo+Pj4+IEFjdHVhbGx5IHRoaXMgaXMg
dGhlIHZlcnkgZmlyc3QgZml4IHdlIHRyaWVkIGludGVybmFsbHkuIFRoZXJlIGlzIG1pbm9yDQo+
Pj4+IGltcHJvdmVtZW50IGluIEVBUyBzcHJlYWRpbmcgb3V0IHRhc2tzLCBidXQgZW5lcmd5IHJl
Z3Jlc3Npb24gaXMgcHJldHR5DQo+Pj4+IG11Y2ggdGhlIHNhbWUsIGFuZCBZb3V0dWJlIGlzIHN0
aWxsIGF0IDIwJSByZWdyZXNzaW9uLg0KPj4+DQo+Pj4gSSB0aG91Z2h0IHRoZSBpc3N1ZSB3YXMg
dGhhdCwgaW4geW91ciBsb3ctcG93ZXIgdGVzdCBjYXNlcywgbW9zdCBvZiB0aGUNCj4+PiB0YXNr
cyBpbnZvbHZlZCBpbiB0aGVzZSBjb250ZW50aW9uIHNjZW5hcmlvcyBhcmUgcmFpc2luZyBDUFUg
ZnJlcXVlbmN5LA0KPj4+IGJ1dCB0aGV5IGFyZSBub3QgZGlyZWN0bHkgY29udHJpYnV0aW5nIHRv
IHRoZSB3b3JrbG9hZCAoaW5jbHVkaW5nDQo+Pj4gQW5kcm9pZCBHcmFwaGljcyBQaXBlbGluZSAo
QUdQKSBwcm9ncmVzcykuIElmIHRoYXQncyB0aGUgY2FzZSwgdGhlDQo+Pj4gYWRkaXRpb25hbCBw
b3dlciBjb25zdW1wdGlvbiBpcyBlc3NlbnRpYWxseSB3YXN0ZWQuDQo+Pj4NCj4+PiBDb3VsZCB5
b3UgY29sbGVjdCBzb21lIGluZm9ybWF0aW9uIGFib3V0IHRoZXNlIGNvbnRlbnRpb24gZXZlbnRz
IGFuZA0KPj4+IGlkZW50aWZ5IHRoZSB0YXNrcyBpbnZvbHZlZD8NCj4+DQo+PiBPdXIgcHJvZmls
aW5nIHNob3dzIHRoYXQgdGhlcmUgaXMgYSB2ZXJ5IHR5cGljYWwgc2NlbmFyaW8gaW4gdGhlc2UN
Cj4+IGVuZXJneSByZWdyZXNzaW9ucywgd2hpY2ggaXMgSVBDLg0KPj4NCj4+IFF1aXRlIGEgbG90
IG9mIGFwcHMgaGF2ZSBwZXItQ1BVIHdvcmtlciB0aHJlYWRzIHRha2luZyBkYXRhIGZyb20NCj4+
IHByb2R1Y2Vycy4gV2hlbiBhIHByb2R1Y2VyIHNlbmRzIHRoZSBmaXJzdCBwaWVjZSBvZiBkYXRh
IChtb3N0bHkgdXNpbmcNCj4+IHdha2VfdXBfc3luYygpKSwgYSB3b3JrZXIgdGhyZWFkIG9uIHRo
ZSBzYW1lIENQVSBnZXRzIHdva2VuIHVwLCBidXQgdGhhdA0KPj4gd29ya2VyIGlzIG5vdCBpbW1l
ZGlhdGVseSBzd2l0Y2hlZCB0bywgd2hpY2ggaXMgcmlnaHQgYmVjYXVzZSB5b3Ugd2FudA0KPj4g
dGhlIHByb2R1Y2VyIHRvIGZpbmlzaCBwcm9kdWNpbmcgZGF0YS4gQnV0LCBiZWNhdXNlIHRoYXQg
d29ya2VyIHRocmVhZA0KPj4gaXMgYWxyZWFkeSBydW5uYWJsZSwgaXQgc3RhcnRzIHRvIHNob290
IHVwIGl0cyBydW5uYWJsZV9hdmcgYW5kIHRoZSBycQ0KPj4gcnVubmFibGVfYXZnLiBXaGVuIHRo
ZSBwcm9kdWNlciBpcyBkb25lIGFuZCB3ZSBmaW5hbGx5IGNvbnRleHQgc3dpdGNoIHRvDQo+PiB0
aGUgd29ya2VyLCB0aGUgZnJlcXVlbmN5IGlzIGFscmVhZHkgc3VwZXIgaGlnaCBhbmQgaXQgdGFr
ZXMgdGltZSBmb3INCj4+IHRoZSBmcmVxdWVuY3kgdG8gZGVjYXkuDQo+Pg0KPj4gVHdvIHByb2Js
ZW1zIHdpdGggdGhpczoNCj4+DQo+PiAxLiBJbiB0aGlzIGNvbW1vbiBzY2VuYXJpbywgdGhlIHBy
b2R1Y2VyIGFuZCBwZXItQ1BVIGNvbnN1bWVyIHRocmVhZHMNCj4+IGFyZSBub3QgcmVhbGx5ICdj
b250ZW5kaW5nJy4gVGhleSBhcmUgYWNjb21wbGlzaGluZyB0aGUgc2FtZSBqb2IgYnV0DQo+PiBq
dXN0IHNwbGl0IGludG8gbXVsdGlwbGUgc3RhZ2VzLiBUaGUgJ2NvbnRlbnRpb24nIGhlcmUgc2hv
dWxkIGJlIG11Y2gNCj4+IHNtYWxsZXIgdGhhbiB0d28gaW5kZXBlbmRlbnQgdGhyZWFkcyBkb2lu
ZyB0d28gc2VwYXJhdGUgam9icy4NCj4gDQo+IEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGlzIHRv
IGJlIHJlbGF0aXZlbHkgcmFyZSwgc2luY2UgZmVlYygpIHNob3VsZA0KPiBub3JtYWxseSBwbGFj
ZSB0aGUgY29uc3VtZXIgb24gYW5vdGhlciBDUFUgaW4gdGhlIHNhbWUgY2x1c3RlciBhY2NvcmRp
bmcNCj4gdG8gbWF4LXNwYXJlLWNhcGFjaXR5LiBUaGUgcHJvZHVjZXIgc2hvdWxkIGFscmVhZHkg
aGF2ZSBjb25zdW1lZCBzb21lIHNwYXJlDQo+IGNhcGFjaXR5IG9uIGl0cyBjdXJyZW50IENQVSwg
c28gYW5vdGhlciBDUFUgc2hvdWxkIGxvb2sgcHJlZmVyYWJsZS4NCj4gDQo+IFdoeSBkb2VzIHRo
aXMgbm90IGhhcHBlbiBpbiBwcmFjdGljZT8gSXMgdGhlIGNvbnN1bWVyIHdha2V1cCBub3QgZ29p
bmcNCj4gdGhyb3VnaCB0aGF0IHBhdGggZm9yIHNvbWUgb3RoZXIgcmVhc29uLCBvciBpcyB0aGUg
c3BhcmUtY2FwYWNpdHkgZGVsdGENCj4gdG9vIHNtYWxsPw0KDQpUaGUgQmluZGVyIElQQyBtZWNo
YW5pc20gaW4gQW5kcm9pZCBhbmQgbWFueSBhcHBzIGhhdmUgcGVyLUNQVSBjb25zdW1lciANCnRo
cmVhZHMuIFRoZSBwcm9kdWNlciBkb2VzIHdha2VfdXBfc3luYygpIGluc3RlYWQgb2YgYSBub3Jt
YWwgd2FrZS11cCBvbiANCmEgY29uc3VtZXIgdGhyZWFkIG9uIHRoZSAqc2FtZSogQ1BVLiBUaGlz
IGlzIHRvIGF2b2lkIG1vdmluZyBkYXRhIGFjcm9zcyANCkNQVXMgYmVjYXVzZSB0aGUgcHJvZHVj
ZXIgaXMgZXhwZWN0ZWQgdG8geWllbGQgc29vbiB0byB0aGUgY29uc3VtZXIuDQoNCj4gT24geW91
ciA0KzMrMSBTb0MsIGRvZXMgdGhpcyDigJxkb21pbmF0ZWQgYnkgcnVubmFibGVfYXZn4oCdIHNj
ZW5hcmlvIGhhcHBlbg0KPiBtb3N0bHkgb24gYSBzcGVjaWZpYyBjbHVzdGVyLCBvciBpcyBpdCBm
YWlybHkgZXZlbmx5IGRpc3RyaWJ1dGVkPw0KDQpGYWlybHkgZXZlbi4gSW4gWW91dHViZSBwbGF5
YmFjaywgdGhlIHRocmVlIGNsdXN0ZXJzIGFsbCBoYXZlIGFyb3VuZCANCjQwLTUwJSBoaWdoZXIg
YXZlcmFnZSBmcmVxdWVuY3ksIGxlYWRpbmcgdG8gYSAyMCUgcG93ZXIgcmVncmVzc2lvbi4NCg0K
Pj4gW3NuaXBdDQoNCg==
