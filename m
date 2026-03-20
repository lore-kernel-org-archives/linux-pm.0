Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0943CCFAE;
	Fri, 20 Mar 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017865; cv=fail; b=Iz7z7qZ8HoXTSsJVE5hXZYuT2HCFBK6YXgKH5M564tNOzKaxou0niUbz31HQfzBcLB1ezLXIkaDk9Dz9R0sT8eSAt1izJqbDo0L49w/aQqR4hQ2ftZeGtbj8Grpu+14PUO+w5jVohOGUr5lrayN/g1yKLdF19F9WBctcTYuXtow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017865; c=relaxed/simple;
	bh=kwnLbwmFNSMO2WWOqZqTAWNXYbePGwsaO6oypIo2s/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjAmsRGEIy2H2p3HGRV0i9Ec4ddUuixUJVbQSDTZDquJGE+OjzFIxfM6dw5Mlcaff3FhW9yQJLrmdOWgx8GPy8aaVtdXTVMeDTykjUUk7wc/dedrWFC1Ll30exOg4D3NlYSQDi944lVmRlVp2KC/CZiQNmlPSJjAUJWU1LNnm+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1MZWDTc6; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1MZWDTc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPNvhdPmAFkx8of3x6uqocE7LRqg/I6X7cCH6LaBmEnirWmCDUcXc9VMwBuSFSeoyI/9hy7ctnHa3rkn/zQ3V6E1HKgHsQLspQBdMlU5KjWTrEOjiHwzTFHsSKl8ICWcVk2tsCjvG2RulGiuaYEGyWClcFrhJtqLVIB7qrMYHnA74b78M7V5LqHtxxpWNTSbKszD1bcNru+6xwFb7GvHdPrWiq9g15yA5MGx7/HI3VsAUMz/j4yxvq7Uy7ctScHZuCnHuoAbVW9UGABecfLkIfGS64OzEDKS7i+WDOZwys7CdXgSUryz7yOj6UETDJHngLyObZTCufCSdJ9W6SUFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkLOwohI6dc8aPUc92IDLThfWowkKO64re0lSupCtNE=;
 b=M9ESILoiNhWmt8VXZjo4KQ0/UNM3gCgjRKVj3UnEA1l8fOtEvryi35YKk5Qu/Ezyt3akZBanuD8vIoikx+j78zwxmiyf9Npm6KFZujZd54RFbyXucK4s3hJPplAh457ABsl4Dtw4rtd1J8dHk6bVVIdFebzqRb9geeE2g+mjubs63KA3knvR/BufXBM4+X8NuPEQngmklV9PqKJOoqPfO8agLR0OguLtG3fnLi8R37qizBHdnTM4sGlAnV8kdA2QXGtKl0um0h66uOh1UIO1NHmiOV9yJctWoynfEnO74Rbq0y0NYlwC+FAgjNyMCGyHCI8fQghoF7Jj/+/8QWBzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkLOwohI6dc8aPUc92IDLThfWowkKO64re0lSupCtNE=;
 b=1MZWDTc6yKwX8vaY6mVQaz9iLAJ6otiNOrELmHtFnBDg4cQJj4WqixBgzimO4DECQqPQepsjhudWi22xyq09KO17KhwzzsCpxA9+GvtgyZonUc25bnpYzt9bZPVEz1GaoG1hooeySAvAklJpcnsxwcTeswwp6AsfiqB5lxrmb3M=
Received: from MN2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:208:178::36)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:44:19 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::c6) by MN2PR19CA0023.outlook.office365.com
 (2603:10b6:208:178::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:18 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:16 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 09/12] amd-pstate-ut: Add a testcase to validate the visibility of driver attributes
Date: Fri, 20 Mar 2026 20:13:18 +0530
Message-ID: <20260320144321.18543-10-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 06852f9a-0b67-4fec-8758-08de868f2a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1920/TwpvEZlTNpnJsA6mRqmiFr9VqT76WEyVnyLEkjOe97W0LRUtA71vGD9ofPEzFrQw1vjCzz1LybSwAD3s9JN+GvS8915XuxJkcJ1+dTB9idGRRLc0ljWjlT+SBaZisvd/VDM3A7xJdDTfV+D3oKKpw/yDv1eIuHDffHiNx0Z8u9izcnr3YTANbhzd6zr+fE/6A7ZYXCwex8P9U/M57XLbZTkFvX/ubE8/QwiPr9juokdZi0oJ5ziCL4HCAbzynTZMU2Zh1ax2lGqp3HQbRgHZN1RdpH4gIeXS/c3v9pKXXNq6SaOFaPvpGleBGs82MlAzhQ5IQ8Kcx7ln6ZLhS1dUsuGcu+nZRo0sc08LUEFZCK0BISP0pey4E/OIzekNgFogzmhqNH3Fa88gL4YufNaJBqyhOrPYHDZFfjM3r2gojMziJ06p38+M1ep0jg0Ek7SdrLOb1EVL+dS77eQHFPc9MtpIzhkGBEnrduSUrThrH51HpGbaC5rSNmFUbcwFkjzbqsSbxOxWPLET6fIh79XfqAgZsHRQB2+vBqfBGnICHgexVIH4Ki8nVdToKeXPH0Suq6y3NnTHLsxznWdV7/9/U3JC4oWednPPAUkpRGzcQIcJGCg2IKxcdAg/bcyVHdaDtnqBhFn2E6Vq9/yPOvt3krUqZL/u4hnRFyk52TZe955Qq9O/SIW4fsjnJ62Lw1G8q0vjAnG1Sbeb9DooUCdu2y2aqd0V2e1u9BG5GYJSV1qTrOehzKpCL8fGxgxUp+/wv9ZLcGrPjXSfORqiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IS6euUlS1MX+iVt9U/FwkTrc8FF0OovGVBTseKFZW3JP8dwh3RdGJu8Kat/w66fety2ocRa3Brv1F5PR6ETGTPeapegNLaJoUds3oWHFDUCDv48SQWpAJhBdP9FAH3VRZbTpIfDyCGI2ubrgdIPuKVbUsWlvT02AVDLZSI8/R2iaeoFPcYbPtKLtuJ5LCaO+i2GTlg2lfvxIuuFBQcdukcB9QLlvyHDR+x4H3Z/mM9tZxMrwtRzCJBoWhmuGXhBI6TxaIBIGI6x5Q4040pIG/5018QHaqhtFfptdj4XdeG0XHNrLE1RiQfsiRGkTR+2N7shqa9n/Yb3GDsyhiQrPIwRAipce+D19lDTTDjfjdnxJVAModVVpRogfPAb0YdG5E/msJuhKknu2KboIMMcTTG0z/0yAAlCNRU2JYrSEqvY7y8BhHm8+EYMhjCa3e5lu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:18.4535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06852f9a-0b67-4fec-8758-08de868f2a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

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
index 35e453a49c0f..5d87fb8a26df 100644
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
 
 static bool get_shared_mem(void)
@@ -274,6 +278,131 @@ static int amd_pstate_ut_check_driver(u32 index)
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
index 2f7a96836fcd..6551f559edf1 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -132,4 +132,8 @@ const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
 int amd_pstate_get_status(void);
 int amd_pstate_update_status(const char *buf, size_t size);
 
+struct freq_attr;
+
+struct freq_attr **amd_pstate_get_current_attrs(void);
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

