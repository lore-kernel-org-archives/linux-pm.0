Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AA33C195;
	Fri,  8 May 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217541; cv=fail; b=LDLGMTEaFkWcBQoqJaQaOdAAVQtI/5UaVFoUEtMX+jIgjZ4nCdcMf0ulETyjbuD+USaFz2CIjjfvrX84zxOHMdQ1aZuayHjhc8OxrLqqyo0CGYmoNFa9hY7TXllfigh2JIPDlnbHfbtYIqii467s2www/v8/zFV/B75NO9AhNqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217541; c=relaxed/simple;
	bh=4zqdQXHMWijf5u+2l2HJs0Hs5p+Cn2ZUwql1mhZbHRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3z3jWQ+81eKw7uzz9wZrXyQiAYXgCNQm+UACoLUJ3LxzGa/JPVzpyRKkw4KPNabC8cuFFUbooqGdWvnqXxrqGNu+hZmqd9r02VnPujUh2kJwMRN4XqFPj3HpjK+v9cIKA3NBr8hxRvpdrf6QXt362wVUUbqAbQKS2PHG4ZGTlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fkJbvYwu; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fkJbvYwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ann/bGnrkhrmgI4/A0JORnLHHxeLRN/KHhzC/9hmlAbH9WZLdKW2nwjuox+E7Wp7XpUICwb8mJBtxOrcCuorMv/daaTAVSLbQjutgsRRyWbxzs5i1ietmv3TWTn7DLmU6UlpQxFB9twP7Ho2gCeLq2yUzzKk6gLZ6j76YKAM3qM0OAoahdcGGPqgq47BwT5WfmW/+mlTlBI7naU9EntelGb0gjSvyV+ux9stN3A4bW5HOWmnSxKOQ0mOjgLVuz7i7Yqd+DnhHf+1WxSUuWlFOJYLz/uRtFtZI5JXE3aoyu65GmfepCrA46f5qHiqcUKwDM77V50vDiYOvnJ35mkHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqpYsqAS6dPcuJ9s11SwEkE8/O5Gs/3V1Wc8SIFwEGI=;
 b=xdqYvH6i5RRZ9KSwBo5DDyVrH36A3d07lJHXrabZz0MR1yNNz0dMRezCXmdSpLGI1nYSzBCOwd6vGc0g+TosXG3/ZFu2P9kyE6XzMERrNEQE3JVmkf/+KHuNwDXyjhsOpbS1r0X8mvFu6ht3MmMd49DDW+DvSVJb/OS+eRiN3hpiZW5k3h4+vNHZer7DGCD5K7qCU4QKl2swUWTwVh+1tdHgTeccDPKunrLvBGW4dVgmImk5hpCSPp1aj/CGsQMXIHgZQhssIDXWDw9AhSMysXlZXBGdkE0nWvVE6LYino9nr0zO5EKOgGXaKgm4VNzCFLHjytzFSnlTwiyZK0Rj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqpYsqAS6dPcuJ9s11SwEkE8/O5Gs/3V1Wc8SIFwEGI=;
 b=fkJbvYwuniaDGLEV8VuWOSYfq+ICdF6NuiFI4DeU6mrsp2YIqRJXId+0yMPC9PGWAwejgPEl0KI3iA2yJ/zhJn3APwFZEI+K87aCgM/4LBB8MTTGIkEUSf/TkdF+ngTOV0K1XNFCDXIfYzFhwhLDNYAhvpudYO5QVhk/P1WsrYU=
Received: from CYZPR20CA0020.namprd20.prod.outlook.com (2603:10b6:930:a2::25)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 05:18:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:930:a2:cafe::97) by CYZPR20CA0020.outlook.office365.com
 (2603:10b6:930:a2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 05:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:18:55 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:18:52 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 3/6] cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't modified
Date: Fri, 8 May 2026 05:17:45 +0000
Message-ID: <20260508051748.10484-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: d05ffd4b-0b28-4264-87b8-08deacc14d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QnEwygY590gLeXLjRPvMJSJ9nwx/hVwpQcPPXReRHyd/aNoD2JQnvYYYpbD+EsYtgv/I793FZtraoevdIdFsgbyTfGrxvxHeb9FIq4SJw3YxOPWjvqCL8cNw34YfqO7VwF9dAYupHbMO+Wt17IjtZwOXldzypDROFDHKPQNAcUPs7xn6utD05mO4rigAsxqhbTGbziLV7Sp3stSQ2ZLWa5cIJF1M4N0H41HEtrySBBAdxSrtXzFz5Rhas7/HVrE/vr9wz/SNs/dA+N/2aovNxy2/UBH+ZATaA0e1g8qrxe8bHyDywFhAp4/DiVFkNFga4rMoSR90hIhNUfkEqvBCdPAfirDDPLWGMLiD57kzVCVi/0dYirZgioeyPPnMXetPTE73Aaal4/1dtrkZpFSn+bX//lhxzDffQXYm6Vlf7eZ7/NvYxvngjKaEESr7iFsZ1oABpEuvfg0gcft7oT+xHb5fore0OqKb7/AEXat3aLYGfTDFBUtUZvtfYgeTLt/QGl2eZHMJBmgGpVzTWiCVJsULRhrOTSTWuUcugfSRcLsfyouXHZot1XzZXA2nvJnH6/O/tfJP04v9xMJWH+nInaARsyPjgFjlfVitR7dJZG41+TaAq694qwOj3l/jQjF4Z/dJEP0ZIgGSpiQ7/p6CIl5hFXIjqlyLEea7GcjrVlZrd547+cek2yTxMrYwLVd28xBgQLCh/kLVfw6QZXhJ7kjVI2wCLkBMRbgu+gK3tMI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t0dljC6UZXG8kroon9U/PkKOJa360xZNYeiQW7QtPE+xwvxSstKDLhYmW+NcEuohL/KWvhAWsgj5htjamN18n5TZqnez++UKhnQwjQnpk5mf3wlrkuPZ3J/XYX5MQeASGwMFueVVboNRtDihdjEqi8JKTAtb/NluYRqEZF4rqgapK5J3kbuWZ1+t7BFy0MRoZNe5jyO+ajAISOs9G48vO2s2zD/LuKabYTQc77CCYBhgg6TK9xxERyIDqRgMyERefnpNwSqbBPV4jUJtXpqhQVfwyoJtbcGAI0x0tSk/Y7I5JehpDBUW1Ys6HgsGhNe6bQJcrXu0VpHbDqNRWboXGdmmvsjGjp0jkJeZs/jZiZ+l/bvwqkklFHn557cMgqAt/su+lwDtgS+JFmhZrYhkPQaTvfzzobmmRcutP35L5EtlWCoQ2/F2FSC3MGjZwr5j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:18:55.4779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05ffd4b-0b28-4264-87b8-08deacc14d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

Writing the current "dynamic_epp" state to sysfs fails with -EINVAL even
though the desired result was achieved. Allow writes to "dynamic_epp"
that does not modify the state.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 72514be2f30fb..462ddad7bc79e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1832,8 +1832,9 @@ static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
 		return -EINVAL;
 	}
 
+	/* Nothing to do */
 	if (dynamic_epp == enabled)
-		return -EINVAL;
+		return count;
 
 	/* reinitialize with desired dynamic EPP value */
 	dynamic_epp = enabled;
-- 
2.34.1

