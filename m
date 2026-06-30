Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60829357739;
	Tue, 30 Jun 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845973; cv=fail; b=DDooiLGqvVw/hln5m+pYXHcAd1AUzTUKoszMJmpJwT6hbQLBOk0A8ft/86u71ykGDOYNPQW/FrsBGZmEiM4Z/YJ2Uutp81Z9L/af6PwDH0IPbwBx2xesyAZdcNQ+Wv/fjn2HhxFsJOgdU7JwwI6HYxCsdWYS1aQ38/kjHZ4IQlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845973; c=relaxed/simple;
	bh=JCZRcyYHfIZJ71gFsORU5Y63B9TJPIq8stJec04NneQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W4zM+OArBT7KlTZ/mNt82FJifGSpXC+mX3tFauTfFW0cgaI0nNiWxpDHVPgf3aMgec4TjXPK6L3+KDjed6LSRZATFGo4+gMGXuJCRecXrvuJ1bVPX8wZ98EaqGjRHpt8uipsXwSE/ReIcYnUHacjOh59PPiCEmTfa4H+mXlIYpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WM/H6Xkg; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WM/H6Xkg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5VVHa43HTVfQUIH+NFqo/VO5O31zarm9Zu96bHan0IKMOoVnNmFyyq911kF5eBKhNnf5kSLsNNRRzFI138j1vyaD6ZuZTS+0J59VuoJ+MtiEvfuk2/ZPE6YmWjKR3btIRyVnXc6vnLupVycXp4pTYHHkYt6O3RveEbZSA0tv+5Z0HSAFMeoHDCc/FcP9Anbw9fXH9IxUOyUpdMtu5fg52oTbezjwFYs/XmhSj/YWJJr4dxn7ldftgNiQ2v8tbNbLZ50vW5J0SRsZ3hqoKSQw2d3i509/pjIHcEjGsBNNDbwyQaotPqQ/YbOK6IJiUdbv8SU/q5Nf27Al2PM4bPjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue7ED4xUmaRorcU0Tu5/PTarITmn0eYnD26XCskUUtM=;
 b=fZfjqydoEHM75qrNJkCNzUzNoWMWc5xeplFIXDpaAgp6R6wN/3heNNLZsHCfhDvFYoQz1cpS2Ze+mN44ozJoZOo6Tje3TDar1H6XSUHoXU1r+uDSTUsjhjkPAcEu5Hqe+KcfeVlQu06rl+hqRgW1JPyM8ryuk/pwyNNmEhQZMz7vgMZlvwuYqOqbO1yOSXbKdS8E1Tldmy2rNHHEoGoozTWpsSLIZD5WBT6YsEbf/vDTxTbu68ZgDsKkr0AIcty3xkGtSPV2TsQDsccRkbjzBaAUzDYFtMeLKRZTI5YP1TdAvVz6POql8jhCVBZ639zAvcUx6R4HLVGy7MYCiqg+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue7ED4xUmaRorcU0Tu5/PTarITmn0eYnD26XCskUUtM=;
 b=WM/H6XkgyUZ2T4DWVolp308L5BXxzYG1Kt7DGOP3Ucum7eLnjElV+L9IVD4rbx7CSzUqEOcXJynk/pmGNBpcw6QYZbYNIBk8IAz5y86R4onKxl0KhKqLxRP/RaxyPhDDFtLQB8kcuH9d1WlVqLg1fxN4O/Q6s5XKyP0Ya+LH7ME=
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 18:59:25 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:332:cafe::89) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 18:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Tue, 30 Jun 2026 18:59:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:59:22 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/6] cpufreq/amd-pstate: Rework dynamic_epp as an energy_performance_preference mode
Date: Tue, 30 Jun 2026 18:58:58 +0000
Message-ID: <20260630185904.5602-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0cd092-7aef-4281-3e97-08ded6d9b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	R/wevXyFGiVVqr3/kvNg/PEU+q+nvqAaKTPs7VoOhXI0PVBfpCQfbwPRc73rcoMmcAkb4g1sBoBNZZJDZklerb6aHYUsHb0IUEnTyNcRGJSN+mnEY12Tl+UYo4H4IwHIo6EwotJamrZEOT7uiy/8W82+pm3vWlqEcvuYH9vRz4R+4JWOUXuNW5nzdIwtAHVt7H3nEa5XUyNc0BZEaAa0ThIGKHK0L57vIC1g8hWe+N20H/R3F1e8xNa41woMZQR/Jhtk/fk6EMWBXK8FDs/s1TskmdbDrwtsczoKwHpIYYaZWvMaMMjfIeXMGAbUL1k/bRGsZ44tfPsTLZJJ0ZDMbyIyhCzDjQ8kbsoJQkFJhkD+U6lOn44roExikxENQjBVNHH0oAUCSBJRdFSTHXn7Jwjkenq/9rhNkVfiGLKGEWzoT1Vney8eopczThxSrbC/CCtIjDATJ2cbqk2gIcIgDvTwd4fcccuclfFfxe0x5Wf8ptNnUVI2qqFbxKi5Ckgl0ncXgIrY1wweuu9SQBsU95WWJ+bJnwv8UDG7ot9vIRibA4W10fHggmzxIRi32CVShGzzrZNQfrGETb/Okfc/8+xHm0zQDEOVa2qvq+NvDpZAxNoFciXIVV+h8n19erfaedtu0M8VE5/cu4yPyXy3doRDPMNOuQQMfLIdwo4zZvOdswAg2dHRcsBvYjA45l5DPh+s6EfvpgJioaC6ynsxMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OhRCHRz5Y1v1P45TWpdp5J5CrjaQwDbi6qlgQMZXvK83mtNdm2hp/Zwv7cWa/LTLSJKciO3uCEgZQgX/nmEbzALPGid7SFU3AZLS5icvGaZ+lGpcKeRMGOkCpE5kzqfyC0jtPNYwyVeTK4K0lC001FTUD2oak6iWpBnhaIPvCS3lzBPPIuLKnU9gI+FE9WMl/WiQLzpjR4ceE0kjOS3nc7WZytXsRmVo/9GsAfhFTbwxd0+daS4LgWrF5pQqToGFLgdKxtLLwVKPU6sMcjWHpfTORPeWkukpZN/vemKEAhR4sciYQaN1Npc1bBNGQfxQBdJuDNkpzLEz1ue/BpK2fAex2t9ZoqYDzqeXdggT1FH7NjxSG30szejRZmgTI7i6oKPLsD9aQWDvE9FIgbiO/FODiECD0U2Ufi48IwZGKV0QET6bND0xF5GP+dPLN9Y0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:59:25.4842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0cd092-7aef-4281-3e97-08ded6d9b45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

