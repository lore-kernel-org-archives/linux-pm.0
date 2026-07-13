Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281374189D9;
	Mon, 13 Jul 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948417; cv=fail; b=D/2fIJ6+XayHoRDuwCeGDVniEtapkOVpQmI7+tBqVtVB3rDyA4NERADAHZHQIamlxqu/G7b7L35tLJ90UnEJxBTdw3FwOCsV+MoMppWavjAlb6vkLJ1BOu2u3mujORqn0rhQIefJO268OcDbVzLCEWGNM/tJcCAaH+UTXOmpiD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948417; c=relaxed/simple;
	bh=dy/v+Tos8femEWb6D54oqovTBHfqQjPdcYCm6zLE4X8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FX3K/n0W1RT2mOoFkaS/WuWtbQ1+8ewPNv7lqtIisAoPwA9Vx7CQJoKvwXQ6Cl9JiGujty53l1TOWw6zDkuq4AHHXX5FRfOtidFhsQpasVfVwGoL7/ZYOpbgvs6jlUWKKzQi+lu2qcFrESMzWwCPJnTa6rX215hXmzJ+mliAVHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rh0rsAqz; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rh0rsAqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC/8425XzDV0q+rsV5hfVeAqBbUmtgXctS9cdjvzlEXgtX7Tn1wQswPNBkoy9K4pEvOeaQ9QEgB9lSIC2AkSA/RzA3tIZffnHmeCMayZEH0WQbWCx56bMAlHQW4jZ4l6MBauEzct7ZGVCkSkoNeLItTdC5kYCuAiZtmDpyaGv1sh5QHBOm1hpS6E3xews+IsyIksKdJa5IMNoLpybUHUVSm0ggyRXUqRPVVABWLFvxJkFZQtzx0o5798a4+04HFcoiaabwDmnErt8Z5VfoK7la2xozYVwpFe5lQ73E3jBDqC0/vxuesDJuHicpaWJ9H5YN6xIL7OAyYLL8SDoxXBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjhRH0jzNlIyJ9q57m2nyjvxW3yoRAz8kdMs/KGsoNw=;
 b=pNaKL0CVvlS/ZDKy3BU7cSb8XWspdOFVvedcdY3VRhaHgNnu0PJrPNYhzulL6PSNXJwyASrihuDL/UI2DP184lhGSFcvXBAxrU4JNYe0HbJ/85+9bOY1one/RX8j6kijqa8P0FCTagJCSpiuA5wla/9Xu1n9VGtLN2Mm9GfO6RiFe0MvS5v9XvWEFAw/yFEohENsjf0dRiOZ4x5tf2CWqjSuwHTz5DW8QfQ/hUNEya7Mz1wkoZgyqyu6yJIHGu4aK85aj1ln6OB4KijKXCTZeGJr6zdxTty8CR8VAcsp4ymsGi3w39KgnqCZpmdrP+056k7NF/SDvfB7O52uIVEqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjhRH0jzNlIyJ9q57m2nyjvxW3yoRAz8kdMs/KGsoNw=;
 b=Rh0rsAqzfVwsTrnXIwhS3VKpf+FIlGEk5XW9ATg5TGuLDWl6DWDm7vOEXCwTFywR4Ad/7A8PRB+EsbKWr1AAraeQEf1skyIUlPs1Tu4BvHGyc4SD0Q3hCzu+R0fQfqPsOLjuVoGXazNstMND1oGcE3YA8wnFt52c8pkcc/1UIr3NnHLlLvdX3fbmhJl1C819SyrUvuclPBuKUKr3k3EkZG6Y+OWrGBH2p56UUXR+VhoPgfaJYugxSMZwKlL868mu/OPVI8GST1Idy7younhN/aLkNSSz6HHO7YsZfyU4Q8+soHtGtReltR/C42hqLda6HvmxuTinDjBigU+ilptbxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5316.apcprd06.prod.outlook.com (2603:1096:4:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 13:13:32 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:13:32 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pm@vger.kernel.org (open list:MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA),
	linux-tegra@vger.kernel.org (open list:MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] PM / devfreq: tegra30: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:13:15 +0800
Message-Id: <20260713131316.322358-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e32042-4d58-41c1-3b85-08dee0e089c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Xs3x4RdanDb+posggR81dlyUFEDp+WCuBySMGHW49arhvn2eyTnfIIe7GsCx4QJooFO7s9X+l7hprr4pGIokbOH5Wq944WTO5y6T/KLdOgss7sG5FPU1er17mHNlEOvHq9PkY2mBmDlnfhZhzrRVdlAImwE99d2Ql6LSdzIVjZUkFtJPDGjuhoN/DZlGV0XBwSKbmn96Qodsz7LIyMQ/wFk87tcV90jc37ZWBt+CnkKiRY72D7j9QwIs65BykPdI1E6IubI2qnJ/xRw4HI+PDIJpT+pl4xfdt1wygL2hdPMR8kgtmbQmyY1AgbDm2x2VCqgF+R1amZiRIc4HFmu07Qh7dyjlDEaXhrJ9FMpQFKfmHR9jXp5PlEKYEfOXYdYRoTPzLVf2E4IY69tSzzAMZgD2PAWDnoSeUEF7sPMYelN7a+Wahmz8w3Y4OgDOKdXHknNnkyXrp7zdUmYHqTnhXsnvW1VS8faLX/l0dLiJ4fpcNv5++Zvl9MDkkYDNihsxvoDJn9tQJHwXXzdxEeFTIANn9aDL3m2at1aIj1n9Xg5sLkhZ/Ufnn70OhAhY0uYhdt363lKfIvM/KnbXgv+VdsRPe9N0eKL+TKCaP75npmnvYxFE2xvqGSyq0GxOP47jaipi+QryUXqYQqQr++lnTXK7M+9eLiSY8KPg3YLMIJkTL+r2/XVSKL81NIueJnIn1z1yj9YtrFJNKxcopV0KhOaPUFDRf5/kJP8SRTgT8tA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4lhOUSZ0oDyZNAt4jO8gcXiNpJcQWZGsSiPh98Y4r6BjiP+W3fJtmWuExnb?=
 =?us-ascii?Q?3+GKI9t72S54s7VYVPKgD6O9RhSDZNng+PKHBarzbT3P/IjQcelW0cx4cekY?=
 =?us-ascii?Q?rztNlsOLGiJ6XZo1eVEv3Q4c7NqZbXmnUyS89a+Ta2cU9bbKBTUH6vsscF3e?=
 =?us-ascii?Q?rnVQznf7p8O4GAcpl03wu2Ga4o1/vC16wKe9t3Koli+HDSZ1aUEse7pVc8JS?=
 =?us-ascii?Q?buiQ7eeUiFc4hrIqaNLu8NOjLymdDZSADjArWkTSBLEQJ6rZgAeTigQZAmaC?=
 =?us-ascii?Q?gfFjUoIAuj2Lr/B+IjfI+FQ9Ja7hkBlUVSNCWsH3kYH7zc/fYeHeE1Rn1EUs?=
 =?us-ascii?Q?TxZAQ14uJCYRonbSpVDJcSHF8PwAvy+LsuRi7qvr8ftr7r33LaK3aFe3kdh2?=
 =?us-ascii?Q?X2kq6wRJN8jM61jlcJ9LPVIM9UQjs/uG3SewII4jnXzoXxJGrGXcd6bWALOf?=
 =?us-ascii?Q?a45/ySAfA9KOAwgQA9kQs1wjT8JhFswXYKgX+7w7apdHVHlL7ltC7EAZFK2H?=
 =?us-ascii?Q?Xcv0TYwyxvmoSWUNjr1YQt9QCTdxOEsh0sj2b7hChF3n6cUOO2jMwFoDY++a?=
 =?us-ascii?Q?yuXwoyX7apNZjxXXOrL5qUxV9wTdzEuiH2QZ8a9X2LTRPU/kk/tVvAg+muWB?=
 =?us-ascii?Q?fUYIvHRjB57FaAWltm50ssED3rv8HXhkaIckrjrKnU+F1aUCeIRLyajBdNZx?=
 =?us-ascii?Q?8SbKEmBAcsjkh2U10LZY6DUQGyJnGdIyaQ67Uni022ZKPTLaBps/Vt+oJ4be?=
 =?us-ascii?Q?KzYMA0+YgTTKKOYpFgsKbt7hF4JU7p0X0XnAzzvznGgOTcQvWfMBi3I3MtgO?=
 =?us-ascii?Q?QNeU7VqZ+XZMPkmPGZySaRgRIZwEZ7Ns4BXqWAeqBvq17Qij69VGSU7BwnbD?=
 =?us-ascii?Q?JzBCdt7CVf0yMeD3Fqh64uY9nBfok8xdh4D2wwRJ1VyMy4s/x7DmSKmgXpkW?=
 =?us-ascii?Q?2fSTJ2HbxarNxJDH5/KqL2+EeUbyxNUYR0HSwie4WNVeHeE9p+Kiwer4RA6w?=
 =?us-ascii?Q?ZBsc1WCLa3WO35CjutiG5FTU81VV36puvvybGTwwgjjP7DWZ6VWoQ0GryxHx?=
 =?us-ascii?Q?TEgy43uE1LL0RJUFWPgHHgRKmir+bugO+XXCWU3SD8VoiGjfYnOFAPU7tQ9i?=
 =?us-ascii?Q?NhoUpMg/6wXIYBpbRecHr9i5crUezZbfpjpkn0thtzb6vRpPlEK1w0z35RL4?=
 =?us-ascii?Q?zO3AzoWUKPOZeXwkR7f3vNRmeaueAzY1Le5/ma/D+DqrSh1JlqqRBFprX373?=
 =?us-ascii?Q?m9KhxTsAbWqXhbzaDGLqHeQDPLl7aHkSwNuauziBXoKC9dpZR3y+QSpzH5CP?=
 =?us-ascii?Q?PNpVaP+43NWHiAEH/jnS13rEfmkjww37hwCnfcmoYshiG4CWOkwkVPe8wOAl?=
 =?us-ascii?Q?JLBWMOlSZkyJ7U0KXYuKTyRkdv6jugSQ/Q9K4LtDrXriC4af7XuDVms5UZrb?=
 =?us-ascii?Q?9L36jhmVSaAIpYztkY3zl026reDwxsHteE4+zpkUmQI10evFzUDPhUIglMhI?=
 =?us-ascii?Q?8x28vM8+OCkOa+pwOAe3BwUCITVoWTV0sJRwLwR7wdwBwoLqzmZILkM7bmjz?=
 =?us-ascii?Q?x57Cg+ID0RlkjnYYCeVvI8nE/3ML/24rRc4Oa/FcY04RExLaf+fghLL+egyZ?=
 =?us-ascii?Q?Le1gVp6nJjaAIXmSBGQdJinCNUZkQGM013rnNffPHjkN4Ld/lAx6fFxvTr+a?=
 =?us-ascii?Q?0j3ncFt1+HREEghxgaREuKNRaVBqFK7e0/zNgwAh73FHTkRkDO/8huN/U31p?=
 =?us-ascii?Q?uGiubueSug=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e32042-4d58-41c1-3b85-08dee0e089c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:13:32.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkGkt7vtzgt3hVVbfUrp6YLMUjo0zZe4nM7Hl6fMSw9E+D5ujd/vQU/eiZ+Opzp3FtxHPDD8gb0sL0cw+vzHKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5316

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/devfreq/tegra30-devfreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 401aac6a9f07..d149694becd9 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -880,10 +880,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
 					actmon_thread_isr, IRQF_ONESHOT,
 					"tegra-devfreq", tegra);
-	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
+	if (err)
 		return err;
-	}
 
 	err = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (err) {
-- 
2.34.1

