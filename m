Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359A357D17;
	Fri,  9 Oct 2026 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518445; cv=fail; b=CHqAO7d/yGa8OdKFldWhdkZFRaJveEvin4wa4tGu1DFpIP9OdqiPBqfbywI0uiZ/P0M0OscvrpRHNxfQXenVZIKB1sCOeUu/RsTm1Mb0qhdot/M1fwT3G0rrSQN4Abrq1prGW4+QHk5ewJ+8ujD+MA6ki16ogT43S/vLfuT6UCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518445; c=relaxed/simple;
	bh=W/FtfKXNk9otc2PcxhUpJR0gjsjSmbWWSZqcnil5Amg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TDxzXXpsemPTfssXvwAZtpRKva66+L3zNT7IgZvPLv3Ff4ah0ln946fk8Bus7SNh3CLWBpqQDKgkawqef77+LCEB6oOWp4gXxMrzQ65BUW/pehs8mdFXj/oEM0Jx/Dv28XcPUkhWbGaolKFebWYJlW/Um1M38z2pPG1oyEji2jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MZiLAJId; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MZiLAJId"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWxrlYB5ojlPA2+6nxTnNfwkx9vjEmvPm7zGtsoXZjCgb/NAtaMGFou2EDmsbTlPsnEo7/dD2Y+WiCLRn7Tb01wk0KWckD/Tm526cOHEJi+7pTYwN7jaixTpDh7jMBSa6gc3SxRLdrcV5ZQsJNUoW0dOJghJweaYI/6zgvJMRzprwhAfNL1Md+i6OZ2MQcczlgVYDOQxwHp94CIjFiN1DBlyWetJGuxGxfD2cGFXFVtmBOrFlZ6DL4OFNSvbFYbTm1LoMk2r1s/naHbgEJZtTj0CJUbLZa21C5oyuT/hg+gYP1KIIPuKfFFFqYkzcnWm7TGQt2uef2DZwK1J5TR+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CwMtfXsjsdoJFC0NxBg31b8ZuvRC7S7ZIXiaL+PRZw=;
 b=IsrTrzXRKKXHyYMtvDV46JAu5aBWx2+P+Z9KzpWGMgstj5d4KqqMVpvisrS7clyx/XSvfO7MBmKUQsmm6XIgpIrf5err6Ll7tI89JNgcg1bOl7GAZuryxb8LWcIKnwt2R6xUck2b7bgqU3ROxdEYMTBWwmvglLKa9Gknln9njowxklOfmvbxiuLPcWcAZuCMpPiFK9nuqamXzl2VieWDNpBebamr2i2JZMiB6QD7lCM6sbCJ55PSeC3CG2hsMlf1CpIkUojMzJ9IybfMYhvgJwaWBSDcRa90YDpZS9LoKt/406fRwubn+jSJdUH5zMlmjuT38Z/9Q7WVOLvsmDLkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CwMtfXsjsdoJFC0NxBg31b8ZuvRC7S7ZIXiaL+PRZw=;
 b=MZiLAJIdWjpWpBhNRuuHB1MxnGtW6K4IgZCdIw6/gvYNgFsX58b/7jeTiA2kwi0xVVJz2v10J2mEBw52kWlE23Ha1Oh0FzCafi/xImwvVa8BRhO5qjXdlQu7s2vHu7miEzlh105rcQNG0acNOB1kiFRlUG+uDheG7f/ScpGGN34=
