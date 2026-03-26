Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADB3F6612;
	Thu, 26 Mar 2026 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525736; cv=fail; b=l2fW/7K1sSemZHwmrXEQaw0qotaqDkS+eYlkbpPQzNLylxwfwclTzHjkJJJdIqVfZYTF4A54TZYoMcbP9qSCImqFoQ/etoDjPpDbWuLFNXmJxxMs4lWuj6VrJNFivvrUHJ8q+INy2mtIMM6M6l3ELatpfByZO1Ijvjs0ZmCCGs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525736; c=relaxed/simple;
	bh=vVAEfF7m4URGP9NW9MOWTbtBBtzEGgFq7fyPvE49y9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAG5ge+691ODvDbsFR10y2d3ZJSG26o9t3AXac7XsH3dHwwsg3wYxHf9JO/WexaX/vnLwWjVe1Zu/AILCTtwaktr9nT57rbM0tl0+mV1zMaqVW2ZgZw20sHIz7Na8a/1Nu0xQXvYxMme8OCYHyjUK+ppkdPBIyTQBHeNdkXlYPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICBg6e4i; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICBg6e4i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaOetrTktlcO6byQdD8VsSkC+wXxU3ZAWld/bbOGRU8WzBOirGGSHBCFb0OMrlPVIUEhKnIgJRQuPXOT4FpixcoW2m9YHz/EwRy1c4dKZZR/0mx6rVCiOUZnPtouHhhe9U2RV82rpmf38ioNqiHddNlH2+PWtEZLWp76T1smL0WWwUt0uHRdQYL66UwmSRkM57MydH4tup61EO7UmoX37UDFFaZGxS1CLLC63Mkhb6PaSHJD1LS6YL7ARNZ7AyU7or8AgFmLKwq4+f5g9F4WN3u/mdeEJbL8QjUIb+2ucoKrc/gHLaYDgfcZX0McNMqBgfov6d/aZueChBB7NpsYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1mxz1yyMgnJBmHwXQnO6tbe9XLGLFOxqWqz/GQisXE=;
 b=ANPqFLn1TaeH2Xm/taIJZ/q0HnPowJoI534K3lHl8pIAvZIvAxMupBMtwO9PtXjxWAf2GMX3ncbGWi6811q6SPpHMBQWAw3UN9pZYUoGe6tZ/3cOTzXExHoQw8E2JGSQwFc8BXBzyCLfb9eKHNTsRd85P7a6dOOqyYtuYXd7CKPLWNab5eYIYhhzwcv/BD3n2phNNs+Awimi93IaquYr7038FdspYbODrRXaCTygfpAG4MoXCbeDxjP4MKECRFZH3HoKf3pH+eFcdDhcFOaUbcJhtcYIkTQwgNV4HVyILsRS7uYk8Q9m/Qq7qvH2f0t8aMFfWfVJ4S6L9+8QlxMobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1mxz1yyMgnJBmHwXQnO6tbe9XLGLFOxqWqz/GQisXE=;
 b=ICBg6e4imGc7p2IpxbfYdI+whyRRU1UVzoAdAv+bE1j3dGvvzPeauWcpYORkWLHVwkneVgfjHwJySxJE/SH6KcVjVrgh2+ERGbBSb9P4ee8CEA4ZjigQXExzfflPgvMh+ZE87kYhXDlDtZdi34QSX5hSC34Gf61h9oL9hoJyqkw=
Received: from CH2PR19CA0011.namprd19.prod.outlook.com (2603:10b6:610:4d::21)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 26 Mar
 2026 11:48:42 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::b5) by CH2PR19CA0011.outlook.office365.com
 (2603:10b6:610:4d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 11:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:41 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:39 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v4 09/12] amd-pstate-ut: Add a testcase to validate the visibility of driver attributes
