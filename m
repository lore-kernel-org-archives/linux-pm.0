Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022089.outbound.protection.outlook.com [52.101.126.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F9433041;
	Tue, 22 Sep 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067884; cv=fail; b=oMD2THBXDVqZ6rIvTPDBvefy+eqbvJyC4V+oIZ+3NcSXKfZim/3x3PA+o0ZvT0IqV8ZAbhRTWDNYDWld2IZl0FS31C5SV4ZjbNLbNfhnYi2y8mrhtz9vffuEucKbhGB0boZ7xRPuIsneVDTNp4URXn0hxS1CymF5g8f58rxyPYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067884; c=relaxed/simple;
	bh=nuipQ18ruYqVVdyOKvJDGCjlkB/hyBEvcN7zNiO1iJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCPjI+6xZWwGvOliO/a2CTiGiwrWXWzxU/9s7U6cKuKrtWZ5JJrqF22JM9yBJyiDdjoUVpAyxgdz5gg36eTpCUZoWWoDa+c78VgT4/zhwxHDOMTiP3nGrrgmEEhuVECokAn+TT124ccHodc9t4AgUC7D4S8p6sa5FEq9OMUqAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=jx4OcZc/; arc=fail smtp.client-ip=52.101.126.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="jx4OcZc/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svHt8WbYRX70qY5vQ0l8gZsBmlrfu/QgK1qdo9440vEIvyOA5Bm7gVCYREr93zv665UeQDe1YjQ0wVrTA3i6av++8lKpkZbdKHEP0E1PRtHYupDsZ/6fpdtKsgEBSgZCtaLYnOhP24AYex94Vcp7D4f3kiUjmtP7YtyDivvxdGEt5faaH92THhcVvO2Yq3R8Ag8i+Dnso2jYgkMkwtDKNcniAUMY/42cioJ5hseT4Cvs5+dYzgyHS53H0MrwCz2HNmRvRaXZ7pGfW2H5bMVfCB0VGyfR/KOaiFAgUrXNmHsWHO7yXMJ2z1LFN8INaj2bXUlS3UWydueBUhgEywoHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+B7m7pqZOWedWU18BKJtwKhElkQwd1HXt/BH2lprKU=;
 b=kDxNVPVQisnN56bxt0jLkJOdy3b6it4vjvW0zD1RGuFZwAdrdHR2uozpxD16AUdo8UJb0zzLWZNiTqUT6t0p7FlNFQ0gj3i+TZXQlZylXzSlvb3ISgwEX1x8hxMDAv76LbqSTZD6Tl6i+6IeiVIOh2vaujN89qhA8ZBcNx579nj+avPZO7eaVFZBBJiifVetMzCaD4wZ+c3v4XsMZyX2d0WUwKGiEYVnA3thw6JIcxRj+Cr++3kmFG8SBQdM2rAd+pRwX5a39RSdTJR2HIo+eA30/+nhy4fwIXNnYcmst55fh17ecNHn8BiELbsMs+j05U/QaNWx/u7HkYPrzPB8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+B7m7pqZOWedWU18BKJtwKhElkQwd1HXt/BH2lprKU=;
 b=jx4OcZc/NKIlSJ0AlcbK70YisT4Ho9BfFVKfYfClDMVqEFiQDG7VGsy0u9hXpRmsCaKl7aWuonpG/roFb/5d0HNEuo6GNEtJGPHNE55N1cTjtAPsBxuWBTercjUxpDYtO0yCZpFs9xAASSvMHK8CdiM4C0t6Ghw84R1OMh7vqx8YlAKieyAxgR66cd5O49hzPBMoM5Jt2xNSHjwGggl9TxST7tVSiGnsUSBWJde2M1IBU+fBcMq4f+0affd9MWleYzrTDNeUH4InvOBFIPaFUOtiI0DrLlud5VXqPbpOlwfyjilNdh6KNxQuauk32cUQzUBSPIz6PYC0LnHhvZpVAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6416.apcprd03.prod.outlook.com (2603:1096:4:17f::12)
 by TYZPR03MB8689.apcprd03.prod.outlook.com (2603:1096:405:b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:04:39 +0000
Received: from SG2PR03MB6416.apcprd03.prod.outlook.com
 ([fe80::e7e9:94d6:830a:5222]) by SG2PR03MB6416.apcprd03.prod.outlook.com
 ([fe80::e7e9:94d6:830a:5222%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:04:39 +0000
Message-ID: <f52fefa5-1a47-4ed4-8e7a-cfc5fc80d97b@amlogic.com>
Date: Tue, 22 Sep 2026 17:04:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: amlogic: Keep Amlogic A9 ETH domain always on
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Ulf Hansson <ulfh@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com>
 <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
 <CAPx+jO-Fh7RDmHz-YH=odsHxmqYaj=vj4R9iUSSmbSqcRr-p6Q@mail.gmail.com>
From: Qingpeng Yang <qingpeng.yang@amlogic.com>
In-Reply-To: <CAPx+jO-Fh7RDmHz-YH=odsHxmqYaj=vj4R9iUSSmbSqcRr-p6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::19) To SG2PR03MB6416.apcprd03.prod.outlook.com
 (2603:1096:4:17f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6416:EE_|TYZPR03MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 8969d535-a172-4143-1270-08df18888841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|11063799006|4143699003|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P/NH7a6SIXVqj58bgTS9prRKsyOKKEDwBMJQTJ7lBXAhES6fEYm74M9llHbEQvuqWKS6Qq8wSdIpiAa54LyeLhtyo9icgnJg31FPVRKgXzA7a824HePM8MNRoD1wYw9gMkIl/ry6T+3fK04ycbcFSVs6D8z3vykyn539BcJ0PSXJYtMJNSlMN27vVXgd7w4QtCyMX8RnwAgihTC1kQ+li/SVoE+zsLm66rzYcGDFi1Sq3Hd2ovtdUGL35yMfAPM1UAyunLTEP1LWIa9zCeTgYvUDtcClezz5rrPnFSLeJbpx9srbZk0iSaER0CXw5g+cVxfUDm4NH9uU8GkhptiROluoPrX9ucZsGM/EunMxv13fm2K5L3FgR6cye63ovt5suv1UqtXL1zF3ZgM2LFgas3PpTvllxACE4pNbI8DzjlFXNFiUK+5jQU13K83wc/z5LdqDfzlX9w7FzgMhGXFP44eTYLfXSt1z+e0Y4KatuJfuMccneFfZJ7CyVXAdyswuNOSguoOxtyb+51RMQ+uOlHJ9Kyq93xZtZaQnkX9D3pWX/HgBjQZ6NaX8pjztupHd/if6TE7HJngI7zCo4k9VEI5kOFy5X9GDBZ7hcQUfb5oBsuyGnu4a8BGyUx4xuV8YQLJOUbdP8j4OI6HLg4iw9+DYtWFPV7ebozCpZ309WKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDV5S1NuaWVYSzhHRmN1aXJJUlVyWVBuMU9DR0pMUGFGVitDTHRCMFBJZDRr?=
 =?utf-8?B?U0NpL1JNY2FhODEzUTZUQ21PVTVLeVFHZGZCZ1hyV0pSclloTENUczdRM1Zl?=
 =?utf-8?B?WHFvUzV2L0E0WkluaVc5a0owbW1sUlhpMVpzQ0JsdkJEdWVGRFg3WUJ0N1ly?=
 =?utf-8?B?WEZ3Q094UGRKVnBTUDhsNXBuekxxanJjanoxa1VDMWUvZnFNVUpVV0w3TWx3?=
 =?utf-8?B?ZVprMEF4dFZzU0w3SnZXNWNVLzdwMWwzSjlzOW9YL3hyUDQwQkx1SWlFRk82?=
 =?utf-8?B?Q1NhZTdkdXhadHl3SEhOeExXZGJ0anlRVkpnYjF1YVN3QjEyVjN6NXVkSnFh?=
 =?utf-8?B?bGhuM294R2pHclF1N3ZlaUl2L2hqNXlkUFZtUjJqYUhoRERkKy94QjRyMDJn?=
 =?utf-8?B?R1dWR3pEcXMwK2hvc3VMdHZsRU5uczNpa1lJS2tBcXByaU04QnNRdUgzUDUw?=
 =?utf-8?B?UU13ZkdGQlJFR3UyTHZSYU5DUkVzRzYwcm9NR0p6T05TUU9LdWZkU1NPa1hs?=
 =?utf-8?B?L2poa1FtWlFZUlhNVEc1QTljVE9mUERJUnRjQnB6WVRRVGpWSXQ5S0JJTnRY?=
 =?utf-8?B?V0NscStTTmNzclpER25qQ2gwcUhYZWRNNTV1LzhqTUFUQms0ZXRSRUhNYTdl?=
 =?utf-8?B?L0szNE5IQnJWYXNlTHN4NUIwRDlveFVoQWNSZDM0bnJGMm9LbEVOdXV3REJY?=
 =?utf-8?B?dTVXeXZLczl4aEpySEE4U2hhMnd6TGtsUzh6TEFRMUpqVE16U2JUb2xsYnJF?=
 =?utf-8?B?aDE5MnBPTFpOcGp5MEZKVjNDY09WVzc0eDlmNFdYQk02RmtpbDgydjBDbFhp?=
 =?utf-8?B?NUR4WkdtUFBvQ2N4bkFuV2ROMGJzWmVuaGZPdEZMUXdIMEc3UzF2bjhuVnZ0?=
 =?utf-8?B?Q0ZCbUllQ2p2RUxlYWlnK3FFR09LK3JJZXZBZ1NpY2lKZ3ErWlVSTjNhVVFj?=
 =?utf-8?B?Mkxuc2wxL2pSQVJsb3ZWaTk5RWl3OEtlQ1BMbnlMRm9FbDQ3WCs1MGNyT0Jq?=
 =?utf-8?B?cXZ2L01IcWtyZHhtV1EvbUJpMjV3OWl2bGkxNmJidC9YZkNGRldWZnVoUHFT?=
 =?utf-8?B?bjNwMS9pbGFtMGJ5TkgyTkNyOGl3clFrT0NKUGVSbjFkQUN0c0tvKys0VitT?=
 =?utf-8?B?TnNHeXo1T1hnTXhwL2tXeWF1VGR5TkZ5V1EwSFBTaEcxdlBPRkhIcXFKNXBv?=
 =?utf-8?B?MEpjemhzM21Gc0xBc2w5ODZhZ3NPQmRmRUJ3dUp6dGV4SkdWUmVVTGRBRlk3?=
 =?utf-8?B?VnpZWlN2VTNhSXdNOTVBaml1c3hKb01PRHdmbEorZjVMd1FBbldVeFIwUEU3?=
 =?utf-8?B?MG5lU2IvSlJCanArVkhKZytYbG82RkRNR3FENGlEN1d6alV5OWV4U3ZDLzdl?=
 =?utf-8?B?ZWYwZTNiMXloRnJEWlpFT3pBSFdQSDlueTBWV3pWTDEzT012cHpDMG9LRTd6?=
 =?utf-8?B?Tk5ERHVuT2lRS3hpc2hyeVJDUnBVc3BzWFh1YVd0MENDaXovTExqQTV4dUNp?=
 =?utf-8?B?eHNyQ0V0bE9HMzR4ZGV5Rmw1cG15WWYwQ0g2NEpDTmJGV2NGNThUZ2VSRXpm?=
 =?utf-8?B?Si8zUWlMNzRGZHVHT2h4cTR3KzVTTjdMbWoxajBxWkFndzZHQkJWOTJRUUpo?=
 =?utf-8?B?QmpxOWIrTCt4MWZCL3pRckt4ZEd0NjF4aTc0QndaTDRCQjBvSEtSN3pnMzhE?=
 =?utf-8?B?SU5zeDhKdlA2Y0RMRkEzWFVJZU94OXlZeWdPMGlkTDNXY2Q2cXBmRnp2a3da?=
 =?utf-8?B?ckhCb1pOMWpoVkV1Mkp4Z2ZKR1ZBUWdlTWJZWDZkSTIzQXlwY1hzVUExckF6?=
 =?utf-8?B?UVFTNVNUMkpDVEVWTWdEL0wvbnM3aHN5K1Y4bW1kUEo4RVdaUEQveEhBSzVx?=
 =?utf-8?B?ZzhWSjU1R1B6TXdCbHl3UzF1N2dqd3BNb0k4NkJIM2lpUGFxWFkvbWJ5eW9h?=
 =?utf-8?B?dERsbzMrK1kxa3FPc292RHRKNHBUQmVrWTZuUDhyTVpWalkyalRYQ3VLdk52?=
 =?utf-8?B?K2pFUFMwT0JXYS9sVE5LSXIrVDIrZmxLR1cvU0FueHZ4UzRISjVqQW9SZGFY?=
 =?utf-8?B?R2FTa0F1dnBtNFJTQWtvdFYxZURJcjBKR1F6YmVHSmp3UFVFVkNyQS9jSE12?=
 =?utf-8?B?ZXFRL0hLZTE2cEhYbzVDaDZLVjkrcXhyTGtNZmJvdERWTG9rdktUZk41S0o4?=
 =?utf-8?B?QWtHcnoyV3U1b2U0Z2szRjFtNUZHaXlJeC9aL3h3WDlhcVBRTm54WU5tZjBl?=
 =?utf-8?B?SnEwYVJpeXJ0TmMrR1d2VGloQ0FZTEh3Q2FPSFN4QXJ3dWI2cWRTOW5DbGFZ?=
 =?utf-8?B?QS9QV3MxcjQvVmV0OGlFdjBGd0VZMm5LeXc2eEVKalRpeWVlYWJZOTNwV1di?=
 =?utf-8?Q?yWOtxz11tihyEvIY=3D?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8969d535-a172-4143-1270-08df18888841
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:04:39.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apfO3TbtS0lylc3Y335EoSm3RKWKLS6Vgxj1epJGQDRBeA26TByBZliIdjB31ceOLFj8NQvX+j34r7j0fSqmudYcBeKrB4xykZh4ZME3wu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8689

Hi Uffe,
     Thanks for your review.

On 9/15/2026 11:47 PM, Ulf Hansson wrote:
> 
> On Mon, Sep 14, 2026 at 12:40 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> On Mon, Sep 14, 2026 at 10:56 AM Xianwei Zhao via B4 Relay
>> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>>
>>> From: Qingpeng Yang <qingpeng.yang@amlogic.com>
>>>
>>> Mark the A9 ethernet power domain as always-on since it is required
>>> for ethernet online wakeup and must not be powered down.
>> Is "online wakeup" a wake up from suspend?
>> If so: is the Ethernet controller listed with the "wakeup-source" flag
>> in .dts{,i}?
>> I'm wondering if the pmdomain and/or power (wakeup) frameworks in
>> Linux have other ways of managing this case (e.g. only keeping the
>> power domain active if needed).
> 
> We certainly do.
> 
> For in-band wakeup we have GENPD_FLAG_ACTIVE_WAKEUP. If this is set
> for the genpd in question and the device being suspended is configured
> for system wakeup (device_awake_path() returns true), the genpd will
> remain powered on during system suspend, see genpd_finish_suspend().
> 
> In genpd_finish_suspend() we also support out-band wakeups via
> checking device_out_band_wakeup(). Although, I guess that's not the
> case here.

Thanks for pointing out GENPD_FLAG_ACTIVE_WAKEUP and the
genpd_finish_suspend() logic. That is very helpful.

When we do need Ethernet wakeup support later, we will revisit this and
follow the approach you described, including the proper use of
GENPD_FLAG_ACTIVE_WAKEUP and the wakeup-source configuration.

> 
> Kind regards
> Uffe

