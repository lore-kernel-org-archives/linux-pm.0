Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3003A5E73;
	Wed,  1 Apr 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040877; cv=fail; b=KBVs5R2Zp6Qmry0ETFKQKuxksS0EK7907aPZZ7qtK+BK3AiJNcyYzq4KFupUqWSKfAEiUerydxk5NGIH6GUgOPOMOBQpxWSp74e0YqwA/TwU5xFkK5CjwVzfzstkX3+PASfvFpLBLSWpczzfU8NsDc4xl5t+pivxy44Ixny14rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040877; c=relaxed/simple;
	bh=k0e6M4WYe/cSf1KiLNMKdYMrtobGM7z2hgEiqRnhxOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Juan8+HqxO493ZPqnD2OM6TYB9viw++Y6vLyI7DkoD27OFPyBqMfyaUxAp/OFc7iVscSvW5E2TK1eyjO0L3yZECHLAhuV6sGwhfjNutAnkCYJinbZSd6k//HUfpJMrnMHUh5kC5rkJBgglHTf7xsNz9LRyNNult2kwkN7jfsPp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CyJll75V; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CyJll75V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVxWY5i0FVNbp3dA3xiEPLDo46qQ6/kqpopo3WTBnErwkGUw5vezwPuSXXIjcmBQYvAL2YowjDF4IwuDX3mrUdgkWKMl0iy69QbWuG6BbQzAlux5xN9w5QwcrnWRNBTuAbDslZbRPUTcruh9neL521TH97gnO2ZPd2Kbgm7ADnO7mPzMKNp76yNaupXNpM/2KhbXJg8OoPL0huzW1OTe24NYM5GDzom8OLyrnvwfwPPMDZfX9etSDQZD3oURuEzd1sgN+eUXGk+37MtqpwM4oAWK6d3YpZg+WgUC+etbUBR3otMBTbkXgsQJdDFuKZ5pCDolNqNLU2toe9XTj3GP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ylxxZRea5DCicLGYStqEnQK+n+pN5UHDoxzdf3/BlY=;
 b=FlftskdEIUPU1TWIGl0C5asg/VASDJUjjJlKuasHc8UaHh6oSmXfFbBj9pwhg4GspsPJ0hNuiQzdX4LIl7ZCvwpddwCrpzcloWlvnoOhrgQpbQRW1v14FGaNaGWl8LdpDz4m1a2EVLlu7w3IuHc2rIMmXo4c3nBahj4DBVuUF6yCPbjt+W7MlTywKMW/+3E/PVDKeeDGb2SJ4hw0tqDvK/DAWTdEVX4ygkqKqOEZNmCXenisBuPBSitxjwz+7T2o16NpZvHOD9m3uYe/Y4tE2GkI02vDeNPi/7J2S0QPmSnwLWruo4NbSJX1qj7vnMbQ2ciyJ9PgVFqLS6CQ4oGLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ylxxZRea5DCicLGYStqEnQK+n+pN5UHDoxzdf3/BlY=;
 b=CyJll75V25rK9Vx5QaXAV+2OYPR5Q1tJt/JMTiuoUUl+KH4mmpTeovll+Tp5sLx8jWn3UoDjDJfxU5CfgDubKBANQnatm2F/7tV3EKYT2i6Ba5pLZVtN/Rurx8RvwHGCoyjUrOrnekwYKPm4npzVxDAzBN59Vj7RwHceC5Y+DTA=
Received: from MN2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:208:234::22)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:54:33 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::fa) by MN2PR16CA0053.outlook.office365.com
 (2603:10b6:208:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:54:31 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:26 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:54:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:54:26 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631As6KO4132409;
	Wed, 1 Apr 2026 05:54:21 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v2 2/6] dt-bindings: opp: ti-cpu: Add ti,soc-info property
