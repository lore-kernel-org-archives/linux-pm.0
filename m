Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210424EE859;
	Wed, 16 Sep 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560040; cv=fail; b=Ri5ahV7ffDCH/DeN1jaHWY1rXmNEnU9Hrf6LRW6Tt9d9X3DBwn075l0nMJOR4IWf/uu5uCuZjHEmsGmc0SIWYI87cMpfi0wVxYhM7oI7JIsTZci8oFvG+b8+rEOt+MLyjDzgaHGoemFxvHzzFQIb36KOF6NCAI41elSKOAZmKM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560040; c=relaxed/simple;
	bh=CAxiBQxK2jvg8SSafbloXfGCNNebQRNw4fZPHyvaqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pk0GFX2aFMMMTaM8K+EGVPsT8jh+LgQimmsenUw4Ygj/T2gg6tPiBikkc1+JCVyhqOw2DEHj0YEqEAgFgHuhIigD7vv4WDsPos9RxEkJLmo7evP6slHm6U7jYnCABxB/qrXda4odn5eM1ZX+xhh8vdeKDquiv6gEWubIe8h6LJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=RXPAHCdu; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="RXPAHCdu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT3KxsoqVxkfCH0lrM0u1wzCkwKvwq5mUPOeMXBWGcQGHCrJH1r4YbO0OuyaLfmzVQL3xnFLjaZ8It1Gx6RNkiIoQ/YVjMQPAqLFCXMeApfyg88GwWj6r96Ek1zqqaesJOSpNnGD7NPU/C6QEj6QA7zBiZ9VjJgfjw+lALsoBuuUk500zf8Y+vMFsgJpz+yfeBOf9GgAr96eZz1feOyI0mAEYv0CLPB6KBxCVAqW5zYP7S2n6U1bXnrOOdeJ6NO218FHTGW/RsWxFbqYymc7we5iMvpAsXwzTtTp8/NN2o0zZxZHIPYvJ86wuhtgTR43qdaZtoew5CG0YWAcItAQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k8bM4wvylMOjdZ4OcJyaDnzalIYhohN2NZ+ebbbLFg=;
 b=JLTfYUN0Kce70aHVf2IiyNXMb2x3eY3L4CT0YqDTUihxgldEkFCoiwzD8mkJjCbuJA0Vcgcmuc2nqIJxhAlNhy6HFM6o1luwwHRmretl1P/g6nU9J8m4yjOyNzfzGunWxmME3Yy6c6lr9cqLZE5Cy7Z44rTPpDkZQ5FKNRIJxvlEcvGbkRj0gAoHO0OJNLcJG+XyH3ERF0dMZy3WXvqAm158tGLqAch9NjmJoUGmDszIq0h6YIMGn2Tdyu/6BKywPwaMBelRDPJWUp5yhitDi4XxJ1V1fTdGxEyYYvowCZm7dX3C/hwnYlYCyG/Cucnv4lreD6HfvwQX4OMYW+x2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k8bM4wvylMOjdZ4OcJyaDnzalIYhohN2NZ+ebbbLFg=;
 b=RXPAHCdu9Xw7POl5vSExYhN/mPqLqkOntH+mZBLRwSHuxQjXc7JKl0KtVryH/qGCx1tgkDUzfox026kA4yE9qRwz7BA9Us++DSf8CF0YEos7kbxB8cxgPMEeSldmtP0yDznAbf+7fHJh0CrL2CKxGjuP6iIVwotOWKxQcNhgezI=
Received: from TY6PR01CA0018.jpnprd01.prod.outlook.com (2603:1096:405:3bb::16)
 by OS7PR01MB14893.jpnprd01.prod.outlook.com (2603:1096:604:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 12:00:26 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bb:cafe::81) by TY6PR01CA0018.outlook.office365.com
 (2603:1096:405:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 12:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 12:00:26 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.205])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C71843000441;
	Wed, 16 Sep 2026 21:00:23 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH 0/5] thermal: renesas: rzg3e: TSU driver fixes and cleanups
