Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01C31355C;
	Wed, 27 May 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863163; cv=fail; b=Mv0DWOQMm+yJjl00LIYST46NFlpwlDs8i/Xo3Iupx6f0DqMeuwON0qn+cCkNYflOaMcq5HFaJMhxaFnGKLFQRgidABtwwKl18bX1JgnU+qZavy3uXQF5qibc0FC/MXxv0kTk0yOmhrE7FgTgrDXp9ZYdTIygWHLE3OfOGm0u/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863163; c=relaxed/simple;
	bh=V9WqY+dfYZCkhuQfhtKilGVIsqNBZWDq8uMG45rXVJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npuayDxcf5I4UotTCAKXTBFUyU7KcWxSYsozuEnFYCc/LtqzMxcwzPNeFGs1TiPxlDElETtJ44+6iTkOgLpt/adMMZp7QUv6bDRT5ZUrsaHmdR7KUOWnRFgCn2mItx+GQoD4jGAWrJe59ZxnqKvwyrr/OZnnRoWitH15PC2NKGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SpJuZGYd; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SpJuZGYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scPGql+zotBwfbRrJaHWywhV9dEsgQcqHgbP58FSVRBHiuBdmbcgdOviu84Nh8qgAhXcryXGng91Xu4WRJEWno/pIGgBqq1A6szJdtouDKVVYRBDi5PjPJECeF10/5uMWlTrDKUefUBlBuMxOPsIUBGM3So+IcwYHeLA9m/NPIhoCDNqnPxEF4vaozG9cZHVnB5m9Gf25mOZJrpFC7fdf7ujigbDevtgLub0pieUWEiO/sBpXU7Ka0rw8oyWn4pR2cop49XgdCzuaIXulglq+gfxSyurUpfRA1m/fWYpWaF2P2gw0QFk/nutcJ4S/kLmo83eut0U3688MYqoh0EeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wXZatX2E/Eq78miIBrRoHMfWF5YkrGKNX8QC4RItzs=;
 b=xOt1cfzAm4y6vdROVmDGKpxvTegrlVq6YpfPDy+gtR2l7esOkrqmOk0JQekeyWLolIzvnQC+yy0l1Hsc0FN/qC1BenWrV2VxvUc43+4sCa3lH8eEUYCJ6OCZOiFpmm64gJ4yX9JjFIq4rG43LMmDTTNacT4oVUrzCWTHST6Hpn2MyQYHS/K2xNhVX4wCNZGK08uVjgoG3m/dsHFPMiyAdtB/QUv8phXcpgkDwOsATQeTCPhx8laD78L7f0OiACIe/GkSD9379Bf01jBIS4xBXmovlCODGBInAu+Aq3mdz/vrWw9Wwpp6kI85AmpxH4bT684F6p271Im+hXYmZE9E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wXZatX2E/Eq78miIBrRoHMfWF5YkrGKNX8QC4RItzs=;
 b=SpJuZGYdVWnE3FBC5nB6Ina2yAuZjsRGlUZ/1AxnZ571LKwOcHkmBu/yDjZh0p+Usykv528Q7Y5U2MQ7qfvjg49bKoqXN8CAHsS8EqH76BxkCiWJ9k6qBBgNxePqqdjhCNix6byxS8cXFrVpl14tv+YlgG46DXCtyLO7lJIggrw=
