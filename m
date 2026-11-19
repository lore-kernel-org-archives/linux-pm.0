Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086774;
	b=udDw5iI33gfxZ8HVP57CTU4G3in6hRVY0xjf6vuWhS+BphKysNur0lHg0kfvHgU6bxAm
	 K7wsWZblOj3gBzHbsMEWEZoUKLUPuW8xSi1taEcYKaobRZKI5wwECLFopc+k4DJ0I4Mu9
	 zRJwKk01TTA6ntTjzSW74yJzaIqWbtfzVDQtLij/BzJQ7hIRtDtQCbPcyNIpDNzJRELCa
	 qAK2aAoo4yqoXQNwQv7OErAXHrTKjasSmF3tQwiLyJbfYwzbi+OBayiYMQd7GkwugfoNT
	 dHuiLv5XKE/l1v8PaU58xLXUiQS+/aZJ33dPb87Eon2CWGh3qLny8zm7Ff0lFMgnR/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086774;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IT8eYdMOoDdmYQGDflBtbgLSwLUT9Vzt/ue5D2tZIog=;
	b=ObxO1QSV/3lx2Ki9SamFqkKgsKwFjEadZAHCj/t3Ab1rQGot/2MXr7AbM+hkLyEUdVh0
	 koH8njFctJEmRlW78IcIXNzQgxcY24FGAYKX0U0Rutnc3AZUdbbvm+F/a6Tq9bpcXNcym
	 DM8DWaUrrlOxMwMQTgBHCcsTD37DiqLvZ5pYAf8HIiN5+qnEvX1FKQuP/HrPhZbiUOHyy
	 bereGInpR1d0/ip2Ymt4XnPjx+lJV/D+5CCC4Qz4cP4HV9KyZNdhS69mZYU3o2uaoD85O
	 ba5myV3Pk/RYFDEUEnis86mEBGCwyc+64gZz6yupQbuIzvOhFeu5bb+BPgzDAScxyGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kPbLRZGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.13
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F2606A326;
	Thu, 19 Nov 2026 11:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kPbLRZGz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBVBKASaHTfegT5siRjMai4freGBRZgEND4BdpfsRc4qRpryLS4S/TGnrfxYKcmiKSBJ4iFHmMjY85VdUw+u4DJQSWKC5+1crsNIJyngJ0QYFaccm9rDC7LBGORoHHxo455UY7SeVAZSZm9gLm31ZKOStBgR/bdhwENipeD6hdLqR0lUzGGQ/1MTXZBIHH8dHd5iXyHK2tkWk6OXsada3z29EG39rPuS/waRU6HV5sVM11/3WO9iGOF8ACb2LKKv7gJwvKHMT4JKAt/57YHMTj3qzjNYvzQFEBWJ3MkhS8Fh2WmAFXxgQ+/54TxCaS2Mq09f86W4Lp4IT26X58Aasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT8eYdMOoDdmYQGDflBtbgLSwLUT9Vzt/ue5D2tZIog=;
 b=NZP+BzxTDGWAedZIMS/7H6LVZuKatuBdqi4GF3Hf/fnkSqKCePrIT+wKQFE/dRfVPhuSMCgpVLdL73MKcPa+enWz51SctT/0pWj9iYRrSApUjiE/Jlr2o62XGglp9GE8lES1STm3ekr2V8z70Mb3LLW5vs17KKCzMv9/YGXX4cbQsaYnFAf9zKhl8eb5tJI3IQAuSb7rtr/7662aF7cUFQR3QoH+88tJH2+k0zXjQL/OjmocKgg/Er6CzLalpxfrArlM0Qep2Sd6Co1nKE9sO+g8zmKSwAP84eAg4XjZfziES4fYoTB2XYBv6zaQ33h/V2yW3pOG4EtyND8J7FNeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT8eYdMOoDdmYQGDflBtbgLSwLUT9Vzt/ue5D2tZIog=;
 b=kPbLRZGzvg3lRLlDKF/K/HQQ8O6ENbf7Uq7vjmvT4VNJGsAUKLYaWq1jCgwXzcB6QqPGVAfU9C6uz9Sp9GHMdqf8RXz75ndPVA+gLqlMIEqst2O6rZu3grEUjO0t2DMju4JU+lcci7ybFdB8p5asiXdzMnLEBstpiui3UZFBjLccf8LExuKz7rDz7VJKVo26sUgR+sCMzAaRXC0MBCaOx8pKdqxso7XtWTJs4nO3x3B/pGtNcPhWzfIYQe/5EONyjvDCViOpmQhW6SByH4hvKWsRqZJdEMimpHWwsbkX7gIy92fjcW3zvkcD3waBxLF8md6ErcNl+AqBsaewZALfCg==
