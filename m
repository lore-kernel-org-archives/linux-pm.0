Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794833553;
	b=oKj8I5sv3tCj01nusFTNUzrvv27uCpnC95RDDbkJ1pINkmaa28pgLblO4dRX3n2vJW1n
	 nVY131+WxMZZ/FefWzl7mPU3V+Jk3G+RAsHC1DbhYeYR91+yh06rIaI3wI/iO7vGKmDQm
	 qLKYJ3sTqRZqduSnUSFmrKsXbEHZjZVpH0aMSDhXEWWvfyTH2RqTaZSZhhw5ykreWPQgA
	 xiINl5xXkYIlsdtCc1U9yFxc0VgLY8o/oBYx/0liumJPFGKoeRPI8bN9/nLGLu0IJiyQ9
	 PbKXVFRz68ktuAwB/YBE9IJu0dUIHzB/Lw62N1jWbSAJBmyazv63FRiMih7pEgTrmxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833553;
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
	bh=Nhy5WBNfAxG3ia21NF0rEN2ptyouNfeMrK2lG/QiNoE=;
	b=Ah/SXtSqGjT6gUfsqieWnehrbl2vyoOgF83c2DcZUHgzK2IYoNFeUilFpRTdDnxO/r5M
	 Aena0q+BZy0ooZqE/fD+lF0Jg8wDyLLDu0vxkq3TpJ0AjUIK7K+3qX2Z7EMzz8NFPytC6
	 jQo8ElhiQe/+sTj42D/OUINOoQ+WWtBf/qBhiR/CcWAWgI++zUARrqBS2q2iS/TX2xA9H
	 kTIk5lZPjef1J5HrRz7IF4oPy+59bdH+qLYTMFB7yyhy+23q6z8laFuPNb6uLGy1+Sv1a
	 pNuV9yHpz+s2EhsC3R7h0FuSgeV6/HxYlTHfyip/8Rh1dPRSI8ew1sU+alp/hxKYZTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=ii2SMqkK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.24
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC18606A31C;
	Mon, 16 Nov 2026 12:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=ii2SMqkK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3CCl3MKpXlV3wRneOfzbOR8DwBsmDJIsV70lQaxZVm3lYOAgESh3tXbRwD+xJrKSgujqIZ3ySguOV0JMrj+Go0zeR9J90CHkklZlXXstk/u+oH1DbDEK5OGH8e7HqVWUPdJ/iBPWVRVfGV3CmFlmIOq3bVS7r9qBs1R+p0IUYfGdszjg6hwZJYjIEG0f0ApdrHnxKQiAQfl1LHzAZPebwH3L+Q/gP0Efc7DvBLCOCZNMT1FrcMw5E/EaMDfxrdsH2YeYEbrp2cBvxh9v6VZek5XQfBOsFJiMYISrqoOga/jP4aBs3JGWLvEMiETzTldk49+np5fQLruWlP/u35hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhy5WBNfAxG3ia21NF0rEN2ptyouNfeMrK2lG/QiNoE=;
 b=M3MVUN5ulRUr1qvXnsJ0RO+tXIjMx+jZpFCBrxAifKMFAffjjd7WU/KRvbsYUCFx4hok6d6kipE986NJOobXKDvF53DpOH+EknIvaxPtalOLVY6ePzpCuWi6zfSbvbdsb4XgBO50TGfiB7bLRoz89pY3YKc+2wUB2CaH92mBa0OCv7imaVd+rHjG35u8r5CrIX0uLGe2z+ZRinRVWtD1yOldsnmF76iSkaZrH7nD/0S29wWXAKuSJqCJPvM57kG8rm2ZMEXrh6VCIV5ior3bx9FzvwbZPAPC7OnmCIsSMDX8g8jYlpV5z9v19eqgySv+LbCF3OstHpv6zEqebrcrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhy5WBNfAxG3ia21NF0rEN2ptyouNfeMrK2lG/QiNoE=;
 b=ii2SMqkKwAjx1SwJ4YLlKH1RuHr4yIJXpbfOEnuhHPFVihkIwFMApN5bfnrsA1cOx71OWXTPVtdoNrsQ6Kur7FFh2gxVRQCDfFUEeL1uv/mAUyUTNX4JO5vnSBATK5P6fbUBklLd0RD09MH+OdQt8G5WED7FUF6nW1kAfp81thw=
