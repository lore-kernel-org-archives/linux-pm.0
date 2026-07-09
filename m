Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012049.outbound.protection.outlook.com [52.101.126.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DAC39E9CF;
	Thu,  9 Jul 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568138; cv=fail; b=pyEKdwztZ9s9BawyW14rg1YTdQVbPmOXhUJ1t+jZDfu42LpU0zOULVHLglRC7trnu0ZcZuZuJ7YDU+z8+gT9r1PaoXz/in0J5YVYVcUPcpUXGWReTohUjdb5jjIUPQFWuJ+i9VKIEiPIO5mxaCXoPAI6jyndLRSm4Xbsh94bebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568138; c=relaxed/simple;
	bh=qC5HcFNZuqmggHvfkL/vEumM7wE8SBU7xaGNawBboz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGBDdpXtvoCZW+lptVMKLz2paHsSi3FQkvx839zspkzXOx2cJ6CYguTO7918HyBEY2tUMxQJFsFdC56FS/C5Yi0vQ4pND32bAy/8uEZ9bKxvmz2mEm8UxKi9UwvsWmqimwLGheY58WXw60ZKF+xU1xZGVytWwKK09v3a9GVxXCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Nq2E6DrE; arc=fail smtp.client-ip=52.101.126.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Nq2E6DrE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXQ6k26KdWpOThwIlL/RCTH7kx4qnk0ouWmvCe0aBnJIGdUt47hR5e4HSLyQjNsMguL6FNNYGVWHVNwNu9w6ctysIdgy7waHQ+/qk+kQiUB0h6HxhTFaaVEsEHU33fx5ZDHMoOfWrbHyTetIpuYxpVnXv1gQovFQczfL/DqF/9eYuKi10vHRbdHcQRWbLpgwiEj94+X6xr2x0/1vc1yBrW1IdJC8MuFkqfc5Vv0fMkrZ9yxpUT7nWy/igPxdwoIwBDPqtcJGCBLvuQsktNQGzALyCN3cVxiQ75IlyVX4VTZ+w737PVbXYZwZH0bFEsid82f0iL3c8eNP2zWoc6T+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25lV8tQ0qYVgiVUXbSKug4OH3+LcxH5Py0ID8aWL0jU=;
 b=pClayUXfp6cSRU2CCJX/5zL4ZbuzWqHLsTKWGx/fUbWdvRdDGZcrij07HOMzRAtQsHKP79wdO1RzuYPkIL1TS10h3b/maFHgCI0Zsa5dgRDvrzJFgVzK+VckQB5GusSI78zrCF/XhemA5FzUPPXeZDAKjwQvseeN5NYKLGXtxSQHVjbG7DG0KuW6s/5B0V14Q2v/A7Z8N98RL9ygFxX4YBx5HpUG9zZOgpePLnZTAjVcC4PMhxuSDqIzgToh9V7n1zKnNg9o8naL4FHN+XJXiRAvELcxgOVZuS1ePGQtlu2F6OQFG8KcpGglXJTL09s4lwYDC8n1m4QQGDlTVLX1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25lV8tQ0qYVgiVUXbSKug4OH3+LcxH5Py0ID8aWL0jU=;
 b=Nq2E6DrE65TZOGwbt8T1wvw5CtKZ2F8YBAsGWGsaBCmM8Xwz6Fw6mCS825NjxidHNZMYDpbJvr0cCuYvhHjRSG/wz8Xa9LlgIql5EX5Bi6tez/3u9VKlS2cH336caZ6LEuHta4dzKvt+IxLfYUOkftsgOXHmhn2uAmJc/lqRWQDxyfZbqcV2PlD9NIOF/FaWpZgqRYUDE7yqH0tJpTrJNjN7iSk1RFKJRyCEsI1c0euB9s3iXyfLeRyGJs74QvXSa8BImAcWQe+h9xiKx0IZ9cv5fMl0N1eR/WhznYOmdoSP9jx+dTacJbE5oy6D3uryBEmYjbrldQPsXW/32SZdUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:20 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:20 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 23/43] power: supply: max8903_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:02 +0800
