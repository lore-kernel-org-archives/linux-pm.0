Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013038.outbound.protection.outlook.com [40.107.44.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2C3A5E72;
	Thu,  9 Jul 2026 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568137; cv=fail; b=UacTVA2T9MbZr5CT01W98psvu6Um/+xZNYF3zUdwQKG7e0RRvs+FsA1ouptAxVGWCFSOps70AzNGabBgFGQTCx0aekziVU8eE8xwdhye0hGX2ZfNcH8IDPt+PvB2kaMWSEnehleL1PwLPvVxOVtZtrYacPK6wezln7RcxALxO2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568137; c=relaxed/simple;
	bh=Jf0uBx+yDdOYdeyqOI7/DAuq0PEGgz+KPfS6c1zhgYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igTB0d7xNaFWXow9nGsQ8Mv9YSVWaNVOAWCL24zOwkTWpSiRm7/92h4x/xQaOmcxF6mmeZQOkxvsEwVP/3Cv0ED5JN82GfEQksawsmRjghjU47XTXa281K96C1Til429yn+0xLHI+dsG/eDDw4NBNwyUDTTSLqje4uTuMpualQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GKCkQVWN; arc=fail smtp.client-ip=40.107.44.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GKCkQVWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnOectYqhUpBfijkLvWCvyPb9XYFS2FlLj+DoMvYa8f1v5AcSl+ph2/w6IR2Nf3MUujo/KKXPw/ZVhZOzh6/ImXn4bwqF0IeQa9iSRqZHT/mEpSwTepHeOZXesqJ+5wnA6/Tn2CLiP1RmL8tW2ioI88aEdnbgXzLyAwSYgU7UaeHoXne0OwahDDGEMGv0CEr9DDY9C6U63bIyF/5Txs2ekmW76wIOrN3Hr9PZ5ua4CKYt1J7LOxe4DeYIcsZjzyfL2Nhpx4QkPUEd6AtpKH8sLx8cWWPUiwK9rHE8C165Mg8g7FJVCSFT5f/3hzRV2tLuExHPi5WIkZwKvJ7F04w7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THLZGSbhybN3D/mlDeY2yRH30hCLLJ8kS8lxP1Cvmh4=;
 b=mLPArRitxykvD9R6uS/7TqUp9VvWernN8mKdXWMeAMyzPkLqXx98e7BzsugJLfYo3jBfjVxRofpae528g8yxQ9J1sdXHoJtXpywX0QDm5/kNqtrnYHGC+jYBBO5nDjqncdjgDbvJeN6fhiseCSQTJlqPIh9+vm4ynWKQlYCCUqZC+zybP3DQSA/hMNjoJiL3EqEWtMVfrbS7kDuPL/GP58p/SMgp/qnoGqW/UorFLEBBozs7lvndp93y5BLpozCcdVQC4TtvNPXrsbbgv8mBbcfI9kCKJ+iEZ0u1vK+GmSxAT/BIZU5H3nRNSPunENTK3NsiLLwDo6btAAG/qH+XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THLZGSbhybN3D/mlDeY2yRH30hCLLJ8kS8lxP1Cvmh4=;
 b=GKCkQVWNIFes8T5nvVW8rhv0c4giJPzaAOEfU8gimDg+Sj7qvLNeGLNDeOfIrt5LTMi2saHfzVymZzxwfHW3H5e3lST0ac3lh2GHsaygTCphM+ArTsEurOBYiBaNbOe2m/eIbOxjC573lMSPO8N+IGa2i2Hq5sP9qPhoJjeN+TXlqZRWwNvOZtRQLP3m9o4iaB82I+Vb234xsQbFZXM3K3OSm43meSigVtNi1B+P6ThnysSQQit/yeClIIjQITyjuAnx0KLi2iPf4Ub3ILA3T/a2WOmDB4TX09btmq9eV1UGJaAJvvlKOiXnT6DPowDGSSGPGqTzc3nkA6JgZynERQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:35:26 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:35:26 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 27/43] power: supply: mt6370-charger: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 11:34:06 +0800
