Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012009.outbound.protection.outlook.com [40.107.75.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738634D4D6;
	Thu,  9 Jul 2026 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564350; cv=fail; b=Rf+PkI96myjx25/rIYaD4SPng9Q/Dok7DnxeTDDEA6jO37IhSFQ20oxKI5eEY0xFa/R1R6D+ZY9onFsDsjNRhmLY47NO3uPcIjYmYWwUxyvIK0NdPuo3k4/MvUyi3GQrjss9dt3OoH51fcxoDTV0+9Mu7AWU9djhVsNwPdLYEbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564350; c=relaxed/simple;
	bh=BFMp7mnHWeodv5+3f0a+jD1TeUq138dpHjgENk/TVB4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m21kI0L2l23yC/O30ZDH/iLz8FKsIpNO2IaXHpoQyHccpF4pfbx3Ltir3lazDh6WCudIexZVnTtFQoYLpaUp3+36QyL4kPvwGWpIPZxW28/kvY6Rqhh/wu86xq5GcIORpjLK2ZR3LpyMNiS+X1oOtatYAmogOZjE0oBvK0dwe2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hLrYG7k7; arc=fail smtp.client-ip=40.107.75.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hLrYG7k7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhsWW8w9Ke9/3Nw1HILraoKgHoDp9lczp7kNTwq/fQOnZpb8xOpxO+808eJAUqPtE4gd6krrVYmIxs3VgjiEtrH/Byd8Si8+P6WjyBU6iYqyUJ+DaJTDjNkIgODaebFLFIme1UcQwYZ6JfDssaQEHQdW5Yh0bQlNvfgov4PE1pRpIKgHVo0HiKbBMy3U1yvlpx14/1p8+TwDIpBdaJDY3+kAzaizQ4IuD+7OCV7FoxWO+05s8rX5oaa1jXhRvCjLXOlAkwMHqXTkOVnA0uZwuX+UMUHeVFbnEFHxJ666uNo3AQpXPNpwTSBQuCMkWBekzeZ+86psjtYejwIql6o6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+UjrzhkPlBYEoEaILlsYrNJvqXpf5XNpnEz7IZhAWw=;
 b=UYLtnbZB72KqKWoAlMxBeLNYnDthWEnKxpdZCCFnhNSqQAD5a1Niv55tA01HWuPlS6zGYjMtmBS0YtDGn3IdsHEWj+NbL74BGHv6582t2NAIbDRYGardQvCHIBT/NKKphWtHVa9QqL3CUEGDtVY+MjXhdr1PI9uKoPt2rYz+AODhkS742U6mPxGM0iFJB3q+fKqTSP/kmIihdAidzDMknZ361Dh6H4bvx7g0lrXVvks4cN+ydGTssvXlYNRPy474MYkUR2K1EHqeFVsQL/eMZPsV5Zr5En8D3EtXpgw9zn3XtyX5olui6gFHMO8F1ocTM+LPlPVDmahoF0WBpEuRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+UjrzhkPlBYEoEaILlsYrNJvqXpf5XNpnEz7IZhAWw=;
 b=hLrYG7k7LoTLdVV4TxoPLjLtBwoRBCbqnPK0PYE4nryLYl5gt7o12QqILLGfzSvSJu5twRYtOJNK7X6FV9RMNuQnWy6Osz037+bY8puHe+Q6HGhybBhPNSNNyli8O+KcIlRuXcVoI7QInAJk3QobF61wc9/3wKnFAHtdGmo/rV5PjSgDHbD4QK5HywsIXcDNDdzWpw09NQ0c1bGcRAAJbu7v1sMmz+7SfCqRapW9j/9WLH+4yA//SWD3Kt6fpPY32zJz3LlLLoQNDQL6fWeX0jrtSKApaFZwes2oTwSCYF762CMyxF+CQ0/J2z0apMrES+AkK9a8hMQI5MtezjT0Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 02:32:25 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:32:25 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pan Chuang <panchuang@vivo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH 16/18] thermal/drivers/st: Remove redundant dev_err()
Date: Thu,  9 Jul 2026 10:30:19 +0800
Message-Id: <20260709023048.599150-17-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709023048.599150-1-panchuang@vivo.com>
References: <20260709023048.599150-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e291c5-360d-427b-9044-08dedd624fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|11063799006|6133799003|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	M6nigFexEiC40b74rXwS/y90S8iysPjjY3u1sJrk88a3ByoBGYFjcDROr4qHLWtxm3sppvL+LnGcX6K8ynW/aGafh/cgQUKc0lwQY9j+nDycZs58twhy+Ge+nFWm0lvMpmYnQ+DmGRvSsB/hUZVNsyDpK9LblFVurvdH9vP8UTyzeGNUBLzA8eV0Dvu1MQidpxhQ9GsB+dgTFTxiqIet4IfyIRyW/m9LBWD0N2c0C5oouVlp1KREuK4KwTagT8qqcNZHuvkgBV1o1WkBYpIAdxiro7kr6fmCQscSfR3kBEJ59l0CT9KZfxmqexkq4LxMijomiW7rG81L/bwdv76SceJtKswgCo5XehoMQLQS4djGaHdvoIuU6alZxFjsvJebZTRxntkzgsMC5q7BKfQC5XVRcarY0mk3oMNsPwZAE4Kmpm1YBCix+NzyiZGE9KjkEwlfbcDRbC6fCXwm/eK11AYVwTZxFFm0NPu3oL0zA2Kcx4aYSuz23MaRy69+NOsnxmuSEVAxqR275tkyfpMa+wLkK7ijmnit1bbyzr00/H5pyjeethsPQ+elpeKX0m7iyjoddywbiAfIjndGDeNUUiVbs8JxTf0mvI4EQVy2XBu9Ydy65QV6R/WrB3r6EqjMtvwG6ayknO1ySP93A0V81wVCDJYrBvwe3TcFdLhpEFpEAndSKF7N8ghPFXFfzfIH2WPv5RFpeafTgC9on8dU2Kv80GrGGazkuetYdvHWZJpbyRvyLDre17cuJyK2fFAj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bQq92CvfLkXEhiUT7T/PuS7+p5fZQS+AaM6mQJTVhYMjygh9zJMCDjBfDTU?=
 =?us-ascii?Q?/0gd5r8qIKY+r8Qsov9blxvd24XDXDlE95uKF1VQD+SXWBO+eJkFHIKtVDly?=
 =?us-ascii?Q?LmE+gh2HHx96q/AapxgsV/9Co1Z5CZ2in2WU6P9ZqIYRGAwjYG57E6eNBcSi?=
 =?us-ascii?Q?af6KnXLUv3vEuyzLulIBrUQy6+iEw2en651zMVRFiiac9tq6+S0rQ/lQamjM?=
 =?us-ascii?Q?L+SsOw3glNSnpklaTkgxFBf43DcVOuxK5hfWh3Byvi0o9fHSluy8e32Y8bCG?=
 =?us-ascii?Q?UfUmjCc+viuif/QlAko6YE5CoHYRNayBKHyfZHRU4aPVeyMfhbxR5ZSGEUzH?=
 =?us-ascii?Q?JSiocbsycHZVvZnC2mWbSL5+FGR6Hf/xxSNBoKOzYuLOtxqs/nvW1vzTpzok?=
 =?us-ascii?Q?XMsp8cXwEzDX+EF//fUCVtyU0i26wf7PV4vM+KPJ3GkDMJ4xBpji4rEAp+Xd?=
 =?us-ascii?Q?yx14txU7/buv7Ga3JvK1o5Hs6P7zz436XC7tdekCqpxlTymEIXC8Y7O3JpwY?=
 =?us-ascii?Q?HXBHiRNa0bwAOKrvUg6vP7vSlpLscjMeEc4n13JPb+p15bB/FCobIQ8D4zMB?=
 =?us-ascii?Q?Nl+sq3OCL2aWd53C++mo7heZWhsjNHGAsp9c2FnZju3JB3cub5eLmPR81OU3?=
 =?us-ascii?Q?ohujXBSBxGj4R3gVDdCZGaIRyqd+vwadQ9BxykotjjyDi7rJR8D+MlAlp/9L?=
 =?us-ascii?Q?e9liOhrqDCzZRXl9EzNeWXbI4EsEDoEVCUiZfZXXoU1CFHApLZf/7E3zAm+q?=
 =?us-ascii?Q?tiQ4R6Mxb2nGh3dr1TD9NNfwkycArDlFSh2J1Op8vWUucOlHAaQ6OlDJvupX?=
 =?us-ascii?Q?HHGgE5RoPwRcCulQYkkZarIdpEiTxWHlqDFnYlGwm+rvNoSDelsRbuFL1BoE?=
 =?us-ascii?Q?kC+AyE6vKc6zsXjPITD9EyOLlsvaID1K/J7lq5BW68nINyrwp25dClRRacI2?=
 =?us-ascii?Q?FKkVZpLfRzASru9peTtYhafZAr+czAlxOVy+2a50WAH/Hlas3ad5Yga1NNgE?=
 =?us-ascii?Q?m1CfYDYuzUms9UD2RwWpgrlYYrfKB/HxN4FW1fkUd7uF8L/oJOLBwXD/siOQ?=
 =?us-ascii?Q?NDMbFWUgGj6/FDg1WSfKQ/ul3Zsp51yI98B39tmWjgjiT9/8vn4KQzqfiz6n?=
 =?us-ascii?Q?kKMmieSqjKLN/uAKQWbpn34pi9lQoG8Akwx5sLh4lKSnnHmtHoTMe/MxbJgN?=
 =?us-ascii?Q?oYr4ZaCSBpnj4ceJhsatZUS2DqJ79CzpZvaHvovQg4KWqYisjNt+ZwxFSKn6?=
 =?us-ascii?Q?Jjc0buQStTbPGi5C1hg0t2T4Kbcawqg56JI74uzR+24B2tQY4GL/fqoPL/qO?=
 =?us-ascii?Q?Z/HnD9nseFtijJKxNmUsnacNwyYKgsiIc2VXSuRaAdK6R86qo6aFiqFGDkVH?=
 =?us-ascii?Q?1DlSztUvNoG6zktgXSIZU+XkOa7UUR7BUJDZerXa+I1d2Vqnd/oKjUuVlfqi?=
 =?us-ascii?Q?4jyWNdbV/wF8s2HJWNBK9dhdslVupISnAN+58+nF5cXwCJAeM6V7qv6JbXLA?=
 =?us-ascii?Q?xc1bLYpYiYyijuD+Dl0ZscX1vLh636QBt8CKnspnqyPBB5VEzUIkE6N/2yPr?=
 =?us-ascii?Q?KvcSETQ9Xa0v6tDHCJQrQl4wIXzX4HSEXcFWYZMOiSxHi5wrRwrgG2mpLGQi?=
 =?us-ascii?Q?LYLckH5X8KWPQNGPWA9iOkUePx4q93u7+wLb1h5VaUrgBtnZO+KbTndT0p/k?=
 =?us-ascii?Q?duCItcYgpRanpaV9jzbZmmAnSSZLdL84o+40Fn5Tj7T8yfDBbyQaUx7cX0ju?=
 =?us-ascii?Q?xEcTvtBpIA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e291c5-360d-427b-9044-08dedd624fea
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:32:25.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNJhbUwij5T6wkz2wnIR5MGBqhqJXNxHW3dHqD7+AEeZBjiCA6qgFxMgKC5/2Hyuqqv6gk+Sl0RuTjZ+QSRyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6278

The devm_request_threaded_irq() now automatically logs detailed error
messages on failure. This eliminates the need for driver-specific
dev_err() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/st/st_thermal_memmap.c | 4 +---
 drivers/thermal/st/stm_thermal.c       | 5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 8f76e50ea567..e3dbe4df80cb 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -101,10 +101,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 					NULL, st_mmap_thermal_trip_handler,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "failed to register IRQ %d\n", sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	return st_mmap_enable_irq(sensor);
 }
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5d8170bfb382..3290da7ab607 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -390,11 +390,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 					stm_thermal_irq_handler,
 					IRQF_ONESHOT,
 					dev->driver->name, sensor);
-	if (ret) {
-		dev_err(dev, "%s: Failed to register IRQ %d\n", __func__,
-			sensor->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
 
-- 
2.34.1

