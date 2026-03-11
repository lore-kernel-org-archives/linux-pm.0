Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F47373BE2;
	Wed, 11 Mar 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237729; cv=fail; b=dDp8+BwFNmdRhGerG7AvEtYGDVUQGHqYQqC9I34QxX+BvIfCAOicYSNgIJOBaoqABXKMTaSzq8unF0V9GLkj6FL59shjPUCKMwTRpMg3jAE3EszH2r0Y01+FUtrZEAE5aHGf/Bv+dgq2FSyqMDm3DJ5jJysZv9bVdobnvhGiYTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237729; c=relaxed/simple;
	bh=A1yHnhB/IYVOd2+W3u/SqDV3u1aRzkm3Sb8Rxq9owic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMcP+ubnVilEBXEbruPQH7lhgDcY3mgDy+5+dHnBXrXNGRdVL8Sy3/wofpqX6Z5LwQVfIRlI2W18nNLCetSglypoDc6VgriXdoc9R1jvpDRc5xDgvDOm2fzEGZzvneq0HBVAwcOHCatxYyjVaya6qWx4BmZImymZeD4OBOVpbLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hzxNXfHn; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hzxNXfHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6XMcQ8wamk99TzPvXbA/krtvQzSCjzJ9+ecvkeFWZYTN/quj/NLnOIsbua7TXSYoMoID5KEQgokL8Ui16ifpq8uya/hg8uA49Iy/159Xr1xbfbXRN84vVvfR9pxd5STeV5QKGBia5960CHwbFLcx2/u3vUw5M6gmFjTnxcqq1BEJONigxiw0rIhMa0YKnVWcD1BQaiGrXuHoF5huJlVg2G7PM9ukyCPE9Yt92J4DHBbw5t6nXcWgpMhxt8Tf7w5p1Yg9OhmoJRxXYCPKfRe4p5RdoMj24i7CH6eOTVw0BeJnTVGGnkTtc1E9xQWrGEsN1oFZssT8qv8BDp2L1gtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0pDnujbxihaJ9jacUUeRsP4e8AtFNDFw9OChWnL/PY=;
 b=O2G1vrmo0/9dWs3IUK8qdEBA3Quc4/BAjUkxHVzZaR4Xbi/HnO58FNWXycJddqBScA1wJQ9dGt/WShnNMCHH1XxS7tBPkvN+PHrxP/icB7kLMpnC97uJafx8OekFsk/vKuzUNGTujN0XunOKDJTElkOBL++Gb3BvhfMGpXvG+t3cCP4klU846EYUAnkYlm8ALVJefDDnytOWurrPUZ1L+U2I31iD9Y9QOngsciyqjn+77f3mtz/NeBJtTrdus5YEDhGSSzsPa1lqWVP4SBW56ag02dviKIKReCg0cI4pEWP8dZIGBQ5SZQHDZGBaT/jnZ6JyQHIIDv85z7muZg5M1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0pDnujbxihaJ9jacUUeRsP4e8AtFNDFw9OChWnL/PY=;
 b=hzxNXfHn4nfKhmG3ghS1yIzm65tfuJgDJZYh5SDqr/eIEXbUtxBpsA01uMXA5zQEBCEiTuErLk2H3o3ERL4lM1UC8EuRUWCErmlH+SDQIbmEZyWA3GBAMJdYt6n/tvzSDECo3l+G7oY6zAESalvwul/39OHJ2zpcLTwZ53cIzHo=
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 14:02:02 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::71) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 14:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:02:01 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:59 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Subject: [PATCH v2 8/9] Documentation/amd-pstate: List prefcore related sysfs files
Date: Wed, 11 Mar 2026 19:31:15 +0530
Message-ID: <20260311140116.19604-9-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 63853274-a090-40a4-c2c0-08de7f76c4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z21Tc6RZ1aj+eXBPJjtN4DzzPvxlPec7eBzkakQQZ8UBt+NoVpauforlvMRrHqaKgH2blaYTV/BAOt0D6xZ8X1ql2ZBnrrNtnZrwPpOnzQg7Lvrup4V+/wDWF9syGJuS0tga7yvqW03Z2oVSRZVe9NOVc60DjteVUo2f2koMC/ZHPEWQRmVfbGLoARWrVDhJ63eU3KTn0sfbBj7bK1wh/yLVb88eXjzIkedF8B9Q0eqF/A+EoWUeevzIe4AKI6CLVgrqxI29ogfLceHCrP0YSANsKhDga0+4pkzWCYicTPJhzzGXiYsXrR6BMLKd4BZ/4WfbsNF/R8bWpk/REJKZ0Lt12f4CmQGPVQklNdDAJXBv51L3Rs1OrQangOAL8Ju7AtcsTUkY6ogxP05HvMX39KRnBmjSCaMttACuiSTELP6V3ItF0FZUMqOWv9aejk0K6CseXkWyN/MigB6jLR0+E8guzbRkJ7naIpaB0FAFfIAxXS1lLroZPenA4VQXV5VXRw2O6uk7SUYRxU5ElNIEpn/hK+FfNKXa43T3YNZiMNrf0k59NCxcc3LcBhxIHryjoabCe7jiCBi6TjLH7+RzFoZOPwGV0o4/d0YFiO+TGNw9xluglfVIMVca6O3cy12v/TqSHWljAJrJr7bJrusnCbBZJB84vxrrbexRSneO2fc2qUzVIbu84wQs0toKgKqeZ6l2H+q0P/Z6Of4lsnEGuDxMphH6peJajUtZDxpFfJGety4axRU+4dwfwqPUcLY64PTII3WOR/tazMsGDulotg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ksr+QxfQIBfWZHqWmNkBOIC9STLfaYltk55GJlR99eu/xXU83j2oJGD1pg0QVOFdXS0TgD6x3Ku0ch5apIPSErenjhfLhxShoczzuHqqFy4RC+YgKI0xAJSZBNZrEArdos2XTMtZCFcK2XRT7G7OjwCWrsDlGe+0/gI0Lw5guqq3AXhlFRoNO40dJMTDD+Hf358NnOM0+faGEyaA33bKhGVNJkAQGyrWxFlqY5XKiU6U9XIN7DtT7htOx9gYZ0PdEh0DZ/akDaIqYSZqXa9NaCziKufmXQTvJ7+7SCMJ7mjq31okd0+msAP/FNo4hsyYjo+tn23HU3SERp/4efELKmNDcH+BBOWitrmLXPadOWUiNfblpqKIviBZ2pOku20UFH+eAksCA4516gSeF3iWfrX4B6Az8+Q3Tk9Jvogpv0mBbPJN3gkGjnC52b2b1bvB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:02:01.8547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63853274-a090-40a4-c2c0-08de7f76c4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

Add the missing amd_pstate_hw_prefcore and amd_pstate_prefcore_ranking
filenames in the sysfs listing example leading to the descriptions of
these parameters.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5f..f566fea6613e6 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -239,8 +239,10 @@ control its functionality at the system level. They are located in the
 
  root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
  /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking
 
 
 ``amd_pstate_highest_perf / amd_pstate_max_freq``
@@ -264,14 +266,17 @@ This attribute is read-only.
 
 ``amd_pstate_hw_prefcore``
 
-Whether the platform supports the preferred core feature and it has been
-enabled. This attribute is read-only.
+Whether the platform supports the preferred core feature and it has
+been enabled. This attribute is read-only. This file is only visible
+on platforms which support the preferred core feature.
 
 ``amd_pstate_prefcore_ranking``
 
-The performance ranking of the core. This number doesn't have any unit, but
-larger numbers are preferred at the time of reading. This can change at
-runtime based on platform conditions. This attribute is read-only.
+The performance ranking of the core. This number doesn't have any
+unit, but larger numbers are preferred at the time of reading. This
+can change at runtime based on platform conditions. This attribute is
+read-only.  This file is only visible on platforms which support the
+preferred core feature.
 
 ``energy_performance_available_preferences``
 
-- 
2.34.1

