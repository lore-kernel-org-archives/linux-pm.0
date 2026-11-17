Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794886669;
	b=mflylOy+EOW28/QwdNG3uZdHMj1w2T2IZIykVal7drvz4lDSeB4+dxWuzDHM20r/79b/
	 /5i/XsT+oQG1j0SdzeLzMSdVpcedlt+g+P2j60wpA2XwaZWdf9ume42hSie5HJWmpyx/9
	 fGo22k9ov3pdlsUSx9VBAo34tljR8Ib28PPOARIEN96DBK0wRVyxr5DknZsGqpF/cs/AG
	 WN9XSJH2UZXjb6jlsn/fxLa91GcvuwQIhZjvGLvdck733RVWahrI2Aa6V0Se9NhgW+LxY
	 XmNks4fItDuA6mKaFfZKniLy40BPM3H8JsBCBahX9dF2izZHOXAEiedoc+vYDtfZxwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886669;
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
	bh=FMda0X9bFQT7IKFujytdunXC1uJ+AcNn60UQK1vC+Dg=;
	b=hBqkJs2SORAeXO+3m8pWyxh8vXKIchmmkMtxHyfDQiBN/qb5tQgeZ0DvQjCaTqEAtbaT
	 9MEkv/OpLoe37u+U6h2s/2q7dIrdd/w8ccvqYH3KOu5qeiUpdXbJbnzSXaQ9SWvtGMUGY
	 7RcEsdkhaicc9U96s2ZvJ37//IezyuPiRCmyM9QWHoREqhDr9n2jl/tRyERQzgUennsta
	 lsarHm7Brtx5cGaK9wmM3I727DL3LbZzQSON5OKhdw8P0X0RqC4VJO//TBwzo2D14uyI/
	 EoElMmgGv7FpwPpkD3eXWc+ajU2bD6XFzTEzi7LKVO7NrmGCjbuomlVGhZBaMx3QzWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yHvUsJZl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.51
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9653606A32C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9653606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yHvUsJZl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTjOX5+zy65ZBbHDNVA7pyKDLxLqEfYfkzObzssSUYP1EEx9hOF5gWDhqRq90A3j1fQI/hz1tkGmQ1ffOr0mgLwnt26I3N/ldc4HP7cQzkSC+/0rMyFcpCRmIC6TtcaGVU6Nj3DU8B57atUhjyAXanYbX+BpFIY4saF3LJM48Xg1fTkQB2RqFeNxBwb6XI10JhgwoUe135/bJ/XZkGrFtl3pIgLhKTNVH/E039gYNVzXQKqfdA5XQJHWnXSTZDl+bsad4Fc8n5iLdtANM5QsVOAyjeXGdoIJzNGQwKTQc80jzRLPmKYRm0xdiBrxc9iHKIWzymRQLG1bkHU9kum9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMda0X9bFQT7IKFujytdunXC1uJ+AcNn60UQK1vC+Dg=;
 b=D/xiT3+hy/peP7ORclfUdaoqiWc7L+XyrdK6neTBUuvjGSOhJJkFr1K3W+cEc4Rsz/gD+hcpNA5+DjCamJIpiLP5Aw1teNYVUEDlmkP5eRgY/LqeyyVrPZAnTgsjaI3rSnpgZ1LVnc6ccGy8lwJtt93jUBsKIAfbYsjQ84nQiymVhsXRDUcILfVdi1UshqJjy4zz8V6VdOteHS5UKjuebSPrbZ3cWHO50e3kOsbsenZLo0gRS72rymQpmBrDjy+QMqmCJZNfQ3J2t9J85K0pu7Xq8P79vDTIxXOsaLk1AgObNNh5H002utNh7p89EYjaAbL6YtEDkazthgicTr2DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMda0X9bFQT7IKFujytdunXC1uJ+AcNn60UQK1vC+Dg=;
 b=yHvUsJZlkeWea8dXr7Ecm2BokB4/M1Beedftg+on+7Dlrf7FIdU4uBLdjlIICnw7n2Ym6RB8e4MzDjXl+zx5nG+Q7kxw+EldkOUL3rgb1IBy3E2ku1L82Fndi1da1wmgoGIk3EBw4Sg7C3BN9PfmwM7WKIVDRBmYkae/iHbRnHY=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 03:37:43 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::a5) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 03:37:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 03:37:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 21:37:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/6] cpufreq: amd-pstate: Fix a batch of correctness bugs
