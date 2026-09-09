Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EE353A9D;
	Wed,  9 Sep 2026 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925015; cv=fail; b=HjRhEjLtC1pzTbm5WZV5BYra6/I7yxCGSqyq9yqibjpPd75IDxSt0NJp2r5vWooDv/HreS8YwIF+pDznG1Krund94ScobBWdEWn0/uMMLPwcmmj8s9c14o8R1YD1kOAFTbgZX1aWHfSMMQ34/tbBjldwEqZKd5PiobtZByzKtFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925015; c=relaxed/simple;
	bh=0Jq3I2vpviIAmOEhdfeY2WStORDHauPfur4qeP638tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBcnjsJe52whYbkJBzcAFQE2eXUpYmxRTCLgqwRhrmSeljslWQbPf4eYFznXuZQTlDuvt+3fvyU2kya8qIYHoEiBl7JPx2uwMx41jQcblg6e/JF9+G8dtPZBjJ5R648XoiFhK2mBv6nRuOd+pYdJzEVcsx83xeg6ZPpHsVn0374=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQ/3RQns; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQ/3RQns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja+whklJyHmrkCm3EwHGbV2/3bXNv/as/l/KRSzM9UlAkibobyH+AOWS33OFJO/B5nfiQSWLOQK0boMTZXuPATMA4qGyv8rMEMw57z0u2rLklZAEX3cd7nKb7T9nA5ZIOI2WW+9qkOUD741mu2GVQptlGgmuFYC3M8DJQ/VjjgDMhy2tj3E1NPfmhwZfgtO2MAb6lgAviS+xY2RBCgry0BRyAZttQ3r8A2VuZUjncBdkpfqUkNRuF6/KFrXLHIW/zzLYbAdpDiNkEJQk9KW3BObRn5YGNVMypH/EwMa2rjvOSrTj38CRFYykW9jhZ5TZ6N9irkzf8FsKBDhaUM/DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZA9cRxGOmLoMpF0tyT+P23+BRs6dwIXb1O1/Tn4hJ8=;
 b=uYvzsKBvMB9YdTSvYDgXggWarposVlFsGpj9JPgJucYxeeBaK6mBaFif7qK8ADYFIy7d+fY/ApPcAqq6WV8LHtZQmB43twUylnV5Qs1N9iZ3eHn3h3x4ywhDZpOrLAS9gsUjFLv0HwR185+Vg1GY55FIX+InKpNYlDDFzjtEpjY69QDQhyvGWvptI6DEpF/3A3FcMrgN6NmnLZYaJWEXeWvSe6PaiLA4uxITYu8LdyfoxwCEaqOR2SwDJBFhvxl74BELGQ46BbtAdydb8szK5KsYT4vMzdOY0WqwpHo/4RxULsSdrS11QQcZTisUy3ecVeDAisZalOWVQZ9THnjQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZA9cRxGOmLoMpF0tyT+P23+BRs6dwIXb1O1/Tn4hJ8=;
 b=QQ/3RQnsFPnnkeYy4JFVD/KzOntMqs+EUCwRpsjdtXVA3nKyHSrmfaDtCcFttGQ81NqzD7gpEjAKuOC1x8I0HAUCR0OYAz3L6v6I0+9Uj8YohndjMQqKPbIFl1RrqxRwiZvW+GB77N7XWIWIgTbNPR9DV1PwLE2yxH4daUa7kjE=