Date: Wed, 16 Sep 2026 11:59:58 +0000
Message-ID: <20260916120003.87018-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OS7PR01MB14893:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54b6de65-c842-4c0e-a333-08df13ea1896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	32/rKG4DM42OyTeYTyUXZ23ioIVTTToUdGb6byRAZD127nB/ZRxKECFqU6/UwEtM5qkdxPZNl8G4U79aK6Q6rgf0tiQiqMmLD910gqm1HmP8GqKVxbNskoBqFFkWf2IMOrIfE0TD+blh6LsJi+ZayhLbMVeGaDyFd8srfQcd9If7fRFfhXJAbgGS3v67IxpVMNwPvPc+pyMqoWxiwfxF6uyjyuIDRAGjBep7ct0spLbSFGWrRLPeWtruA1Atv5QtToIJf7Y2K7qC8InryMlA2dgrU+V22AVbqmM6S5Zpmh3mmj0+PtLqfmKeCU/8b9lapP6SVjon7yyws4Y1bqFr9SM6pmx/NClezS0pwHgmnNqTkNuynzLDQGMh50aFvwTWx17e6Gyf+zq26f+XAMnezyQy/QdxmgBuF0mVOnr/gIEHvDoW7En6OJ0XHvdq5TNUtqM0IOscnrvNxgKNgguWex1mv5vd79DPJl0l4YIU1f3UIxSCAyxrYj/wEg+BN+LNE/QV9HH2KNz2dyeSH8TI+0p+1fKY0Pe/ZerqJARzkBOGLILY/aEj2v3hcsIc0OHwV/mNa9x8xFU74bvCXdsWHE4aiS9EXiXcchUJpf8Rj7ORNVN/9zVm7GZnUPfV/bD1ukr3dK/lBY39CT3t7qztZCz+FtVe2F3YzebePj2PuJ0zNVq2TIkhBshyEev5Gi3CnboG/3ytln6p9oDFKPNQKA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LW3Ebry9ZnQsJxoH+dlbk32WtVOT3/3sCpWHG1qIsXcyG5k2X+JbABPowWYqmY0HFxx5UwtETQ1lcM/uJ7/4VXRnnrTYcQtB5MgBOQPGdP0k9Hc/d++KpPtcuf1D029jubuJfsG9HVhq6VDhq+Pl0iyiGjzpGMknVTmDYaC1E3EJkiio78KSVTjxSjqAULoTSbxwofhhLNQihvFV3E0r4PQD/r/j5QMVwx4Q5GhOsxaWZJ0Ovh+Utmh4jBE0K1daG7oOwMamhjWA6mtd+8hXj59OxSdcsg4XE9NgGpMUH3Afjd4xf5vNRFCtf1hLlcqy+El/N8xGVBAJnH+rTQniM20vhlgYbiX+yi/idohBXM+Ljj0CYa0WoT5z8Bi1ROSIMCyJF4j1Nz5UZjbpt54Tx5aLxfpQmPV3xy6DC8dUuuXr0YC6dOFjEtjndZ3k35rc
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:00:26.5200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b6de65-c842-4c0e-a333-08df13ea1896
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14893

Hi,

This series contains a few fixes for the Renesas RZ/G3E TSU thermal
driver, found while reviewing the driver against the hardware manual,
along with some small cleanups.

Thanks,
Ovidiu

Ovidiu Panait (5):
  thermal: renesas: rzg3e: Fix signed integer overflow in temp_to_code()
  thermal: renesas: rzg3e: Fix runtime PM handling of compare irq
  thermal: renesas: rzg3e: Fix race between set_trips() and get_temp()
  thermal: renesas: rzg3e: Remove unneeded low/high check in set_trips()
  thermal: renesas: rzg3e: Remove redundant pm_runtime_mark_last_busy()
    calls

 drivers/thermal/renesas/rzg3e_thermal.c | 35 +++++++++++++++++--------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.34.1

