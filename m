Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBA3BCD0B;
	Wed, 16 Sep 2026 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560059; cv=fail; b=gA30dwAnevOrFLsLwfF7zaD5OPR1QBZK8YmlTDZQAsPPAlBrpB3FX8zFTA/gfbf6hwcU1kfDe/UYV107oshAA88XjNdw0pCml8o4T7WF3kyFtln/In4ntHI27gMnwVb4dpDWtO9kkxaFYTO+KkFTWPBeo70i7EtzJKr4MsWaRX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560059; c=relaxed/simple;
	bh=PwI2IGpHvsqeDpfUb/pz7MQGnr1C9zHaYVwKVMGelkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBHgNxeLG2mM2AvtuIbfARzf1CwGAaAdtXOCSqVE0zOTi1Q1FvY6K9TkJW3QAmruRYDFt1edQgbEsLoQ3ZMG1dYY0BxGKB8rUb98TiO85k6JL9Yfc6XsuHAP3xa14a02NphVacReWbXCtwcMQMgCwEx+Ux67Bmwl/vN2MfB8UxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LczT4ih+; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LczT4ih+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNO0kF53p+9kvtoAfSK/2PUx3MLIQJUzRhPpOfAQE15r92V2qHdSZRj+6r7y4kazW28h2fQ4wm7uEtXoKXatw2MoI9HjYSzOMivHAPWyQf86dzOSBxjTTflp3hz9kzHArOh8rp3V85EXhO3Eq8UUfhXN5C3c0AV5Q3AS2zLMyIxr/wko3mXNlI3Gi359P5fqUd/uMeq+cy65fGjIlz+iZIQGpdX5FhD5Fu5Nw+e5ot7viyrv29YaPbBiHbVh9w3uX4qjSflCSGUsU8dhEWlO9J/b1NwKbIOABXZiytWaZvbV1FVNDN8envVYN1Er5VUEAvuTHYNVz411+qTSjd2nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeudhQGTK91LSTKQCW8CsrtjVUu2nZtKHzSaWIk77a8=;
 b=snsDSC4DkU/G4o6Lvi9r9un0EDh60tIbdjtmmtI3d+61Jt+YaCPijn5PIEXWlm3+dl+FCdP1FiDwlG7VNfW8g2Qyn83ywIYQysO9/T4dcO+GMLgdK5hCFAHGD9IQYJxPuSzJG5mSHQF2DD8SnRxgBBLkiaWS2oYBM6IVDZ4dq1j2ofQ8YCJdV8LJ8oyMlmtn/TPBKxtU5Bu81DPep+c3NBmkclpv3P+/U9i1YK7C0rKjn4wG536GjDgdvi+WJ/QK9JvNSYWVtz32mpHarz3Z/JVkxcW2mIGmjsVEWRifiYASrOhjB4rwQj5WaP7pwbWs0aWWl/GTqxCmdoOpONotwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeudhQGTK91LSTKQCW8CsrtjVUu2nZtKHzSaWIk77a8=;
 b=LczT4ih+3euTzhyptX/VSUAROo6W5UBdgtkAsXFZD7N5UwzQF8JDXKNzmYx5pjEem2lxQ8nDeYTspg4LonvJowl6DNzCMCbB7tQFIy36PJzkWUjstmMHQRmCPlZapAiba+dPYG46iUrVUkwCnIgWwlo9eY0hg+AKlsHLTpm5Yzs=
Received: from TYCP301CA0007.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:386::18)
 by TY7PR01MB13704.jpnprd01.prod.outlook.com (2603:1096:405:1ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 12:00:42 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:386:cafe::91) by TYCP301CA0007.outlook.office365.com
 (2603:1096:400:386::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:42 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id AD9A93000441;
	Wed, 16 Sep 2026 21:00:39 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 5/5] thermal: renesas: rzg3e: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed, 16 Sep 2026 12:00:03 +0000
Message-ID: <20260916120003.87018-6-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TY7PR01MB13704:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48f53048-3939-4bc5-3f79-08df13ea220e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KEFvHES/S6aWNmVJ8n3d5lUcLtExIZZ4omc8rMafrq8uqXV2fHFf6nyOZu/97M4uccMJDOmg+xBGQGkN66Z6cWwf4NQ8zQ+bsUBOubKHZYIuqH1fRT9GCZYNBNxYTk4cQXMKh2QEPaBowHk9N08IkfFczaymeceGKhSZVDMsp7m3Lxfn4W4RQtntI4CeCdSJGO4aVK0AB9k2n2bBJllVwkV254W5sei8MEWpVxds8itu3/QF4dA6P5UgND0y6yXZZ6b5rUdv39yYFejSeBNjUOWze9gjO22jc5D1p0gXrG+YgkEZCy+VAnBIGjCoesW10jgP9v/yt7eeFwLORaZUXbDkESgMEq6i3+DEhLFEYtBHTNYtuY+xbfd50jw1XGuVBMepTgq7ohyPXG9gB6PXmdwdUQOKsdtft4SpoO8ByazXTy8ot+z+AY8HXYHC++HJcv5YY4z+fkOIjZji6ilXoRfrdWtzaNJqNo/yppO2xMzyyT7gaLmcWqjKxGeaQx0p7ZzrXrDLWFBPWsId4kFPb8zF9wdEb2UFIK1EnnMvLiWLHx5p/imwNsUV12Wst7LB+mgHu0csAU2oXVR5y9KeceB3/7eGayGeo6mZR1hGEu/6sndnvk2G4RO745tFUTYhXPRkSRkLioW78hLFwEF+GzEv4rqbyAZE2bG9wrCKNP/KBZLnaD5BWlcBcNaOxplaM58kbgaI8WE8YmaG3aGUFg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qmOMPkbW1gcZW8t3t0+pDwcgpFugZQ92IbHx6IexXce0DCkvapro/ysBaexLyVZlNryZ7gSsxCsx7SpTupNg5cUXd+Pq81AZ21QywiZjTud1+oAVSBBmwQT5cF0kK/8i4PLEnAhzlYt8ZcUo7gXZJqjTLFBds3cljh6PySgqYfA/rXT5bZC6rlD3BawfoKJ++esR7GGBqIHd99PifoEeDO9a9rhQTUW2IKiA4wNMlSkHg2KXl1MSCL11SWKte3WSi+8f4S2PZv/0b9ZXvLo2/7XHuNIdDvs0tWp2WcN2+5bWz3lPot/Tq41deB5eaeYKXSfGI0bAEOs+3sr6a7hPPRgEQiVa2SSmyJbpqds3D8x3wl3dGf/aTjE/goykzetBlh5bHlnrdZCJMda709JcbJGTZ/nLx3TNrPXq9Oauwfw3EsHie0yjWAnszw/tYYB6
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:42.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f53048-3939-4bc5-3f79-08df13ea220e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13704

pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally, so the explicit calls are not needed. Remove them.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index ffe2b8725031..a1ceff79e83e 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -262,7 +262,6 @@ static int rzg3e_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 		*temp, *temp / 1000, abs(*temp) % 1000, code);
 
 out:
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 	return ret;
 }
@@ -313,7 +312,6 @@ static int rzg3e_thermal_set_trips(struct thermal_zone_device *tz,
 	/* Unmask compare IRQ */
 	writel(TSU_SIER_CMPIE, priv->base + TSU_SIER);
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return 0;
@@ -485,7 +483,6 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	dev_info(dev, "RZ/G3E thermal sensor registered\n");
-- 
2.34.1