Like custom_epp, move dnamic_epp functionality into a
energy_performance_preference selection which makes the integration more
natural with the rest of the driver functionality.

RFC is mainly to check if this is a good idea and if the "dynamic_epp"
sysfs needs to be retained? I've retained it in the series, changing it
to a RO attribute to reflect if the feature is disabled from kenel
cmdline but it seems unnecessary with the feature available as an
"energy_performance_preference" which can be toggled anytime.

Series is based on linux-pm:bleeding-edge at commit 03842bb4dfb5
("Merge branch 'experimental/acpi-driver-work' into bleeding-edge")
(30-06-2026) with Marco's series from [1] applied on top.

[1] https://lore.kernel.org/lkml/20260609073042.81275-1-scardracs@disroot.org/
---
K Prateek Nayak (6):
  cpufreq/amd-pstate: Extract platform profile to EPP conversion into a
    helper
  cpufreq/amd-pstate: Add dynamic EPP as an
    "energy_performance_preference" mode
  cpufreq/amd-pstate: Repurpose "amd_dynamic_epp" cmdline and
    corresponding sysfs
  Documentation/amd-pstate: Update dynamic_epp documentation with new
    behavior
  cpufreq/amd-pstate: Reduce the scope of exported symbols
  cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode

 Documentation/admin-guide/pm/amd-pstate.rst |  61 ++++--
 drivers/cpufreq/amd-pstate-ut.c             |  48 +++--
 drivers/cpufreq/amd-pstate.c                | 221 ++++++++++++--------
 drivers/cpufreq/amd-pstate.h                |   8 +
 4 files changed, 206 insertions(+), 132 deletions(-)


base-commit: 03842bb4dfb516e7c3c6323fede451823c4629dc
prerequisite-message-id: 20260609073042.81275-1-scardracs@disroot.org
prerequisite-patch-id: 15637b279250c6f653e42afb1c7ed7970be2627e
prerequisite-patch-id: f8c8f4064db0f33251d420723da8c92d9d803890
prerequisite-patch-id: 72386a2a5a24597eccbeb16624dcfd8b27770c16
-- 
2.34.1