Date: Mon, 16 Nov 2026 21:37:33 -0600
Message-ID: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAP7L+2oC/yXNQQ7CIBCF4as0s3YSoJS2XsW4YGBQjGIDYpo0v
 buoy+8t3r9B4Ry5wLHbIPM7lvhMDfLQgbvadGGMvhmUUEZKabDUhfND4j2mumKw5Aw5wnnSjJr
 siETDiEI519sgptCW2fdKWyu09wO04yVziOsvejr/XSrd2L2+Jdj3D7KKEnSWAAAA
X-Change-ID: 20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-9d324aa04dd5
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f7b4e5-c3ba-44fa-cf65-08df445c2375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261021135927099003|261021123027099003|261009221227099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	DqI5WweW9ovqAW3Qjyf63ze4AWh56444pYO/MoHjjk2lbm90XQDublJZu2zUdjl5Jix+wjY9wKhcthawjYp+X18WPSG1k582RbRe3CxI8ZYfOtZkM5GIaBHy5/ga1JMx1xjx5zEw6MCGIDDES7jSK3mgsadQT4YhB0V27vjJoHL1VJ7uJ99Si9vu7sIWi9xZTm8sZADEdfHkCuvrk83sh0BN0j2JpPBiFJDnlrjMpCIYOJtAgBgUhoD64b9wjkWp1tZuhU1nlTeQH9IZ3fwnui0hcgQHrQHUBCDPbopF8+tT6izp1e7WkxNM1DiqgFQKC3+i1GoVWe9ErSsLAaCluCmA5Wh+Xo5cyfNssCuclJ8SunBtLrRgA8OJfg0QIOI2NC/Cdo7T2QZqDr+eTSgKFKX/so7CMQCC0IKFhMbQ95V8uBGpXCJN8LfI8Qiid6BISKSYYRV2HJZahRT8ydsbo6afU/oEV5Gg3+IN9SSJJaRVGSmVpFlOjvDcUMFjrAowH5eszWg5MlpKuGfY7F2i0SZe/1RWfF3VPhOwsod8OhBuPlElfxmQmgjJRzopyg5wAdQyZBQM5lqmtkIR57tOkiNxAQSin569iCBszxkooMb/PhN6MBWnk8d41SESEekI5zQCkNmcu/ZBZIDI1FJcVyiqQBzFC01+QXn2IQQSxquux0viZwIaEXZfGkdTEcdQsXSZ6I2QNhh+kCmVuyWACQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021135927099003)(261021123027099003)(261009221227099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2P/4mAViGl9ZDhE0IISat8ZIFTiXuutG6b1165yLrs4dp+wbc9GiyPkaDGmsZRYfe2uTAPumNMJdw8ByzdFi6yTQPtrkfTJHTciDfi9oThVT4xMdEUFQD1n/wT+o/vZOfQSy5mY589gnpXDKjJICPvt2yTM6kIXM7OPq1D6JLBc9mv/jnP34odeBElR/lWujgZgFpRsvCXP92pyXAZYczG3P+t0V0krBizqmTFV+V0dUgpDcgR7ahZlVrHnqBB2OBpHl1U/ZBzTe9Cm+/3ncb2aexZ6vv2AmVrsVJW/V6A8KTTiJZLvHTymhFN42e/N04o+ry2h/vAn3UAYeqa4HR8esNuQWC+IDK/YlGPNi1Es9wlGTYPTCZLn1rJegyHra1F7GRu4bHcq2Qi/JVomixD61EuJmpmSQBPCHhUa9hCKOh+qk+3WA2KX0hQSZPXWj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:37:43.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f7b4e5-c3ba-44fa-cf65-08df445c2375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

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
Mario Limonciello (6):
      cpufreq: amd-pstate: Fix NULL dereference in amd_prefcore_param()
      cpufreq/amd-pstate: Fix EPP extraction in shmem_get_epp()
      cpufreq/amd-pstate: Fix unit mismatch in amd_pstate_init_freq()
      cpufreq: amd-pstate: Require exact mode string match
      cpufreq/amd-pstate-ut: Restore EPP state at end of amd_pstate_ut_epp()
      cpufreq/amd-pstate: Snapshot policy limits in amd_pstate_update_min_max_limit()

 drivers/cpufreq/amd-pstate-ut.c | 29 ++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.c    | 32 ++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 19 deletions(-)
---
base-commit: 141b164bbe186423e295b139e40e8e2d11cf1341
change-id: 20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-9d324aa04dd5

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