Date: Wed, 1 Apr 2026 16:24:00 +0530
Message-ID: <20260401105404.1194717-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401105404.1194717-1-a-kaur@ti.com>
References: <20260401105404.1194717-1-a-kaur@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 20364243-167a-4709-1713-08de8fdd0dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	phr/f28nu9kglbS2YYAQQkUYQ372XE4v6VrVrgrvomWGOtuBZ5TXTqC1vIGIK220CM3qVE37zIw8zGL2rTF4lADVOXwK5Hsa3S+AoYFrM5rNQ1jFkT72/vIbANxv/LFcJwlLxuDrBGoiNSOh+4YbjDUB95aX1lVQHHhPz7NZtQTh+f3LnleU3jm4HYpVoy7gi1+CT5/IEvxEtu+obxfcFz2Uu4rjXtdODq1ijWiUjPK2o/ttIfslB1kmGlSbwb1AmqnYXP7H5+4inW2bX/ICPQZ6g7OgGHZjdmumb/Tv65o1Z+cBjk9zErb0ITrXOqMIg6Op79WIJS4DUzBG8mmoYDM+3QZhnl8mkWs1eQAeS1AhtBWW4+iD4FW8a9/OMHvSkHb+ezQB8caGecdQOVnb0C7wWveDOArS/kSIgpUDrSzlqbKYtO+dsQZAOMh7FD2UyyGh0Rfpa0LLOXQVw71xVQ0vS6zeg72x94iPv8eiH8sN5AfWGyn/6Ymd8XKCWLCcZ3Mpk9VxEK9FN+Q7nsMPVHu7C4HXR8sa9XavkaTjDTxabahowhB3d4F2qXTZiWZden7X9Q2l+/XTutJxh5IHMSXQP9C8c7emtBnZF7E+XpeFB559MGwu4oCEVLBuAxdNGTsvSIE8AAGSov0xyATEHD/aPBhA8U8sS+f5oM6nl0qIdrt+lx8ZW1J7lHPp1HFsOU08Il3zp1uEs8n7Xj8Z23WqK6Vq1A5RDDNX3p87ZLixQe7BydR0F1sunpJ+mJ2He5qvRRtY8/pLYVxZKdTs57WTehTgffRQFlvn75bxFnN+BVXaSYhRl8MNB1qLpGPL
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EkrgV+z+ZvPrCFrPWaHLCuivJbNxHGMr3tp0CxslpEyRfnCqX6u0cp4yKnkzlY63JGdV6GXtAYmGJaWgHAbb5pwCL86xxkrwmbDL2bJjeI68UCZFwbE6gnatpYdSqdH8agkA9jdx2PikK19vs/kLJaLLJ/5TM1t8yPWlAG4Eea3XuCaPnVu3JMxbrINnDjuulk6GBSGtuSLOJj7f1/9oC25UokXHV+IWeBAsSkP0P1rDQn1sW3VkFvF/IZHDNl4+eUittRc90zJAB/jMmN20RrRgdPkQoOONGtjN5tpxdOUg+aqdH9z+gcPrah9XyzX0CSSdrjHulL9YLT7BAD15DStcyGLc34oNuhKku37H3zGSwNofGiOgOMZLjETy3Z/sDq5wdSLjeOp3oqT7IcFzUFbylTN6uDEq6cWUEeir9TgIWem2QLZTvYwsyT5zJT3P
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:54:31.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20364243-167a-4709-1713-08de8fdd0dc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144

Add ti,soc-info property to allow OPP tables to reference the SoC info
device (chipid) for establishing device link dependencies.

This is used on K3 SoCs (AM625, AM62A7, AM62L3, AM62P5) to ensure proper
probe ordering between ti-cpufreq and k3-socinfo drivers. The ti-cpufreq
driver depends on k3-socinfo registering the SoC device for revision
detection via soc_device_match().

The device link also prevents unbinding k3-socinfo while ti-cpufreq is
using it, maintaining system stability.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 .../bindings/opp/operating-points-v2-ti-cpu.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
index 624d1f3f1382..f318494d5295 100644
--- a/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
@@ -34,6 +34,16 @@ properties:
       points to syscon node representing the control module
       register space of the SoC.
 
+  ti,soc-info:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Optional phandle to the SoC info device (chipid). Used on K3 SoCs
+      to establish device link dependencies ensuring proper probe ordering
+      (ti-cpufreq after k3-socinfo) and preventing unbinding of k3-socinfo
+      while the OPP table is in use. This is needed because ti-cpufreq uses
+      soc_device_match() to detect SoC revision information provided by
+      k3-socinfo.
+
   opp-shared: true
 
 patternProperties:
@@ -82,6 +92,7 @@ examples:
     opp-table {
         compatible = "operating-points-v2-ti-cpu";
         syscon = <&scm_conf>;
+        ti,soc-info = <&chipid>;
 
         opp-300000000 {
             opp-hz = /bits/ 64 <300000000>;
-- 
2.34.1

