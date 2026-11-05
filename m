Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793895481;
	b=2gxMFmoqKRNO9CqrWkFydkYM3axbxqXEF8ZhynGL1Tg7Rla09mX5/XZpBCFJ1QI1oF8R
	 H/9q1BdtKlmYVCilWBkFDqootJdK0GJj3LCWdBfgrh71LzaxMhNGdZ5EP61bl/Ojf5ob5
	 cz5VTVxG07cdAaifutVlkHvF/7PFWgAJ0aieEh4ur+udNlOzFqtVXFiQD8WZG6MWpOB7k
	 oBKjyat7Mq7H6it1KUtRCcJFAVYvc+BXAqVtuYtOm6i5CWUVSVXRxd0NbjNm2pzexJqtj
	 ZAxDNsKYJuNYykQ0ykWOAAfSEZMMbe5qtmUGuK1YU9wXUIpAxAhdeRi6LlJ0f3XwsjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895481;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=/UDFzH51n7+Pom1JyEqoRuSUy4TtU81Lpvb5o1lCFtI=;
	b=YoZvpM6ONIiKLTTcU2gkBNU3mpK7/wZFOezBd21+owcrW5nmm3zOgmS0TBZH6JWAIIkF
	 H1mT0UZS4w3w0bKq3ettWkJt4EFDCSh1vCkUZK0viEJh09MscMCIaN+jwQWIL82mh4yVl
	 9pM8QUJb1u2PqV4AAESEpG1pbzu5io/6lFew4YKCiIGN465XF3kQwnhf7twttWqGSbW5E
	 bThJLrddovA2RIjbk6prxWBAxAsRcgRPR7N4MZuKN+pXroSqi22qKVb/gj7WD5wBuDFNn
	 lL0TJUFt1pxGlPFeJpjXh/fQ9UwhIGcsSU4pjI3xT7ktKg49clhW0iWdFm7veT6FVOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QbF6DP2o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.48
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43551606A335;
	Thu,  5 Nov 2026 16:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43551606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QbF6DP2o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mnh0oMrTFb4cb8K3Iz0NmT9z/3TxmrluGayFo54A5MxC+A5ZvQyKTJ6ictEU/hrRCsYv76rlxM9uhphbXrkHSMQQZd+t1RxMVrb1rFNfMiGc9/t08cS0KRoG9ee8zZjYo8RsI5zSKFdasCSrb/UbGwlW3n1LcsNW+z3UzkFv1ctk1/S5MPJJi1NFvEIgyw00ueCt21hq4Zh7vMR1MXPIC727IM1/nAIUahpwxnfRQy7QvgmWP3+74bp2hh0MnPxiVnQaE8bC/0qX3PdDlPTMhlv+so833URD0r3FpZxB5b8yS1vB4Cmk3HFFf/ljeKMx8GE7XR7JpqdTEJdz5F6nJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UDFzH51n7+Pom1JyEqoRuSUy4TtU81Lpvb5o1lCFtI=;
 b=QFul3VT+19ykPcY/3TBKzMiJeNL2DkZmF1Foxp14S7HNOTV3b9LFa1sppl4sMAMoVtNc4/dnP0y8jU+XljWVNbpO4cRyUh6I5LlcrXLY9G0EDuNuqmpqMchjGpWKqIfGMVtVlJ8mMaEyOTijMJ+xRkkGO8PHAIclK8VMKp5aBuoE3l9PYUiL+7Z8L90LVwC2O1QA5BkJb5NQCn10NJkPjEvvjxxQJLnqZ5t4SvcIJcKgazA7bCKhI0wb2mwGHNscttlHMejrCXR3pT2erd/+z8tX+T+meZsoQRGGtn2WVVjZtxjTwPUiev/dPT7XgnmedDEQVP8Q32mEeveyIdD+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UDFzH51n7+Pom1JyEqoRuSUy4TtU81Lpvb5o1lCFtI=;
 b=QbF6DP2oJtfo49xHAT7hGH/rjFtSwFQQIZOHMkW6WRV5Hk7/+cIj4XO4bYym5SnwET/+p33QIWMFrE6/PCkJpuWwZspLExgOJzE9BZ+QQrvugUGYskDUi0N7dNSDMy0BtOsqgwpi5YB8gWKlGwyzqNEJOiorrxBlCEmtDZC4ggEjRU/I2S1aY9UgElWNlKQaMoqQQwDBaU58U1e4oPQOku+eXRrqB1rtiRF3s0hAuEJWRPudBplbab3kH42I97wrX2+C2/FLmTkl9eMRd21IO4+j9NKqlNQt6i43Yj6up3tivq6ORM+CDYiR//CFOrQIr4A8iPbzmo5tDRzeBHCEyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by PH7PR12MB6739.namprd12.prod.outlook.com
 (2603:10b6:510:1aa::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:17:52 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:17:52 +0000
Message-ID: <d9b2bb45-5997-4a5a-88c8-d99f56f0e969@nvidia.com>
Date: Thu, 5 Nov 2026 21:47:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Serialize global boost updates
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-3-christian.loehle@arm.com>
 <fd2b81d0-df9c-4a07-bc47-a2a6460304f0@nvidia.com>
 <4606b154-e372-4d41-95ce-57b17f0f1d4a@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4606b154-e372-4d41-95ce-57b17f0f1d4a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::13) To CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10)
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 13019177-29bd-4365-def1-08df3b58574e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|10067099003|56012099006|4143699003|11063799006|261026140227099003|261028144727099003|261022105027099003|261102130727099003|261102123227099003|261021121427099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	SzaduR3mvXTgM/JcmLMM8XNtURPYQ5VDAAq4mgG339ATTC+tBN5/MPRr7cUDdfATBPrUp1k9Yi0HWdeQc4MPMEXJN/fFWVjVuSC5kO8mZTYrT5M24YverzxTwNCKoI5E1Ho74MkcCsLQ+cyHEYqdzrG16hCUx9HiG0z8BI91MZKJyC7QsimDdD8bTuAPoFHgwXopBdD8bY9Hn9H65jp/7Mnxl8TqXLRSN3aAtlNSaaJJ18skdsIGt74H7Q/Mx4UxzrRWA4WnoFfy2SVFpwTw0vmc3CQiompe6bxyiL0E7kRHJ4EkK52xbo7gO+SjWJFv5UZ1hfZdWEYh/7KihFp7YNBY5VhPNdKGBIoSyN7BWAxa7ZPxZJqY7EA7qS9zUcOwcv+AYpBndZ6+TYxoB5jFzjF8hBuYF+hxelY+PoUKsmTfBf+wb9DkC6c/NsHxD+AEC56JG+eXWBWrSIcRKvkP0FC6MN+rdt598syl0GNqjEVGWhA0DYF69aBNVuCXnCe6fe89dtX7mDtAf1GrPxKpPuxaxHXAW8jTMyZYPzt1cHW+TnY+KpnQ0Oft084tu6LCKbmT/tIslnG2hzfxVxR4vRcxIVPWbLljzR21MpUILZkgbBdoVjs2V3dYv66sLPZEoXts8LWLCV/EYU8GGBnsZUwmnDTVNLJpbE8QQh1agrA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261102130727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktzWVRKVTVxLzhLbkZ6MysxL0pEZWkySjB0V255bm13azNzeGgvbWdkWjM1?=
 =?utf-8?B?M1FOWEFCdXMyUnlGS1JhVTQrZVJ1SHMwMHNUY1JzY3l2R2tyYzRIUWcwZDFJ?=
 =?utf-8?B?OUZVV3B6N2RZM0htUGo3eVAvc2dGR3ZnelJIS2Y2M0dFWWd6cWo2dnpqQkhz?=
 =?utf-8?B?SVg2TkNVcnRyVjh0UmJVWG9oUm9JMXAxcUNQc05iR0tFQ2VweFZhQ2FYTzBV?=
 =?utf-8?B?WmJ3UzFiWmthT1pHMStwbkVES2hTbnhnUDR5SmplMjlMWHRGcVhsaklJOHNl?=
 =?utf-8?B?WkNnTFlndkxJWitlTlk4eG9RRyt5eVFQd0J1N0xwc2pUSjMvekY0UVFFRmlo?=
 =?utf-8?B?VXoxVUdoS3V6SEl4ZmhiTGkxK2dEbmFFNTRyUkdnQStkNHZaTUx0cE5icGNx?=
 =?utf-8?B?bTNRWkdxckxueG5sdU5XR0o5UUMyc1o4WkRKcnByTVg5dkhzeW1kT2ptbmhk?=
 =?utf-8?B?M1k4NXNMYTdvTlVNU2xNcUtMZE50OGo3Q3BmbDRuR0FYUUNiMk5jaTgwUDVu?=
 =?utf-8?B?UC9lS21pMUhCNG5VbHE5cjJRK0RqZ0VBUGljQ0NUdjE4K2JsVW5FR0dLdWdn?=
 =?utf-8?B?NCt4RmJTMnd2Yzl5cS94NGdlWkJMVUJNWGhFT1hpTU1aQVZrYWhWU250OG9T?=
 =?utf-8?B?ODZUU2M2ZUJ4ZEZnV2txWTFjVHZyYXhiY245YVFnVkVmNGkvd3BoSllCQXg4?=
 =?utf-8?B?ZC9RUHpQWDlGdVc3Mmd2MDh2eFNuci9kZlFkZHlPdXFoUEs4enFXRnFOY0d6?=
 =?utf-8?B?L2Q5bTNQdk9sRmJYWlVTTzZiUEF6cDdFYkFxc0VkZW1hN1dmWGRpUm92ak5F?=
 =?utf-8?B?MmMwb2x2aGdGbEp6bkw4ZzlKOTVqVXZOcDk2dVlOWTA5ek9uWlduNFM2MlUr?=
 =?utf-8?B?cVhLSnN4c3NlaWYwSlo3Y0J5dEdkUGFkemdWaDRPVEVndWU1c200c1h4VExL?=
 =?utf-8?B?b3c0blR5bW1DUktpbTVTS1JwVjhmUEw1QlZjVmFzNjVtcHBwdUFQak9UK3Av?=
 =?utf-8?B?U05oOGMvMWFBa050VzhkOENNaGxtU2xlT24vc1h2SHF0VVZpWHhzM0hpQitx?=
 =?utf-8?B?Y0Q1S3BpVUJhVWxPREdXUk9abE0wVjJQdDZwTGROSFpOaHBOTkM4dmgyT3Bp?=
 =?utf-8?B?Umo4eVNPSnNlZ3BNVGlvUXBvWXRXTmZRYUxxclQvRW10RVJ1SURoTDFFMDli?=
 =?utf-8?B?ZG1FcWx0YTNPNGhZQjNVUHV5NkM5SHgrbHlyRmNBR2QrK2cxUkc1VllYcDdY?=
 =?utf-8?B?eUtjWVdudk5pZnFPQURsZVNJVzBLdm9qN3NxaTAzNkVGWHMrdSs5TW10WnA3?=
 =?utf-8?B?NTBFdHhBVm1RRnAwUnZlR3Mva1YzTnV4N0t1Smc1MU9NVm9keDRhdWNpWUZJ?=
 =?utf-8?B?RTVYaHAvUlk4dEN4Q0JMWVVhUTVNL1lrdmdEbnFIbGRIemxVb0puU3dvWDVO?=
 =?utf-8?B?dzlLZmcwYkYrYVhRajJYeWVTbVViT2RDQlByNEY4Qm13SSt2dWJBR01NYnFP?=
 =?utf-8?B?dC9BQkIrSnEyNVZsTUxqRC9FY05aS1BUVGQxMkpDaE1UZ1VSdUdQQk01M1FE?=
 =?utf-8?B?REZPMEo4TlpWVElSeU85SmtBZ3JiQkd2d2o1TEYyeWh5bkpZSE9ONVJyYlNL?=
 =?utf-8?B?aEp4c3lPWlQ3Zkh5WVhFaGFLWUZQa3Qwb1dFNUZzckdicmpZQUdtUEJ2bWVL?=
 =?utf-8?B?WG5KYkhCQkwzUWJIeUhqTktQT29GU21wTEZNcTlLSUlQc2JXYURaUUk3alVV?=
 =?utf-8?B?M0VNNzFMcUFTLzhCY3phQjU0c3BzM2RDRzNwU2EyZFZPeEdNeWlzYzVDd1Qr?=
 =?utf-8?B?WDJNbk8rU3RaTUVMZTY0Q1lzV2g3YUMzbnAyZldqRHkyWVY2encvOWE2SFpp?=
 =?utf-8?B?YzMyc1hxSjhpZ1FpR045eHFzWXVIT3V3M1ZXQnpZWVNjWWE2d2tDaG4xZXp2?=
 =?utf-8?B?V2tMWU5YaVdZTWxSSHlaRUJCV1dGNVR6VnRHQmo2YWM4MVRvTTZaU2E4ekls?=
 =?utf-8?B?SFJ2YW8rM1ZtWE0zd2JvVTZMV056MkdqOUtoemU3c2g4aCs3aVRLanhHR09F?=
 =?utf-8?B?RFdmWlFTRVZHRU5na2JnbnFXUlEvQ3drcU02SldPL1RWS1lXRnhHeWlwNHZE?=
 =?utf-8?B?b3BwcEphNXppMzdZTTJpRll1MS81RGFGZkJnNFFjU3dQaUh3RG5sczd6WDF4?=
 =?utf-8?B?ZjEyQTJmSDc2R2tGTUprK3dMTmJ5NjZDR3AvTWdZbWR1S1VHS1FxbzNxL0gz?=
 =?utf-8?B?bWh3RDlHZ2NibnhzbTBPZXgzMnM5bW5taytQaVB3TVRWeXRNbUJQb21vZHR5?=
 =?utf-8?Q?vV1vsrHMmuirevj3WR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13019177-29bd-4365-def1-08df3b58574e
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:17:52.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yldU2C1NoF0XhZ/VhtR7xFZreyMotfebL/tFnJ9hLQ0w1FP5sQsw/IWaohXwuFwvnUtRuvVrnAI5mTFmmQS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739



