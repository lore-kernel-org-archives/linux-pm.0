Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677838F254;
	Thu,  9 Jul 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568112; cv=fail; b=c2ucE8hSl99+BLQ/6gxdae8pwUKkAp0LdEn1Zgna0pPAe/pzuvej1zBv5D39R7Nwzh5v0ZCgW5In9aZX9LZpsbCRXw9q+jC+kNFFAS9TavyEGxkZYxIbA7qON2OaY0y9KGZRj6hlnffGL+H4tDoL/hkMcY4vLKUeikWZkw/9LpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568112; c=relaxed/simple;
	bh=U/c/4+tnqzQRcD92qS30WJKY8Uz/qH0/OH7h33voo3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgZq82dYYF8Y44hqmCSrPOIxP3OXaL4qqmDg82NgmRjPKY2nt5XKccN6qyedyIWk+AbByEclQyGNDtfPKevKun93QQnr5E3c1+UOW0yCW4OePbnb56wph4Cjni4M7B6kx0vZaCk3sTOKleTmul5ly7284AOnCStL8H80+khp+YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PYXe32TI; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PYXe32TI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgbVYFmvarYDM6EcQlnDOOwLP1csoaoQ4BDT1qq0yvROn4KsD62ZKpQElPGJoYRBUzAgVYycpz/2wVuRX6AQKuRJ/x/ZZU7rqRLJ0whGx96dG55QNbc6drziQ6LygR7rLG67vu/vE19PkjMy+HNMTOLqZI3iXM5nXLpqHXso9oGUv8/G1yvUv12QlGvGZugaVbFkG/y8VoV5Is+mCmgEMQXKNEcxS1bSnn4izdPiUU5R+gx9ZMsxVGu0PO/62pyYi8vrG2/yxCqYtsMXNc/pt1stH2aZT6goP8PaDK7/dgVC6w7LDDT24N0yuXNdnSb0644mYN5KeGb2ghJ8uwFhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBsA7g+vmdm/3NwBO/WnKFaAsq8lKwSKXA3tbeIoUO4=;
 b=rpduH0LMjXrOcDrMHyw+F2ZknN/nAEzkYe2XNxH6lCw9spiwNs9sKbh4o2MPudmLBW3yJPQJzYtpno5pYg3n5U7+g9jhAcuCxCFG5shqkIKbGFVqYcZcnSWCUD05zH7501GS8hc5qyAsKa0jw4DwDmhAGJxGEdNEHqQUIhLcaReuqPgErWAmxMWX9gM6wsofFay/btTzbHlQ+i4RlagEUNS7lInVk8YWDhMdhLVEdHIc+yP6P5SC2UXTZNadgftntlOiHmm7h5O1txDbPKnUDyfeyoqYNGIpl04pSBuzljoV1UXEXOyZIpAW4Mjq+drkL6b1nMtXxylmSMibfthDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBsA7g+vmdm/3NwBO/WnKFaAsq8lKwSKXA3tbeIoUO4=;
 b=PYXe32TIDl/xlbEU6zjL2joNZDLDpDVkMoDYV+RvfVSvAcc0+V9+mQXRMx+DpQ0eA5fFrcLqGCiDmF1tcTmK4P/ixWNHGDaYXhzfLJ1bi+wU5cMMFMaCNIyk74vYTbkUXhFcxYyBwDL4RS1Id3zKb+g1/wKJxrrosTUEMCRhDDTxPNHm2rxab7+pzBLb3QUUGJ1zoNOMhNBX01SlUQjn7uRigZdf0rxO+DKR15mg8l/ER2nk8vGuL95foKtikOG8vHPDsU2H+IVHeoWA1tsuYakZBKLGNYYKO1T9zr1hoFQCEmhfPEMHz6AgP+p0ClRL4KyYo/+deNCOjRYpz6ARLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:34:56 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:34:56 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 05/43] power: supply: ab8500_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:44 +0800
