Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793623571;
	b=Qi09zqxbIHUdAiTrqcwL/LcYTqGMKnEGXTF8qcGC20OUGSF4Zdfw7UD9VFXfNXc6uQGX
	 9cMIlDY/CP5bww9ojWxdwLZ/WlF1tJRlu0JTE9vAxVARTGfIObsOHFIUldpTiCgE/TLDV
	 ZHiE/mhEs9F5UyUxSxdZfOSlQOEHWCTM5pIv5cXL4nAwRKIDXisLE3hdmTtpdN4EpPGpM
	 PwWiip40geeGUNFtRL6YAeszbsO2UpUZq5SRItxTfgaM4R625XnYp7gguKtULwF/Pgm/4
	 jl/ePDSyf36jpy/73YCLhjh9TDGBi3hiWlUz4tjvvaNkBaOR1+HNgFfUyO58mF4Ud+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623571;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2suKidbgkKLYRyzBagdPxImQixz+ZTXOKaYFPTNOe0I=;
	b=luJuv5ZZvm6VmS9fvfGDA5MhJihAoz7UuS4jGSZvMiaWwKTtEGQqa5j7ZNoL9wP+llkb
	 7tbrv8+WtNgn+AZrnxeOTTq1W9MuwS1LXTRzFcaIODS4wbUvuPJrG9uZN5a9dlJ5MABwi
	 Jkeh51CZT+4Zul+SE8Sz4XOb/iPkeSfr0gaxY5WER0TR4vD3GHiIAffurBN9oCXMH4bqy
	 qzB6XkvBVxCtAm77WlSwb0NhEzMhw5W65iebxXYU4jatfOr4BbXrqZLrvehUEZFG7eWYd
	 iqsYfeDmraVLPIpbpsxrsdp/kBLQGkW7gZ9ymuJGwRJS3HEM1utdOVcflBUixPMGGSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=lOUlIxF0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.62
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AD606A326;
	Mon,  2 Nov 2026 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=lOUlIxF0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZxO8em5zOAm7jzhwb62mh8au7jJ8GdxL0H2qRywkGj1Gs56KkNTceCks+2tKtWG7PdaX54m19YWn/uzn3S9Uz9wDbAYZhtV8HLez1EmDOPncK8pl6GBI6LiufnBvAd2KqOLCu9Bx5TC6FjJOytT87YVsFPR/ySz79RUFR6qumc17J345QVbrEa7d7qzeXRIR7TsL8EAqSHozZDg0SPYdNa7NEqC2Z1YkXYQAxiG1UuZqozsUeilDFY60bSRJ7uNzY/661j0nlSNHJvmY1B4qHZcvLAxXCz6pzfGO+QLXv7oxFnxVCInvpm6tVHh+gEtRSebmtA8yT+3HV1OvSgwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2suKidbgkKLYRyzBagdPxImQixz+ZTXOKaYFPTNOe0I=;
 b=nto3CLfY7udfnu33ldRDWL8MUjBnUyzdRZ9nqbOhM0GpV9rzgrvpd7znAq2Rl75pJXY7PZwECdelmodpTqLZ8UZrJ5G+waXKXdPDMGGVKHeBi7ckiGPaYId8Rk84hsU6rHfi6hvc7Oji2Oynt29ssrf9hQyv8QkxLpCdiVv4Z/sPI/FJS1nvXUmMpzyioJV3arDr5JNMYJaxd4Sw/a89IJ9CKyAL1VR/I8VPBrQnx4HdVeNZCiOxJcbg5zBI4AZuv/0TJXeK3+fHqp8EUGrQiqTpAbiIHH1Jh0Ydi3bcCLuOtPGXbQ2ZLnnYBb8r/FsqS5h8+6FIiqBU036caC0w8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2suKidbgkKLYRyzBagdPxImQixz+ZTXOKaYFPTNOe0I=;
 b=lOUlIxF0oQMQUMXuUUP+cQ4g2OzaRk85/GZxCWgJ9+1L1V1f06TGBYqXkyubZOlBNkExxfIQMnJQnd492LzvFv+x4uaeT10aPIPeZrzD6bFu99rqfmD8wstyjfsbGH2RLBnyL3hRpk7R/IXagMQg3Oo5zMeFxhec2n+zNOMluGw=
