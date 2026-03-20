Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69153C3BEC;
	Fri, 20 Mar 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017873; cv=fail; b=iPy6zEk2n9+oA+OR8kaqt28Zco2FV2OVGhcohCIfbEJZ73pgzem8FE+kRf2XtrrI2WoPr8sSP03tOPQslsuCcQqrr0o+KK4lb2HTad4BP4+YEABfzd+lVDbTi7LBfEFSVE6Bje0KMCdW3Q7TBfsZUoR8uwUQ//UVAWRCKoJ4qYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017873; c=relaxed/simple;
	bh=pRO6Hef/W5q8wXO+XxzdA+8oGANSZIvjexg4kas9inM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFFnzYviuKJnYFgiI8bHcySzdwYyH53O0tVn/7vR4RUa9WNFWxCp+/Qb1nPepnSvhoVWOG/JPeGgKKlY24br3cFL8nt32+aVxu5eidLHNwyQfTlGcKhWyp9A+vohrv+g7G+5wstLc0TrM56cidsumpNtio38GY0rmDSKBoJSBJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yvuvk1ky; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yvuvk1ky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+zAT4PJs+6m3NBxA8dnovzFTUUwoN6J+p2DpuQQaOBdldYEeZptzS/Mke+ZiyuokH5rIitQ4DzE8rc/mU/LR37eVk+yaIdOccjH1cIIjytzTjWdm93F3vLCNcCRBPciebyQqYowBAENE9yXQoZ1+qt9+HT2tedBY2Zc8mQUwkV+99BedALaMIeAepU2P08/g+Qh6jh6AAFBMrJRc8IlfkpD413TqmN51Z3DnPcYKDx49ctSk0FKfCEq3cQ2mm26uHT5Khdpq/M0dI8O/4QxV4wvg0l9oF1/wQrrsNqshJFwzCPA6GqcDUEOcjTSX4QTWoF8+s4jjrnrLza0cfQCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQq/T0LPXQnNi6OrDFu4kYQ3IolW7ZrdtsnnH5h6rwA=;
 b=Uj2Kex1hBUHROXTTrgMZ8I33+64JQmWC7wo99q0P5pqlqkYG9fum7N90fxiRMXnM5cSrShPloLhX0A/sIk4obOYWaezwihgk+Qc609stUMhNYDEkefdfZLt2s5ahQGaEykAMXBqUWEXXAKo4qIu4YPum1GXKneLiuSIfGLu9w0z4VWp2SFR/0/+ruXjJImm2n7dhhXY48UdQixiWsijfjNkBjx4PeSKhH37Mpi/7WDmgEFdn/UO5tpK7PZkQG1Hh9uAnbr6G8ctsQJ9CqA0ifhK4cTgjifXDySAZiD3fkc0NTAjk1PXXGVoB99AZ3v9Z3U1M38gstmNYuctknkRB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQq/T0LPXQnNi6OrDFu4kYQ3IolW7ZrdtsnnH5h6rwA=;
 b=Yvuvk1kyBT7mE7ydf7yGzjTCwh0i7jEwPwpiJATRjAKwjBidETDCk6rurqjHtgIbLIE+BNXS5Gv0AzbZLeNMZCr+dLeUf99O/zYyszKznFLDnBhsuu1syAH5hUvQ+QeoXVvA7szUIPwOaIVX5FeNpP+hAg7kpoqRLGY/qYOzfuc=
Received: from BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::13)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 14:44:25 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a1) by BL1P222CA0008.outlook.office365.com
 (2603:10b6:208:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 14:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:24 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:21 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 11/12] Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file
Date: Fri, 20 Mar 2026 20:13:20 +0530
Message-ID: <20260320144321.18543-12-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b703a28-ced7-4fca-e501-08de868f2e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y9K501+Xo3h7yCVA0pnjg2tPhcBLn7jOf842exsnNizDyfaLZMz4TzZJ0aQ52UqtF6X6JY+jm0e3RkJzpPTfHdsShR70/WROavg6FpKKDiusNikfnOT0jRHu22F5j7mUDrSnkLJ6T3k4iBfyrveE6tkRXLxxNnLEs39VJr2OFr2OVqjwgiIPXMMGlg/Dp6Yq+E8DPzJbjsASjhgRWBi8QJWGvTNDkqZ6H14al9+kLZQkMgf9qiXkTnpfZ21jDSMG41fNxsPO52OT2KAq4Gip0dMmOqgGs9yX1Ger3MK5VrVSK4eYyW3/nYaxPWa+Hs7qixyeiRsKwosVBEmufCcHt48+Hh1lTNF72IXJEF27SAprqg6uIcsxztPFBoTG4IPd+JEG87mn2ouy4RlN7nSJX0+C3JNEGO1eNQUxnkrrYJtRc7bTxNQ/xEusO7SskAxYNWyd2NrDAVOUIUffAKJaVTFCXPPBZC5Ky7G3+U/zuIVh+jc5mDuCvmJAkNrvVxdoDdUzVKXCxfXCipgZj/+HKlTmzPenTQYq0cBFbRmMx9kHSgxwQ/4MwUzkG5M13xRr1X14JaZQQKd+SbrS/sF+zJH2Plk+HcCDZ/WZdwtusTK7nee1UJgk5kOkeifMAkLjsGSy2emxoEPUqBfml8x/k3040UK01lbZgFAiYHNm10BvwYzOXSzxKvXJ/YeolnlXZORCh3UvVlWHaw5LzueozRVQ67+um62Idq8XvX2Eu/azpy5QUaj4D/lwITrMHu0E6QQ6rgCJeZZTvsW3e3xQWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yz5vAJx8syMu8SlFNfwSe6yBc2R9ODNbFPSpfYQv3+UQKVQFJm+xqBGOCGII45TOY0URc/P2H+wr++k6DaZe7/MzEvVa8M5fYop6hmROwmhCjnm1t51NFK9iMvIWzquACUYedTXuXr71TEBHO6awhP4tXAlQYAlyUvXAAWPbOcAQEarOMcEB9Fo6ALePHfnRe0X+9OSGnTfxyMZrle556eUhV1jGHjzxQ8pdHZJQ6SpJdXOvgUUv946w2RUCgh+XVxdn/umEwi+PP35hz0EqLR3CYkh/r/YRehkEB0SwV5KKQ1ZarOOgR/D8pY6s+n1QIbAgxENMS5Q0f1k4mndT0BqBNgBh7ehomqllATeyfqd7EIumdu1RbdfU61HTEacB5k8JRKUg+u2r2U81iyFcBqv7BzSKhPO8/SJsO8Wa+bL36xccWasxQYkflnpxBdXY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:24.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b703a28-ced7-4fca-e501-08de868f2e2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

Add the missing amd_pstate_prefcore_ranking filenames in the sysfs
listing example leading to the descriptions of these
parameters. Clarify when will the file be visible.

Fixes: 15a2b764ea7c ("amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index b8c846cbf301..b31a478c28ba 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -242,6 +242,7 @@ control its functionality at the system level. They are located in the
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
 ``amd_pstate_highest_perf / amd_pstate_max_freq``
@@ -273,7 +274,8 @@ on platforms which support the preferred core feature.
 
 The performance ranking of the core. This number doesn't have any unit, but
 larger numbers are preferred at the time of reading. This can change at
-runtime based on platform conditions. This attribute is read-only.
+runtime based on platform conditions. This attribute is read-only. This file
+is only visible on platforms which support the preferred core feature.
 
 ``energy_performance_available_preferences``
 
-- 
2.34.1