Message-Id: <20260709033428.362970-28-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2ca91df-059b-402a-4d4d-08dedd6b1db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X4Al5SPMntTe2PT4vy//l0J6RAChnSxFPyk6WUjDcIoU/JWDy4JkIzRQSXRCqcaJJBXMk5xv86J5G6XEozvb2rctE7SVTOorgE4wJyyMDBH7/+dLbmM13Sg6nqbLfmvxtej316AjK+4m6LieKlGzDqgpYRgZbGPFlthpLURMQABGH6LkF5FQP+UCufStAzJidabtgrewHfxZB4Uf8+ihMmwpLO2107Pkj6pTd8jj5YA8yR8U0E4CUpAHCnCx2diQ6lmm9S7LCuEKDEEEMHeQwuwB/v6svQb8WWKZdCgWKyB4XP20k5qKDUjnZ5BvSgjq/Zccqaclt3cHpUX0qK+fXEHhaOycjAb8k5Z4oXJlcpzzJIZhdytKrv39MJZ9sNdzujWUjQiQ+ZaBLsxR57MySQbsK232i8VdcQl8za6hQf11qQ6SNt94w/AZjaY39QPjhPEYvqbOLvyF16D0QaYHMbu/SVChXOQ0Z6JZs5mvzcPGY1wxFzL41h2GZstZPsy9NruqNoyCUNXUXT44NRSvC5mAvQmX4VlOcMiw5zlp0Sew48or4Rd4Nb4yZgTgJwjQ9VC5CzZvhPeshVs9UmizjdBGjrIcRNcEJ1mJMhLlHfKteMzWBwOg5rUjJeZL6jEPHixjtUQxR1Ozd32AALPi6e3QrlLTDueofbt9FVaMgj1arTsuYwp/uPjbG3QFphyijemBhPKMNMQ801E13PceFRz0O3NqYLSLn9ywUdHCp5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+VAnXrMVERNTQhvpOCUnjDQRHSzT63i+kpqiquVSl4OW0NuX8qzFzMTq2GX?=
 =?us-ascii?Q?0vTxj/M31JmgnTvB2rlYgK9lAxxlRcuyfQuwTLqQz0CD5qqYAIXMdqJX4loE?=
 =?us-ascii?Q?GuXl1tZjh09hchTFbmHBvuWs0occhoulJHDJmOvELGR2Ny+oo0Y51zuNVYT9?=
 =?us-ascii?Q?otvlKled7hOcx9zIkM+zp1ZDrz4yJ07nJXFaNcvfXiWFg6DWB+g1tSsbgfpO?=
 =?us-ascii?Q?21UdnNSCZh7vzElPkiBvhJ6DJiba8r7kxDNPrDlylSMuLrqQjEzwAd3KYsql?=
 =?us-ascii?Q?Z0MQtrYXC5Y1mjgH1Ud1bFukpOrgCkGK6OQ0+deIB3l2tZd177gFKhD7K8kB?=
 =?us-ascii?Q?uqKsMbIQjlySCWVpneDYQLlrO0uyYHiwHvRhjzEO79nIfDIBpUmRXcLiwHmk?=
 =?us-ascii?Q?qTxccfc4aWjBiVLaU2cUm2JRfIpTnaDEV5W9FhlB1F1LqjO9sF1fO38NTwUU?=
 =?us-ascii?Q?rB+5UIcMN6e3iHTj5ZkFk1CtEUAAWZHGZWAN9sCBmKYXHFVxNt7ZXg/b0E6Y?=
 =?us-ascii?Q?WVqbafWVraBwJ7QsyvnRnmT4pYCdbvf+7mXbG2xdvsWDUCJ1wdSTAa7vM3Fq?=
 =?us-ascii?Q?25ZzRRK3LSsxFWJtksYmtarl3GWcTXp/St0UwlvIc553bF0h6o9rNSXo63Cv?=
 =?us-ascii?Q?6CAVOCo/CdnDKBfLZEgGvffZmSsAl7F9esW53zJPt3NV4T2Ew+OmPP044j+9?=
 =?us-ascii?Q?DZsiNjuL4Vh4ucOkkfN+rDnhMi6xMEGJQj2S9oFQVQA/p3c69EaVPVKLLs1M?=
 =?us-ascii?Q?s7P6+wb6tqT5T3CNcT5HADXeLo+Itkivzc6xLSWZio2oXx3yy+XyIhGpDJdL?=
 =?us-ascii?Q?hINBpxCBAHT6Zx31OdaxGuW9cWY7NbpK7QGKv/LFnYyFC2McL8htf7Wn3SRy?=
 =?us-ascii?Q?SGXoxEG9A0Ru060TsJCt26wKdBIN9QID1LjckgNA84xWjTG6b1aTUBpqPmkA?=
 =?us-ascii?Q?iniKHJOJC0YtoBoJnNjL7XPudt5/XCzKTfvkwFh8FzPzxJujT/DbBWMuKl2O?=
 =?us-ascii?Q?ZyvespwKr2iLCj9a+ze+aGeAacfLMT9eToH4PTRdk9+HZ7LCJ5S894mKRQZg?=
 =?us-ascii?Q?xoOCmihoW+OTfCEW8s2FENRDpBPfK2D44XdLeLtA6QRdDUnhhhL0uNZ9fqUv?=
 =?us-ascii?Q?NPs9m1vZVABL2Yxzt5FGWSsuGUwMw/CzotSLJ80q6jeuJpDHtVfLKjLwCgW8?=
 =?us-ascii?Q?rrL561Z/8vaP7RKp8IQxBIEu2qF7RxSclciS8zJ08WwQBKXSSSyyPgxyDPtn?=
 =?us-ascii?Q?hLhAfKkdOjKhZQHTbJLBf+VPBIG1FPwIOI/sSDDGQKSWlP5VRqUGOi69vvbp?=
 =?us-ascii?Q?xRNZiH2hcJCJXdRWZTQK91LaAGC+3yOdASzxxhosv2XKbYAsfUyzOLKoZdFs?=
 =?us-ascii?Q?Y/ReFwZjjjXoOmeVfID01zWVgK4T88N/9L7F3wQ213RgxwQP7wyHJcMCa0Qs?=
 =?us-ascii?Q?s+dHP7z+zmqut9lkUzpmb9dMMsZ49JtjqOA6GaTTCxRtt2cpt5IYxE72wXde?=
 =?us-ascii?Q?Udni4R9UszHz3z1waAgtTjGc2EsSFn/D8/LrzAETQuDor+nPy2WnRrdVx5a3?=
 =?us-ascii?Q?TvfE7cL7/3tC2UPm8teTc8ARW0SzHDgM0pHyIhuYcg2JENU5Nt6Gbi/IRAtG?=
 =?us-ascii?Q?/7E9jx7JCyqQmf/LFM8cDkkxNVDT90t6iw7FglciqawS6DVMHyWORa8BIFqJ?=
 =?us-ascii?Q?aihZslTFaTVlRc/NAQsn/20Xx24N398XwVwNFXI5ItSuD5NE31wGkoX4ZT/u?=
 =?us-ascii?Q?ulErI+ZgUg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ca91df-059b-402a-4d4d-08dedd6b1db8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:35:26.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZDlC2mzzPCa4QSBocJLo0ZSHkNhlRBVieLWwLo1zNXfnxNWzA0TEuNGChYgaOS+iLcyzA4z1J+lv30XWAqbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/power/supply/mt6370-charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index 916556baa854..9d388bc53098 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -837,9 +837,7 @@ static int mt6370_chg_init_irq(struct mt6370_priv *priv)
 						IRQF_TRIGGER_FALLING,
 						dev_name(priv->dev), priv);
 		if (ret)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to request irq %s\n",
-					     mt6370_chg_irqs[i].name);
+			return ret;
 	}
 
 	return 0;
-- 
2.34.1

