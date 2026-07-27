Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47083DCDAC;
	Mon, 27 Jul 2026 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136920; cv=fail; b=ngP6zuMIbIMlNAvvooYFtduuYMVGQ32O1jEHyrGquDF7ohTlO1ImyNn6ve0NCHy1/nzpPKwLMX34Bly6xEK3OIXm++VqZ0UTH8zJDg9UTEOz/avaP17solVewKZ8+1P57vK4ErHo4oz68oiE9d7BriMg/riXqVfiKTCx+pW9kYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136920; c=relaxed/simple;
	bh=fRwUGIr7l4Hf+zgjpa9y3L/OxDe6l7A3Ie0KfbOj1oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8k6o0/piYM8+g/QF9QZt+NwQmwHEcADiRjW1o671W2BzAm83ZsNGDrSeXWP1ATtJq+uUkvcDea9EtJ9EPHnxc2VaOHupyVMQVWyNc/nBljW2HPEH4hMX0/wRsLG4tIkNPDIVIzEtWb1oYvgVcJ6XmY/uhY80M4pn9sNCClyeas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7tmq27O; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7tmq27O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5HSgrcsR53olJWWoLnVRlOEzQuUKBFimWOE7U7bMs9YxcgRk0mTukJ+pCIW5VQYnCPjJd+YPnzx00tzkeKM9dYWDEMwB6HCdcnj1Icil9mt4WhCDSmolzFf/v+HkmUjEHuDp0EyxsTPw+42eXb24rJnbMzicbBM+pp1bxVNfDCT/adI269pVyAPFZGONqAIgv0JxIV7bHhsnBT/m35/yKYnkl62n2vxRjZfeRrgIlFWlgbZzcmxSXv3+kcLDcIwaUzBmc4Y6bun4+1xfjEk3mfVHK9WzGXWTSvaPzSM6AxcD+ywcFvZt4JomkJ5VMlLeej78/9iRBcC9T440uZe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMaipAgCyi1RX+zhbZlLDsqmCCYPFZq8Brj6Wgy/53A=;
 b=RlinWZCVQcH06cGRbBBuGf7R17E6o4MZyQ4ipSPcbes3/ZxHNvOqK9/sjOYDeMBRWBa60NEqzj9XmQDAjS23z2oJWV7ISQmJgK2LNxROYfGdmUS/cfWwGr7L1gLwoGu10FKqnQrFuAW6TNdpzwIvQLaOGXXuxZR+d2756u54eRzoPOfIqTb/XvOAUslSnF1hSRAZg/lE79uiX6KXCyp7QWEB593nSScGS9a2Esptt2gQ9CAQq9eae9hdb94LdRxYzalursY8wVeyuJvu3ozGGSx3dUzKmPV1bog6b5Pm7QnL02QDv5aGo4BYdv7EIc8uyzyJUpBa2jkaecINgX+ISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMaipAgCyi1RX+zhbZlLDsqmCCYPFZq8Brj6Wgy/53A=;
 b=j7tmq27OqMItMtXIj9t/ytFk3sdZywvz6DnuugWLLQ81qYVuq9jgrSty6jzdT9PCTJ+x5rehh5eKL33YiZeanB8hDZs6U1mUOBXYbzAJKl6ZyspcAXj3G7hvrZ6Ro9xX4FC2yKsO8IJfxDQZA1KEHkFVwBAWK/onSf3x+avEMQQ=
Received: from MN2PR15CA0059.namprd15.prod.outlook.com (2603:10b6:208:237::28)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:21:55 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::8c) by MN2PR15CA0059.outlook.office365.com
 (2603:10b6:208:237::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:21:54 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:21:50 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 2/9] cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
