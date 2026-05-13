Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCC37F72F
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668158; cv=fail; b=Ew4Sr81uWXKzktSnd5hMQQLtQLdJU4Frs+NfdAGIZRSOz+GVuYn3e7NHXu6bYlb+Spojl+0fasWUrLvztChHdbJMI+XN6OYlT0jzDXJ/3WZY+PZfEDcCmP+rPCB4mPek+oGkkIKDb9xnzngICwBEiw0QPaIxBebv+qdXl5EQt20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668158; c=relaxed/simple;
	bh=cvDDAdLzZb+5SsmwWiM31T0g5x6zJq+/4Brsgnbf/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=md4iodgwEzVnzzMDvHaX0UHK278JyqDOA9tnG1Bwt/K3Hvwb/Ec2RsNg77oaYAqegaIKDqX1Tro65D6GO8sMySUASQmTUPPRVju83zg7WYkgOK3GM89jE4p/hkM83Cc8lFNLYbncsWtMAVV/ZXbTG64/sN0S0xlz4yUKxGfnWZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=m4DoAIQI; arc=fail smtp.client-ip=52.101.126.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="m4DoAIQI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDCLeInKy+rwFW/IOHXHQR/fUxaARn3KEd+22ygL5UFdW5RAaJV5URUh659lJuFhbs3U3Z5hQgQDRMnjW+8XbdBLNznhML14/e9sjLaMVJtoUgRRHBGTVSaO8cxqMPZLJq60NFbGnvGeVtbd3/lMIrCKehXHzbKJVTfq473/mSOx0qkhdfgGYWJ7htAk4dWdehpZJzmsPxLdJKMiAuq8or2pqZxVSlSawb3q4Lspgn9JoPqtLP3XZZm9VEwvW2jnMYPtvYIz062Azclld+7WhP068k/nuliRSRtCwhvb+lh0xs46fe9GBy0gAm6bFHzLeyuDgcLOKExvYLs0tzCXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0xGG4OustdU03hqvsjLfWOmaBnHEiCTE35EUPlc598=;
 b=O0eDrN9gJx7yuYzAWYP/qOIf3I6tUzoaXd3kWaZJe7ze6K41aHhobWVa9u2VhB9o4+WW9XPk+cwNYXwChvwG4uxaboDXA70mhJLMKhTjYo2JTWNgAWouH8GQijRA46mI4vwMu3YbrVsOYoj6jyXDIcUQEslE1nOA4dHlLDZ1Ff8Mq5RPtdd84cJQFNOxKcOkp+Hk8wjCVIkZ5TVa6+zX+ZScVmKMszUC8Xd4R0ai0+emvoiPCz86NryCzGo19/NbeF6gBbYAefmVXvUfVHaMJQufpwwzT3VcemH4quNhtI2b8SynWTcJnFlWSDpOl6nkcYkt84l1GhRTEF0Tgi+phA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0xGG4OustdU03hqvsjLfWOmaBnHEiCTE35EUPlc598=;
 b=m4DoAIQILN6asDIz100h+x2ex43mhSLKhXKb6wWy2fh/AsNVLuERxvuV5gvR9L/ktkB89DZbhYWOhIu8+0UccOhFvGixIGVsmgpDnNZgNkOd87jBApZqgc5n3JVmGiirYOdZJNBJZm5pr7pU/7wc8hJU5pyewOYGxS3ea2XDdlsHdysDy43GgIXVgIQLT7PhzdXm1olJxuQVOLw/AMOoTYcNGc8joUzaPxCRZJTlp2yB2V5jr9dWMbM/ArNQ1kVE/pEovuFAIId9OVtFjzUy+99wbYvbPfy/pRucGS2INWjIDWTg/QViZrCt10+uz2z3XSo3pJfFqEr9Hmyf1ry5TA==
