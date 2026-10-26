Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021184;
	b=0BPRGY/iAPN0ov/kMZmdzAljkO9nplr9wF4xuLMhMQZTjUjAozOp7z7X48VD5nUs408B
	 HRtwDmsz4OgvkWucZEt/h8RHZHzfm5/xq+FNk1P9Q63SrDbsVWVDPmAJgco2JMGAEhc0H
	 4eryvRkyy+dH5MuP/WwXOsnkuenyuqH6cgVelkjJG7eJa3NlA90IXobcpMbmhg8V8dxCR
	 /AdHgog5mj0sVy/uHY71+gtvg5Yu0jQo0z2mIYw/1r3YC7b7KMuNAd4YPZMWfR5Pa/RXb
	 6fR8og+llCa+8XkVMviI9a376rPmhTkO7AapYBpc/rRcKZxWWSF8XwCe2kRBcJAe6JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021184;
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
	bh=J9m+00u04xahbA9yxQ6ajmHpQa/zXAaT/37BtYbFIGQ=;
	b=ehxGOmosjovVN/xiLghnRK5mA1nVXOI/0u21irBS3bYhQsZ1ggSksSIVQBVNFp5y3ueQ
	 wTT2nDGkgk7e0/yb/jm2QemMFwVmFHfHWZbBWlFS1e9GHdQ5NnJ6LoMlfAf7VMWAmwxCw
	 /783PR1zBxTGIiy01l489j7bynfmsMgnIa3Qnt8zPUtmST8Puu5VT45i1mxMw5OGksvrB
	 lPgw0YHbbYBN9CQ1c0C9PW32uv9j8O2rPTO3qi6/qgtXjvDQAEPRK1s46/Wcb6qMT/WUU
	 UWRvp9A5+SDJt57Ixf8ZWYKXy1a61WVGBN02ccCnI5u0gi3OzHUKZ7aLM9cm9toC08Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=g5At5g+I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.23
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1A606A31A;
	Mon, 26 Oct 2026 13:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=g5At5g+I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFNbjm2wM4bniNf64/sMLtifhQf8k0JLV5wmoc3+7XaVYEbloabOQeJM5KFPaqKa7w214Rdq+pFL8c79G1A3Exr5MbxY8KCfSj6t+DaBxIY9+sksXE1/TS9ElfnVZPL5VUgh2XhNDQe+qKRuDOSTlhIJlofbnasu58gwesTKyWix1K0zhW53XNochbrscFLuemjdEBHtDu6+hhPGb3jioIQ0lYfNc8UEThQZ2cI87IAoHQGkkKXy8URJRmRKrMI513D7njbPFM15tRkDE9xS/DCSmu5SamZvEjXwo1QfsTRWVXbBUxUfCI1kAr5Xh5MFyjW+K+nK8yke7lMdOemqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9m+00u04xahbA9yxQ6ajmHpQa/zXAaT/37BtYbFIGQ=;
 b=bCplHahASaYDSUrACTgs08zqJcBIWzLgE4el5u/a5btxitB4en+UrhX6mhRhNhkq+vYPxSgRQhWqjxNHwM1iJsrgo/NgYWuDJUXGlJqzFPR9Hn+J9NCpbM9X0g0y/XiogLrmhIX486R6g8IDqY9v2aGXsYyZfVUBf2Bfqgp8HZt6/JDWeJIw5VZjXSY6t/ldxi+PW3ShrmsEp6zUJ83u97zEap2+71nPKwm9xvILxHbsSMbDiZnwysyA0y6WwdN4GcdWLOGae5sDzv3vShtHX5vxL/Q0i/i3FT7MIjGShVSi1SsDDs3pna+xhFlw7TNlT+F7HjOS0+jlIXgTCAm+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9m+00u04xahbA9yxQ6ajmHpQa/zXAaT/37BtYbFIGQ=;
 b=g5At5g+IKvLkjX16cG02efjyMQwXCz0fUAFHonrLcbUe53qmJQB88Ld3Yx2DxdT0yZeaZoZvWwC94kl8mcr8Kia4RmuPUmo7FLNKF1iwE6RJuzMOTUysG56reXXChF8GdThbboc62caYWIXYhbiHrMFQHBd60ZRQy8Gis0ihmdM=