Message-Id: <20260709033428.362970-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f10ba10e-e118-438c-11a6-08dedd6b0bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Lr9TcSz8dRsTzATdc4ShiZAx3UhgEEeQc1q8I1hbX+cSBCnWYLDkRKYSE3FksKZsCBl45/1/NqTnDeUK6Y6vrAKvq7zaURs7tEPiafNAgyuH5b7Tgm3H6eNksai7++/3pbN5qeV/+z0nOMFfsbX8pa0CW7rjBiPAt1agBBGgnWCQzzRur1C4X926wudrDuR2E1vdWYJSap7kzQjiT2vZttKHLfY6QWo0Y7rsqjl1nX4ZoOI8WBmp9PB/bZ+5w4loPLOpKx9FsIF8C0xxTF8JL4znFKlayLsTtzlepDwoioEXJPP080UKpxnGyKxxVndGBBO7Uub+PgxZfwFGYtffXZtMmE+U7PuQhaXIsfVBYwP40CCqrBWq9q9fONjtMx8eXq9oGsXoBUgw3iYye9qS/6GEcpG9qNmL3kPPqeTlcK8mF2IReUh0DnE2Pff6/rZr1fW5LwvmVjxT2xxMyngX9yYLUi/l7Iz2Z1RW0vI6vAcozsr1TSC7o3Kb/YdEC4zM7Ww2cTG28wWGvxpVCMOKfhG5sOglE4wJLVNHMQpIETz73RvYLAFP/2WYNhA4T7F5vXRHPLNZ+p6Hfx0VAoT9VzFY+7OAxDW0tZ0kXY53ptbRzq0Q6A4taAJ3AP4gjKfDIXT7XInv7vof5WTHQtOZQvWcgslp9LIg8u5ule+3PWb/JPC/eHEGnCfrOu6tAw3A/QzbLogGqHM8kCaGH44mOr6L7OSOE5Yt0wzeYUvAnPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2DPqZju3QS5zFLz1nRq8FGcfSrxeYOkU/SqM3aqnJ6BnmNeufAeb4HH6wgy0?=
 =?us-ascii?Q?i56c3G+cF1j2DHf6wGD8nPcdznFxRAt4JU/Fv8r16h9c3sJIgk4uxnOLOJ05?=
 =?us-ascii?Q?aK5Tpv7n8i50TjxOQl0D6VS3+JoqGFfQarenoXpw4rut2tnfXZQiUxRm+HWv?=
 =?us-ascii?Q?hs+0JcuaU7rcHIkDbfNORdg00E086l3pZvjKwCZnkwFETi/7qm0VMvcbB94D?=
 =?us-ascii?Q?trl7bQ/JQtzPJ0GgJUc2+haupFB8R9UrjEAcvVOzPViL0it+CUzQV1cvDwOW?=
 =?us-ascii?Q?yTedGV6dF8l3zxVsGP6exjHasOkqcbdrxp0uC52f/hV5hCVhxI+OfXQsEN4Q?=
 =?us-ascii?Q?p+jEkfLUzj0yK9NzJBFetcsWMj4d/Nw661khaE6wUuWcKpyoariiKDjlAubx?=
 =?us-ascii?Q?j5nHPJAE7PX5l/iP64yaaXstYPbpN4Jz2BzzHvFFU44xtHwQ4WZRqoCqvjsg?=
 =?us-ascii?Q?zLLa0ivULw0wS68PhqDVDv1jMIJgXByPyFHY4ckzK9DfuT6dbmlUwI/lbUav?=
 =?us-ascii?Q?INUYlUhE77wMnrg6A9Gcj2DK/0sjHaVmGT87XwB+owrlXsrMHdkTX25k37af?=
 =?us-ascii?Q?m4mP1HjavUk5Ld93tWmQtZXQcvFhFqrnN9JjKdbKYFU5NjEJc8IQl79p0SgQ?=
 =?us-ascii?Q?YvihYkWcY2PDgVHB4YhqLK0ql2rEQBHYGn4TVuDE7k2/ImqKse9VvPMNrWC/?=
 =?us-ascii?Q?M3JTDCXSLMTBBEbg6gAbonMdbm/65YjulgW89kv4FRflj47hSeNGAjeQ0Gyl?=
 =?us-ascii?Q?ZX6KPTgBxK/TLrl7reoOPCSe6jYnQCT533QG0aXVDIOeWpiuEUL0BMWdLtaX?=
 =?us-ascii?Q?qYlDCdMiKNbr3KB1531m5r5H9HBwsbFYQlfJOhbifqn1X0p1ZyCd3x8Xw1z9?=
 =?us-ascii?Q?aopd4nppeDCxxVn7/90iKp6ZfjY86IyHCDmwnsRLCyajPKugRYVDDTJ1xFh8?=
 =?us-ascii?Q?OW15c09m2BQR1va3Oa/J99mBgbLH1BTsErz++P/vuq8lImTJy5DLKOy+qhB+?=
 =?us-ascii?Q?cjNQxCjbRjDIgw7KQx6fMWwTV5vyPmjhWUwQzVuBUq78W/cqn74Cnt+cL0vy?=
 =?us-ascii?Q?WXSm1Pmk0piuBTstOBpgmZZQ7ggh4odaGYpQksl8Q5HRufgH/04tmdikztWW?=
 =?us-ascii?Q?NpYO0B4V2XDQAkQp15Rzguzr5l1oXzjl6XLpz3iFPZf8+WtfiP7Q8Ow5got7?=
 =?us-ascii?Q?FyAXYLCz4IwHy2EaESlUysz/0Ith/ZwEIvNMb5PTi3ecvtIF7FYIjGsCcgEe?=
 =?us-ascii?Q?UZSGak4w8O/3uCacAf1Smq6X7GEWiERB7B3+hJh8Kf9IcNN03+ChdBWR0aZ6?=
 =?us-ascii?Q?yiwiJ9X2mGbsKuLz7NT/r4+xgHjN/LW8NwOjk5tMTMKtyYBoLSqLbVANDHzS?=
 =?us-ascii?Q?Uh2W+6yRmPgs1zYDIJQDW7CkoEr67ABmJK3kOW6Jn/nlpKQTYXz9njI45vj4?=
 =?us-ascii?Q?nR0JL/gUZ91rI3WxrkHC0GQ9Dbbu6T8DnPn2X26nCFoVDcRsQ8LI/Ux6Qqqw?=
 =?us-ascii?Q?lgzZp09csRckhkqwidKkc3FnSErhM8upUO2/Rdirss1Nr0xivFr0GmURO4+f?=
 =?us-ascii?Q?wZd3cyppNqRuOJKUqvbRUbAoihjkH5iSXDNcJOf9TBMFUmgJlOlTTyX6xvpY?=
 =?us-ascii?Q?+yWiEZY2DmEmvfAbF+eAt6eU1hmkRmTtS/8uyjYmPtQhE4kOi+ybLNtCa2nJ?=
 =?us-ascii?Q?IF1ubb95G93uLwDClhX1FQ7JroJCuUeFGV6GCbvL86uKxgi0PQKwM3dvBEiF?=
 =?us-ascii?Q?enBDiUuuWA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10ba10e-e118-438c-11a6-08dedd6b0bda
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:34:56.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5VaJDKrY16ZTj8sC+/yANvgyB+I9BhG4tLCWkAjnb5544rXTwxz/KFMiFSuUjH8xiUPBoF0VPzebzv5CCuu1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/ab8500_charger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 1813fbdfa1c1..bc6c070a564d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3605,11 +3605,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
 			ab8500_charger_irq[i].name, di);
 
-		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n"
-				, ab8500_charger_irq[i].name, irq, ret);
+		if (ret)
 			return ret;
-		}
 		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_charger_irq[i].name, irq, ret);
 	}
-- 
2.34.1