Received: from SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::22)
 by LVTPR10MB997842.namprd10.prod.outlook.com (2603:10b6:408:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:25:49 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::77) by SA1P222CA0110.outlook.office365.com
 (2603:10b6:806:3c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 06:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 06:25:48 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 01:25:47 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 01:25:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 01:25:46 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64R6PbjW2481084;
	Wed, 27 May 2026 01:25:43 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v3 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
Date: Wed, 27 May 2026 11:55:34 +0530
Message-ID: <20260527062534.1808422-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527062534.1808422-1-a-kaur@ti.com>
References: <20260527062534.1808422-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|LVTPR10MB997842:EE_
X-MS-Office365-Filtering-Correlation-Id: d839ce44-350a-4fe1-2a5e-08debbb8caae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	r+lOCcU2TbH0vUeNCWRPkLYqrOVvb0pV8fyfM28i2hFXAcw1LzqI6YxgwcLckCzwg7ce8ZdX4aCegW9Ic24QvUinTwsHA7xms58O957rDcwkSDUWTPIJF3DoEPPyEKOuS+41UESXQPuNk2fBCsBP/XdVHf42PwS8pzQLyr1B86GFLv885TJvaQNsoGkxbS7xBO9LyysJphIzxDS161mwhVmUsOLZzkKy722S9YyQrQ33ejKboahKsaTs/R3fZLTOgV7wURORcbK0/2Y+28V8uneGhmjetLPMtwIxe84QVIDJtJDZJbJxtYQwN13I826kMrdg79BQNUhez0K6Pq45jg2xziEGCfC1XQ3KOgMHvBY2ZzUR6XeuJIf1AfChflt1JLgRu//1DG9AFgzkyNGCfmg+qxYD4vV5LvlmxS1yr1/OsBnOy9lQFhY6xyVTrujeLCBPznmzcdhqHdv7D6Ei56EX5uxWgaELI8fW90uNGFl2iqMS4j72L5t7F83haReiBwR6NbYgcFFmwDh/EVF7JPHFDIdW6T8FWO0O4ibNm48iyAyJMAd58gCt4wttdFFxxesRBnNvXWBGjJ/e/NTTiw43W/+3qjpOHDhRnsJEGR1rImPTU/m6EcrJCshrHAzzfnBEz8xwESusB3olC+KJi0AllwH0l8XUfW/CRIDG2uxNhSC3gC9Og6zULn0c9I7QJ+hbAl9yblCT/NxTzTINO4nxVhlb7iw70z+6ay9W+pg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p18TL7MZN61aT80H6P2ofIrLc34berHknPoqsZ5Q9RicDaKehLSL+Db3QQrfB5zwhWNZz1/ZIli5Qg6+bLowIe2+fAzqrn8BMK+8kBGoTJfUsdnRFxKEFmvQ/UfAS/pwVNcdLfrlU0X6+8HyeLUu/iUstPwFkkViuKlUikdFtxMdVKa7rcMGXd7GfceghH3GhITWRqqrYLF8p12c4bJVOtUWWmJOU3ccoP6he8pV6QFBS+l3GpOfZPCd4X9ZPSN2WNUe+SbisyUHgNzMCFUVKJUf5t6qLj0O6EieZQFxAcgOuFl6vvzUmSR7nA0lsVqYih6cIwOObDYI3/UdJ1IfeORwxhLSgRutkQ5pIj53bGJkG6knz8WX5iTIBChLlizkDxY3butYiF5NhQr+TUGeEaa0jxArORnqeykoUPf5/pSUsqzLFwkoh4nMPmCYmtYw
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:25:48.1259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d839ce44-350a-4fe1-2a5e-08debbb8caae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR10MB997842

On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
device before soc_device_match() can return valid revision
information. If ti-cpufreq probes before k3-socinfo,
soc_device_match() returns NULL, leading to incorrect CPU frequency
scaling behavior.
Defer probe when k3-socinfo hasn't registered the SoC device yet.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a01abc1622eb..72832898f3f5 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -429,6 +429,7 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 			      u32 *revision_value)
 {
+	const struct of_device_id *match;
 	struct device *dev = opp_data->cpu_dev;
 	u32 revision;
 	int ret;
@@ -441,6 +442,15 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 		 */
 		*revision_value = 0x1;
 		goto done;
+	} else {
+		/* Check if we're on a K3 SoC that needs k3-socinfo */
+		match = dev_get_platdata(dev);
+		if (match && !strncmp(match->compatible, "ti,am62", 7)) {
+			/* SoC info not ready yet, defer */
+			dev_dbg(opp_data->cpu_dev,
+				"Failed to get SoC info, deferring probe\n");
+			return -EPROBE_DEFER;
+		}
 	}
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
-- 
2.34.1

