Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9F3D5643;
	Thu,  2 Apr 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125604; cv=fail; b=coaUWOp99X4fNpMJtl52+fKzQLp++Oxr5/Bz7U962TgH5U36Ql0hW95CONRN6dyWXsHSl3PT/mbNKpUT/DCsnZdhrG9sos2pQRDZnHGnokHx0bBj3/QftROI9ipbJ/a/pQ6ZW1CKrRwMh82/RbylrmEwDK3tNJk+TjGnvAtWLFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125604; c=relaxed/simple;
	bh=JVuRcmok2Zq6Ge0lwNpjJKaYJjb7SEh5cyadkYn1zWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVuLi4NF+zhdjTTlsohvZJ746VOMQg9dAeE0TXTBl6eXsoRnQDfDRsTN3NNnL2tHg0SaS2pvHcGyA1q9QENfE7RQ8Zzk1GZnmqXt9bmd7i3KqSjS4s+Wk4I0Xi6Cl0NgI3/Py2MtxTrdYpBuRwQyZpxgKuJcFoW7Wco7elUCln4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yyprwjrX; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yyprwjrX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0s+2pjf2A/QGYsjCSzuz8Ed2hcHCIM6Ue1f9p7U2PRhmPY6t1Iq8JiF/kNKGGv/MBB1D1SapElMIGSTUJ2W1kVCCzP8HnVDc/doZ0Y6te7uU2dlO2Pbn2wkACEzs5IUFUoyB91lh62LCYq/Lv1emGrvEgY8K9SocJGaULISGwFjcL6BjywZfEn2vDcf9MRHG0WllbsNheu+UiWAN6XSo9jWzTTyBCNqN1IcT3XTIJS10n1XsPDUHlGRyue8t0PpkQYJVgxp+xjYylmpV3FBZQ93mejjRSuMJAPJvrXDQZXURj8mMdDbNYXFRCSIb8SwOIhCpTDcYp7JzZ33Defylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJlcJpbLDRl0ldtisllMblr/U4PVQmE5M3H7QTdarkQ=;
 b=LDmSXIyDQRJ5mOXKYA0SPfuSXq1JZPM1HpA3Tn3FpEzfPAwPbJATByFvWDdUo6joEDeQfYVU44BGRqKB8ITFI/0ek/NnJlO7LWSGDsOgl3OOy5DvqC/xsTJ2hFesDJEboRXsN631OL8C916tOBzg5psFRU92PplU2MzURpSNmSSAxEfSQRrPDFbFm4XYVLUffw8dNyJYtfJ2MTESkKV/f5DV5aT313whQOdrnIuDt/62/ecK7/2qBmhkIsMy3A9kLzqcVfk7433q16GeyhOTnx/qJJrdAPpJR/wjj/YJ8LfJOnYJLQaW98mOUtyKmmr/31Y3/uoknNFg6Wnvdlr5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJlcJpbLDRl0ldtisllMblr/U4PVQmE5M3H7QTdarkQ=;
 b=yyprwjrXau1QOULvArOMWPxBHiw19nhW9fObRzjIQFOUsrk0+urUQlADW+a+brL/H+/ON4urTXnbEoOqdDtqbfhUavckz5Po4+OuO/ZD5HB48uUJIfagof5YVBDK7U+HzZkEkyuCCJVRi+UKCaVHf5Op2NppFvW7vax2G8KEcjY=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:26:39 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::f5) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 10:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 10:26:39 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 05:26:34 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ray.huang@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gautham.shenoy@gmail.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] MAINTAINERS: amd-pstate: Step down as maintainer, add Prateek as reviewer
Date: Thu, 2 Apr 2026 15:56:11 +0530
Message-ID: <20260402102611.16519-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: b734179d-b9e2-4d51-a362-08de90a2538e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XbKLGHhL+OcgPLNmlmKyFVPTAjGfvQTnYCMYXbsR4fNX8CjkllM6TWpDVzbx4fn8itdldTwFRoUUxYETcsXwaR7ax3vIr/wMX6ygbNkgb1ZoGgepEpCJJcOlxn9rCb9N1jxASYG+yJg/5Xix+J3WT5fXeCmZdaAEn6a/yUSBTy0EvwcKdbjSa2Li8m8PAPZACAoIVd0F4jyxDDXRx12B5rqynCkkjYAjZ1RURCVRMnLXQal7BoyMzIQ+xJZNWLYDGcFjxktGz+7uhITK0GlWeskUhOYLhOcV7qcxW1EpDzQIMpCeBkcPF/stND6flzzMIUFPCeAqiNlG8e7/xdEEWGNL54jSCXHAsX9BN3TFm0CmVExj+U2ND7d0f8KIxphwKxKCMVF7+NMOSOrPosC4yq2ckAlJzBQbsvVSFmgaXAXx4kCE0JHqbt3/+pISgT4WOjLHZDm48PZGY1TKqZnUKa87YBB0NI8HZpfVeTpmwaekWHRYClJe5fCnSn4DrTJ0uwII2hkP+06rUHH+62aHSAVtmbDwvf3PVRxMfArr1u2x7ROLIdboEpq/rEQHfmKVTipHtP14jkNUpBeAqAHhGK6YSry86n+rpHWaD84AGPxKPXSXpMuR3IbF0/rrH5tB0NiN6um1sGymLcwwdYNLHTlqYuMPl+bQF5Nh/WxQ/nBEyoj+AWGKgpg4c78GnyqcGnm2lrjXc77muudi1PrK36SNmhdPUbfYCtGfMMkLk2aSXuNUt6x6chY7fK57POAP/zyUb84QBOYTSau6ILwRaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wQHsOrnTREEZ3dBWcX+qTtaKkYhFmtqcIe+61zSxcizfgp5nkbIal81zxL9RPKEPtgpchCMYk9+0ZugDjQTr7KAQ4gyarO1P22/J1UgQ4YhnN18HSSVf0phGaOQkUVCOmnK/p6YO6zXOST0EHtSTQ4ZniOr5+of5tDck/au6FCtWv6Sz33qDA97Q04BpIUJWZiVRF4+imX7jv1pJiXipdxNq17ltFVgUQlnQlGmxNmNrAosSHDD1NawIB7o9xYes7RWDKRVfDY8bQ569JaXwQwK1af47HB068dL9z9FSnetu8qaoQ2CqV9gHMqIQsTELMwPwBFb7m+XrXaIxeFo+NzJGqpxoEjMqA9HvV3Rlc8PHBbuYFK1K30v2hpFs/S/2LN/FOfwxWfrMMLqbijwLCzWZpJpsTMcrd5ZV0eijQIoWQhiAlO2Duh+MH23gZrkN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:26:39.3433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b734179d-b9e2-4d51-a362-08de90a2538e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

Mario Limonciello has led amd-pstate maintenance in recent years and
has done excellent work. The amd-pstate driver is in good hands with
him. I am stepping down as co-maintainer as I move on to other things.

Add K Prateek Nayak as a reviewer. He has been actively contributing
to the driver including preferred-core and ITMT improvements, and has
been helping review amd-pstate patches for a while now.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..a85a0b45f023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,9 +1234,9 @@ F:	drivers/gpu/drm/amd/pm/
 
 AMD PSTATE DRIVER
 M:	Huang Rui <ray.huang@amd.com>
-M:	Gautham R. Shenoy <gautham.shenoy@amd.com>
 M:	Mario Limonciello <mario.limonciello@amd.com>
 R:	Perry Yuan <perry.yuan@amd.com>
+R:	K Prateek Nayak <kprateek.nayak@amd.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
-- 
2.34.1

