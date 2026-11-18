Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794972497;
	b=Zrksmx5r5G54GaQYw0lZ8Z4khD3/lPVnCzN4F6JHHLv3WPco2XXHJX+ybfQunRvQr9KO
	 ZVM7KLCbm9FluzIAWhpDf3tS5Lbg7sBhfha1RgSIabuv31Mk5b1XPX31rOi8OqaUABfie
	 Z7IIPVfuP5abGtFOSOabN6yOxzOp2PTDfrVoqqpE2/Nq+Hryz47tSp/QE9gVJ0fIY414D
	 P1IS55WH22cVwNU1hjFyu/grYW4WixYe0RCU1mJUxGB2moGeKui4tfIdNpLRJ/gBhcpP9
	 ovugLpXAipMOKQIcqp/j3NKgm8oKJe0rgQlTFTI24wv329Vp4WSpVRhDEl+zJHSBy9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972497;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=zGxI37+ueK34tspBmcy60HP09a3SdEueG2W5NG1v3bc=;
	b=v7crtdpOtb37ubSvcgNlOd0oAF4olx/8IxaALs7RMPmFPAoLQ25dSjBgFVGtYbSfgt3V
	 NxOXxW+2d9SJCWoW0kROBtDB7FNYxqGYgkYt5O+W6PxPpLOk2oYBJh/q6zyh5VCd3gIu0
	 lr1APdOOw9ovwDa8CeAouFKulZidAteRwmzD+SFEO03IgxMmhwHxkEIAHA/rW7awTEsBf
	 iyZuS1VFnt+6evXxSob43Xkk54HJKK0U6drcQEAM9ivqZcYEqm/hIyeq+TpWzcUjtUprY
	 72aNFDmaoylALHsDk3Dk+VACT5uz7YdHEnJNZ2FRziG944Q3FAM9jwutNXiNbJOYKag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="WOD7dV/z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.21
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B10606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 03:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32B10606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WOD7dV/z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAL5jcfZmfVWmiSYaj6HywsP7yGu6w4CAJ1tA7VvIkBNTbvdFgJZtQ/35uj3mT0A95bpqfxKfHafpSI0akIP0Qo0w8G2+puQr+Khfke9Ig/faaPUmfiV855u0GiPBw5tiIMN15V0u+EuJ3lPIgj6i6hmo7jL6XpYZTiwNKUU5CAqeosYrYf8AdZLOep4w57AAn5TN2U9tzupEkAqwLv/ffwCre3hand6kbMvK0O0Z+9fo6Q9wnXMQy1WRJnHyp9s9QDCaxvoYH3iTstZOuCwA3MwuL6EDES5YhDP5+z7om22nRXV5mbEX2RwrqaxPO+CEgTjYLtXPccEHnswju9Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGxI37+ueK34tspBmcy60HP09a3SdEueG2W5NG1v3bc=;
 b=VsStAKrVau8AApKUSRqB4AGojdtFISSIuQ0NmwwYpfzlnHDuQa9WPqt4GH4Ih+psK2JKDnnWC8OLsIWctVvr+307WjcuOse7psKftxp7CluGO+X/lnn6jle+Y5xUF6Hb2K5nKu5TsXAwEFjEWZ6NlA7ODE01HlzwfLca+NzvYUF1mPrnVu/YFQeCy9XPf3gnqSwNw9mdyDTD+pN8GM1TENBitVRKszjhXqP2aqUiUDWLez9+20S7X0UplnS/g42BgyQx3qS3MoQ+NIxvRB8UhMr2GtfSRQrjnoc5zVlljnGoYxd5jX77M6qC9619RXnjkc+nlopnIbUEVADm6USFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGxI37+ueK34tspBmcy60HP09a3SdEueG2W5NG1v3bc=;
 b=WOD7dV/zXFJaGKmdiTB9E6iq8VJJZs9bu86sAnR1a9Kk5grSHc/PH6Ff74Kjd2VS0P3E0PqNtsm1OV3mE3voYvdhlBSn4nQSDEp6XvaQqMvROqWn7yXZTPN+LrrLm+NBz9bB6X8lAi/iesgr+xU6zNv1PnR8NJ9C6ZN8LE7PBTs=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 03:27:56 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 03:27:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 03:27:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 21:27:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/7] cpufreq: amd-pstate: Fix a batch of correctness
 bugs
Date: Tue, 17 Nov 2026 21:27:46 -0600
Message-ID: <20261117-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v2-0-2a0048f563c7@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIb/WoC/6WOSw6CMBRFt0I69pm2lAKO3Idh0M+r1MgnLRAMY
 e8WXILDc3Nz79lIxOAxklu2kYCLj37oE/BLRkyr+ieCt4kJp1wyxiTEecTQMXj7fl7BKW2kNhr
 qSiAIrUrQuiiBcmNy5WjlUlLbnAulqLC2IGl4DOj8ep4+mh/HWb/QTMfT0Wh9nIbwOa0WdvT+E
 lgYUJAVV+iscGjlXXX2aoaONPu+fwHUKi1CBAEAAA==