Received: from OSTP286CA0095.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::14)
 by SEYPR04MB7364.apcprd04.prod.outlook.com (2603:1096:101:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 10:29:08 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:604:219:cafe::84) by OSTP286CA0095.outlook.office365.com
 (2603:1096:604:219::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 10:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 10:29:08 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id E73B51B5;
	Wed, 13 May 2026 18:29:07 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Henry Tseng <henrytseng@qnap.com>
Subject: [PATCH] cpufreq: intel_pstate: Use HYBRID_SCALING_FACTOR_ADL for Bartlett Lake
Date: Wed, 13 May 2026 18:28:46 +0800
Message-ID: <20260513102847.75179-1-henrytseng@qnap.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|SEYPR04MB7364:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e3c1d1e-34de-427a-1fd7-08deb0da774f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|55112099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	vqnKObIWHuIgpIBdgX3WA2oJWZJlfN/ZIXWVBYfnaD/lAUVf/C1K37SrcpoofDIet8Ie2unfDPGpn3AEFUV3cJ1xvFis21Y0H7NrfSD26hYnCuTE9mbJ8zXgVTtjuyMyJQjelxQ50L0GzSeaDEG6MOLio1ROTy09NcW45p24pCmkTl+YAvRhQXnaXr6ilB/aJq40jn3Oe3mBO0kaCsqos0WycZGJvnXzFMM95/b4KRgKdLVKy3GDf9I6sHiBKbsUbf0BBwmsHnHvU8f2WBFvbEGrjsD2DDQk1jIcv/2WHpccJKk0itnv5W0enmj3azdWJxq1j+evrT9UPCX0vCqzpAGn/0BqEyP4n1I1uwRMfVh9favaowUHsEXv6ANWZhk6KkDEgYZzEaL11EDM7L3K99CqGg3e3dPtr01CoLq8tNDO2Jc2xqL4sng4OkAVKtmeePyrkwqCF4Zwlp48ZLlJyQf5sD+VHd9/fp5HJjPGsIBsq5yMJgOptE57Wph6neXXBqaKAUEP7zn/kZNP6oKgfsFHwTkjc4HoQfqazLs1uJEBIHqmIIjRfJCE0Ge8gBOxyqde9FnSDHkZpGuf/WL3niE2DkCI2rBvVK+reUTIELphY9l0L+4YysKGHpYm9aPwZ6qfdAG1GWOZ8ZrflsVz7SEPoh5Cv1kRPNOtjpFop3pHKx57N7kvhwodU2qfpk2YXUCz3bl0SNhpGX6cH9cXwCMKjKkYVVImNAJNZ5VixXA=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(55112099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SqiOCoWxz73l434nLmyw4vT0BPnVy7ECo6pJBqTU9eWpaBksgeEMJmyIctbiFxbtJ9zvdGMJ3ORmM79Bf5a2eBYDiiteQQoGBVQxirO1CZvkai5QUHENCHlTAw/vri6loiuheT4ciUTDckX+gmT+driHqVJvIV7Ev8yLWtHrte/XU0OOgeXm9eqTFVNiCDqQBkrW2XOtBXbFVN59f/R8EEjip45roS2MbZmYDJj+uCxYTDhUVIJ3PKlo/r+VXmdg/Y8iUBK+HHKS02N4ur2mzU4QQT32/flOi07obSqTwL6I91tym4PaZ/IT+tlBqPJhHeT/LTrFujaoPvWwbn8/0vtoGqR3EfYbHyya8UG5Dyi3mDbodKNT/Ud5PeFYukFeYWEjulTpQuzrAWNPDrS4Lynuqw09OzBozR3CULArXSpt3dQNLdQpYlLR1boTjzo6
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:29:08.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3c1d1e-34de-427a-1fd7-08deb0da774f
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7364

Bartlett Lake P-core only SKUs (e.g. Intel Core 9 273PE)
do not report X86_FEATURE_HYBRID_CPU and are not in
intel_hybrid_scaling_factor[].  In hwp_get_cpu_scaling(), the
non-hybrid fallback then applies core_get_scaling() (100000),
producing cpuinfo_max_freq values that exceed the documented Max
Turbo Frequency:

  intel_pstate: CPU0: PERF_CTL turbo = 57
  intel_pstate: CPU0: HWP_CAP guaranteed = 30
  intel_pstate: CPU0: HWP_CAP highest = 70
  intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
  ...
  intel_pstate: CPU12: PERF_CTL turbo = 57
  intel_pstate: CPU12: HWP_CAP guaranteed = 30
  intel_pstate: CPU12: HWP_CAP highest = 73
  intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
  intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000
  ...

Per the Intel datasheet [1], the Intel Core 9 273PE specifies:

  Performance-cores:                                 12
  Efficient-cores:                                   0
  Max Turbo Frequency:                               5.7 GHz
  Intel Thermal Velocity Boost Frequency:            5.7 GHz
  Intel Turbo Boost Max Technology 3.0 Frequency:    5.6 GHz
  Performance-core Max Turbo Frequency:              5.4 GHz
  Performance-core Base Frequency:                   2.3 GHz

Bartlett Lake P-cores are Raptor Cove cores, per
commit d466304c4322 ("x86/cpu: Add CPU model number for Bartlett
Lake CPUs with Raptor Cove cores").  The Alder Lake and Raptor Lake
P-core entries in intel_hybrid_scaling_factor[] use
HYBRID_SCALING_FACTOR_ADL (78741).  The same factor applies to
Bartlett Lake.

Add Bartlett Lake to intel_hybrid_scaling_factor[] with
HYBRID_SCALING_FACTOR_ADL so HWP performance levels map to the
correct CPU frequencies matching the datasheet's Max Turbo Frequency.

[1] https://www.intel.com/content/www/us/en/products/sku/245717/intel-core-9-processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html

Signed-off-by: Henry Tseng <henrytseng@qnap.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..2737e51cff34 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3734,6 +3734,7 @@ static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
 	{}
-- 
2.43.0

