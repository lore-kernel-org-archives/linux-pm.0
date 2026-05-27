Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66435E1A9;
	Wed, 27 May 2026 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863162; cv=fail; b=Off2RJG+iRzdJtgusq9qEJBKKHWA9wPZj6VEwCf2Fi7nts87Du8ysXG4WT4/ZHt1zLc/8ThmXIg5nD3peS4gSjWE5jjE9vQvzOuSzrlqMwClcVDF8z3vpI6nt3i/08SCk8rP+KoFmiPBQPoSDG6TB7NG/V20tfCaXjJ3Z5+RyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863162; c=relaxed/simple;
	bh=128QYALdbn74IA71mBYkkpFbNPZexvA4yxqTKidTbt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jEg+KyLTsIeGyKXRKbNx5hWH08MqAbYeSl+jNsszvNOQ3Ot8RHbIEUGp+az1t4o3d5H5O7OEinxiDhyRni5iPmRnrj5uWSsPPl/5w9EJ2cbj5IXtnU/0aBSg97MQgs19/vBxm5LntHTgTjm+sfy96euOV5U/qN8KhAMRd2vEetA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WrgmDMDn; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WrgmDMDn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bob31OjOQ0HWAEJsoR+EYrB6UH1TK4drFORx9b1wkQz3p9joaZghIh0mfEoifUJMpXFJWWob1/+Wq12keCy0SnQboUH/gq1q3Mwtzh+JrPXWgXB3oiskE/wD3yh/G+aeVuoKt/BsEeIxnbERB/6M91pCKzxRMOOyQk8zziPTMwGcgX4g+VhxtVaa9VJzMcFOVDF86n8XG9CouQ6/4BObADNoS2I/Ro10YvebsbfL9utRPmU/eVAyVZplCOlUY4XDiw2gqAsMzBz1UgH819EOcTCHz/1FOk+DS5oD2aK2dLkyMxOiFRoKuJwNUSu8L+UdDNfc6E1FGE7INUUlnO/Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj2u0v2Jj5uv739jx68141toPVIjSP0DXvf/gXsTg/A=;
 b=YVJwiHIROdq6/oYVkASYxzXfPAQjNNIWyL49hddNWLqNG7xOE6gkRDX4lfiQikjNpj0swGw6i/bJn3QkQ63CRL24pwfdJ/5Yj9zRtYG82KsDRxSCBypsOUNWHaO5NjXkwG9+ZzoN5v5W1wqTfk3YM2RZ2XmSWGMVTltyOrrBnU1hFd04NJxStRRvfokJH1/1HMqyf9eJpd3r9otUBVbl8uX/LL1Oknpq6oOVngarKhUWmAUH1ws6ZWgYlRrf0k7VNJOu333vd6QO4Xi49XRxeZiqgOy7VSlnbzjtRbByHVVdB3fkSvnzDykAQMRJtTOb82J85g/0gBbubog+mxYCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj2u0v2Jj5uv739jx68141toPVIjSP0DXvf/gXsTg/A=;
 b=WrgmDMDnsO3fY8UICD1V8yUgb/hLN9RkckylmPzeg8tGMruhnU8VvAWfe8c1cjYJMI9by4kiJaRcZBGFhjKXEL7MHSmuQaFghv1nFuBfHVvrxxiKD5zkudU6r624KRrxgIE/b4fB1mRoSZrSCzM8agiKmNFh36ERoA6KvAv547Y=
