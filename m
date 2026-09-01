Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785046A5EC;
	Tue,  1 Sep 2026 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299978; cv=fail; b=rqA/enR10mW3VyebU9xkseitj4a6357MEH264Lnid1wmkwpoQS5L43IhaqSzzDbiCQUsIGyh2pcQHZga8+M2pbAUDDY83N6FE/vopweMjGa5+0axj4oPJdavCbU1fy5DxHuAo0Ua5DxYyYVhGaX4ecHhQrXmfTYRgqwIceDsUak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299978; c=relaxed/simple;
	bh=XDLwZROMSiHlUQpb5wp68clb6d7HZ+eFhwCVJc8VNQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxUl0jIrY55JAcxtvMiSaP7Uupw+EnPqJovAoH19om9RIO5iC8zonyOYm7Sp+Bpx2brFXbVmkWEm0BVUJHE+u/W3yb9DnCwYUSz5h8Ov158p+OwO9Uv32eCqPPdxIkgcAqx/Mk3N+3lfhtk3kub0ScUOFT084kGPrYV5EIFoKfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bBxCDF6p; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bBxCDF6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbyGzRvFSOtG3eeGa7QQtOO9N4ZQ22KMg3+ZspU9zwR0ebeqG+elNBuQaXsMuzTk8hTpKzUscqnG2Mw2okzhPU5IcVAldqQDh9OyTQRie1Gqwa7+HoUlNwNpLlRAFxff461ugr+PjCaxLoGJaqACxNSyt1xfjdnndcjzvDCoK8OACCgU9QeZ8d3R4CCSK3P5FawulFUYKSmKYROxai/Daq6R4DC91DtNv4Ybk4T1j1dB89YewPRNv4EuvX1x+uVFvvi9GdnFAdmUhKGx3e783FQUPTMHOTbsF/p99+NsE+PbtURCm11tawwGsNQNbsmkJQlZKzOrpdXd0wcgFBv1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHQJQKdY7OdxQ0oYqBKSPWq3RmFiQuHxt9ms6m/H4yg=;
 b=YiHUcGnJmjOXL+6HJn1WMhl4rrCeUoTSSHKnR8M68TqheKJqbZ7ocaY1cCjA+kmiflvGzMW7lZAxJEN0mGgTO+Tl1TqUtuZfQlln/cOqMcch5LgyokqjyIjL5wLbyrmXi0szybodQtZjVII5YuSKpne6iJ84Fcqlje7CVD4zvVDgKA2r4EB2PDDprbTxsJ3xkVhpfXmrvi3ISyrgic8uSKzi9QIJKPh/RTE3YTtHcsBwZHsw/pE3tvf1rMoy+jvk2DLHRViQ9S0+ewqGTd99eZzKbeJ7s0S8qyW5dEY5Im64p+DogVDo+5DK/y6aENtZmM3SbZkRRv4nGFHvCU/zCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHQJQKdY7OdxQ0oYqBKSPWq3RmFiQuHxt9ms6m/H4yg=;
 b=bBxCDF6pjtbnRb5Ke3qwJHu9M5F+vyNat+YdDu8vgf0cO6IK4Wn1rykRy/3qjaztgd4x72zk5MAOxz5tEZa4OQzooumA51bG/rbqdSPSPySYtFHJsPiL0IimJSZad8oSdagtJl0yARYva9tkeC9yb2kicQeJmrsx+3iMWIe8Rao=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:59:29 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::62) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 21:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 21:59:28 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 16:59:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] cpufreq/amd-pstate: Get Highest Freq for a CPU
Date: Tue, 1 Sep 2026 16:59:12 -0500
Message-ID: <20260901215913.3042182-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901215913.3042182-1-mario.limonciello@amd.com>
References: <20260901215913.3042182-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ede249-ccc4-4c70-c63e-08df08744bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JDQFSp/4/2uwCgZizbGziz2NixUjNCT0xi0VcuX9VJcRFuQ9sXdxDAk7e1uTfjq8rNyHCUO3uGOXtOn3cf6XpBTJv2Sc97NmA2s9GQf18bAT2aJzmOrPObqUY5J+JnCq1Y4Gd5oEqb1d+kcjBHHAxisyvrbCmwij+q1eMfLb1GmE2YX4YMQSDMDOcobkkVHglXcHPHFdd84i7hSClozzUSMUi8OGYfXYri0MZWKi9rp6gFHEBfU2abZCeQQKW8uVbdjLySkO7azL3xuu6nDsJxHWw6r3mRYrwAhIzCsSUIGWZV4Aqk+6hKtU9tsHOITHV5y870KoqOLEipvys3x8CMHF3oEhF6tNW+gdzVbUQ8mgKH+dH1Azc8BUCBMFQIEeqHrpjVxxm2XpUZwEr+XmhkNlhFxkrIag3vQi7acEBjcrl0UJD45YLn0r/6c8SkXJHbSbMAYu6kQGB7tJAVFmGuFuJRJPUVPMq4tq9RxGrYUKUZrzDpAhyfAkxR1YQOnt9I6085aAImzxuivn5WoSj/gv6mWQ4mjRUDo4evPTKH8+AYJpEQPXUjwEtDmCEUPgOTUnTV0yNDEqFQQyjz5UPzMS0brIhWacDNbdCIZ3w5KSxP3AQ/niMuSeJB+aptFYawJ2FIUfMksVzgM8MYboPRxQuirOJtkNr0fJh44OSOi6ctGZNHH9XpNglONY6VGH0Tj/0/NX3vK3H7AZDCYnEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZyrR+j5wrR5eaGrKBp8+2BHYOWUMDTZayuiHTYTx7USXDP2YcNrCJ6ZpadypAKwEjWs7BKgv7cX0NmFHZq3e+7gLgq+Doi1XkPG8seaB04ZMwBeOVIZP9MTAPIUdk6vNIKzwdFUVjqP27TCNuVlfgTI0QoTVGzwa6BQP0AYJydeDioE50g+fQeDhzjrXY516sQlmh1N9mIeAVDW/582G6edrXi9wAV1oWZvigmus/x+R+SGhHpoBRY2moLP8zH8PKmM4Z0ECQ8OJ0WdC/kMRa7VGZYHTm+d2z1EDq55BmEVHBk7c3qGS33TltENRCEcxj8eKOcMUMFa3MTn49OWLOFmqSe72P2GVQnZsmb0VqmwPY44VVYjmRf9OTyoWxHk/gOtmm6P/UbQp9ztha0PCSahY5/2jipxlHWvCwBxf3PGBibS8TUSMhxNz9PB4Qrl3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:59:28.8630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ede249-ccc4-4c70-c63e-08df08744bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

If the highest frequency is known for a CPU, use this instead of
trying to calculate by linear interpolation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use fallback method if no BIOS/quirk values
---
 drivers/cpufreq/amd-pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cf2d67f09fead..dbe08420b1df7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1133,8 +1133,10 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
-	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
-	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
+	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
+	if (!max_freq)
+		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
 	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
-- 
2.43.0