X-Change-ID: 20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-9d324aa04dd5
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0984c7f2-b06d-46f5-b341-08df4523efd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|261009221227099003|261009223027099003|13003099007|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261022075727099003|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	H0vNaV3qWbLLcBxMxtIzPtXTe/pCvwS1kjoLaE6Ac3a4NPc2nJNnLWmEXeahXkIMOnCeyR+MvjiNeaqm9Gwi6/NIElY74k6PR1gI3aNMnEmNQAShrn/RdhxupnqXC4t6uY2HAOvsxHz8IYBqkPPg/REdG/+v8qXmqkF4BElXLi7Z4N1r5QgkU+4LUO8dFCD4KJZevOctboLh5x5c2asgu1Ry1aLzr/fBVoBnnWsXBNTHmyprQNQW+F09LDa6AawXHOPxIhwiOXmDd0kso+gL068VS4XGrvbFe11RJ/kj4MEszT2Q2gG0cfwj2goRcsh1rmT0Mzo1qTVOQRcTN9rJ7lNgvsS4fBA3z5jchaowudjIHbEgwiQv+bV/IagZk2yLHnFD957UZs4EAz0StQeiMiGJBlMF9Yi80g04Y/nqEuf8ZguiZV09mj919F7eOimWmb4AvacqCh/r/RE1qSefwiWRY8rGJDKVOveq2gWicq+1mvr3mrqEZuNMlV2rcNDNTrbsE0hw42Z8Oyo0FkcrubHdszVDzD/iPq/IPJx6nWGi3xMvVREkJteccHWA01/5FfsmUxC4Stma5IcS70thLFYfslhObSEZnkfn6v66BjFYwphEr642L8eN/90EDSsjt9QOXvDVF24XWnHZt6VB2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(261009221227099003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261022075727099003)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H8K9MtuS+DVLWS446u5EFv3y6A9xwNoxFLPPUf0+OhA324UN9KCa6RZy/eko73s6JHaaxDyohWFaipxxaLfV9F5nshcZcTnC4CVjQbN/ruflxVP7GUp0/kQZeTLopqd0RsCWip9i8bPDEFJGwZGt5LB74RC30qsqR8AHSB4TP/7ae9Dm2S3a6a85tIW+5GwHeEyScWVB/aJWqgB3fYvgFKx/48FFxze2gxe5hYXlD0I9eUmvySCsiFUDjRMi3lDqT6GlWoDb/xEbULaDePOtxGdTA/fJJuBni0mMJeT7jNnmzAkHp6U4t1/jtajZ+MFI1++xhSxA1X1deA8H3Es0ktSq0SiGsO7sIw/XciYdmyBVTW8x+q3GLkU6eHBRP/tsgEHgignphsqCISCtka+exnaOqimSPiKmUdWtb3vj8P81RyuRP6AIGT+azHTYou05
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 03:27:55.9071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0984c7f2-b06d-46f5-b341-08df4523efd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

This series fixes six independent bugs in the amd-pstate cpufreq driver
and its unit test module. They were reported by automated code review
and each is fixed in its own patch:

 - amd_prefcore_param() dereferenced a NULL string when "amd_prefcore"
   was passed on the kernel command line without a value, panicking
   early in boot.
 - shmem_get_epp() applied the bits 31:24 mask to the unshifted 8-bit
   value returned by cppc_get_epp_perf(), so it always returned 0 on
   shared-memory CPPC systems and the firmware default EPP was lost.
 - amd_pstate_init_freq() passed the quirk lowest_freq (MHz) to
   freq_to_perf() together with a nominal_freq in kHz, which produced a
   bogus lowest_perf.
 - get_mode_idx_from_str() matched any prefix of a mode name, so writing
   e.g. "undefi" to the status sysfs file was silently accepted instead
   of returning -EINVAL.
 - amd_pstate_ut_epp() leaked a platform profile device and left the
   EPP state modified when dynamic EPP was originally disabled.
 - amd_pstate_update_min_max_limit() read policy->min/max multiple times
   without holding policy->rwsem, so the programmed perf limits could
   disagree with the cached limit frequencies.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v2:
- Fold in suggestions for string handling into 5/6 (Prateek)
- Pull in changes from EPP aliasing in
  https://lore.kernel.org/linux-pm/20261012205559.3421297-1-mario.limonciello@amd.com/
- Link to v1: https://patch.msgid.link/20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com

---
Mario Limonciello (7):
      cpufreq: amd-pstate: Fix NULL dereference in amd_prefcore_param()
      cpufreq/amd-pstate: Fix EPP extraction in shmem_get_epp()
      cpufreq/amd-pstate: Fix unit mismatch in amd_pstate_init_freq()
      cpufreq: amd-pstate: Require exact mode string match
      cpufreq/amd-pstate-ut: Restore EPP state at end of amd_pstate_ut_epp()
      cpufreq/amd-pstate: Snapshot policy limits in amd_pstate_update_min_max_limit()
      cpufreq: amd-pstate: Preserve names for aliased EPP values

 drivers/cpufreq/amd-pstate-ut.c | 63 +++++++++++++++++++++--------------------
 drivers/cpufreq/amd-pstate.c    | 55 +++++++++++++++++++++++------------
 drivers/cpufreq/amd-pstate.h    |  4 +--
 3 files changed, 71 insertions(+), 51 deletions(-)
---
base-commit: 141b164bbe186423e295b139e40e8e2d11cf1341
change-id: 20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-9d324aa04dd5

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

