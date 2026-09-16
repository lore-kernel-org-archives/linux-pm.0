Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1A233945;
	Wed, 16 Sep 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560051; cv=fail; b=SJwXE09JSPOfUHdD/FO95JE/EwVUkHFu5N//GA1CcaJnGyhLgvSE482F7EFKifqt3/2qUh8TzSKhwUBUAh6oYEajjLo8GQd555nF/DZpIP0onb3Ju8rKsxnxoKcUiCqmbF3Fol20LaNe21cQj5eReQpQRvtJZEDl5hcpFLEJWWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560051; c=relaxed/simple;
	bh=399Ddsop68fdRiWUrEPQwgeDB9ohvg/K3bVxZwkSzd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFS4zZWNo/cFdlOsyOuaM4nNEcKeili7+d9HeW4S2odkmu6RIjl7TQynKwoKOSIOJqh/AXfHCZt2Dmfuw/MbrhNXrAl8jSPJwc25xgYAEYDlmXbLyncDAiap2p9V21rHh9HgCb1ZtiIKKx8zUtzOTu4V9emEm+vuG5l53cRzXWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=NMScqDqP; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="NMScqDqP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNhef3jWC3tTJrOPeqop0rdcOInPg/sqH999OzG4wF0fGI2uxMujCHN3l2NazNDvrEUgwAOjXaKaxcHAMwcdppHZLFzhi7oejXsv1DtAtnYY+bICHjPVuabudjKU4Lk8WM48If59Z0qq7kc5VmmVxGIeC7kHFpoSLZQfaRK6vIxJVGuWWTL7kAY/tzPJHBDdVYXg683FhhBanKjbmXDvaRfXcnoVomXHic4Ztsn2aC4KP/FF+/RlD8GkrNl41BIVSFSozrb+DRbvaKDmYTq+ctxL/y0/5wuPFS8oT4zSiNoeJDtVat4TNRYmplchbxPzg4oxvBzEeyxAJt5JwivAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT+euU59/XOrSjauEIcYxozIYKvGt0YQYq4LGUf4eX4=;
 b=gqqv/W3GZdbpjCF22IEJ2Rf+I3o6K58EEQcJekb8310ZezmzayAEzlD2Dm00Gnt/4uFL4bcytHBWqBkW40H3V4sGr55DRdu2FSjHIeaC9eOWfhQueX7tnbZ6NI/vw9emEuAqSRD2yADBtzGjAw2a9EUvfN7kvb+o1VVUqBk6X/hCZjUAMtIqBtjSDR+nScqgskOFoljJEUFmSFn5uDvrl48t4Wu9ItAjlEsbTQNa5FNLDCajAXI1mfFgNx/eOYuo6s8dNNTufEeZZj8BIhQLXLBLKxvMYS+7O7Cretl5MELn3T3JLePxR8Cv4jqYORzjhTbQOt7L7ybG0ppzNL01aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT+euU59/XOrSjauEIcYxozIYKvGt0YQYq4LGUf4eX4=;
 b=NMScqDqPSv0IWWVmuRJQt4cqlWxsCl6MMVnxGro/XSx4K46GV/SgJa3fDiliaPg4ee8MoreNi8sKMX7DO96OEnpPR39kOMF+wpjzcl1o4Cu1MQFScUmLi2hcSboo0J/MLTL1ShdCymgwgLVpzYKvZOALsiVKVk7Uq4Fs1xaq7rk=
Received: from TYCP301CA0001.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:386::19)
 by OSCPR01MB15628.jpnprd01.prod.outlook.com (2603:1096:604:3b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 12:00:39 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:386:cafe::2) by TYCP301CA0001.outlook.office365.com
 (2603:1096:400:386::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:39 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 84BAA3000441;
	Wed, 16 Sep 2026 21:00:36 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 4/5] thermal: renesas: rzg3e: Remove unneeded low/high check in set_trips()
Date: Wed, 16 Sep 2026 12:00:02 +0000
Message-ID: <20260916120003.87018-5-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OSCPR01MB15628:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 77f22844-0889-4574-10dc-08df13ea202b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5eN2AG0MlMj3SYZsFcXq8y1lAMGAXlv1RY+DRDgdBWtU2uklNPU+Y5K/JwvuO6Mkf2fJ5rqJQbeN+yerzUE4zoz+7PBNSPoGDtssZNsSoBtf7Vrx7drw7GID4yX+tTIsEu5eK275XyqZH0sDX2yM7s13VU1qYXn58B16t+cFqm4LC69oFiY/w9Hm3K6exyPMnclgaDxYYdsbWptX54C4uFKK0X0nv0Q7AnAKrZcEV0eMwLNAcjpMFXXnLhpmhMWQTgTDkWSKQSYAvPQP/O1FeRu/w3L6epo+8zeZYVG71wpwjFsDR8uZ2xmQ1W4YEQV0Sp+mfbo6mr/+pEH/6R9lKJSx+enePtWiTwJ2+0GsS4xH7tgTJSSbCMGYHifhmIEcIB2YK0pugEpuUCJEOYBX5J3tYT9UUw6GdExqti5rw4i6ukwW6pqxGpfQ0Sz4fkf7SSrEel1CM4gHZYTWyLBYUyJhMw6ua/Oej32bSHOWvA1Qr/3NwcLe8Lr6vVc93zlHmzDFa8x8OKEBA7TvtC0WE5TU49RyQTSR7iDVxPZKl/wXa05PzsS1Xels1nYfnoZiYuBwQ0E3bCoQ35MB+3OWYy5X9n4mInMZIsJbBASeczLm8IjK+HveCU9Sj0+ozb039Gvd1nSnW3yrZgXCFb2C9EmTCQWhxwTNhmcbs7+mHLBw9xuTITmmfWCL3YHRew4eqNV5jAr6z2mQ7tZHYJ7FQA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	McQ37vyomoggmPySOTRnKr8TZxeNs2qM+4ulACRoHfJ8JQCOyJ2xGBcEICXX5FxTGsSM9QeKqzBdNIArheFfSF7YExCr27YWaDOagHyeczAMUSlQISD/6NZTxvUlGHH3/0SQRyZ5N8O7Did12e+qqk4YAhQZ3BNQMKpp0R086APEXIBx4R5/0Iw8DbD+6plUoljvOsbQHIDBMPjD1sHNdFbtkyZ3c3+G+BnDvuz6jCz+2wRSzkUlUZ8gMa2nKJMynLLKGgmhx5BP2q0V5fZiwkKBSq7ekUnOtbbndkcbAfdV2hFTT1b0uBiXENS2WLYkwVwgc/wJlI4+NY0CiLyyiNwv0IOOGegaAvsejnX0j6Z9RKnN3OJImnktjfRB+IqtBvxKUVyeEtGmJq0acMDkjlP73KlJJ3gWIHDatkOgh6d8NaWnIA1pY6VCCUcTF7mn
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:39.2369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f22844-0889-4574-10dc-08df13ea202b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15628

The hardware manual doesn't specify that the trip settings must be
strictly low < high, just that when the CMPCOND bit is 0, an interrupt
will be raised when the acquired temperature data is > ULIM or < LLIM.

Also, the thermal core already guarantees low < high.

Remove the redundant check.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 58fdcc66456a..ffe2b8725031 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -275,10 +275,6 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_device *tz,
 	u32 val;
 	int ret;
 
-	/* Hardware requires low < high */
-	if (low >= high)
-		return -EINVAL;
-
 	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0)
 		return ret;
-- 
2.34.1

