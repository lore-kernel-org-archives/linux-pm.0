Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010031.outbound.protection.outlook.com [52.103.23.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5682DCF57;
	Thu, 16 Jul 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228298; cv=fail; b=kQFosFSYjuKws4QD5+J5xaH3D4eIkTFRUQXGDYlvPibKsa/fN5FbKKsuOGQ9sNLFAJSmuKfvrnph8r9Yp7loYcUGvgGXrHpxh3vdz4xCBWdmLmM+bpbgFyFRz7LB3m0wgqqsTezdNZe6Ya9X50ZuWDizLToV3Es8wVaa6Vfxqac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228298; c=relaxed/simple;
	bh=qSMnXQoHFHfE2LTHrmF0MZMKiemMXiDxQL944Q/DjsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sx1ktHbkmAFfwBEn8qpPWwWwFpKOD6okriQIlbt/dKhx9EKWTJCBfRV9K6Q57q5AjTa6DZamW7mEYbH8gPDMbn+EeuR5sKPKFSU6xVB7gTxRbPF8wHD5UO0ZfDdKTOBlB5LyIaBkfihYToc9eURXoc9eZ549HmUt2MejBLenPxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dU30aImC; arc=fail smtp.client-ip=52.103.23.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dU30aImC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5v8XRHDFmc9j+eq1ovPg8UeLRzLVgkRHOpL+ThKVXJERL+xSfnDMQ4ob2o61MO7BRMmaTDfOblLpi16DIQuatoH7miH1SpKIbhL8xoJwbCLQEzozyZ+0M6RA6Luzvxh0KHTN9t6gYAgiiCgtI5si9rE8SRAdBO6z4i0cNW9bkxHlW1C0o3+unSe5wxaa6LIvjKa2DYX3wENaGhWjcTI8K4HeSPVnSwYa18HF5qFoq2hyNsDvzdPg1k2fOSNjGYZFD0g27LQ0b+aHphsUBx8UmljchcaU0JwM1Gaa7hv9sei8grBCzIKN2TO1SMBOCw54a7F204eKC2+yc4quezAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSMnXQoHFHfE2LTHrmF0MZMKiemMXiDxQL944Q/DjsY=;
 b=gQ8DrTqrpQpEfzeP4ocXGB+curE4KhSlVnMeJxQp6Yc+ujuVm2tvEeTyEiCxmTxz4IAUTsVJd6DFoGoC3Xzmw++39RHc/mN8xOsgLJnFKAgR79bPjxgC7W6QyGP0tNKqJqsJ6zq64xn/PO+kiXtp7SQipSzNDcGPENW/b7QKNVQ/CadCPGojKoC2g2uYSjxlZVuqth4iGRJwaCM6sA0kHKBSN/ZXazYAIn5VTtVS6e0mrJlvV6ZsMjJsGUFz+7vJesVS4BP7usEqpOW2L47qNTHUNv9zU502FwycYNxJosAt4PxPdW5R+j1W2lSfvu82/swR6A7r7fEpYNn40N/Xxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSMnXQoHFHfE2LTHrmF0MZMKiemMXiDxQL944Q/DjsY=;
 b=dU30aImCqFCc/R1ybaYgc0TV09qKxhRIxMVsB1gszu/0SajwJaGVkKQOrznrPDT1VH14dwFWpgQyhsWCJNahCU7KCpdfV9Nf78R472oKNvUmqnfyJ1OTPmZJep67iv+Y+PdjHk2Z4MHg8qOZpJEupJNKId1wG9ZPrmDz16GqD/vNMcd16ijQbBCKIPcMmI8yL0ql5WHOeQodFJ6gPyNDg5W16JK+MHiQXAomMoC1RLP/ndZLvqbm20IFv+NV6zuQ9bcNfrNPaBvxi/bOVplsxrOq+5fq8lsd6cLa/g/5l1dqgRU6yKPxX3IXIeE6E4IChwbOr5S0XP291dD1XjQUIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV0PR02MB11496.namprd02.prod.outlook.com (2603:10b6:408:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 18:58:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 18:58:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rong Zhang <i@rong.moe>, K Prateek Nayak <kprateek.nayak@amd.com>, Jason
 Andryuk <jason.andryuk@amd.com>
CC: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Borislav Petkov <bp@alien8.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Thread-Topic: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Thread-Index: AQIrPSTZ8vlDsNovD5GCISbceOWLTLXUH6OAgAAIFYCAAAXkUA==
Date: Thu, 16 Jul 2026 18:58:14 +0000
Message-ID:
 <SN6PR02MB41575F5EDD2C5EBBA567EB49D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
	 <7caa23a0-bcf0-41a5-a600-99b33f418020@amd.com>
 <e23f42a9e57220c49ced41d22d50618cf24948cf.camel@rong.moe>
In-Reply-To: <e23f42a9e57220c49ced41d22d50618cf24948cf.camel@rong.moe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV0PR02MB11496:EE_
x-ms-office365-filtering-correlation-id: 3952b91b-950a-4b5a-0384-08dee36c3086
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|15080799012|19110799012|24021099003|8060799015|8062599012|4140399003|51005399006|25010399006|37011999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUJZaUVzdXdLQkRjZnYxcm1VSko0UE92TlBWd0FwY09XbWpSZVZnV1haVEx6?=
 =?utf-8?B?bC9PRWNaMGlpdk1OZVExL0FGMEQ0RVJoRVRoYmFnbEtEaHROL1A3cVdTL1E4?=
 =?utf-8?B?alc2bnpOSmZvWC9mcjZKcS9lSkI2c0tpQjBPc3FKSjFTSGo4ekwvNnk3dzRJ?=
 =?utf-8?B?LzVKcHNkTnNzOU9ySzh0eWhqN20ycEpSWFE5TEszS2MyYWtYa2pMT1NoaUIv?=
 =?utf-8?B?OVhJOGtXQktHMEEzbU04TzFVcG5KMGJIdWxLWUMwUkdRWGhLUXFoUWFZcEdV?=
 =?utf-8?B?VGhEbC93Ni9pRWJuQlVmWndWSGZ5QkZVaElvSlZJRkwxNTRWME1WT0E3Q3k2?=
 =?utf-8?B?aFBHNjl5cVd2bkpXRFRPWEowV0Vuc0ttdjhRbDl3QzNxNWo1M3BLM1FTM2gz?=
 =?utf-8?B?WU5aa3ROM1haSlN5cmp1VXVvR0kzckY4Zm9aZEluWDlHRldHaVpiODRvL2ZT?=
 =?utf-8?B?K1J1ajY0OGdwN09rV2hvRzBXZ2tpQ2lLVHNOZmFaQldkQkZURDliWlcwZU42?=
 =?utf-8?B?aFZVSElJOGg5RjN3RnhuSGdnTHBMMzFwYWJzKzN0b0llcDZtV0ZGcjcvZnZH?=
 =?utf-8?B?VWRHL2VQY0lVeENFV2F0ekE1MGxPamFxRno0bUVzU1VmOThwaEV2WGVocWx0?=
 =?utf-8?B?d2R4RDhBSm1PMlBsTXpWRmIwckVuclpsSjdGV1RVb0R1LzcrS2VuUG15RUt5?=
 =?utf-8?B?aTBqYlkybjQ0MGROL2Q0QlgvcVhZeWwvMm1qbkdMSmhPaCtFMEk3RzhvR0tm?=
 =?utf-8?B?eVI5ZGxEMndwOG5CQWlmS1hlNTQ0eUNiWmZuN3VLSDBGVkZvUHhyR2N3R25i?=
 =?utf-8?B?b1FlSVFQVnlrQ3RGSmZWTjZNWEM3ZnZHYWhFZ1BlS2JENk4vVUtHa2R5dGFQ?=
 =?utf-8?B?WDZaRkNCbWhuUnU1bXJJVGFsaGxRdDJ0ZkluTVRWUFlUSk1Uc1RLcXd6enJN?=
 =?utf-8?B?R3dWLzVSc0EyMjk0Q29tNUhOSStleURPQ09naUVubnRHOUYya1QrQld3aFVD?=
 =?utf-8?B?NmQ4dDhYQXZrM0xQTEVmUkltdFNBekwrVHgxdUFwTXozUituSWxVcG1DeUoz?=
 =?utf-8?B?RTJUOUZSK0VhRnZkMnY5QmJoNEZrNG8za2xzL2tITHc2dUUwazhYVnJ4anhP?=
 =?utf-8?B?ZExOc0hkbWphQ0VPTzdCaWJ1TkJJb2xBcWFrY0lNUTFWRmdtQWoxV29RVmVw?=
 =?utf-8?B?SDIvamovVm1CVmZkSDQ4Wkk0WUE2ZTJhTG1HWlpiemtyaTROQVJEMnVUUnJC?=
 =?utf-8?B?cHpMdkNRZVd3RjZkTjBNc0IxQkdWSnBjWlhXZElwbmVjU1UwckRXdEMrQlBJ?=
 =?utf-8?Q?XWnLWBy7/Kw93vwtbtaEGqndd4jRZm/k9p?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTFIMHVhOTJYVmxWSXRDY1dpeXdTcktYc1BDZ3VQOE13ZEdlZGJnZFJCa2Zs?=
 =?utf-8?B?MzJaUiszREZXK3ozTiswY0lKL0U3R2pZYmlpd1Y2MURDSEhLUGU1bGJOWHBp?=
 =?utf-8?B?YnAzcVROeDY1R3ZCRWNBTXBKQjZqUCtqRGsrc24vbURIc2dGSndEQ2NUMmZo?=
 =?utf-8?B?SlNSaUM2TE1WUVRqQWtHeUcwaVFna1AxS0krQi9MYzU3eHpUUThaT0NKWFh2?=
 =?utf-8?B?WjVOUzVxZXRCTm1LSFoySk54WXBCUk1DQWxDeFBXVWs1UmZtSmltUHFMZG9v?=
 =?utf-8?B?Z3pvOUJaQmpTQkptMDJNVlpuMTNGTkN4NFVmMlJBVXVvSVhEZFlUL2F0YWRo?=
 =?utf-8?B?YXBFMFVoeE5uS2o4cWJHMmMxM2wwNHdHNkF4V001QnFrRXh0MVkvRmpxVGFK?=
 =?utf-8?B?eXI5Y3AzckdYcjAvRnVQUUZHellocVRSRWhtdDZVcDZtS21YZjB5S1pRK3Yx?=
 =?utf-8?B?SVV6YUNKRjhxdVUzQ0JzT0FwU0R4R3RiRGdiaHFPbkJSdStiaUdDaWNWVFNY?=
 =?utf-8?B?R29yWENNUU1WUmhyVFpzVm9iYm5Sc0ZuMU8xcW9YbHlMdVdiT3FBV1pMQnMx?=
 =?utf-8?B?THU1M1IybzduTGduMHh1SWNrWHNORHdUYjFjWVp0dHZjR2VlUTV3NUd5VEdI?=
 =?utf-8?B?WGt1MXMydVRGQU5KM1RwbzVoREJEWWJWWkJoYkFnM3Q4UTZNYVJvMkhjdzZ4?=
 =?utf-8?B?TUpROERVR2U0U2I2eWVGOVYwTXJzQTF4NEpSa3ZidXd3Vlo4M1RseVA3c2ZN?=
 =?utf-8?B?c0daSm0yTC9EcmphSFQ3K2ttSW8wOUpINE5IbGsxdDR4blk5SVpRYVZsYU1J?=
 =?utf-8?B?bUZVNVFid0FvSXlsV0d4aG1ZMTBLNU51SVFZZnp3SmFSeGFQNTIxQWE5S0hQ?=
 =?utf-8?B?VTh0OFJ4QkJkNko2OFFXNlh3N0xlNlg0Zndhc21ac0Z1dThMbHhUOHM3NnRu?=
 =?utf-8?B?R1RpT3czejRuallSbndQS2lsUm1JZ2E5MzQ1Q2V2dUpYTGpCMzZoK3pOWWJL?=
 =?utf-8?B?RHZuTE03a3V5VHRUZXM4eVoya2JLRkxRd1NxaGRuNVRnRGcvWnREZWxTL2VW?=
 =?utf-8?B?ZmJRanZJVlgvRW15OUEyRlBxL3JOUHRYeHFjY3hIby81VTR4ci9VZ3Z5RDJG?=
 =?utf-8?B?U0lYcE4yT2lwWDlkUmJnVG40YmFFbmJNczlJSDUwUnRUb0thL0x0Nk9OdTUx?=
 =?utf-8?B?NWx3Y2thQTRuL2xsZzc4V0xlellsWlpGQ2RZTDd1VDZBbVFaaC8xcVhucFVL?=
 =?utf-8?B?OE91cCtGbGtOS201SG5mUmczWkxkS3pEY1JEOFZTQlgra1ZCdHZ4cm56QnBt?=
 =?utf-8?B?Z1JMOThKdVkwOEdRUmJ5R254eXV2N0hiN2JYWDFJV2VqNm95anQvU1ZDa2pC?=
 =?utf-8?B?YSsyRDRrZk1ISTVKaHNHQk1tMi8vUU5UNzAzNzhVN3FLMUpZRk5oMFcrcEJK?=
 =?utf-8?B?WllUQjJrOGh5NzRneWpjZktPL3BES1NUUGtzZThQWklHTnkvSzk3dmE0WnAx?=
 =?utf-8?B?bGhWM3Nwdks0VVFHblJTN0lKeUs1dlczdWRrc3JDU29EWEU2VE9pa2hQcFkz?=
 =?utf-8?B?UjYwS3NZaUJSTTdUdlpRQXVUWHVrWXR1MlB0UVZjU1lJMGlaUkF0cDkzc0kv?=
 =?utf-8?B?S1ExbFpRT1ROL1A2UnZ1ZGsyVHFqNEZEOU1jcW9lRlNKTW91WUVMK1FnSDU1?=
 =?utf-8?B?b2h1cUxZdE1NTExUaTBjelo4QW03R1NveGU3SWxJL0ZyVzk5ZkVVbWlKNnAx?=
 =?utf-8?B?Qit3b0w4UEVKSzVibVBVbzJuZUN0YjNyYjN3RS82bm1sRW5jZjZlZWEydVBV?=
 =?utf-8?Q?7lpQX3NtJdXx181D3QjO368PiYwfxtrYUQtBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3952b91b-950a-4b5a-0384-08dee36c3086
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 18:58:14.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11496

RnJvbTogUm9uZyBaaGFuZyA8aUByb25nLm1vZT4gU2VudDogVGh1cnNkYXksIEp1bHkgMTYsIDIw
MjYgMTE6MjkgQU0NCj4gDQo+IEhpIEsgUHJhdGVlaywNCj4gDQo+IFRoYW5rcyBmb3IgcmV2aWV3
aW5nIHRoaXMuDQo+IA0KDQpbc25pcF0NCg0KPiANCj4gQXMgSmFzb24gc2FpZDoNCj4gDQo+ICAg
IFdpdGggWGVuLCB0aGUgWGVuIGh5cGVydmlzb3IgaXRzZWxmIGNvbnRyb2xzIENQUEMuICBkb20w
DQo+ICAgICh4ZW5faW5pdGlhbF9kb21haW4oKSkgZG9lc24ndCBuZWVkIHRoZSBhbWQtcHN0YXRl
IGRyaXZlci4NCj4gDQo+IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCBYZW4u
DQo+IA0KPiBATWljaGFlbCwgaWYgeW91IGhhdmUgdGhlIHRpbWUsIGNvdWxkIHlvdSB0ZXN0IGlm
IEh5cGVyLVYgZXhwb3Nlcw0KPiBYODZfRkVBVFVSRV9IV19QU1RBVEUgKGkuZS4sIDB4ODAwMDAw
MDcvZWR4IGJpdCA3KT8NCg0KSSBjaGVja2VkIGEgVk0gcnVubmluZyBvbiBIeXBlci1WIG9uIGFu
IEFNRCBaZW4gMiAoRVBZQyA3NDUyKSwNCmFuZCBhbm90aGVyIG9uIGEgWmVuIDQgKEVQWUMgOVY3
NCkgcHJvY2Vzc29yLiBOZWl0aGVyIGhhcw0KWDg2X0ZFQVRVUkVfSFdfUFNUQVRFIHNldC4gVGhl
cmUgYXJlIG90aGVyIHZhcmlhdGlvbnMgdGhhdA0KY291bGQgYWZmZWN0IHdoYXQgYSBndWVzdCBv
biBIeXBlci1WIHNlZXMsIGJ1dCB0aGVzZSBzcG90IHRlc3RzDQphcmUgc3VmZmljaWVudCBldmlk
ZW5jZSB0aGF0IHRoaXMgZmxhZyBkb2VzIHdoYXQgd2Ugd2FudCBmb3INCkh5cGVyLVYgZ3Vlc3Rz
Lg0KDQpNaWNoYWVsDQo=
