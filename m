Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972487;
	b=KSvH5GVrZuoyw+pKJ7I0nuI9HZhPXatzXj3ni3n8Zwn2Wvsvg/ceihMAtgn6tJ0lg9Eg
	 xo3YJO+neJB31lXaUPZvWo79NEkwqRAPAmzEE7NtJu5JcJUCHtuK4aMH0UMhVGcyMaF62
	 mfYMGhSIHB8FEoC9JIPU0Xaa0j5NKU+MttqUjybxsspj6oY/Judmr0LCe3OlAouwU7ooD
	 XRR2Ebq9z5B8ZUjKPMjT3c1OehY2DCOzRISlgwDirURGnX08LNqLCSsOHrh64MC6TWK3u
	 ESlqbnrKjqKu+L7O5lhH1fey1JbVucVld8O3DJNIqY5EPzSF+zbK00gwl3wHr8qzkZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972487;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v14/nKA1O2XvY0shBC3e9jEiGZ5xhnEj132i9E4HKqM=;
	b=DTI6Aaj3g9HRYbobmDyWq59sTFQbRIHr6OvkiyVpjC6bLdtQgUH3gQHlXGsHe204vS0h
	 b6jIYjMmSpTgWbT/Aj02KH0J1rI6Upny2jrjH8YzR7VJ/MrSMmDhxwgjQl0vx0jTFNxAE
	 5hf/365O0IfVQu0om/e/2/E9Ckp+TPwfi8kWTlRFbQmPCjEPfxw0zPSL6KiHgP8mKO/AF
	 B1z3aKEKaCex/3sgCkbxmA2JQOstjqvzau2wc7zndfLrVy5yA2VmSK2UuYpADXSHWHY+r
	 MNB1MUn8UOWarSEEjfxFAJiQyuxmDi5WHAhTpKY+X3q/ocPrEulQ87NsTpe1GzlBMBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=draesJid;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.23
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE1606A32C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12FE1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=draesJid
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCQ6u8d6FLGQ/TsN1SDIrGW12P5+dyax2u3xjEyjZdWsj1EcHBuWTkshwjlZpsdMyljX/HY/FLh6WxJ7RUEQJLb/Vk6Gd98u4kMgDfLXZNAjBgWO9zJaVTaOlKxBjXt/bgqnzk3oAHY+dxNFPWYviil/FfNsjWw+vsqeb9r7+uzraIDjgzZC51l+YO2i3m0ljGJBuef54knU3Nmrxv9lucHzyYFUJRjecEIGpo98v9daeFQjvhJ1dAkcKChdO6GslC0Va2J49FltKw8ilOWYzhUv5acd05zZu/Hsx8f9umnhWMylTxfbQyFXUnakIFJzo8Wqo1hUeEBipmsjYFGWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v14/nKA1O2XvY0shBC3e9jEiGZ5xhnEj132i9E4HKqM=;
 b=BBTlhVy1mTeC5FQ8wnhr6AXgu0QB9Q0rXLpwqoctnoxReNUzmN3esM4iZ+7bJeocAcCYx5gBvUZzqbFe/DyR2oRVOcuGe+rUD0P58d09XKHTQ/e9q8PNUKIBzar2zFKAB5sQC8lnjL3WMdOJvSwDI3JzIfLqqOEAzgHbVDw2sTX8+9eGW/v6TcvXR2ru73a2hF+eZ0VXG+UxqC+lF7bjbCrQyB4/ydK84o3r8pg+P5BH3i2lQyt+2X01wIeTa6AtUrYyiJ5IOiDHBQQ8NKfXQVlfkhBXUUeHSXHUNk+fNCXTXNRpkq4vktpKvYBnRc8uM3oqHa4MurvInE8fJ906sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v14/nKA1O2XvY0shBC3e9jEiGZ5xhnEj132i9E4HKqM=;
 b=draesJid5o0FDdk2hETKZQB9ug5hD8YR59OED3MkKVU8cj2ez+M47Bn+uM3Se173R3fQqS7m8+2PkrEVr9MBD8pyTpVeFYE7kpfcD4wVSqXw0Ype3a3C+qoM7igYP9BtWR5PrJ5bOup8wknjYOnlhdjA6Q99DlbZ+3YXiRYjA6A=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:28:01 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::6e) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 03:28:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:28:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:59 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 17 Nov 2026 21:27:53 -0600