Received: from BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::12)
 by CH4PR12MB026689.namprd12.prod.outlook.com (2603:10b6:610:506::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:00:31 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::71) by BY1P220CA0050.outlook.office365.com
 (2603:10b6:a03:59e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri, 9
 Oct 2026 04:00:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 04:00:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 23:00:25 -0500
Received: from xhdnaggolla50x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 23:00:21 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
Date: Fri, 9 Oct 2026 09:30:11 +0530
Subject: [PATCH v4 2/6] PM: runtime: Add pm_runtime_if_active guard and
 conditional variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-adma-pm-fix-and-per-channel-reset-v4-2-55f5fe409c55@amd.com>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
In-Reply-To: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Michal
 Simek" <michal.simek@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Tretter <m.tretter@pengutronix.de>, "Harini
 Katakam" <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <git@amd.com>, Golla Nagendra
	<nagendra.golla@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791518416; l=3597;
 i=nagendra.golla@amd.com; s=20261008; h=from:subject:message-id;
 bh=W/FtfKXNk9otc2PcxhUpJR0gjsjSmbWWSZqcnil5Amg=;
 b=O24pGi5SfDFoJT477thCqrJgC1Zub1cvoFmYQ4u6mgcuD+LJAwEysDG9kIuA6R5wqN/AbKwxG
 B+r+f/DgdDRCytHEhJcw5c7QoQJ6IBkZpYptVsY/kRH/rj6dMPS2k7h
X-Developer-Key: i=nagendra.golla@amd.com; a=ed25519;
 pk=pCRGj/0mb0C3aDMpVVZeyBqOIQZUKGJjCKL4QZTu7nQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH4PR12MB026689:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8d5b3b-45ca-44dd-f577-08df25b9dcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|10067099003|18002099003|22082099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zQBcyZ/DYrZ5Ai59LpYwVL1d4XNC7TgYW313IFqqA1XYBBocHYWOKZGLec2VUPl9A8ScnYtnyr9ch3/F5JTiARcWx8F+GAlSeKDNmcNPZXzzLkAkJloO+e5uR5kkg6fuUk/FbTTEE8n++qj1JjyddF9AKnZtF9MCTmupBQu7cm2NMSx7uvEdo8gZERykUIbvlmVR91yN0D+iG7CjXnwVj30zjyysURbr6/amD6KscaKBxj735/l4SbIvAQRCG1dkrqSozv4FwBesk9iMGMtHrDYQzirq6tPU9MTRl4yuQJANb1GdPQB2ma6dcgTfrMDXfdLTmdcMZ9O6ytLX5f/6oH+zeXjEmFigPbMr1MitJqYId+ByxbAkOeOHUdOZ+7ggIaxKebJZpb13opp/Sxxvh+qfHdj/jlGfsc2/LjFsf0lRXN11PpfRyQ0sZ9/Ja97XxX/02OQhKpxDdNohxgNQcmlK+CJunFMUkp/KC20RJjArTV3GvaF8hpC+6FdBgDRYHJNzOT9RFYU8LELmC5h0b87FN++3t7+N+klk4HtENWwjQgUHqS+hnItlOEO+E/joze5oala1ykEU/BWOnvQj5SRBmhDUNgR4Aw/8YNJ5T+1nCVGg6o/aGs9serFbr8rKnsDiR4PvEjpPTJkXJxS5oX6b6nhaKHlEErGITmcq3/c2XjVMmEn5c2+AqPtEj3f5DcH57LIMJCH/3ZOuK+fpC4HbZgMkTxX10VN0PefaBGuMMGDksZu1X0Hunmt8GBha
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/pJgerksaHongF/5yoFXRbIwfpu3SK2ToNG1npz2on/vewr8+gdG+YcPdkVjDrUJHoHylqo66wy5dhR515YBOOURNdurm1US/vlp0zEE2UlF0GoC8JfHgRztefUPSpGWj7lj27zXDHAa4dRuEoOWdo3qMC0aKhduehxPMUjcHC/HrTJv6auTohJsSeQk092V1GFd7nD1kSOt27zTpXVqWWJIRXFNv1Ns6UyRxnaJba8kph2pw23WxuB8LR1kgqEx5bCl+HGo1aeXOKJYtck/1HWAzx9BtRl4fGS3UJPVZVXucuSAyuWKoQFCbV2yKj+pie+R2G7bM1PUGymDZ7WR0RwjLgJJ50wwZbhI3Yf79UStajiRbm+N9zSdVk6+qGFIhnilw684bSIUczxMidy69Z+etklMSFII4B09cnPf16lacH1dMhPjjDFmGfl3Sb0Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:00:31.5201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8d5b3b-45ca-44dd-f577-08df25b9dcf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB026689

Add a pm_runtime_if_active base guard and its _try conditional variant
to pm_runtime.h for drivers that need to conditionally acquire a runtime
PM reference only when the device is already active.

The base guard must not be used directly via guard()/scoped_guard()
because pm_runtime_get_if_active() only acquires a reference when it
returns 1; the destructor unconditionally calls pm_runtime_put(), which
would underflow usage_count on a suspended device. The base guard
exists solely to back the DEFINE_GUARD_COND _try variant.

The _try variant (used via PM_RUNTIME_ACQUIRE_IF_ACTIVE) satisfies the
_try API contract that guards must not produce an error when runtime PM
is disabled for the device. When pm_runtime_get_if_active() returns
-EINVAL (runtime PM disabled), the expression calls
pm_runtime_get_noresume() to pre-balance the destructor's unconditional
pm_runtime_put(), then returns 1 so the guard condition succeeds
(bypass). This mirrors the behaviour of pm_runtime_active_try which
uses RPM_TRANSPARENT for the same purpose. When the device is genuinely
runtime-suspended (return value 0), the guard condition fails and
ACQUIRE_ERR returns true, allowing callers such as interrupt handlers to
skip MMIO accesses.

Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
---
 include/linux/pm_runtime.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 64921b10ac74..ae2a8740ffb3 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -609,6 +609,13 @@ DEFINE_GUARD(pm_runtime_active, struct device *,
 	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
 DEFINE_GUARD(pm_runtime_active_auto, struct device *,
 	     pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
+/*
+ * Do not use directly -- the destructor calls pm_runtime_put()
+ * unconditionally, which underflows if no reference was acquired.
+ * Use only via the _try variant below.
+ */
+DEFINE_GUARD(pm_runtime_if_active, struct device *,
+	     pm_runtime_get_if_active(_T), pm_runtime_put(_T));
 /*
  * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
  *
@@ -624,6 +631,23 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
 		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 		  pm_runtime_resume_and_get(_T), _RET == 0)
+/*
+ * The _try contract is that no error is produced when runtime PM is disabled,
+ * so bypass the guard when pm_runtime_get_if_active() returns -EINVAL: take a
+ * reference with pm_runtime_get_noresume() to pre-balance the destructor's
+ * pm_runtime_put() and return 1 so the guard condition succeeds. Interrupt
+ * handlers then keep servicing interrupts when runtime PM is disabled for the
+ * device or CONFIG_PM is not enabled.
+ */
+DEFINE_GUARD_COND(pm_runtime_if_active, _try,
+		  ({
+			int _r = pm_runtime_get_if_active(_T);
+
+			if (_r == -EINVAL)
+				pm_runtime_get_noresume(_T);
+			_r == -EINVAL ? 1 : (_r ?: -EAGAIN);
+		  }),
+		  _RET == 1)
 
 /* ACQUIRE() wrapper macros for the guards defined above. */
 
@@ -639,6 +663,9 @@ DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
 #define PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(_dev, _var)	\
 	ACQUIRE(pm_runtime_active_auto_try_enabled, _var)(_dev)
 
+#define PM_RUNTIME_ACQUIRE_IF_ACTIVE(_dev, _var)	\
+	ACQUIRE(pm_runtime_if_active_try, _var)(_dev)
+
 /*
  * ACQUIRE_ERR() wrapper macro for guard pm_runtime_active.
  *

-- 
2.43.7