Message-Id: <20260709033428.362970-24-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 883ee79d-be5c-4599-458c-08dedd6b1a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	t6C+9fhb2p/fwwMlk2Z3JpVxYF7AQ++RXoWX17u7xobo5hqUZ9z2nFxrZpGcQm5XqvAdOG5ISZPbrGvStd68qvVSEQ0rQHTtGS1WhccF9G8K2mQSW6MSxJe/HzZPRHfDQDCReaiwmIv654oeEcFf7K56Astibbj0qGm/gctRYRCuX/oDUazq6i0XwWCyUdVBU84h9TJEBqBCrAWUTtS7GLuaWsHVmyGT/qpWLm5ELVFP9PX/338ahPr261DBlu7IlAR/IFASZfjgjcLKo7YgOlTNPhpzYhEwzaMOFjGdfv3uIbXUImmVAj/Wu9tPmrzhZfXJKK9dFtLZp6FtYy3AYGJo9OM3SWP4GMBVjbEsQSKtBhU1n9f+FTnHGnr1OHHYPn/M7lP88/difJVzSfLjvPdrHvo89evduxkocOoxpfmn9dm16ZcFIJ5JtvKWXCmop+u0aYzyB35NuOIiTr/MDuaAJifQk+K1W9QVp/3a/1do27efbdpSu4O7/5I2fZdCSOxQDWWtY6fwhyqlLHVr6Pes+DATrmQYOgQ0MFEJhKUt+fsXYN4Zppijuc2z99oGLuB9GIQ6y+7MvLf4ksrBMV1mfnn+aBadS7O1DNvrNQzX1HWx5SVj0wMSjg+TArRGaIJU0RkaWs5zdVXlmUwZXNWThZqDgqWCx5zKT4q3eRhDWgq3rflW2H+z1s8/w6jCesTqE1OWGEC7rVbjQZUp52RHwu1jGL5/kXWCxMmNaT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wP7MmpK6HWRXK1EZfGbq+ggr35k9EXRu7bYJp34Hshu7LKq3WLVfqYZ/UHvn?=
 =?us-ascii?Q?3sRxuKN69Fo1RME3yWOj2pBY0Akd4ex5f1VUrabu7RJ4r1yu6+spVVQp1qkH?=
 =?us-ascii?Q?+K1RjU8aXXJl0/YOrA1gZe52QNkrmIOk1phUR1TWkkaBtRZ+6Ypsejhzr7ex?=
 =?us-ascii?Q?ofqlX3rbZ4eib+r8VlJWsWIH5ABq3w/6eF3e4NOZHjfBohafZ0td5dtjHN7A?=
 =?us-ascii?Q?WGGBzbh9nflnxsp6j5FcKkfC6xJ01ESgXw/Pjp8/dxeD4+lHsMD+ZLaZyqWy?=
 =?us-ascii?Q?tDkuz13npUsa5rWGcZEIO9GFDhZpx3zT+jRmf6rsMwuKPYp9XWnLaxflSFHi?=
 =?us-ascii?Q?3+ZsZdqPfuTW9OLje5Niu88cxhiplO6e8jUjoWxJ6sMLSt2IHncuGq1tVN/2?=
 =?us-ascii?Q?8ADg6up72SmfbrCvnw9aCPkwe88v7caQMK/WCxxZqtwWubHszA29IRC8g1mm?=
 =?us-ascii?Q?g1uLBnvm0PPDkZVBgsL/0bmnEVmqDKGL1ngk2ORwj0TTkyqBTkudHqckWTtE?=
 =?us-ascii?Q?0KKpHgLRc9WqHh2+Ioem5dhRW6AFIZ1qP6eTO79dw9q9IQ+n5ALODMGU61o3?=
 =?us-ascii?Q?807zPE4BmXStfVo6/Kako8Xhsc8kfnppCUewVUrVGhFeUIs+shwnwYJWPL/z?=
 =?us-ascii?Q?bGqUxK/L5RvHWqZ4AZvmMYmty2W5U/WChRKr2QDYCwHlozy5cxJiEBj81LJo?=
 =?us-ascii?Q?Y9/mhSIf5QhomBBtycVWMyWNjR27Nlf9FsGlW7TYle6iZwCAmFLPmQ5j9MVc?=
 =?us-ascii?Q?zPVBAf/SvFKtgW77FFfPoJWLBczZ/2MGlO2JAzD8phwrWCJ2M6Bj26bwzt7M?=
 =?us-ascii?Q?9/LYPUzhf6TWD/Y1XW2cB4LaIzS+JNeuYYwc+dG1NzbtyUJpOo682Pgg/GaX?=
 =?us-ascii?Q?EjLEqLkBw80ZmGx9RgiX2eqIWQPOSbxl3tg/tfsJjEjzhFVs0D89R8OjXlVk?=
 =?us-ascii?Q?bm8ZsXHMqEmk0SUf7j8fxB9vczO/bwArMKMNfVw0il2weulCmg0lgzCjKe7A?=
 =?us-ascii?Q?f1i6e+dPeTBXcgx4EurhfdrqU9JzdDGxAUXOmmh7TkCFPEdkYJHyuu2aGt2e?=
 =?us-ascii?Q?VSDMoSB5mCNiWnP+LTXcHydT2CuK16eaqOafVK/gvZLWNxK/fG8Aq+hqgIB/?=
 =?us-ascii?Q?gjLm0K/wb9SfWbc4qZAqXUoQVM/H33hCtKeqgzaweQoeHvBm66bBnSBtazq2?=
 =?us-ascii?Q?3ibWa2ZPdxnuEfhLm6MgXTmfVg3HMTCN+H0do7a0fjbHvZXHfYuByIjuu8RB?=
 =?us-ascii?Q?3m14UCTs6x6IENMwLbT8LDH1cSWZHA8MsIT4APEbF5h1JFNCN4JArZF5NRfZ?=
 =?us-ascii?Q?dH3vTAuCuCKe0Hdcp4spBKVMa1jZ/21BcrfdYTRs4YdI7vLZrp73z+IxIcmc?=
 =?us-ascii?Q?SC6/oMrOaI2xt0AU9B+AZa7J0W0N1MyfbqpdddKR4cfpmJfIRJDc+Ea0I/rf?=
 =?us-ascii?Q?G6sUdM8hi6+PcRXH6AafLSjAUgf+BXF0SqELB/fCG1h07XI/EvhczIAfZArd?=
 =?us-ascii?Q?BmU6fVtJJYCT5H6M6ZSyGG9WZYh9fvaBKLxgdf6qbbzeOugC2X2swYsz0Mil?=
 =?us-ascii?Q?3H+V7K1g312k+aOQSfbs364hd/0EhAUiqHXtCobLIwKb5usyfccy/gCLfITM?=
 =?us-ascii?Q?VdAx+nczoBZ9iEv6ZkK4xISKQnMBKxuj9s4K0gI2Xk8JhiITlShs2GRct/Sf?=
 =?us-ascii?Q?3mRZ3LTqT+4krCA4zcvOS1e9IgpNAiX5Btua3TGU/0yVkECBAgax/V5sJyHV?=
 =?us-ascii?Q?F70GAnQOhw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883ee79d-be5c-4599-458c-08dedd6b1a30
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:20.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV6RrOVjqyXbtybUdR7/t7/9kuV/+JTDSPO6FfRH7YcOQBqidCS3GpsBSYQw5xirXNvTWaqkkrqZtOCKthbZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/max8903_charger.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index 45fbaad6c647..47334bfc8381 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -364,11 +364,8 @@ static int max8903_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 DC IN", data);
-		if (ret) {
-			dev_err(dev, "Cannot request irq %d for DC (%d)\n",
-					gpiod_to_irq(data->dok), ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (data->uok) {
@@ -377,11 +374,8 @@ static int max8903_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 USB IN", data);
-		if (ret) {
-			dev_err(dev, "Cannot request irq %d for USB (%d)\n",
-					gpiod_to_irq(data->uok), ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (data->flt) {
@@ -390,11 +384,8 @@ static int max8903_probe(struct platform_device *pdev)
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"MAX8903 Fault", data);
-		if (ret) {
-			dev_err(dev, "Cannot request irq %d for Fault (%d)\n",
-					gpiod_to_irq(data->flt), ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.34.1