Received: from OL1P279CA0024.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::11)
 by BR0PR02MB101064.eurprd02.prod.outlook.com (2603:10a6:2c8:52::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:46:05 +0000
Received: from CPH1EPF00000523.eurprd05.prod.outlook.com
 (2603:10a6:e10:13:cafe::2a) by OL1P279CA0024.outlook.office365.com
 (2603:10a6:e10:13::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:46:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000523.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:46:05 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 2 Nov
 2026 13:46:04 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] docs: ABI: power: rt9467: Fix invalid inline
 emphasis
In-Reply-To: <62a1b6df-88cf-49be-9664-4db8ec2e03f7@infradead.org>
References: <cover.1793225920.git.waqar.hameed@axis.com>
	<11c2308c9bbd739d3e72f0a2fc614232a5ecd6fb.1793225920.git.waqar.hameed@axis.com>
	<62a1b6df-88cf-49be-9664-4db8ec2e03f7@infradead.org>
Date: Mon, 2 Nov 2026 13:46:04 +0100
Message-ID: <pnd4idzo0z7.a.out@axis.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000523:EE_|BR0PR02MB101064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccb53a3-f1ec-49ec-f7e7-08df38df4297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|4143699003|56012099006|261028144727099003|261009223027099003|261022105027099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mKaNvXpeGKqKnidYBF75BC2KnG1eLLOly5Y2J6MnyKQLgtgxt44rZVhRSgtUVKlHwsPTWHkFq+nCH1ULHl5B3xFTzrNyAIl08waiSM0A+XcGWLfw0hS9DC13Cqg3o8X8NnPD8fzSPTBhawQPEk0etnMFNw/OLCe5i0YAu1ii9l/r8jJxerAhtwffcKJZ9MgtAPb+fr0e8XXPt2a6lmny32jW4PvybpjRMk0YMAEYbwtjrTqB5ZGdZOL7NGmM5hpnkzFpuArPIKHdj9qINIecsUMAjSfanEyP8mwD3FLWwIusRoNlkWDViArSk61qCgMmeyYdd8pvniuCHktOwWoOoAY1HYEysOeWWXnTHISnZ7V3t0gZM2fHe0E3y1M7jRhPHQw3fvQy/r+Qh0OmWSMwslFtwrvsfp2O4cHgIwukjDx7R/sjb1i4GDh8OSJ2Bt05aU7qbqmpmDidAIXcstcuPGq/+4pGlXovaKroLB7+6Mp4dAKb7zx7tlYMrN0eymz5Ry1sC6iNBjthA5jU0fVTPSci+6JHjMRoBwUTxlb3tqEwITEP38JlI3gKmxHZ8vXit1bppQ5I06DvYI7PLqgoEwPOSdhzmZ/vVSyQrkYascjTiAxJTi4Hm1ftljON2ZA6uoi8ryLWQ7lXSCQCF710vw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(4143699003)(56012099006)(261028144727099003)(261009223027099003)(261022105027099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B9AfpMFFpPjMBDuyo4aGO4zTTXq9CxtnLagolEq1U7kqtBlns+JXfXrF/HoM3JbjyzyjZ+XAVefmp1YOkhYDsRCZUkUlY+rDkxaWgmH+y9fm1Jdk9rhRYdF3SqEyju7crgEScyW/FZQBXMip/oWt/BgMnwFMsevB1NkS/vFrDml7nqm2wxIyN3b9Web0D+d5fXinG3ODuXD8kTqV0ZUVLFhfm3RFKtWMFzFHiqshoM6J5KLdt7grtEZOE9j6iV2W3WY5yngyfvXsr+SPVUm/xkFbwFZaooXgcL4nDO0IHKbKSLNIst2x/0UbrYZKgf+TuZGCq65RsGax+YMTNMtr5ajEndNN2ROZV7YqQ5hHP8tPlgy46BeAjUMQ/If9qtOIPXdxAy6uhBI3Hrfhy3W0xL9yWlmfmFPbAmmBxVM5qA4t7XToV5D9nEoMek2qntxI
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:46:05.5839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccb53a3-f1ec-49ec-f7e7-08df38df4297
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000523.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR02MB101064

On Thu, Oct 29, 2026 at 09:06 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/28/26 3:39 PM, Waqar Hameed wrote:
>> `docutils` warns:
>> 
>>   Documentation/ABI/testing/sysfs-class-power-rt9467:1: (WARNING/2) Inline emphasis start-string without end-string.
>>   Documentation/ABI/testing/sysfs-class-power-rt9471:16: (WARNING/2) Inline emphasis start-string without end-string.
>
> rt9471 above! :)

Good catch! Copy-paste mistake...

I'm thinking Sebastian could just amend this when picking
this up? Will wait for him before doing anything.

>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>> 
>> Fix this by escaping the `*`.
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-power-rt9467 | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
>> index bfbfd78ec1c19..bfb9c0f478e45 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power-rt9467
>> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
>> @@ -1,4 +1,4 @@
>> -What:		/sys/class/power_supply/rt9467-*/sysoff_enable
>> +What:		/sys/class/power_supply/rt9467-\*/sysoff_enable
>>  Date:		Feb 2023
>>  KernelVersion:	6.3
>>  Contact:	ChiaEn Wu <chiaen_wu@richtek.com>
>> @@ -13,7 +13,7 @@ Description:
>>  		'Disable' also can help to leave it, but it's more like to
>>  		abort the action before the device really enter shipping mode.
>>  
>> -		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
>> +		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
>>  
>>  		Access: Read, Write
>>  		Valid values:
