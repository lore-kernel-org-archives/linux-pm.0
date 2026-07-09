Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41B3939B1;
	Thu,  9 Jul 2026 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568129; cv=fail; b=h7IqXN8xKRFaRRYTKxLZBDM11irDGfDH8SZ2nlQ0oWz+rOAg1Me2EmJPL/LltOfY6arqXG04yfytsGsC37gVH5n2+RqjaaQs9Ivyj/JYlQC0DtuLBgt2LlxnDYwNj2kDYLZXwV5/9RyALODurhAIMBtp12u2/kotzyVIJSED6l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568129; c=relaxed/simple;
	bh=UeuwSzkxxb0q1lIsDsmA6MFpL/j2eSdF7z6wZRkzUTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nor+8NtR32lfdykjY9+Bz3oinoSiwgzDM/dnRbS31ogF9d24r81qP6BA6d4DC8SUowNqWQybdzgf4fjuq2+GWlslaDpXJ7lq66DbPhT5o7QGyXP1gW1QtZSMJSZkpVpqeeopA1VNNhMNcL0gE250toygknI3S+cSKTGIy3yKZ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XWRGm1fZ; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XWRGm1fZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChiMBqiZqmKMR8tdKEDCb0ni2kzriJcMIYGVbq/MvZOkCTQD9x5zD/cfI94vQ98TD4nmpPDH2NrC8JUNTyFtzhDY5RIVF85naaSQzQ5TzB+KrBswYm5vCKfv427nSZA+5qjja/MbXMHsnRnpXAdPUuxqjp7cgs/rNauMnEkfX2zXUcy4znLaXxenILYOFBEch82XFv4fYm/z5jem8H3u8LStFf3H0RtNv8lKXRMgXACqRxreBNqXPtPPA5kSyU01rpxe/8s1nscwtmV00qm7s+dS3/sEhKrLnNFeGDycz6fJ4EspHDr0fiMsc+VRJCH5KqROJyW35C3FA0R1QDkiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC931/oT3TytbNTL/gugj+ZLtF5jraJRI9UNaqol6oA=;
 b=IVEXeYvADYh1F9A201zBleYxCvQSplEGgLQdcIjtdI+VhsBGnJKem5iy40IjN+jdcn/Sd060h0WtUxDzFl7aUvJsFW3CttO4IYfSNEsp48MIqeGy6qgJEuap5lRGlMf5pg9ijjNtOWELopClDFA0nAJu9Btl7iJzBzr25rH0L2b3nlCZr+iEyITHjzAFjWtoz16k8o1pzmK3/mxj13aD9zJ5ZJbiMsgfhyAcNGxdE2ynumkf13ENCzr7FbzV22Vq/SWxWXjZLa5QRpgjZifYzzER1IJN5xhGmue4xZ/dh4ISf93ubB97L1vkffMcpBs3HljZDpwgh2qyZCdfLahiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC931/oT3TytbNTL/gugj+ZLtF5jraJRI9UNaqol6oA=;
 b=XWRGm1fZwiigLUWxlZhs/wauSaHbbHLxeC/ABG7VAzsf+byN0nlSuEeUP+zz0gOiTbqjwUc0pzeHwsWqoULdrtuG+VxsiCv0dd9lzbbVz8MO1btEY8yV61FSUi1wEm0s4cZZoKr+RoJ+YIQMmGgtOkhiA0RuB233hOPlkn00PlLlD/tcoGl2anGG0Zk3+wUVdBaVOg5gqJYp/aQB01vcGSdS6MZg0cBxOlcoo8fIs6zt68+2kN9gzePXkVysO9gpjnopP7OZrU2jlWsT/vRPkf8UaLClNrnSL4+Fd4b6gYwiYBAC8Nw7DjiVeiE5G5VyvNFQ25k+m8x2VndCO2sfOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:13 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:13 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 18/43] power: supply: cpcap-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:33:57 +0800
