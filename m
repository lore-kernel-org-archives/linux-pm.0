Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B9394789;
	Thu,  9 Jul 2026 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568123; cv=fail; b=J6lzzjf1gjjOP4HVI0xYdyUcTayX4XFp/xER/fyX1DOG0nizqS6i4JQfpToRn8GByfdaFUG/KAnESXoxhgG7VxcXiM7wBDBiM1OegUr1paVQh/8FuRWbAFUxICUSG1Y+NJV74hOw16dLoArXbTudQZQNgaGqwu4s2zqQsvJgIWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568123; c=relaxed/simple;
	bh=D/qaDuu3L4fJDUD9DxfWUGMig2CacQmRYSBefNkpYOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xctc8k+/5JPurfaR3Fx6N2SJu9FcyVmZFAXsoFiXQDvfxTQLMmpXevszFiqPmHGXC2ZVYgstZbRkkPuPdtxnTFJFcQ+5UJ78AFRgr1L26tn5kwQyfc9+pjFlpfvDwaF/GOAmvziJUdJS79H1ZQ2TamcIJDrvbXnttbIn71wQEyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BGkzZ0WB; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BGkzZ0WB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COZ6djyUvtOAoLFUv7vGiJsYBjARW0k8ZHqGsmJmF+fL2VMcEpJhjUkx4K54Dvs/BN3EMiZBCJdy28Xr4ew5xgbCako3qugi7gx0afBMegLmwHBhel67fJq3IfgMBYaF6v4GuwbGjLJ2+Ok9C3iKJvPRgj2BEXm6Ar2kIPRukiFMRQj/vmqumkkHiLgH+NsItuXd7Vp1I4V9JDSL33ZiyoWzmCnN8Ko8WSdM5NxDgwUO/NMyvbqWKVcykHELw8cmXeJjd+f31Rbrehyadpd88KUMtofZt7nh3z3WYQ78mGNY8JS9ALKdhpBKFIachnzQU9Fqg+eQ9rWXGvSk5Jw9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCEdnq4W6B6g4VuPH2J78EM6mNoaukPmTRtGbBhiT/o=;
 b=kEWDRG4Bl5CsacGvGYCcjwbJi6zl5r5u4mMZrAZ3LFnSOTUay4aJ7tV2y636ViHhSlQcspaExqXxz7eVaXAhz8+9MUjKv2kqAufK5xnygMbr0lrCOfktL8bxDWFvoOsjoWxcJ944cMjB/BcpsJspUwcZd3GvebQH5FPTW9FHxnpNpDZCYrhtQbEyyOxYyHz63iVJ5ryJWSQ8pUTKGbi8V82zq6gqmulLd8DwI3MBhMqLGlSAX+VNev2LGBHvQUmr+pDHmRgruI0I6gr++iwuChxTkMp8z9GsbOQwjjrC59gwZwD8otbAFKdbtzaQ4kxDomLACTKEb2Tp44wlA1EhlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCEdnq4W6B6g4VuPH2J78EM6mNoaukPmTRtGbBhiT/o=;
 b=BGkzZ0WBC6LUh8q8x8kpoPnPNqvFoVviNrHzxf9ZvJ1Pf9FsxeQZXhiSCBGVZjiV56lrj6PZNH8vpEOvJ0Khnmg76XC8vg3gLcaaiQ2E2ZtTH1kJRt2l55Ou3sm/DCMp/64jDNicIqw12Zobfj/K5f0ofJKMAucjD39wbXmUwVFvF3Q6mDY9EazGlFcbA2+2yb7N7cBKqjU3R7k7QStfdMl2efuRs8ahJgvUWJN9tCgSLf7ZmmuEePZVYRRmO7IIt9ffx+beCkqyegcd7AVbHxgcdY83Url7SfD73mCdwOlrJNTRdtDfYpE+D9G4V1cPILSBMc9Q6oekwlktvIoSLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:01 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:01 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 09/43] power: supply: axp20x_usb_power: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:48 +0800
