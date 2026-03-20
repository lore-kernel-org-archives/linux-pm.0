Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022118.outbound.protection.outlook.com [40.107.75.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E42D8DCA;
	Fri, 20 Mar 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000664; cv=fail; b=REnRKCj8dlFqymLOX1uA8b4GFGsu+7TAzfJMiOwSiaM4bthFVjhNpF8GIONGicZrNpxzL68xDkByXPqgWJT5Ac029JB9gaZZYZ0EwGq3b3ARX7TbOX8Qbuu1njYguBPOJezzytjAbUrr4fHbUwNRsYtAxvokHMTTxdYFoiFE8os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000664; c=relaxed/simple;
	bh=eC7mMNUFrDsFNFc3EqrYYF+r5Km5mW2LiU5QPWJrHXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhvifRkPt3eyHf4hbtq9Fd4hxbakaoJJpDTHaa/yxhYqOe8Zo1bsAr/CX5pKKfCzvO/REGx9ZCDZ0Tt1/ae5t9K3IQj8R31M1/MXhjlRy/X0Dudt2KMG17aRMxKpYk+Wx0y5n1FsHyghe6KK18nMsSIUddG0lgvfMzEVc2OEFjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=HIdFFHxO; arc=fail smtp.client-ip=40.107.75.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="HIdFFHxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxybMobI3EGsVGxd73uWpQVhja0VdnbehpKOqiTz01S9zZpE1rjy4CjeYI3pteMLaha5YfwIx8ak1XWY0R7NRYGDQ+RzQsGQNH/NFOIj5ET2YDJyzr++0pj6H+8mVOVxx5ULie41iiSbgNXoOUqZfa02moltUbuaSYKnYP/El1RA/R0F3W8eRPc3p9RSTc4m//TLGwij4a0RpRSoCep3IWhGGRxAMiIMuTMKTwSb1SAHXOnnYEfCQ5qMdjMsNylynRgfnpZpII7EkkHWrA3i9+mf1leuOeqYyNzcLZqlSIWfNgD1Ya3DOpS7K1MVk4KWEjxk7CcDEaL3FTCDMZSI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmHq8PXkhwFb4M2oG+c5u78Z80KSKZCCPtcJXRiTWFc=;
 b=UDse9d9vCoJXg79MUA3PCofGsCKL9C0OsGj0pDY6WuftY5iIb69JkqQRPupJUQFlXQQ+m98SeZ5IwAfGRw5Dtw8LT4Y/ng1nMpYBpkVjscs4t967EOz/Wvb/ihRsAUtLV3l7Egof7c9JJcZ7of6T9wlU5Gu5EWin+l46CcIRY6Ud5OPaj8wXZWmT9az/HHMREpjrEeexIMD93LD0JBnmoBMLQY6479MQ+XuTCHIi4Fg1k2HYxi7CZdL8HK/FU9GAN1A2tNxboNq9pUudD83vIbliAlIdi0HhpfnVvXdZblU0D1YQTIdCTg1Duk7v6bGNO+IL8MQRsf7OZg7WcmhviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmHq8PXkhwFb4M2oG+c5u78Z80KSKZCCPtcJXRiTWFc=;
 b=HIdFFHxOYsf4bVQTaIHYCqjRAkeWm7YtdDoHLaWsx6K4NyRQd3KohYhYRAlqxcWvRPNX9ipVE+QHg1u5BOG8ph8G4qpW7zAOk4PAZHf4t9/4dn+FeKjjBnwXQyQBWIHHcA3Xv/dX4qMixvQ5q7zdpNhbk3vbZyuOnZNUjZ0AfN3wSrR1UZX2qkk7TcVPgrKhVnfQi8+kQaA5zJR2j3SwAuo6yCpSp8K6zimRj4jgYF9CeQ5i3lFYvK3L5pUXxf+1G2k+Njde/Efm00FTLkuJMUSuo7WKhuQXqej6kq6zHchOoVUc2jwgun0fuH+4ar7Ajr0HW6vskW14oBQ7HhzfrA==
Received: from SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21) by
 OSQPR04MB7946.apcprd04.prod.outlook.com (2603:1096:604:29f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Fri, 20 Mar 2026 09:57:37 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:4:1:cafe::f8) by SG2PR06CA0189.outlook.office365.com
 (2603:1096:4:1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 09:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Fri, 20 Mar 2026 09:57:36 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 74A861B0;
	Fri, 20 Mar 2026 17:57:36 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	SW Chen <swchen@qnap.com>,
	Kevin Ko <kevinko@qnap.com>,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH] cpufreq: acpi-cpufreq: use DMI max speed when CPPC is unavailable
