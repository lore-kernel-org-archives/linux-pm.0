Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFD3FE372;
	Mon, 11 May 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510108; cv=fail; b=lFkdH99i/4E8cpaI2YGOagl7dVUXvVLKeRTbvrocW1ppgA6RI8cL2lfjaReWyYkhj2YjSrp073C9gPzqmkohiJHkGLm+qK8zNL6u8+fEqIeNmFd2/WFKk7EQupgAyz68clUqhcLuMBZJUqvrxtnIVcYdNKsjY7SW0KFm82vO454=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510108; c=relaxed/simple;
	bh=dOEMTR1Z+AZu1Y/Ypz6Qf8NqAvgVSpK7JhH1l4OHa3o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jPi5O087NhmO0ZhXWBA0d8z4nT+J/ySWCVNTk+keMUBxFRv2nd4NYZt2tPcfS3MKyhL2tSNjqIoNdKp+PBvxvCePqjzkN78I1WbNXJc8Q4hH5/57S/cbxg0JC7uzTJdkX2DquGw2nR3Ti0oHuPb9dU3zUhLudd6xmlspOpAIFzU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ahPXYCa1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ahPXYCa1; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ahPXYCa1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ahPXYCa1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GmEDETgSZIVdtPLeSIcfQUHbyaIa/xBjSkdiJ6tAaHFUpCvhXonv3x6Gc+E95vhAjkxhjTqyTF5OUX/IsoJPbBVbGzlW7OM0UrIgEP5zj+ouR0GDWClxjetd1vTgHrgWOT2v44sF5dzi8RlhpHuj1f5FRir5LGbMEJN4Pi5m69L/CpA6QCXzqxOltzfBh6EjLQMX6BDtMJ2O/LY/ymocOm1Chx0pgKDJUIJZAYCQv2eb5ceBLPXErbAhw8RVYYB+V9uytnVUIxHNgYGq7tgPSBWWsvmXWp4rEHVTGrbUba6SejQNMKDIVQ5aH3v2x5PjoofmymeAWm0qhJr44/12mw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFy0+HPzMNUsbGb5/95WI9ZX2cK5wNRlh8RV8I8YeIo=;
 b=NaN7G+SEbdk13oH2RkjlToffCaFBK5WvLlL9UcNGHK2xgDzzstsYlCrKILILnVD/wCYMk+2745FMzB1q3a/cgeoeZ4nfMHu3OOZBhFuotMOjEmCGrZUUAVLYdv1pyh3PezVPWuPZB9m1QJ8bF4Hms6mPhkXQ/2x7pl11GMauCwU7iByq4ykcW/3YIl3jVv91k+U0ZkYi02Bzwm2cF3ykrTdKWBBLBrGTDXXmwkAmo3k733/gPfB9tRqH8RLy6lRHNTysyDHzDZ4BhXuGdHNsQu8F32x4pmeMoBzADbiYRX477B49eAMVei78iy/C5V0a8ICN0LReECvkrO/yaquafg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFy0+HPzMNUsbGb5/95WI9ZX2cK5wNRlh8RV8I8YeIo=;
 b=ahPXYCa1g4VOg4bWBRRFlQSahT0vdg+OOjM6F4EZNNmNdy347VTpRFJfGr64oxEdi9I076OKyv/+TU+Ivw/ZWGjdMerX6FMe6dQtSwrrNypMyaLArCBS3Lu1vYKHcL3Slo5yrLNL/AQgL1alayErm8snixvhF/k137PGI756lWE=