Message-Id: <20260709033428.362970-19-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dc614bee-0629-46b7-4c5d-08dedd6b15e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xLBNSh07qLt8dqRCs3orC2KhLFSyM0YWV8W0bJzFVNSxehbdfXM9NOTFewMzXfNQ3eUYb01c/RUq3W4Vwe6bdbD+zgLGMmV9ZWdGV5hh8KKWK85X3DZCDbvrHShbxWmaYZaz6sCTq9N6D3Cog+7ku6vM/SmhvfHle13wT4B35E9J1uQFyQibI2l1AtoErxn14KRrvtaF0ZlPfc3ZnTcADbn3+feE+MLRLJhjzUwjUsNkebUrT07IDk1GyJBNbnSSWdb1ubCmR+Z7Bplh4Pw+eJu5j6jB6/pY+yh7qOkGiePbYXoSgAzJX0fQn08SF7GA0NtdX/VRCQazF7q2dzylpVd4HGgEJKT3QYkyyUwrLYZl2GLCJqTiyr49b3ZkX6dPdUSQ8qYfZdVGcCLLWeZ4raRIzJ96zOgwrALg7B8oHNJRax557xJ3mA750O3USHRrzs1eK5LBTYslk5vXMBhwV+VQhdj3j5+9HN+dEkYWbvmstSCaENdBzwxpTNdsjHQbRy17VH029E4yYuNFmLcg8Kub7CyfNFqHNGepDWuvmshVJ1UkpBm+Qg9vxiGmbMOaeFPwgW/yMyf7Zbb6uxzOyw16PDdtDTorLMgarlFMnA5NyS/Aal6ab2rcRMHHmPIPOhiRdW2tnMjVRzF0Vb9qfswI2rm5WKFYc0AlDaMXs8HZ/rs6b0QTF3ZfKFmYuS/XsM5PSB2qfSsrVyqqTyDGTC7UQzWFtxnuAmNXCQMJqMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pPtxKYjg21vxDee3SNqtKoCaOo3Yr8StMvliVwYM3JvX/vijZtO0dMU3EcyB?=
 =?us-ascii?Q?EgV/1Dd3jrWY2NNXg7BCzI/oCdHCoEyWXgzicz2m5AVUYg2eA2t8uRtdIj4p?=
 =?us-ascii?Q?u49AzxcA/Kxmxl2T0h2Ig1jJKWPbMJ++aLk2zmZWZaDC+JwUY9Gi77S0kZRW?=
 =?us-ascii?Q?wXQDTzbGvWEh6NJHI54jnKR0S9aSqWXcPYNFdYcfMEC5mHzjIsDdewIN56+L?=
 =?us-ascii?Q?ntSpFvDaZ74F8cErq899eXkkWV5u/7R6IFUwLBfjg0Q3Dqn5PgDbRKnt/PjB?=
 =?us-ascii?Q?RfFiU67b/nhQ1U3YJJ4YAOdxjsRiYu/+nDxdWHt3B9MyQJ+W3ah6BskxAHbI?=
 =?us-ascii?Q?AjiR7mMPd4RRl0LoMEc7s9o7u37XuwspxBv4pgu5uHDizThi9L+JHehHpyNw?=
 =?us-ascii?Q?lND1VCG3K/Yb/aANR0YDcyiY0app9ImVP24qKzO3WQMcganFRiXmvATTlpFG?=
 =?us-ascii?Q?6G6AJ8r1vO+En8QWg7TJv74Dt+fMGf/Y1Oj7jIqT9PCQwSW0vVFtDJJlAEt8?=
 =?us-ascii?Q?3LXUvK1zta5Ownolcej9BND6sWrXzsPEshJ5cZdQR+Dp34vVmtBKQa0iycR0?=
 =?us-ascii?Q?vrKHgbow8tG8sJqnc8PbrK5tFf73/u33AB1lE1Ql2sT58un2nnmst3TrQU5X?=
 =?us-ascii?Q?bOkIREX11FkapnBeAWg3mJk3DAcT6U1uIV9YIl2vIFoIC+uK7ZN4eD6wc1El?=
 =?us-ascii?Q?+NwAEUJxdLdLLQYuEOqaFg+sBz+NJntIMSeuWfIBtVWfZLaARoJ9c7CMcXm1?=
 =?us-ascii?Q?UgMyKEYxYv3GHgZ9D56zHnVsjv5x45+83Xfo+83GUdDejSEC3OjM0r9bmzaK?=
 =?us-ascii?Q?JLc9FXmH+zgONGhILr+kCBKPCFNjkEKaQKbaCqmIhP1D+c7CeY0aZiJpaah0?=
 =?us-ascii?Q?3ShpO2HwxWZjJgZF0qRqjyKln6ObhvJwtvHtq14Z+LVmhlyzqCdJpH0GBqj0?=
 =?us-ascii?Q?M1t7FjvFJoP+vcyE7IP91WIZwZrpkZTZZ/GwQGhnumlIYb3YBRyT+v+jWgio?=
 =?us-ascii?Q?myr7vtdig37GT7QqYwIpBPoC5kc70HBjOoaeqQrkTP2nE0mUOCEEFiDPdXsY?=
 =?us-ascii?Q?wWfPhxWqn2WozG67MHSgFSsGfUogaeeYXEqbq/MmsiTnEExV6cXonS3TCVVo?=
 =?us-ascii?Q?gYSSfSGZCVDv1/Oftx02ZsvugjdTywr0Cmd0NJTBfj3nPHZBF2LIzYil556J?=
 =?us-ascii?Q?Kv3Vju/Dc39dsDet4sWL63pzmxWPtkEHXtyDS1vgZyrO8alPrM6McDi/2elK?=
 =?us-ascii?Q?gnV5/6wKn2HfW/SEwKRUqkcWK0ItLQWmBTrBYyubI7FsykCYQ3AhznhFDDET?=
 =?us-ascii?Q?BXyHuQ1aKiqA3PVAWqSnwtOOMrTtfnjv/Wxzh6xo3cnOnJP2maeE0sViHnug?=
 =?us-ascii?Q?6TmKFg3B7nXzppXIVputP+YiplwWJWDfgBdym9tFYjQ8sljh1JdvtRYFvgpX?=
 =?us-ascii?Q?sazu8l7B0jDaRbVWZD32xBxeZI6LdhI2ODu7vDzgjSWUcWlfh3grHxC7ot/w?=
 =?us-ascii?Q?k/hK3jrkRdaD2EgY1LNceF8pxoRrZrqz4UTH/lpbV+tY2R20aQKPr87WJr9Q?=
 =?us-ascii?Q?xgzUwZg/uApbkz8PYNy+uZxPjsFmYS7ZNKDMVb4TSn3Y7zkhedcTTUHGoxH6?=
 =?us-ascii?Q?M6f17k930qfCCjt8kZZECc9aDJJ0GiiNav1dk8sRmS8Kfz7OBWsmUkRBc8OB?=
 =?us-ascii?Q?nvQdrCnRPH0QBA9tf8iI4ZqHcqjDWJ2D2mlTHzris0EhPThLxOvlIhqqhAB+?=
 =?us-ascii?Q?1ntWenTn0A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc614bee-0629-46b7-4c5d-08dedd6b15e2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:13.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plKxZmWgZfoLptyIMcLF15d+vYmueCSng7C0KOaOSn/WYkSAMKLhO6KNO4vkcs/bZQfVRg6VvqV5MW32y66vwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/cpcap-charger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index ec8d2a9245d9..76e2d2e3f5f5 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -761,12 +761,8 @@ static int cpcap_usb_init_irq(struct platform_device *pdev,
 					  cpcap_charger_irq_thread,
 					  IRQF_SHARED | IRQF_ONESHOT,
 					  name, ddata);
-	if (error) {
-		dev_err(ddata->dev, "could not get irq %s: %i\n",
-			name, error);
-
+	if (error)
 		return error;
-	}
 
 	d = devm_kzalloc(ddata->dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
-- 
2.34.1

