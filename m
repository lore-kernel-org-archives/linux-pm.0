Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022108.outbound.protection.outlook.com [40.107.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A09379EF6;
	Mon, 18 May 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104254; cv=fail; b=sztEIOOh/wn5k7/RXaGMXCyjS9jmFHRbiCY5Ulh5MORPh65BzcuPkgBjq7H1YUCgXo5O3z9ZCQM4e2jLNeyGnY5N+aJGE5vkrnQ+28sB88rsHRdjOAzOZJAEeSy72dEuv2AsFqwqbIw+8CLHnw7PhcM/lOCCZJEZrwvd9ccl8Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104254; c=relaxed/simple;
	bh=t/5/QJAEdnodXKaAyQX2xZKG1U4P+pMcmXVJoFePmBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZ1fZofq0u33r4By5kcIGIh51x7YkgEwfX2lsqV27rLxgXGahy9IPcu+usqqskzrauYna9NmCPKj6T03IHLIq11rk8SLi0Po+aj6T05PFf2McBtOszZc6/qQ+FvASISsMBod9RRyhW/HyC3UEXpAaA9/ONoV35Yp1JEPgFoirh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=o/le6xY+; arc=fail smtp.client-ip=40.107.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="o/le6xY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4cRube1lje+L5jwx5jQfeuLyt4GIbnLsGkQHlSDrYi938X58W4l2uoi8jUC3hM0hD9OmpMnwxtxCBB15A0O6HWDk7RO8hUY91DMnbPHUXmm2exYEGVCJkzuXkRquYI6GV214tb9hd4xg044EZ5WDAOOnsPhJUCt1JuEeOfIzOrwTa2PD8IpyCgyOhcLOzq7ordUG+IJhUDZtVNQMqYtfpSCEdrVcLgaiQ/CGb9/l1C93iBKEWRBjTtTtvSMr0pAURU1Epgtd5JwKwiQ9nopCgrJHOMuOxkDBVzsz2OIt+23B5deR1tb2hehrmmnAd4JOTFgcTs+HHiKXzhdYxApOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/5/QJAEdnodXKaAyQX2xZKG1U4P+pMcmXVJoFePmBI=;
 b=DBfgWyLP0Vb3v+aXIaBFRhKcUtfi6PQWirn8DVQYPUNIgRjLgmTJ7bipcNvBupBgc0rB9/HVKBS/dgZ5FuYY8Ryk1Hmn8SSkIGm7I/qZIgXApVabFtJyYzisj1hXYRhliHsJ17eCTh7eeuhA5HGwWf2arbsCtOnp9Xwcw1/zfMGcb9osnypg23BtQrt0ymhbpYse5Ynd0PRr3e5rzgpfVCeC7VeJ9iASpO4bOnXCvdH8sE1m7gjxCjCtAkBaOMbuL5gVtjceYxLFHZF9BJsPQ2zt/jhXfE9ohiB1bPTf2MHlMPnzIsvejVuezKwiNSXyLyj25SgvTv7ghHasgqsCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/5/QJAEdnodXKaAyQX2xZKG1U4P+pMcmXVJoFePmBI=;
 b=o/le6xY+TAmS7ChHtdFmY4M5zqQIDvFXyuxfCwlRXr52GpWGrWJTnB/7ktgxCoTKxhhw49Aow9AB/ssuLzgUZW2nr4D7Fhp5bMc5FRkShMQYcd8Ikh6Me3kZJHVm4wLmOrr+m05GjXrcxyj3Ly2umsjWZah04cbrXYKRtk9Ue+k=
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 (2603:1096:820:c7::13) by SEZPR04MB6454.apcprd04.prod.outlook.com
 (2603:1096:101:a9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 11:37:25 +0000
Received: from KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3]) by KL1PR0401MB6196.apcprd04.prod.outlook.com
 ([fe80::f2ee:1e28:9022:99f3%4]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 11:37:25 +0000
From: =?utf-8?B?aG9uZ3lhbi54aWEo5aSP5byY5b2mKQ==?= <hongyan.xia@transsion.com>
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: =?utf-8?B?aHVwdSjog6Hnkp4p?= <hupu@transsion.com>,
	=?utf-8?B?amlhemkubGko5p2O55Sy5a2QKQ==?= <jiazi.li@transsion.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qais Yousef
	<qyousef@layalina.io>
Subject: Re: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Topic: [PATCH] sched/fair: Revert boost in cpu_util()
Thread-Index: AQHc5m/BRW7AFLKU3EWFGb8vyxXv8LYTjqUAgAAZa4A=
Date: Mon, 18 May 2026 11:37:24 +0000
Message-ID: <b136fd7e-e062-48ce-a039-803cad969322@transsion.com>
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
x-ms-traffictypediagnostic: KL1PR0401MB6196:EE_|SEZPR04MB6454:EE_
x-ms-office365-filtering-correlation-id: df32e36c-06f7-4afc-b233-08deb4d1d51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021|11063799003|4143699003|4133799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 V44Q+0XGPjUZmcHD3EY06xLq0o8CxqyYcHIZkjziHCoHdoGJBoV/m0hsP69KkCXf9F/QSPjQjrVGUPKt5PueGn8JGXp9Z5QY3JB6N16hzvRPe+WRBBxm/YpWa/Aevl5nHqzZbeMt7eF8KDxFKvEmMqHvoVY+Hih5eTrrFhSwiwepCA5eAq0GfiEnjbmNB2sKq7mLXpWWo3QhgRi6Qnof6MCPPS6zA75p7uRN+PzmOeOJo2Y6vO5Qx0IVLhGQByfiw7SRs3ct/uED/xX+BalezGvMQn7girD0C0vpvM1nSTbZYW9lnqYHuVT43GbXKZHMVqrbEpb8uELZ1VmX1b/tkteDWjQ4VGngb+agVsvT832pPMP0GJpHlXG4lAG2UNaEvGtXUrPo9nAgtJtvgqVI9pXSGh9u69m/w6C0ABiMMMyj3iJJ97BS/qnX2GqkwonlWiUZZgmBfY/KjmeHVb2V1H2WFSstnQZyUUAE7xDYxnLKbAShzoi7JV7SYnJaHVbSqQ1qguGILci84dxeouhZPcb6ibP9o5qF/yE4XNZxg1OGmns3AHHWMjL8h8KehorB1QC9xWld8K0ZRV6LzSsvbA311ebdapFuTIdjSpptAae7+EU1RcTiVmCsLTwuXSBwE+jVXw2kSSTBMn51qzHRIpUlY7GhdbkCdVlDqYQi7mLqOetQxMH2OXf1hYZIBz6STP4AeztGI5w03OseIG3xuLg5V7po+e/p+bq/G5jmoSqiizBDN7AOsiCmlDF9QjY6UAq2cUUedBeCQ5aumYxSfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0401MB6196.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(11063799003)(4143699003)(4133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnV4MS91cERidE1oNWt2ZHNldW5OY2JSeG5oc3hRUDZoSzBOZUlmZ2ZXdTZT?=
 =?utf-8?B?Q1UrekdNZFNKdXY2ek1IQXMvVFczQnZEajlhOGtnVFk0SnAvQ1lPc1lQcml4?=
 =?utf-8?B?b2FhVS9rQlBSVHNxbXM1Wk12Mm5STlMvSDBhS0FBd1hDdyt4UEJlWVRTQTBR?=
 =?utf-8?B?K1ZIQmFwVkRSQVdLcjZhWElQT2laNFBFSHlmTTd5WFNCUmV1bG95RWtpdklH?=
 =?utf-8?B?MnlTNUJIdXBWdDluZEtjeDZUUHM5L1lZN0IwNmMvK01IRHA0bEdkOG1CMGFK?=
 =?utf-8?B?NG1VZU1iRXVvZDU4TjNZZ1d3REJZZDQvSmMvSmlIQmJkWGZtdXcyS2lCK0Jt?=
 =?utf-8?B?enl2UGtZOGFrV1R4b3lHZGxJektBYmo3K2tSaCsrTjZ1WVY4b0lCWkNVM2hl?=
 =?utf-8?B?OUFQZUt6ZythcnRUYm1aSkZxTzhld3BiZ0NFR0RMSHBnNHQyOXBYMkRJaW9q?=
 =?utf-8?B?alpDTTFQREVLV09vU3dvQnhGSmVsS2ZkQUs0TWlsR2ROc2syYzVOdlhseTNn?=
 =?utf-8?B?R2xxM2ZoWlBvUGdUTis2MGp0Q2RkeE96bEpVcHVOUTJJK3k5UDJWWldDZDQ5?=
 =?utf-8?B?Q1RuOHB6TzZ3UDh2bkxFNEpYOHR1Z1JUOFkycnZQazg4UEdyVFJTR3Z2aE9h?=
 =?utf-8?B?MVdJRVZ6SVkzQWlUcHJXWXRTOUl1NWRleGFHZlMyQmdKUnFwWjRBeU9iOVBB?=
 =?utf-8?B?ZFhSVkRRcVgxdTVpc2d1UU51c29EUks3VU9yVHFTdlVvZldiaGZhYXM4b3d6?=
 =?utf-8?B?RGJIUlBqZWp4MkNyZE03aUNCbWdzQ3R4RkFjWlN1cHRMNUtieHVvVGN3T2o5?=
 =?utf-8?B?ODZDeFloZmttcjVFUUI2L05Rakg2UlZ6QW9WTlBlRkF2VnppRDltUVowR1RY?=
 =?utf-8?B?TU5rZEFZTS9SWkc5cDk5VnI0TmozTWE1dW1keGY4cUFwRUZJakxBb3g1alJL?=
 =?utf-8?B?Ky9RVlVwRnZiNVZ4QkJka1JoRzh3b20ybVJmaEZYVENIYi9ZandNSmhQU0ZH?=
 =?utf-8?B?akRSdHJGSFZiZ2k4bkhhR0FydFFIOUNHc0xlNjlTYk5DNXgzWFBDNmFZNW4w?=
 =?utf-8?B?LzdVKzJKWXI2T1hwcnZ5VmIxaGRhVTU2aUN1aG5vMTE2QmRXWFh6NWllNVpG?=
 =?utf-8?B?VFgzQnR2cUUwQ3R3b1ZLUmYyVC9TUzBwcnFjQlJPRDEyMzB6ZTYrNWQ0WXNi?=
 =?utf-8?B?dEV0NEg5eGN4OThqOExvdCsxSUtBZ0ZqYndDVlk5ZTVFdmN4QzJrcFJ6bk1t?=
 =?utf-8?B?ZkE1cDc0cmJvSnl5WkoyditvWHMyMTdEcVRlSWd6R2MwcE53dWZ3cWtZYis5?=
 =?utf-8?B?NEVVNnhQOUZrUmhuRDlDTnFReWxiNFJpbFUrYUJXQm5ZcUdKeVB0SFlEdytE?=
 =?utf-8?B?RzdvU1RrOFRQd3BUbXQrczNGRnVKNFlnUHJRdnp0YU9HYzEwNnlZYkkvL244?=
 =?utf-8?B?YWlFM1NYdVMxa09pWjZiMnpiTVI1cndXeGxUZXAvaEgza1p2ZlNSODZFb1dP?=
 =?utf-8?B?RXpiVVgyeWRNNzRPNCs2akxhMU5DbVFWaTAxTnhzOS92VFpVUUUzM05mcmFn?=
 =?utf-8?B?aWJuWnZEcnl2MGFQL1hJVVFJRHFRVmlmd1o4QU9tQVc5UG9TK25WaTNzSytC?=
 =?utf-8?B?eXNQMWV6aVQ4MWFXQTA2eFY3OFZ2NDYxOXRoSzhydFNydmZydkZxdkwrcy8y?=
 =?utf-8?B?SklWRnRDNlBLWkxZYXFURXBsTUhXZTN1YjdoWXMyMXFGZEY0eU9SNERZSVBz?=
 =?utf-8?B?NW9WL3NTQ0FTakVDUjVjVC9ZSXJjUTV1bTZ5TFpTbUZiQnBqaEM5dmpVb2Jx?=
 =?utf-8?B?dktUYlJsN0NRUWtIVzlTV1dycTkrSVc2dEYrYml4NGRHWWdZR0hRbDFwdUd6?=
 =?utf-8?B?eDNqcXd0MEpKRkx0ZlJHcXZVUXFWWmV3Y3NuNW1oWDd2VkZzSVc0aEYyd1dY?=
 =?utf-8?B?T2VMbmNybjU5UzZvV1M5YmxYdGE2NEdodU1mMExuZXZpZk1Ca2J3MVhPOE5Z?=
 =?utf-8?B?cjdlMFdFbEU3dE5rRnJXdDZ5N3lnRGtXQW82Njdrdk03YXVqaEJnWk5ucTE2?=
 =?utf-8?B?d1NKUFA5MTFsT09ya3YvcWhUU1NWNDU0OElzMkg2YWJRS05maENRL2FGMG5K?=
 =?utf-8?B?Y1pqQ3UxY3V2QWsrRllENUx0N0NGaWxEdk5QdHhMVGFxZWVhMjhkR0FUSGNx?=
 =?utf-8?B?aWx6ZW9LUHFNUCs5VEZTVlg4V2djMWpCQjMwUUxYM2FBbDIvNUlqNWR1VHdH?=
 =?utf-8?B?cnRTcFFJdDRSSjZuS3hPQmhMZVRQSkMyRjhMWmhBTHZ3c3lBa1NSVXUrWSth?=
 =?utf-8?B?eWR0SThQOVNHaGgvWDFDOVdZaFF3V0svcnNzQUh3ektlOXc0WUZWSnFFWExq?=
 =?utf-8?Q?yG+6WkPSbqGV0MDY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77BBE3EC7CB64544A8EEAEABEFD874F0@apcprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df32e36c-06f7-4afc-b233-08deb4d1d51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 11:37:24.9518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aqLRJd4quEIw3TZWDtl24kYa64U8pWr4GxGdBJ6MW4dwRrgAp/r6/bDajoGU4M59dvk4L7ESvST0vmAecGVhiLPOEzEDLBi4A89YT03aqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6454

T24gNS8xOC8yMDI2IDY6MDQgUE0sIENocmlzdGlhbiBMb2VobGUgd3JvdGU6DQo+IFtTb21lIHBl
b3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IGNocmlzdGlhbi5sb2VobGVAYXJtLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IE9u
IDUvMTgvMjYgMDM6NDAsIGhvbmd5YW4ueGlhKOWkj+W8mOW9pikgd3JvdGU6DQo+PiBGcm9tOiBI
b25neWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4+DQo+PiBXZSBoYXZlIHNl
ZW4gYSBtYXNzaXZlIHBvd2VyIGNvbnN1bXB0aW9uIHJlZ3Jlc3Npb24gKDIwJSBTb0MgcG93ZXIN
Cj4+IGluY3JlYXNlIGluIG1hbnkgYXBwcykgYWZ0ZXIgdXBkYXRpbmcgb3VyIGtlcm5lbC4gQWZ0
ZXIgYmlzZWN0aW9uIHdlDQo+PiBwaW5wb2ludGVkIHRoZSByZWdyZXNzaW9uIHRvIHRoZSBjcHVf
dXRpbChib29zdCkgZmVhdHVyZS4gQWZ0ZXINCj4+IHJldmVydGluZyB0aGUgYm9vc3QgZmVhdHVy
ZSB0aGUgbWFzc2l2ZSBlbmVyZ3kgcmVncmVzc2lvbiBpcyBnb25lLg0KPj4gRGV0YWlsZWQgdHJh
Y2UgYW5hbHlzaXMgZG93biBiZWxvdy4gVGhlIHJlZ3Jlc3Npb24gaXMgZm91bmQgYWNyb3NzIHF1
aXRlDQo+PiBtYW55IGFwcHMgYnV0IFlvdXR1YmUgaXMgb25lIG9mIHRoZSB3b3JzdCBvZmZlbmRl
cnMsIHNob3duIGluIHRoZQ0KPj4gMTA4MHA2MGZwcyB2aWRlbyBiZW5jaG1hcms6DQo+Pg0KPj4g
ICBTZXR1cCAgICAgIEZQUyAgIFNvQyBQb3dlciAobVcpICBkaWZmDQo+PiB3LyAgYm9vc3QgIDU5
Ljk0ICAgICAgOTEzLjYNCj4+IHcvbyBib29zdCAgNTkuOTMgICAgICA3MjAuNCAgICAgLTIxLjE1
JQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEhvbmd5YW4gWGlhIDxob25neWFuLnhpYUB0cmFuc3Np
b24uY29tPg0KPj4NCj4+IC0tLQ0KPj4gQW5hbHlzaXM6DQo+Pg0KPj4gV2UgZm91bmQgc2V2ZXJh
bCBwcm9ibGVtcyB0aGF0IHJlc3VsdCBpbiB0aGUgcG93ZXIgc3Bpa2U6DQo+Pg0KPj4gMS4gQXJp
dGhtZXRpYyBzaG91bGQgbm90IGhhcHBlbiBiZXR3ZWVuIHV0aWxfYXZnIGFuZCBydW5uYWJsZV9h
dmc6DQo+Pg0KPj4gQWZ0ZXIgdXRpbCA9IG1heCh1dGlsLCBydW5uYWJsZSkgd2hpY2ggcG90ZW50
aWFsbHkgcGlja3MgcnVubmFibGUgdmFsdWUNCj4+IGluIGNwdV91dGlsKCksIHdlIHRoZW4gYWRk
IG9yIHN1YnRyYWN0IHRhc2sgdXRpbCB2YWx1ZXMgZnJvbSBpdC4gVGhpcw0KPj4gcHJvZHVjZXMg
YSB2YWx1ZSB0aGF0IGlzIGhhbGYtcnVubmFibGUtaGFsZi11dGlsIHdoaWNoIGlzIGlsbC1kZWZp
bmVkLg0KPj4gVGhpcyBhbG9uZSBzaG91bGQgYmUgYSB3YXJuaW5nIHNpZ24uIFRoaXMgYnJlYWtz
IEVBUyBjYWxjdWxhdGlvbnMgaW4NCj4+IG1hbnkgY2FzZXMsIGxlYWRpbmcgdG8gc3ViLW9wdGlt
YWwgdGFzayBwbGFjZW1lbnRzLg0KPj4NCj4+IDIuIFVzaW5nIHRoZSBhYnNvbHV0ZSB2YWx1ZSBv
ZiBydW5uYWJsZV9hdmcgdG8gZHJpdmUgZnJlcXVlbmN5IGlzDQo+PiAgICAgdG9vIGhpZ2ggdG8g
YmUgcmVhc29uYWJsZToNCj4+DQo+PiBXZSB1c2UgcnVubmFibGUgaW4gYSBfcmVsYXRpdmVfIHdh
eSB0byB1dGlsIHRvIGtub3cgd2hldGhlciB0aGVyZSBpcw0KPj4gY29udGVudGlvbiBpbiBzZXZl
cmFsIHBsYWNlcy4gSG93ZXZlciwgdGhlIF9hYnNvbHV0ZV8gdmFsdWUgc2hvdWxkIG5vdA0KPj4g
YmUgdXNlZCBsaWtlIHV0aWwuIFJ1bm5hYmxlX2F2ZyB0ZW5kcyB0byBiZSBzaWduaWZpY2FudGx5
IGhpZ2hlciwNCj4+IG1ha2luZyBpdCBtdWNoIGVhc2llciB0byBzYXR1cmF0ZSBmcmVxdWVuY3ku
DQo+Pg0KPj4gRm9yIGV4YW1wbGUsIGlmIHRocmVlIHRhc2tzIGVhY2ggd2l0aCBhIHV0aWwgb2Yg
MTAwIGNvbnRlbmQgb24gdGhlIHNhbWUNCj4+IHJxLCB0aGUgcnEgdXRpbCBpcyAzMDAgYnV0IHJ1
bm5hYmxlX2F2ZyBzaG9vdHMgdXAgdG8gOTAwLiA5MDAgZHJpdmVzIHRoZQ0KPj4gQ1BVIGF0IHRo
ZSBtYXggZnJlcXVlbmN5LCBhbmQgaXQncyBoaWdobHkgcXVlc3Rpb25hYmxlIHdoZXRoZXIgdGhp
cw0KPj4gYm9vc3QgaXMgdGhlIHJpZ2h0IGRlY2lzaW9uLg0KPj4NCj4+IDMuIFJ1bm5hYmxlX2F2
ZyBtYXkgbm90IGV2ZW4gcmVmbGVjdCB0cnVlIGNvbnRlbnRpb246DQo+Pg0KPj4gV2hlbiB0YXNr
cyBhcmUgZGVwZW5kZW50LCB0aGUgYm90dGxlbmVjayBpcyBvZnRlbiB0aGUgZGF0YSBmbG93IGJl
dHdlZW4NCj4+IHRhc2tzLCBub3QgdGhlIGNvbnRlbnRpb24gc2VlbiBieSBydW5uYWJsZV9hdmcu
IEJvb3N0aW5nIGZyZXF1ZW5jeSB3aXRoDQo+PiBydW5uYWJsZSBpbiBzdWNoIHNjZW5hcmlvcyB3
YXN0ZXMgcG93ZXIgd2l0aG91dCBwZXJmb3JtYW5jZSBiZW5lZml0cy4NCj4+DQo+PiBXZSBmb3Vu
ZCAxIGhhcyBtaW5vciBwb3dlciByZWdyZXNzaW9uIGJ1dCAyIGFuZCAzIHJlZ3Jlc3NlcyBwb3dl
cg0KPj4gc2lnbmlmaWNhbnRseS4gV2UgaGF2ZSBzZWVuIG11bHRpcGxlIGFwcGxpY2F0aW9ucyB3
aXRoIHRoZQ0KPj4gcHJvZHVjZXItY29uc3VtZXIgbW9kZWwgd2l0aCBtYW55IHdvcmtlciB0aHJl
YWRzIHN1ZmZlci4gV2hlbiB0aGVyZSBpcw0KPj4gSVBDIGJldHdlZW4gcHJvZHVjZXIgYW5kIGNv
bnN1bWVyLCBib29zdGluZyBmcmVxdWVuY3kgYmxpbmRseSBkb2VzIG5vdA0KPj4gaGVscCBwZXJm
b3JtYW5jZSBhdCBhbGwgaWYgY29uc3VtZXIgaXMgbGltaXRlZCBieSBob3cgbXVjaCBkYXRhIGlz
IGZsb3duDQo+PiB0aHJvdWdoLiBZb3V0dWJlIHN1ZmZlciBmcm9tIDEsIDIgYW5kIDMgYXQgdGhl
IHNhbWUgdGltZSwgbGVhZGluZyB0byBhDQo+PiB0b3RhbCBTb0MgcG93ZXIgcmVncmVzc2lvbiBv
ZiAyMCUgc2hvd24gaW4gdGhlIHJlc3VsdHMgYWJvdmUuDQo+DQo+IFdlIGRpZCBkaXNjdXNzIHJl
bW92aW5nIHJ1bm5hYmxlIGJvb3N0IGludGVybmFsbHkgYXMgd2VsbCwgYnV0IEnigJlkIGxvdmUg
dG8gc2VlDQo+IG1vcmUgZGF0YSB0b28uDQo+IFRoZSBvcmlnaW5hbCBpc3N1ZSBpdCB3YXMgdHJ5
aW5nIHRvIHNvbHZlIHdhcyBhdm9pZGluZyBqYW5rIGZyYW1lcyBkdXJpbmcgbG9hZA0KPiBzcGlr
ZXMsIHdoaWNoIFlvdVR1YmUgZG9lcyBub3QgcmVhbGx5IGV4ZXJjaXNlLiBTb21lIGdhbWluZyB3
b3JrbG9hZCBkYXRhIHdvdWxkDQo+IHRoZXJlZm9yZSBiZSBhIHVzZWZ1bCBhZGRpdGlvbiBoZXJl
Lg0KDQpBbHRob3VnaCBJIHdvdWxkIGJlIGdsYWQgdG8gcHJvdmlkZSBtb3JlIGRhdGEgKGFmdGVy
IG1vcmUgYmVuY2htYXJrcyBhbmQNCnBlbmRpbmcgb3VyIGludGVybmFsIGFwcHJvdmFsKSwgSSB3
b25kZXIsIHdoYXQgbGV2ZWwgb2YgcGVyZm9ybWFuY2UgZ2Fpbg0KZG8gd2UgZXhwZWN0IGZyb20g
dGhpcyBmZWF0dXJlIHRvIGp1c3RpZnkgdGhlIGJpZyBlbmVyZ3kgcmVncmVzc2lvbj8NCg0KPiBS
dW5uYWJsZSBib29zdCB3YXMgY29uc2lkZXJlZCBhcyBhbiBhbHRlcm5hdGl2ZSB0byBhcHByb2Fj
aGVzIGxpa2UgcmVkdWNpbmcgdGhlDQo+IFBFTFQgaGFsZi1saWZlIGFuZCBzaW1pbGFyIGNoYW5n
ZXMuIFFhaXPigJkgY3VycmVudCBpZGVhcyBhbHNvIHRyeSB0byB0YWNrbGUgdGhpcw0KPiBwcm9i
bGVtLCBvZiBjb3Vyc2UsIHNvICtDQy4NCj4NCj4gSWYgeW91IGhhdmUgcnVuIG1hbnkgd29ya2xv
YWRzLCBkbyB5b3UgYWxzbyBoYXZlIGRhdGEgb24gd2hlcmUgdGhpcyBmZWF0dXJlIGFjdHVhbGx5
DQo+IGhlbHBlZCwgZXNwZWNpYWxseSBpbiByZWR1Y2luZyBqYW5rIGZyYW1lcz8NCg0KV2UgcmFu
IG91ciBEYXkgb2YgVXNlIChEb1UsIGluY2x1ZGluZyBGYWNlYm9vaywgWW91dHViZSBhbmQgb3Ro
ZXINCnBvcHVsYXIgYXBwcykgdGVzdCBtb2RlbCBhbmQgd2UgZGlkIHNlZSBhIDYuNiUgaW5jcmVh
c2UgaW4gamFuayBmcmFtZXMNCmFmdGVyIHRoZSByZXZlcnQuIERyb3BwZWQgZnJhbWVzIHdlbnQg
dXAgZnJvbSAxMDYgdG8gMTEzIGluIGEgdG90YWwgb2YNCjcwMjEwIGZyYW1lcy4gSG93ZXZlciwg
aW4gb3VyIHRlc3QgbW9kZWwgdGhlcmUgaXMgbm8gd2F5IGFuIGluY3JlYXNlIG9mDQo3IGZyYW1l
cyB3aXRoaW4gNzAyMTAganVzdGlmaWVzIHRoZSBlbmVyZ3kgcmVncmVzc2lvbiBiZXR3ZWVuIDEw
JSBhbmQNCjIwJSBpbiBhIGxvdCBvZiBhcHBzLCBoZW5jZSBmb3IgdXMgdGhlIHRyYWRlLW9mZiBk
ZWNpc2lvbiBpcyB2ZXJ5IGNsZWFyDQpoZXJlLg0KDQpBbm90aGVyIHF1ZXN0aW9uIGZyb20gbWUg
aXMsIGlmIHRoaXMgZmVhdHVyZSBoYXMgcG90ZW50aWFsbHkgYnVnZ3kNCmNvcm5lcnMgb3IgbWF0
aGVtYXRpY2FsIHVuc291bmRuZXNzIChtb3N0bHkgdGhlIGhhbGYtdXRpbC1oYWxmLXJ1bm5hYmxl
DQp2YWx1ZSBpbnNpZGUgY3B1X3V0aWwoKSksIHNob3VsZCB3ZSByZWx5IG9uIGl0cyBwZXJmb3Jt
YW5jZSBnYWluPw0KDQo+DQo+IFNvbWUgZGlzY3Vzc2lvbiBmcm9tIGJhY2sgdGhlbjoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDQwNjE1NTAzMC4xOTg5NTU0LTEtZGlldG1h
ci5lZ2dlbWFubkBhcm0uY29tLw0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIw
ODI5MDU1NDUwLjE3MDMwOTItMS1kaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20vDQo+DQo+PiBbc25p
cF0NCg0K