Subject: [PATCH v2 7/7] cpufreq: amd-pstate: Preserve names for aliased EPP
 values
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-7-2a0048f563c7@amd.com>
References: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
In-Reply-To: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a4e239-9d27-4bf3-6c69-08df4523f2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|22082099003|18002099003|261009221227099003|261009223027099003|13003099007|56012099006|11063799006|5023799004|10067099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261102130727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	qdTpHchDScw2MdLE6ij3BUDd2oWWu1Zo2Mq0PoBn9fIGrfL/Tf/s6hp70g3ZJCSkcpvQX5/LmUHG7syeKdeogULnyKnMEr8dkcwunbUSyMLf0BlPGdce5hPTqVwZNwsZ1QwIf1I//98C5RFvAsble+dUWQCvDRzUUV4R6flBXzaFhXEHFicXANuWCIj0kIQSd453/kfM5KlXXomjVLluw1nyPw9m8JltL1k5DQwk3WbWzg+aBwh0aSboldbuNsRXgrPaGbFqOuJRslBRC3La68D7CRUXprH1PMTJ/6/eviQCZxm1LsrQOlgZPG1kBCn9kNXYs9TEY2qN1UxZMmSqDaEPTmaJcBjHgztGvYYumkuWqb/Yla6HWyLKDwc45boqoy5EkOhkrsA+aeuxFs/t8asdkMHIx5uQo5pRc8V3y6pQ6nFWkNFUQNneA5OaM3kXIiOb7OBVTj30xGb5ksgzc52bBD4F1d5n418Q7bMq4H0WB569U8+dCJy7XQjJEdHcLE7K0l1//I+psDcIO5pBglVeDQi8rrztYfs1wrzmVUfsIISY/ckuTLvnLaQ+9WQxbynW6N9arWt3HnFyIBhjtdgDDNUQe20PL19zBvHjkdfS+FRNGvcZ9oVm8xe6wV78TLRTskoBJCcNfj5eHbjMOPTQmgmdu53+00F8p2j9tT4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(13003099007)(56012099006)(11063799006)(5023799004)(10067099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102130727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b+Ev1HFIVXdT2hzo7V3bPtEycgG/p9qGAlBBdNoVYdqhfogaATbJat6dcNxmVhGOY/87Qw74NrA2iB5e6QYirsWMn/jSxWd9HFKMGwIV7ZaJf/wlH9lH22jZBrmYJAJC6iyoP8bt6dS8aHPS9ljBjKNOp9mnNZYnglWPAY1gcO3B1LXQNHHgZSoxSLB9HwJ7HbLU35wZCIeVnx80iqM3wEAWriSOQ8dN0UTOBUH1WMRW87X7+rk1eiuzibwExsH3I1GwyYTgcEN4Y47hGWAH3Vo7HcapscxMjaHfMRIdATbFudyJKS0OPCBCiErkANioPGGfErgo2E5Au70By0J1oNHq49LNWicwcXFzesOOEU6v9n+TXLNSeSiBzmpIRlDm5bseV6ayZAAAU17ofv0sYmMkGNv5rKHJybMaGW0m2PYitJlI1g1Kv6Z9SiwKZR22
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:28:00.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a4e239-9d27-4bf3-6c69-08df4523f2ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

Zen6 low-power cores use the same numeric EPP value for the
balance_performance, balance_power, and power preferences. The show
callback currently scans the numeric values and returns the first matching
name, so writing balance_power or power reads back as
balance_performance.

Instead of initializing epp_index to EPP_INDEX_MAX and checking a range
plus value equality in the show callback, initialize epp_index to the
correct index during CPU init. The store callback sets the index on all
successful paths via a common success: label. The show callback then
simply checks if epp_index != EPP_INDEX_MAX to derive the string.

This approach is cleaner and more direct: the index is set to the
correct value at boot time based on the ACPI power profile, and updated
whenever the user writes a named preference via sysfs. Raw EPP writes
leave epp_index at EPP_INDEX_MAX, falling back to the existing numeric
lookup.

Make the unit test require exact string round-tripping again.