Date: Thu, 26 Mar 2026 17:17:53 +0530
Message-ID: <20260326114756.20374-10-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be0d0b2-c303-4a31-442c-08de8b2da0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3suCZbPXKL6mKZMcN5OVztRVLGvtrQLBRXYDuzxb70i9Qh5MVCUyAUzBYNBjLl6gQlbCD3kLxlFcQnZ77O83U6DRCyNGq1oKFGXnF2L9icWO+a/cjtvKxzvKYYnnmEA94BQQvOxBhbG81MVhO8BpTyKoNYig3J7Jb2LjWoVsS591gNV26nOdIesq+2vnvzM2iykjr2s1PYsBUtv62nVCF6l8nWydrCaKN32vH17oeL08wLQpQCV6gvErn8Qbuuf1uee8sHZIrdjG+ftozqvMGJSm1oJSm+Ac5jW9HCfUoHV81TNLdOne2owlE+GOJXVQTfDGLbgvvxVfUUzQFOtcmeX2vNym0PMEFb83/4/KBrO+8vaPCftcF9pL3K5QSpqocAM0lXlmPWRupFxeXzzTG1Ddk70ssaAGWJ+J6PuCswOMQ8/YfopM4JPFbuiPMIdCoMIMwv9h/cBBg8C04QN+35JP07yYTGE8udj3crKpkSwFVml+XgZwDvlOYHoXEOk554WCtz1LcOe8sOUiXce0tHwGmu3BnTxZ3W8YV1EqLdbMWGpJYoFcWt8me3j7kAqwtJnhcokhNyrhtGvc4gOclx1PhsEpSRLf4jadTrVzfxsAdWJQhOn6FUZgfXnkNanE0UVp19ucGqyZBVk8fEtDPRO1tenfYZ1QXBLNdXB1ivcEwU4HvopNWSjHIfVPloToYBUwWqEx0Q0/XZm7Ghwq7t0H1bynzP6jM7sqUvypYYRWE8nWxkPFg/t4kd4IDPJ/y8cYgN508VAviH4BSsyIyw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ielOsLcWIrNaPQ2ThBt455f8zYFAWNgwF4vV9YR9RbWGXl18wGKSo6BNIaSUCqMnZwTiAW8aA2EWRbW2fpqrPcA6/4dRKY+ZQLKbeQJ6cBJlDZazebFnuFiZATlj+nZCVRrzyN9i8xGQWafenxd/r5UTIIBOVz8aXKdliabaFtnm/6qaAGljiiB62On7YRoNouGlyIsldUE3bnzj/ywfBELqcxey0qx1Dm/MqNDrg9YTV2Opyv+vu+K/iTLA8nx+Mtqqd6u7y8jVYpLfLVZIMrm6QRYAAkMqyHLc2OY1ZOcxvqlF+9eDXWi7wxQO0O8xUJnSMKyt/4z3CpNrgOGA3y8lH2IdvTGNa9c06ffWZqNXCIcuLXOqqA0XPIoPXfUqw6xDSQjyGtzi7RhpUMOn16k+2mrgpGqlSN28iympjjE4I6ITQVfejuL+7I8iCoUH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:41.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be0d0b2-c303-4a31-442c-08de8b2da0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

amd-pstate driver has per-attribute visibility functions to
dynamically control which sysfs freq_attrs are exposed based on the
platform capabilities and the current amd_pstate mode. However, there
is no test coverage to validate that the driver's live attribute list
matches the expected visibility for each mode.

Add amd_pstate_ut_check_freq_attrs() to the amd-pstate unit test
module. For each enabled mode (passive, active, guided), the test
independently derives the expected visibility of each attribute:
  - Core attributes (max_freq, lowest_nonlinear_freq, highest_perf)
    are always expected.
  - Prefcore attributes (prefcore_ranking, hw_prefcore) are expected
    only when cpudata->hw_prefcore indicates platform support.
  - EPP attributes (energy_performance_preference,
    energy_performance_available_preferences) are expected only in
    active mode.
  - Floor frequency attributes (floor_freq, floor_count) are expected
    only when X86_FEATURE_CPPC_PERF_PRIO is present.

Compare these independent expectations against the live driver's attr
array, catching bugs such as attributes leaking into wrong modes or
visibility functions checking incorrect conditions.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 139 ++++++++++++++++++++++++++++++--
 drivers/cpufreq/amd-pstate.c    |   8 ++
 drivers/cpufreq/amd-pstate.h    |   4 +
 3 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 3dcdf56883a6..1f62ab6438b4 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -23,6 +23,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitfield.h>
+#include <linux/cpufeature.h>
+#include <linux/cpufreq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -53,13 +55,15 @@ static int amd_pstate_ut_check_enabled(u32 index);
 static int amd_pstate_ut_check_perf(u32 index);
 static int amd_pstate_ut_check_freq(u32 index);
 static int amd_pstate_ut_check_driver(u32 index);
