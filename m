Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793102298;
	b=l+7UNHFh7ns2p5HGcew4t4iZQ8bC8TPGuiDJ3WJsFxn03nxhBiPortoGa7QwmAAGYMKH
	 sf1fl9uwq84cIlompe27BFSJeMgzMnyHkgYskesAoyo1HgqkS/W3ikbtfbqblzXB9mRrx
	 rCK+1NXW5jpGSxdwEu7uzWgwbxJXFe56SjzsrGLmKHWxe/J+IPcwIIUG2IEp2BpAIyH8G
	 ukIOoZ4I+PNriSnG2/YGim6p0orhrkBUngT+NIDn9l767MXgVacgaqrwtA6AoAwBA3euL
	 Obu4acKhm7lqWd4A6m2FbBYpbFe5U2W77BT8XpyQQElyUW33k2HSgAWcwc+W5PbH2rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102298;
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
	bh=8jv+iuLmVZLdEDtuJdsTqwP8MQYAl01dxwp+GPm/Prw=;
	b=yVksxo9Bluirvr8fqUlg11mnPGW9DvA0QW+mA+Xmq//otgebom2L4bHtwbcU6gwa/u/2
	 jwQhW1yH5KCFcOuQCTFIG9FiqpPkDCc8EEvN+aes6MNsz2PjB4SHEWJQvBYCkQzqR3SxT
	 HyX4VjslVSgsgeePRp66O10ThuOnGIi1stwZPWCk5GRxMms+5FQKi7uJ1WIOtR19shMBu
	 hpCRyniYsuukQNNlOEBam3FVTeuzMxV9n37ICwNG6paeq0bXRdm7uYgEqjYL3n729pDYY
	 Sl/oBo1Cy7DRXZlR+Pd7e1eUIXTD9HfXpyxNo15dnS+l7/M4t8xl8b6cocYHS4Vu60Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=VlEkhCnK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FE606A31E;
	Tue, 27 Oct 2026 11:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E56FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=VlEkhCnK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B20iOMzkI0lTltXr/moSMDYY+Z5injfLSq7eEtc0Ge7fV0xO+QRAGx1miNyNST4XSe053oiSE+epUp/E7TM1Y6g4w91++pzAqGC9k51VhcxrKQAhE2ILM2SoZf4ztizxJFX3Oth6mrGEDO4qLfFfqKnKT87+F2axYA1w+joaZbO2DSLD9dMEEGUvL/5SX+z6TWx/QpuZkjF3c4nBs2IzEoXJVpGYn3m7qy56c33+IAtcXmhH73fZhN4xtTmdD686/1xG61oxNchR/nWUpXh1tlxhCz1lw+2jC7Lgnqpao6XhBUlzaQdvjAQvf8oSw/FudtH3ml6DBCnXsfIoLch+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jv+iuLmVZLdEDtuJdsTqwP8MQYAl01dxwp+GPm/Prw=;
 b=NtmMm2KSpH3DGceSaCFdsXMeGVcG3D2Gn+gJWm4R0hcNiVu0JqlEdZ4GyJ7EgtCw2W2MA6wjdKNmvMi6pb4r6UIs/M4+mqIyE9P99mQseBjw0RvOf1us2Xc0DdBADKbcDy8JeVZRxq66FONwu7CSuyWTU1gvdksgaMKUro/c8Zb31bmm72lCTbHMVbO6wYDis8gRVvPogJx4nKIbRO3ppU8Wy+jJWe8RN0Wapu7QLPz0ZhYCC+8/3so2emHb1sDL/LBLZSmtehTHve8Mg/NFbAbdH+qIH52eWGRaDlADAKEaYzHqIMjG5GixmSipdS3+ocNzg8T7DbMRgiBsBuT/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jv+iuLmVZLdEDtuJdsTqwP8MQYAl01dxwp+GPm/Prw=;
 b=VlEkhCnKBSJksNQjl0bm8RmXFwEM8XIyAsldP8v32z2temh9CeKYOS5u/3dACp0VCkmhDXVZy0cp+V2t/W9oqCS7neqQUnt29mWQGfWrwwbgNNBNgS7GcvXPfPFGEbxositXCCZqJQz8GG8todu4x7n5J9S/6pLNEzad97Fzb2M=