Received: from PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::16)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 03:36:48 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::a7) by PH8P223CA0026.outlook.office365.com
 (2603:10b6:510:2db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 03:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 03:36:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 22:36:44 -0500
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 22:36:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>
Subject: [PATCH v3 2/3] cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms
Date: Tue, 8 Sep 2026 22:36:22 -0500
Message-ID: <20260909033623.454449-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909033623.454449-1-mario.limonciello@amd.com>
References: <20260909033623.454449-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 6041ca3c-0673-4aaa-0066-08df0e2393c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IYkUOhPIUjfMciykxCnT4c5fW+3jbMhk8MkwY/aAZJ9P94FrlEYBrRmcHJr4fiNCYWwmo1LsnfPQp9gTV2eO9MO08ItlLTa6eXrZQg1XI4SQ1pQ0SC5sD9mWf+ENkIv6KR5X0fbfKrwu+UaR82bP7a7N6CJmVhFeEc7DjX7A/JVEL4lnYK7YWw3CEa2KvZFdgV3hD0I8e3WsKJfCVLh2xzJCzV+ertTTLSOSrbFI0X4rw0UzTytoKP4u4IomzHY3N1NR4rfWH/wZ4Akbus3azzOqaNwIv6QUJHFsMq73lIcmeCZPCT8KoIcv9gJE1clfr82FS6anoagXsNFl6c+Okdb2PTX/K9aegU6kvCGXfCXoNyqSkeP4/tJDqMp9GPk4IiA0U8vYS6lkHtHWy4USa9M8DUenOf0KNzHmuNGz4cZrr/lQmEhq/PwtnPbN3DMsLT9ZjUDQsRY/LSosK8Xkq5tXjyfHrzysfAEvELpetBJKxvvApRJcmDTNqy8rSoWby4f2iCa5WpSlVheUhHstkLo0zk9LdGj6h5puEFlyfo1UYyfS211iQbg91DZIvF2NiTW1ypBkcR2cvMK3PVcTPQPN4PPfx57O59A4LLBaao83rhSAdVERTywyeMvYwCPy/pVSVYbBxIYfv7e6jpWqJOWlFSuSy9uLTsET57v95ouyxRLV070OmQjV5vb+jdC7REhjapyI6woU6pjvmXntBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kQEv0Iv/Iq1/4cGktk1ht32eO4fWwy83h2zGgic0evoBS8aWnY5FAseLy6cOJ+NjiX0uIdQuYUULAq67B3Q6EAEh4RRSq+8Ty7enMFMF8s/7Q0dr1fqKsHQCochVodXtgoM3H+thoZTRUObjC8zF59n01vxJNh7mnQ2k9ikfhU0TiLKDegBdiSbrbqn0KjmQbnMTDGVDtwN4L3lMbQig1HL8EqgK8hHnfQmeD3oe2E5QOqKgI7agoEys3Gcq9gyyqcfrtDDFO5wfSCrnXf1nHHvcqz9GOd/gl/csWZ+2Pxq3tq70eBY7eiU52ybC9qEwvr4qElY9UMZ+OjSMs9Y2NkrFIUxMopS1bnJjfUxfTZ+nfCWgfHs74xGz8byGtgAI1wN9K0/l48k8BX3nIaPrP6VGyAn0bzkmxH2+A+oE8CP2dr3cl5vW1dQgoi1H3nzW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:36:47.5355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6041ca3c-0673-4aaa-0066-08df0e2393c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

Zen6 client platforms perform better with individual tunings for
different core types.  Add initial EPP tuning values for those
platforms.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 60a8b8f220437..380294bb56cd7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -206,7 +206,33 @@ struct amd_pstate_epp_soc {
  * Per-CPU-type EPP overrides for hybrid systems. Only hybrid SoCs should be
  * listed here; non-hybrid systems always use the legacy defaults.
  */
+static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
+	.performance_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 64,
+	},
+	.efficiency_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 115,
+	},
+	.low_power_core = {
+		.performance		= 25,
+		.balance_performance	= 51,
+		.balance_power		= 64,
+		.power			= 115,
+	},
+};
+
 static const struct x86_cpu_id amd_pstate_epp_soc_ids[] __initconst = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x80, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x81, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x84, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0x85, &epp_soc_zen6_client),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x1A, 0xe0, &epp_soc_zen6_client),
 	{}
 };
 
-- 
2.43.0