On 05/11/26 20:31, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/5/2026 10:41 PM, Sumit Gupta wrote:
>>
>>
>> On 05/11/26 14:33, Christian Loehle wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Serialize concurrent global boost sysfs writes with a mutex.
>>>
>>> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> ---
>>>   drivers/cpufreq/cpufreq.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 23a77f5524df..d95c849f79c5 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy
>>> *policy, int state)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>>
>>> +static DEFINE_MUTEX(cpufreq_boost_mutex);
>>> +
>>>   static int cpufreq_boost_trigger_state(int state)
>>>   {
>>>          struct cpufreq_policy *policy;
>>> @@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
>>>          bool boost_enabled;
>>>          int ret = -EOPNOTSUPP;
>>>
>>> +       guard(mutex)(&cpufreq_boost_mutex);
>>> +
>>
>>
>> The policy->rwsem case from [1] seems to be still open. The per-policy
>> boost attribute calls policy_set_boost() with policy->rwsem held, but
>> cpufreq_boost_trigger_state() and cpufreq_online() don't, so they can
>> race with per-policy writers like ospm_nominal_freq in [1].
>>
>> Could cpufreq_boost_trigger_state() take the policy lock, as
>> cpufreq_suspend() does?
>>
>>    scoped_guard(cpufreq_policy_write, policy)
>>        ret = policy_set_boost(policy, state);
>>
>> [1] https://lore.kernel.org/lkml/20261030172745.2045743-4-
>> sumitg@nvidia.com/
>>
> 
> Hi Sumit,
> 
> Could you please check whether the following patch addresses the issue
> you mentioned?
> 
> https://lore.kernel.org/all/be3739f8-e668-4711-912c-91459d77ed35@arm.com/
> 
> 
Yes, that covers it. I missed that. Please ignore my comment.

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Thanks,
Sumit

