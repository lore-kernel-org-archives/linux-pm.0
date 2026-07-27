Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D43DCDAC;
	Mon, 27 Jul 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136938; cv=fail; b=fjHlZpATeGL+8XkCZCXh8u/2e55KObXx4mlxmFpsDgUYUgQfIG4xJB+q1N7021MAbFlBK17KT72txSPRSZlPJ5ngtCHA9FrsJbKq8sdQlJL4YFe5IZ9+uKBHcKpuks04JMSFDbjH/7fnE9f550pbNkSvqUQHEjiQgyIBrCBKe6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136938; c=relaxed/simple;
	bh=KX2hErS2Wr82si/uZeY5uFGOgremHf8ji8y7GayXIuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mznALkNVUhPAna8zzSRlOFTe/fxVTUvRv+ba8SMIy42TG+Evla+Gzko8pIvY4c0+V7ZSpnLjONq0xgYudcz7giTsWDVvKr/y0LyE3lrAs/C3jXAEDWYTnnGz43ffqkkJ2S942C49eMgretG0J1QyBtRxESdi9CFHjj28VEWXJQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHJ6IAt/; arc=fail smtp.client-ip=52.101.85.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHJ6IAt/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhZjtFXCe/CoPzecAQ38a7w2thKSUiYga4aUphtivu/+zoLVmqRsk6Z7bdlJgj4LUNyfcrqAilgqob0p+i/Wpbjws/grlIH1I2vAYC3wsFyUlmE+UCjH5JdiqPiOIdWOP+7OUZ+BQUHcCH7/m5orqnZJqrWhLnsTpWZVZOe6xLdpPJ6X3wK7NOIbhn81exAtGgQs+T3Qcwbmj0J31FNsuSkGFn46/fxGOxPcMTxZaxEW1/0avFjkMUj3Wxs5QqZiyripejKAfmuEoprn5kPF4aVEfpXsFFRDO8Opavb8TtxJSenAiegyJ1GynORsBEi0y85u7mKdp5kr9OrN/utW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqgTwao33NStrzFm96hIHUpuB5LJzbtT8JWP9fCdtqs=;
 b=W44DJSu02W2dpUigkbHACvUEQr5oFVe2OFRa/2FudRP2yU5kKyeRv1pysDJU8WvV5LE1atLwVzpTs+p4x3AEjkOfr7Z+wdMaMihopon6S64RsStwU1+h7B7lPUfAeesgWmRyfdGcYyK/RV9lzOYRoYlzxI6J6jyyRD1W146sS4jIUCfCF+lf4O2pfBIkQ8/C4ULEM6inbZ4DfuOLwZ+ekDEIoxpbzaGJaW2wDxKj+fTnHTIRp/uaqWnZ9v9I4D/ZqsUe3TDTqQKmjJw0XQzJfYAMbb8vuOq/cadS+lsHPykrcxKt60wHYlJ5AiVw0P96mXEgTRb20aqszEA7nd+zbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqgTwao33NStrzFm96hIHUpuB5LJzbtT8JWP9fCdtqs=;
 b=SHJ6IAt/Y4Q7ac2OIPG9T++cwCZgJ1tl82+nu6EaetzALdOfIumfc0CNu2ZJt3yO8EzuzLKuU9r36ZVDPpKbRaLmRj1ng100ithYWJCavamSmYjCqIYxNChtbSv1cyPX9ElAVyUsANlr0oDgbTHPAjsoZKvbVS8oBTdBUFOtSUU=
Received: from MN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:52d::24)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Mon, 27 Jul
 2026 07:22:12 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::4e) by MN0PR04CA0025.outlook.office365.com
 (2603:10b6:208:52d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:22:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:22:07 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 3/9] cpufreq/amd-pstate: Extract platform profile to EPP conversion into a helper
