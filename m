Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5E3EB105;
	Tue, 22 Sep 2026 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051280; cv=fail; b=LRhvHExrs/thqOzm1ss7qurGVQfllQoR/CNQz2sf9eErn/a8LSHSc1+JFP6qbx8eo/c4vXWz7oq2IVQsNIQXbpv1EpEc/U7bl0nU9CbxmCrrsUmk2/h/YsKqsXh+9vx0aYaKRPsBrvtQGM8on8amPJ1OphMT9gBcz6SZJQcxYck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051280; c=relaxed/simple;
	bh=sXmyn6QHky4btcmtpNuM7FQNfggP2oCssD+Z6MZYcvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9rxHWyWuCjHvBoPCjWZVZiD2gcoQS5zyi+ndckXg00NdQ3uG30R2g/D8sInW9zBdVg2LUXqo6cZXCkgU75eH3YkWN3Tjf6AauN4mvkV3dZ9BU8ZxP9Rj7C/9lltjw6XJ7NBvMsdzrm1YqbaIQyQ27YjgrhFUaxqHcay/5iwFM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bpnP+BKu; arc=fail smtp.client-ip=52.101.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bpnP+BKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDQCqDB6RrG3t3iN/NP8HuuFjR/cXc+Osipe54V2+Dc3h/QRijDkO/B3xUSmbzmgIk4hA+2sNjQS8XivNPNfWDOcLDyk31tJcKVKPmHkwHoC4woyMc++MBQUu56knJ8LxXL4LoH1QcEWCTHHNaZ58C6/3tza0HA4MVA/E/KJ4vmLT0Jd5EG2EpYOKSn5Ye0LUQAyz64yJMA6M9UV67qR3uDbQd3WgM//e8MbkhABykk2C94ZfK2B4s97r+El2OyuhX7/DsDgEn37Yfg49J0S1NO1vTD0eBcC0wAONY3EvRX4XDf7nuaAxbrnifD4MQEga4UsxfagwqQIp/zGrVuzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL0rKlFbwxpyUjCcIhGDI2ugYyVpDSnZ/GxyeU2xDtI=;
 b=DDo4trv0Tj0Gm2a9aDplohEvSyZ+G0V7zlZqGQR4bJa7tEvbzNf85m9fio9GPxjdp3feh5JOpdFR49xzB+DVEvG+qpcMukZf/Qi5Yk2ABX65hVouXdHU1N44da53nh/0oPE0nhJ6mh7G0TPKuN+J1naMKxbpoGAsnIeoYPrp1M21HYH7SvE0WdlLDyf4X1LuC0BX1AnHhfELA5xmmdcUg2JEVEU+PcKnKSoEtBn/lvDyT1+SRxrJg1J3QV4dvHJ0wrfXsapYSC3zu3NC8/XeQWYCGIOVc1VzSJ7rQ4O0bNFyoxygXBNP81mBc9IkB+wh7wxeBAucc/mP4z7y0QAtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL0rKlFbwxpyUjCcIhGDI2ugYyVpDSnZ/GxyeU2xDtI=;
 b=bpnP+BKueB3VGalc8Q7M9iS5ZvhlzbqSPIxoE2mdSJwG9Q02Ek8AaRcfp434YyaFI60FLEdxVQ95ywvBeeOeP7c07DxgS2knH6grCP2AbqsJHxQHgVhL0ahNHjTReYfKGqBsfARk9M/3o+ovRu2noxNihAm6bVF8LZLv/kL7dD4=
Received: from OSTP286CA0044.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:224::10)
 by TYVPR01MB11169.jpnprd01.prod.outlook.com (2603:1096:400:36b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 04:27:55 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:224:cafe::7) by OSTP286CA0044.outlook.office365.com
 (2603:1096:604:224::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:27:54 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id F3FB7300028B;
	Tue, 22 Sep 2026 13:27:46 +0900 (JST)
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
Subject: [PATCH v3 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
Date: Tue, 22 Sep 2026 05:26:56 +0100
Message-ID: <20260922042707.116378-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYVPR01MB11169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a47ef55-5d94-415e-9099-08df1861df49
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|7416014|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VUXk23Db+oFrGE9wNGwcy6hrUvqHAAN2HNVvrk5ZPraEM8dabvowGtbsUNn1qwPuOzxd2qBoZ1B4X0SrOOiG2CD93avagWuZCCsW5w57YrDGHHEwy5EplfMhcSmIICTSwGtZU7CrWy13zONoOXATvgGJ/T5V54wXoG5i7NKdAdnBlJE2qR/5s7WVwAcnwwiMtDiwoJZzxTYtW6r93z4zYc6R26Sd6wDJ9jDDP9WqGCXxmWtJ8pftZ7Q05uHaPzRaL+1eKODVBFoZaRUaS+8eXS/5ZAZdaCNAD4gG/lKvQH8SeIBMPRbw7Q+fQ93f3jWVPkeoNLc6RBDqFE3xFvq9sbPhr1yxfPRyeYgUizqk0g39eylNrmW6UbxuXW84zxU6NSUOh+F+dAZ2tGCwRUPhQ/TM6RnSRsSxAQbKjPnv4P8d+JLd8WhLkvmfe71qRWpBqXo6+XqkF1BtdDxTTEoAfzq94AZ/2dnx56ZLamo6DUvC+otPRajnQnXEuB/DgbdmSc/CEJcNDzMZrJxOuCVXZVUduO9TYYJ/XzWJluw1LyR954GJFYMaruN9nnhHgoXuZiLbgaj620wyzOHZiLuWe6PAxlV78sP5QYxcUiWtmNI7ys03w7yjYWr+7uf9sFiAo/NobsslAtG8hIKG8FsrpW6rnACIIm+O72n84g8Lj4Jc3nI53wg48KjusiexWmF6
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(7416014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EKsF342KAqzbSDIIOPMimrdRwGvSh638PbB+0GlNzdj6DqhFT7vUY3ntbjj+99xlWmwX+WNFEDxe3F+qPZSMO8+XG8Eqa06rF+AGZ/TgWtQ1CaN0I/PeEa7e73FCqZC49wm9AOVpgYI1zsYyykVWrx0dSRWQZkrKF5ckVNbQZjTqoH4+TjxPLHA41fofgJp2YO0SGMTL57NtGSVO5byq9P6GE+yjhApfQyVe37BsuxE4GBbPBk4hccIJ3Ry/rC4TssksPnMiPBuuSwYoMxz/UuxQG8U5K6NXFzlJgrrZcAc4zbwVkViWuVeC959tAytM7Y79tW6V09KzohrUa0znndzFcdLA3ym2+Dj5aTBTuI5AaeCiCpkv0X0JzpwmvfM/OlgqE0yxb6Qc905TNIDaUmJwHO6Rc1Nj36UAI2jipu/pWpWpCX4qof62wwuComyI
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:27:54.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a47ef55-5d94-415e-9099-08df1861df49
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11169

Add the renesas,r9a08g046-tsu compatible string and its default
(software) calibration constants for RZ/G3L, used when FUSE
calibration values are missing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
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