Received: from AS9PR06CA0609.eurprd06.prod.outlook.com (2603:10a6:20b:46e::9)
 by GV1PR02MB8657.eurprd02.prod.outlook.com (2603:10a6:150:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 11:58:09 +0000
Received: from AM2PEPF00070CF6.eurprd02.prod.outlook.com
 (2603:10a6:20b:46e:cafe::8a) by AS9PR06CA0609.outlook.office365.com
 (2603:10a6:20b:46e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 11:58:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF00070CF6.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 11:58:08 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 27 Oct
 2026 12:58:07 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Sebastian Reichel <sre@kernel.org>, <kernel@axis.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mauro Carvalho
 Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
In-Reply-To: <4ab3e196-0326-48d9-bfdb-ede2f8cfac64@infradead.org>
References: <cover.1792965060.git.waqar.hameed@axis.com>
	<ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
	<004fbff3-7fbc-440c-9c44-44585795521c@infradead.org>
	<pndse1svbin.a.out@axis.com>
	<4ab3e196-0326-48d9-bfdb-ede2f8cfac64@infradead.org>
Date: Tue, 27 Oct 2026 12:58:07 +0100
Message-ID: <pndo6cftkxc.a.out@axis.com>
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
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF6:EE_|GV1PR02MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5504b7ce-f347-4cf6-b8a7-08df34219171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|10067099003|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rq1Cny+UMaYXRI5pvVULT6Aj47yoFqHWci+ImTbf9H8Ikq/ttsjnovv0qzscvgIAxerO+ZxvA9whkzqf0ANS+DaXc5JJ5q/RIe0v7HGapZs6672juVakmHh4XredOAI7FgJiSkFNxKFkv36bgf4mLLQeKNIUOjfUUW3Bh7Ut/R9MRUFHXcUqTBwtZGCrDE+vqVTWBdp+ih4WcbCNVc8emNbkGZKcCqbQ/36khED1GZqCqQ1nWN+79Kf0GMB9j39oCg4DRrp1BeW2sePVYKYIyh+UQ7V5bpAbbG/pKgLN9QRDDi6JzWOwFYkoMtLsev4+iUx1Gu3Vc6qAomAbVW57/KETLTj+fieR/QDIvmq/DFWQLGsiNaFBIp4ca+weRDNG+u5LjT5HoxaTBdaiW3UXWXm9akaWNkqhycn3MXSpMksyihhfdqZzzjY/kIBsuh79P923/WEnMwFWNoE7XF/GGoa0SWaTJtw96TYX3uNl5yK4XbrX/tKNbPM1NtW509XjkVuqlPZED+ER+oFDhyVwtN1mq82s/3RA9geiMPDLwtuWI4g7Z0XusAH4mXSb+47oNY8aZRQm3ohZsJUB8kFszaxJNN5/iyKK9UqDCFfwL5bBqa7pS34VCnllX26XCkyxkwMBf2G3TmZ9gPO4Qe7Ie+hLpH0IIA1m3GjVdKWgpDfMfU/yvW3bK17BNDaNhWqotlzkmVtJdwToNB2EjQo5oQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvleGPCp9Y4qARWmOER3gYuzGzXLTAKSX9NJhnm874G0XMFCn3SnCE/HczXZDZBp2JKwJiQboDKtwFMzzgvCKORkMzA1sbktee/bipn5Xe7321BLFIKr8gesslW+/R6iS9Pva7QBV8xbs+7obikv58iYLYjtCm1musLchi2iuElziU2XUlvCjqnY1cK2/0aIQXB+tty6fn9hyYSTHtI3cQtEf2JtymqyxYXMre9Yb65aI+36zLSedH+5TtWvYiJSl4h884qt9nHe5COOfdjfWkgBo4FWaQRboYBEpxHrEVjwTH1NCNF//LexuQsIbg7HgON472E2HZb8AudTVgzvy+fEh+/WYSVNyYVmj57kF1GjiR/ST5fa4p1+EU4JqA7I6isAzY5A696Y5qtYkFkLjuZEpE+bJK0X+A3c5elmeENE5R1Xj+tvr6IcBPZRcnOJ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:58:08.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5504b7ce-f347-4cf6-b8a7-08df34219171
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8657

On Mon, Oct 26, 2026 at 13:13 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/26/26 6:26 AM, Waqar Hameed wrote:
>> On Sun, Oct 25, 2026 at 19:39 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> On 10/25/26 3:05 PM, Waqar Hameed wrote:
>>>> `docutils` warns:
>>>>
>>>>   Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
>>>>   Documentation/ABI/testing/sysfs-class-power-rt9471:20: (WARNING/2) Inline
>>>> emphasis start-string without end-string.
>>>>
>>>> Fix this by escaping the `*`.
>>>
>>> I'm still seeing this issue after the patch is applied (same for patch 4/7).
>>> Maybe we are fighting a docutils your-version vs. my-version problem
>>> or just a moving target.
>>
>> Hm, that's weird. What output do you actually get? The '*' is escaped
>> now, so it shouldn't complain...
>>
>
> docutils still complains:
>
> Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline emphasis start-string without end-string. [docutils]
>
> and running the command that Mauro provided:
> $ ./tools/docs/get_abi.py -D Documentation/ABI/testing/ rest --enable-lineno|grep -A20 rt9467
>
> gives me:
> .. LINENO Documentation/ABI/testing/sysfs-class-power-rt9467#1
>
> .. _abi_sys_class_power_supply_rt9467_sysoff_enable:
>
> +------------------------------------------------------------+
> | **\/sys\/class\/power_supply\/rt9467\-\\*\/sysoff_enable** |
> +------------------------------------------------------------+
>
> Defined on file :ref:`sysfs-class-power-rt9467 <abi_file_testing_sysfs_class_pow
> er_rt9467>`
>
> This entry allows enabling the sysoff mode of rt9467 charger
> devices.
> If enabled and the input is removed, the internal battery FET
> is turned off to reduce the leakage from the BAT pin. See
> device datasheet for details. It's commonly used when the
> product enter shipping stage. After entering shipping mode,
> only 'VBUS' or 'Power key' pressed can make it leave this mode.
> 'Disable' also can help to leave it, but it's more like to
> abort the action before the device really enter shipping mode.
>
> Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
> ---
>
> Aha. It's the line above that now needs to have the '*' character
> escaped. I have no warnings after that is done.

Ah, linux-next just got updated (merged) with the changes from
Sebastian's tree. I'll rebase the series and of course fix this one as
well!