Date: Mon, 27 Jul 2026 07:20:50 +0000
Message-ID: <20260727072056.1248-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd4b62-5ee7-49d7-be72-08deebafc6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9+DoudDR85gSmnKwXE2b2g6Tgqodyu3Jx9YlNIVy6FeqHt3x2C5yOkmRFlEEd4uqtfXhgQNNlObn7zgzyli4lsEKRMwvsvLTdnr3kliCxURr0PEViP+y4mOvr174TCr8WspjP1q5Lh+puF+Uho2d72+fJMnMtp6GEGJQjnpV7PqZONFKORjNc3M9TkPlAqkknoHRERKE2+smvw8y+VHlm4BgL+oCrbcBo8cJg2vKMEefZoov0wmmMB4g0yIGZlUEqIol7xC1KEye7/CDi1DHFUjYzqD1qkvq8TBV7DUSZQZ2Z68i1AQUYHZByGG+nO6f6CFjuAcDLnj/LDssIX3Rfnnw+Xnz8YH4jwpBhzNOHaNdeeeqEDM/KAtxG6rFw4gYlWqYaP67/6EPyHkn49/7tMazmdCHlUkq4WmXWT09LfH0Va/4l28gbyeQj4+q/T9VRuD9Kf6X+k/tDcCM5NiW9cHtHM744c70jiN9Sc1V3Owr5xDLLLbaUBBdhkdSxTuET004IEFEGx0JVPdZJ5/nXq4AWStSoeTpwOVNdm7D7aLARWbHQR+QI1pS+NnpJzSQG4GGJ9GaL9unNewKJcSa+AdlesneVN/exb/N5IctjxHLikuGqxtjBDKZ0BrAe8VmRqHg3+ND/XY/UL+dS0FnYesFyuujSIfn3zF00xKCF1O1fMdy5Cv3T6HlDlXkbxIYrsTvE85UlUZocK1D1y6LVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jxeLPPRDQLcR95sVeOVf4s3tT5i8h5faZadlfgf3N+o8FIiK6+Jyc+tqpIbbqrwu118m5MdM1509e9cavTv04cOc30qOm7LVDc6rsZ5uG/Y63MYBKcgSHfBi+lSo+sFYN5ylmqpekCBIL3FUIWCcRopLgxu4WCJ/9+FJD9u1f/8Q5E3E1bZjPqNCP6bpGM1cU4QcA1HgGl11X+0EWT+uRjah70Ya0bWDYoXwQ/QViDLvWRrwxmbBi64gG/20f5TwlLf+/KemnMGJAm7gG84GeqtImcOIUvfJ0dfXNw64pRptXBY8j/IHLlb67AfFNa61FE0BfVfoT2ezMwEgA6W133z4ZrMdFQF5H7E2dNM0rulrWs0aQGVRI7pBqW/8cNJ0nuYSV/WjbcjtaqOIGUnIq47wLvfKBcburrc3GlyuMxEtOGXXgooMph+wUNTjwZBc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:22:11.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd4b62-5ee7-49d7-be72-08deebafc6b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

Avoid duplication by extracting the switch case that derives EPP based
on platform profile into the amd_pstate_get_epp_from_platform_profile()
helper.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o No changes.
---
 drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4c608dad1b0b..5b10a0a0e6b6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1189,6 +1189,24 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int amd_pstate_get_epp_from_platform_profile(struct cpufreq_policy *policy,
+						    enum platform_profile_option profile)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return AMD_CPPC_EPP_PERFORMANCE;
+	case PLATFORM_PROFILE_BALANCED:
+		return amd_pstate_get_balanced_epp(policy);
+	case PLATFORM_PROFILE_LOW_POWER:
+		return AMD_CPPC_EPP_POWERSAVE;
+	default:
+		break;
+	}
+
+	pr_err("Unknown Platform Profile %d\n", profile);
+	return -EOPNOTSUPP;
+}
+
 static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
 {
 	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
@@ -1214,31 +1232,19 @@ static int amd_pstate_profile_set(struct device *dev,
 	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	int ret;
+	u8 epp;
 
 	if (!policy)
 		return -ENODEV;
 
-	switch (profile) {
-	case PLATFORM_PROFILE_LOW_POWER:
-		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
-		if (ret)
-			return ret;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		ret = amd_pstate_set_epp(policy,
-					 amd_pstate_get_balanced_epp(policy));
-		if (ret)
-			return ret;
-		break;
-	case PLATFORM_PROFILE_PERFORMANCE:
-		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
-		if (ret)
-			return ret;
-		break;
-	default:
-		pr_err("Unknown Platform Profile %d\n", profile);
-		return -EOPNOTSUPP;
-	}
+	ret = amd_pstate_get_epp_from_platform_profile(policy, profile);
+	if (ret < 0)
+		return ret;
+
+	epp = (u8)ret;
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
 
 	cpudata->current_profile = profile;
 
@@ -1272,20 +1278,11 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 	int ret;
 	u8 epp;
 
-	switch (cpudata->current_profile) {
-	case PLATFORM_PROFILE_PERFORMANCE:
-		epp = AMD_CPPC_EPP_PERFORMANCE;
-		break;
-	case PLATFORM_PROFILE_LOW_POWER:
-		epp = AMD_CPPC_EPP_POWERSAVE;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		epp = amd_pstate_get_balanced_epp(policy);
-		break;
-	default:
-		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
-		return -EOPNOTSUPP;
-	}
+	ret = amd_pstate_get_epp_from_platform_profile(policy, cpudata->current_profile);
+	if (ret < 0)
+		return ret;
+
+	epp = (u8)ret;
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
-- 
2.34.1