Fixes: 52763c00945a ("cpufreq: amd-pstate: Update Zen6 client EPP tuning values")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20261012205559.3421297-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate-ut.c | 17 +----------------
 drivers/cpufreq/amd-pstate.c    | 23 +++++++++++++++++------
 drivers/cpufreq/amd-pstate.h    |  4 ++--
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index bc696f452749d..cbb09c78c94c2 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -414,26 +414,11 @@ static int amd_pstate_ut_epp(u32 index)
 		strreplace(buf, '\n', '\0');
 		/*
 		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
-		 * Trim at "(" and just compare tie the epp string.
+		 * Trim at "(" and just compare the EPP string.
 		 */
 		strreplace(buf, '(', '\0');
 
 		if (strcmp(buf, energy_perf_strings[epp_modes[i]])) {
-			u8 epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
-
-			/*
-			 * The preference read back may legitimately differ from the one
-			 * written: some platforms (e.g. Zen6) program the same raw EPP
-			 * value for more than one named preference, so show() reports the
-			 * first name that matches that value.
-			 *
-			 * If strings mismatch, confirm the CPU is programmed with the correct
-			 * EPP value for the mode. This verifies hardware programming while
-			 * tolerating such aliasing in driver.
-			 */
-			if (epp == amd_pstate_cpu_epp_values(cpudata->cpu_type)[epp_modes[i]])
-				continue;
-
 			pr_err("String EPP value mismatch: %s != %s\n",
 			       buf, energy_perf_strings[epp_modes[i]]);
 			ret = -EINVAL;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0acb545a5f4fa..c49414f8ca962 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -118,7 +118,7 @@ static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
  * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
  * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
  */
-u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
+static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 {
 	switch (cpu_type) {
 	case TOPO_CPU_TYPE_PERFORMANCE:
@@ -129,7 +129,6 @@ u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 		return epp_values[TOPO_CPU_TYPE_ANY];
 	}
 }
-EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_cpu_epp_values);
 
 /**
  * struct amd_pstate_epp_values - EPP values for the four named preferences
@@ -1479,6 +1478,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
+	u8 epp_index = EPP_INDEX_MAX;
 	ssize_t ret;
 	bool raw_epp = false;
 	u8 epp;
@@ -1502,20 +1502,22 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 			 * Nothing to do.
 			 */
 			if (cpudata->dynamic_epp)
-				return count;
+				goto success;
 
 			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 			ret = amd_pstate_set_dynamic_epp(policy);
 			if (ret)
 				return ret;
 
-			return count;
+			goto success;
 		}
 
-		if (ret)
+		if (ret) {
 			epp = values[ret];
-		else
+			epp_index = ret;
+		} else {
 			epp = cpudata->epp_default_dc;
+		}
 	}
 
 	if (epp > 0 && epp != values[EPP_INDEX_PERFORMANCE] &&
@@ -1536,6 +1538,8 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		return ret;
 
 	cpudata->raw_epp = raw_epp;
+success:
+	cpudata->epp_index = epp_index;
 
 	return count;
 }
@@ -1553,6 +1557,11 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
+	/* Several named preferences may share the same numeric EPP value. */
+	if (cpudata->epp_index != EPP_INDEX_MAX)
+		return sysfs_emit(buf, "%s\n",
+				  energy_perf_strings[cpudata->epp_index]);
+
 	/*
 	 * Map the cached EPP value back to a named preference. Skip the
 	 * "default" slot (index 0) so an EPP of 0 reports as "performance".
@@ -2034,6 +2043,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
+		cpudata->epp_index = EPP_INDEX_PERFORMANCE;
 	} else {
 		u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu_type);
 
@@ -2041,6 +2051,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->epp_default_ac = values[EPP_INDEX_PERFORMANCE];
 		cpudata->epp_default_dc = values[EPP_INDEX_BALANCE_PERFORMANCE];
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
+		cpudata->epp_index = EPP_INDEX_BALANCE_PERFORMANCE;
 	}
 
 	ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 422188c639b1e..e42ea811d581e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -101,6 +101,7 @@ struct amd_aperf_mperf {
  * @dynamic_epp: Whether dynamic EPP is enabled
  * @raw_epp: Whether the last EPP write was a raw numeric value rather than a
  *	     named preference
+ * @epp_index: Index of the last static named EPP preference
  * @power_nb: Notifier block for power events
  * @current_profile: Currently selected platform profile option
  * @ppdev: Device registered with the platform profile handler
@@ -142,6 +143,7 @@ struct amd_cpudata {
 	u8	epp_default_dc;
 	bool	dynamic_epp;
 	bool	raw_epp;
+	u8	epp_index;
 	struct notifier_block power_nb;
 
 	/* platform profile */
@@ -204,8 +206,6 @@ static const char * const energy_perf_strings[] = {
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
-u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type);
-
 static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
 	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);

-- 
2.43.0

