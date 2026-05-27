Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269D28E0F;
	Wed, 27 May 2026 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779851924; cv=fail; b=TN4mJK7ttGtmHMdn9aih4bRRrd4uiZ+IsA4WK+bxVTGA78OU7xzjlSyFi2ggvrP1IF1uwWORyrjBQKIQzRI2p9uzJcL+XgkoeNGVpxc5CsKL+vb4aLKTo6B+s534u2Mb+xls8Hq9+P/gMqMcWUKOVSjTMyYcitwXsmsFX/u/rg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779851924; c=relaxed/simple;
	bh=QT8MZ5XjqyL8mrPePJO5wPczqlw5QpxHFcsNvMcRc3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LnsSX+Mvg45bOvQuShs7eB9Va6CWGLTuwrlG5Q2VEFWXGAdFEOZDUEBFO3K85h392kaj6Fem93avxksAM7iPVlTY/mgH2JsEjH+YGLhC8QbihwZVjGfC5iyTnSo2r0oxLKR7OjqiOTy8uXX1jtUXAPzpgNYDeJ8MlTr0fo9zQlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=TgYC6ul5; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="TgYC6ul5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwHx0aV5+q+103hh5kGifWPx38bS4eeRPBOkDYskraEU3cWsjJzGhSj5qwK/8z8mw7G2rYTHoTXxN6fBar1KXcxZs2xVTKiBXAT2jWS7Hi0Pj8EGMchZOEbfqdN4CPill3A+1ePIKgUuhM34qKGaKcYfPbucL9AsW84oCI5aDZQiG55DW+3N6+3XBcykdXiJBioQC9r2t73Su4t6z0EEkm8R/SBCBEYFG1VuRxnv+YJSJxuxpFVU2KPaLqJbGbv8hV8vj84ZA3UaJCg6VjMdQQ3coNGdIOmCp/2aZaFm17njkXfg8d6LH2IKJOQAJRJGbk+LwFM0JD2FHVgUW7/yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT8MZ5XjqyL8mrPePJO5wPczqlw5QpxHFcsNvMcRc3M=;
 b=hJNtiPucA/4LZ6f7MwOy1+V8piJWvtRnZKNKy6RI6ZtEhX/eVqcHBv+RmgZgE0iDpbhUtZocHlLKZBLr/+pMfTeqo+0ea+7uF+kEQl2CAafJT5+YvXGi4Qg5Tzm5NsHL6iTRe9HUeaf6/MOu2+Jmx5pYrMLmusd5Qmhx575LVtR8CEZpi4k7wS45mY7GBdrOUAcb2KBv4S9LWn1JOhLDhvEQkWxt/l3MUGuEogi7zkIjEj01EpXtWDYlOupLysbMpb4Fc68LV/Y7Jvp5mThj/3apVWAdj/lCvjVnCuxnh2oczhvFkb8ugakThNhUrfAGPOwTMlcMDymBmlfLbF473A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT8MZ5XjqyL8mrPePJO5wPczqlw5QpxHFcsNvMcRc3M=;
 b=TgYC6ul5KDpgW1m+cWC16+ZM+C2zRPYXdcn+y+AHv52KjmMAw5+OO6BO3o8u0wBdczg3TSY/2OdGcZ7imxg7AGnjPf/5Df8iR0EWUx2JcH6D2xyyakmm05VgIdmt+nghC42p6j0dlS6oGLesaKu1zJ5hS7vfF4rqxSNmxRDeaxc=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by JH0PR04MB7004.apcprd04.prod.outlook.com
 (2603:1096:990:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 03:18:38 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 03:18:38 +0000
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYZshaAgAAd/ACABsnXAIAAqByA
Date: Wed, 27 May 2026 03:18:38 +0000
Message-ID: <7008900d-0483-40b8-90c9-036942bc1ffa@transsion.com>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <0f7dd656-5ee4-4c14-a27c-fa30c12a676a@arm.com>
 <bc7720fa-012c-4f0e-add6-4db526fdaa2d@transsion.com>
 <cd93c5e6-b581-4a9c-b5f7-09443ab76672@arm.com>
In-Reply-To: <cd93c5e6-b581-4a9c-b5f7-09443ab76672@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|JH0PR04MB7004:EE_
x-ms-office365-filtering-correlation-id: 07c8faf6-5321-4140-32f7-08debb9ea56e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021|921020;
x-microsoft-antispam-message-info:
 6LkS3lXLNh/32J4RW40PXB7CHCwxJV9ZI5FfQxcLLTOIsXzeekNsnHLY2veSJ+eqAy7h9L02kExfeME4wz+KmqKS4mORFCrwlkKXexaRsjoCuSMrCvdaiXxhyu30RTFjjkWd0GJSzM5XsJpXkqZH/MslXccifbgAuWimhsQreVN8QSWs8Z5Q+UoC8cj7OPxYcvxThAVQyyS6t7na9anY8KdzS42CzTxW+kXzHZeFEGR/jKpUqMeV1o5eo0mPtK3o/qyGkOcRBxR5kXFo+XVJFi+A7lDHnmY5uUBSpJC61xQW5kdrMVudOuJVk6iEgJoaAtLa38grRXlpyTC4fXZLGQuDJbmXELzhz7Xly5OZraOTVRDL/qori1IswEdgtCmo624jx0sfxYyZSXEXyx2zAVtWq3owRuY9apq10pNt98MU1eptUh7Bq3FTcmrML0BDoBDfd2DHqIAbGVU3Dpag/fOne8MYtmY6sZL87qKO+B2LnMflBsszU9L+x8qsd0oQ4AFhvmCxyf3IAGgfMUnXX6xrk6BRxfE2MjnYK6BwCvvoj7RrcCuYf/ujM5JKIeCZ7An8Y9XegHi8LKEJAvO1wybuwzSoqHeLMigirLoyxnfSKL3PEy0TSME2F6CMtcaopjrLOg2lRiOF+KLupAgQXCfgHZMaModx4n5nnHZXWnhSMlbUt9m//jfqe1ou3e+oMa8HnTw1j1ZrweNH6D8NViruJdkIPosHIbLXmOw9Ldlfvj/AgDdESfcDikwmCjLrAnGQ1ziEegMwwrBITatG2g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2NiMUx0aElRcUliMjhlY0NzZERVN0lCRGlLMjJZMHlZVW1MUGhTWFVIclo0?=
 =?utf-8?B?ZGE3Um5uK0p1ckRKQU1KY1k3WHhDakx0WXZBQ3JuZGhLWUpRTU94dWtNRnlz?=
 =?utf-8?B?c3hESXZ5VEx3a1FneDRMZWU4L1g0ZnpGemJhYWVhcjBZS3FicUVHdXNpUWRt?=
 =?utf-8?B?c1RGQ3Z2Mm5WUTQwRHhNY0pXN2xIK2FicXg3M21KV0JGYjU1L0U4bGpYWTFh?=
 =?utf-8?B?akFRRXNyZlRlVjRVZGJheFJvS2VkZ0QxNEd3azA2aEg1cHdJMElNVFB1YlVi?=
 =?utf-8?B?SldEb3FMSC84MCtNaWFJakkzUkloNHlNQ21GYk1rOUNxT05xRk42dUswRmc1?=
 =?utf-8?B?UUwwUDhTVUlpQlF3U29vZEVQNjQ1aUwvdkNidy9aN0pCUG9ZMUJiSTJxVE9W?=
 =?utf-8?B?OUp0TldEWkh4TDEvUENLc1ZxRlFOUEVQVWJ4aEZzQmZlb3FORzd6WFVYRHZU?=
 =?utf-8?B?U0F4ZEV5WVJ6U3lHbnovOVlLQnFtdXI5cVhlc1I3Z2JUZnZ1b3pZLzhiNVB4?=
 =?utf-8?B?elpIdGxDM1FKR2lrdXhyeTZJZ21LelBmcnY5S3djWkFvSk52SGw5ZWFKVC9I?=
 =?utf-8?B?bWVBMVlBOXpvTHBtWTRlZkQyNTdUSE5VQmtIUE8zT1ZxNW9BeDJ5WjFMNVVN?=
 =?utf-8?B?a2N6Q2FQUkpQSDByNG5QRDEwQ2ZqMXk2cXA5UGtQZXJmYWZyQUNDWkpzalVi?=
 =?utf-8?B?bmZpV3ZscGlnVzhOQktiRUQ5ekNCMWdJQlNLUTN0eWFHMEFEazV2UTFCYnlU?=
 =?utf-8?B?T0lwTXZHbFZ0QStkNUpTRW1ZaVp5NmNTZDh3QXUrcU9nbXJ5R0c1UE1QaWdX?=
 =?utf-8?B?TGdNZlBEQXdDcVQxZW9TTTdwT1hKeDF4bXFDYVhpTk1FQ1VxNkZweUx4UVVl?=
 =?utf-8?B?eUY1cHoxOTZxMzFHdzFIeXh4T2k1blpiL3h4SnIzaU0wVllmd2pCUXE0T2p1?=
 =?utf-8?B?QVBxc2FKaUFmSTlDOHhsZmk1MUora2dtbE1LYVFEdk1JYjFlbFg1MDBabUlz?=
 =?utf-8?B?TDZSbDZDKzhlN0treFNFSmllVGpRVkFPUjZ4TUxmWUUxK2Q3VjV6MytGOGJU?=
 =?utf-8?B?TS9kdGg1Wm56b2dkOGlYemRnL2xvalg3ZWEyQWFMajNsb2dkRW1XS3NFZVZW?=
 =?utf-8?B?Vk11OXY1RFc4dnBIb2VmRHdHRk10YUJIVHBqZkVIMG5id2hjNFdFN2NxcmdN?=
 =?utf-8?B?RjJMSm9JeTdDTUhLNE9CUENRSithUmRybVBlTlNFdzd1NjNQZi9iMzdLUDV4?=
 =?utf-8?B?RUFaWWdjR2xIU0dHc3I3WXM0WnJic1VRTkpBeUsxdVBzMndvQlVPRTVKVVVk?=
 =?utf-8?B?eGN3VTh0VGdwSCtFeHF4dTF4eDRValBvNnRianhqMjBhMEZnaDBvTm5MNVlj?=
 =?utf-8?B?TlpkQ0d5dGo5OWNiTTRmQkJ6c1JBa0xGajAyUU1RdGdvNFBVQ1QwWFlHdjV4?=
 =?utf-8?B?SDVMbXE4VEVKRVB6V1RvdzdCZmkrZzEwUVMrTlorWVQ0ZGwxMnZ4akptMkUv?=
 =?utf-8?B?WFFXdDNSdllpQkh3ZStWVndvZEdiODJmTVg1ZkZqdm1wZG1wU1Q0L2c4MlR5?=
 =?utf-8?B?ZWtSTGxvNDNaekJKc0hTZzlkbWltS0F3RUdqNjlTZ2VxTkQ2dlowTjQ3RGl4?=
 =?utf-8?B?RTZVK0FKRWZGUGdkUTFGSDhabHBaUUlua0dvUUtvV3BFSU9icFVCK3pWN25U?=
 =?utf-8?B?OTY1NndHWlROck9EQlc2VnoyQlFTa1RoaitJOWgwNlJBRUZsd3NrVXk0R0M5?=
 =?utf-8?B?WFhBWTVrWmRhcE8vaC9WQlVRbjBKcDVqMndsVVJVUnAvcjZQVjJST2tjNDlJ?=
 =?utf-8?B?Unc2d3hqcWk0aGtwMjBtUFgzaXFzRk5DdmJHU2RzL3ZmY0ovZGNjZHlHbXFC?=
 =?utf-8?B?THdJZzI0NFpqdXV6M0tKTGFkdW94VVQwbVBPZE92RzUxcjRWWEExL3o3WXZZ?=
 =?utf-8?B?dEtYQThheW03b3UrbUNCTXpsSjNDNjFBcmRiK0xDVTdMTFpiQUM5MVBTYWVC?=
 =?utf-8?B?SUthak94TFQ3ZHdYdEpxV0pqR1dQb1R0NTJpakdZOEowb2s3T0Q3L1JVcFFS?=
 =?utf-8?B?WkoySXZRd0pVRWhLcVdtMjgrdHNlaUdHSWlYU0Z1MmtmQWpNL3JZZ2hUSW1E?=
 =?utf-8?B?eDZzN3Z2WFRxRC9Fcm5rdDRoZEJMZ1A2Ync3blVpRTRPQkJub2F3aEcxTFd5?=
 =?utf-8?B?UFh2OFNjU3JZNTNpUjBJMTdBOThJZDYvVk11SnFhQkRzRWx5NXdCUkl5Q0Zo?=
 =?utf-8?B?T3A2S2VnYzEvZEd6cVNLYndGb0pPUlhkMW53LzhGWVdCK3dtQ3VWc0U5UWRO?=
 =?utf-8?B?dy9WREZFUm0rTUREU1c0WVRTNS81Wm5JMUlJUDFPTWU4SEpJMkFacTdXZGtP?=
 =?utf-8?Q?0NU4cevlhYlNvLEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACE9DFFB12471544AD398B77153B63EF@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c8faf6-5321-4140-32f7-08debb9ea56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 03:18:38.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqReF3IRpRiTGgZNa+fJ39XyVX19uAiBZJY6drBeUzmCImMAgYZZZUTux5O6oGv/lrnlJdJVNv0BEXOHk+auM3z4mn3LEyTRuthUdnnXKgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7004

T24gNS8yNy8yMDI2IDE6MTYgQU0sIERpZXRtYXIgRWdnZW1hbm4gd3JvdGU6DQo+IE9uIDIyLjA1
LjI2IDExOjM2LCBob25neWFuLnhpYSB3cm90ZToNCj4+IE9uIDUvMjIvMjAyNiAzOjQ5IFBNLCBE
aWV0bWFyIEVnZ2VtYW5uIHdyb3RlOg0KPj4+IE9uIDE4LjA1LjI2IDA0OjQwLCBob25neWFuLnhp
YSjlpI/lvJjlvaYpIHdyb3RlOg0KPj4+PiBGcm9tOiBIb25neWFuIFhpYSA8aG9uZ3lhbi54aWFA
dHJhbnNzaW9uLmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPj4+IEFyZSB5b3UgdXNpbmcgQW5kcm9p
ZCBvbiB5b3VyIGRldmljZXM/IEkgcmVtZW1iZXIgdGhlcmUgd2FzIHNvbWUNCj4+PiBmdW5jdGlv
bmFsaXR5IGFkZGVkIHRvIGF2b2lkIGphbmtzIGluIGRpc3BsYXkgcGlwZWxpbmUuDQo+Pg0KPj4g
WWVzLCB0aGlzIGlzIEFuZHJvaWQgYnV0IHdpdGggc2NoZWR1bGVyIHZlbmRvciBob29rcyBzdHJp
cHBlZCwgc28ga2VybmVsDQo+PiA2LjYgc2NoZWR1dGlsIHdpdGggc29tZSBHS0kgcGF0Y2hlcyBv
biB0b3AuIFRoZXJlIGlzICJzb21ldGhpbmcgdG8gYXZvaWQNCj4+IGphbmtzIiwgYnV0IHRvIG1h
a2Ugc3VyZSB0aGUgcmVzdWx0cyBjYW4gYmUgc2hhcmVkIHVwc3RyZWFtLCBzdWNoDQo+PiBBbmRy
b2lkIHRoaW5ncyBhcmUgZGlzYWJsZWQsIGxlYXZpbmcgYmFzaWNhbGx5IHZhbmlsbGEgc2NoZWR1
dGlsLg0KPiANCj4gT0suDQo+IA0KPiBXb3VsZCBiZSBpbnRlcmVzdGluZyB0byBrbm93IGhvdyB0
aGlzICdhdm9pZCBqYW5rcycgZmVhdHVyZSBjYW4gYmUNCj4gZGlzYWJsZWQuIFNvIGFsbCBBRFBG
ICgnUGVyZm9ybWFuY2UgSGludHMnIGFuZC9vciAnUGVyZm9ybWFuY2UgYm9vc3QgZm9yDQo+IGdh
bWVzJykgaGludHMgYXJlIG9mZj8gQW5kIHRoaXMgY2FuIGJlIGFjaGlldmVkIGJ5IHNpbXBseSBz
dHJpcHBpbmcgYWxsDQo+IFZlbmRvciBIb29rcz8NCj4gSSBoYXZlbid0IGxvb2tlZCBhdCB0aGlz
IGZvciBxdWl0ZSBzb21lIHRpbWUgc28gSSBkb24ndCBrbm93IGhvdyB0aGlzIGlzDQo+IGFsbCB3
aXJlZCB1cCBhbmQgaG93IHRvIGRpc2FibGUgdGhpcy4NCg0KRm9yIG91ciBkZXZpY2VzLCB0aGUg
QURQRi9Qb3dlckhBTCBpcyBlbnRpcmVseSB3cml0dGVuIG9yIGNvbnRyb2xsZWQgYnkgDQpvdXJz
ZWx2ZXMgc28gaXQncyBmYWlybHkgZWFzeSB0byBkaXNhYmxlIGV2ZXJ5dGhpbmcuIEFmdGVyIGRp
c2FibGluZyANCmV2ZXJ5dGhpbmcgaXQncyBwcmV0dHkgbXVjaCB2YW5pbGxhIHNjaGVkdXRpbC4N
Cg0KWW91ciBtaWxlYWdlIG1heSB2YXJ5IGJlY2F1c2UgSSBhc3N1bWUgeW91IHVzZSBQaXhlbHMs
IHdoaWNoIG1pZ2h0IG5vdCANCmJlIGVhc3kgdG8ga25vdyBob3cgZXZlcnl0aGluZyBjYW4gYmUg
ZW5hYmxlZC9kaXNhYmxlZC4gTWF5YmUgdGhlIFBpeGVsIA0KbWFpbmxpbmUga2VybmVscyBjYW4g
aGVscD8NCj4gWy4uLl0NCg0KDQo=