Message-Id: <20260709033428.362970-10-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709033428.362970-1-panchuang@vivo.com>
References: <20260709033428.362970-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: bd456d78-1feb-42a1-ad84-08dedd6b0ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JQb2zSMY6J44P9XNGSbBX3zoFPCp5EmWOfKMftlozCEnJ81Wt0AC89Sk9zaX93vsrlafGYwvMCxPqb7d7L4x26GMCJcE+5Ds1NiGJ52MpIBO53kG1HG/2uFtdN98Ou6HDKFG44zxEqqLzR+XnrzosmgfkaxL9pfG8UtYEhfv5ALaIyTQg6GiI7GRq4mMHNlGwogz6Ix3Gdtkt+jSlzmU6ygkL3CE9sjacm6i+nj2cJ1oMfxcM5jfzCugQDu3bhwiRP2xM97Mq/YRF5W7QV6Fhl+ziKRDaAt5QjcxQjPmmrsjXRT3S+xEpKFCxo5JvBSLetGYwzbCkliP76ZPbkccI3NIjnTh/VTjanGb1xdZ5oUCqKyDjq/XfQxk0F3b3UTBhHw9Y3i0BX0s4lpcd61/3+D89xWZq42oqAX/CbI0z1ymLXG+7Bar03xWEvb08RKoqn/pgQ7YZvEARRoX9CZvo1IOc0dV2+83huAug7SAv5v7PgPkQWXn03p1vob7cuslLaXjL8caqZT3IQpRpd+8FvZbhK4ll6U6PZCX07FQzI4ZmLOwf+Y88laQ7YwgJ2Yo8EMnmPJA/9ZPrWDx4PHz8+f05sTqg3kzvWNloSv6xdh5v+5doEE+p3VXCGes/FJh6PCRlQt3FdarGj+AMTxOM14s2rU4NuZFwV7cSEYcfI4DxLrdbSHQ8Yk5EQFp80u1Xhca+/nqbE9h6e8SqSHnoj35vBUvpCi4Z8d2EjY+DPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V2Q46ozeKqLjXaPmV/8V4vk2xc+XVPimS7btHL2CgW+uR4/4u+SGRYj3Bow3?=
 =?us-ascii?Q?JmO3UUI9wtNMSBQzJWe7KxOiXIy31dg+VZeiVbKJRjDngZq8JdctpqZCRUsL?=
 =?us-ascii?Q?KsPKgclBre9O4I2egUf4yofcQn9vUEWnR5QxRUu6Tckk2cuIWi4BIB8KkMDi?=
 =?us-ascii?Q?AAY72HVfNrQT+z/p9xEWTIRHsBLAzusXtLUelnRw4zPEJeza1+u294nP/txG?=
 =?us-ascii?Q?pT4Ih4EnhBGYGTMsTWZZkF1mAsrevaLMsTWULYr4hEfJpA8ugldc7NY8NK3f?=
 =?us-ascii?Q?SNt/BtSUFj74Pi3VbwGGzM0SzLVfq3lDLqN7QF+ymY+N0O7jdt/ZoAob0NLK?=
 =?us-ascii?Q?HQD3QESDtNSyaZ4k2Wx1kzR/Hf2Ro/h+QYlr6rZTX/AlyBP9WgRhYpeod58i?=
 =?us-ascii?Q?JN8ufl1ZAPPN2McC3xhE/U0w640saEXNIqfw21So83PPewlK+6SdTpRH1F8L?=
 =?us-ascii?Q?2X+Y6XqXkFQ9sHDdcYaKBvVwfgJrrpEe1OLa6qOV2E/Zt9CGpuPBJl10Dgnd?=
 =?us-ascii?Q?Me019E5GkH8p9/B7Xu2b4IK/NiiKEI1b+rCpq1GCWoyM4I34waeuqbW3R42l?=
 =?us-ascii?Q?5FM+MqORISFkL+xlxxIyZOYKT8oIJ2IVzdq352AaZx9at+jVmL5vgA363BNp?=
 =?us-ascii?Q?J1SbgKE5+McNvGVCEvdcQ8fszzK61PbtZ8rEI/mgTiqa5EHIennkBpl+MmKv?=
 =?us-ascii?Q?tzPQ7dUUw5orGh6LkDLdS2IioyhlY0sa0FJiO28iK/dLZVoKoLH546Nc9ikI?=
 =?us-ascii?Q?UKZ/RGzlnNcSQbS/EJATx9jzigajtpnzxCoh22Y95y8KRKrcBeOXksCCdshM?=
 =?us-ascii?Q?zOJ+7UrrKP62ZZPWmSun3tE7ompbFzbX4eyPMz0y6gAaaBRfE784n+rOKpx5?=
 =?us-ascii?Q?Ovmz/ys0UuLMcacDQHTfPo77SVEjIhhQPIHOsUQ20yOrtzaLri8vkarikDQK?=
 =?us-ascii?Q?v1S16mnRbupNCPYy6JXOSrPKy4QOAUTc8pePFkouP1CRmTuCODvkziZ6dYrh?=
 =?us-ascii?Q?K7ogcsKJY2YwWsDI6VHKMwiJ20fM3HK379Wqg3695dRQE5LIPlqxZfxJ1sS9?=
 =?us-ascii?Q?KeGcGPiuLf6jvzc3V8bTK1yMexJZ1Ee/Zq9GtX4nLczkcx4fYx18z+eWinSN?=
 =?us-ascii?Q?e8VbLqukNyWplAaof+R0hwqusSX4TCVa643FzVeCYSmT42ObGlLyHrxKVaMm?=
 =?us-ascii?Q?PPEAYtx1ii9q3BppMC/uOCR1rzBz5j0FjmNIHTZdlzhwt1cOFcVCjktDb2tN?=
 =?us-ascii?Q?/qT+kCmCVKX9lMChwTx8NatKljrWCRuHRk2o0DoUTdBuE7TAfw6v+qw7O9BZ?=
 =?us-ascii?Q?0cjmJSXbl8w91ogq/x0/MGBdMwS1WMKHpaNbbdeq5EcPtb/dyFBDM3w5Wd7o?=
 =?us-ascii?Q?QZhoAm3ICrgmqRGydiTmmIUlRSR5DnxKjk6lckAzGjc8eFNCMyiwLDqOP18N?=
 =?us-ascii?Q?45/vvFtgZ4sqMnLK4iSeJgpQ8oIcB8qudeal0gpLElAyuGSlFPOZDY2F/zvT?=
 =?us-ascii?Q?lyyI6la6hwYJgbQw6zzRMnZ98/CGC52AkwVnCQQ7S3d/tFaaUROaREC49eRJ?=
 =?us-ascii?Q?Qhxb0Kxl9BemsZKCnZYzv8Wv4XX2sFpoEmhCT3GU9Q4wfTSx3q4WZYxF1me2?=
 =?us-ascii?Q?HUJ+DG8GS0r0ikiuhtBnqIwMHxeY5yTu+Q6xE5dxcXnRy4e4a1u6vxKEH8eX?=
 =?us-ascii?Q?K1UdodDFnOOhQwIDYAJWJ4vNj8WgYkW/z4VHnqgo3E6Y5HrY2c1FHN4n87KO?=
 =?us-ascii?Q?yX3BaS6mgA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd456d78-1feb-42a1-ad84-08dedd6b0ef1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:01.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRkALlUfZI3tVKIzrZaeLaGec4gIoAqeOvnQanxCE0KNJ4Nwlazv5NCtAxKzRRcK/KOj8E1ZgwkYWuLHQqyZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_any_context_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() and dev_err_probe() calls that previously printed generic
messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/axp20x_usb_power.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e75d1e377ac1..29f105f9212d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -1030,11 +1030,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
 						   axp20x_usb_power_irq, 0,
 						   DRVNAME, power);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				axp_data->irq_names[i], ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (axp20x_usb_vbus_needs_polling(power))
-- 
2.34.1

