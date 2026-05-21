Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E63403E6;
	Thu, 21 May 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382791; cv=fail; b=PTGoVRS3O52nlGOAw+6MJMiMEEXkYjgto3c+qa/1zMML88/B81VCNERUrbKcNjCesatyoyx8SRUPUUopWt/xyd2gkcKXY8+z7k/1ExTzsHkK/peHYP+ov3VPekv5By8c2AK9+aHwAsQP709uxD6NiNXnvLeesfWviOwWX5upKok=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382791; c=relaxed/simple;
	bh=ZQfEjWc+/4GXuXBxFePSUJ19yjvJFl/L/wg5s6JClkg=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=Vnl2C0x0q8LOx7t5LlEyTo5xyCQgP2i8EC4w5wU87eIvF/i7EernYP+dydqCXJpxzAH//eFP0ZBm8TjaJfDmkagmroYoKvkRLitpj6ueJmAEKotYlmlEvcCU97Gd7HCCKRUtcBTr5jrc6Q/uiolgg4DnOQcjqYe4MMcJWwQyskU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xx08WhnG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xx08WhnG; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xx08WhnG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xx08WhnG"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SJwNLqpf9ApWB2vCvZ8Q2Wk1X11Q3L/LHkMb2ymGau0MLAB9ubE3kB5Ld5rO/6TXoNSpqNvJw8vXtsyx7m4YdE9acdVP9ggewubs0LGOb1oZt/Oqo5J2OEXnF8nyxT0pSlt0A/ThEa6EXdrrAjiEy5yN2CDEj135E+pqHkzG9pxTTS6Fx2VaqsAjNnPTd0bim6aIVCZSlIk+5CyAo75S26I+C2eIVF+/353uvNuCX+iHo62wjupuJYpKuKq0lY501RVbG1PONMXRXsHsSlAN6PVgkt/y0Y+fts7fLC27vkbT18skmXMRXHuU3KBVL62dttPb4kVEPmAWJ3+4EVdOYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b01SpknLSt+7cn9W3GWxMyR0K2JnsdRcghqL7qFoA2E=;
 b=eP2gp6b+RwPtKw2PgrKGKQrKgkmD/r7BykXj6xdgGvhTQ2jGT1m+ekygGdD4YoyrAMQ/1GMkc/Nk255cde+J7h1L7A4zvxOHTP6GH7HDPxv7YbLzW8tTcM1tnA4ijSGYbmBbnB45l5tnMSXh4Hax6cm3G9jIecGqM/brPaOaJR5fudzvqAwmUnIp358Q4iifDN3F2t4+Rbmt94jF0VJlcjCecwR/rMOVcRF+FtSPOeu13mui2nyU16jNZ59y2OJh5IXFSpD8afR0TtW6lu5xhCRxW07WmHkW1Wam729wqwdPO1P8pbjdozh2sXZTWhtnquf/dNsEWZkX4A69ghctWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b01SpknLSt+7cn9W3GWxMyR0K2JnsdRcghqL7qFoA2E=;
 b=Xx08WhnGghkRENFtoLbD2E3i3loNJocNEPSxUQ6ZglbgeIWYoJDvs8ngawn1VNxcEoq3WMUGhf7XQdbQGyW4sUrCdC0+oV1BZgt6XgFAwLOILAWRse+MMqcWBuezYuCUpjbn/6LR74u4z799PPzmDqhw7Xe2MGS37ugMjpxkV9c=
