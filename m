Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352285;
	b=J63w72Wa5f3p26+UuQXlnZi5dCQYLqdcCyJke5DIkOKFBrQfJIPG95vjDefSemPrIQEy
	 ps4NQW4RZMUaGJhOSKslFxwbdxzGPbhIu4Qkn8fyrD6fufPeNvzRtERseH36LTB47Gsze
	 OzSfsVVUHHGqwJrb0G90/L3Zd3yAlbd/2DPUkVeB4I9YBYlyCUAbYYcqKKoyYdNcPQlSM
	 OHJvNi4ZKh2ljM9hxJwLuy79cA4Y4s/+lOZ5HherDxr/qLznp15lq6rp5uXV5W16U5OE3
	 d9HyfytYfGMUjx77aBHhfVGwP199QyLkZMDvf5fcz1L9FUEwaWkiS+ambK8pDO6N03Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352285;
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
	bh=I0TLv7ZDq9a03FaqNPiNkYaeS8EGCNNAs77bhaYWY4w=;
	b=aEh21sAAOcWkfWMJZVo+NWBbMf2Sw3p/klYRW4tLfLxc14EBuO4/MIEZfmW2Zl7vAqZs
	 64raZ22ycxAsJmTJ0+f1Q8eCzCymeeADvBCthVnkvWM3ZGPyrPZOc9Wp7MuBjQWWfSVCg
	 O19ujVnSHtxLlWKHM6cI6ALRL14A52b6Od52rTmv/X31mNyPCN0s5fX/knZbLICEmxbib
	 v1xUOP9pbbkXup9Ag6RGfPfPkHaNUhUra+16X0dqxiQ5m8iB3czMye+xslXmjKeehd/ga
	 GzJ6Qn+2Nig4NXcnrYnJWEw7jjFFPtzhTioDk2GDMOYbqRuRyt6ICLcacndJsa04ZRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HliqrH+y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E3606A31A;
	Fri, 30 Oct 2026 09:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HliqrH+y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVRtqt1T1ZFadPfgF8FUWKv9jDLNWWliUwtYkbUVqPXI84B5du2UWJFdGwHYsyFW+gqSJDUBzLhv8MRE3IGvBvUuIcqxgMEdf17/XM/m/h30cufGtdI9tMSuHtHMd+W9dJf1M2L1OjunQZkC4nAVdmNNKb+BhlntLTXHWEexj3hG5D//TadDqYjJXfoT5WWHbrdC3VP1qIh0HmyXA6PwWPrAcKjxwgwrQgVLmfejWDpMMjLvOtHj1Fr5R/dg73j97XoINvgnYc9ctFXeEH9jVvYAxUKlgt5FFYqAefAKo5eG3Zp1Y7hXWYH7yw11N0EmpQKDqO/r/x3EzPa7eiVc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0TLv7ZDq9a03FaqNPiNkYaeS8EGCNNAs77bhaYWY4w=;
 b=m73cI6IkUlDphUuMDvgcIX5yB69w6U/OEq07VmxIsYH6JrxvH+3oaFcXnXqlcWug7697WEsc+rOLRHoYzJuL9XaxVcm6dl6WHP6o3BpKAE9hua1kOCi7Tweq8xgbrBoKN7mszjbZ68vESl6fPUQK65gJeM1+/9C+GdEFe6BBym5nv7dAZzpNh3EJAZqpr8WGO0csp8SefKsXgSUM4Ijmvca/stBEN5YFx2NSgldtd6WLjp9/7CKm0CHv7n47OjNNRXe8flVI6HRDZu8P1tdaY4i3FvGK+X3hFK19WR9w1xXV0gEyWC6A2b87JyWmIsr2kX+OhKuaTOrgWNPivDtk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0TLv7ZDq9a03FaqNPiNkYaeS8EGCNNAs77bhaYWY4w=;
 b=HliqrH+yhPC2KkP4KSZ9yPnA5/diuqfoej57LCBemr1GyvyT9fCDsSTzp7fhfhjASub95Ci4CkWG4oguQjgiAaPtJGnXoWILDd+GLFgZEolRUyV+0jRgj5xeWU7qKUAz+pC0/Z78MAArPSuTebe8EAhbwmRM4gJuhv/ZxEDKbmhRllGcU7++ErvPWqnJbDIZWo4DnfAsRBiv+AYS0JnrZHG7wvQ1TP61EqMY7LyZ8oKF+yMC9uKYaAIPnt7+A3J458JMd3/0+Kmdh4mAwwY/yGyc8fSHxXXWnaxt9ew50E6bh4pM8KTZmF9wta44AW4hYbECQvKg0eqhkUD1AqZRHA==
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by IA3PR12MB575744.namprd12.prod.outlook.com (2603:10b6:208:61d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:24:41 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::64) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 09:24:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:24:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:24:24 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:24:18 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v7 0/5] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Fri, 30 Oct 2026 14:54:12 +0530
Message-ID: <20261030092416.1993889-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|IA3PR12MB575744:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d55c86b-498a-4451-db16-08df3667a05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|10067099003|11063799006|56012099006|261009221227099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261022113327099003|261021123027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9FZKDqhWVWXSh4r183pTk7kbMe5HAOezB7QDivPwdnfViC4MKG9q2BRaOazwet+aVjFY8L2jwmkyapww+/g2u3Igmds1AYEz/pG0kryCuT0NoMKBvvHFWihks8ZEWUFuy13bZUuKYOdempkuwJ6zrOL888nzFLknlkn+T/pJX71JKdwRYi5xAf95UdbB8G7WMs8GY7YVHjb3yAEpmpyAz0K9SHELPj4zjulKDhzyr8t5L9VHB9271w2YHpsaC16e8XYcyZL81zKhfX+0rGV318+zePXN/CSW1Yur63oNZpzcacp5nhUuY6vcB1djL4Oy8ZjDeM4iaZd5ZxdYkPgIsNy1pOERwTrtjojYcMPgeNqfPP8BlWcspJOUYr9APYiIBrt1l4gPwHL+kMAvvxarPMgamXTI+S72tuyssw1rTv+Y4dginvNQVYYRr8/59gw+ummY6VEV+mBchheodYC5oC71AhAdSEwXERkT8UH3TshS11BWRHVj5BwFz6jAF2rholt4dZQSRQgccS9CdQUN8zBHVjKrEeuJIG1+KT+kED0DL6xkqyrqUEqKdGkkI9/UG0xakMD2igz7xEKGuI+/dwVEv4hANuYiaj0z8tzzY7DfYecXVfdOWJedHAwWHMR0K5zooVuqzLWq5sPkJI5d/ALgBYwpZUcydyew8COGjmHuf2BV2ryZKW/afZ7Ef9VX6hsfdeLZkzGtwELK4HycIheJLd0WwKMfiUSKMjNPfEB8gbyAcZ9S5TbIlUOwyc8f
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022113327099003)(261021123027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ErvT4p6w+YdlnzlHvPQoDax79A22XrNUKNtv16e/Sa58TDqLozINyyikwmnc/bCXVGJXRU3/x/jrrxk0aOGchV8umrackVmszAhHWkd+U6P9yh+zGHkr6ZbIhA+W4ufiLw5P+lIqqw2mMlZQ/s1xtW1W0wYPImWTtbJIiMOWYUkQH43sxeYQDlpkzixSaAz64dFlJvoGdB8vokGSMwmw3EF360SO6845ebY3jfTBrRa3zrGVR0S/dLai3ZfSZRk4cuUq4Fd0hRIcS45z582fGnnb9r6wIr8FvLFBZ0ZBA0VSJMzkEWFKin2SMweXaUnhYR4ubyxT6aHmfUhbq33cvzR0WcN6XJtlauIURWwloQgrBz8U194SPZ43FXstRpjEiS0rDbjKsJpC4F904kpfgb0imGBhtHh1Fbli+LMMW+EpmxhVqUDThQDL3Mr2Rpd5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:24:40.8111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d55c86b-498a-4451-db16-08df3667a05b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB575744

This series preserves the OSPM-set CPPC registers (Energy Performance
Preference, Autonomous Activity Window, Autonomous Selection - set via
sysfs) across CPU hotplug and suspend/resume. On driver unload, it puts
back the values they had before the driver loaded.

To do this, it keeps the CPPC cpufreq policy alive across CPU hotplug.
It also orders the performance-control writes in cppc_set_perf(), so
that restoring them after a platform reset never sends an invalid
request.

Without online()/offline() callbacks, the core tears a policy down when
its last CPU goes offline and rebuilds it on the way back, re-reading the
CPPC capabilities each time. The values written to these registers can
be lost:

 - Across CPU hotplug or suspend/resume: the platform may reset them
   while the CPU is offline or suspended.
 - On driver unload: the driver-written value is left in the register
   instead of returning to its pre-driver state.

Handle these with:

 - Patch 1: orders the Desired, MIN and MAX writes in cppc_set_perf(), so
   that the platform never sees an invalid request. Christian proposed
   it in [7], and this version adds fixes found in testing.
 - Patch 2: adds online()/offline() callbacks so the core keeps policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 3: makes the autonomous selection register helpers take a u64.
 - Patch 4: saves each register's firmware value at init() and each
   successful sysfs write as the requested value. offline() restores the
   firmware values, and online() reapplies the requested values.
 - Patch 5: extends the same restore and reapply to system
   suspend/resume.

v6[6] -> v7:
 - Patch 1:
   - clamp Desired into MIN and MAX instead of rejecting it. (Sashiko)
   - store_auto_select() updates its cache only on success. (Sashiko)
 - Patch 2:
   - exit() only frees the driver data. (Sashiko)
   - online() continues if enabling CPPC fails, as init() does.
 - Patch 4:
   - save the requested value on each successful sysfs write, instead
     of reading it in offline(). (Christian, Rafael [8])
   - init() fails if a firmware value cannot be read. (Christian)
   - split the auto_act_window store from perf_limited.
 - Patch 5:
   - suspend() no longer reads and saves the registers.

Christian Loehle (1):
  ACPI: CPPC: Order performance-control updates

Sumit Gupta (4):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume

 drivers/acpi/cppc_acpi.c       | 318 +++++++++++++++-----
 drivers/cpufreq/amd-pstate.c   |   2 +-
 drivers/cpufreq/cppc_cpufreq.c | 530 ++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h       |   9 +-
 4 files changed, 729 insertions(+), 130 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/
[4] v4: https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/
[5] v5: https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
[6] v6: https://lore.kernel.org/lkml/20261020121846.691218-1-sumitg@nvidia.com/
[7] https://lore.kernel.org/lkml/1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com/
[8] https://lore.kernel.org/linux-pm/CAJZ5v0iXip_5Ywk3EkrGL_u2w_hOcGKA1XvrubLPb3diWHx5Lw@mail.gmail.com/

-- 
2.34.1

