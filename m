Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012057.outbound.protection.outlook.com [52.101.126.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CB3A3E96;
	Thu,  9 Jul 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568136; cv=fail; b=ss+aeDzIMKA/6lnGdUs/wjeWdqBdOWSWFre955PVYC83idSw5Y3wb+SjNanUAFlODbSU+Wpu2cVQYeaUSIiOk3i211/5duOqSwZoQ615Yakw8/1BfGWijV4UjOY6B/pWVM1rQ4v4pGQVitU00f7vY5BbnhYUMfki28Vr+6kYkik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568136; c=relaxed/simple;
	bh=a4qYSgnz7fn4CSVVnczuaA2yD8eLKtlNUT2SqKzVE+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9R0/nCrd8cGmWLMmWgpgwFvAB6Es8oV3y9H6qXZRWwcNThEVOVgpe3O0/CcNpAvGfMkYCjvMAWxQ9VsthDRzxpkaIaKtw/ZoQb+lvGEoGN8wXkpy/4wysnvDzXjUInWmmOebejIi0wSfi835OawU8dLk4tC0Vsqw0BIsQlsGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mLqJnl3s; arc=fail smtp.client-ip=52.101.126.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mLqJnl3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpGfyDsYRFI5bUlDk5ZWci3iA2F54I7dF2joTHYwGjxaFRioJFyfYWtfPBHlMUnro5pAcXWvrJgJudV7hhoJmjgLNWwff7/Ge0vjoAt+OvJd5MeyFBrDtwxBb64okOlBwK1ZDyp44frJatT8iYrwdlHXWyUF4YEPDAxxsS4MV1OjD1csjRPQGdlSJlX8FYSwmhqgzITPnk6HgNcGdHK9XfNUqOS+UO87uHa4HFpbjs4EtF3DQY8/0oasoq50MuCzxNwF7zznHALuUNg2hB8k5jgF5o8wEKU4XVD/k40NzVFNJ7Ozy63vCFv/vYFCI3Wh8FXjFwN/jc9aLgrWQiPO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PihRxhLQxEdN6YpeVvRui5fm7dKQ/QaPILZFm1DkjI=;
 b=wdjA9MlXwiJw6G2eeWjG8npazl2rHA32IjePJDBPjaFn9pPr+f9SzglPk16P6pvHDGgcvPk8/gbXQkfHijW/uQGL1afP7heOMqtktUO+E/xUXZD9Ux7HcQkODk1VJy2UMJwRTKR/UOUefqBFl+2SbsWy3ob0yTeoyt3aSTDJtd7LhLcLctGuqtqqtocSn6pOB+CJNA0X32ezvBkw3PwLOqK9KupbCvC/eP2L4prcWGFhX2gfcz7cUtYL1oTOEWuMME6hU9HB12ePUARIhhMTVJcigehnIzHtfe7StoJ94bDj5ir3K7sEYkTxHgDR3bVgOMBxx0rX4COJ37WuLeEs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PihRxhLQxEdN6YpeVvRui5fm7dKQ/QaPILZFm1DkjI=;
 b=mLqJnl3s2N8WBL3DoPYN7PxIk5ByofrnsyogGfb/nvAquo7qFr6Gi1aJVNd1FOMyyFUQHiqmn2cLu1Werx/BZyYZHuRUXE5uy/vBFHLNWDzy9kvN/gQuSO+rSHafcLI+W9okfgz9QiLSUHJxlbWYbmkMmJK7rJWXdARZkMCAGcxjzk3SnAKDFuKvkRSEEQ5XLmq/Wq167HI7Vhy49RIxF3r48InZbaeTVvCjqWi7/9B3nF1XL4JvZvtOW9wcZ4j2mJo3OU2TNIlh344N4AUpVuwDuMdw7pUo3gzHpDAVXMAjlyp9PhoooLXMntxKZSNmvPub/hn3kM5pvnBuvNHK1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB7253.apcprd06.prod.outlook.com (2603:1096:405:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 03:35:21 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:21 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 24/43] power: supply: max8971_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:03 +0800
Message-Id: <20260709033428.362970-25-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77f42e25-8478-4074-f702-08dedd6b1af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|52116014|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	SBUbIglTAwCDgLYmXakETsidwzsq1zZNHjtQuFFAMTaWz9nnFUaXucJt/QrlVu1TRXB0FFLdjay1PQxn4hPUlVtasSnoVoqvkfGWEi7FqGJvUZHGeyScsxFMaGGgYm3arrR+9mtIaEClMSOaHm2gR2fzxKaXLt8pcEISFBFzBlevbbyeT1OGhk6Ios/MEZer3hR6+9/oXeSMA7B8TCJowVX5YDf9f2X7tVBZwDGiEIdN/dqnhzqB0m5KBS+zEgXDQCHwF6q51FgVckayzZh3koKKwHXi8vnnWNJbbxxz+ldVvnafWOMlzCY8ctegfMdyBbc3Yu5BbkOBDrtdi7nhLL3DC8TbXOOuyR133mbPoltkVKmKe9tGotyhJGg7oNrEEFlLzo6gAhLzNO+90LxApwNZuT9vumTGspNqKA4mBfS0ic39OiZDgpdWVW8XdzsF6+Td9yLXlZ/4dYrKLrR9dDlUPXuoOBCDkrkNYGWcwQW2/aaI+lXc11b67A9gvOUlLyeb+OtlzE8RIzbYvWpJFrhYK1UjDzY5PV2iWTE0/md16TVobejJDIw7fczVqL8jV4icJe479kwmrnkm4FSds38oWPZOC70DrjRtgQ5/aKTcbT+CjWmkCr5gmxTSL8M9BiGK3Ej5bOOeQAhipHq0LPJ4bK5xT8/boEMrEnrzivLqWJEqpwbR6AfWgY2/Sk3c8+qw9+ogRi06EiMBUobpE4xIZ1+lZQV/xpxIeqK8gu8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(52116014)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bK9trxr+xiXj2ILnkJV4SCZUTnTXYV3vbRvXGY/1a0sV2lviiK6dgfvOqZMl?=
 =?us-ascii?Q?Lp+j0MACkAEaDiFxrh+rytNoFdy0LUtNpWxPK75JupfD0VXxflkV5QF6XDz8?=
 =?us-ascii?Q?c19p5gElaoKWwvh7ehE2iqhFgaqVomhgn63eYw2sepEFDetijJte0Aj6AuvM?=
 =?us-ascii?Q?jioFQQGrYbZaxXYCMgOIjVYzcn796EDwdOKehla06nhF4PJ7bDHJt2xIFtjt?=
 =?us-ascii?Q?mAPMCm7JUBHvTBKsFmDCQrmo6JExAiwr2RexqgoxRJpPpQr1KAIMWzfzKr49?=
 =?us-ascii?Q?wT1D0FyUbMAJQ1qsR26EaXs5voY7xWIwsZ97c7Y2zZ8yk8mcwBnublGiXAOQ?=
 =?us-ascii?Q?nIjFIfMQJQDvrpAHdncjwxsJveeMI/+RFW9AQYdi4pvGPtUpCMq5/CwQKRIU?=
 =?us-ascii?Q?yIXaQnX60ocWEYuBm1bQ6CWDJhzJDODKcyYz4ottfyfJD7dGGn2skjWBaaNF?=
 =?us-ascii?Q?Pnmsa3d8Jv1OMekTdKiociqOYlM4i1GSB5DPz4vXHekNI0qqRbvhHHB/qyOP?=
 =?us-ascii?Q?stUbiAmLu8520Ni8VPIZ7hl5wI+FitCz4dZzzdL4wkpYDKRIbFxTK2p8cYBf?=
 =?us-ascii?Q?UK6Dx0YyIbn9OiTgQuWAvA5YE6QAutnyYOJ5Ik3nEdyaU0GMQnHwCwjdxc/E?=
 =?us-ascii?Q?rziVNC9fV5IqWAQwCjFtpWPJZOIUGSDLQ59gl8qLSfawzhNb5zfaoN5gm5v5?=
 =?us-ascii?Q?lQ4pRcq/Ej+ZYPZ7SWrAuEHQh7mrGav81l8/ipL8ZHJlJ0fbdNAgiWO3x3yq?=
 =?us-ascii?Q?4cFb+IkzIEUcRmf6BnRHGV0C3Qqsr7G/PxLr5abQfPBWcnDcqBRAt8LRJwvD?=
 =?us-ascii?Q?Yvs3IWkTJEkDUfsifAT7JMrTRIprnHRLmpYUO9xiTJwBmdKD0hmKjOVU8k2K?=
 =?us-ascii?Q?kbJXWFHPmFD38/LcOwtJHjyliDciSLBgCx0AJ+EFCcfxaOfqb7HpJBvvG7CU?=
 =?us-ascii?Q?lq2S2fAU6QXziUSn9gAx0dXYDIU51IFuPBEtJlrFF5PgBKATKViffH11OyM+?=
 =?us-ascii?Q?PyxVAvhkf6bOCVUmi3QtKa0MjQox8tYdEFJOlg9SW1M8aLiePjKFrBLeyTyy?=
 =?us-ascii?Q?68AOKJpkxkotFZsll5HwsNNpfYi7ixMt/+lc1v/x2I1fWTVhcLOABcfUksQG?=
 =?us-ascii?Q?ro4rdXGnz9pOAj8Lhk4NlgHnAbT9SI3wp/TO1gmw3BY7iN9rN6Ok19nhQn2Y?=
 =?us-ascii?Q?KNdSeGpuoq2IiuBtQXs/x5I2DDhPY/kLYCAd/VVENn2gPVsBw1v78DjhGcHc?=
 =?us-ascii?Q?3KnQ8xoNgBTnGOWOV54qIVTh+avff3V+RuRHkDjjO0laEW1WAlb6cIhfpTCJ?=
 =?us-ascii?Q?J76m4IRJMhBSHzHzRlVx59bjelr/Cq0V/j/vukzIxyWChL8Wa4/8nlkyh5Er?=
 =?us-ascii?Q?tYEzTgcvuVmJdAyjvS1BhNU/I7HbYMb/EQonLOpVEzSxYqiDh/YwsvEvKOd3?=
 =?us-ascii?Q?b5cmN3KGE/2znrsGbChP7Zw/R7Mn2kM6yLsNLuaMO9gOO+F+YNUQV0CweHea?=
 =?us-ascii?Q?Wtz0DGKNYTSTQKD0c3SC3L0/fknir9dE7+ZM06AZN9Qu2ypY+TP4VVcGcUaG?=
 =?us-ascii?Q?CU/5JLnlapes906teG87aV1hH83mwpeH1yOglhG2Q5mGgCPr9wt/tZlekR3f?=
 =?us-ascii?Q?9tcxDxSJyfAWGJpog5+peb5oTCNo/mvQxMppcnW/fRjbk/4KwhJL6WWjdZJd?=
 =?us-ascii?Q?4GmdDYn5/vTN6KU4kIMZp42CdUVynd97a+xOz644YcWRPDpR01Kg2KO/3N7N?=
 =?us-ascii?Q?uRHxde6V9Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f42e25-8478-4074-f702-08dedd6b1af1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:21.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTBN0wR8fK6T2+Era43ranTU54wUnDtSLjp3i0YJxg5RRUDRjehf59h2sOWzZuxyrfJhFHHyddWONah78qiw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7253

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/max8971_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8971_charger.c b/drivers/power/supply/max8971_charger.c
index 82f20b89b6b4..0d69e9f44c05 100644
--- a/drivers/power/supply/max8971_charger.c
+++ b/drivers/power/supply/max8971_charger.c
@@ -683,7 +683,7 @@ static int max8971_probe(struct i2c_client *client)
 	err = devm_request_threaded_irq(dev, client->irq, NULL, &max8971_interrupt,
 					IRQF_ONESHOT | IRQF_SHARED, client->name, priv);
 	if (err)
-		return dev_err_probe(dev, err, "failed to register IRQ %d\n", client->irq);
+		return err;
 
 	extcon = of_graph_get_remote_node(dev->of_node, -1, -1);
 	if (!extcon)
-- 
2.34.1