+static int amd_pstate_ut_check_freq_attrs(u32 index);
 
 static struct amd_pstate_ut_struct amd_pstate_ut_cases[] = {
-	{"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   },
-	{"amd_pstate_ut_check_enabled",    amd_pstate_ut_check_enabled    },
-	{"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       },
-	{"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       },
-	{"amd_pstate_ut_check_driver",	   amd_pstate_ut_check_driver     }
+	{"amd_pstate_ut_acpi_cpc_valid",    amd_pstate_ut_acpi_cpc_valid   },
+	{"amd_pstate_ut_check_enabled",     amd_pstate_ut_check_enabled    },
+	{"amd_pstate_ut_check_perf",        amd_pstate_ut_check_perf       },
+	{"amd_pstate_ut_check_freq",        amd_pstate_ut_check_freq       },
+	{"amd_pstate_ut_check_driver",      amd_pstate_ut_check_driver     },
+	{"amd_pstate_ut_check_freq_attrs",  amd_pstate_ut_check_freq_attrs },
 };
 
 static bool test_in_list(const char *list, const char *name)
@@ -293,6 +297,131 @@ static int amd_pstate_ut_check_driver(u32 index)
 	return ret;
 }
 
+enum attr_category {
+	ATTR_ALWAYS,
+	ATTR_PREFCORE,
+	ATTR_EPP,
+	ATTR_FLOOR_FREQ,
+};
+
+static const struct {
+	const char	*name;
+	enum attr_category category;
+} expected_freq_attrs[] = {
+	{"amd_pstate_max_freq",				ATTR_ALWAYS},
+	{"amd_pstate_lowest_nonlinear_freq",		ATTR_ALWAYS},
+	{"amd_pstate_highest_perf",			ATTR_ALWAYS},
+	{"amd_pstate_prefcore_ranking",			ATTR_PREFCORE},
+	{"amd_pstate_hw_prefcore",			ATTR_PREFCORE},
+	{"energy_performance_preference",		ATTR_EPP},
+	{"energy_performance_available_preferences",	ATTR_EPP},
+	{"amd_pstate_floor_freq",			ATTR_FLOOR_FREQ},
+	{"amd_pstate_floor_count",			ATTR_FLOOR_FREQ},
+};
+
+static bool attr_in_driver(struct freq_attr **driver_attrs, const char *name)
+{
+	int j;
+
+	for (j = 0; driver_attrs[j]; j++) {
+		if (!strcmp(driver_attrs[j]->attr.name, name))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Verify that for each mode the driver's live ->attr array contains exactly
+ * the attributes that should be visible.  Expected visibility is derived
+ * independently from hw_prefcore, cpu features, and the current mode —
+ * not from the driver's own visibility functions.
+ */
+static int amd_pstate_ut_check_freq_attrs(u32 index)
+{
+	enum amd_pstate_mode orig_mode = amd_pstate_get_status();
+	static const enum amd_pstate_mode modes[] = {
+		AMD_PSTATE_PASSIVE, AMD_PSTATE_ACTIVE, AMD_PSTATE_GUIDED,
+	};
+	bool has_prefcore, has_floor_freq;
+	int m, i, ret;
+
+	has_floor_freq = cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
+
+	/*
+	 * Determine prefcore support from any online CPU's cpudata.
+	 * hw_prefcore reflects the platform-wide decision made at init.
+	 */
+	has_prefcore = false;
+	for_each_online_cpu(i) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
+		struct amd_cpudata *cpudata;
+
+		policy = cpufreq_cpu_get(i);
+		if (!policy)
+			continue;
+		cpudata = policy->driver_data;
+		has_prefcore = cpudata->hw_prefcore;
+		break;
+	}
+
+	for (m = 0; m < ARRAY_SIZE(modes); m++) {
+		struct freq_attr **driver_attrs;
+
+		ret = amd_pstate_set_mode(modes[m]);
+		if (ret)
+			goto out;
+
+		driver_attrs = amd_pstate_get_current_attrs();
+		if (!driver_attrs) {
+			pr_err("%s: no driver attrs in mode %s\n",
+			       __func__, amd_pstate_get_mode_string(modes[m]));
+			ret = -EINVAL;
+			goto out;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(expected_freq_attrs); i++) {
+			bool expected, found;
+
+			switch (expected_freq_attrs[i].category) {
+			case ATTR_ALWAYS:
+				expected = true;
+				break;
+			case ATTR_PREFCORE:
+				expected = has_prefcore;
+				break;
+			case ATTR_EPP:
+				expected = (modes[m] == AMD_PSTATE_ACTIVE);
+				break;
+			case ATTR_FLOOR_FREQ:
+				expected = has_floor_freq;
+				break;
+			default:
+				expected = false;
+				break;
+			}
+
+			found = attr_in_driver(driver_attrs,
+					       expected_freq_attrs[i].name);
+
+			if (expected != found) {
+				pr_err("%s: mode %s: attr %s expected %s but is %s\n",
+				       __func__,
+				       amd_pstate_get_mode_string(modes[m]),
+				       expected_freq_attrs[i].name,
+				       expected ? "visible" : "hidden",
+				       found ? "visible" : "hidden");
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	ret = 0;
+out:
+	amd_pstate_set_mode(orig_mode);
+	return ret;
+}
+
 static int __init amd_pstate_ut_init(void)
 {
 	u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5eae74a67aeb..ed9fd4155a25 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1390,6 +1390,14 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_floor_count, floor_freq_visibility},
 };
 
+struct freq_attr **amd_pstate_get_current_attrs(void)
+{
+	if (!current_pstate_driver)
+		return NULL;
+	return current_pstate_driver->attr;
+}
+EXPORT_SYMBOL_GPL(amd_pstate_get_current_attrs);
+
 static struct freq_attr **get_freq_attrs(void)
 {
 	bool attr_visible[ARRAY_SIZE(amd_pstate_attr_visibility)];
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 453adfb445f8..faead0b19a8a 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -134,4 +134,8 @@ const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);
 
+struct freq_attr;
+
+struct freq_attr **amd_pstate_get_current_attrs(void);
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

