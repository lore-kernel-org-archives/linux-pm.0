Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6846983B;
	Thu, 30 Jul 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439378; cv=fail; b=lev7xHAo5IzVxdSRxtYKYwu60l+lUi/hNBCUqB/52dB6WDYnnk5z2Ydej4pieuAEByqgLJ5DjgSXtGXp7U3YnPLm0j8cdlOcw4mdvjJYuQiX/XuZ55+aT9Q5V/F9ymbnCI4zITC8GE3zUt5SfkXd09lROxUrF3OXfq8MUNyeZS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439378; c=relaxed/simple;
	bh=JedwyFlIz0jsIQOTYBg2XjH9TULgEJPusrd9BSmKgeY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxWxQWr6fMWZOsB79dQv880TDawLGJZVhoJ+64aOGpkXstyW3/mGar05I1tMbMkrEKKquKZWXT1V4sR+U2kVq3rCRRDSjQA0Yim16MbtGvetNz+X6ZtiAlnV6e5oSgO5Gkgz1p2GDfgfoZeGCzHXr8hUzaU0qmHO6tkS/oWAnqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=UbwIUfJj; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UbwIUfJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ntpWiLZhZqP1GvzKMvceOeShefY1ug508b667xUxSsYI56cScJHCYnFe68kB6sZ/+MJ+ID6519oOjcbKrXTIjxNDDP6UkpRQ2Q9tctjnn0e0Mv5+efZWsCCHMTxpnHwccbc+jFhTyJqZsXgdgObUhQMh1dF5HhZeURqFVIxhIdfYGia1ogr7OTpCycZA22bVh4aZU2eH7+RSWPl3wiuw1jPssTgBkZco38ms0lGsbtKMpGVWFF6HBvzF470/NXRurdic3M0nvVYwvuS160nNOj/aC5EpncdCk1J/wmJ/2E7DhFrrMpjsS+KOqyEXdfx4tudjTH9ckJjGwWKJd2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JedwyFlIz0jsIQOTYBg2XjH9TULgEJPusrd9BSmKgeY=;
 b=YlgaY9SLjBhW7WJUDv1L6eNBo/3swl2jevwfDP6/xK4XlJI2g3UTuCF4CF7m2SALm2oorcnc7aaI539as5D0UdcYS4izH6jepxG02af6CyLIDcTSWB9TxW7W0aCTngWTX/4ti7vxpBLQvfPVY4o3jIibXJi8/hAj1S4Df7LvkgSzbqcPpAU7dmyCd4DvoahLGHukkZ2OZFbXmxl+27JRMVrB246SyR+dAptEP/GYMFXVS/HA+Xnj9lSiCtu7HtTDX/4QOGHG/f3mIC1U1sJQCFqs1DcV7L8soZGaCA0acEkeivKY96MvgYy++1wc0sQrUYnC7sJUMGLSVU5o9dcmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JedwyFlIz0jsIQOTYBg2XjH9TULgEJPusrd9BSmKgeY=;
 b=UbwIUfJjUKrG/ThvUgTckeh8pXv0IPxh+/pkDqV4Pm2b1KZSyGBAeXQU9NX9YdBK9uPHIRMpU13wkq8v9qRtJp4KHJxEXNZCK2AK1TWCOjtUTJ2+dPB+LJGo/mRTq7JHm5dzweXGMBkRPTErrngRjLzHrDvvBSPUTjn5YxMATIk=
