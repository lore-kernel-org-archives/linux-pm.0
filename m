Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911A3546E3;
	Tue, 30 Jun 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846047; cv=fail; b=VHpGKV/FZkix9P3GlzcWP5Fl2Ef44/PS5IWHBdu0G269NWzPXNSRAkXxeebg0tTHwBMntIdnlyWE7m1R0/7+Km9CAxHmivdbEIDqPdOd060BT+p3qWhG0DLhOfHBc7a5WU5SrrIhaowQLII/G4Vah1EqU6a1kkFBpcDQQwUN0nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846047; c=relaxed/simple;
	bh=Vm5NKAHvuTYWyQA3qRkhTYBRJhyvBem4CFP9cdh7puE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+MkIQRfuSJa/8QQFrRGKgUCZq1JdnU8iQG6CcAuHHqqJNNe+KV8dse/Kw5CgaPgMTJXwhTGi8v0VB5CodCLvrG+mgLvmVKtlQU63mh1Gjr/YyIMO6y6TnhbOZRTXV6MxwNnzkH+kWR3MRqL8Ujw2f42F+ZoTT4MEkg4Zhnkvow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6I6XDms; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6I6XDms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyc2FaHDzbpNtvtkuCkShPGvtQ5U5QQMs8C6jyQnt8rRlHZLXujdMbRI+nMkEU1PaKq9aUcfwRT6JeVLOzJC7PtwOeylSn0973QTVy9XM80uQcpX6eP87CRMH4g4GUG8n4D6rXlNOQ3evQwPzMk2TWbLvGwBzc3ShZNMUILfHJTzV7QTYQLd15uqWanDLFDVkW9hGs9UDiJc5AQ/QtA8SEYWPLP5A1grikc4LwnWPkgsfWhzjWU9701iEvYRI1FbxlOO8jeXt7Ogpq/mS7j3Whq5jSVHKeg8n1SALk4vq94763/aQZ+fmhsb/qQEabQknioYwqdemeg6NztQsTZ/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5mgCTzExUbbMiqdhQUmDfhCOtjIo/mlSXDaZV7C71Q=;
 b=R1abTeOqqlW8dbsXv/BdJP23qXHQKIEY1pUupal+qayPKZM6it9p3+GSmuvA7cQbSd3IEUNT5P4jBgnAQD6LVIbWtqviRLHO1r1NXsa4dKYpy+i/oAsvOMIzmDNSo0DdXcR0HKQzAQ9rS5ZQPi0ezEjjENGMUAbPzW+VFU/HR3ZlJUBYouE1W8q5xfbPb9ySihCSQcD76navy67rdg85OMafxoPP8GTIYL/Y1nISI0P03eo9lXNGfyBuGiqWWTCvulwgqJn2hH3JToQOT0nedDiK0br3fC+nJ+lIdDV6HVS3vonpHsW1Y4eMX9NUmE9648a52qALajT/UilN3a5QFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5mgCTzExUbbMiqdhQUmDfhCOtjIo/mlSXDaZV7C71Q=;
 b=F6I6XDmstA12/dtXxXa/jYyoVc9JxB2v580edG7kJVKrfxXVwPWho7fMnGypnvaZMbTCTopCIrB8F2jONuEXmIhtI7mombBiudbu39jUITFdaSAhpQ2QKCpyXnnPqKUzQY780yqT+ZsPcd/RwcgLfrxPNTD74OCDFf3jtVlo+LI=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 19:00:42 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3f) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 19:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:00:41 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 14:00:38 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/6] cpufreq/amd-pstate: Repurpose "amd_dynamic_epp" cmdline and corresponding sysfs
Date: Tue, 30 Jun 2026 18:59:01 +0000
Message-ID: <20260630185904.5602-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: b45edb91-151c-4dd9-c6ce-08ded6d9e1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BQ2MW1d9K1iMxkvsqi16dKaJE8ntccTYmqESz/zFF89YkncOvv293DctYGq/Ae7KkdsS2xY3AItEAl77eeM67bmL/jM4/mMsV2v6bdGYQUnvFHUKf949nap7jewGD0MKhlxukOnvGHSZYm0miMulgfQjvN0ETO8WEJv7HFAWNv9yNakeE0S946E4KHV5JmgB/UdoH4nDSRmgJLNuSS2UNz3W5vDKbso8GJKPE2olK2BDQafjRMPI1qghWPwY7pV5qmHVpmhsQn0ZvIBJE/MPK215Lz/A9ojraU3OBHibcv20MfkMVLFXUYVRttrkOwwwprZtA+bvsy+KBrfO2p5AwCttZS9rhLiV97nhqU6QyPjJ0ez3sxoqbyvVTsqpnwa28bwVFDl3MwZG07cI6++TCAjkGZk97MhVtLQSda8IgmFqpHcStl32aDu1sPkj3sh1wdcUtNrdKUs8PhaqVyjDWeRR7scn3F4NMSU3R13Cq8B3W1iaGqP6gMTFFAwrzfQr0MmiK+pEjp/D8mYqtfb3AnSd3GSkjvay87EEdcRQHiOomQvTidxyscfVTI5i24RuvsdHQ1bw51eYr8YNouMs6trpK68hx0CKNxGpIohI7kGR92oUdI1wwp1YyLYJcNN/dYuQbJgVmlY2N4xaA+Y+Zqn7hKhVymifj29CZkQAgg8uwy62Mawz9J7IwvpdgBAtmH9iQX3lBG31VJgU+QGVtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	58eyaFzZuq4n9C+DJXDXmWAjDnd3nGG+rzkVrq7ZsugplAKQmU8zY7F+P2Aj0EGxzln7MsEZdgdy2/qv3Wd1ZNB6gmnKbmRkKdMLK90tRFRZyw3LAJOq0R+uKXLphI7PggG5LCO3YnCzFbdWuatTtNORqPglBIeibVTz3RAUyqkiwF1AHCq6VJGAXt40r8IGcDW7coR+tq1SOkqDoviyKCYYTCwNdY5s98Pj8CgkeA0URuD4WhU76X3DQgIVF5410kryyXb9IVUdvn7g7DCP87TaxWW5wRM216epc0qCV0VK3VD41nksqnU1iire/qob39SRQmKm6v0UG5CY3yGH8bxBlMfS9E58Fn/Aj6u1esvYED8zRpx6yy6azdGzAXR2wd1mIUbJPLViwQV509pA7ZIVIn9bK1F/1XviuFiZ2OArA0/rdbLaT+kD/YXPoGhz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:00:41.7827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45edb91-151c-4dd9-c6ce-08ded6d9e1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

