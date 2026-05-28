Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022080.outbound.protection.outlook.com [52.101.126.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52327E076;
	Thu, 28 May 2026 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932518; cv=fail; b=bPraedLCwmlxLUH0qKFDKuhP+nsYlSFFRr8re+AD6lozn9iN94dKde0+vwf6X3mQyZ95AnPXu8pIsQrcFM9GWIk5Jbk1u8EJD3ohJd0c5aeU1WZIfND6ycegNj7scFwdkzyX6dl3ScEdsqnV7gAsqXrkd8EsHU+kINf4tSepqCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932518; c=relaxed/simple;
	bh=NC39aLl90a9Xb6hh7ixbz54ryVOJnZ5PfgHtBjGdTLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Feyg9O7lRi47m7Z+LtB7oZo2oD4Jer4yk37Lh2y+lemFfgR+WJNon0uZ981x3NHz2E3RgC/sfiYyedcIsZ39IVU2qZVywlHCcwe/hn1XcKWV1zoDpMEcs4y7xzRJEDnPM2pRVmWK+Bt2kaLx0Kf+n0465BN7sERTcMdVwFBwdzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=AFawl78D; arc=fail smtp.client-ip=52.101.126.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="AFawl78D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX0Xae0YSOkM3VHSSi7Eflmn/vd635OaQkBwCGb9NtVB9jaHU1rEE/CbgM/WmMwkjo90KSa/QbufhhNuBWzmiavw1IaKegNP4bUsVbnlZtylvant2g6JQPtvDBdH6yeCXquymMQEx/x9T3qIS4k5b9E0y2WBhEEXtpenij1PeOHiqt3+ImA9Z0vYWIFzmGti7MrP/YwwKMMg6dgLUHjob1TvJaEZJIEqqzfR+e6CpK6CS2XGm6pIbD3BJ3aVozfarruNGcv6dWeNSMt7KHs9VShEwUkLAw2H9HnPp2aktFBzKHSlD7E96mbN6nTZ3s6NDf/WYBwbFcYZbmmiGU95QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC39aLl90a9Xb6hh7ixbz54ryVOJnZ5PfgHtBjGdTLg=;
 b=QmZCNKfc8ruFf34tyPltCL18LD+xoL4HeOw/7veI1S+qlg1tA+DZ4PenBm5/mOdZt1rWFQSzqcb8wWWZH3R8GF1Ofd/p75DZo8w1Mvw/s5+v80UXXaYHIgerRogZHXZp4l7lxJw5YRBeCbL0ZQCxlqw0Ns8VZIYzHaSwo7MwgkEESFbr7J6lVt3YyPD9Hyj0te0yGfwAbKMf703jsMxwj0bF6eZn82gAzgEKoBknIFL+7909nei9N00j2fac9K2yp0DKzkptLSXzA0rEOLdElNZGCr4MuZmdb3v5oz01rgbLz5eEnyBIIXZPvaCJPpR3B6b3Y/7l2PViPYEt8zO0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC39aLl90a9Xb6hh7ixbz54ryVOJnZ5PfgHtBjGdTLg=;
 b=AFawl78DmVOQwiNVMrwedinPLQHSsQIAeZWHtpyvhIOoFWV8zCnE/bnrjJFLY74Rzfy0zoUsJZOT/s/0rEopdyputaAxAc4yM89P72axSJLa7bQSeCcXKyMU/GgUnOC9B0m9TX4mN6J++Dm1MiTLPjm/ti3VKiPA0Fdm7BZG2Xo=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by KUZPR04MB8955.apcprd04.prod.outlook.com
 (2603:1096:d10:49::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:41:52 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 01:41:51 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: Pu Hu <hupu@transsion.com>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYgmfuAgAIfhAA=
Date: Thu, 28 May 2026 01:41:51 +0000
Message-ID: <f8c4e2f6-bf63-436e-8d6c-5be8311fce49@transsion.com>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <d6b41012-923b-4d0e-bc31-42dd74033d3e@arm.com>
In-Reply-To: <d6b41012-923b-4d0e-bc31-42dd74033d3e@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|KUZPR04MB8955:EE_
x-ms-office365-filtering-correlation-id: aa0ea905-8338-40df-0097-08debc5a4aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|38070700021|921020|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Uf/3VG71Im5peOKvYbkI4YgeveiwmrmyajExzhC5bO4tE6SIJhE2tV7+GJ8YZY9/vmj/CrrJgue+Gx+jraDDSerk/NxasZRgvhyHRibmbfyKSFrgdwz45zVRcNJFqZHBXXQc8EbjKEiDthM2t2Mzh912IHOuSstOS/xfdZS3mU1EfC2lZdaOUrg42BnFFe8WdwW2qz/Ou91cXKduC5l8svcy8AX5zaaGgBuxefRoFmIy57kITj9vjWifDMW8I1BAKTcm5JkVWkCn/AVYRwLEkwSY1ibnASLGRZJyfjAhRb43Mbg3KQEVgj0Srrx8yZ110cZY36KLSVNInIp5B8tj9PuNfwlhC+gvpHvqQboiesOGC+Y+dqVqEEaIR27NkPhaD1+9hvpuFeD+OmXnifOjTCLqmuPAvWLiOBcF/G/3XcTsvJmEY7CeZeCzpWL70dmA+Lv7j8O39zDudKolo+YB9N88n+NiYEm7LrIE8Ado7iGN5gCydRmwG66NN9r+iJNHfniqhkaKcK/0UdfHXqqT4+MpgcHg8vi7XVpUQmMkVL7BDqhJlZSjy4GZXWcU3/m395281gxTXONqjAjfQ8MwG9R1Ss/EioNbkIAywqGWw1RcD0uZzQaNnvRVHCDj0S/hZYFrx0p7AFpiHJa7Nqj4bCv52e5yGCA7AaqjSM/7IdDGFduIwfG0B7f1q7Im3kVeAQP+svEJGQ+qonxwgN4tkG30KsbmShZB6P0MMVdPesHCPIeGJT3XUGc7u1scWxHuSpXFdQ6A9IinuJBaDL/qPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(38070700021)(921020)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTIzZGNySk5xaDZoVkx3MFBPRDAzTHpvQThTaEFHRkdZK1ZKQ2MwbWsxbFVh?=
 =?utf-8?B?ZzV5UHlRbHMxRmc3dXMrQTN0cUNNeDVlcEtYaTZ5dWxLNXZBb0xlR2g3VWEz?=
 =?utf-8?B?L0pVZVFERzYrWDR4alZuK2dKaE91RGF1SXdSMU9UenRDSUdXSFFzOThtYVZn?=
 =?utf-8?B?L3BmNnJrSnBqT3hyMmJoSTM5V0ZPZmRvcHRObEpzTjZQWW5LRURVSzRjQmo5?=
 =?utf-8?B?Tkp0UFpBL2xCRmVuQXVSNW9FZHhJWUZTV2xrb1pQZ3lJR2pPTm1icjJCVzFQ?=
 =?utf-8?B?SEpMZjduYmhxZkMyd1JLUTJSUW9IS093dzU2TzZoM0ozWGFWam5vVnM4akxL?=
 =?utf-8?B?ZURlUmVrQjA1RGFZK2hIbUE0dExsSjRuNUJieHJSVm44UjJ3WU5LWjFUa2Vz?=
 =?utf-8?B?cEVnZFlGb3J5bDNzMFcxV0JldXhYZERKbjdHVktMaDZnU0ZIUnUxSlA5UDY0?=
 =?utf-8?B?RTh3VGptMEZRR1FBVkRuOExiSGczUjQrVkxpYlh4TDRIZkkyNEVWL2RCWHMx?=
 =?utf-8?B?cUZ6Y3hjYzU0YkcwQldoM2Q2NUNOS1NybVExMXNZelpkZmdsK0tqSmY0eDBu?=
 =?utf-8?B?NjVmcFNGZk5DUnRoUlZPSVdhanM0bWpibG5WSng4SllXeDcvbXErdmxRWXJL?=
 =?utf-8?B?OEEwZGowWG9yYk5jdzFFVVphOHk2WTQxWjB1RFNvS21vQmZRT25yck02WTlw?=
 =?utf-8?B?YTdhbGx4anF4eUIrQUg1M3p1cUZ0MWVBVUZrakxyU1ZURGNYbHVqZVpqc2w0?=
 =?utf-8?B?MmUvWnhHR1pWVWJkMkVVNjRCczZsTUw2NERiUTdEUWl2MHhhNmwyenAwbm1D?=
 =?utf-8?B?MHZ5RXlmd1ZIK0tNOHMwRlJFSGZLbnZ3ckc1WGNKQ1RSTTc2cm4wTXF3R3Ew?=
 =?utf-8?B?YTd0cXRqTXJ3d2FRRkxYYllMamQ5MjVZTU9kWGEvTVNndUF3WE5nY056OFBj?=
 =?utf-8?B?Wmh1Nkg5c05Td3JWbnZ6TkR2bTlpaGdLWXRjSHRVNllicFNYNnpxa3k0TmFZ?=
 =?utf-8?B?Z2s1QkF4bXBPclpwN2p3eU4xMHB4VkJEaEkyWkl6d0k5eEFBT3NjNi9hTGQ0?=
 =?utf-8?B?MlVCU21ZcjdxN09hb1IrK1NRRExaR2JjRmNBVlU5VkJBM1ZaS3NxclpLaHhM?=
 =?utf-8?B?clZ6Nm5VSlRhN0s1ei9JQjNEYno5VlZWNVN1RXRJeGNzZWlqYXNBK2hjTUZH?=
 =?utf-8?B?RlIvbGVjWXY2czlVY2xaYkNIT1QzVDRsWFFkVjRmTmV4Z0NJb0R0eU9MZ0M1?=
 =?utf-8?B?SFk2UG90b3d3OTdtSlJNNEV2aENlN2FRblRvZ3dZMkgyd3Ayekw4YytJbFdC?=
 =?utf-8?B?Mnhvd2d2OEV2K0MwVkNuWWM4TXBKaE5FeVBxaWxrUHZaM3hJSWt5V1g4UUxu?=
 =?utf-8?B?RkUzbGJlQ0dyOGVtMkM2TlRNMXJsaGdLNmNKT21EQ0RWcGZ1aENTbWlYN1Zp?=
 =?utf-8?B?UVZ5a3Z4bXlxd3VoRFJ0d1huN3c5S0pKV1FEZ0lLQmJIRUFQQjhTSzNPdGk5?=
 =?utf-8?B?VERVTmN5cnZRT0J0ZGtXajU0VjBhbytpSkc3RlJ4SFhvSDNXK1c5RDE1UG5U?=
 =?utf-8?B?ZWh0MzhwNmZkbUZFS29YVjRVbDdKaXJocFdVbmlyVTN4Y2hvbmFTU0IxMXJz?=
 =?utf-8?B?UkJYR3JzckYvdlAxTVcrTVBnZGd4VVdyVzZ3aHc0UFZKMTNDUzB5dDVIYWxy?=
 =?utf-8?B?SlcrY2hTcXRZQ3l5angrZk1TZTZGQjR3RVpjQzU4ZHJLVVdGdlVJQUFTSlU3?=
 =?utf-8?B?UFhYa3dpYmtLNlJ1U0d5cUcvVU4xc294blhsenM0My9Db1pTckZwR2lPNlJz?=
 =?utf-8?B?WS9KbjRqcGlqM1N1UGZXeGREMHZJTGIzc3hKbDVMSk9tdjhWN0tJbWo5UDhJ?=
 =?utf-8?B?dW8wSFhmN0dvZjZ6UlBDU3BGbW5WZjdjaFFDc1F4c0drWVppYkF4WjNLU3dQ?=
 =?utf-8?B?VnB2QjRoWmpXTFJXT3IzMS96eG5qcFkwNk5BRDFYVS9FcWtIYzNpQ1VFKzRX?=
 =?utf-8?B?WEpBWk1UZ0lCbHpwd1l3eTNNUjlROHhVYTlZeG1FdVdoZEZqZ3paalRWSmFF?=
 =?utf-8?B?UHo3S1lER2ZJOGhsVEdIRmd6UGpqaUpyc0syYS9rQnVvaWxIN2VCY0poOVNm?=
 =?utf-8?B?M1JXQ2JKaExDRWdtZ3ovbzFkdVR0WkNOTDVPZmJtU0xIMlJwSjk3VmR3UDJu?=
 =?utf-8?B?bEtXZVFsTFBiK0VUTWNSSkZCaDdqaGdhWW1sMnVoYzg2dlVCbDlocFRjQ3Vy?=
 =?utf-8?B?eXgyWnQ4cDNXQjNTWW4wc3F2UFNyOWFjYXBVWkQxeDhsQlhxZEswQmNSaUN5?=
 =?utf-8?B?UDE3V05IOS9JQWxob1c1d1J0TVpLdjhNTkZyNDR4YmEvbndoOGg0b2hUUlZT?=
 =?utf-8?Q?+K/o27U0k/IsH95w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9D6ED067B88543AAB9E3DADCE2D0D4@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0ea905-8338-40df-0097-08debc5a4aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 01:41:51.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vo7wYIXypEU+mgKEm+CTqlLa28KrIBMYEOe9bbEPLE7KjrNYUe4baMZ40PCFjIeKC35F41DgpY1XkZAcvfnnOYTztOKqwkbI+eU6qJIiKf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8955

T24gNS8yNy8yMDI2IDE6MTYgQU0sIERpZXRtYXIgRWdnZW1hbm4gd3JvdGU6DQo+IE9uIDE4LjA1
LjI2IDA0OjQwLCBob25neWFuLnhpYSjlpI/lvJjlvaYpIHdyb3RlOg0KPj4gRnJvbTogSG9uZ3lh
biBYaWEgPGhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20+DQo+Pg0KPj4gV2UgaGF2ZSBzZWVuIGEg
bWFzc2l2ZSBwb3dlciBjb25zdW1wdGlvbiByZWdyZXNzaW9uICgyMCUgU29DIHBvd2VyDQo+PiBp
bmNyZWFzZSBpbiBtYW55IGFwcHMpIGFmdGVyIHVwZGF0aW5nIG91ciBrZXJuZWwuIEFmdGVyIGJp
c2VjdGlvbiB3ZQ0KPj4gcGlucG9pbnRlZCB0aGUgcmVncmVzc2lvbiB0byB0aGUgY3B1X3V0aWwo
Ym9vc3QpIGZlYXR1cmUuIEFmdGVyDQo+PiByZXZlcnRpbmcgdGhlIGJvb3N0IGZlYXR1cmUgdGhl
IG1hc3NpdmUgZW5lcmd5IHJlZ3Jlc3Npb24gaXMgZ29uZS4NCj4+IERldGFpbGVkIHRyYWNlIGFu
YWx5c2lzIGRvd24gYmVsb3cuIFRoZSByZWdyZXNzaW9uIGlzIGZvdW5kIGFjcm9zcyBxdWl0ZQ0K
Pj4gbWFueSBhcHBzIGJ1dCBZb3V0dWJlIGlzIG9uZSBvZiB0aGUgd29yc3Qgb2ZmZW5kZXJzLCBz
aG93biBpbiB0aGUNCj4+IDEwODBwNjBmcHMgdmlkZW8gYmVuY2htYXJrOg0KPj4NCj4+ICAgU2V0
dXAgICAgICBGUFMgICBTb0MgUG93ZXIgKG1XKSAgZGlmZg0KPj4gdy8gIGJvb3N0ICA1OS45NCAg
ICAgIDkxMy42DQo+PiB3L28gYm9vc3QgIDU5LjkzICAgICAgNzIwLjQgICAgIC0yMS4xNSUNCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNv
bT4NCj4gDQo+IExvb2tzIGxpa2UgSSBtaXNzZWQgcnVubmluZyBvbmUgb2YgdGhlIGxvdy1wb3dl
ciB0ZXN0IGNhc2VzIGJhY2sgdGhlbi4NCj4gDQo+IFRoYXQgc2FpZCwgYm9vc3RpbmcgdGFza3Mg
dW5kZXIgY29udGVudGlvbiBkb2VzIG5vdCBzZWVtIGxpa2UgYQ0KPiBwYXJ0aWN1bGFybHkgZ29v
ZCBpZGVhLg0KDQpBY3R1YWxseSBpdCBjb3VsZCBiZSBkZXNpcmFibGUgdG8gYm9vc3QgdW5kZXIg
Y29udGVudGlvbiwgYnV0IHVzaW5nIHRoZSANCnJhdyB2YWx1ZSBvZiBydW5uYWJsZV9hdmcgbWln
aHQgbmVlZCBzb21lIHJlLXRoaW5raW5nLg0KDQo+IEphbmtiZW5jaCwgYmVpbmcgcHJpbWFyaWx5
IGEgVUkgcmVuZGVyaW5nIGJlbmNobWFyaywgd2FzIHByb2JhYmx5DQo+IG92ZXJlbXBoYXNpemlu
ZyBzdHJlc3Mgb24gdGhlIEFuZHJvaWQgR3JhcGhpY3MgUGlwZWxpbmUgKEFHUCksIHdoZXJlIHRo
ZQ0KPiBydW5uYWJsZV9hdmcgYm9vc3RpbmcgaGFwcGVuZWQgdG8gaGVscC4gU3VwcG9ydCBmb3Ig
SmFua2JlbmNoIGFsc28NCj4gYXBwZWFycyB0byBoYXZlIHN0b3BwZWQgd2l0aCBBbmRyb2lkIDEy
IOKAlCBJIGFtIG5vdCBzdXJlIHdoeS4NCj4gDQo+IEF0IHRoZSBzYW1lIHRpbWUsIGxvdy1wb3dl
ciBiZW5jaG1hcmtzLCBhbmQgZXZlbiBnYW1lcywgZG8gbm90IHNlZW0gdG8NCj4gaGF2ZSBlcXVh
bGx5IHN0cmljdCByZXF1aXJlbWVudHMgZm9yIGNvbnNpc3RlbnRseSBtZWV0aW5nIFVJIHJlbmRl
cmluZw0KPiBkZWFkbGluZXMuDQo+IA0KPiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRoYXQgdGhlIEFH
UCBpdHNlbGYgaGFzIGV2b2x2ZWQgc2luY2UgdGhlbi4gSQ0KPiB2YWd1ZWx5IHJlbWVtYmVyIGEg
R29vZ2xlIEJvb3RjYW1wIHByZXNlbnRhdGlvbiBkaXNjdXNzaW5nIHRoZSBpbmplY3Rpb24NCj4g
b2YgcGVyZm9ybWFuY2UgaGludHMgYXQgdGhlIGJlZ2lubmluZyBvZiBhIGZyYW1lLXJlbmRlcmlu
ZyBjeWNsZSB0bw0KPiBtaXRpZ2F0ZSBlYXJseSBqYW5rLCBidXQgSSBjYW4gbm8gbG9uZ2VyIGZp
bmQgaXQuIEkgYWxzbyBkbyBub3Qga25vdyBob3cNCj4gdGhhdCBhcHByb2FjaCByZWxhdGVzIHRv
IHRoZSByZW1vdmFsIG9mIGFsbCB2ZW5kb3IgaG9va3MuDQo+IA0KPiBHaXZlbiBhbGwgb2YgdGhp
cywgSSB3b3VsZCBhbHNvIGxlYW4gdG93YXJkIHJlbW92aW5nIHRoZSBydW5uYWJsZV9hdmcNCj4g
Ym9vc3RpbmcgZnVuY3Rpb25hbGl0eSBlbnRpcmVseSwgcmF0aGVyIHRoYW4ga2VlcGluZyBpdCBi
ZWhpbmQgYSBzY2hlZA0KPiBmZWF0dXJlIGZsYWcgdGhhdCBkZWZhdWx0cyB0byBmYWxzZS4NCj4g
DQo+PiBAQCAtODIyOSwxNiArODIyMiwxMCBAQCBzdGF0aWMgaW50IHNlbGVjdF9pZGxlX3NpYmxp
bmcoc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgcHJldiwgaW50IHRhcmdldCkNCj4+ICAgICog
UmV0dXJuOiAoQm9vc3RlZCkgKGVzdGltYXRlZCkgdXRpbGl6YXRpb24gZm9yIHRoZSBzcGVjaWZp
ZWQgQ1BVLg0KPiANCj4gcy8oQm9vc3RlZCkgKGUvKEUvDQoNCkFjay4NCg0KPj4gICAgKi8NCj4+
ICAgc3RhdGljIHVuc2lnbmVkIGxvbmcNCj4+IC1jcHVfdXRpbChpbnQgY3B1LCBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnAsIGludCBkc3RfY3B1LCBpbnQgYm9vc3QpDQo+PiArY3B1X3V0aWwoaW50IGNw
dSwgc3RydWN0IHRhc2tfc3RydWN0ICpwLCBpbnQgZHN0X2NwdSkNCj4+ICAgew0KPj4gICAgICAg
IHN0cnVjdCBjZnNfcnEgKmNmc19ycSA9ICZjcHVfcnEoY3B1KS0+Y2ZzOw0KPj4gICAgICAgIHVu
c2lnbmVkIGxvbmcgdXRpbCA9IFJFQURfT05DRShjZnNfcnEtPmF2Zy51dGlsX2F2Zyk7DQo+PiAt
ICAgICB1bnNpZ25lZCBsb25nIHJ1bm5hYmxlOw0KPj4gLQ0KPj4gLSAgICAgaWYgKGJvb3N0KSB7
DQo+PiAtICAgICAgICAgICAgIHJ1bm5hYmxlID0gUkVBRF9PTkNFKGNmc19ycS0+YXZnLnJ1bm5h
YmxlX2F2Zyk7DQo+PiAtICAgICAgICAgICAgIHV0aWwgPSBtYXgodXRpbCwgcnVubmFibGUpOw0K
Pj4gLSAgICAgfQ0KPj4NCj4+ICAgICAgICAvKg0KPj4gICAgICAgICAqIElmIEBkc3RfY3B1IGlz
IC0xIG9yIEBwIG1pZ3JhdGVzIGZyb20gQGNwdSB0byBAZHN0X2NwdSByZW1vdmUgaXRzDQoNCg==