Received: from AS4P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::8)
 by PA1PR02MB11355.eurprd02.prod.outlook.com (2603:10a6:102:4f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:22:37 +0000
Received: from AMS1EPF00000090.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::a2) by AS4P251CA0002.outlook.office365.com
 (2603:10a6:20b:5d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 19:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000090.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 19:22:37 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 30 Jul
 2026 21:22:36 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linmao Li <lilinmao@kylinos.cn>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: bq25630: Scope battery
 information to bq25630_setup()
In-Reply-To: <20260730011713.3332913-2-lilinmao@kylinos.cn> (Linmao Li's
	message of "Thu, 30 Jul 2026 09:17:12 +0800")
References: <20260730011713.3332913-1-lilinmao@kylinos.cn>
	<20260730011713.3332913-2-lilinmao@kylinos.cn>
User-Agent: a.out
Date: Thu, 30 Jul 2026 21:22:36 +0200
Message-ID: <pndbjbouvsz.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000090:EE_|PA1PR02MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: a73c10dd-121c-483d-b305-08deee6fea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EWbHYwTT2kM1Z3/76umy0O6LShdstax2uBJHTYQi9zjdiTIyaiZM3VnZrBW7IwMRfRQZGT7wGf8CzET+ZOP9z2EpQqU1TTC9UDozgxwr27mZmB+G+fvEGCUUORdI1Jr0BAF4z6zBE41VVT0i5lHTCJMKAaDgyrsequufEBOa8A+xeeS8M6sZ1vN4cNcYp0WC0kUPi8Vlfdad14XVwM5GpsnaxSJkz1DwGxq18VwZGSYJi84ukrDhil6wb49aP0ZztLD7j5OzjVWuWJpISUrdfiKfYcyBDLSWpY1Vd9lBYjK91nWf9HC5HJcsyMjr8pu5JhiW0nL6di5RTGyPQig14cYGxS1fu8e43JB0BcqCFdF9/CiQNNurovZthQdrTtChKBEuvnMJyRDCPmP2wVHDhmpiZN3GUYhJiVNqcY8zYx8HALHGaLZPH3nyb9AJ0qFu2p74YL/xlYIXgv2r4/ciqYhriykxY3ahKC6UZ1xPw/acNeC7ZMUXjEB6rcYXGnx9Nlcv8L4cF4HtmYRoOusBxJnZw4z7rq14gDjrnh+yMSD/0cSQAMLlKhdkgHvqT0Sw0OtmaHmdxQJYSPNimFpNfGsCk390f4o0yCvjd1qjQ5qndSymuzqwB1loP3Y4V49ymq2vRBnMjaWTMTMXUQH51Ts2z2Zgth0LEYK1OZDSaTo1hHXqX300XPCHNibFyD6e+47PiHfe5KPMESh68kYQlg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	269+12DxAjX0c62IqaKtv4S3fYsEjnZjWmUIRlbLp2EgiAvlWO3vgJsJmson9Vw7WwcsJuUOyRpU/EY8hqHPhp0lfXpjeAkkxRl9fYe+v8nhMdipSaMRjvC+B+4KDwx27/Ck/2/0Wz59ps+ECoH6CL/ap7HRUZyV74v7oas9b3ZSnocU1UYiUh1yuxc0ZkhEgeJG08kUsHKgpgFlM07znMGbxf5R6S2hXFzOLsBsl14YXDOM2K/n1pxieEQ5QXVnc/j9dwW1fxf34d6yuv9IEHn1OoR5IsbkljaNeiNnrj3YAP+XsdhYlaTLLhfTRiJWrBA+IQQ748e714IuhfFfsgSzCT3KXSoOAKRR+BDwcJ4V0WWdlPh24NnhORKS+Qx6eH2IcaNCHC8Vkhs7FwgOrjHhN9XfezC7sRu5KTNGSSS3a2LCIqD/xCrhhNspRfgT
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:22:37.2492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c10dd-121c-483d-b305-08deee6fea4c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11355

On Thu, Jul 30, 2026 at 09:17 +0800 Linmao Li <lilinmao@kylinos.cn> wrote:

> data->batinfo is only used by bq25630_setup() to program the initial
> charge limits, but power_supply_get_battery_info() allocates it on
> psy->dev, so it stays around for the lifetime of the device. Nothing
> else in the driver uses it.
>
> Get the battery information in bq25630_setup(), just before it is read,
> and release it on every path out of that function. The driver data no
> longer has to carry the pointer.
>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Looks good, thanks!

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

[...]

