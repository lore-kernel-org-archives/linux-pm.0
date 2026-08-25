Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E0306B08;
	Tue, 25 Aug 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626311; cv=fail; b=ZVTinO8jtLi/fZPW+vmDCDv7tOg/CyF33wN1PYHFM87yV4bgLBG6BZCC8jR3o4HB4v/GrUCAua8zP8LFn7Pv96NpovGnWfEXVwf2pyhaFpYFT2hvK225grzu6W6vlk4YlQv9fml6JBWgGYtHhaUw8sd7Yc8dg0NEbgr2T4aQCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626311; c=relaxed/simple;
	bh=ILSqOPGOpG6Caw2mNXXC8iUCHjSnYm5tRGlyvyrfCnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U0/07uQAJeTMjQp8UlmPN4htLGnemWvDPGSPdxX//k6aVenRTV9P3wqAPY/GyDulCrhQCbW149t3DsB50ofuBNQN1r1+LdaurzJ3e0QP2MXeC6JgsyKqyVP4VCBQDGhNuXXWqouMrFlPqhzrDO3ZKL10Np2eKcvkU55mqVWFuHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=RGQM1eCr; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="RGQM1eCr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV4ElI13GDfgFdRESnpsJJ+YuvpL28GPbugPe4oQHY9t+J7fomMRyiO/CgyhljPOLEdzRVm9TLxu5Nh40GnP0X3Z+6KnykSR84BN0ZhTiq52Znxb41hP3NGHVQ8XPg5s1+n5JQ4ObGCdUr+Y6ww6AEGi1UKjw4vhWziJ0Bw4antqPvvzjoqgxXqcQ+Rgc9VnRUIquj0CFHDKPGiJKv0Fp1/xSyAgGO/9YNtvJzlGMyECRDGsv7jTbUGOdp9SQNdLBIWuaM5TYTWuaMV77VL1IAafipkFaFUY3JrRV6GjQeAhWiYu5/Q6X1uXgRaJ3k1DY/3ARMxF0cbpxZYsctaQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILSqOPGOpG6Caw2mNXXC8iUCHjSnYm5tRGlyvyrfCnQ=;
 b=MGKLS6+nPk+4wvDLvAAfHOa1FXYKdcC8hNKo6NOXfubnRMxMmWZRtX3fI/tFKqdrgaKO/UenPCg8h3cvCeJ58W83XhgAU4i5V8fgWwl5q3SQQRy0TiXdEP50WCwmUHjeYrN/2EI7AHsbualYqrX4P2XatuGLTGlArlvMx93+Q05Dr42OZU1J4LOAmhcAHI34BjbVSYvGQrgYAK8HyY6ND/QHFVtP00/ZqNuUI2WCYLWMyolXCR2St8o1ljosDMyiNwlEc+aDMl3bKNTv3NC2+vyKoSFO0ATOmEI+FQZlJgBISaGgrl8gWyo4t0cciBGRcYj3svhlhBGYHMyPzMEXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILSqOPGOpG6Caw2mNXXC8iUCHjSnYm5tRGlyvyrfCnQ=;
 b=RGQM1eCrjAZnXgBBw5y+hWnjSDx1U9RVtlOS66YmdaK89vlICN2O1F9CWYLOOcpMePgyn3eU8QLQcwFKaeomix5sE1O9yG/plGSV77yCevHrf3reB5GS6EaNEdXaoGYsfnxM69pXsCMGXjXuRhBJcsJGdUyVwMDSk18Hp7GosQE=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEZPR04MB7796.apcprd04.prod.outlook.com
 (2603:1096:101:221::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 02:51:45 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 02:51:45 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Christian Loehle <christian.loehle@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "daniel.lezcano@kernel.org"
	<daniel.lezcano@kernel.org>
CC: "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"frederic@kernel.org" <frederic@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"jstultz@google.com" <jstultz@google.com>, "qyousef@layalina.io"
	<qyousef@layalina.io>, "sibi.sankar@oss.qualcomm.com"
	<sibi.sankar@oss.qualcomm.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"morten.rasmussen@arm.com" <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
Thread-Topic: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
Thread-Index: AQHdM8tFrBYFi9pGd0uZtMcYzVtF8bauEYUA
Date: Tue, 25 Aug 2026 02:51:45 +0000
Message-ID: <14b8edb7-3515-42dd-86bc-c61872921b5d@transsion.com>
References: <20260824131842.2443385-1-christian.loehle@arm.com>
In-Reply-To: <20260824131842.2443385-1-christian.loehle@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEZPR04MB7796:EE_
x-ms-office365-filtering-correlation-id: 64caf738-bd44-46a8-ba59-08df0253ccc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 oZX4VSQU3kRqWm/z9cPQY8cO36pwUodKYtrWxf3v8AtbwOFw7X7YUeBkSI5gGHnVcoD+DBHCEKXHZ9fMZlXvgfr/XwDwrDoVs24VwA1RlrSWGjkjGJSuvF0rBtc/hmGoB8R63g1ShsysiUpD5VDkpKTMTF1uhm3ZhD1mLqHFenCcWf+DwhaekDfAjN/Vhf3E4CB9e2ROYZFOzRg4IHEEk3s83S5reANskj8TCg1U0SLk86RCRUzie8BkBfQFQxVh43ZVqTyd8uay8LlCKcnr0SKhHou9/BLNoaFXZ1jKItGUrPlyrvOAB+5cFismKmuWq5VaegVlKiwGzQhXMFSsU7B6UnhxZ9lEzEYoWEz0W0UosC4plXUI6/1m13jm7+X7LxaMMmA5IQAOnPYpvWeXFxYOrgSvglbptELbuLj9SCVU6ba+c2gWPAyNEgL97CVWpJjm49t4VaSPqL9Or3nDyUPBgTG81gEdtt1+t5Jnme2p0gKi7tUvAtEyOI9Hiv75mhm+2hX1qJfaKnnU84oFp4FGcBqKuDEaqhe+Vc8Z6V3bW2mgPG4xX2un/g3ufDg509reLt5qkB61ZCyLeEJ621mS5r9cqFOHgvkKmLoQZL+PFhru37NWwhctLZHW4sM+56EdwdGpODz81N+gag7VBrB1purtC/A3WyPmIOcm6sqzZ4OElcHzAyeA+jWsIszGsVkkeeubvpDfxpn3b96Eh+R5vhzBlnXUxCf5UUIiPQs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXhBRVFmNk1MTElwTG9aVmJ3T285SDQwdlllM2p5TUdjZ2wrL05XNTYxRlpW?=
 =?utf-8?B?ZXN3Wi9BVWw5VnlScWkvK0RBK0hQYzlDZEIzbStldHRwcmpvb2tVSzh1RGQw?=
 =?utf-8?B?d1FPTzlWSGE1dVNvK2ZxZDJtb0J1ejBSM2U3NG9LMnBVd3F0c3hRMVBXVXVW?=
 =?utf-8?B?SkNDcXJpRzlYdzc5YlVWY2dYUkkySGZ0R3RsT0tFaWhodEZJTXdLczRXNnJw?=
 =?utf-8?B?c25kSHlFTHU5QmJ6NUR0Y0JSVDBrNjg4aE93Y2RiTEJaWG5neWgrSFZNak9k?=
 =?utf-8?B?TkhHVHFWNERBcHhzM1BXN0ZYTEFFbkxaekJxdzVTTVllc2xxK1FRQ09VaUVv?=
 =?utf-8?B?d1luaVBpSkhiVkRBUGpnN3Y3cG5jdlQwalJjNis3MloxRjhkNjVOdXdPYTRU?=
 =?utf-8?B?aXJkWWlYem1TRFpXdHpqZmcza29TZFEwTzdOQ2kwMjRvOVJlTGhpc2FJNkl4?=
 =?utf-8?B?cGVMeEVNNEdxdHpza1BrM2pLUzFCazhZYjNmOERnRmpIL0h6OTJIaUlGREJr?=
 =?utf-8?B?R25LTmxaaG4vU3hDbDNMRUFqVEtLTVhBTzJhb2kzaGdqWHZyeHAzQy95b3Fj?=
 =?utf-8?B?RDNXdXc2WmFJUUEwMFRaaE9uamZHRnRSaTU3MStYYVlSVFY3djlSSWVFK001?=
 =?utf-8?B?N0lpS1dxN0Q4c2s2ZU1UUThjWDNBZ3Q5T1hmVmU3MnRPdWtUNmY1ejJzZXA5?=
 =?utf-8?B?b1RWclorN2tkL00zbU9KM0N0VldYVUFEMDZObHlwTlU2MVdFdzFQTU1Saml0?=
 =?utf-8?B?VE1hbVRzeENWN1FQdWpTSmNQQUNQMUdJMGF6ellzY3RnSllkbW90ZVd1K1gx?=
 =?utf-8?B?VkNIenNkcE5QK0EzM1ZpRkJYMmxqdUxYSkRlMVBaQXpINGJ2bEJ6bHlZd21s?=
 =?utf-8?B?OG5yUHBkcFloQ1NGelFZZzZCalBlcElCblNNSFBrcEFjUWJIQ2JNZU5Vd0NO?=
 =?utf-8?B?b0FXWjYrcVZiQlhGTWl3K1psZ0NMMTFGcTlPOGpleE5HWUFYeGk4em5obHpY?=
 =?utf-8?B?ZHNvb3pVcjhPMHhJQTRGL3lRQ05waUNZRmZTdzdLSWdlcXpSbzJxM2FZZ1hM?=
 =?utf-8?B?bk82TTJEOW4zb0RiQmJ2T0dPRk5nbERNckRzOFE5RnV6U0lQV2dDN1k0K2Fn?=
 =?utf-8?B?eWRkYU9mc1pKcDlZV3NIelpqemppN2thVU43a20rU1E0MUd1RzVVRmc5dCtk?=
 =?utf-8?B?WUs4V2E4eTU4QzhYWm1yT1ZnVEoyZkZnNlovUitxU3E1RUpZNUJaYnR2eVRU?=
 =?utf-8?B?L0h6OXJlMHpIZzdVeTBQeElaZFVSbjZUVG5wMHg2T2xFVlFkSWZrNDlERGhX?=
 =?utf-8?B?WDZYTEN3VEhzRXZKMHFSb2tQVS9sbnpOc3orb3NZSlRESDduQWxsVEtwenF4?=
 =?utf-8?B?K0tSOFNXVXBmNnE4UmpsQkZ3NlNmNjF4clZKeVgrU3FXVFR0NVprdlNKWU9Y?=
 =?utf-8?B?YUZ6aGdSN0lCSlI2ZmNBUjhGKzVTd0RHUUVYTDEyL3lFdUtNNkcyTE96Z3Qw?=
 =?utf-8?B?alN3UTY4TDVmWGFEMndHeHdXN09NZFY3cGExZnkzcGxEQnhBRlQ5RzRJcjM2?=
 =?utf-8?B?WE5kcDA1TGZXbUZvdVFXTms2MUNvejVvdnFUeE1CSllTYzBOUFVMVU9iT3RG?=
 =?utf-8?B?NFBxZEtnVW15QTRiblhDSktjZ1dGM3R3ZWtDQnp2VnE0UWdEK1hQd1NrWUNi?=
 =?utf-8?B?bnhMbTBRZzBUbUxJOUJpYll1dlRjWWNPZVpnNjdhNWF2MElFejhyajJFQkE5?=
 =?utf-8?B?M0RWb3VsWGVseXBOaWxOOEh0b3FTT0RxV3NseUxxN2V5ZEFlZGNwYnI5cU9n?=
 =?utf-8?B?azQ3QnQ2ZW1VMXE0S1RwNVdGWUh1R0QyWVhpQzJISkhOdjJ5Z3IrQXYvNDZP?=
 =?utf-8?B?NE55Z0pqTUh4SzBUZkVhZGVOcDVLeHFPR0NaRWZHWU9Ubkg4QWNIcmQxQ0hU?=
 =?utf-8?B?V3pJV09PTDVXS2E2a2hFU05URmJJMEFxY3RHWTFmL0xKOE5acXMwTzNpRndS?=
 =?utf-8?B?eWdtZjlmSGplVTMvOElJVTMwamVEZk5ZK0tiZ2U3T2NySkFDTUplOGE2RGJp?=
 =?utf-8?B?cmlmRFdaWWpGTG1jdzJ4S3ZZSDNLVkJZVW1Ec3RwSTZDY3p4UTVRa2ZyZGpT?=
 =?utf-8?B?TGlmWTdFRFhhYXJWUU83YUZEeGQ5NTNpR2tKUVB3Ly9pT3lFc1R1R1dMLzFI?=
 =?utf-8?B?VDNHU0Y5ZWJsV0F3VERBMS9kcGw3ei9pSU1Ba2lkUSs1T2JWRUJTZDZGRkZw?=
 =?utf-8?B?aVFsbE16cmd6VU1tRm5kNTFFblA5MTk0by80VllINnNGYkRseG55MHRYRVY0?=
 =?utf-8?B?RWJNQkpkcEhGR3Fud2oxRURJTWVyZjhKaHZHR3E5akh1dXR4MGl3N2ZJSmxS?=
 =?utf-8?Q?tShVvLKhFJlN72m4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332CEE727B3F604D927BCCE1269A6F0F@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64caf738-bd44-46a8-ba59-08df0253ccc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 02:51:45.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnPuvhxmQ6h/s1npRvsYc3GdHh29LZsZSMBFcFLlY56Y0nViwq/bc0HaFl8MYFfHzYoAkCMdvMUCkcGJ+vdJ/ASq7m2Lj8ABw0VJE8Q6/EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7796

T24gOC8yNC8yMDI2IDk6MTggUE0sIENocmlzdGlhbiBMb2VobGUgd3JvdGU6DQo+IHN1Z292X2hv
bGRfZnJlcSgpIGNhbiBwcmVzZXJ2ZSBhIFVDTEFNUF9NSU4tZHJpdmVuIGhpZ2ggZnJlcXVlbmN5
IHdoZW4NCj4gdGhlIHJ1bnF1ZXVlIGdvZXMgaWRsZS4gSWYgY3B1aWRsZSB0aGVuIHN0b3BzIHRo
ZSB0aWNrLCBubyBsYXRlcg0KPiB1dGlsaXphdGlvbiB1cGRhdGUgaXMgZ3VhcmFudGVlZCBhbmQg
YSBDUFUgdXNpbmcgV0ZJIGNhbiByZW1haW4gYXQgYW4NCj4gdW5uZWNlc3NhcmlseSBoaWdoIHZv
bHRhZ2UgZm9yIHRoZSBlbnRpcmUgaWRsZSBwZXJpb2QuDQo+IA0KPiBJc3N1ZSBhIGZpbmFsIGNw
dWZyZXEgdXBkYXRlIHdoZW4gdGhlIGlkbGUgdGljayBhY3R1YWxseSB0cmFuc2l0aW9ucyB0bw0K
PiBzdG9wcGVkIGFuZCBmb3JjZSBzaW5nbGUtcG9saWN5IHNjaGVkdXRpbCBwYXN0IGl0cyByYXRl
IGxpbWl0LiBLZWVwIHRoZQ0KPiBleGlzdGluZyBob2xkIGJlaGF2aW9yIHdoZW4gdGhlIHRpY2sg
aXMgcmV0YWluZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxjaHJp
c3RpYW4ubG9laGxlQGFybS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvc2NoZWQvY3B1
ZnJlcS5oICAgIHwgIDEgKw0KPiAgIGtlcm5lbC9zY2hlZC9jcHVmcmVxX3NjaGVkdXRpbC5jIHwg
IDUgKysrKy0NCj4gICBrZXJuZWwvc2NoZWQvaWRsZS5jICAgICAgICAgICAgICB8IDI5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
c2NoZWQvY3B1ZnJlcS5oIGIvaW5jbHVkZS9saW51eC9zY2hlZC9jcHVmcmVxLmgNCj4gaW5kZXgg
YmRkMzFhYjkzYmM1Li4wODE0ZjZjNzkzMTUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgv
c2NoZWQvY3B1ZnJlcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2NoZWQvY3B1ZnJlcS5oDQo+
IEBAIC05LDYgKzksNyBAQA0KPiAgICAqLw0KPiAgIA0KPiAgICNkZWZpbmUgU0NIRURfQ1BVRlJF
UV9JT1dBSVQJKDFVIDw8IDApDQo+ICsjZGVmaW5lIFNDSEVEX0NQVUZSRVFfSURMRQkoMVUgPDwg
MSkNCj4gICANCj4gICAjaWZkZWYgQ09ORklHX0NQVV9GUkVRDQo+ICAgc3RydWN0IGNwdWZyZXFf
cG9saWN5Ow0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1dGlsLmMg
Yi9rZXJuZWwvc2NoZWQvY3B1ZnJlcV9zY2hlZHV0aWwuYw0KPiBpbmRleCBhMTc4Mjc1NWVmY2Mu
LjkwYmY4ZDhiZmZiNyAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1
dGlsLmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2NwdWZyZXFfc2NoZWR1dGlsLmMNCj4gQEAgLTEw
MCw3ICsxMDAsNyBAQCBzdGF0aWMgYm9vbCBzdWdvdl9zaG91bGRfdXBkYXRlX2ZyZXEoc3RydWN0
IHN1Z292X3BvbGljeSAqc2dfcG9saWN5LCB1NjQgdGltZSkNCj4gICANCj4gICAJCXJldHVybiB0
cnVlOw0KPiAgIAl9IGVsc2UgaWYgKHNnX3BvbGljeS0+bmVlZF9mcmVxX3VwZGF0ZSkgew0KPiAt
CQkvKiBpZ25vcmVfZGxfcmF0ZV9saW1pdCgpIHdhbnRzIGEgbmV3IGZyZXF1ZW5jeSB0byBiZSBm
b3VuZC4gKi8NCj4gKwkJLyogQSBmb3JjZWQgdXBkYXRlIG5lZWRzIGEgbmV3IGZyZXF1ZW5jeSB0
byBiZSBmb3VuZC4gKi8NCj4gICAJCXJldHVybiB0cnVlOw0KPiAgIAl9DQo+ICAgDQo+IEBAIC00
MDcsNiArNDA3LDkgQEAgc3RhdGljIGlubGluZSBib29sIHN1Z292X3VwZGF0ZV9zaW5nbGVfY29t
bW9uKHN0cnVjdCBzdWdvdl9jcHUgKnNnX2NwdSwNCj4gICAJc3Vnb3ZfaW93YWl0X2Jvb3N0KHNn
X2NwdSwgdGltZSwgZmxhZ3MpOw0KPiAgIAlzZ19jcHUtPmxhc3RfdXBkYXRlID0gdGltZTsNCj4g
ICANCj4gKwlpZiAoZmxhZ3MgJiBTQ0hFRF9DUFVGUkVRX0lETEUpDQo+ICsJCXNnX2NwdS0+c2df
cG9saWN5LT5uZWVkX2ZyZXFfdXBkYXRlID0gdHJ1ZTsNCj4gKw0KPiAgIAlpZ25vcmVfZGxfcmF0
ZV9saW1pdChzZ19jcHUpOw0KPiAgIA0KPiAgIAlpZiAoIXN1Z292X3Nob3VsZF91cGRhdGVfZnJl
cShzZ19jcHUtPnNnX3BvbGljeSwgdGltZSkpDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQv
aWRsZS5jIGIva2VybmVsL3NjaGVkL2lkbGUuYw0KPiBpbmRleCBlYjczYjY1Y2U2YzQuLjM2Zjg4
NDBkMDU2MiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVkL2lkbGUuYw0KPiArKysgYi9rZXJu
ZWwvc2NoZWQvaWRsZS5jDQo+IEBAIC0xNjEsMTAgKzE2MSwzNSBAQCBzdGF0aWMgaW50IGNhbGxf
Y3B1aWRsZShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwgc3RydWN0IGNwdWlkbGVfZGV2aWNl
ICpkZXYsDQo+ICAgCXJldHVybiBjcHVpZGxlX2VudGVyKGRydiwgZGV2LCBuZXh0X3N0YXRlKTsN
Cj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgdm9pZCBpZGxlX3N0b3BfdGljayh2b2lkKQ0KPiArew0K
PiArI2lmZGVmIENPTkZJR19DUFVfRlJFUQ0KPiArCWJvb2wgd2FzX3N0b3BwZWQgPSB0aWNrX25v
aHpfdGlja19zdG9wcGVkKCk7DQo+ICsjZW5kaWYNCj4gKw0KPiArCXRpY2tfbm9oel9pZGxlX3N0
b3BfdGljaygpOw0KPiArDQo+ICsjaWZkZWYgQ09ORklHX0NQVV9GUkVRDQo+ICsJLyoNCj4gKwkg
KiBSdW4gb25lIGxhc3QgY3B1ZnJlcSB1cGRhdGUgYmVmb3JlIGVudGVyaW5nIGlkbGUgd2l0aCB0
aGUgdGljaw0KPiArCSAqIHN0b3BwZWQsIGJlY2F1c2Ugbm8gbGF0ZXIgdXBkYXRlIGlzIGd1YXJh
bnRlZWQuDQo+ICsJICovDQo+ICsJaWYgKCF3YXNfc3RvcHBlZCAmJiB0aWNrX25vaHpfdGlja19z
dG9wcGVkKCkpIHsNCj4gKwkJc3RydWN0IHJxICpycSA9IHRoaXNfcnEoKTsNCj4gKwkJc3RydWN0
IHJxX2ZsYWdzIHJmOw0KPiArDQo+ICsJCXJxX2xvY2socnEsICZyZik7DQo+ICsJCXVwZGF0ZV9y
cV9jbG9jayhycSk7DQo+ICsJCWNwdWZyZXFfdXBkYXRlX3V0aWwocnEsIFNDSEVEX0NQVUZSRVFf
SURMRSk7DQo+ICsJCXJxX3VubG9jayhycSwgJnJmKTsNCj4gKwl9DQo+ICsjZW5kaWYNCj4gK30N
Cj4gKw0KPiAgIHN0YXRpYyB2b2lkIGlkbGVfY2FsbF9zdG9wX29yX3JldGFpbl90aWNrKGJvb2wg
c3RvcF90aWNrKQ0KPiAgIHsNCj4gICAJaWYgKHN0b3BfdGljayB8fCB0aWNrX25vaHpfdGlja19z
dG9wcGVkKCkpDQo+IC0JCXRpY2tfbm9oel9pZGxlX3N0b3BfdGljaygpOw0KPiArCQlpZGxlX3N0
b3BfdGljaygpOw0KPiAgIAllbHNlDQo+ICAgCQl0aWNrX25vaHpfaWRsZV9yZXRhaW5fdGljaygp
Ow0KPiAgIH0NCj4gQEAgLTIyNSw3ICsyNTAsNyBAQCBzdGF0aWMgdm9pZCBjcHVpZGxlX2lkbGVf
Y2FsbChib29sIHN0b3BfdGljaykNCj4gICAJCQltYXhfbGF0ZW5jeV9ucyA9IGRldi0+Zm9yY2Vk
X2lkbGVfbGF0ZW5jeV9saW1pdF9uczsNCj4gICAJCX0NCj4gICANCj4gLQkJdGlja19ub2h6X2lk
bGVfc3RvcF90aWNrKCk7DQo+ICsJCWlkbGVfc3RvcF90aWNrKCk7DQo+ICAgDQo+ICAgCQluZXh0
X3N0YXRlID0gY3B1aWRsZV9maW5kX2RlZXBlc3Rfc3RhdGUoZHJ2LCBkZXYsIG1heF9sYXRlbmN5
X25zKTsNCj4gICAJCWNhbGxfY3B1aWRsZShkcnYsIGRldiwgbmV4dF9zdGF0ZSk7DQoNCkxHVE0s
IG1pbnVzIHRoZSBTYXNoaWtvIGlzc3VlLg0KDQpPbmUgc2lkZSBub3RlIGlzIHRoYXQgSSBicmll
Zmx5IGxvb2tlZCBhdCBzaW1pbGFyIHRoaW5ncyBiZWZvcmUsIG5vdCANCmp1c3QgZm9yIHN1Z292
X2hvbGRfZnJlcSgpIGJ1dCBmb3IgZ29pbmcgaWRsZSBpbiBnZW5lcmFsLiBJdCBtaWdodCBiZSAN
CmRlc2lyYWJsZSB0byBwcmVkaWN0IHRoZSB1dGlsICphZnRlciogd2FrZS11cCBhbmQgdXNlIGl0
IHRvIGRyaXZlIA0KZnJlcXVlbmN5IG9uZSBsYXN0IHRpbWUgYmVmb3JlIGdvaW5nIGlkbGUgZm9y
IGFueSBDUFUuIFRoaXMgYXZvaWRzIA0KaG9sZGluZyBoaWdoIGZyZXF1ZW5jaWVzIGluIHVwZGF0
ZV9zaW5nbGUoKSBhbmQgYWxzbyBhdm9pZHMgaWRsaW5nIENQVXMgDQpob2xkaW5nIGhpZ2ggZnJl
cXVlbmNpZXMgZm9yIHRoZSBlbnRpcmUgY2x1c3RlciBpbiB1cGRhdGVfc2hhcmVkKCkuDQoNCkJ1
dCBwcmVkaWN0aW9ucyBhcmUgaGFyZCBhbmQgdGhlIGVuZXJneSBzYXZpbmdzIGFyZW4ndCBtdWNo
IHNvIEkgZGlkbid0IA0Kc3BlbmQgbXVjaCB0aW1lIG9uIGl0LiBOb3Qgc3VyZSBpZiB0aGVyZSBh
cmUgYmV0dGVyIGlkZWFzLg0K
