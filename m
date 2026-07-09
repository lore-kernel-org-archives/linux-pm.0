Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991639D6FF;
	Thu,  9 Jul 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568134; cv=fail; b=CQMUOgq58EGRYHHc56fjHOk3eMOUIhYjVDpKRGB+HbIpXdPTbXjXHbOxereLTsmTtv9nl4K2BotDUEB5VqbMftmsDaiHfvxMfxeVfnp4x8m/SqtGrtHeEV0u1ZL5ZmoDSmYPly7ooMu9pXKgph/492B1vv7OkyhUs7KQLDnn4os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568134; c=relaxed/simple;
	bh=a1uXh9H94sd58n6ecQOfRxYSJY2NlqN3acWDZsFtXhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoFnWxjOrO8KLYa6JslBAgqJpepYZPP4olzAx516wK2dVsR1agT7232o19YCvgz9EXRz0x9vaGb+c4uiy9/x0FX07sOzku1x0SL0MDPgecnRhW7jUP2hyDPBJcWegQvV3435A21KvzIG/RfAOPdPIqyBoVw8PrscZo+NdNr8b8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fnPvQwnB; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fnPvQwnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDRDUrByX/H4RXSemG1TFHt2/ZNBVjINMoH/+hhBnNWgYHpaYw0lXbbrgfhsoQ2ikuQ5s2cVtyfidNvJCqnoqUBe1kRzjeafWrb/U/Sih2ysrPDknq9m2abPMcBDOYtADgqcVRf9asDK2WI1YiUKn3/UzQvg1hDJUjxmQTAn5f2G8GywWM7YiCANttaaiwSHRGnVcm7PhyELUEX2FDNPHHYRvwWfS8Tcd+I0Org/hn/otk+Zy8BE4N7sITMDEj60Os/7cPfpPgdepDMlp5SON/5ppFFVna97CQu9wY0jFSXnlCI2zhqv+9SF6L38NZrMP+Yw/sc92K1FIEJWinW21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rqJ4rUml8UHLCqe/E5dm0gjDpyRf57gPfd5m9tO6wM=;
 b=g4ZzwYxCTk7tp6jofjyuVItQH95Icfqf594DhNZtY3RilxNFNoDma3/XlwLhetFkyRkF4u+mGafeytAn2DDOLNyrKK49eAWeKS5smNY2CNWPCsA7Z5pDApIqNM5tLIsy9xcg8vZmV97Ra9eBnEk8pcktskEcEarmeFh4IDSsiRGKw3RmqdEcFALaoh/9UroxAcbL/PWM6eBK+aV63sTI9/VHih8DIliX5EmhCWpbqu0234gbPIU7tgVACyjvowTw9MnA2cI+06C/DUkVpv1Y9tiT0iTQKyY/+4z5+04NUFS99Xna0tnfWtdNvDAZ5cz8IfWoB08f7IkmRaDqnd4RUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rqJ4rUml8UHLCqe/E5dm0gjDpyRf57gPfd5m9tO6wM=;
 b=fnPvQwnBpCEHfoZgiMALisycu8fZThsr5jWWfHP0xEbdzcZPaEbnZiRXQehmj219/fwxNcdRCctFp7wFzK5hu+BdegriSCMjNC5qJEFz+Qy7MEoS5oAc2DpjEfSck5oA+z4loFkTVHbDveEEHAhW4nKTiImeGY1DqCWg3wQITb1dL4b/URORJEteWbxwZGyDXuT2aZ5ZGu8fmkhxd2Mzf7VnnZEsLEV4DgblTlVdAHgNqWpHdqOrzsFPjARLdTh74R5VT8R/vh0tiyhf3ii1gsbLjdBrnVO0YBeGV6y6GHuXPQx/XkZD8uA7CThvUhvhkojzXWX0tL7PqqZkfpmfAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:23 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:23 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Saravanan Sekar <sravanhome@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 25/43] power: supply: mp2629_charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:04 +0800