Received: from PA7P264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34b::13)
 by DB9PR02MB6779.eurprd02.prod.outlook.com (2603:10a6:10:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:52:30 +0000
Received: from AM7PEPF00000051.EURPRD83.prod.outlook.com
 (2603:10a6:102:34b:cafe::23) by PA7P264CA0031.outlook.office365.com
 (2603:10a6:102:34b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 12:52:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM7PEPF00000051.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 12:52:29 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 16 Nov
 2026 13:52:29 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Power
 Management" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: rt9467, rt9471: Escape the asterisk in
 ABI documentation
In-Reply-To: <20261116034200.14045-1-bagasdotme@gmail.com>
References: <20261116034200.14045-1-bagasdotme@gmail.com>
Date: Mon, 16 Nov 2026 13:52:29 +0100
Message-ID: <pndld6taqgi.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM7PEPF00000051:EE_|DB9PR02MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 5780370d-be14-4cd9-6b45-08df43e07952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|56012099006|11063799006|260925022911599003|260925021911599003|260925021311599003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	VXV9ooiTl79lxkI2migKE97CXRwyvozCCWNol3I+gx+LDN++5H4ZiAViWGaDggClF8XZ+pJ17REweOYrdyKteDt97lgdRtOiUL/SHoXSmWrk4f6VeMzjcXnAG8t9yDTqEO3Jlik3XlZDJvhpFgrv7u04XmWBUs2RVjtIOXb2dIwI4PWOs8gV8YLnfAm1edrZcTOlQEXNG5uh2pEAnYiTGWQOpDKrNdFYA1OB9zkCBKFiLR0NUx3SH0ls0OG4/nYw36hTwQCO45TZjWDswR0dwCOwAPZMvq0371itPnCP+Egg3whxnaRRPr/nITAdC/fOhPEslKaICUruczEMTycW2SJvHxYvKUgrBJyg5o6V+vmcleJ/2jkTspCKYUQhYYGoy7oZ6XYdw7+6uR7tL/1mtpvgzpoHIzbFNT0S4DrKQvHUGj5FsEA2CAB+OxegO+nBrUPmCOESwP5IluCdwRv/2VUPfR8DUs+sNoAUWvLK4aE5+VwQDJbvSET+HOGRBv/FmWlyAFG86hws+KxzaKjRXqZk+4eLUaevr8aWmDzI+B+6OqZ4kq7w7O8WluhrXUwosLMToUOApwCEMqW6tSLfeD8I6L+SgsFTw4uAysSsHJ6UOq/kSDSSE9M8aO9pnBiNf6yLDXJ+R5oKZxTptVxqBAz54hpO4HG9lGbELg/C1Nw=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vTlKfEjRgso4QjQVkb/AZ/RGlwu6/02zca3fBiqB5ZmX8uDYf8RRc6ihAeqqrUL6OaI8BewAO3Obctm4k5nm6LxzsJriHE3R8tYOtx4jeSkPxcm6wx9wWx8MCX7Of1ch/LyVbdMB5VzM5NBnS92iR/arHIucEuk1j8endwqJcct4C6JOUNIC6ojoza/Ayo5aufBcjegFduajYuExxXU5G+p6IJhYyZo3tTeHvK40Qb4CVJiMEvHV+rdV3HiToOAM61GdgNx07ivuGm0y1CodBOo91iAQ4UQ8WjDJHiho71NOcrlNfF40E1jAycJ1ZhQjoTetW9QOx78JMA4kSHPWjS2CmpQgsGH6i4G8l3A8m3glMNa+jvOPYNNnAEqNX35ydttr6+awaAKbNtCUVMjViVlpx9cmdfxV2m86uHzZ4rMFPJIKV1lQ/zPiWceZCss9
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:52:29.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5780370d-be14-4cd9-6b45-08df43e07952
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000051.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6779

On Mon, Nov 16, 2026 at 10:42 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Sphinx reports docutils warnings:
>
> Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline emphasis start-string without end-string. [docutils]
>
> Fix them by escaping the asterisk in
> /sys/class/power_supply/{rt9467,rt9471}/load_switch.
>
> Fixes: 3f21de6784a654 ("power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH")
> Fixes: cb012fe405f0f4 ("power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

These have already been fixed :) [1]

[1] https://lore.kernel.org/lkml/cover.1793225920.git.waqar.hameed@axis.com/
