Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDE3D9049;
	Tue, 30 Jun 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845989; cv=fail; b=OuTYSqnB4mVABKvRhKL4h11mRgn8tptlzwCuPZWJNqQ6YJs2Z5mWApxzStdmPk+yuSgfVOh1W0Uii43h42Ppl648jWOZ03Y7ftndqJaWOObT19jb5ont/YLoE//3gsjWHJU1h/dyXVL56O0VWzRyFf6/YKs9/H0E5JcKuOa6pV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845989; c=relaxed/simple;
	bh=7H49Wzp9uD6SDIup8EAPAKQqXGljEKLqL/gHkuEr4HY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRnelxb0zeReSR/h7JjZIzjvTIwETW3hzO5q97ccC2UShP1RD5C80ZBCt0iq43hO7F3XNy8JywO5/pIrMONMzN1yHacBgCRM2ph4NpussnjKSh47dXqtgVyTLqHgOO6IiXm6smUCalcD7s87zxyWiYGkIEEkQNs+G4hOagTHfDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gAW3mU6q; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gAW3mU6q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7LxU7jitk0/7r7orI8iyX+VObMqZDz2B4P9eGHmFQ9Haw7ymoJuSvZY668ryhrY8BQ19tHPNQbDlKD4jp+8UOwTQ+T0H2QJUEDgGK4kB0qj0Ej2//lbmQU1OkSGOvGwZR1ysHogC8b0PyTBrVGPWQJO7gUp8/UotkGBQMZDQQnQQS4sZP5CwUoKSZcoyp9K6Ya/E5V2qDA5j3xYr/09MsqOH6FsedrKOuI69oJr4eY7nvLKbqRBr7kOK/13eCvh6tNddQlVm3I4yVM9rHS5ZLJJO2gJgoqkUjq+PuQoH6AqwV/dpcXvrh07y3xHNyjMSWCJJ8Dzp/o6pU0g+CgI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOfINFqtdP0jVwhtg3jmenfTcf9cganheeEWSMy8X7I=;
 b=CeCWc57uuV4WROkUi/ttn8tRGXjSS97r+ywLMR3znynjCy+e89R2+A1dVhr3oY3PDGvQtv6g3JcQMTjS2noOGal1vMC97J4EF1oVMSznmqbwcX/1K9As2/X2b9c6krRuCwwEnyWirvhExh3QWYABL5ypvvlSqRx/gD8hofeXc4FN/spIFc3yLzKHyjOCn4IgmktZjz/FQ8Z+CbtLWnPqy9fUjKArCAJvD6ervfXhDgbPnGanRh7IO3rITaolVUjZxMUtP1tt2fBXbfM0ApWXaheoqU06Qc8nTAF90ne9wgB+n2LdlAAdaueLR2Un6QgnHzh/GyWKbQ6iy/XkElRW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOfINFqtdP0jVwhtg3jmenfTcf9cganheeEWSMy8X7I=;
 b=gAW3mU6qDKHVxMRLpM8ZrU6kU47dbRoZduOl1Tx8rqB5t4+1OrXmj3kwnN+yWKxqdEvYfZS7lr8cvwQ44r4tjoN5zMlnVhDpz/PM0T8zW5cbFtoo+SD3ijGJEKzWlOJTd5wlqXR3UOo0uMGRydIBlZGIzNT+6VqWTx4qv5PDEs0=
Received: from CH2PR15CA0014.namprd15.prod.outlook.com (2603:10b6:610:51::24)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 18:59:41 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::3c) by CH2PR15CA0014.outlook.office365.com
 (2603:10b6:610:51::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 18:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Tue, 30 Jun 2026 18:59:40 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:59:38 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/6] cpufreq/amd-pstate: Extract platform profile to EPP conversion into a helper
Date: Tue, 30 Jun 2026 18:58:59 +0000
Message-ID: <20260630185904.5602-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630185904.5602-1-kprateek.nayak@amd.com>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3f2cf9-c615-4eff-0491-08ded6d9bd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	p7Q34H7MQVl/Vu1uSpWJeTPvlncRcfziFDkLKoraxHgoN+mkM74iR/6c9Y1sKOugHQIUfFJSmqwcmfej+qQnirh6m4I4D552gFvQBGTEmv0+xU18t/3MpyPgFgidN4TjnGBTtSlRpWQd7MdNx39wWoT+DXLa9RGown06ZN7ZjoR5PrS4GcrWJ0/cdztxqi2DYGemAZv2K4Uoka49OIaYvsMOBr3r1rhg+RUo+JxZprtQtf+qrcUGB1R9/NaAiT/mPlnls5LsOdEHDPWKz2cDrIwN+1qD9UJIQZ9NXpCmkwE+EbABvklwrEXPLojBxV1DyWV1wUSqHgUoWLhlV0KvRC1ntjPYsc7hvVfJt/ku9x7lI9GBEMoirD5dVefuPZoAWNFZEAo/N3dffVuwtTHt3W4gXjFBYVOSl1vH4vao4vSxGhbcd7wMoZ76mf4nm4m+LawTi/NwN5y2hgAWTn/wSaTh4ueD+HvCijS9Wl225Alp2zJTU0dg8TYfoLFh8JkConMoGhm+MTjHs0Y/d1Avs2ValIAB0cMvByIFRSUHeoXKxLWzmlOouQauNbU5eJellqVsnLCAQkNkafCcFXP+aoY1L8U6fQuymSUvKQg9m1Jk+UMn02iKxwPMoCqncOtXuGgTGW3avDihP5XHp8JuBcd0lNfhv55jAfOHBTuHZfjAZYXjyK8eI7pNcMhqVM+vXzymrpMBl6dCw4hutbWV+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ElmaYoJK8w+IQY8fdPNYULOSKEISidjJ4CH9eIAef/dhDgIYWheQUtr6GIUsNZCgY1wRCPGERQXc8dncWLoW6xtcQcqupZWvFfGZQ1Puy8QV1VewS9aAFvPMZ4r64i8LZ71kz+vdNy2lPO8vAKZ/EiNpcpWNgsFbjD1YuLt+hqHHt0phviOFjIcPzjaKKKi6CCt79wdrQRAIwHSJxzNicehqpK5bnTso4vhXi2VDYVHOHFqiv7T+NzXp3X8xHSAMymU1zn9CbnFOwEEq44URXgRnVE5xCgYR5pDXeh84mo1GxD0IckIiRUb6Fmpdh4Ys2q7FGNcdc8pISsQuHN+R1FdXIiYJkrrMjKtf66KOObc5mdyEDS06QM+8qadmnAYeUXrGEwJDELo6j+Jj0Kgf1w/8IXGgHK3tpYTQTfY2vAqhOamwnbTXrh9pPp8B6BTA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:59:40.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3f2cf9-c615-4eff-0491-08ded6d9bd9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

Avoid duplication by extracting the switch case that derives EPP based
on platform profile into the amd_pstate_get_epp_from_platform_profile()
helper.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 20c30d14100f..1893b0054a6a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1179,6 +1179,24 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
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
@@ -1204,28 +1222,16 @@ static int amd_pstate_profile_set(struct device *dev,
 	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	int ret;
+	u8 epp;
 
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
 
@@ -1259,20 +1265,11 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
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

