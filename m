Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8A4A99D4;
	Fri, 18 Sep 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744142; cv=fail; b=j4qtGJ9wtzjKnoZgWK749zp/aBQkxylYzYZXgvVLacr/8XYIiIiNYF/DDXwMDbw738rsa9xGU/dB0eRVR3ftFO4SqBm8AkIfVLE2cMUj9+29Lsybjt9v4J9/dFeu/x+Dx+SG2mJF40jgLP7GXfcCHNwCwtO2ksZGm/O4kz042kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744142; c=relaxed/simple;
	bh=PLdAFc1FPWBVCXEGDktb2sc0H7NyetIpV64HV0Rtg9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGrIirx3b9WIU/GdOIswT0uQJ1FN+ww6xHGIYF3mAllm2ZOv8WaLww3z73Dbl/NKcJnCc0gXLNpS54ayMwt2WabuUwmt7MJoPXv0Eh5lg86053ZpKNrHO5svlp4qRAcDHNGj0/8u/tkAJbJ45EcThfhxOSrZsKShAkKelPQPF0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NzbwudiY; arc=fail smtp.client-ip=52.101.229.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NzbwudiY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT+BHRocHX9vhY9igl29vcSsP6YTPFdphPBgss74f++U8tIg7DvGHG4BeAOxk4/6FoSdijHEYahPiFMYMqpUvLcckX8WyXW74/l/fJxjgSB8N55r9wkO3gnRzSaKq88br17uNRTnDEeJ6wzb2GfE9pOZK/k7LjNQsJHNb8gqqQ5fzM6mJkSUwNeKhC62Z3WEbI/46OrMSHKb5H1YyeU93t0k18dOvM7bTTZx8Pf1OD4J94wzFYZqLleGwvz/oO22nXoXDe0eye1CCYtzfTiZ63Nt0otCiGozGSRG/5wJRpGOrEF/OTbS1Jr99IprEKowYamT3Ib24p2H+51+nWesmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq0kSDbh8rnxl6tAvbN/aSQQ1qWRLap7t4pY2njCeO4=;
 b=Tbx6qewAWuiT7BNMiaIkiToKQhoNKXWQGpHuBTJ0iL4xHzMxzLbDYEtNV7kyBd66WJCtFtLd4E6npC8AQi8RzvJ44Ng8d8w35eSaYUJSmIt2nPAMsLgPGoy1iHy2AJL/sOy0RRER8m1wFvbd2za0gX6IFLbUpQwhvUwS/MqKEfNIaFVVRPV+oCv/X13wfplh052fqlmABrCZrpOZoqwpFS7PftRxSWSulAQmORwomPDGtcb12m/8YtVY50MkQ+D/mVXuAefSHzPwq2J2t7Ks/25n0upJ6COry3aY2jOiXFcekH8rZxgh86qSSKwS5ITTmJ0D5HRsOLtrUawFpjwgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq0kSDbh8rnxl6tAvbN/aSQQ1qWRLap7t4pY2njCeO4=;
 b=NzbwudiYM56SzsmffUatQWA20mT33CQZ9bn9JPkecCAGhecDr4cFvdgJeItyYV+Xz3eEbjQdnYv96wmN3e2rI/AAdDwtFP4HjwyiHj6Qcuz1yr/9RMRPA/oC2kAMeA20ZQymQkyM3ZF2u9hOSMkNReDmJ/He1rCaf8soLiSGi1w=
Received: from TY4P301CA0040.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2be::16)
 by OS9PR01MB17971.jpnprd01.prod.outlook.com (2603:1096:604:46b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 15:08:41 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2be:cafe::16) by TY4P301CA0040.outlook.office365.com
 (2603:1096:405:2be::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 15:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:08:40 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id F06FE30007D2;
	Sat, 19 Sep 2026 00:08:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
Date: Fri, 18 Sep 2026 16:07:21 +0100
Message-ID: <20260918150730.122056-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|OS9PR01MB17971:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 16c8417d-36e9-490d-d765-08df1596b946
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yf7q9eLQTNlBjUBhm0ltPsg2SiZ9dKaJvbTQKhiri1S2H3oOluHBJfONP75AlmH3g8K8mPXvqpvqvmseTXOVfFXR6/6vdUhmE/EiWcgcz/mNHHUFl/LefHvq66rw1ScOb+4D2Ld/auOPMFC34CNx0C/pGKHkLgPQZkKuWe6kSvaVHMJRm4UBM8t29s2QDxGXkE1cClrYx3CsOh8Hbf/e64ZHHN5knpVFitz+ugCth9ARHirUFcZemdNfP2HXLDXhfMGY8DPxjPPIiV5NO1QrC71WFgJbL9Zp6S7a6snifbXGXJFMdaSVDGxVkFwAiocSYlg9Y9VjqidMSAsHQpIlyeIaxAefTBGgl2Hq9Ajjy7Z53lES3JC0zE7Y1pzya3WuWnHMRBT+fXoqFpkCJDCd2aTcypADCv6EN+zJMB9Tz9HlOhBRTixwI3tPLe5pffQJn8ZiGT/xzHfnBcRUqtI6UXP8XAmIxcnSifj61Eck35LUABkPxnqeyqrlmsDc3UcKdOJq87YJv4OkxV4H2QipoTSWd0W93t2vNssp05MtvREd0V33wmnpdlVCgAIC04m/sl7RLde4d9IsZYjnOAcNzd7xwo5DyNGzv2C3myYTtuXOZFBb8s2oJyW5Vi/9s2huf/LZO5YC2swS7SpvWd2+FNq+pk3eTaIBMghLBFbuvp2y/IcDurPgVtzQnMA6/6gD
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	euECLOhigPrVWiqJaGjIQUjc7MwYVizFwHxDnHAQZ0QSfZkJkI75G/MQWyDVAeiy4UZe6qg8f9GBCAE1PEM3FsukBMxZy3wxXRatNWlkmhO9DWyZkKmsmC3CjnyIK5rZ9xZCnW4f9q7D4mKvNFYvqFJQU7EyTvAPwIg2mblHVsrTyCut9btAn+cRdHvmspixLQt1fB5dbFCtzWYhzXJ8/U9USdh5c8VeDT6P5epzOi406sUIqVUXQwMRMEpi5Ds6RALieO/qdD6M8odtZD0AHer62nC9fAiu7yPJmLsrc7kQx0B+1ZmoDUVBuaTRtZ+FHnJM1etiJ+jaz/r4v6Omevy/2Uz3oQ0ow4ahg79bglaQSQVONQr7Xd2M8vayCuUoPsheUd/69jRYpx9hoV3MwGkwr00MqwDeD2GjehgaFg5C8koFGcLDCJrwfClp/ndX
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:08:40.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c8417d-36e9-490d-d765-08df1596b946
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17971

Add the renesas,r9a08g046-tsu compatible string and its default
(software) calibration constants for RZ/G3L, used when FUSE
calibration values are missing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/thermal/renesas/rzg3s_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
index 146b73a1b751..a8716da7fcd2 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -265,8 +265,14 @@ static const struct rzg3s_thermal_info rzg3s_info = {
 	.calib1 = 751,
 };
 
+static const struct rzg3s_thermal_info rzg3l_info = {
+	.calib0 = 1322,
+	.calib1 = 772,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] = {
 	{ .compatible = "renesas,r9a08g045-tsu", .data = &rzg3s_info },
+	{ .compatible = "renesas,r9a08g046-tsu", .data = &rzg3l_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
-- 
2.43.0