Received: from AS4P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::9)
 by PAVPR08MB9282.eurprd08.prod.outlook.com (2603:10a6:102:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 14:35:01 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::61) by AS4P191CA0019.outlook.office365.com
 (2603:10a6:20b:5d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 14:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.3 via
 Frontend Transport; Mon, 11 May 2026 14:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2Bgzy6WbwBYlQL0r85pmz2m9o0nAnxJBxdfueK4s525oBxEjvb69EnmyogDiEztctHvha2vBP3TGyjm1aK/K8HXkFbYZac54F5LWwJtw56+TmezKAfeRPPV/TkxYA1/FAavV874YCUdmqUHUpkr1g9TploF9Zy+z2XBCPEVCG+RRIDWb3JitW65HLa1IlGC9I8Lu52x+4sqDwiiMcGiBIBMDXYgeEEaNniISJeZwZFwseMGhAZYnpwv1akcG3A4fIm6KNV5Gg4pLYaJOcjI2nJjcr5SSm4YcJlP/ltJZNE0AiakkIHPGlXniZnCIIo7IohIfPu8InvI7xan7PYyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFy0+HPzMNUsbGb5/95WI9ZX2cK5wNRlh8RV8I8YeIo=;
 b=Rja6skJ21+QxczFXKYv8zk0EwCs24/6bJdwJkq0kdAI8dMyhm9rfF0at7WWr4Ts49y2xkrk+Buf8w8piqKErTly+1s7zguYsmu7a73W15zrQgV/wXNAUUrD1AFtaduekI3QQmN2SxE2qTZF1Fjedy6s8wAalNscJ5Zck0EmU6BJWHILhaO4lSagW/zbM9IZd3l+DavHm3cG3hhKw8ICHwE41IQepsRgTQQq5fuxo9fdWx5A8mxZPcL+ESULTr/VUmdaTdpNn43qvp+KX/3FiCHqJIhsjdxwAp+T7M9azqh3BgcCNHAk0TIzcy361+1cZd30pLN4ImpRlxRKaxl9/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFy0+HPzMNUsbGb5/95WI9ZX2cK5wNRlh8RV8I8YeIo=;
 b=ahPXYCa1g4VOg4bWBRRFlQSahT0vdg+OOjM6F4EZNNmNdy347VTpRFJfGr64oxEdi9I076OKyv/+TU+Ivw/ZWGjdMerX6FMe6dQtSwrrNypMyaLArCBS3Lu1vYKHcL3Slo5yrLNL/AQgL1alayErm8snixvhF/k137PGI756lWE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by GVXPR08MB10688.eurprd08.prod.outlook.com
 (2603:10a6:150:153::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 14:33:56 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::11da:2693:8a4b:1e29%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:33:56 +0000
Message-ID: <915c9286-d201-4dce-8b47-944b353c8e91@arm.com>
Date: Mon, 11 May 2026 16:33:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq: CPPC: mask Desired_Excursion when autonomous
 selection is enabled
To: luoxueqin <luoxueqin@kylinos.cn>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 sumitg@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506101834.343001-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260506101834.343001-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|GVXPR08MB10688:EE_|AM4PEPF00025F9C:EE_|PAVPR08MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ea9377-c4be-4ddd-05cd-08deaf6a7ac6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 a6GDh7H/xJHtEQTDlcwtuqih4WPCO9KKJCOvXl238Iv9ytzHHs8/h88Ldd9vyezk5nCdKjVlX90KWMld6WP1aNIAGVidWwl0gf/mjttfxXZMFB1ynLX3puqGL9Sw5nyr0WkEz5+Gc17JjhUh269Ytq0Gv0ItZvz6lbxRjFxXXdtCqKJtWKO2HW/Zegpur9lxElAu3t8g/I5GQVsX1XxeIvlk75MG0BXFVTXy0PMZPHDFb2ZhL0H2kCHMx3DZGsE5rwbUsIK48exAjsjQsHJN6Lx/vWgT5MXU4zlkRV7igOo11QmbvlTD65eLPLSCMkhz8T8Ca2GtKwd4acy41c6/VVCqtypbWwC1e3k5XXYfOFVLVU1HSTzo83JIU9Si2NBMXvW9XkoXguD9Un79fojU3AtUPCbeS31kNhd1IjknFpyQ1n3cH1E9q2aVvu+W+B7vTstuXwRzGpbD0mJFXdAsH0Nfu4xk2bdyj0Q7nDDSh5XZzsOdrapNfE7a0bHpt0t2YDqORXtz2msMyMGlw8dFxAtXuYNUatQel7cmILeBDWK56vL6/eAnyqWr0oYIHrMBHzj00gm7LSEHvwyAHCfh/G9Pig8FeJR8XHW5VdnZDlpJLaebl7mWVd5YEVmhUJKelQikicklp7pnqRCaeVriG+AOiLckFW+nwxGuKWg5y0hWGUMOgfbeA1HOKIHXHcat
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Z8fSbzGA+GZtHopOZ1RcAt79V4OZONz3O3iB4m4UMHHkhKOmrd/nvJVawbfkSk3mf6kZW3xNiFtFaDBc9S0BGwRJeIdGzw0aMNwnH+5dTIs2M1j749JW/DHj+2CZOL441TIiAnXGKMSicfbrec90QLt2ucKuXlPivETaJxof5ZppYCSV2HGL+1nBuAlaRSsQ89jGNpba3J2r3+izwpxEXyLll4rZuDqmo9KIxj6YFymLPug/X44yWieyLpXWI1BTXnjJ68+wvolxXoKkjjbXyBASrqF6jWd/LT9SD3NqHYwcSQQ/9R7F001MOroHgcMpFbHq893Bv24FK/cH7+Pr6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10688
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d8c170ae-9673-451c-abac-08deaf6a54d8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700016|376014|14060799003|1800799024|56012099003|22082099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jZM5uRjr4Uy6Ys8BsUNPLKCvP9VHQaDDvAUCFiIOVRPSA3BsvBJ9vUjeI+JeCZ98j5oA4YY15sSOV8F34FV4I8HjMG+x15lH/gO5WvXX+Vci9TUnNU2GWRTSqabV/GSX1a78IKxF0NjD1yDkzCq8GBdhQaw+Gs8wj7UiU4Xe0eg6D/pu7sqqoq/yRUYLBnqLZG3+BuixOl/NA3lDIkHthnMvqafoCMXCgU1+LNaWmEXvMvRH3VsPW6DSYibr4cPcv6SJGv6fut5JMtcJoFJLhF3xvxKLD2Zgi6YfpONdXm0Bxf9sGA7FqMtJ1eEIxhU7N7RttXBJ/64SVGxoXlw9QTA4dBrmH8xRco6zPNCj3J/drrr4HLIzQTP0UOK+pOJwgwAC8NDnc55L9Sw0SA73S4h7xRMtHWYHCnGSSKRrk288slVsdQQ2pPsbOeKbYaM9NHHes3pnVquWd6ezTdB/q20yDHqYF47zYXKcdrpFPDco3DWm3pClXNI0c7sthqfZCNFlegCBh0Dwx9Ks6WY5Vj46WbQ+lNmJDFVnWBCC7ZKfVYGJsXtzuWtuhTTdJkEjJmbfN12J+9a40GORlzBSLn+HdIoFZFVMRT0dE5VEaGUzdSocJL+6MwWsmBA4Mp5+Kz0DJJNqKHwkgg2lQLcZvLMvEexyxsG8HgSPO+Be4oCn8/Rmm64lnOUU07vgg2pp7/xuDy10RIeVH1Zr+Q6XqBxP2StRnJnOiPVHZGkKCYE=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700016)(376014)(14060799003)(1800799024)(56012099003)(22082099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gZTvxBvDo0jiVFtwm3yeIRsXFe9ICoynl/jyt/oiyBRoWCt6PVtcWVzH4GwXgjQCIIxPALOr0CPOtbVAokic5LzSqQxOjRhd88O3rHYQqaLnVOjZBt1XJx0Js3noLK3R3Dd9CIuCOt+m6pZL8+VdEVw+1zqHAiQfr9JnV/SLchxlvYiSiZHYdK4eS0YqTvR+ZZQj8HrY60bnna61ldsE4MvdpiDHfCrIMxZ4bRXWLdOlyUq06GuAgqYgnt7Ls9e5pS52zzDfrz1IXfSxaoeu7BETv3lSQR4uON86P9xVWLShaqNbWbm8p0abVs1WiEr1ST8xxIJ2tlNde6Jq1OtGSDfuMxBSe8/G3/76VlkSqKKvReDgP5DGUQszPckab38LLLZ8kMUoPOaiA4b1Dp32iOpPhUW1XmSvn8mOtzmLjEAF5a3Ze8OlC/AUMGga3qEN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:34:59.3434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ea9377-c4be-4ddd-05cd-08deaf6a7ac6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9282

Hello Xueqin,

Thanks for the update,

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>


On 5/6/26 12:18, luoxueqin wrote:
> From: Xueqin Luo <luoxueqin@kylinos.cn>
>
> According to the ACPI specification, the Desired_Excursion field is not
> utilized when Autonomous Selection is enabled. In this mode, the bit is
> architecturally ignored and does not carry meaningful information.
>
> Currently, the kernel exposes the raw Performance Limited register
> value to userspace through the cpufreq sysfs interface. This may lead to
> misinterpretation, as userspace may assume Desired_Excursion is valid
> even when autonomous selection is active.
>
> To provide a stable and semantically correct ABI, mask out the
> Desired_Excursion bit when autonomous selection is enabled, so that
> userspace does not observe undefined or misleading values.
>
> Writes are left unchanged, as the field is architecturally ignored in
> this mode and write attempts are harmless.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
> v2->v3:
> - Use cached auto_sel from cpufreq driver data
> - Fall back to raw value when policy is unavailable
> - Keep sysfs ABI unchanged by using a wrapper around cppc_get_perf_limited()
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..a439d9621eed 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -982,7 +982,34 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>   	return count;
>   }
>   
> -CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
> +static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
> +{
> +	struct cpufreq_policy *policy;
> +	struct cppc_cpudata *cpu_data;
> +	bool auto_sel_enabled = false;
> +	int ret;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (policy && policy->driver_data) {
> +		cpu_data = policy->driver_data;
> +		auto_sel_enabled = cpu_data->perf_ctrls.auto_sel;
> +	}
> +
> +	ret = cppc_get_perf_limited(cpu, perf_limited);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Desired_Excursion is ignored when Autonomous Selection is enabled.
> +	 * Mask it to avoid exposing misleading values to userspace.
> +	 */
> +	if (auto_sel_enabled)
> +		*perf_limited &= ~CPPC_PERF_LIMITED_DESIRED_EXCURSION;
> +
> +	return 0;
> +}
> +
> +CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>   			 cppc_set_perf_limited)
>   
>   cpufreq_freq_attr_ro(freqdomain_cpus);
