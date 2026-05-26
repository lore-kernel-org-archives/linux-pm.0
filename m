Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023130.outbound.protection.outlook.com [40.107.44.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953B3CB8F4;
	Tue, 26 May 2026 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779780951; cv=fail; b=fggcgxAhg7OuLpNM4nmf9qKEokvlXkTwmEDrJxZikkR7cRliH1EuIICHkXzOqnyAu0JJYBeUQnLnw+Qk49iz9eO4TMMrl4FI87BTrQmLt1zpWVHQQFNMgcO7K3BAd+W7eYeE6xHdbWrr/trW1kUd5593aNkzhEfeoHGlXLa7c2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779780951; c=relaxed/simple;
	bh=EyhwsxMriluafNt/VBwGaM7vt8Ng3u7mnUH2Iq4Ebtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CId4RvLRoHNIY3BPvH1O2iAC5VhSYh0Cz3nzNeNQ3ylGEpOPQOR60ZFdG2KoCwwBrRZE6EbSs0dftfmLnOdilkUaVq3g/x3tSAGncLe2cZemq+pgFOrsTdJfmcr8ljwpcm4NRVYv1C4lPN6RLgz0mzTtmX8SSo6/LqCRhId+jXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=cRsLBOH7; arc=fail smtp.client-ip=40.107.44.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="cRsLBOH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpaYmNiArxlU6PveW3omW7VqFkWZnB+lWFXUTkRSG99x1mlIEfFIj7hRe2BKTekBXDDagqEfGDnGoYQvfA+XkuRKpoz5Wu65Qd+RFmzhLY3D1OxY1BR0ZzeV6j1ncqndkHMXNHNDMabIvb9HHYQAfaxwueDvFNEgiPZ0q7usU/9QippRj60jMxoRzawdsL21l5BQVA1ulAb2oGakgGrwJRktq4VupjI2R/3yo2sBx+gRFBQDF/cg3KW+NSzNwL00DeT7DLEJXetlFFx4SqdtWRvjAsair4yvu3MzsoosOxNf33EqevdF4ma6AiAymQ1YwZDNuzx8U/YOGk9V+Up6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyhwsxMriluafNt/VBwGaM7vt8Ng3u7mnUH2Iq4Ebtg=;
 b=dw+a2tsFRBqFQayQMw0RUqqRqDCttGMF1DQJqUyXytnkbXk0KZTO7PeUR3v0uoGNF4vSJNOt+7Ytr0S681IA4XgTRAKmC3k5o5Ye1TbN3ptBIMfGXZsTk42v4NqzkEe3gk/3fS/UdpvcUC6E5GeLi516YQWVIlLq2k3lB/6WMirp6WrfAQJ3VzRywpm8c+TdiVPA0vuZCvRwqi+fGjy7TKMltObCuHLCSfs9IQN3+IroDfm+tXHYQTCNkNg0XhHLJFvLPlu0xJq5SHwu/CRtIs++8O8ML7lAgUY2iyM0LrHtPyLT9bshNdtpSkSwkOxOy/R63bGMDkQoYM41cyY8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyhwsxMriluafNt/VBwGaM7vt8Ng3u7mnUH2Iq4Ebtg=;
 b=cRsLBOH7s2fmBPngtWFjQPy2Fy90TBIanv1QV43ezu8qqXDmpiX2Ggvw6ihXqtAio2pwYLrQ8UfMY848chAR2P5RzYqu1EL7IDpzkYjjhQ+l1QLK+Kb2Or11QUitxQIu4FAsC6QfH+AQuOItOd4NW7zF5eWmNmCm9har0UJ4xTM=
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com (2603:1096:400:32b::10)
 by SEZPR04MB8150.apcprd04.prod.outlook.com (2603:1096:101:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:35:46 +0000
Received: from TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb]) by TY0PR04MB6192.apcprd04.prod.outlook.com
 ([fe80::e43:f9a5:d1da:59bb%2]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 07:35:45 +0000
From: Hongyan Xia <hongyan.xia@transsion.com>
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: Pu Hu <hupu@transsion.com>, Jiazi Li <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYTjqUAgAxpIgA=
Date: Tue, 26 May 2026 07:35:45 +0000
Message-ID: <1bfeb1d7-43c8-440e-85c7-1ae415ab91e9@transsion.com>
References: <20260518024039.932-1-hongyan.xia@transsion.com>
 <97ac52d6-98b4-4b15-b50b-f606b53a2288@arm.com>
In-Reply-To: <97ac52d6-98b4-4b15-b50b-f606b53a2288@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6192:EE_|SEZPR04MB8150:EE_
x-ms-office365-filtering-correlation-id: 470891f5-8412-41ec-7a87-08debaf9663f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|4143699003|11063799006|5023799004|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 Oh2QBdV0KvcfAefu7Fw3uJyeg62sDQKjT/DCacqUwt4Mn/GU/GfU5k0EgAo71W1uw62uuMjP0RslnmvU/+S/8YbYmaIpJ4lJZqBL7UfTIw9b/ti/4hdDCR2n5QOgpfoedP00r2XD1flQ5waYETDiZZhufTTfk+hHMjJ8Mkj8Pe8u1C9V2SQYJcpazRwKDJmI280Ati0/6IUUiioYoMAnJzk1AM6Up97bcIn2adzQeZywqYGAhecW3jURjBaNlXk/Hd2GZ179iNXwGMwBrFSvtWzM2sn6Ky3ig4dNNG5ZKsCQ0qBNGeoWG3lYn5cx/i3lMxd8sZ4YaD6LM+AGHkJSK44+lulMPyB9SAviVCBQ5MIvIPu+dnG2w09SuYxgC7jVgCy8o0qM004IkKZfcD78sHRnyGSm+VsA+G4MMejZyt3Vu+lN72Deta83CFBlVqYAEmJPNTNnG/OSYwPA4+dv+Gh42KuF4hf8JFnwX1eMuC78GGsu6ETTqVTmySiHApqhNC1Zu/h2adDxkN1rqwqbud68Kpf1wzD6rZK5hVYCJmd4XvKzky6xYp/SUqq3S+3VRtnNBh2f04RcTj4CM9FMQwQy7hZbFObah7fM6kA8moRCaVhF1QuTs+l4R/w8IM5bBPyH+BPs+c221Z8SUpx0l0r00kb9W049CJL03XatdvZRLCaz+eZu2GztpNa+znaoc3MXK0ksxUqr0wDNAq6mg/SPUVXuE/4TY+Tl2yPWbWU0rw49DkZYWX7zB91ZHgsYe1X5OgGPyqU3cshyyRtPlQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6192.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(4143699003)(11063799006)(5023799004)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEUyM1VnaGhjajR5ZmtmZG13ZHN1Q0pIa1crSnlESFlNS1FkOEdqeEs2STMx?=
 =?utf-8?B?L1J1U0txVzJsUmRmMEVKbHdHZW50L3J3VXBTQWgreFQ5QmJMckxPZERhWmtD?=
 =?utf-8?B?T1EvOXBHeUxlQzBEcnovTGZaTHk3RDI1eU1hM0VwcGlidzNvbndSRWMxOGlB?=
 =?utf-8?B?Z0VWcHRDeklxdGNMN2JIblFsWUFMMXQ5Z1ducXI4Y2Q3SnJPL3dNa0Q2a255?=
 =?utf-8?B?ejBhN2R6SVFNdDRqRHBTeXNwa0drVUhEZmh5N2oySnd2T1BJcjVHQnNIUGVw?=
 =?utf-8?B?UGhmRmRaMkdFN1loYjF2c2NTR3A0VHpkV3hWVitJRDcrL2dwUHo1UkphVURI?=
 =?utf-8?B?OFlqTFd5ZUszb3I3NEo3dnZNQjR5TEpCd3p1YThvVzBsR3BHN1g0R25TSnFK?=
 =?utf-8?B?dytjamVxQUJvRFdNZ0FIZzNHcDFqL1hZQXkyNHZndXRIa2Jad2pSK3oxQnJE?=
 =?utf-8?B?ZHBpcTFUeXRjK3A3YUtDc0NVcFByZ2FpK2lWUVlCeHpFdEFabGgvOWx3UzUw?=
 =?utf-8?B?RDEwd01CT2VuMElVRytia3M0QVRBTnZvQWFFVXVza05UWGpmbDFhUjI4c1BV?=
 =?utf-8?B?amFoWm5OQW5ySUxLQ3pvOUNTbDZzSXZmSnRGOXRrUSttbW9PUVFQTURiRld6?=
 =?utf-8?B?bmJueHJqTXhHUmppdEp2R1dCNVkyRGdBMlRqUnNBcVUxaUF2SFp4dk10eDdm?=
 =?utf-8?B?TW5yZDRXZDZJREJ5aFJTK2pKRllBa0ZBSVo4eG96UGJOZTR0MnBWbUlNYWZI?=
 =?utf-8?B?ZExlZFJBeE5nVUhLNFUvSzlxYzRsTmoweThNbTRrK1gzYndJWW52R3dCbEwr?=
 =?utf-8?B?cFRvQ2lIckI3SFRSWnZoTmd5NDJkQitoQzlOdHJnYkR3RmQ1ZHJTUGFsZUlQ?=
 =?utf-8?B?R1NCcW9pOUxLNnNaWXJSN0JNR0xvUnZENHpvdGFUMWdGVlMxWTNhN3Ezalhr?=
 =?utf-8?B?bjRtejV1VlErTFVDNDRQY3hlSVFOckE0eGUzNTF6UnQyOFRVUmRMc29ySTlT?=
 =?utf-8?B?TkdqbjA1eWs2Vm5RLzV4RkpVdmE2V0RFalB4Rlp2a3l5d0FNbkg5dHdsTTVy?=
 =?utf-8?B?WFozT25SWjdBbGkzMG1Gc0xVRzNyYi9SNHBMK294eWpRRmxLRTg5VHFWRHRk?=
 =?utf-8?B?SHN0b2pKbGtyMWZMVS9CQy9SV3lSdTFLSUxzbXY5RU5zYUZTZnBENHNQMkZD?=
 =?utf-8?B?TmpuM1B3WlorSzF3QWhVYS9SNzQ0SU5Bc1NlMVIvSGpCajhPNXVhSCs3L29M?=
 =?utf-8?B?Yi8wdU9kRDRNa0l5Y1pvZzNlMEpxU0MyZjlrUzJLTlpsNkZUYXBtdDZ3aVNU?=
 =?utf-8?B?WXhBNDdhaElNT2EwTExLb0UramhJRnFhSjNpditMcHhBb2FDaEpJUmV0aVp1?=
 =?utf-8?B?cFZCYVhTS3huTnBiUkIzSlBoUld6Z2wvRGRNdGJkNngrV0djMy9sTUF5SVVq?=
 =?utf-8?B?VGJBdWZmbFBOU0xZTFhraGpIbEFWZ28rRDhab3FZWlc3VXlBN1FRaG1jWWlU?=
 =?utf-8?B?bU9ucjhVaUxpN3FRbFdmazVLWnNKQzVRSytQMWlzM0tseXlGWXBlUU51NDZP?=
 =?utf-8?B?Y0RQREVqZElWTUxieTd0WEN1eHcyNnZ6aXN5TEhNWkRMWExRT2lEYy9GanNv?=
 =?utf-8?B?WGlpVG94aE14REU5OXQrRGlWQVlXeHAyUEtHbzhJSitXcTJFWHZzWU5FNkpo?=
 =?utf-8?B?WkUyblhTejNvZjZYMlpJZHVRNTFOenlweTdZajV4M0M5cCtyOXZXOVRJcTBq?=
 =?utf-8?B?M0VNT1JwUDEzSFovTFZ6bGxTSUhtNWdPN01rU0RJeEVscVhaamhOZS91MzBM?=
 =?utf-8?B?dDNiaTZoSndPajMyeG5LcXJkcG9zRGhrcEc4VGVJTmVrWk1NZllWa2kyTTJk?=
 =?utf-8?B?ZzcwQlBtaVJZOUJORk9YY2JnTUc3aHE3NGQ1emw1MjVsaDFzOWRxSlNDMFc3?=
 =?utf-8?B?Y0ViQWRqU3lqWmpUYTErRnI5S05lODVJdElJYmViSkVBbUs1VHBmLzFXV2Qv?=
 =?utf-8?B?N1Q3bVFNQXFPNXErek5MTnE3ZnJCT1Fsd3NzbjFhYjN0d3JITGc2TjRNVXNm?=
 =?utf-8?B?TDBlRGRlVms2MnRhcVFpam1NQitlNnpBVGZmQnc0RGhxa2lnWVlvUC9ja2gx?=
 =?utf-8?B?SllQenpBRlAzMjR6OHY4ckt6M2o5cDhGYythSzdGSWk1NkVJTndhTG9FazlU?=
 =?utf-8?B?Qy9Lb3hDeDA5Ri96aVlDVld2a2MzVnRlOGJtaHpWYmxXVVY4ZFV5dW5lT1Qx?=
 =?utf-8?B?U0daTStTS2V4Ylo0ck53UzJqNFJTbnMva0UrRC9oVTAxd0VocEwrQkFKOEVj?=
 =?utf-8?B?VzdRbVh2a0NLdzROeTRabkpBK1doaTR1dFgxR3ZaTDJnOWlGTTJ3dUF1T2x2?=
 =?utf-8?Q?REDb54gKlJjMYjCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C8D5AA673DAC4B90976F4A82F8D45B@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 470891f5-8412-41ec-7a87-08debaf9663f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 07:35:45.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spc7/AFrUuOTXe1bXMrOXz+s2f0SPXKIR2QJfbrB94K8Oy/VxoDrjDGuDRcc/3aRZV/bmfh5GVRSdfngQMLQ9KgJyH6ejvxGWXVcVl3FpbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8150

T24gNS8xOC8yMDI2IDY6MDQgUE0sIENocmlzdGlhbiBMb2VobGUgd3JvdGU6DQo+IE9uIDUvMTgv
MjYgMDM6NDAsIGhvbmd5YW4ueGlhKOWkj+W8mOW9pikgd3JvdGU6DQo+PiBGcm9tOiBIb25neWFu
IFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiBXZSBoYXZlIHNlZW4gYSBt
YXNzaXZlIHBvd2VyIGNvbnN1bXB0aW9uIHJlZ3Jlc3Npb24gKDIwJSBTb0MgcG93ZXINCj4+IGlu
Y3JlYXNlIGluIG1hbnkgYXBwcykgYWZ0ZXIgdXBkYXRpbmcgb3VyIGtlcm5lbC4gQWZ0ZXIgYmlz
ZWN0aW9uIHdlDQo+PiBwaW5wb2ludGVkIHRoZSByZWdyZXNzaW9uIHRvIHRoZSBjcHVfdXRpbChi
b29zdCkgZmVhdHVyZS4gQWZ0ZXINCj4+IHJldmVydGluZyB0aGUgYm9vc3QgZmVhdHVyZSB0aGUg
bWFzc2l2ZSBlbmVyZ3kgcmVncmVzc2lvbiBpcyBnb25lLg0KPj4gRGV0YWlsZWQgdHJhY2UgYW5h
bHlzaXMgZG93biBiZWxvdy4gVGhlIHJlZ3Jlc3Npb24gaXMgZm91bmQgYWNyb3NzIHF1aXRlDQo+
PiBtYW55IGFwcHMgYnV0IFlvdXR1YmUgaXMgb25lIG9mIHRoZSB3b3JzdCBvZmZlbmRlcnMsIHNo
b3duIGluIHRoZQ0KPj4gMTA4MHA2MGZwcyB2aWRlbyBiZW5jaG1hcms6DQo+Pg0KPj4gICBTZXR1
cCAgICAgIEZQUyAgIFNvQyBQb3dlciAobVcpICBkaWZmDQo+PiB3LyAgYm9vc3QgIDU5Ljk0ICAg
ICAgOTEzLjYNCj4+IHcvbyBib29zdCAgNTkuOTMgICAgICA3MjAuNCAgICAgLTIxLjE1JQ0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEhvbmd5YW4gWGlhIDxob25neWFuLnhpYUB0cmFuc3Npb24uY29t
Pg0KPj4NCj4+IC0tLQ0KPj4gQW5hbHlzaXM6DQo+Pg0KPj4gV2UgZm91bmQgc2V2ZXJhbCBwcm9i
bGVtcyB0aGF0IHJlc3VsdCBpbiB0aGUgcG93ZXIgc3Bpa2U6DQo+Pg0KPj4gMS4gQXJpdGhtZXRp
YyBzaG91bGQgbm90IGhhcHBlbiBiZXR3ZWVuIHV0aWxfYXZnIGFuZCBydW5uYWJsZV9hdmc6DQo+
Pg0KPj4gQWZ0ZXIgdXRpbCA9IG1heCh1dGlsLCBydW5uYWJsZSkgd2hpY2ggcG90ZW50aWFsbHkg
cGlja3MgcnVubmFibGUgdmFsdWUNCj4+IGluIGNwdV91dGlsKCksIHdlIHRoZW4gYWRkIG9yIHN1
YnRyYWN0IHRhc2sgdXRpbCB2YWx1ZXMgZnJvbSBpdC4gVGhpcw0KPj4gcHJvZHVjZXMgYSB2YWx1
ZSB0aGF0IGlzIGhhbGYtcnVubmFibGUtaGFsZi11dGlsIHdoaWNoIGlzIGlsbC1kZWZpbmVkLg0K
Pj4gVGhpcyBhbG9uZSBzaG91bGQgYmUgYSB3YXJuaW5nIHNpZ24uIFRoaXMgYnJlYWtzIEVBUyBj
YWxjdWxhdGlvbnMgaW4NCj4+IG1hbnkgY2FzZXMsIGxlYWRpbmcgdG8gc3ViLW9wdGltYWwgdGFz
ayBwbGFjZW1lbnRzLg0KPj4NCj4+IDIuIFVzaW5nIHRoZSBhYnNvbHV0ZSB2YWx1ZSBvZiBydW5u
YWJsZV9hdmcgdG8gZHJpdmUgZnJlcXVlbmN5IGlzDQo+PiAgICAgdG9vIGhpZ2ggdG8gYmUgcmVh
c29uYWJsZToNCj4+DQo+PiBXZSB1c2UgcnVubmFibGUgaW4gYSBfcmVsYXRpdmVfIHdheSB0byB1
dGlsIHRvIGtub3cgd2hldGhlciB0aGVyZSBpcw0KPj4gY29udGVudGlvbiBpbiBzZXZlcmFsIHBs
YWNlcy4gSG93ZXZlciwgdGhlIF9hYnNvbHV0ZV8gdmFsdWUgc2hvdWxkIG5vdA0KPj4gYmUgdXNl
ZCBsaWtlIHV0aWwuIFJ1bm5hYmxlX2F2ZyB0ZW5kcyB0byBiZSBzaWduaWZpY2FudGx5IGhpZ2hl
ciwNCj4+IG1ha2luZyBpdCBtdWNoIGVhc2llciB0byBzYXR1cmF0ZSBmcmVxdWVuY3kuDQo+Pg0K
Pj4gRm9yIGV4YW1wbGUsIGlmIHRocmVlIHRhc2tzIGVhY2ggd2l0aCBhIHV0aWwgb2YgMTAwIGNv
bnRlbmQgb24gdGhlIHNhbWUNCj4+IHJxLCB0aGUgcnEgdXRpbCBpcyAzMDAgYnV0IHJ1bm5hYmxl
X2F2ZyBzaG9vdHMgdXAgdG8gOTAwLiA5MDAgZHJpdmVzIHRoZQ0KPj4gQ1BVIGF0IHRoZSBtYXgg
ZnJlcXVlbmN5LCBhbmQgaXQncyBoaWdobHkgcXVlc3Rpb25hYmxlIHdoZXRoZXIgdGhpcw0KPj4g
Ym9vc3QgaXMgdGhlIHJpZ2h0IGRlY2lzaW9uLg0KPj4NCj4+IDMuIFJ1bm5hYmxlX2F2ZyBtYXkg
bm90IGV2ZW4gcmVmbGVjdCB0cnVlIGNvbnRlbnRpb246DQo+Pg0KPj4gV2hlbiB0YXNrcyBhcmUg
ZGVwZW5kZW50LCB0aGUgYm90dGxlbmVjayBpcyBvZnRlbiB0aGUgZGF0YSBmbG93IGJldHdlZW4N
Cj4+IHRhc2tzLCBub3QgdGhlIGNvbnRlbnRpb24gc2VlbiBieSBydW5uYWJsZV9hdmcuIEJvb3N0
aW5nIGZyZXF1ZW5jeSB3aXRoDQo+PiBydW5uYWJsZSBpbiBzdWNoIHNjZW5hcmlvcyB3YXN0ZXMg
cG93ZXIgd2l0aG91dCBwZXJmb3JtYW5jZSBiZW5lZml0cy4NCj4+DQo+PiBXZSBmb3VuZCAxIGhh
cyBtaW5vciBwb3dlciByZWdyZXNzaW9uIGJ1dCAyIGFuZCAzIHJlZ3Jlc3NlcyBwb3dlcg0KPj4g
c2lnbmlmaWNhbnRseS4gV2UgaGF2ZSBzZWVuIG11bHRpcGxlIGFwcGxpY2F0aW9ucyB3aXRoIHRo
ZQ0KPj4gcHJvZHVjZXItY29uc3VtZXIgbW9kZWwgd2l0aCBtYW55IHdvcmtlciB0aHJlYWRzIHN1
ZmZlci4gV2hlbiB0aGVyZSBpcw0KPj4gSVBDIGJldHdlZW4gcHJvZHVjZXIgYW5kIGNvbnN1bWVy
LCBib29zdGluZyBmcmVxdWVuY3kgYmxpbmRseSBkb2VzIG5vdA0KPj4gaGVscCBwZXJmb3JtYW5j
ZSBhdCBhbGwgaWYgY29uc3VtZXIgaXMgbGltaXRlZCBieSBob3cgbXVjaCBkYXRhIGlzIGZsb3du
DQo+PiB0aHJvdWdoLiBZb3V0dWJlIHN1ZmZlciBmcm9tIDEsIDIgYW5kIDMgYXQgdGhlIHNhbWUg
dGltZSwgbGVhZGluZyB0byBhDQo+PiB0b3RhbCBTb0MgcG93ZXIgcmVncmVzc2lvbiBvZiAyMCUg
c2hvd24gaW4gdGhlIHJlc3VsdHMgYWJvdmUuDQo+IA0KPiBXZSBkaWQgZGlzY3VzcyByZW1vdmlu
ZyBydW5uYWJsZSBib29zdCBpbnRlcm5hbGx5IGFzIHdlbGwsIGJ1dCBJ4oCZZCBsb3ZlIHRvIHNl
ZQ0KPiBtb3JlIGRhdGEgdG9vLg0KPiBUaGUgb3JpZ2luYWwgaXNzdWUgaXQgd2FzIHRyeWluZyB0
byBzb2x2ZSB3YXMgYXZvaWRpbmcgamFuayBmcmFtZXMgZHVyaW5nIGxvYWQNCj4gc3Bpa2VzLCB3
aGljaCBZb3VUdWJlIGRvZXMgbm90IHJlYWxseSBleGVyY2lzZS4gU29tZSBnYW1pbmcgd29ya2xv
YWQgZGF0YSB3b3VsZA0KPiB0aGVyZWZvcmUgYmUgYSB1c2VmdWwgYWRkaXRpb24gaGVyZS4NCg0K
U29tZSBnYW1pbmcgbnVtYmVycyBvbiBzb21lIHBvcHVsYXIgbW9iaWxlIGdhbWVzIHBsYXllZCBi
eSBvdXIgDQpjdXN0b21lcnMuIFN0aWxsIG9uIERpbWVuc2l0eSA4NDAwIGxpa2UgYWxsIHRoZSBu
dW1iZXJzIGJlZm9yZS4gc2RldiANCnN0YW5kcyBmb3Igc3RhbmRhcmQgZGV2aWF0aW9uLg0KDQpN
b2JpbGUgTGVnZW5kcw0KICAgICAgICAgICAgICAgICBGUFMgICBzZGV2ICAgdG90YWwgcG93ZXIg
IGRpZmYNCncvbyBib29zdCAgICAgMTIwLjA3ICAwLjU2ICAgMjk5Ni4wOW1XDQp3LyAgYm9vc3Qg
ICAgIDEyMC4xNiAgMC40NyAgIDMyOTQuMTBtVyAgKzkuOTUlDQoNCkdlbnNoaW4gSW1wYWN0ICht
ZWRpdW0gcXVhbGl0eSkNCiAgICAgICAgICAgICAgICAgRlBTICAgc2RldiAgIHRvdGFsIHBvd2Vy
ICBkaWZmDQp3L28gYm9vc3QgICAgICA2MC4wMyAgMC4zNSAgIDU2OTUuNDZtVw0Kdy8gIGJvb3N0
ICAgICAgNjAuMDUgIDAuMzQgICA2MjE1Ljg0bVcgICs5LjE0JQ0KDQpHZW5zaGluIEltcGFjdCAo
aGlnaCBxdWFsaXR5KQ0KICAgICAgICAgICAgICAgICBGUFMgICBzZGV2ICB0b3RhbCBwb3dlciAg
ZGlmZg0Kdy9vIGJvb3N0ICAgICAgNjAuMDYgIDAuMjcgICA2MzU2LjQzbVcNCncvICBib29zdCAg
ICAgIDYwLjA4ICAwLjI3ICAgNjY3Mi43N21XICArNC45OCUNCg0KTG9va3MgbGlrZSBpbiB0aGVz
ZSBnYW1lcyB0aGUgYm9vc3QgZmVhdHVyZSBpc24ndCBtdWNoIHVzZWZ1bC4gVGhlIA0KYXZlcmFn
ZSBGUFMgaXMgcm91Z2hseSB0aGUgc2FtZSBhbmQgZXZlbiB0aGUgc3RhbmRhcmQgZGV2aWF0aW9u
IGRvZXNuJ3QgDQpjaGFuZ2UgbXVjaC4gVGhlc2UgbnVtYmVycyBhcmUgdG90YWwgcGhvbmUgcG93
ZXIsIHNvIGlmIHlvdSBjb3VudCBvbmx5IA0KdGhlIFNvQyB0aGUgcG93ZXIgaW5jcmVhc2Ugd2ls
bCBiZSBtdWNoIGhpZ2hlciB0aGFuIDEwJS4gUHJvYmxlbSBpcyB0aGF0IA0KdGhlc2UgZ2FtZXMg
YXJlIGNhcGFibGUgdG8gcnVuIGFib3ZlIHRoZSBGUFMgbGltaXQsIHNvIGJvb3N0aW5nIHdvbid0
IA0KaGVscCBhdCBhbGwuDQoNClNvIGZhciBJIGZhaWwgdG8gZmluZCBjb25jcmV0ZSByZWFsLXdv
cmxkIHdvcmtsb2FkcyB0aGF0IHNob3cgbm90aWNlYWJsZSANCmJlbmVmaXQgZnJvbSBib29zdGlu
Zy4gRG8geW91IGhhdmUgYW55dGhpbmcgSSBjYW4gcnVuIGFuZCBzZWU/DQoNCj4gWy4uLl0NCg==
