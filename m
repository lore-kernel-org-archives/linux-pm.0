Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90403B19A5;
	Thu,  4 Jun 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556037; cv=fail; b=CjYUdHoIonnyAGrlTRnlb309gTyrcKDI5xTDx/H4iy8tNDr+u6XzB7p+AkEkU+pZWlBuQ+cPQQpaA6ZEdt8OWGVWeTP0PXQoUsLrZJ6HF3iSzZ6BXGCyetUaeMiiRCdDjOcHWa/cC4zX8dvlIVyj/HsyHWXG9tz5VheXpoKLHq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556037; c=relaxed/simple;
	bh=hD4e30JJ6gY9ORcdHqehOg3mZ4BGOtUAOKJGlVejtoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckZSaqp8rSBYzvNNVMpfrwuWqhmcwnQf29trDuOoIh3NDWlGA+KwDxbvy7wliv+8vuS5nsj+cU/R/27BKSFki4PQFostl/6zbnBXDM47RnOY83pIYvmxLRqOLNwcDEv2QB5T5uKrE80Q5n+1RapQAZPHy7N9moQlatDc810J3HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Ocm9Vou+; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Ocm9Vou+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgPRcNZEuBx6APJ2D4+1RMxVnAcBkZ2p67Kiz+GjC7lDZySKWXIwmM5qW7eMhxol7czyxxIoMlbod67aemzKrDuKXpxLJAFrJRTTCW3mYT5y7JT6YMQQw1AY1Nh89fRCfz4RPKk6tu9+b+/30iBl8Olb1Bs6iIftLGxlyGir9SlXM2mie8rsQxyxrgc/hP3uGmXBW2Us4H368rCC2uIZp2a9HEoCtQNMQWJiod6E9PG95Armb+2LpgCuWa87YC1RwlRWwDTqxXvTiIwVVJXt5ocIwL3AqSLKb1LroOgldkoAMD7JsSPxPwB1P4m3jaPdsgqig36YyJHJuRxQNZ8kwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD4e30JJ6gY9ORcdHqehOg3mZ4BGOtUAOKJGlVejtoc=;
 b=mpwgUC6u7gvEjw6mqFE4PTEbLpYiIxu3axdDPcrHFY0Uo42+nc6HiH2zZ3dNStP9Rdbc3pkM0+kM3XFQ2GFnhx8S93U7rt/50ZzNF7kef3uPvUHA0mI/P3PxcuozuZXqu2eQ2cVKfdoYzUE1Lj6xc2zI30Ev547rsTiM0oP5jZjD7bZfcFl/rxBp1lgXgiUWiRhwmyXIoMVuNp9v/HLqgQkbwRjD5e/1DzFARDkZgmBeTn5PSVMIu2O24Pbg+RAhekbkGruVO6JjvwK3iiSiD50PQA9WrhjRpHfkjVrC6/dWy+Pj0W2DLm1P7Jyf3sS7TQ3EQcJazrT67LLkTVJnuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD4e30JJ6gY9ORcdHqehOg3mZ4BGOtUAOKJGlVejtoc=;
 b=Ocm9Vou+NvHDOKiTZ3yHHTggqn5NyYHOJLE0R2J0rA2rzA/p0XFFKfCZnIesyVBnrOjEALffQqoaY6o16X2aGqSmqJ+adfcTji0KyKn5VDmjVipV30IUKOwxTOhpbJSw8dfpxkdpko1+0rMRDQ0p3skW4LMY7rPEkeuqIPnjpuA=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEZPR04MB7853.apcprd04.prod.outlook.com
 (2603:1096:101:237::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:53:53 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:53:53 +0000
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
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYgmfuAgA123gA=
Date: Thu, 4 Jun 2026 06:53:53 +0000
Message-ID: <09f99c13-fc2b-4fae-bfd6-dce3d589a6b8@transsion.com>
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
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEZPR04MB7853:EE_
x-ms-office365-filtering-correlation-id: 78092a28-ca52-48bd-7173-08dec2060a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 nnZmuF7PprSm9LYgymwFs4crLNHGwmgrjz7OWZ7TdL+Ovj+Lo9bvbF0NGtpPRsY9BG0VIMdW0qX2a+SiD3ElRWzpJ8m1OoPpbOy7MkC5Mw0lACBF11tPp4vteU1q2COaBw+zfz8BTRZs0FN977ZwCn2fk0roiJcbZcj9e4pDcqg8O7sytafXY5hpLoE66fMW8qjdGJ6Vg2cA/rRGmfu3nGv17Y2Fxo9L9j5k5LO1ZSJ+ta3cgdDhDJiRlhyIcrvFa2GU7G45wP7QkMSNJ5FVgVzfSXb7jyBHWtxv5ixmJ1S7zpi2ZPs1JidZrYPuKGVa3Rznow/fmQ5JseO9qFzU2Rj7uOTX4YoNZqRmlcuLr6xg6XIMJ8SdhPQ8YpoR2Qfqv78gI652J06RvA9N+/YobsL0lBB5WFWLLJpshCSNJEwUiLvRxr8XzTHKGLRZ7kO1Swf+bCZBqW+H/fMa5FWsiFlKHzuWte/Oqb16TE54dztoXH2pF//9cYwr40jfvm4aPrU0KUPM/InNWhfyRlq8Lq2IZrLuJoVlFPEEip0A+X0yFoakPdg69gDTITqXmFaIjAG3dHmprRODTvkt/9lV4tNNi0uxnHGApDJOjuKANzCOyndHoS2pyt2MZ6vpbdr3vFGXhI9z9Qc3p76HyWKGUbRQz9qkcF5mYrVya8rG+y0mEl0sGRpWfqS9ER/8e71w5+4M0Aoi/5nL0UkJPl8yamQ+0lrQYIyk7MCCtXJpmPYyyVnnUkiD1I50sbmy96t42IpR2Z0/b5vvi179+eLsQg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTVydGgyT2lpd2pTZk5NRUhyRSs2dmdvbVBYYlNkYU1SR2dCMytoSEdCT0NG?=
 =?utf-8?B?blkzQ1FoV0JiVUhBK2RYd0NnZUR5WisrNkQ4MXhhOXM0QXBBNUsxcHFrckUv?=
 =?utf-8?B?TGo4bjZ1Z09HTGFaNG1kK2lOSDlaclUzbG5xRHdqNjU3V2J3UUFvbkNnVW5R?=
 =?utf-8?B?b0RKWUhSN3NQek5OYitjTXBOTFB3TjBaUmh2WEkxRzVrKy9DTjd1TlcxMmFR?=
 =?utf-8?B?dVZHWTJyZ3FWNVZzQ3ZsYWZIRjNBcEVDbzIwRGw2a0RCdmFuVXk1dVhkSXFv?=
 =?utf-8?B?amhENGZSaEF6WjhrMXB3eEJpMUV2R05iU1EzY2tacE0vb3NHNk0wZElleDdy?=
 =?utf-8?B?K2hUOVM0L3ZNWU5oZXU2QkV1Z2tkTUdyVlBRWjBJd2ZGWlVrUnVab3Q4ZUV0?=
 =?utf-8?B?b3BwL3NCWDcvTyt3ZzFRUkNpempMNjB4dUhsNEhJV2Urd3pBZEhxQklFai9Z?=
 =?utf-8?B?RnJteHZGc0tPR0xpSWxUNVMxY3NuYjNhMDlEejRVNThkcys0ekVEQXY3dTN1?=
 =?utf-8?B?RXdHZXJDd0NZUmNNNEhRUFp4ZUtjbThicUVtQnB4bjI3NDRmSzdxMHlMQjVG?=
 =?utf-8?B?YVcyMTl5OTNUQlZhb2JMckhNNDRNVGkzQ0I3MWQyaXVCNCtBbXFTZGh3REJh?=
 =?utf-8?B?M0RycE9tQS9hVmd6SE85SWFVbUdEYmVSenNJeVhwcitzcU1KSlU5RzN6ak55?=
 =?utf-8?B?ajVkTm5rWmN3NVdEMXRYUDc4RDl6YzRZRC9hUnQ5SVpWOXhwc0x0WG5NUXV5?=
 =?utf-8?B?bkg3SUJQNnFkc3BDZEwrVXlBNDduSHlrY3FMMTUvT05HSXZuQ1JIZWpaQnV5?=
 =?utf-8?B?ZVZscEFOU1V5Q2MwN1h5RWhMdE5jY2VmdTlZSjhGOWxNMlRUZ29wV0Urd2pz?=
 =?utf-8?B?L2RDZU5HSUNibzJCTDdLNXg4OXlpMUVmajJxQ2dmcTlxRnFuRVFVMnV0WEVH?=
 =?utf-8?B?ZXM4K1VIWDY3STNZVnZEZ3ZvaWIwODdwWUw3dUh0V0pHcXd6cnV0RzNxMmRl?=
 =?utf-8?B?eVY4Y0RIeXQ3UHZ6SjhCOXBkNDczeDhiWFFha1Bock14RldseFYvcTYzVW1a?=
 =?utf-8?B?cGtLWGRiaFAxWjJVbCtqN21SUU1lK1VYRWx1NHhYOWgwcmdTSVB6L1ZIZExN?=
 =?utf-8?B?MUdXNitEcE1aTHU0UHg0YVcwOUhlazQ2YitFbE1XNkgzL2FaR2RjeGVxYXZz?=
 =?utf-8?B?RFdJMCsyWHhneURsb3l2cXJrQytpWE5YU09oTnoyWkJsZ25iUmcxSENoR3A5?=
 =?utf-8?B?R1RPMUZUSzdGeENjZzdQdFZWSTl1Q2phZ0JLYWhiRTVEUWlmdTRaREhyaTB4?=
 =?utf-8?B?ZjdpdTNVMUlWdjZwb0N3MlpsUS9OZ2Q4SjgyT2JVNzJIdVVHbHpkT0lpdDFq?=
 =?utf-8?B?Qk1xMHBLR1RUaWo4NHQzeVFiTmVVaHFvVUcwSTdJSDVpa3E0VWdVMDlWWk44?=
 =?utf-8?B?ZzJabFNqcjZkK05HUllOWlB0WmdVbU0vOG5hYWZJMkFFOW1qS3YyRVVNNmFn?=
 =?utf-8?B?SnhRTUp3ZVVUSFhiYjRUYWJqanBpNStORUVOM29ROGJTNzFucnV3MUVqaTI0?=
 =?utf-8?B?SFBaTThpODQrUXhTcFRoajEzSkRUTmI4QmxmMmtmUjdwT0huU3pibnN1YjhV?=
 =?utf-8?B?a0VQTXlqL0JweUVyaUM0OE9LSHVnaytiZ3NrR2IxMU53aFVwbDJoWUREaFYz?=
 =?utf-8?B?eHdwWjYwUDlGOGZHbnJ1MUppM1V2SXlJQXZpM3EyZEt5YzhrekNHSkNMNmNV?=
 =?utf-8?B?aUZpdU1TVXV6UnV3Q21QZHM2VHhlQ1VkOS9yc05ySUxwU2NpTE1LTHMvUFNM?=
 =?utf-8?B?Sy8vWWJjSjcrQ2wzazZyNklJZVYvZE9GcVhyS1NKMXN1bCsxaWNaTm1VQU5x?=
 =?utf-8?B?dm1hMFFXQTBUeElaUFB4OWVEMGRrWFllRVl4U2xqVlRoSUxWMUtpSTZiY0Ez?=
 =?utf-8?B?cCs2QXhKa0lFMTk0SjZFUGwxQWZMRFFvMkd0RjRFZk15N2JmMVZPeTZMY0ll?=
 =?utf-8?B?b2oxU29pNGg5RWNZbEVvaUdhZEUvYTM3M3lZeEFEMkg0UHBxWlBtUjhyWmdv?=
 =?utf-8?B?UFRhSXBveDRsWlJ4Nm16aG1zUGNhdlVVSEJtQ3BXM3RMamFMc2wxWDhzaGlX?=
 =?utf-8?B?YlBmdERrVlJaTzViY0NUN2pqM3VLYnBzTE5jYlN5Ym1MZnQvZVROOW5xc043?=
 =?utf-8?B?K0Njd0ZKcmEraWwvWGpVbTdEaXZVM2hxNWhsUWtPcUpNRDFRRXJRL3BUMUg4?=
 =?utf-8?B?VG8rWUs3ZHVBZU8rcmdQWWphUWR5R3VnZUpBcXRnYk9XbW1ySU83dXdyZEZl?=
 =?utf-8?B?bnBTZlRCU3o5eFFMNXMveEdjTnhKTkpUcVpsNy8vUlZ4bFExeUExRkxLRUVr?=
 =?utf-8?Q?oEZQLVnJFWDxrU/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D990AA1F1AEC409C4BE44C6856F02A@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 78092a28-ca52-48bd-7173-08dec2060a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 06:53:53.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juYZ60sGxT4dFWCh8LBdMWkCURjncM4HjIPSpwmmliZA3xgHnIsqbY0EPHUmUJtF/NDLbJJZwbMQ/kFYisLcZWRunfUF0ri3Dr4fSfFZd28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7853

T24gNS8yNy8yMDI2IDE6MTYgQU0sIERpZXRtYXIgRWdnZW1hbm4gd3JvdGU6DQo+IFtTb21lIHBl
b3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBP
biAxOC4wNS4yNiAwNDo0MCwgaG9uZ3lhbi54aWEo5aSP5byY5b2mKSB3cm90ZToNCj4+IEZyb206
IEhvbmd5YW4gWGlhIDxob25neWFuLnhpYUB0cmFuc3Npb24uY29tPg0KPj4NCj4+IFdlIGhhdmUg
c2VlbiBhIG1hc3NpdmUgcG93ZXIgY29uc3VtcHRpb24gcmVncmVzc2lvbiAoMjAlIFNvQyBwb3dl
cg0KPj4gaW5jcmVhc2UgaW4gbWFueSBhcHBzKSBhZnRlciB1cGRhdGluZyBvdXIga2VybmVsLiBB
ZnRlciBiaXNlY3Rpb24gd2UNCj4+IHBpbnBvaW50ZWQgdGhlIHJlZ3Jlc3Npb24gdG8gdGhlIGNw
dV91dGlsKGJvb3N0KSBmZWF0dXJlLiBBZnRlcg0KPj4gcmV2ZXJ0aW5nIHRoZSBib29zdCBmZWF0
dXJlIHRoZSBtYXNzaXZlIGVuZXJneSByZWdyZXNzaW9uIGlzIGdvbmUuDQo+PiBEZXRhaWxlZCB0
cmFjZSBhbmFseXNpcyBkb3duIGJlbG93LiBUaGUgcmVncmVzc2lvbiBpcyBmb3VuZCBhY3Jvc3Mg
cXVpdGUNCj4+IG1hbnkgYXBwcyBidXQgWW91dHViZSBpcyBvbmUgb2YgdGhlIHdvcnN0IG9mZmVu
ZGVycywgc2hvd24gaW4gdGhlDQo+PiAxMDgwcDYwZnBzIHZpZGVvIGJlbmNobWFyazoNCj4+DQo+
PiAgIFNldHVwICAgICAgRlBTICAgU29DIFBvd2VyIChtVykgIGRpZmYNCj4+IHcvICBib29zdCAg
NTkuOTQgICAgICA5MTMuNg0KPj4gdy9vIGJvb3N0ICA1OS45MyAgICAgIDcyMC40ICAgICAtMjEu
MTUlDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSG9uZ3lhbiBYaWEgPGhvbmd5YW4ueGlhQHRyYW5z
c2lvbi5jb20+DQo+IA0KPiBMb29rcyBsaWtlIEkgbWlzc2VkIHJ1bm5pbmcgb25lIG9mIHRoZSBs
b3ctcG93ZXIgdGVzdCBjYXNlcyBiYWNrIHRoZW4uDQo+IA0KPiBUaGF0IHNhaWQsIGJvb3N0aW5n
IHRhc2tzIHVuZGVyIGNvbnRlbnRpb24gZG9lcyBub3Qgc2VlbSBsaWtlIGENCj4gcGFydGljdWxh
cmx5IGdvb2QgaWRlYS4NCj4gDQo+IEphbmtiZW5jaCwgYmVpbmcgcHJpbWFyaWx5IGEgVUkgcmVu
ZGVyaW5nIGJlbmNobWFyaywgd2FzIHByb2JhYmx5DQo+IG92ZXJlbXBoYXNpemluZyBzdHJlc3Mg
b24gdGhlIEFuZHJvaWQgR3JhcGhpY3MgUGlwZWxpbmUgKEFHUCksIHdoZXJlIHRoZQ0KPiBydW5u
YWJsZV9hdmcgYm9vc3RpbmcgaGFwcGVuZWQgdG8gaGVscC4gU3VwcG9ydCBmb3IgSmFua2JlbmNo
IGFsc28NCj4gYXBwZWFycyB0byBoYXZlIHN0b3BwZWQgd2l0aCBBbmRyb2lkIDEyIOKAlCBJIGFt
IG5vdCBzdXJlIHdoeS4NCj4gDQo+IEF0IHRoZSBzYW1lIHRpbWUsIGxvdy1wb3dlciBiZW5jaG1h
cmtzLCBhbmQgZXZlbiBnYW1lcywgZG8gbm90IHNlZW0gdG8NCj4gaGF2ZSBlcXVhbGx5IHN0cmlj
dCByZXF1aXJlbWVudHMgZm9yIGNvbnNpc3RlbnRseSBtZWV0aW5nIFVJIHJlbmRlcmluZw0KPiBk
ZWFkbGluZXMuDQo+IA0KPiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRoYXQgdGhlIEFHUCBpdHNlbGYg
aGFzIGV2b2x2ZWQgc2luY2UgdGhlbi4gSQ0KPiB2YWd1ZWx5IHJlbWVtYmVyIGEgR29vZ2xlIEJv
b3RjYW1wIHByZXNlbnRhdGlvbiBkaXNjdXNzaW5nIHRoZSBpbmplY3Rpb24NCj4gb2YgcGVyZm9y
bWFuY2UgaGludHMgYXQgdGhlIGJlZ2lubmluZyBvZiBhIGZyYW1lLXJlbmRlcmluZyBjeWNsZSB0
bw0KPiBtaXRpZ2F0ZSBlYXJseSBqYW5rLCBidXQgSSBjYW4gbm8gbG9uZ2VyIGZpbmQgaXQuIEkg
YWxzbyBkbyBub3Qga25vdyBob3cNCj4gdGhhdCBhcHByb2FjaCByZWxhdGVzIHRvIHRoZSByZW1v
dmFsIG9mIGFsbCB2ZW5kb3IgaG9va3MuDQo+IA0KPiBHaXZlbiBhbGwgb2YgdGhpcywgSSB3b3Vs
ZCBhbHNvIGxlYW4gdG93YXJkIHJlbW92aW5nIHRoZSBydW5uYWJsZV9hdmcNCj4gYm9vc3Rpbmcg
ZnVuY3Rpb25hbGl0eSBlbnRpcmVseSwgcmF0aGVyIHRoYW4ga2VlcGluZyBpdCBiZWhpbmQgYSBz
Y2hlZA0KPiBmZWF0dXJlIGZsYWcgdGhhdCBkZWZhdWx0cyB0byBmYWxzZS4NCg0KSWYgc28sIGRv
IHlvdSB0aGluayB5b3UgY2FuIGdpdmUgYW4gUi1iIG9uIHYyPyBJJ3ZlIHVwZGF0ZWQgdGhlIGNv
bW1lbnRzIA0KYW5kIGluY2x1ZGVkIG1vcmUgZGF0YSBvbiBnYW1pbmcgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjgwMjM2MTEuMjQz
My0xLWhvbmd5YW4ueGlhQHRyYW5zc2lvbi5jb20vDQoNCkkgYWxzbyBsZWFuIHRvd2FyZHMgcmV2
ZXJ0aW5nIGl0LiBUaGluZ3MgaGF2ZSBjaGFuZ2VkIGEgbG90IGFuZCBpZiB3ZSANCnN0aWxsIHdh
bnQgc29tZSBzb3J0IG9mIGJvb3N0aW5nIHdlIG1pZ2h0IHdhbnQgdG8gY29tZSB1cCB3aXRoIHNv
bWV0aGluZyANCmVsc2UuDQoNCj4+IEBAIC04MjI5LDE2ICs4MjIyLDEwIEBAIHN0YXRpYyBpbnQg
c2VsZWN0X2lkbGVfc2libGluZyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwcmV2LCBpbnQg
dGFyZ2V0KQ0KPj4gICAgKiBSZXR1cm46IChCb29zdGVkKSAoZXN0aW1hdGVkKSB1dGlsaXphdGlv
biBmb3IgdGhlIHNwZWNpZmllZCBDUFUuDQo+IA0KPiBzLyhCb29zdGVkKSAoZS8oRS8NCj4gDQo+
PiAgICAqLw0KPj4gICBzdGF0aWMgdW5zaWduZWQgbG9uZw0KPj4gLWNwdV91dGlsKGludCBjcHUs
IHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IGRzdF9jcHUsIGludCBib29zdCkNCj4+ICtjcHVf
dXRpbChpbnQgY3B1LCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBkc3RfY3B1KQ0KPj4gICB7
DQo+PiAgICAgICAgc3RydWN0IGNmc19ycSAqY2ZzX3JxID0gJmNwdV9ycShjcHUpLT5jZnM7DQo+
PiAgICAgICAgdW5zaWduZWQgbG9uZyB1dGlsID0gUkVBRF9PTkNFKGNmc19ycS0+YXZnLnV0aWxf
YXZnKTsNCj4+IC0gICAgIHVuc2lnbmVkIGxvbmcgcnVubmFibGU7DQo+PiAtDQo+PiAtICAgICBp
ZiAoYm9vc3QpIHsNCj4+IC0gICAgICAgICAgICAgcnVubmFibGUgPSBSRUFEX09OQ0UoY2ZzX3Jx
LT5hdmcucnVubmFibGVfYXZnKTsNCj4+IC0gICAgICAgICAgICAgdXRpbCA9IG1heCh1dGlsLCBy
dW5uYWJsZSk7DQo+PiAtICAgICB9DQo+Pg0KPj4gICAgICAgIC8qDQo+PiAgICAgICAgICogSWYg
QGRzdF9jcHUgaXMgLTEgb3IgQHAgbWlncmF0ZXMgZnJvbSBAY3B1IHRvIEBkc3RfY3B1IHJlbW92
ZSBpdHMNCg0K