Received: from CH2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:5a::33)
 by DS0PR12MB999312.namprd12.prod.outlook.com (2603:10b6:8:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:12:46 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:610:5a:cafe::1b) by CH2PR08CA0023.outlook.office365.com
 (2603:10b6:610:5a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Thu,
 19 Nov 2026 11:12:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:12:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 03:12:24 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:12:20 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
Date: Thu, 19 Nov 2026 16:42:08 +0530
Message-ID: <20261119111217.902071-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|DS0PR12MB999312:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3a4a7e-3697-40fc-3930-08df462e0a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|18002099003|13003099007|921020|11063799006|10067099003|56012099006|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	dYXmu0B082BXbEHf75dn3ESSERi6NDlSJxy+hqnyP64+44rl6ygYU5j20nUIuzTgA9Dak2SO+ZIrri0A4K/Fr0+Tbk24Uod2W5WL275YKWJYi3jssuJHqWso3MOuDcexw9earWqMhOn3VdmI/fvnVPP7VzC0GupO5//jGMW1ZwJfjOrlLjoMF9NG2ZcRpOH/qbpnH/vkToeAA1V2aEiQQrVkP45pcopZyaWnbptVFcsfRqqXcpBpxPjp9C3kHDKVyVGvcTc8LOkLg0gN64XQm1BKsggSyWaaBD3RfELLK6jOxHYGrBdPNzDhq5iPyEj0Pic9DAsVPtpTwXOgjIjE6t4biWSwBuhvH93X7Oq1Ph6Xjg/3hw5FB9j85aQSOs/Se6o7NgHCDkHgGbOm6NMfP9KdevymZIPznGbbuvEL6fJO4jZEBoQHRzkc8hIrMMxs/WgmXsDYFrcB+orNa4FjZ5Cp9w21hKakVvJAKeVd7N9FLnlyT/la5rct3lKDZ5oLh21nS+l2DTKI3yTzIiaJhDLYvTZxobSm4FoC2WWEF7Gju06BxoAIHm96G3fBpNK9hT4I90FYQ4GFm5AQcHGFkOOSJ0LM7Uo1l7F6yPcVAke7DSy26gh9DYkiz8fdBMBmIVfIYicD8gf1vNivte9Ph9jABlTWNML1ztVOSRy6r7HyCaCXpRjeCWghy4Url1wZfL0yU+Dv7u8qbu5KbtDicS2Arc18cc1FRIXUEQ0F68xENWpqEE8ahpI6DMo+W06I
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(13003099007)(921020)(11063799006)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qARilR3/V9/1umbhqxNRxY6x5HmLREOmAPc8QHSzoDNF/qJyQUZ6eUsJbMJ4ty7jRnd7MgDLYTeRQVMdFEtv+bXkcFxictLajY4IuwFeDZ1JN+SMSAUCqcy8Or2ljXYsUGBwms/4QteYEqI/Kv8O2DZDEwDs2UpPgGHYrOX60EswW7MfaJUticibyP35qxq+tsrppwDEgkdcFVC7CCzBWTIS1n00/hWVbPjKDiXk3igVPj/MCQvB2KiBLT/oMd9oh8RpowD+1+BKGPviZF49ojgvte2ixNeoYE9VW6J4fgv5OGy+6CO9wkPgNV72hqUCG7MKzAHWfrmJGP1uyYFYM2UKfVEIr2JiB8odZJh69+8/cOJwACBIBB8fYAaPnAPcej47cEwnY7455ODfMZ/dQGWI9bglNwl8Lm4vg2PnPzGoj3NSNubI/o588ekDO/r+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:12:46.2993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3a4a7e-3697-40fc-3930-08df462e0a46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999312

This series adds cpufreq support for Tegra264, which joins the SoCs
already supported by the tegra194-cpufreq driver.

Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
The driver derives the current frequency from the core clock and
reference counters.

The main differences are:
 - Frequency read: through system registers, as on Tegra194, but from
   the 64-bit architected AMU counters. The reference counter ticks at
   the system counter rate (CNTFRQ).

 - Frequency request: through MMIO, as on Tegra234. The driver writes
   NDIV to a core_freq_req register in the CCPLEX register space. Each
   register controls a clock shared by two single-CPU clusters, so both
   CPUs form one cpufreq policy.

The patches fall into four groups:
 - Fix (patch 1): read each CPU's MPIDR from a CPU hotplug callback
   instead of at probe. A CPU that is offline at probe then also gets
   valid cluster and core IDs.

 - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
   to make room for a 64-bit counter and for an MMIO mapping without
   ACTMON counters.

 - Improvement (patches 6 and 7): group CPUs by the generic
   "performance-domains" property, which cluster-based grouping cannot
   express on Tegra264. Device trees without it keep the existing
   grouping.

 - Tegra264 support (patches 8 and 9): the driver support, followed by
   the device tree changes it relies on.

v2[2] -> v3:
 - Patch 8: read the AMU counters with interrupts disabled (Zhongqiu).
 - Add Reviewed-by from Zhongqiu to patches 1-7 and 9.

v1[1] -> v2:
 - Patch 1: drop the cpu argument of get_cpu_cluster_id() (Zhongqiu).
            Check for a bad MPIDR in tegra194_get_speed() (Sashiko).
 - Patch 7: check the BPMP table in tegra194_get_speed() (Sashiko).
 - Patch 8: fail probe if AMU is not available (Zhongqiu).

Sumit Gupta (9):
  cpufreq: tegra194: move MPIDR read to CPU hotplug callback
  cpufreq: tegra194: remove duplicate counter sampling loops
  cpufreq: tegra194: add tegra_counter_delta helper
  cpufreq: tegra194: add per-SoC counter mask
  cpufreq: tegra194: split MMIO mapping from ACTMON offset
  dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
  cpufreq: tegra194: derive frequency domain from device tree
  cpufreq: tegra194: Add support for Tegra264
  arm64: tegra: Add CCPLEX cluster node for Tegra264

 .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
 drivers/cpufreq/Kconfig.arm                   |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c            | 456 +++++++++++++-----
 4 files changed, 387 insertions(+), 121 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20261104181521.3003578-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20261117154954.625126-1-sumitg@nvidia.com/

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.34.1