Message-Id: <20260709033428.362970-26-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYZPR06MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0128ec-532a-453b-5941-08dedd6b1bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bbkXQzMv771KuEKRtFQFgVGnKc+1Mcx2HFp/1H56x5U8/COd2KdOa6i7PFrgpQfyMK2sUw6PBneQFDiC5rfQKSOqu2ghruLmeM+qqoeYVNuWMHBq0N2UHxtFxl67jOrGj08uRldUIoRuAWXCa56Af4rR5AtIYL+MKr0P7Ix2MUZvh0k8EB2s2fofstucKwJgTXN8tHQh7TLxUAhx1dtHcpGW+XMQKOqHl5pvJPEXLQhURs+q6agnkycGJB0nv7a1clAdNf4s1778p6+W+CwGoPHxfJDbTyw3cIFAyrFzMZJJc9ZZ13NsDwdFuI5XFVVBPU2eD9Tqa1hsksGW+PpyqlAY7H/VchlS81MSjUQkFmtnmaB45YJxCMvmHbA/gd7T4Z97nSMR6NocfEOUhX5aaU44lISqMAzp1dcpOOWHaDSyzxsmYdqCrONBLPALAy/H+up3xQsG0Eoe2Ks2twMWQtJ3m9FvjyqFK76WTFQY2Lb1YNMG13KlDvQFE8BAG+9kCFEyLsbaqscc1Kqhs7swghgImn2EvLknoE6AnBzsvIwSXaqElwBGkF15y3+R+SKSPDJQfE5Xv3Tq+34NaPTZ0bzWdiLXI5DP04q4Bvyhig7C+CXvMCWV8wovYL86KyDDGu9YQKvm5BBB5Qlly009XChXOHkCBd8X7JiPyq2EULKFRd0FDPV8zEoB3kV4QWiH65H2CuxioKie5deWZArKFVCR6rCKP+w0zJy8N3+DnJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RqveFRrOZ/Dvn3P9IMy5UvseXp8NRe2K73hU+WSeVpasc7r6HEd3S1XHEi4?=
 =?us-ascii?Q?LpDRKoi8Th7h0SOCj4D+F+qh5mwztstuwyExG0M0Cx9peqUpSpCU5NJ7IK80?=
 =?us-ascii?Q?1lFBIWfXTjtx7tzsw0HhEulFgHdmGvYVPNV6aR0Ky9N+rx+EGePad6ckr3oR?=
 =?us-ascii?Q?XO6HGkxaeRe3NLAGW16zmYAtPwYQQLtzliIWJfhK+Nfvq2JuAqyxPqSDwfq/?=
 =?us-ascii?Q?07r8HAP4Y90mdVgRgrTK1EcDMSFqojyUg8V3yHMIW51L/nQud9nBbNtfAwtm?=
 =?us-ascii?Q?QFgLaiENDGm9vW8it+k53vAK2uDE8iT5fYehnTcsFYIQxIEi3Ee4wQHK/dmw?=
 =?us-ascii?Q?yGpW2MeyZzD/TWNUzrDSZlwPySnTjtKGoMwAk4eI6RiLJe3prl4syjU73E2D?=
 =?us-ascii?Q?ZgHUMducnvIB0sZLD4c7I6qqQHxdbLLRT4c5s9LHOhp4CuFNAtN92qA58xPy?=
 =?us-ascii?Q?imvrvv8qdFYpOOACAHbJCTsFclFh/y5exo4rT5G9Nq/IrB9oZxtdpy+o3fRa?=
 =?us-ascii?Q?NPAi7KC+WFUmB56yOdhpFejWKkbi0vc/44mQJ9JvMQz6doj40fRf+djTVNZ7?=
 =?us-ascii?Q?1TP50JGkkrw5BeS2uIEpoC1H2IS840OMSm3iSI8q8sKFoiAcTB7mw2xLKOpu?=
 =?us-ascii?Q?d6DGbgP7zPw0LyeOVdj8Jz5tZqWfziTxS0yywyBTV0EsX3yybUNxsc1VaGzP?=
 =?us-ascii?Q?GkkLBm8+xIOjcsjvZMooDdV7wIVjr+Z+4IKjh0QjgqjpuVNsZps0fGSbevgh?=
 =?us-ascii?Q?3rxo0de4Tjv7lK0RBRTAQ7tXBradW6Gq+bvnYqD92iQi5csdJf2Z+bHyUdEF?=
 =?us-ascii?Q?uNM6eQ4voeVFmLin99JgNE/qffZAUPCQltdWkL7Td/eMdAR+AzWLWfMyrnVn?=
 =?us-ascii?Q?oe7rFq24SWpl6rBPTkLOjL1JMGj5LvmQUWcsMlxH7aRFTzEDyNmWPHak1lS4?=
 =?us-ascii?Q?fmXhdJ639rywQOEXvsUFRp/Nk0y8RDVvhzVAO1mHCZ/z056dF4y3bexWzAoL?=
 =?us-ascii?Q?zPw8H33y6PyB3EHGSkWnUsq2oMqzu0+H2jOeBMfxak2FT0rYN60rZCMMIhP2?=
 =?us-ascii?Q?0RyFqkJ6M+bSZw4hxXX0f/QwPjMofpVzX2nksUz5q0dQ3EHOpJOeGgiVn6Ec?=
 =?us-ascii?Q?zRwHMfOJV2dyvuxQq0tf0rGDSN1NSdvEDb+loug+T3BGHNLGX/e2QEp8LWl6?=
 =?us-ascii?Q?rRQWcM8CkhAVLDkscQ3LuuEd7qeMa75mLlHteYcaJm+xnGwDh6uRnoZZr9+X?=
 =?us-ascii?Q?CGeRFyvZmOexpNiND4eIsBoi5QiCzSKFZSVS4KXDPVy350iq4UjjpM6m2Vai?=
 =?us-ascii?Q?T1woMeZYQkVWkMUakvA496GNph1P0XGl1B4kjlaE9TIcUQcsFKC6BclCt5Um?=
 =?us-ascii?Q?y6f+UVZwASnB0ym2u+TAuImGhBZcjQpozFerdw4rP+O2pGR73YLOpTKCDK8i?=
 =?us-ascii?Q?Nt8Neqes02/61M0sPyoXauGhdjfWxaJG0UBsutPDuOy0NszJGxzgqkLRueRD?=
 =?us-ascii?Q?Rk/d/0VIJbzLu02aMcwtj0/fYeEcZZ3AUKMgWtCyV/RjcgwPfppnwZu+H+Xa?=
 =?us-ascii?Q?0VKUYC4hK7cm3m2E6j3shGDMfJnA4mz9krQyJmfHNg1OeCls6G38Y9sv/FOo?=
 =?us-ascii?Q?E8LFMNFiEBErlmjyB6ySx3K8QBLHuDA/NR5GfM/yL9HyKbVL0rC0SY6oLLek?=
 =?us-ascii?Q?+nXk1OjAp815JCc0tQ05jTuakrQlRmTL0a5bOazZl4wMKRCScRJewkUgRTR9?=
 =?us-ascii?Q?RP2TCroDvg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0128ec-532a-453b-5941-08dedd6b1bc5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:23.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmGKBR2FpvyuTcWxXK/CLhD8ZQ559fhtTLfMwGof8wNFVHEtaJ14qX5bKYz+VDHEp7JJBorEi8yTqTbdVYG+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/mp2629_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index f758d6a7bc8c..04294359ed7d 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -630,10 +630,8 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL,	mp2629_irq_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"mp2629-charger", charger);
-	if (ret) {
-		dev_err(dev, "failed to request gpio IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
 				GENMASK(6, 5), BIT(6) | BIT(5));
-- 
2.34.1

