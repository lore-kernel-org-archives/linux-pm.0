Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012054.outbound.protection.outlook.com [52.103.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDE326939;
	Wed,  2 Sep 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338909; cv=fail; b=ueqEEXB2JvWoA23x55N7MNGfsRX0BrGK8API4z4oXZKELzn+UkgsFV9EHaw5rw0Sqob1jdv2T/lrluhMsHdeK1xMMIKbMDGWsIpyEDOnPe/xzHDDBa4P2chtUwjuyzAzPGPFHieJHKEAwS8AyN2IFlUmyN3nWF1eD45DlXkc52o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338909; c=relaxed/simple;
	bh=fyy8hVKSfk2SsLWR//hxoLTypI2gZd9OL/UCS59yBGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wp4wlQdSY0Mg+HO01tMYIWX09ZRVx56g7ioYu1RmthmGRRqIqi5E1si1IMFDzljG94XfCDBpa+7YDdtBIk7vynGnRKR/GkdOdLtAYTrDJhI49jk519J22XKXOiXYfwyMWzJd9lyVfIbEJhHtMdo9am4J8EUbalZHmFTqBhONwqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L2D9yjaq; arc=fail smtp.client-ip=52.103.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L2D9yjaq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We91+GBvmFtfEpvL6LVtRibtrFNjmo/7xDBJ2CGIHEEughPn244Tf2aeGDmIGh+W1/mo8lRwbp5eEeSoOCyOHnYd+qD76DtvK9IuAqcrlaB17mWutGmCZWwfu5bPSwYjAqcKv27VQpcKBIPr0rTsA92pI/r5M66DB1NOEgm/Gu2bQLtnLkE0elocFtSTH6hEXapXZQvkQvnn1F02DCt2VwdcjXEa5IAnb0zsYxvWawqxkf8Z2xFrOOETSzE9glBKQx1dB1xqlcQ+QJvzKhknTxP15hBJgklx4ujp0mYEng8y1PhnkscDrqC3z6jcfA/rl5HH+tuP/qOXso+y45xudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEtJJjkuszj2ro5FvhbXx6id2Cfzv/74vDcqNonO06M=;
 b=rtXI9TGJrfTY8JgM7R/wMZL9cywT7U24Xo1zHkkTHpVxbvGGMhfoZ4V+uxdeoa5PJQERbkv0xumdXL0zNLFE/Dpx6vMFYk3MOW5OxM07BI4cJ4c3HxJqUQ2EU4H/AgkoVMM6c+pvNqBmNfgBS3xXXMYmv/QLwRVslnRWAgEXc9VpkM0f2/0L72p4DwtY8MenSuW2Nsk7SIRyYG7WGQTS5l+xfk+VJtXdvNoTm5y8rxDP8O4FRGe94Mwv/TnZAXuk7Z/EaE9EQsb8wFRmMbwKHU5INE2PRcirS9N5P5iTDobKJj+dE6ocqRp3HcfCmTFTxtB1zwURVklmH5XgOHlbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEtJJjkuszj2ro5FvhbXx6id2Cfzv/74vDcqNonO06M=;
 b=L2D9yjaq/czC7vmRJkTIg0J+QURsMtTcXe5ukZgw5gOYlWfeOXQ4YXGqDzbnf8obWjJeWjLlTYUAQa0qk54lv620mpHChB4eBT/DuW6PiwJJCOZ6ZNt+vGbRrz8UxXpeiDAiLDKo0tWLMFeWoQLoKQerj+ox1fMqWSxP6lcxYTOXAqGKzIykWww/naR/GwhCpPkgWVh/NGmM/hWVKo25AgokIaVsar9UTuER9BcQ74mSbmUURzDQeb/zTh7WU7QG9nGasnCjm56z2Q29QW65w9gXaUk6k56h0Eh4p6wuKPS07DtIj6Z+DGRUsWK4x1YXJ+XGCGK22XdASwZxHALQCA==
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com (2603:1096:4:149::12)
 by TY2PPFE8D179BFF.apcprd04.prod.outlook.com (2603:1096:408::af1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:48:22 +0000
Received: from SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78]) by SI2PR04MB4931.apcprd04.prod.outlook.com
 ([fe80::8a7a:9439:be86:eb78%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:48:22 +0000
Message-ID:
 <SI2PR04MB4931F65C44962845CE345B79E3B72@SI2PR04MB4931.apcprd04.prod.outlook.com>
Date: Wed, 2 Sep 2026 16:49:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Only apply cpufreq pressure where frequency
 is invariant
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongyuan@hygon.cn" <zhongyuan@hygon.cn>,
 "huangsj@hygon.cn" <huangsj@hygon.cn>
References: <20260821073927.455475-1-wujianyong@hygon.cn>
 <fea033f4-a680-445f-b231-2a0cc1dded8b@transsion.com>
 <F16AADE6-B6B7-4997-9CC1-A2E323498B7F@outlook.com>
 <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
Content-Language: en-US
From: jong wu <jianyong.wu@outlook.com>
In-Reply-To: <CAKfTPtCxMA-7BX20LNhdOT+BQysdnOxOALrLvhTFNYJLbdsoCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To SI2PR04MB4931.apcprd04.prod.outlook.com
 (2603:1096:4:149::12)
X-Microsoft-Original-Message-ID:
 <5004244a-3d33-45a6-9c23-4fe7a0820f96@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR04MB4931:EE_|TY2PPFE8D179BFF:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e03f61-9ae2-426f-5ae5-08df08cef178
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOy+mYsVH3gICHi7e8OwO+kN/VI/VeuXTve79mFb/7GAo0ydp7z4uyHP5I7cfUBAm8FyLwhf1iVftDqxPg/Mk3uUkEYB9hMMFaKW7uyt7DVJ14g1Dstsq9XCAbsd4YBKK9RwGvAlAoUEcvnTi2SHG2YPE+8vtFnsacYJLyKQFr8Zerm/aQe9ITHQaJ2dhjewCV1oxnz0ggkRxSOvcSZ3YVAOL8XGdCUZP3J96v8vVxvVr9c1PncSOfqMwoiIMLVLM83Twa3Kqz9M4UBjlHpJjbEBhVfgK96vyjAgGjZG3dB55lOXrRz8EWWSA7wjiZk/V7TbtNjY1AzsJ3eorDVmb4XGVsQu57rMjXEnX8GFmQvKkW3yvfYwFQnsXjtE7jz56SF8BBSUeyg+NBw9FlRviIxcYyTpK0za+2DFnOi6Peh74/uHhawRrmF5S1qRxUV6++eBYWZA3zqYrhUO025M3gGK92ZJiDz1/tmi1eVLl19nZtzNwuU4/XiIK8kjplHUBQti9kH6hx7N6BQKfxUp7psjIdm2LeweHb9sSwRZVNxGKOjlBNe6dVOj1WwX0nX9eyeVnIYVVzVGFcK2UBNHNcZkQlHyyYHQNOYzzeQf8ycQOCbOwm407QMXaRQp5jYz20nMPR/MAV71FvGCOlSBA4N5XsuA0wxAjNgP3x05Dj46pkSHue2CXydOknpTRXUr0G5zzit0gI7drmW+8Shqv1o1P05Ttq671gr1MQQCOFGqk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|25010399006|23021999003|19110799012|8060799015|51005399006|19101099003|15080799012|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlObHFKNkNha0FOUDJ3eDBvb3dXeFRramZGZ2hGWjNlMHFoZDRlaWdoS0t0?=
 =?utf-8?B?bmVpZWpjRnF3dTJjZVVDVUVlUnlUbXJiM2l5bTFSMlFMN3dYOG04N1dQY1FN?=
 =?utf-8?B?TWZjL004a01rMnBEWUdQQkRnVFgrSDR3RUZhKzExcitTRlZxWG95eHY3NDdp?=
 =?utf-8?B?KzZsS1dUUFhKNWlQODMvc3JjenRJUGRtb1NteU00UUM2My9NZUFkbkM2MTZL?=
 =?utf-8?B?bjk3T0lvN2RQY0c0OXRZQnkyb1p3aFJ3NXhObjVKVDJGeWFXZDBKaE1CbXJS?=
 =?utf-8?B?eFFzeTJuV0pielRVRXhWM2c5Vmc1WURwb0h2QVQ5QnhCM1htWW92NWtsaGdJ?=
 =?utf-8?B?Q0hJNEF0QlE1WUt6cE85TDlQMDlJcm5oQnRMU2JDWmFlR1JNUGlsMlNnYk9i?=
 =?utf-8?B?RTdOSGpNcFVWazBJRXh2eStuNnVkUUdxRU1McUlSQnZTSjR3cUhWbHZ3QUUy?=
 =?utf-8?B?cGx1OU4vdER5TW13S0x3M2hnNktTbStyTU1iYWJqVkFKYW8yMDMrOHFVd05t?=
 =?utf-8?B?L3VnREt5aFhKR04wMFJ0OUs0NHZlUk14d3VhNnpzdTl3VzR5dVpjdERoM2sx?=
 =?utf-8?B?dUs4M052T2w4RzNVbllhSzdFTURiNlJsN3BnZzFPWHpxK3M1aWcvcVl6OGxT?=
 =?utf-8?B?aUhPVDB3SzBxcVlndGY4a3ZhY3E5QWFrdTl3OXBHZXFaTWF6eDNNd3lXWjlj?=
 =?utf-8?B?Nm5KcWpTNVVoWEpnMStEeGF0aWhHcHVwc0VuSGhKOEt2RVBUWjYwWlJFTU8w?=
 =?utf-8?B?VlgxaitXcml6UVJIRU5CT2tkMmVsVCtnc0J2UldJYVcxVWxvdTdwRWM4bGVj?=
 =?utf-8?B?UkVwcFJEQlpTMlJxb0JGOVVwNHAvQW5Pc1RzVWZCRUh3ZVg2RE9kRC9TOGtS?=
 =?utf-8?B?QjNFWG4reGh6N0xvNWF5K3BOVXhZbUErcjNMVUpOc0poWUtsSDdHSGFXdEN0?=
 =?utf-8?B?dHY3R2plajhzSWlIQ0EvMVVUeWNhWnIvOFhwUmdvRE0xdVBsY29QQUQwbjlQ?=
 =?utf-8?B?ZFI1NWFJNUJyM3pvN2xsbjc1emNoWTA1enR1U1MvNWcwNmY1QTJUUUdKYjMv?=
 =?utf-8?B?cTZXbS9VdzhianhQY3p4U3dxdTROME5laitST3BmRVhCd1lvOFdoMS8wckhs?=
 =?utf-8?B?cDRGS1djbERCTXhrbkt0eGxIbXJESVVvcXVMNVRqcFNHNWV0dlJxVjdkRkVQ?=
 =?utf-8?B?UnlNbCtkSkM5OGpOWEMrUGRKREdQbjVNUzB1UDZ5YmNyQjJoWS9sTVVCWGZE?=
 =?utf-8?B?TFgwenNIUTZSR0VFV3c2YUMwbkk5R3laRk5VZzVCdXB5NWxVQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VTOW9JMFRvemppYys1VUE3L1Y1ZDM4dk9tUC9jTE1oMlpXckJsTFpEY3ZZ?=
 =?utf-8?B?aWZMazgyOUVRVmh6dU1NdUJ5UGRYT2hxSHRWK25UTkhvS0UyeHZzSFY5RVhL?=
 =?utf-8?B?ZDJEZFNCQzZzTXVMMmI2YzQySUZ0dWRSSTk4ZllaRnBpT295R1J0Y2JkOEM5?=
 =?utf-8?B?S1h6YjlvNmcyMTZENlNyNVNKMWhmclRod1NxcmcxdDlwVWxZZEFNNUtKM0R1?=
 =?utf-8?B?UEVjcDZjb2FLS0g2Rk8wTm9KM1o4ZmZMK2R3aElqN01XY0hocitoRm5PZURj?=
 =?utf-8?B?SDVTeG8wQ1hESzJhUjlkQzhDRXEwNlZkdjZlY0FpejRQMkI2NzNxc2VEUjh6?=
 =?utf-8?B?dkZjQys5bGJYMzlXQlpLZ1pJY0liTFRYYktXSm5xZU96VS82c3grV2hkUHpD?=
 =?utf-8?B?U0IzblFwc3QxRGMzSHpXNzExckExSnpNZElWN2dSU0Z2bDVINjF3U003S3Fx?=
 =?utf-8?B?a1BrTlFKU21WaEgvMk14RVltdkhDdm1LMnRMTFNvM010enFKYkVzUzVDaUpn?=
 =?utf-8?B?KzZ2MldrNGRMOHZzUlFkWUZPaHBJbHJraVBIYWVmaktGMFp2NmR6WTZ1VEQx?=
 =?utf-8?B?SmFjWExleWp0MllzYnQ0NnIxR2RnMEtpeUJIazNsU0tVY2pSV3RuTmxNeW00?=
 =?utf-8?B?bFA0cUtaMkwxUk5FS0wxRVE1YlgzSytYdklwQTdPY2FRSlduSFdXWjBSdVRj?=
 =?utf-8?B?RVNhb0paMVIzVS9oQmQ1cnJYeVp6QWl4ZW40MEQwcDkzU0xxZDNOTktpUFox?=
 =?utf-8?B?bWVKNGxCUzFnbGNyOW5JZlFzcy9CaG85SktTOFluWTBUY3d0MldYQUpnczdt?=
 =?utf-8?B?MFR4aXBhdHdReVNsUldsbklCc3BobUU3YmlCNmlsMEhpeFZiNlJkRVUrQzVz?=
 =?utf-8?B?RzlSMEV6YW9Ud29ybWlKTWh1OVFQZ3ZaNHloWjAwMmp4cFBtdW1qVHRtWDQr?=
 =?utf-8?B?UUJJemVuNzJnTWpEWXJHNU1LUmNLWkN6N29rK1Vvd1NTZ3REd3RLcDJ5M282?=
 =?utf-8?B?NnpqaTdQWnJTZmFIc0JpWjFhdjZCdXpCbG82RXV1cGFYK2ZDck5UQUlwZUpW?=
 =?utf-8?B?ZHJnTS92Wjg2d2hwOFZvemF3WEZ3TWlPcHFQdU9ldGtaRXk1QXlHd0RLTHZF?=
 =?utf-8?B?LzYrbHd3WktORHovZTJ3MFNBU2FqNEREeHZxK0RsZU1WRUZ1Tkx5MnlRTGVu?=
 =?utf-8?B?d1A3emxqcnJZRmpmY0djMmJIMmlxck92YnlMR01QR254SktwSXJMakRrb1ls?=
 =?utf-8?B?N1FSSzJ4SUxnQ0pWQk5IVUJ5MUdrdlcvd1AyK2RkaGRzQjFId0ROUkdHbGtU?=
 =?utf-8?B?VXQyUjdXSmpHVDNYYTc2S1p4dnFUL0JJWDd5NnY3UVN5TmliWWk1Z2VJdlNZ?=
 =?utf-8?B?SGpPYTdxRmdHNGpwb3dhcGp2Ukk0dFYrQk4xd0IxSmQyK0lIY25VNTZHMFJL?=
 =?utf-8?B?ekptdHRuUkkyVEw1T1k4SWp5U3cwem8weGFSRU1BRXhHc2I4Uk1kdGNScllQ?=
 =?utf-8?B?NnpFMzNRYUxMeCtXT20vU1dXZVVtSUtLd1R5V29MdG5zYTdOVEJhK05BNi82?=
 =?utf-8?B?L3Z4b1NFczlkNlNRZ1krK3VWalJHYzRJeHZKOW05MGQ5OEJwMjJwdzY1Z2NB?=
 =?utf-8?B?WjNXYzhSRy9MaXo0QzlvODVWSzhhemRKSXN1d0VZUlBuWnJzRm5nVDRFZGNm?=
 =?utf-8?B?Ky9NTTN0eFdCU0FjM0t6WEJ6WXIzZEhUWFc3OGJFWW5KYXBWcVl2OVdYSElS?=
 =?utf-8?B?MklhdE85NWFOd1FsNmxEZ3dqZi91WnVwWUZyQkNlWDFxc0Nvclo5UzZBeVhF?=
 =?utf-8?B?V0ZyaHh5TmlKbGkvRU1YYnFBTERNckl2WW8yR2FidVY3S1pYUFNsYkFDdTlF?=
 =?utf-8?Q?gLxCqZD7Awwq3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e03f61-9ae2-426f-5ae5-08df08cef178
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB4931.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:48:22.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFE8D179BFF



在 2026/8/25 21:05, Vincent Guittot 写道:
> On Mon, 24 Aug 2026 at 15:06, Jianyong Wu <jianyong.wu@outlook.com> wrote:
>>
>> Hi Vincent, Hongyan,
>>
>> Thanks for your comments.
>>
>> My original commit message did not clearly describe the concrete issue
>> being fixed, and its explanation based on frequency invariance was not
>> correct. After looking into this further, I found that the issue I
>> observed has a different cause: the cpuinfo.max_freq fallback added by
>> d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall back to
>> cpuinfo.max_freq").
>>
>> The commit message says:
>>
>>    However, in the absence of arch_scale_freq_ref(), it is reasonable
>>    to assume that cpuinfo.max_freq is the maximum sustainable frequency
>>    for the given cpufreq policy.
>>
>> That assumption does not always hold.
>>
>> On an x86 server using acpi-cpufreq, cpuinfo.max_freq includes the
>> autonomous boost frequency, while policy->max is resolved to the
>> highest selectable _PSS state. With boost enabled and policy->max
>> unchanged at that state, the measured CPU frequency can still exceed
>> policy->max. Thus, policy->max does not represent an effective hardware
>> maximum-frequency cap in this case.
>>
>> Nevertheless, the cpuinfo.max_freq fallback makes
>> cpufreq_update_pressure() calculate positive pressure for every policy,
>> although no effective maximum-frequency restriction has been applied.
>>
>> The underlying issue is that cpuinfo.max_freq is the maximum possible
>> operating frequency and may include an autonomous boost frequency,
>> whereas policy->max may represent the highest selectable _PSS state.
>> Consequently, policy->max < cpuinfo.max_freq does not necessarily mean
>> that the available CPU capacity has been capped.
> 
> IIUC, cpuinfo.max_freq == boost freq and policy->max reflects the
> correct highest frequency reachable by the CPU when boost is disabled
> so the cpufreq_pressure is correct. But your policy->max is not
> updated when boot is enable and doesn't reflect the highest freq
> reachable by the CPU.
> 

Exactly. I think the root cause is that policy->max has different
semantics across cpufreq drivers. On Intel and most AMD machines it is
the maximum attainable frequency, i.e. the boost frequency when boost
is enabled. For acpi-cpufreq, however, policy->max is resolved from the
ACPI _PSS table, which does not contain the boost frequency.

So I think we should give cpufreq_update_pressure() enough information
to decide whether the CPU is really capped. For example, add to struct
cpufreq_policy:

   - boost_freqs_outside_table: the boost frequency is not present in
     the frequency table;
   - table_max: the highest frequency inside the frequency table.

Then the "not capped" case can be detected with:

       if (policy->boost_freqs_outside_table &&
           policy->boost_enabled &&
           policy->max == policy->table_max)
               capped_freq = max_freq;

Once the CPU is known not to be capped, cpufreq_update_pressure() can
use cpuinfo.max_freq as capped_freq instead of policy->max.

WDYT?

Thanks
Jianyong




>>
>>
>> Therefore, this patch checks the wrong condition and is not the right fix. I will drop it.
>>
>> Instead, I am investigating a fix for the reference-frequency fallback
>> in the cpufreq subsystem. One possible approach is to use the highest
>> non-boost frequency-table entry when arch_scale_freq_ref() is
>> unavailable, and only fall back to cpuinfo.max_freq for drivers without
>> such an entry.
>>
>> Does that approach sound reasonable?
>>
>> Thanks
>> Jianyong
>>
>>>
>>