Received: from SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::29)
 by PH0PR10MB997689.namprd10.prod.outlook.com (2603:10b6:510:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:25:44 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5c) by SA1P222CA0069.outlook.office365.com
 (2603:10b6:806:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 06:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 06:25:42 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 01:25:41 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 01:25:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 01:25:41 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64R6PbjV2481084;
	Wed, 27 May 2026 01:25:38 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
	<a-kaur@ti.com>
Subject: [PATCH v3 0/1] cpufreq: ti: Fix probe ordering with k3-socinfo
Date: Wed, 27 May 2026 11:55:33 +0530
Message-ID: <20260527062534.1808422-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|PH0PR10MB997689:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dad484b-aa71-4565-31de-08debbb8c716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PnD6AMJfkaJfL+kAns3MDYRqJmPXkZ6CiqQEo4iytIlsbXk5g2H+PTRy7eQhbCdmS7IzM//Um4y6QCI+CS/zViB0KdoXyjc2kXm4Sb8sMXGOjxKbK/NEubZy5kN8n7tKXBX4sA9n6cGgJrUYxTL+6IwtrmbSOViAngsl8s4/dP9LPQZdyybw0eHo0VEdNLd5zJqC2BSsBNP6R0fSTbGDHkWU2gvrylQPkktV0o2alLzBU1uWCTOX6A6t/t2RDKGck9b2dpNkyryplS+Lm8zfC9YZOo4byiDOR22yxGgDDJx9ITDnWGKZVLBjBzHx738p/Di1LiFPwNhzlrHm6JeoxhTGN8KnNNaFBFit5ffSeaKAkTpc2+b5YcvEaAxUWKVnVzLNkQH4JF443aEblzJnJeqI8kqXktIGe2Ye/BTZXGCbbZue9vKcBsegYWrDyUlotwRqw1QnGdFfOnY5OLLDwkkKiRO69Ntnl+KJ6hJvHCJ4dBeS/KvECMefuAmMUXJNvNxK8ZHBTTMKfZ7WgXCHFh3a1c8Sjqt2D07FNFNfgkCMA8e+2zCa/nM3gaZB6zepHjO2SzyYwKBHmHSlE8RAS6seREBuhRb7sXf6Gyb/GlZaKOP0m89diO+Jqm9eEY4AyBUcXfy1OIrHTh3lp41q5Z7Wn2zUjO0I3JRZoBQaxiwxo2oI9Gd9cCze5ykrNVxpCZg7kiQT1ZI9XZKV9SrKEFrIZhLdU53zNGBuWJqHCgk=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1jQAxFZS7Zc3xG1x5poum47pAxDDrgmD1/FjgBDVk/wtTQtz+E98S7UmJTD1Bbiao+KLUtT3PjRl9DvqZ8rRkJy1xCnweZmjTaAzRnyAeZjslZ6OfXiGXMbPfIcXw0DLU3AIf9ti4xS6kEHww9p00Fo9Bcv2M0sqlgC25VWxLLra1VLcrVcl73twWbTCHvkvTzQFWyfhN7MAn/HSDHLQ8d8man8NRjNIH+P2SQOAtP6EbiAXuhsKDcbq4DxgNG9kyM2ij2cZvbidUmEK+mjnGmOAlFp57JxzzSw0zHXP7FH7oyx4kgXB/mARwW8w15gKw32+Sv53MDdqVlNs2LJZBGSWBx9pBFU3fXfDkGf8CPVZADCn66Tpz/m6StCrAjE9tTQaB8yyMxehU6uumRT782z+ZCD1BGpD4wrJwFSghwgR4FxyLnI9SP43QcbOAJI6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:25:42.0935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dad484b-aa71-4565-31de-08debbb8c716
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997689

For K3 SoCs, ti-cpufreq depends on k3-socinfo to provide SoC revision
information via soc_device_match(). If ti-cpufreq probes before
k3-socinfo, soc_device_match() returns NULL, causing incorrect 
revision detection and OPP table initialization failures.

Add EPROBE_DEFER handling in ti-cpufreq when soc_device_match() fails
for K3 SoCs, ensuring k3-socinfo probes first.

Changes in v3
- Simplified to single patch (EPROBE_DEFER only)
- Changed the logic to detect whether the probe is for am62 family SoCs
- Dropped device link patch after analysis as revision information is 
  cached after successful probe. Module reload also works as k3-socinfo 
  stays bound during normal operation
- Link to v2: https://lore.kernel.org/all/20260401105404.1194717-1-a-kaur@ti.com/

Changes in v2
- Added DT bindings documentation for ti,soc-info property
- Reordered patches: bindings first, then driver changes, then DTS
- Link to v1: https://lore.kernel.org/all/20260330120105.2985200-1-a-kaur@ti.com/

Testing
- Verified correct probe ordering on AM625, AM62A7, AM62P5 platforms

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---

Akashdeep Kaur (1):
  cpufreq: ti: Add EPROBE_DEFER for K3 SoCs

 drivers/cpufreq/ti-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.34.1

