Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB64E3ED9;
	Wed, 16 Sep 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560046; cv=fail; b=D3ZUSBvNQCUoru5RKSx8QSqQCpJj68WD5eZD/aVKo9xFItd/mcv0tpeCtGBA6zAP+qotc6sN/SBmLRWUaCZkBOpVdTmK/3emIPt+AvcbkSOPct2KBcYlMu4N8j7abt/SU663RYPpGlB4KEZo6vo8fWZmpGX2JdLcUVXJVwRovn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560046; c=relaxed/simple;
	bh=A0Y6STjtupIYq7PynAIpWmIa23vrYhYSIkMzsKN/Sxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shs9kyvWjxvpZA2EEUBoyn5FhFtJM5VE+rEDj4pUvISEKIo4AAPUl0GZTf6Dr9hwEpDqv6MGSM7uTMun10LDHdoNouOYB2hhC1z9Frt6NyB7IhxzJvUFAoobu9bRzFng5/QF/QN3D5qN//J/uGD1KFkLwjy7c8y8EhPu57+DraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=b+jNZOez; arc=fail smtp.client-ip=52.101.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="b+jNZOez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF8YN54ieE+JP91kmLmsinkgin/GznK375mHvw4+H5qaT8aONVIoqsRvH1BSFZnfqpqdleM61i5fdV9mYwDO4bmb1/XjBtwprD3ah1ewop4gVjx4EuAdZ80B2fksfVWqFXqga5SIMHr3ka6/OVZm1FB7yHmuIcUhvSCxMhdJMKgZehdVL4ONWKPtxnRgH0CYLNSZSWLjW1L56NRM+6QwvS8egHVm7jCBwNvaCsPwfT0S/I0PG6eE3Pi7sq+TAx2TehJQBbv96XQDwO9pEcPGGWZDhaXEL4q4tmTWEOsUiPofxPkqje6F5GXCTpWUmRpOsaTZO5XfqhpJrCAEvdnEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBnYSJ8P00F6a4tSszP5rdoK1W99CgxnfecMRK1BKs8=;
 b=GJdfpgojPHR75tLmlQ3C+2c9Qeq3WJHN+riQ4z8V2sdXWQBrPcoS8nJiAi68ExOmxEEAH8jdAdzCNxcowiI0/x0vrFOBPvn6KLwlDUEDaSzkGr86bdWgvHFzlz5A600FIlZDqTwftSBwN7UBDZ9jKQ/p8Fvips25VPYdAuDePasqibxOjO/Lp00re4J4IYSjrjvU57E69B78WehdxffBAnsiEA75V7W3h86hLACn0LDoxMjTcoCCyoNCAea8383+nxJcWkF76niiaBoM9w+BELPf7JsA5dGejUFyNB9ggKw9cNeNXJjDIMnIp3RIf2pupNOPd/g0lfV8cApaqbl08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBnYSJ8P00F6a4tSszP5rdoK1W99CgxnfecMRK1BKs8=;
 b=b+jNZOezAfhgkTp0xy0vn9jJUSci/G7ojy0rnrohQ0HKmoAtwPO9P3FlTySjRp+8etnJbIagQWHA4ETllcwMxuWieYdgTW5nTts2jiJqf7eWT7i8g7Cmu90HJXFhhwEdSoaa38tW74WeA+7QCZGzvYAD2rHsonH7GixDMWu7s5E=
Received: from TY6PR01CA0025.jpnprd01.prod.outlook.com (2603:1096:405:3bb::14)
 by OS9PR01MB17980.jpnprd01.prod.outlook.com (2603:1096:604:474::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 12:00:36 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bb:cafe::4c) by TY6PR01CA0025.outlook.office365.com
 (2603:1096:405:3bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:36 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 5B8343000441;
	Wed, 16 Sep 2026 21:00:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 3/5] thermal: renesas: rzg3e: Fix race between set_trips() and get_temp()