Received: from DU2P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::8) by
 PA6PR02MB10522.eurprd02.prod.outlook.com (2603:10a6:102:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:26:16 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::91) by DU2P250CA0003.outlook.office365.com
 (2603:10a6:10:231::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:26:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Mon, 26 Oct 2026 13:26:16 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail11w.axis.com (10.20.40.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 26 Oct
 2026 14:26:15 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Sebastian Reichel <sre@kernel.org>, <kernel@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mauro Carvalho
 Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
In-Reply-To: <004fbff3-7fbc-440c-9c44-44585795521c@infradead.org>
References: <cover.1792965060.git.waqar.hameed@axis.com>
	<ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
	<004fbff3-7fbc-440c-9c44-44585795521c@infradead.org>
Date: Mon, 26 Oct 2026 14:26:08 +0100
Message-ID: <pndse1svbin.a.out@axis.com>
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
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail11w.axis.com
 (10.20.40.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|PA6PR02MB10522:EE_
X-MS-Office365-Filtering-Correlation-Id: 7555ef50-b983-4d54-3dea-08df3364b692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261021121427099003|10067099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	8xFdgjcPMHf6Hz68ss6m2wd5OCdeUODhxm8MnWSXFQWoZippV+F/wJihKo+s40IhqH7mEDHTtyoE+WtqhB8mG+iP/7tA96nqurNmBs7hiW66mPma03OeHuR3ChpGHTKTGaJGArW19vLLEv3dMVYsHNadVo2bRMnvxdR2SQLPLfKDrq88CJe/h/Cr4V0XcfEyFxF2mZgdK0JJbtyPx6I6AeqM+W56HVDBx0lLN2kAlBREr2KphtpmH6Pu9DwW/Jxp0HS0EgpuQZ/iaTNSPpYOKvwEOhiBD7DF6Cfzh3qqaZStf/RKyZZ2cMHUj0sLINkoTUCX4is8AJSb08szcp30EJPjawD/mgXOSHH6OHISJDOQwKxjKKglnWGvFyx2fJC9OIx0EFlO1cSNQu3x3v23/0C7mACXq6gGuKP1maByV5ZRLv/MahaQquuyU6I78CJLmZQkgUV0hQh4sTQ5n91xvX6XQI8tBsGVD4qiYZOWWiygCyUIzLl3+zleMUWnkTtiszTF0fmD4V/MDalQgroTQfnlzfleGEXZMG/7EgOs5Ylj4G1V5DbYM1AGVdy6sbfxVeFjfXpx7QsLyJy1e7aJFaNIDj8ekBWkzTGohpNv/CYIP5u9mciQ/vpQsQJy/EZ14rRo+hZzY64EkRYVNekr0w==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y/zKWrrvXMPv54fisGR27FMbLUxcnzQ+x+HI76mLZEGB21sT5hUw66KsXG3u5enA1X39OcuIcuQeIv4st8z2WRAV08yUntrZQ3ILpFZyNfVor02fHH0urMBOK5LsIY7g4lRqHTD2hNLkkD8fDcGhkgvfw/JpoqTI+VrStcrWniXhMy9U1/ZgWFx6dSEpiUtgPnurL3OYXswOXXbX/IB9UYa2oHIgTM5DMwj9eJaupXjPzFprNUB77kwOcGyV3oPB6tbybvpp1otjat3o08D2JDr7TxznJGjUugZqmQRBb6S7EWYDVplccgMNrRQmzWjkcf4rzWQAbcN2yA8WV5FuI72VHDrLzmHBp/MaNxvcYHVsmwnmLmqvIyeXnedHN5qP3pkySs8hlxqnkmERn8XdsZSFlBvaW4YvTbFOcjMWoZ1yeyBe5XZ+SAAkW2XVGqo7
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:26:16.2151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7555ef50-b983-4d54-3dea-08df3364b692
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10522

On Sun, Oct 25, 2026 at 19:39 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/25/26 3:05 PM, Waqar Hameed wrote:
>> `docutils` warns:
>>
>>   Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
>>   Documentation/ABI/testing/sysfs-class-power-rt9471:20: (WARNING/2) Inline
>> emphasis start-string without end-string.
>>
>> Fix this by escaping the `*`.
>
> I'm still seeing this issue after the patch is applied (same for patch 4/7).
> Maybe we are fighting a docutils your-version vs. my-version problem
> or just a moving target.

Hm, that's weird. What output do you actually get? The '*' is escaped
now, so it shouldn't complain...

>
> $ docutils --version
> docutils-3.13 (Docutils 0.23, Python 3.13.16, on linux)

I have

  docutils (Docutils 0.20.1, Python 3.12.3, on linux)

>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
>> index 0a390ee5ac21c..04a771cd23512 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
>> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
>> @@ -1,4 +1,4 @@
>> -What:                /sys/class/power_supply/rt9471-*/sysoff_enable
>> +What:                /sys/class/power_supply/rt9471-\*/sysoff_enable
>>  Date:                Feb 2023
>>  KernelVersion:       6.3
>>  Contact:     ChiYuan Huang <cy_huang@richtek.com>
>> @@ -16,7 +16,7 @@ Description:
>>               - 1: enabled
>>               - 0: disabled
>>
>> -What:                /sys/class/power_supply/rt9471-*/port_detect_enable
>> +What:                /sys/class/power_supply/rt9471-\*/port_detect_enable
>>  Date:                Feb 2023
>>  KernelVersion:       6.3
>>  Contact:     ChiYuan Huang <cy_huang@richtek.com>