Date: Fri, 20 Mar 2026 17:56:48 +0800
Message-ID: <20260320095648.3598007-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|OSQPR04MB7946:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 340e6daa-84c3-42ec-741e-08de86671da5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	airDbgmxqeDBhydtpqNch4kHifnyA9jA2+73aMzvXlLU/xBPtTf6RrjLD/liL/EmB9oiImRxFfuRudXfuPOzhaBiyDgdw3lQS46oyhzgTo5Krb1haTxrnlfq/BD5zjtC7wemMnUl74fg7QvQ+gPg/P4twyvJCCGvbLoDIsGr7R7FdNkaFXsNlDHW9umBqiFuU67tuGssDL9N31oFAgr5a2GQxPqMyUDOnMYVhd+qOv2EK7kReIEtO6VpTRY6m9AnSLYbWfKPYOWHTw++2emdrhsceHcRjgZWc/+JY7Mikw7drIsoJpoFW9+Bc1z+eqTTbI04VLSY/dj8RrR6VhBgKNeocNmLU8B8e85IMR7e7bo54pkAcpiDM9A0oPhpJ37B+4AvLHVBEbzEua32KdeyRYO+wQ/oUnQzRh2iKj3sI91jj9E1b+Hff/gmY6/VhSSVMU8rk/SCfHb3z80PFAPKUBSyeQxpk79b6zngHMPfWX4iokrAEEzerUKWRxxioJEObyPzliZ/N6NtsVDKV6icYxjOQAibDhvhMu3u4N1otMi7v+aO9XroHiFZ/SO2V3/h6KmEmeyqhH/93g8911vEEJQkMDxavNNcnRYQwE/+WCm6Fw48Oz41ETO8yc3zcQWpp0rXDMrVhYPvT9phb8aRjetFapk4kofZn7/qFAdWIsTVictZrb9HhN54xZQMXX6URoQquGkM1S2bqYXqFdojQ9rFZw7ECBFmWFUix+9/gqsPcy4iTEL9Zk/N+FXxFNrkfJn66V6zW7Sxk3rH6MJAcw==
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wWkOJfTQzmKwlAlW+gNfzm0d3+5FHIMA/blsxQIfx7YqtQtLGnS0VM6EdRRBWBNwuts6+iiNOtlSoYwD/jiGTBX4NevSG8zWrG17aFluT9z8MaoSJ9KwseOQvVzYIypWtonhtv0GL1FVFjuXOOW1rK1wjxQgFb5FPuEjjnTp8py6M3fs7k0/m9KE3UNI954wT3bhj7cW5zpzqsi78AZg0wW1sdDqtimG7j1LstaIKtjhi2y/HTYr0Ocr0Cv6ce7ByWMNtpTqINGNDD26aKvN3hn2CFCoqd5a8LbY0741qh166XMsqGp/M40v98YQjEGiST0HPx7zn2q8gJcFTrfqRPb54KNYAmf0HjHW4eZTL2RWmL1kxHbUb5oycr0IFOFJR2vckNXNblK1+L7c9vrLbXKt6rBsl8mtkiYnEeUxRzRA09V1HSbg/+Atu1zLggMU
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:57:36.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e6daa-84c3-42ec-741e-08de86671da5
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7946