Date: Mon, 27 Jul 2026 07:20:49 +0000
Message-ID: <20260727072056.1248-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 493ef923-3640-480d-bfeb-08deebafbc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rWTU6TU2cL8Ckhm1mtE+CPHUaRcsTsrceiMA+qjcxKnDvcbL1wKvV7BRlzVkILCR9YabBR3nTy6bku45yfHWH62LMqv/udEN4KVIEuvs8tFxTAlhMrVwV1H0neoJmdLyGKKJ2o8qGh85bShX60AOJwO4eyHrFBh8BMELA/HVW06PasFLIsdy/0rAQt44MuimzcMrsr+10wTS0yET1Zy+e1Jrj0aJxkmd/CFQwcl5uf8pazd4iSVGctddpEfR+9uFQsC8cBznihvdB+r6aWt5IRF9dreTlu0YLZyC/cNhdgD7jsHtz9f98fEpsU7bo/lxOKYnPYT50CP0URViBsJo7AFCojkY/ehYrN0gsHpUqzw5PScUMKddExOkJ/CvU8grXvUdJ7k6LbFiFAuSkjXIAyXCGDXUsxj6u9iC6woHpo0pYZFkmyXtQko4mU54Bkt/c23P77hoJUi4WAEAFIByChpbRwBzH3kn13mgPk8hIhrt6uyInVLMjQLQgVsFf17LM7n49psUo9D6bbC7WAJAlo01vVxw6P3qlFGGz/yJ7Sp3D1B1MezOrS9x7wZnRZSS3WjsN2tAtcnytoujqd47T+JUkKJXbWxv98pHeH8mQWPKManTyRC0S+5fY1vj6N1HZa8oqpFNd4CcQ0didZhPLS1SvkYuS8b/HPUV2eatOsvMweWQz0SVpmGld0FQgUc0QJmSP7nyMQBpelO2QUPniw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n8aKMP60JAkQPE4B9OEXCP0u1lwue6AsTEyY6yahHjZF8szha1Ojl/GQ/XVbZ8h/cBaBTOBJHeER81xryIPH+LR9G6A3D1kVFY+rtoJiSrC7AN0S2jP+i/4UsrL8ufr2/pO/LfNN/Gc5Hd0WSiQ9hBlfGmdh3gRQmwiqMbA4lshLtNRB+FPsZuxnJfQmSg54M4WDJHtaLeiehA2UfxkNUaZ0riIal06PJF6iyCNrG7lfU0tvLMCF0Z2MnBpicTmsGxML6lcJ+JVdaSTU59V/f/iL8NU3DugjOWlMDo4yScD2OBF5iXYUefi4Cs2+2ka/m0S5fmK8mjd8HW/8vIolyY0UdStz4+OUol1X/Z9eiCT4ZWA7XeqKszgulIRjSTiBbzy7XM77meX3JKykhav6kxt1w6a/3PQQwNM+Oq9NN1kXUAIRpDAameaqxfSzSWwH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:21:54.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493ef923-3640-480d-bfeb-08deebafbc3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

Initialization of bios_min_perf (BIOS Requested CPU Min Freq.) only
succeeds when the driver init finds the CPPC_REQ MSRs to have all 0s
except for MIN_PERF bits.

A kexec puts the driver through the suspend path which, although resets
the min_perf back to bios_min_perf, keeps the rest of the CPPR_REQ
intact with the last value at the time of suspend.

The defensive check for bios_min_perf exists to prevent the min perf
from last CPPC_REQ being incorrectly considered as bios_min_perf when
a kexec switches from an older kernel running the version of driver
which is not aware of bios_min_perf to a newer one.

This scenario is extremely unlikely and Mario suggested it is better to
simplify the initialization rather than complicating the suspend resume
paths.

Drop the defensive check for bios_min_perf initialization and add a
debug message to dump the BIOS Requested Min Freq. to console leaving
enough breadcrumbs for debug if a situation so arises.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Picked up tag from Mario. (Thanks a ton!)

o Fixed unit in debug message from MHz to KHz. (Sashiko)
---
 drivers/cpufreq/amd-pstate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 25a179b89a74..4c608dad1b0b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -462,7 +462,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 {
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 cap1, numerator, cppc_req;
-	u8 min_perf;
 
 	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -478,16 +477,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
-	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
-
-	/*
-	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
-	 * indication that the min_perf value is the one specified through the BIOS option
-	 */
-	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
-
-	if (!cppc_req)
-		perf.bios_min_perf = min_perf;
 
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
@@ -495,6 +484,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
 	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
+	perf.bios_min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
 	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
@@ -1044,6 +1034,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return -EINVAL;
 	}
 
+	if (perf.bios_min_perf) {
+		u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.bios_min_perf);
+
+		pr_debug("Found Requested CPU Min Frequency of %uKHz on CPU%d\n",
+			 bios_min_freq, cpudata->cpu);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

