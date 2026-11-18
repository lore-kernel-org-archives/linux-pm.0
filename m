Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795011873;
	b=pxumgqS3PJaVqSMMJa/O416UMXWhO8tCz6HwGxBgNENbL+fnTzgWsWKHONJw7tn5YdWX
	 pS0CFaMJiCvvHmaMzd6pgBBO7N5XQvZwaMTBKjr7wpfiTim0bakdka4Ug+CXmda5bK0+x
	 s4QyzeTT9MPr9/nIrb0TLlcnfOAdqtwRmcDEwlIBj3pIHY5nWDsA3xnr8RlJMckxL70Ax
	 bzQu3EnaMNFXcoOrXIKDAq5z+hSC8y+8rhfqBtNCXJL8cjbDGCpuYLuM280juc0kIdBXe
	 qN4H22AQwCbpYNt9qOkh68vBQLn2gn3931Xl4tN5ZC4vUtoDo8cKppITZrVeDmNDqEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011873;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Symt0/OGuChOG3S49asvnH2m61iQHduoAYDWHoh3oIE=;
	b=ZBnSM8Vgw0SE9eqbr86eELVywFPDFVO8UcGDCnirmtAIReWdvw+DkpQ4wQlcpB7es6AY
	 KkktE4lzQeV37y9BZgr1X0BaUeGxpH3zE52q9lALEw0E4IzXOGM68bQTnctWfc+7Qvp0T
	 FzK6G0SVQqHrLYSAtpSZQ5ZgUjH2Np4mTGFb+iMaWmwaMVwAO2kbWVi9RZlR8+F4IY/Fr
	 ygXiWm5CfQG9D5R64He+t7s14yD/xvu77VjjKTOa7e72hQsp2hlpQSLPMwz8h0yLdSREw
	 O5nlsv5Syu0+rBNuuAWWbcvmfdTcjUW4gOxTouxZXpmNcs+Cq7CGf6/f3UIo0yTCdzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b="xSRezUZ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.116
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021116.outbound.protection.outlook.com [52.101.95.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A66606A320;
	Wed, 18 Nov 2026 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A66606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=xSRezUZ/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scE5jTxZ54S/33sjUFDUvSnfPM5pl5uiCSVjtAG0yfdK2UYdu29m+qwylb13CyKyCTApUjeZgnxFG+Bp+kcyB5Fb1KN1ENL+K8p9P6QfjxIimpYiVt17mC3J5vwfSYWkLln5u+TP3+cCIriCDaHxK+trwWvXH+HfT7Os5/+8J2jRgreq6XbrcNtl/L/JNuj/Q79UQXKtZRvoMwtWZI/IvVjx2od9KNlGxYYlExmkRsz2uyLeH2JtNXIg84DOc9WbCcysOuf9D5yzwZNdWopXL5aVXkaVrOdxonAEnP/YCDGvDcDyDTfPvS0QV/KThjHKQbHJwaTbRNK/yRUCXmuebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Symt0/OGuChOG3S49asvnH2m61iQHduoAYDWHoh3oIE=;
 b=XtW7zhqzJMPAr0XjAQICHkn7RwTGpZRUm/ONEtLlJV7ZoQdjlPAslcKzoMa/+j87+geHJ6lmxhyVGyueAefYdNnb/94IAUtj3ZiaL2c5GoYmnefaqFvWg90rW1cYFA5wYRNlf0GswLjfFjObZ6lNAhWLMS37+yGM/2ZJ1oDYciiU4jBLGVaVTFRtBLet0GdgZqtqWTsnZg/UuvEeFOi33kvk8GGcps1/UZmacqebmehnLu4TvWkMopgHRmC/AzS8c9DLqDEwNlqDFdB6b6sFkGv638F5RmYWd6/uw4h1apHJQUYjzgEkvGMlkCnB2v3RLfhppLZruOrcdHvSQFxW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Symt0/OGuChOG3S49asvnH2m61iQHduoAYDWHoh3oIE=;
 b=xSRezUZ/RFSCRM0xRYQc0Ap50NrRq1kVls9LvWiYrNhmueubnWrsYI3ZP+U1J9yUJZ9DskcDULfqWKXy7VNl5/CqRlNHMTdMGs1IMV4pbmorHzJQHsonT81r08EWlcXSNMDS61znTjjCnt2/kSQtoiDfIxuRvRB4TIgoXQCT5Lc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWXP265MB5105.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:24:27 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:24:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 14:24:25 +0000
Message-Id: <DMYELN5M09W3.1SYPKW7DZ70E1@garyguo.net>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice Hieronymus" <mhi@mailbox.org>
Subject: Re: [PATCH v6 5/7] rust: clk: add devres-managed clks
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>, "Drew Fustini"
 <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>,
 "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-5-a5e9977b3509@collabora.com>
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWXP265MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f95582-5d83-4c64-9624-08df457fa66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|921020|10067099003|5023799004|56012099006|4143699003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZtxxraFoCPeTWR8pnHwl7/HKPRjT4oO9h7HTYjVP04v/cngFpkwl646mMjgICUn4k8WNiaBrBbTYdry4chBdtnGuD3OHLL9MGs/1WaLFayRjPA7S3kCqxUaXPoTNoQV7HEgtsVEqqU7hOEfxHOMz/j+7Vpz6191lCokv55WxrLkm0tX2V69ykJ9AIKppzlwTVsvWgOrhO5KCecnNfJzGtFFIWzSiEDlSxdAycuvpkYtYHN2rbgrnVfsaWgsvcmBq2N4poDbFTuNuQDCGI2yLave2K7mOhCJUVE24kbbmVi4A5gg8yEXBV0O84r715vn9yrXC5q/xRCwyfRg5Ls5fNWYRbFV/G6pADhTI5ci0a2xKOvn/8RqpM0039FQGNDsisifDJ349bYxrWgnpmS4hi/fIwF0A1r7EtErIGl5vFKqKUWDXlIMpL1vnFEhGGwtTWE5/x5JGrlGYxA/FtLX79/8K42Ik8NjJatEW3hwRnFMA6X5ZsSw5KIoULhdCIighc0w5uCy5Y5IGwJaK86A/jREcEL9ehbmizr/DD7EMzv7R4hcexM1x6ol9cmU5oI4CstQP9qiTVdYYHvOMOmqfbfXQiHJgig66AubJpI1BisY4lmVC1tqkjibBXiAfAh5UzQaxd8uctzWg5XYFvaqVCQzbqOsjVj749bWuzvGqp0k4AitvHuwQlufJ/OdepDIjTfPiPfX+zjI88q+kl2bmoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(921020)(10067099003)(5023799004)(56012099006)(4143699003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnFXbWNyemJpQUo5a1U0NHI1K2xOcTNDMURlZjVUWFo4UlR1UU9saVlwWVhs?=
 =?utf-8?B?YXFKV2Z6Z2grQk05TlpiZ0RpQldCWHovSmMvTjE2ZXNveUlYbW9NZ2FaS3dQ?=
 =?utf-8?B?YTVpN1FvK2lnMHFkQm1YbXh0MjAxYnY1ajB4ZGJzdUlBWm5tYXhJaG5iZDVV?=
 =?utf-8?B?T1M4eGVrVzdhWk04YWdscXZIYkNpL1RJbnVCNE1QVU5ZY1pQQStlMHBtNGZa?=
 =?utf-8?B?KzN1aGdSLzN3Yk5UVUpzQ3pTU2I2cHREUS9JTXVwQnVOZkN6YzIxMzNEVU9z?=
 =?utf-8?B?aUdMaWRaSG8vMFpieTQ0Y1BRU2pWTnlsNy9zVE1CNlZPOTdmdDRURkxhUjV3?=
 =?utf-8?B?VFF0OEhiR292SWpvMXVTenNtdHJZMjMzOUkveVYxVGZya2ltNWtFMlMxWEcw?=
 =?utf-8?B?QVBKNktPcnJkcytJdzUvMWNoQmNyY0lBZlZ5Q29yWHl6VC83cktrajFFcEJQ?=
 =?utf-8?B?Vy9NR2s5K2hvNzg2U2ltL01SYnZxR0RlMmZLSnlHNHFHbTFGMWpGK1RPbW03?=
 =?utf-8?B?V3ZPSVFTUnZMa04wcWovdHhqVStFU0JKNG9uMFVzeUFLTGE3c2MzRFZvaGEv?=
 =?utf-8?B?VGJqRUt2VU45RkJGaThTd3doZC9YMlk3NzJ3eXplV3htVS9PS1BrSnhHYWMx?=
 =?utf-8?B?bmk5T0NDd0Mxdy9YaXpYM0N5R2wvVVpaR1o0Vkwwd1V5bUd3QWJsVVlxZWN6?=
 =?utf-8?B?NW5vYXBleVlHQTlPK1FBbzZLRjdHMlRzTkNxNTAvdFRDRDZXMEpnWnFhTHNo?=
 =?utf-8?B?TlhPTnhxQmJSS1BRMUg3QlFsMUZVdWRHb0ZPdUJqYS9ieEdqZFg1bU5KdWhw?=
 =?utf-8?B?M0RZOHFaWUJLWDh2TWd6QUtidlAzNXpxN0QzclJ5M3BoV1BQcFRoWlZRNENj?=
 =?utf-8?B?aXgzSzZiclhiNFMwbCtWR0I1UG8vL1dTUStaTkFzL2MxbEZLaVZINWNkZzhQ?=
 =?utf-8?B?S2t1dVhKQ2lIU3c1RWFNYTRPRVZTSXBpbkFESDVxNk1tNUc4dWxvMmlJNmZm?=
 =?utf-8?B?eTlVeDdmRzUrWEJDV1REWWlRejdqamZSWE9KaDhyWXloZG0zN2J3cC9wVlVZ?=
 =?utf-8?B?ZCtMaWlxUVJtTWpZdTRnd3VjOHh2VkEyVEZCWTBWK284OEF2K1JOemgwL0tB?=
 =?utf-8?B?UmV4allvSHVYVHM1ZnFqYkZUUTN4d0t1c1FRK1pVMFNCWTVxb3FtS0dmY1hB?=
 =?utf-8?B?RGNjNHdCNzdmRnRvVHVkc0x0OXkwNTU1eEkvSExONEtDUFVhdFBVTWMvSjhQ?=
 =?utf-8?B?Y3JKUC9YanFQRjl0ZEN5Y0o4M3c3cmpqbWNiNmZvMUowR0ozc1g0a08vVEJG?=
 =?utf-8?B?SVBLaWF1cXVEQlg5K3BsOCt3WFRXcS9MZm1Bd0pVNG5WdVR3OWtiL1l5cjRr?=
 =?utf-8?B?YjhmV1BOMHNNaVZGZ0diNWNpUFRjbzlpYTlZM0xhcGw3d3BaQlBkTHlyNFFP?=
 =?utf-8?B?UWxkcEFjRmZZMGhaZWlKT0pkNmpOWWhyQWVvSHJ1bkJxRTh2NWM4LzkxWmY5?=
 =?utf-8?B?eFB5bXBqdzA5T3phMGxqU09PeWtIOWhvRVRhUDhYY2lBbm0vM2RIS2Q3OFlv?=
 =?utf-8?B?RHZMQXNWNUxsNnVkRHlVNTk0NlBiQkJ3VlI0YVpVVFdrOFdnUkxhQUpsRXNx?=
 =?utf-8?B?V1BKdFptTU12Y3d3NVBLYWhvM3c1UjB6eEE0ZERPeUxwRXpkaG9VemVGV3Fa?=
 =?utf-8?B?Mmp1anBNRWVjcGRxN3lWSm85YkJnNzRYRnNIdC9Lek5VQmVOM2ZRQ0ZBVUpi?=
 =?utf-8?B?SDUrWFZzZ055dDJsa0dVL294TXlFVUV1emNHbzlYeGVlM3pmN3hmaW5aZUht?=
 =?utf-8?B?QWJyQ0VEeGtpYlB4OXlxUnhvQVRGMk1waXY5OHgyYUZ1YTRBU1gya0h5b05N?=
 =?utf-8?B?YnZHL0U1eGRiRm0wREhRTzQ2OUoxYm9FRFhrblpxYTdXdnNVd2VSSncwUjBq?=
 =?utf-8?B?SWE2VW9UdmVYalJvSnJvQXpGblkrbnRLd3VTQ09ZYkQyMUV2ejJ1bk9HOWVE?=
 =?utf-8?B?SjNTZGd5dm5sQkc3Vm41aVlVMFRWay94SFJ1M1dPYzhHSWt6Vlo5RjFWNWlK?=
 =?utf-8?B?RTBpbzY4enJjcEY5dzNKZ1Fkd2hNQzVJTHBoYlp5bXg3ZlRyR2NFNjRKM2Y4?=
 =?utf-8?B?SGUveXFTNHp4akxiTUwrVGhEZWtTSWNzUXB4UmtHa1JUYU42RUVUMU1QaVZE?=
 =?utf-8?B?MXM5V0hCT2dxVE05Z21QV0N0bG5IemZOa0xGQWtTbVlLZzdZbEZBQXRtZDlr?=
 =?utf-8?B?Z3I1QXQvMk4yQ2o1dENyZlZLSkZBb2VXaE0xLzBqbEEySTJvYlZteHBqSWxk?=
 =?utf-8?B?R0NITjQzQkNweU5VUWlzU0w5K3VCa3NaL0lzKzB6T2krUFRoTjFVUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f95582-5d83-4c64-9624-08df457fa66d
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:24:26.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZdQ3oE51rbxmOYcdUV/69oyFHqQaaKZbiJaCUYS5as6xDDIys2+I81whJqQsRzuYQpUJOYGWNc1Zyqi2VdhHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5105

On Tue Oct 13, 2026 at 6:07 PM BST, Daniel Almeida wrote:
> Many drivers only need a clock running for as long as the device is
> bound and never touch it afterwards. In C, devm_clk_get_enabled() and
> devm_clk_get_optional_enabled() cover this case.
>
> Add devm_enable(), devm_enable_optional() and
> devm_enable_optional_with_rate(), which wrap the C helpers. They return
> no handle, so the driver keeps nothing in its data and cannot change the
> state of the clock. The clock is disabled, unprepared and put when the
> device is unbound.
>
> This mirrors regulator::devm_enable() and devm_enable_optional().
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Given all the device resource lifetime changes, do we still need this now, =
or
would putting a guard in driver private data to be dropped automatically up=
on
unbind be sufficient?

Best,
Gary

> ---
>  rust/kernel/clk.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