On AMD Ryzen Embedded V1780B (Family 17h, Zen 1), the BIOS does not
provide ACPI _CPC objects and the CPU does not support MSR-based CPPC
(X86_FEATURE_CPPC).  The _PSS table only lists nominal P-states
(P0 = 3350 MHz), so when get_max_boost_ratio() fails at
cppc_get_perf_caps(), cpuinfo_max_freq reports only the base frequency
instead of the rated boost frequency (3600 MHz).

  dmesg:
    ACPI CPPC: No CPC descriptor for CPU:0
    acpi_cpufreq: CPU0: Unable to get performance capabilities (-19)

cppc-cpufreq already has a DMI fallback (cppc_get_dmi_max_khz()) that
reads the processor max speed from SMBIOS Type 4.  Export it and reuse
it in acpi-cpufreq as a last-resort source for the boost frequency.

A sanity check ensures the DMI value is above the _PSS P0 frequency
and within 2x of it; values outside that range are ignored and the
existing arch_set_max_freq_ratio() path is taken instead.  The 2x
upper bound is based on a survey of the AMD Ryzen Embedded V1000
series, where the highest boost-to-base ratio is 1.8x (V1404I:
2.0 GHz base / 3.6 GHz boost).

Tested on AMD Ryzen Embedded V1780B with v7.0-rc4:

  Before: cpuinfo_max_freq = 3350000 (base only)
  After:  cpuinfo_max_freq = 3600000 (includes boost)

Link: https://www.amd.com/en/products/embedded/ryzen/ryzen-v1000-series.html#specifications
Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/acpi/cppc_acpi.c       |  3 ++-
 drivers/cpufreq/acpi-cpufreq.c | 21 ++++++++++++++++-----
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f0e513e9ed5d..f53de414acf2 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1944,7 +1944,7 @@ static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 }
 
 /* Look up the max frequency in DMI */
-static u64 cppc_get_dmi_max_khz(void)
+u64 cppc_get_dmi_max_khz(void)
 {
 	u16 mhz = 0;
 
@@ -1958,6 +1958,7 @@ static u64 cppc_get_dmi_max_khz(void)
 
 	return KHZ_PER_MHZ * mhz;
 }
+EXPORT_SYMBOL_GPL(cppc_get_dmi_max_khz);
 
 /*
  * If CPPC lowest_freq and nominal_freq registers are exposed then we can
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e7eff6c2f092..9b4638ad27ba 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -849,13 +849,24 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 		policy->cpuinfo.max_freq = freq * max_boost_ratio >> SCHED_CAPACITY_SHIFT;
 	} else {
+#ifdef CONFIG_ACPI_CPPC_LIB
+		unsigned int freq = freq_table[0].frequency;
+		u64 max_speed = cppc_get_dmi_max_khz();
 		/*
-		 * If the maximum "boost" frequency is unknown, ask the arch
-		 * scale-invariance code to use the "nominal" performance for
-		 * CPU utilization scaling so as to prevent the schedutil
-		 * governor from selecting inadequate CPU frequencies.
+		 * Use DMI "Max Speed" if it looks plausible: must be
+		 * above _PSS P0 frequency and within 2x of it.
 		 */
-		arch_set_max_freq_ratio(true);
+		if (max_speed > freq && max_speed < freq * 2)
+			policy->cpuinfo.max_freq = max_speed;
+		else
+#endif
+			/*
+			 * If the maximum "boost" frequency is unknown, ask the arch
+			 * scale-invariance code to use the "nominal" performance for
+			 * CPU utilization scaling so as to prevent the schedutil
+			 * governor from selecting inadequate CPU frequencies.
+			 */
+			arch_set_max_freq_ratio(true);
 	}
 
 	policy->freq_table = freq_table;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4d644f03098e..e6c5ef3173c5 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -156,6 +156,7 @@ extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
 extern bool cppc_perf_ctrs_in_pcc(void);
+extern u64 cppc_get_dmi_max_khz(void);
 extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
 extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
-- 
2.43.0