Since dynamic_epp has been converted to an
"energy_performance_preference", toggling the feature via the sysfs file
is now redundant.

Repurpose "amd_dynamic_epp=enable" command line to opt into dynamic EPP
by default when the active driver is loaded, or switched into. The
"disable" counterpart will "dynamic" option out of
"energyy_performance_preference" to ensure dynamic EPP feature can never
be toggled.

Use a tri-state enum to differentiate if the user has supplied a command
line parameter or not to enable the feature by default vs keeping the
current defaults as is and allowing users to toggle it later via the
"dynamic" option in "energy_performance_preference" selection.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 48 +++++++++---------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c7eec6b96dcc..61f30820d95a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -82,12 +82,18 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
+enum dynamic_epp_state {
+	DYNAMIC_EPP_USER_TOGGLE = -1,	/* User can toggle dynamic EPP. (Default) */
+	DYNAMIC_EPP_DISABLED,		/* Dynamic EPP disabled from command line. */
+	DYNAMIC_EPP_DEFAULT_ENABLED,	/* Dynamic EPP enabled from command line. */
+};
+
+static enum dynamic_epp_state dynamic_epp = DYNAMIC_EPP_USER_TOGGLE;
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
-static bool dynamic_epp;
 static struct quirk_entry *quirks;
 
 /*
@@ -1839,39 +1845,9 @@ static ssize_t dynamic_epp_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
 }
 
-static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
-				 const char *buf, size_t count)
-{
-	bool enabled;
-	int ret;
-
-	ret = kstrtobool(buf, &enabled);
-	if (ret)
-		return ret;
-
-	guard(mutex)(&amd_pstate_driver_lock);
-
-	if (cppc_state != AMD_PSTATE_ACTIVE) {
-		pr_debug("dynamic_epp can only be toggled in active mode\n");
-		return -EINVAL;
-	}
-
-	/* Nothing to do */
-	if (dynamic_epp == enabled)
-		return count;
-
-	/* reinitialize with desired dynamic EPP value */
-	dynamic_epp = enabled;
-	ret = amd_pstate_change_driver_mode(cppc_state);
-	if (ret)
-		dynamic_epp = false;
-
-	return ret ? ret : count;
-}
-
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
-static DEVICE_ATTR_RW(dynamic_epp);
+static DEVICE_ATTR_RO(dynamic_epp);
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
@@ -1983,7 +1959,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
-	if (dynamic_epp) {
+	if (dynamic_epp == DYNAMIC_EPP_DEFAULT_ENABLED) {
 		/* Dynamic EPP is only available with the POWERSAVE policy. */
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 		ret = amd_pstate_set_dynamic_epp(policy);
@@ -2076,7 +2052,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 		 * If dynamic_epp is enabled by default, toggle it on
 		 * when switching to CPUFREQ_POLICY_POWERSAVE.
 		 */
-		if (dynamic_epp) {
+		if (dynamic_epp == DYNAMIC_EPP_DEFAULT_ENABLED) {
 			WARN_ON_ONCE(policy->policy != CPUFREQ_POLICY_POWERSAVE);
 
 			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
@@ -2410,9 +2386,9 @@ static int __init amd_prefcore_param(char *str)
 static int __init amd_dynamic_epp_param(char *str)
 {
 	if (!strcmp(str, "disable"))
-		dynamic_epp = false;
+		dynamic_epp = DYNAMIC_EPP_DISABLED;
 	if (!strcmp(str, "enable"))
-		dynamic_epp = true;
+		dynamic_epp = DYNAMIC_EPP_DEFAULT_ENABLED;
 
 	return 0;
 }
-- 
2.34.1