Received: from DUZPR01CA0144.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::26) by AMDPR08MB11673.eurprd08.prod.outlook.com
 (2603:10a6:20b:73c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:59:37 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::f8) by DUZPR01CA0144.outlook.office365.com
 (2603:10a6:10:4bd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 16:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 21 May 2026 16:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk55a5x/+3U2gwScp4HH1rdO2x7AiV/QSb4L0gIUIMoq/bxtBb0S2mddFF5I5klnL/d8+8nCPN3EjI1L+5QcfMSBp+0DoBSe3zvDk7YATE9vQ9lT3rm80spop5e0pi3mVkOghzdL/8igA2ok27Y2BemJju9lnJ5HzA72kyPKQZOmmlaikUkgF4OGmrDSib4nBg9IUye0DNvX1RddSbSLFu9gC770dPHa6nVudMa6xBplJNUvFJIeI9JkcNSS4gaIfJ53/ekb20kQdHVyXER6sbi8+vuh6fu1IRHt9kLM0eI5G5SPHOpvUOr9H6ITzHF49jxelCdsQwJ+jDbb5ugePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b01SpknLSt+7cn9W3GWxMyR0K2JnsdRcghqL7qFoA2E=;
 b=OtPRBLZ6sm8+UqElrMK8D5CFeMwnhMLZeR/VsSi7Jw20W+7atqZgLi8AljkwWvGqG/9tpPsvTDTdtSLU1Wr+oH4UpZ5hJ+kg15HgdlAKGOpQPCUnAJUE+xLVy6vBtQw7yN+fv35W2iefs0kPc5nzH9HokKWgij+Jc5gkle1epk2dY2LKqLpGmZKlZJlLtU16hM66fV7FvUa6GmK7ZBD/kHbXTantbgxICCxBGCssNPwXvVFeOh7SvSjxPPCOxOd8p+WDjoaYygq8fPwGALbVT/HLn3qUTZSAKeMR3g20Aju6472pRsv9pFAGOfQ9f9KstC6nvFvR1cB598aH4ikx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b01SpknLSt+7cn9W3GWxMyR0K2JnsdRcghqL7qFoA2E=;
 b=Xx08WhnGghkRENFtoLbD2E3i3loNJocNEPSxUQ6ZglbgeIWYoJDvs8ngawn1VNxcEoq3WMUGhf7XQdbQGyW4sUrCdC0+oV1BZgt6XgFAwLOILAWRse+MMqcWBuezYuCUpjbn/6LR74u4z799PPzmDqhw7Xe2MGS37ugMjpxkV9c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PR3PR08MB5562.eurprd08.prod.outlook.com (2603:10a6:102:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:58:31 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:58:31 +0000
Content-Type: multipart/mixed; boundary="------------WK6BTmTLkjbMw8dFXI6cXV5k"
Message-ID: <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
Date: Thu, 21 May 2026 18:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260514194822.1841748-3-sumitg@nvidia.com>
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PR3PR08MB5562:EE_|DU2PEPF0001E9C0:EE_|AMDPR08MB11673:EE_
X-MS-Office365-Filtering-Correlation-Id: 94301f4d-399e-465a-8df6-08deb75a575d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|6049299003|366016|11063799006|6133799003|921020|4053099003|4013099003|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 w8NAPGGR4s1huoq+LeNliwEDD0Dv5jI2wUiZdIMH69+6cGbzM3WaiHL5zDMJL1hhIJ3hcFJYoLPLJaIDlxx5V9xD06MbcjaJUz0jiKWN/sNKO92RaZyHw6uvVAkRE/TkNULVUTlGWdjp3nJuAMKC7BQyr9pHuvd2n/1yuPcMUft4Qw4qcZRHSY9fEKxQsXT/4MAkfm8FRtiKFkypTdajDiu8/9UFp371Bc78SHh1oZKOLmqSD4RNPzyVPx7dPGXvlKWGIk3JY4NDPtaGwdfxcM7JUOJYHoc+MM4r4cAj+NhdL0GoSekxgX6a6TYHrxguqFq6LEB66R7zW/MEWVPNCBd/7vwBOJTwLdawWDV6i0EjX53h3qoo19Vm81RcVBGijom4ozRneJJ38v6cZ3nzb8+U2QrGX6EdZ3m9IVAiA8D8MjPghiDiIpGBvmNINbFSwmlwdYuelVf2nhffPerOMy4JoXjM11EsH36XIPUFtQkeg6WPW+0qOTD/TSeTp0xpR9HyC7S19emIZSs6AsJoKhYxsrcQsRe8/nh7YyGyQ6AxmnuhUvckbeB6YBrnzwBtz2tPBGLJjM0Auw/iAO0JEzK+fTY/VQa3hLv3KwuGwXS0kU3RYyRIrYMd3mQ49ju/9iVXATpYdjofEunbIibsGOS7P1MEqH+PE0TA2Pg8CowQC81I7ZYKh3KjkjpxaN4ZN81/9Cwz30G9EnMbQtqjYIfE2vyL8aiWqHySGDas5Pg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(6049299003)(366016)(11063799006)(6133799003)(921020)(4053099003)(4013099003)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 X+8tNudp+mcrM9bsLAm1WX0ZLHCDOahAoF/N/yLnj6LXNaLjq/nkCB6L+HLnF9pOMQ/Ld6m7oWmaWqpdG6BG5HQ93OZlRdLvHlunlumwNPFtSZWzkXX6rOWVwkbkza4va+BN9wt/Yrcb4CLvWCL+ga0U/TuZHPo1QsuLw2ULKVamed9PtEwHq4F84rnVjvbUk63EsDd68j1QqMlHBATQl0zgV5XZfyE+HQy5UDDLjuNip67xnH4foRzCclJQpVm+vYRa+hxGXqIyjnADt88Cu0kSPEeS8R+wFTPWU4cmAEzqEJJPMIwbQZR0wxQXABhHjZJI+BM7lZLJ20HWOBne1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5562
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c6a3e18c-4559-4407-0342-08deb75a2fda
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|6049299003|376014|7416014|82310400026|36860700016|35042699022|1800799024|14060799003|921020|6133799003|11063799006|4143699003|18002099003|22082099003|56012099003|4013099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	HL/6wMO28OtsV7LCoUZGR2Gd81LpBfWisVartt6H5isNP22AP9ph0vila8rgZ3GPYGqz41Ke6y4TXc++RLLQB/68UA09q/cEMEZkGe2R5UJ7awpiMpljNGKn/5//QYBCPHerDlUdKNRTn0MMIhxOg77v9kTFafe2BH2+YnjnM2HtsmCVt32fcHxgsomyAlsyMhzjAiru8K+CgQGz3wNfFyZ80VtC4Ok54SysDp5BOF9At67nra39B6Jtr8Pvylb58OSpSOAVnBDSmYHjvQBaE38Rb+hrbCOAlcoyd6JNLk35GNHCiqnRdzt0Sx9h4TVHCIhLsEUOkEsm2og/30ceGGQeCzhzL7fs7O1PFF4pAx/tt7yOy4fT9QSgkHeUT92wjRhziBagg8O+Wyh5WfMUjq0IgA8szB6/xH+Fzuu+gzrWaK9EmSBAuH3pyMuR2EO76eDOiT8eeEsz1iH5CsDK4iQuPqGJ5bhRJLxcYjRlyCi6eMGBZmz3FBKHk72Er9PSwPQZLqTQDF3zzU7IhkzOHxfkl6G2O1bfsnFEGz2n4RcXdKmbtlzzTQM/LRQZQhbNvLNyvc6uCFwbfEnunwWEJIdJL5i81hSeteh1kA3Cr4Oro5AzumV9mk9wyEdGqzmVoXoy7kbA70Uh0O+Gx/fPYThSZ50nDK9wdcFDiYl11QnrSvpdOMBFiFXkvwe2tHghHZzUoXIdGD+lSz4gCAXg3w5SCmRwCLcn0lq0wJTYFg2rGtLl4mOKBLDBggAF+50xvcKJ9jlMTVoO+d5vN1tr/w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(6049299003)(376014)(7416014)(82310400026)(36860700016)(35042699022)(1800799024)(14060799003)(921020)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003)(4013099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O6LmPG+yM50mJrirQg4gIdOf6A9iuwVEt/SVdZIB4PykkoT7nR0+DroW9Z6O/zmYHZFvDmfZUA+HVbVrGqPJTTIufw8OskLYa5sMRtuk2j04Uc24RaF+DLtmfDS+veD0dfyC2RLyvuj9rl3R6D/5ate6DNSfJNnPyQp7s3V3x67NfEMWs7fv7XRW533ahZIzxv4EO2CkHXdafUQy1i6YVhCuSqJ8FSn/DyM7WyZUGYh/D8Jal5vuvuebJ9xFmOVXPPipsciPbzjEBVCRHqtt9YZxYaqgmO6Zzjxl1BoKm8OU9hGgmIG2i1tCw3o/YKduiSMfP00EldWLqJ0Scz2oTaHqg4ewsQ6LAUpuTNWY0fKDlZf46FLYOsOIxsNYuvrrlS96XQkp6dXkZjyGpvR08P4MtNIhM+6QMVN+Fni45m5wU0sVE7EM4GBZCyBelIrm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:59:37.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94301f4d-399e-465a-8df6-08deb75a575d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11673

--------------WK6BTmTLkjbMw8dFXI6cXV5k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Sumit,

I copy-pasted and attached a complementary patch just to show
what I meant by caching the ospm_nominal_perf value at driver
init/exit.

This should also allow to handle the cases where a user tries
to store a new value for a policy with multiple CPUs,
one of the CPUs and we need to rollback.

I think another issue that should be solved is that:

- we don't the value of ospm_nominal_perf when loading the driver

- we leave the register in an unknown state if we unload/reload
the driver.

Note:
IMO caching values like in the patch would also benefit to the
auto_sel register.

------

If you think the patch helps, feel free to take it. Otherwise
please let me know the issues it would raise.

Regards,

Pierre


On 5/14/26 21:48, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
>
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
>
>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
>
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> every CPU in policy->cpus.
>
> The register is write-only; the kernel caches the last written
> value in struct cppc_cpudata for sysfs readback (returns 0 until
> userspace writes a value).
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++++
>   drivers/acpi/cppc_acpi.c                      | 35 ++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++++++++
>   include/acpi/cppc_acpi.h                      |  7 ++++
>   4 files changed, 99 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..ac1bf1b89ac4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,23 @@ Description:	Performance Limited
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
>   
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		May 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance
> +		level lower than the platform-reported nominal. The
> +		platform treats performance above this level as boost
> +		and below as throttle for power and thermal decisions.
> +
> +		Read returns the last written value in kHz, or 0 if no
> +		value has been written. Write a kHz value in the range
> +		[lowest_freq, nominal_freq].
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008
>   KernelVersion:	2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c76cfafa3589..ad6ece16c30d 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance level
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_perf_caps caps;
> +	int ret;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = cppc_get_perf_caps(cpu, &caps);
> +	if (ret)
> +		return ret;
> +
> +	if (ospm_nominal_perf < caps.lowest_perf ||
> +	    ospm_nominal_perf > caps.nominal_perf)
> +		return -EINVAL;
> +
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..6379b7ceee34 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -985,11 +985,50 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>   			 cppc_set_perf_limited)
>   
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +
> +	if (!cpu_data->ospm_nominal_perf)
> +		return sysfs_emit(buf, "0\n");
> +
> +	freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
> +				    cpu_data->ospm_nominal_perf);
> +	return sysfs_emit(buf, "%u\n", freq_khz);
> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int sib;
> +	u64 freq_khz;
> +	u32 perf;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	for_each_cpu(sib, policy->cpus) {
> +		ret = cppc_set_ospm_nominal_perf(sib, perf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	cpu_data->ospm_nominal_perf = perf;
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>   cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
> @@ -997,6 +1036,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&auto_act_window,
>   	&energy_performance_preference_val,
>   	&perf_limited,
> +	&ospm_nominal_freq,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..0b1dcdbea10a 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -153,6 +153,8 @@ struct cppc_cpudata {
>   	struct cppc_perf_fb_ctrs perf_fb_ctrs;
>   	unsigned int shared_type;
>   	cpumask_var_t shared_cpu_map;
> +	/* Cached OSPM Nominal Performance value (write-only register). */
> +	u32 ospm_nominal_perf;
>   };
>   
>   #ifdef CONFIG_ACPI_CPPC_LIB
> @@ -180,6 +182,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -266,6 +269,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>   {
>   	return -EOPNOTSUPP;


diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ac1bf1b89ac4d..f3d357917242a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -356,9 +356,7 @@Description:        OSPM Nominal Performance (kHz)
                platform treats performance above this level as boost
                and below as throttle for power and thermal decisions.

-               Read returns the last written value in kHz, or 0 if no
-               value has been written. Write a kHz value in the range
-               [lowest_freq, nominal_freq].
+Values are in kHz and in the range [lowest_freq, nominal_freq].

                This file is only present if the cppc-cpufreq driver is
                in use.
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 97218c4ac162b..01542184e69b2 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1717,6 +1717,19 @@int cppc_set_ospm_nominal_perf(int cpu, u64 
ospm_nominal_perf)
}
EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);

+/**
+ * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
+ * @cpu: CPU from which to read register.
+ * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
+{
+return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
+
/**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6379b7ceee347..1a51017a81630 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -28,6 +28,9 @@

static struct cpufreq_driver cppc_cpufreq_driver;

+/* Values at driver init. */
+static u64 scratch_ospm_nominal_perf[NR_CPUS];
+
#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
static enum {
        FIE_UNSET = -1,
@@ -642,7 +645,7 @@static void cppc_cpufreq_put_cpu_data(struct 
cpufreq_policy *policy)

static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
{
-       unsigned int cpu = policy->cpu;
+unsigned int sib, cpu = policy->cpu;
        struct cppc_cpudata *cpu_data;
        struct cppc_perf_caps *caps;
        int ret;
@@ -704,6 +707,34 @@static int cppc_cpufreq_cpu_init(struct 
cpufreq_policy *policy)
        if (caps->highest_perf > caps->nominal_perf)
                policy->boost_supported = true;

+/*
+ * CPUs are expected to have:
+ *   ospm_nominal_perf = nominal_perf
+ * at policy init.
+ */
+cpu_data->ospm_nominal_perf = caps->nominal_perf;
+
+for_each_cpu(sib, policy->cpus) {
+u64 ospm_nominal_perf;
+
+ret = cppc_get_ospm_nominal_perf(sib, &ospm_nominal_perf);
+if (ret == -EOPNOTSUPP) {
+continue;
+} else if (ret) {
+pr_err("CPU%d: Could not read ospm_nominal_perf value\n",
+sib);
+goto out;
+}
+
+if (ospm_nominal_perf != caps->nominal_perf) {
+pr_err("Incoherent ospm_nominal_perf values: "
+"scratch_value=%llu expected_value=%u\n",
+scratch_ospm_nominal_perf[sib],
+caps->nominal_perf);
+goto out;
+}
+}
+
        /* Set policy->cur to max now. The governors will adjust later. */
        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
        cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
@@ -727,9 +758,17 @@static void cppc_cpufreq_cpu_exit(struct 
cpufreq_policy *policy)
{
        struct cppc_cpudata *cpu_data = policy->driver_data;
        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-       unsigned int cpu = policy->cpu;
+unsigned int sib, cpu = policy->cpu;
        int ret;

+/*
+ * CPUs are expected to have:
+ *   ospm_nominal_perf = nominal_perf
+ * at policy init, so come back to that state.
+ */
+for_each_cpu(sib, policy->cpus)
+cppc_set_ospm_nominal_perf(sib, caps->nominal_perf);
+
        cppc_cpufreq_cpu_fie_exit(policy);

        cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
@@ -989,9 +1028,20 @@static ssize_t show_ospm_nominal_freq(struct 
cpufreq_policy *policy, char *buf)
{
        struct cppc_cpudata *cpu_data = policy->driver_data;
        unsigned int freq_khz;
+u64 perf;
+int ret;
+
+ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
+if (ret == -EOPNOTSUPP)
+return sysfs_emit(buf, "<unsupported>\n");
+if (ret)
+return ret;

-       if (!cpu_data->ospm_nominal_perf)
-               return sysfs_emit(buf, "0\n");
+if (perf != cpu_data->ospm_nominal_perf) {
+pr_warn("ospm_nominal_freq value is not coherent: "
+"register=%llu scratch_value=%u\n",
+perf, cpu_data->ospm_nominal_perf);
+}

        freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
                                    cpu_data->ospm_nominal_perf);
@@ -1002,7 +1052,7 @@static ssize_t store_ospm_nominal_freq(struct 
cpufreq_policy *policy,
                                       const char *buf, size_t count)
{
        struct cppc_cpudata *cpu_data = policy->driver_data;
-       unsigned int sib;
+unsigned int sib, failing_cpu;
        u64 freq_khz;
        u32 perf;
        int ret;
@@ -1015,12 +1065,23 @@static ssize_t store_ospm_nominal_freq(struct 
cpufreq_policy *policy,

        for_each_cpu(sib, policy->cpus) {
                ret = cppc_set_ospm_nominal_perf(sib, perf);
-               if (ret)
-                       return ret;
+if (ret) {
+failing_cpu = sib;
+goto error;
+}
        }

        cpu_data->ospm_nominal_perf = perf;
        return count;
+
+error:
+for_each_cpu(sib, policy->cpus) {
+if (sib == failing_cpu)
+break;
+cppc_set_ospm_nominal_perf(sib, cpu_data->ospm_nominal_perf);
+}
+
+return ret;
}

cpufreq_freq_attr_ro(freqdomain_cpus);
@@ -1053,6 +1114,64 @@static struct cpufreq_driver cppc_cpufreq_driver = {
        .name = "cppc_cpufreq",
};

+static void __exit cppc_cpufreq_ospm_nominal_perf_exit(void)
+{
+int cpu;
+
+for_each_present_cpu(cpu) {
+if (scratch_ospm_nominal_perf[cpu] == U64_MAX)
+continue;
+
+/* Reset ospm_nominal_perf to the value present at init. */
+cppc_set_ospm_nominal_perf(cpu, scratch_ospm_nominal_perf[cpu]);
+}
+}
+
+static int __init cppc_cpufreq_ospm_nominal_perf_init(void)
+{
+int ret, cpu;
+
+ret = 0;
+
+for_each_present_cpu(cpu) {
+u64 nominal_perf;
+
+/*
+ * If one CPU failed, scratch_ospm_nominal_perf still needs
+ * to be initialized.
+ */
+if (ret) {
+scratch_ospm_nominal_perf[cpu] = U64_MAX;
+continue;
+}
+
+ret = cppc_get_ospm_nominal_perf(cpu, &scratch_ospm_nominal_perf[cpu]);
+if (ret) {
+if (ret == -EOPNOTSUPP) {
+/* Valid reason to fail. Continue to iterate. */
+ret = 0;
+}
+
+scratch_ospm_nominal_perf[cpu] = U64_MAX;
+continue;
+}
+
+/* Set ospm_nominal_perf to nominal_perf before policy init. */
+ret = cppc_get_nominal_perf(cpu, &nominal_perf);
+if (ret)
+continue;
+
+ret = cppc_set_ospm_nominal_perf(cpu, nominal_perf);
+if (ret)
+continue;
+}
+
+if (ret)
+cppc_cpufreq_ospm_nominal_perf_exit();
+
+return ret;
+}
+
static int __init cppc_cpufreq_init(void)
{
        int ret;
@@ -1063,9 +1182,17 @@static int __init cppc_cpufreq_init(void)
        cppc_freq_invariance_init();
        populate_efficiency_class();

+ret = cppc_cpufreq_ospm_nominal_perf_init();
+if (ret) {
+cppc_freq_invariance_exit();
+return ret;
+}
+
        ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-       if (ret)
+if (ret) {
+cppc_cpufreq_ospm_nominal_perf_exit();
                cppc_freq_invariance_exit();
+}

        return ret;
}
@@ -1074,6 +1201,7 @@static void __exit cppc_cpufreq_exit(void)
{
        cpufreq_unregister_driver(&cppc_cpufreq_driver);
        cppc_freq_invariance_exit();
+cppc_cpufreq_ospm_nominal_perf_exit();
}

module_exit(cppc_cpufreq_exit);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 0b1dcdbea10a2..07e6598fa837a 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -183,6 +183,7 @@extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls 
*perf_ctrls, bool enable);
extern int cppc_set_epp(int cpu, u64 epp_val);
extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
+extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -273,6 +274,10 @@static inline int cppc_set_ospm_nominal_perf(int 
cpu, u64 ospm_nominal_perf)
{
        return -EOPNOTSUPP;
}
+static inline int cppc_get_ospm_nominal_perf(int cpu, u64 
*ospm_nominal_perf)
+{
+return -EOPNOTSUPP;
+}
static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
{
        return -EOPNOTSUPP;


--------------WK6BTmTLkjbMw8dFXI6cXV5k
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-CPPC-Add-ospm_nominal_perf-support-additional-c.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-CPPC-Add-ospm_nominal_perf-support-additional-c.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyOGExZmQ4ZTk0Zjg2MGEzYmJmMTM1Nzc5ZmEzOTk2MjFlOTM1NWFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmUgR29uZG9pcyA8cGllcnJlLmdvbmRvaXNAYXJtLmNv
bT4KRGF0ZTogVGh1LCAyMSBNYXkgMjAyNiAxNDo1Mzo0NiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IEFDUEk6IENQUEM6IEFkZCBvc3BtX25vbWluYWxfcGVyZiBzdXBwb3J0IGFkZGl0aW9uYWwgY2hh
bmdlcwoKQ29tcGxlbWVudGFyeSBtb2RpZmljYXRpb25zIHRvOgotICJBQ1BJOiBDUFBDOiBBZGQg
b3NwbV9ub21pbmFsX3BlcmYgc3VwcG9ydCIKClNpZ25lZC1vZmYtYnk6IFBpZXJyZSBHb25kb2lz
IDxwaWVycmUuZ29uZG9pc0Bhcm0uY29tPgotLS0KIC4uLi9BQkkvdGVzdGluZy9zeXNmcy1kZXZp
Y2VzLXN5c3RlbS1jcHUgICAgICB8ICAgNCArLQogZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEzICsrCiBkcml2ZXJzL2NwdWZyZXEvY3BwY19jcHVmcmVx
LmMgICAgICAgICAgICAgICAgfCAxNDQgKysrKysrKysrKysrKysrKystCiBpbmNsdWRlL2FjcGkv
Y3BwY19hY3BpLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogNCBmaWxlcyBjaGFuZ2Vk
LCAxNTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1kZXZpY2VzLXN5c3RlbS1jcHUgYi9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdQppbmRleCBhYzFiZjFiODlh
YzRkLi5mM2QzNTc5MTcyNDJhIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdQorKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5n
L3N5c2ZzLWRldmljZXMtc3lzdGVtLWNwdQpAQCAtMzU2LDkgKzM1Niw3IEBAIERlc2NyaXB0aW9u
OglPU1BNIE5vbWluYWwgUGVyZm9ybWFuY2UgKGtIeikKIAkJcGxhdGZvcm0gdHJlYXRzIHBlcmZv
cm1hbmNlIGFib3ZlIHRoaXMgbGV2ZWwgYXMgYm9vc3QKIAkJYW5kIGJlbG93IGFzIHRocm90dGxl
IGZvciBwb3dlciBhbmQgdGhlcm1hbCBkZWNpc2lvbnMuCiAKLQkJUmVhZCByZXR1cm5zIHRoZSBs
YXN0IHdyaXR0ZW4gdmFsdWUgaW4ga0h6LCBvciAwIGlmIG5vCi0JCXZhbHVlIGhhcyBiZWVuIHdy
aXR0ZW4uIFdyaXRlIGEga0h6IHZhbHVlIGluIHRoZSByYW5nZQotCQlbbG93ZXN0X2ZyZXEsIG5v
bWluYWxfZnJlcV0uCisJCVZhbHVlcyBhcmUgaW4ga0h6IGFuZCBpbiB0aGUgcmFuZ2UgW2xvd2Vz
dF9mcmVxLCBub21pbmFsX2ZyZXFdLgogCiAJCVRoaXMgZmlsZSBpcyBvbmx5IHByZXNlbnQgaWYg
dGhlIGNwcGMtY3B1ZnJlcSBkcml2ZXIgaXMKIAkJaW4gdXNlLgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jCmluZGV4IDk3MjE4
YzRhYzE2MmIuLjAxNTQyMTg0ZTY5YjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9jcHBjX2Fj
cGkuYworKysgYi9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMKQEAgLTE3MTcsNiArMTcxNywxOSBA
QCBpbnQgY3BwY19zZXRfb3NwbV9ub21pbmFsX3BlcmYoaW50IGNwdSwgdTY0IG9zcG1fbm9taW5h
bF9wZXJmKQogfQogRVhQT1JUX1NZTUJPTF9HUEwoY3BwY19zZXRfb3NwbV9ub21pbmFsX3BlcmYp
OwogCisvKioKKyAqIGNwcGNfZ2V0X29zcG1fbm9taW5hbF9wZXJmKCkgLSBSZWFkIE9TUE0gTm9t
aW5hbCBQZXJmb3JtYW5jZSByZWdpc3Rlci4KKyAqIEBjcHU6IENQVSBmcm9tIHdoaWNoIHRvIHJl
YWQgcmVnaXN0ZXIuCisgKiBAb3NwbV9ub21pbmFsX3BlcmY6IFBvaW50ZXIgdG8gc3RvcmUgdGhl
IE9TUE0gTm9taW5hbCBQZXJmb3JtYW5jZSB2YWx1ZS4KKyAqCisgKiBSZXR1cm46IDAgb24gc3Vj
Y2VzcyBvciBuZWdhdGl2ZSBlcnJvciBjb2RlLgorICovCitpbnQgY3BwY19nZXRfb3NwbV9ub21p
bmFsX3BlcmYoaW50IGNwdSwgdTY0ICpvc3BtX25vbWluYWxfcGVyZikKK3sKKwlyZXR1cm4gY3Bw
Y19nZXRfcmVnX3ZhbChjcHUsIE9TUE1fTk9NSU5BTF9QRVJGLCBvc3BtX25vbWluYWxfcGVyZik7
Cit9CitFWFBPUlRfU1lNQk9MX0dQTChjcHBjX2dldF9vc3BtX25vbWluYWxfcGVyZik7CisKIC8q
KgogICogY3BwY19nZXRfYXV0b19hY3Rfd2luZG93KCkgLSBSZWFkIGF1dG9ub21vdXMgYWN0aXZp
dHkgd2luZG93IHJlZ2lzdGVyLgogICogQGNwdTogQ1BVIGZyb20gd2hpY2ggdG8gcmVhZCByZWdp
c3Rlci4KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9jcHBjX2NwdWZyZXEuYyBiL2RyaXZl
cnMvY3B1ZnJlcS9jcHBjX2NwdWZyZXEuYwppbmRleCA2Mzc5YjdjZWVlMzQ3Li4xYTUxMDE3YTgx
NjMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvY3BwY19jcHVmcmVxLmMKKysrIGIvZHJp
dmVycy9jcHVmcmVxL2NwcGNfY3B1ZnJlcS5jCkBAIC0yOCw2ICsyOCw5IEBACiAKIHN0YXRpYyBz
dHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgY3BwY19jcHVmcmVxX2RyaXZlcjsKIAorLyogVmFsdWVzIGF0
IGRyaXZlciBpbml0LiAqLworc3RhdGljIHU2NCBzY3JhdGNoX29zcG1fbm9taW5hbF9wZXJmW05S
X0NQVVNdOworCiAjaWZkZWYgQ09ORklHX0FDUElfQ1BQQ19DUFVGUkVRX0ZJRQogc3RhdGljIGVu
dW0gewogCUZJRV9VTlNFVCA9IC0xLApAQCAtNjQyLDcgKzY0NSw3IEBAIHN0YXRpYyB2b2lkIGNw
cGNfY3B1ZnJlcV9wdXRfY3B1X2RhdGEoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCiAK
IHN0YXRpYyBpbnQgY3BwY19jcHVmcmVxX2NwdV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAq
cG9saWN5KQogewotCXVuc2lnbmVkIGludCBjcHUgPSBwb2xpY3ktPmNwdTsKKwl1bnNpZ25lZCBp
bnQgc2liLCBjcHUgPSBwb2xpY3ktPmNwdTsKIAlzdHJ1Y3QgY3BwY19jcHVkYXRhICpjcHVfZGF0
YTsKIAlzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgKmNhcHM7CiAJaW50IHJldDsKQEAgLTcwNCw2ICs3
MDcsMzQgQEAgc3RhdGljIGludCBjcHBjX2NwdWZyZXFfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFf
cG9saWN5ICpwb2xpY3kpCiAJaWYgKGNhcHMtPmhpZ2hlc3RfcGVyZiA+IGNhcHMtPm5vbWluYWxf
cGVyZikKIAkJcG9saWN5LT5ib29zdF9zdXBwb3J0ZWQgPSB0cnVlOwogCisJLyoKKwkgKiBDUFVz
IGFyZSBleHBlY3RlZCB0byBoYXZlOgorCSAqICAgb3NwbV9ub21pbmFsX3BlcmYgPSBub21pbmFs
X3BlcmYKKwkgKiBhdCBwb2xpY3kgaW5pdC4KKwkgKi8KKwljcHVfZGF0YS0+b3NwbV9ub21pbmFs
X3BlcmYgPSBjYXBzLT5ub21pbmFsX3BlcmY7CisKKwlmb3JfZWFjaF9jcHUoc2liLCBwb2xpY3kt
PmNwdXMpIHsKKwkJdTY0IG9zcG1fbm9taW5hbF9wZXJmOworCisJCXJldCA9IGNwcGNfZ2V0X29z
cG1fbm9taW5hbF9wZXJmKHNpYiwgJm9zcG1fbm9taW5hbF9wZXJmKTsKKwkJaWYgKHJldCA9PSAt
RU9QTk9UU1VQUCkgeworCQkJY29udGludWU7CisJCX0gZWxzZSBpZiAocmV0KSB7CisJCQlwcl9l
cnIoIkNQVSVkOiBDb3VsZCBub3QgcmVhZCBvc3BtX25vbWluYWxfcGVyZiB2YWx1ZVxuIiwKKwkJ
CQlzaWIpOworCQkJZ290byBvdXQ7CisJCX0KKworCQlpZiAob3NwbV9ub21pbmFsX3BlcmYgIT0g
Y2Fwcy0+bm9taW5hbF9wZXJmKSB7CisJCQlwcl9lcnIoIkluY29oZXJlbnQgb3NwbV9ub21pbmFs
X3BlcmYgdmFsdWVzOiAiCisJCQkJInNjcmF0Y2hfdmFsdWU9JWxsdSBleHBlY3RlZF92YWx1ZT0l
dVxuIiwKKwkJCQlzY3JhdGNoX29zcG1fbm9taW5hbF9wZXJmW3NpYl0sCisJCQkJY2Fwcy0+bm9t
aW5hbF9wZXJmKTsKKwkJCWdvdG8gb3V0OworCQl9CisJfQorCiAJLyogU2V0IHBvbGljeS0+Y3Vy
IHRvIG1heCBub3cuIFRoZSBnb3Zlcm5vcnMgd2lsbCBhZGp1c3QgbGF0ZXIuICovCiAJcG9saWN5
LT5jdXIgPSBjcHBjX3BlcmZfdG9fa2h6KGNhcHMsIGNhcHMtPmhpZ2hlc3RfcGVyZik7CiAJY3B1
X2RhdGEtPnBlcmZfY3RybHMuZGVzaXJlZF9wZXJmID0gIGNhcHMtPmhpZ2hlc3RfcGVyZjsKQEAg
LTcyNyw5ICs3NTgsMTcgQEAgc3RhdGljIHZvaWQgY3BwY19jcHVmcmVxX2NwdV9leGl0KHN0cnVj
dCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQogewogCXN0cnVjdCBjcHBjX2NwdWRhdGEgKmNwdV9k
YXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsKIAlzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgKmNhcHMg
PSAmY3B1X2RhdGEtPnBlcmZfY2FwczsKLQl1bnNpZ25lZCBpbnQgY3B1ID0gcG9saWN5LT5jcHU7
CisJdW5zaWduZWQgaW50IHNpYiwgY3B1ID0gcG9saWN5LT5jcHU7CiAJaW50IHJldDsKIAorCS8q
CisJICogQ1BVcyBhcmUgZXhwZWN0ZWQgdG8gaGF2ZToKKwkgKiAgIG9zcG1fbm9taW5hbF9wZXJm
ID0gbm9taW5hbF9wZXJmCisJICogYXQgcG9saWN5IGluaXQsIHNvIGNvbWUgYmFjayB0byB0aGF0
IHN0YXRlLgorCSAqLworCWZvcl9lYWNoX2NwdShzaWIsIHBvbGljeS0+Y3B1cykKKwkJY3BwY19z
ZXRfb3NwbV9ub21pbmFsX3BlcmYoc2liLCBjYXBzLT5ub21pbmFsX3BlcmYpOworCiAJY3BwY19j
cHVmcmVxX2NwdV9maWVfZXhpdChwb2xpY3kpOwogCiAJY3B1X2RhdGEtPnBlcmZfY3RybHMuZGVz
aXJlZF9wZXJmID0gY2Fwcy0+bG93ZXN0X3BlcmY7CkBAIC05ODksOSArMTAyOCwyMCBAQCBzdGF0
aWMgc3NpemVfdCBzaG93X29zcG1fbm9taW5hbF9mcmVxKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAq
cG9saWN5LCBjaGFyICpidWYpCiB7CiAJc3RydWN0IGNwcGNfY3B1ZGF0YSAqY3B1X2RhdGEgPSBw
b2xpY3ktPmRyaXZlcl9kYXRhOwogCXVuc2lnbmVkIGludCBmcmVxX2toejsKKwl1NjQgcGVyZjsK
KwlpbnQgcmV0OworCisJcmV0ID0gY3BwY19nZXRfb3NwbV9ub21pbmFsX3BlcmYocG9saWN5LT5j
cHUsICZwZXJmKTsKKwlpZiAocmV0ID09IC1FT1BOT1RTVVBQKQorCQlyZXR1cm4gc3lzZnNfZW1p
dChidWYsICI8dW5zdXBwb3J0ZWQ+XG4iKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OwogCi0J
aWYgKCFjcHVfZGF0YS0+b3NwbV9ub21pbmFsX3BlcmYpCi0JCXJldHVybiBzeXNmc19lbWl0KGJ1
ZiwgIjBcbiIpOworCWlmIChwZXJmICE9IGNwdV9kYXRhLT5vc3BtX25vbWluYWxfcGVyZikgewor
CQlwcl93YXJuKCJvc3BtX25vbWluYWxfZnJlcSB2YWx1ZSBpcyBub3QgY29oZXJlbnQ6ICIKKwkJ
CSJyZWdpc3Rlcj0lbGx1IHNjcmF0Y2hfdmFsdWU9JXVcbiIsCisJCQlwZXJmLCBjcHVfZGF0YS0+
b3NwbV9ub21pbmFsX3BlcmYpOworCX0KIAogCWZyZXFfa2h6ID0gY3BwY19wZXJmX3RvX2toeigm
Y3B1X2RhdGEtPnBlcmZfY2FwcywKIAkJCQkgICAgY3B1X2RhdGEtPm9zcG1fbm9taW5hbF9wZXJm
KTsKQEAgLTEwMDIsNyArMTA1Miw3IEBAIHN0YXRpYyBzc2l6ZV90IHN0b3JlX29zcG1fbm9taW5h
bF9mcmVxKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LAogCQkJCSAgICAgICBjb25zdCBj
aGFyICpidWYsIHNpemVfdCBjb3VudCkKIHsKIAlzdHJ1Y3QgY3BwY19jcHVkYXRhICpjcHVfZGF0
YSA9IHBvbGljeS0+ZHJpdmVyX2RhdGE7Ci0JdW5zaWduZWQgaW50IHNpYjsKKwl1bnNpZ25lZCBp
bnQgc2liLCBmYWlsaW5nX2NwdTsKIAl1NjQgZnJlcV9raHo7CiAJdTMyIHBlcmY7CiAJaW50IHJl
dDsKQEAgLTEwMTUsMTIgKzEwNjUsMjMgQEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfb3NwbV9ub21p
bmFsX2ZyZXEoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksCiAKIAlmb3JfZWFjaF9jcHUo
c2liLCBwb2xpY3ktPmNwdXMpIHsKIAkJcmV0ID0gY3BwY19zZXRfb3NwbV9ub21pbmFsX3BlcmYo
c2liLCBwZXJmKTsKLQkJaWYgKHJldCkKLQkJCXJldHVybiByZXQ7CisJCWlmIChyZXQpIHsKKwkJ
CWZhaWxpbmdfY3B1ID0gc2liOworCQkJZ290byBlcnJvcjsKKwkJfQogCX0KIAogCWNwdV9kYXRh
LT5vc3BtX25vbWluYWxfcGVyZiA9IHBlcmY7CiAJcmV0dXJuIGNvdW50OworCitlcnJvcjoKKwlm
b3JfZWFjaF9jcHUoc2liLCBwb2xpY3ktPmNwdXMpIHsKKwkJaWYgKHNpYiA9PSBmYWlsaW5nX2Nw
dSkKKwkJCWJyZWFrOworCQljcHBjX3NldF9vc3BtX25vbWluYWxfcGVyZihzaWIsIGNwdV9kYXRh
LT5vc3BtX25vbWluYWxfcGVyZik7CisJfQorCisJcmV0dXJuIHJldDsKIH0KIAogY3B1ZnJlcV9m
cmVxX2F0dHJfcm8oZnJlcWRvbWFpbl9jcHVzKTsKQEAgLTEwNTMsNiArMTExNCw2NCBAQCBzdGF0
aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGNwcGNfY3B1ZnJlcV9kcml2ZXIgPSB7CiAJLm5hbWUg
PSAiY3BwY19jcHVmcmVxIiwKIH07CiAKK3N0YXRpYyB2b2lkIF9fZXhpdCBjcHBjX2NwdWZyZXFf
b3NwbV9ub21pbmFsX3BlcmZfZXhpdCh2b2lkKQoreworCWludCBjcHU7CisKKwlmb3JfZWFjaF9w
cmVzZW50X2NwdShjcHUpIHsKKwkJaWYgKHNjcmF0Y2hfb3NwbV9ub21pbmFsX3BlcmZbY3B1XSA9
PSBVNjRfTUFYKQorCQkJY29udGludWU7CisKKwkJLyogUmVzZXQgb3NwbV9ub21pbmFsX3BlcmYg
dG8gdGhlIHZhbHVlIHByZXNlbnQgYXQgaW5pdC4gKi8KKwkJY3BwY19zZXRfb3NwbV9ub21pbmFs
X3BlcmYoY3B1LCBzY3JhdGNoX29zcG1fbm9taW5hbF9wZXJmW2NwdV0pOworCX0KK30KKworc3Rh
dGljIGludCBfX2luaXQgY3BwY19jcHVmcmVxX29zcG1fbm9taW5hbF9wZXJmX2luaXQodm9pZCkK
K3sKKwlpbnQgcmV0LCBjcHU7CisKKwlyZXQgPSAwOworCisJZm9yX2VhY2hfcHJlc2VudF9jcHUo
Y3B1KSB7CisJCXU2NCBub21pbmFsX3BlcmY7CisKKwkJLyoKKwkJICogSWYgb25lIENQVSBmYWls
ZWQsIHNjcmF0Y2hfb3NwbV9ub21pbmFsX3BlcmYgc3RpbGwgbmVlZHMKKwkJICogdG8gYmUgaW5p
dGlhbGl6ZWQuCisJCSAqLworCQlpZiAocmV0KSB7CisJCQlzY3JhdGNoX29zcG1fbm9taW5hbF9w
ZXJmW2NwdV0gPSBVNjRfTUFYOworCQkJY29udGludWU7CisJCX0KKworCQlyZXQgPSBjcHBjX2dl
dF9vc3BtX25vbWluYWxfcGVyZihjcHUsICZzY3JhdGNoX29zcG1fbm9taW5hbF9wZXJmW2NwdV0p
OworCQlpZiAocmV0KSB7CisJCQlpZiAocmV0ID09IC1FT1BOT1RTVVBQKSB7CisJCQkJLyogVmFs
aWQgcmVhc29uIHRvIGZhaWwuIENvbnRpbnVlIHRvIGl0ZXJhdGUuICovCisJCQkJcmV0ID0gMDsK
KwkJCX0KKworCQkJc2NyYXRjaF9vc3BtX25vbWluYWxfcGVyZltjcHVdID0gVTY0X01BWDsKKwkJ
CWNvbnRpbnVlOworCQl9CisKKwkJLyogU2V0IG9zcG1fbm9taW5hbF9wZXJmIHRvIG5vbWluYWxf
cGVyZiBiZWZvcmUgcG9saWN5IGluaXQuICovCisJCXJldCA9IGNwcGNfZ2V0X25vbWluYWxfcGVy
ZihjcHUsICZub21pbmFsX3BlcmYpOworCQlpZiAocmV0KQorCQkJY29udGludWU7CisKKwkJcmV0
ID0gY3BwY19zZXRfb3NwbV9ub21pbmFsX3BlcmYoY3B1LCBub21pbmFsX3BlcmYpOworCQlpZiAo
cmV0KQorCQkJY29udGludWU7CisJfQorCisJaWYgKHJldCkKKwkJY3BwY19jcHVmcmVxX29zcG1f
bm9taW5hbF9wZXJmX2V4aXQoKTsKKworCXJldHVybiByZXQ7Cit9CisKIHN0YXRpYyBpbnQgX19p
bml0IGNwcGNfY3B1ZnJlcV9pbml0KHZvaWQpCiB7CiAJaW50IHJldDsKQEAgLTEwNjMsOSArMTE4
MiwxNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjcHBjX2NwdWZyZXFfaW5pdCh2b2lkKQogCWNwcGNf
ZnJlcV9pbnZhcmlhbmNlX2luaXQoKTsKIAlwb3B1bGF0ZV9lZmZpY2llbmN5X2NsYXNzKCk7CiAK
KwlyZXQgPSBjcHBjX2NwdWZyZXFfb3NwbV9ub21pbmFsX3BlcmZfaW5pdCgpOworCWlmIChyZXQp
IHsKKwkJY3BwY19mcmVxX2ludmFyaWFuY2VfZXhpdCgpOworCQlyZXR1cm4gcmV0OworCX0KKwog
CXJldCA9IGNwdWZyZXFfcmVnaXN0ZXJfZHJpdmVyKCZjcHBjX2NwdWZyZXFfZHJpdmVyKTsKLQlp
ZiAocmV0KQorCWlmIChyZXQpIHsKKwkJY3BwY19jcHVmcmVxX29zcG1fbm9taW5hbF9wZXJmX2V4
aXQoKTsKIAkJY3BwY19mcmVxX2ludmFyaWFuY2VfZXhpdCgpOworCX0KIAogCXJldHVybiByZXQ7
CiB9CkBAIC0xMDc0LDYgKzEyMDEsNyBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgY3BwY19jcHVmcmVx
X2V4aXQodm9pZCkKIHsKIAljcHVmcmVxX3VucmVnaXN0ZXJfZHJpdmVyKCZjcHBjX2NwdWZyZXFf
ZHJpdmVyKTsKIAljcHBjX2ZyZXFfaW52YXJpYW5jZV9leGl0KCk7CisJY3BwY19jcHVmcmVxX29z
cG1fbm9taW5hbF9wZXJmX2V4aXQoKTsKIH0KIAogbW9kdWxlX2V4aXQoY3BwY19jcHVmcmVxX2V4
aXQpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3BpL2NwcGNfYWNwaS5oIGIvaW5jbHVkZS9hY3Bp
L2NwcGNfYWNwaS5oCmluZGV4IDBiMWRjZGJlYTEwYTIuLjA3ZTY1OThmYTgzN2EgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvYWNwaS9jcHBjX2FjcGkuaAorKysgYi9pbmNsdWRlL2FjcGkvY3BwY19hY3Bp
LmgKQEAgLTE4Myw2ICsxODMsNyBAQCBleHRlcm4gaW50IGNwcGNfZ2V0X2VwcF9wZXJmKGludCBj
cHVudW0sIHU2NCAqZXBwX3BlcmYpOwogZXh0ZXJuIGludCBjcHBjX3NldF9lcHBfcGVyZihpbnQg
Y3B1LCBzdHJ1Y3QgY3BwY19wZXJmX2N0cmxzICpwZXJmX2N0cmxzLCBib29sIGVuYWJsZSk7CiBl
eHRlcm4gaW50IGNwcGNfc2V0X2VwcChpbnQgY3B1LCB1NjQgZXBwX3ZhbCk7CiBleHRlcm4gaW50
IGNwcGNfc2V0X29zcG1fbm9taW5hbF9wZXJmKGludCBjcHUsIHU2NCBvc3BtX25vbWluYWxfcGVy
Zik7CitleHRlcm4gaW50IGNwcGNfZ2V0X29zcG1fbm9taW5hbF9wZXJmKGludCBjcHUsIHU2NCAq
b3NwbV9ub21pbmFsX3BlcmYpOwogZXh0ZXJuIGludCBjcHBjX2dldF9hdXRvX2FjdF93aW5kb3co
aW50IGNwdSwgdTY0ICphdXRvX2FjdF93aW5kb3cpOwogZXh0ZXJuIGludCBjcHBjX3NldF9hdXRv
X2FjdF93aW5kb3coaW50IGNwdSwgdTY0IGF1dG9fYWN0X3dpbmRvdyk7CiBleHRlcm4gaW50IGNw
cGNfZ2V0X2F1dG9fc2VsKGludCBjcHUsIGJvb2wgKmVuYWJsZSk7CkBAIC0yNzMsNiArMjc0LDEw
IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNwcGNfc2V0X29zcG1fbm9taW5hbF9wZXJmKGludCBjcHUs
IHU2NCBvc3BtX25vbWluYWxfcGVyZikKIHsKIAlyZXR1cm4gLUVPUE5PVFNVUFA7CiB9CitzdGF0
aWMgaW5saW5lIGludCBjcHBjX2dldF9vc3BtX25vbWluYWxfcGVyZihpbnQgY3B1LCB1NjQgKm9z
cG1fbm9taW5hbF9wZXJmKQoreworCXJldHVybiAtRU9QTk9UU1VQUDsKK30KIHN0YXRpYyBpbmxp
bmUgaW50IGNwcGNfZ2V0X2F1dG9fYWN0X3dpbmRvdyhpbnQgY3B1LCB1NjQgKmF1dG9fYWN0X3dp
bmRvdykKIHsKIAlyZXR1cm4gLUVPUE5PVFNVUFA7Ci0tIAoyLjQzLjAKCg==

--------------WK6BTmTLkjbMw8dFXI6cXV5k--