Date: Wed, 16 Sep 2026 12:00:01 +0000
Message-ID: <20260916120003.87018-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
References: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OS9PR01MB17980:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44c836fe-696a-49a0-bd10-08df13ea1e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2wVlJgFpJm67vVfUTaFvgOVEtZDWyfNivLd2fR15/0sqhcy9BOG1tfypw8wn2clCXGRupgHnkBSTovihBuPZovGXprI5GDgwN7hFD8oDUzm6B9BaQocHCB2qyAjr0bnf0qAlbtjRQcB48rlwCQZFybyQisvYts6HQ9e/ZxMxsqp6bVrmyFybcQbn3jExcHlmTKVzJ92u2rqp9iGTbIQmTiadLTH8NXXmSWKgZlx/X79ggs0SwdYohWOFOo8P/bntr2Av8joBGvb03/sbhVy9zV8Xco96M3ZN8i7zglltdUI5n0thdSv/JVBRAmBB/jbesW/brjrPIwB25QfJozoziL7m08zZaZcKycpLZA+t1H1ppAsPR02yGywDkbl+ox2wiQz8rhs3AbTQAICNNUWGcwi9VsKyxWvsEukRY/egZQlUmj9xUQONkwjdyJTPtJi8EvL8nwDka4o53eGzUnhx05mNFH/VH+NZ9b8+3A4FlxYd9ZCIzh2KxBokPymjRbDrUU/6h2chG3Vjd76T5mmvtCDDBuJFg88ERsCySy+Wa7wxyGGPbtaxNdrpO+dl0gNnTKg4o60+YbrVcBSoiA1wV8sqf/UtCICqXgGOBXNl+Iu9A5ivQR3jmRYlK0mlJ9rGI9/b4Erd/IzgLJNKkDp2oR7PTzf264qxMOah5twklWyXcG0HdJ1wXiJ9YQa0SD1KedVfsbAEW3//UJfWZBHHtg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cmzcnWywAulGwIhbr9++D69GwcjH3BjughnjiNTooEABMfQJ0vCb65fG16rUHSR/BlBg67KNKN93eH2TrKsBlvSP5lOLwA3l7rItay18S4T039fvaTL8ZX5BC6gNMTMN9rlRJJcoxWmoSovkZT+s+DN3Gj1g/m0keMEj4zC/2Um1vitfAfTkro6DJErJJ/2c5rr9eeCios5yE8Jwfrx8zCo92JWQ9jjqNlHD8AufvYed7SzXKxWrZf4/NKqxF50qnDVRr4M5Xbv/p3y9KZabhZvjS8OiUjMlPDuXKNMZ4dg9MFyg2bhkiuZyQrEWrMEvqI5aB7j9D9EEm51xr5Or47Wt820qQ1H/WIP5H/XYjnOYA1C9gfxKKylSxIFfkmpYI/HcqhIIMP2GF/Yd7SDGRa7l4hLhypSRTvhNj2dnC+M6hQfY9liRXXRA7GAzRIul
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:36.1672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c836fe-696a-49a0-bd10-08df13ea1e56
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17980

Datasheet section 7.11.9.2 "Conversion Start Trigger" states that a
conversion must only be started while no other conversion is in
progress:

  "Before making the setting to start conversion by software or an ELC
   trigger, check that the CONV bit of the sensor status register is 0b."

set_trips() starts a conversion at the end of the function and returns
without waiting for it to finish. A get_temp() call arriving right after
that starts a conversion while the CONV bit may still be set, violating
the requirement above.

Fix this by:
 - polling for CONV == 0 in get_temp() before starting a conversion
 - not starting a conversion at the end of set_trips() anymore

The conversion started at the end of set_trips() was supposed to check
whether the thresholds have been passed, since the hw cannot raise
interrupts on its own, but only when the temperature is read. However,
the thermal core reads the temperature and computes the trip window from
it just before calling into set_trips(), so reading the temperature again
straight away is useless.

Fixes: dc67521c20b7 ("thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas RZ/G3E SoC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 45f67b2e1131..58fdcc66456a 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -225,6 +225,16 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	guard(mutex)(&priv->lock);
 
+	/* Make sure a previous conversion is not in progress */
+	ret = readl_poll_timeout(priv->base + TSU_SSR, status,
+				 !(status & TSU_SSR_CONV),
+				 TSU_POLL_DELAY_US,
+				 USEC_PER_MSEC);
+	if (ret) {
+		dev_err(priv->dev, "Timeout waiting for conversion\n");
+		goto out;
+	}
+
 	/* Clear any previous conversion status */
 	writel(TSU_SICR_ADCLR, priv->base + TSU_SICR);
 
@@ -304,9 +314,8 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_device *tz,
 	/* Enable comparison with "out of range" mode (CMPCOND=0) */
 	writel(TSU_CMSR_CMPEN, priv->base + TSU_CMSR);
 
-	/* Unmask compare IRQ and start a conversion to evaluate window */
+	/* Unmask compare IRQ */
 	writel(TSU_SIER_CMPIE, priv->base + TSU_SIER);
-	writel(TSU_STRGR_ADST, priv->base + TSU_STRGR);
 
 	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
-- 
2.34.1

