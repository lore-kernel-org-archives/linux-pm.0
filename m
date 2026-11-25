Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627262;
	b=cFeHpoHegfnRkYtsj1hY0LtbFr1e8nY7u9ZHgEv8VD3f39PAD9M6Bi2nJjT+6cNLgB17
	 rE3JB6QawvzOxfjMM5ZttwKhdjZHJ0AdO4i99+DosF4GVrV6MQezn6v/sFLatVIotrjn7
	 d+MvgxdifrqE+sDmmWitX21jwP9MHT/WRqAGvb7cAqABiwGJsgjf4N9eUOGUJaCwCnvHw
	 57LSlng9EIO5OhSBjWqLtiQ3mBrG/A2TwHGXP/rY6vIjoNy5x1z682YcL83qI11J2BpxW
	 Qbd26A/KsRcD0U9nuTuLkzq+99L33Pleh4LMuEmFxDghZz3z58svSn7FWcwEVFl+omg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627262;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lSkn2nCFUBhOAlQyv3Nwci6Zfqp+sAVcmQVsZWOu1PY=;
	b=xhFp89mw+Uoz6eer6obvTPFfW/1oWS0I6t2GC18xp6BDSWJasopa0PHk+/RAaAgHcMbx
	 XfaCp3dlhsdZVKVK+bxCQ+VJaMYWKrxY416qePfTmC6HM1x7YPGm7kiS7HM7CflDGQ5wK
	 wRFVFqMIGgl4tWa8aszPNSjvIc0FLERUtu7p5CGCHAYUlVQ01qzRRjYZCqK54A4Yts40p
	 N3dLc8+o/LZHWvQAuWmF9xGZ6piGFElZH02Kohfh0+FdtdAH/0aykUJH58c5LK5bXp/3w
	 hf/X2R9tMJO13V0OxHL6itln8+Nasx4qxjFZt/FA26tHR5m+4m0W85Ps3prX1z67hRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BTfoPI7Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.20
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDE606A32E;
	Wed, 25 Nov 2026 17:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFBDE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BTfoPI7Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shFnVfJyxFaf3raDBvCFMhhGh6Gj0apr8UboRx1Md0JlDmTcta+EdQ+q29dgjRgAAQ9zKQhKJ9q+Wm/uboaM5NqaCWj+Ag7vkZOSO8rEQgVEZjnuE5fr6N9KdMUEsZgi7V76bcpFulbZ7mpWDi9pqyGp7YSJGOvVOGK1oxdafSfj6A41IGrghWrzTawaipXo+pkCTZM/kTf5sJiigoVX0nTWC3/G+o5AJpxoZPXCd9fz7il759HBynywE0S0wyzxzfQoeKDMJ7vug0zKDpnECPcDQc08Gm7wz98FLLSJISREFlC913iV2/1HCHZs/f75gyXJE081geIU07NAM0oGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSkn2nCFUBhOAlQyv3Nwci6Zfqp+sAVcmQVsZWOu1PY=;
 b=u/MPqs27vb1TxWR4+gFcUMl3fWRZxJ4lmgf2mksZA5uI1I7HiRFyP4x0Olo6OjZYJbSvBiSsrNCqGY/nfOPf+K6DECcHUTiq5MJFh3fSxEDf3EkbHoLYd0NN/zHUUizjjDaSXcvWSZPhwdw+8SyEBpII5/hsYA5j8kzHKQxdIPC+o88sG9XdfUzDQPZnoIJMolbVdWLWAhFf1+V9RtTgyNUT8M+6ROcTrFLd1iih13qpl0sQLD3wgv/O78dc419QnI2Fh6r7EBaCN1ysUEnZi0Y4Hgr2PnKQrVX9BEOTzhSCqnxRJ0bPAVUPJm4iy/dThpuuJK84XZBeMDol++rUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSkn2nCFUBhOAlQyv3Nwci6Zfqp+sAVcmQVsZWOu1PY=;
 b=BTfoPI7Zx1R8JzCDZraSyspItg/7jM0d9aG1YQLC+lvSCeRD1rJgTicScbPny5iHKjx+ekZFm3geLNHadRi3ke/BFDnbfWUwm5iaDS6JIcGUd0BD3XzGOrxQe5qNxSNGF/8gPKsVKRd2xqD7PUAFGarMLilEjziY00DdolnHTro=
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 CH1PPFA0A5C3BCA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:20:50 +0000
Received: from CY7PEPF000000F2.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::68) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 17:20:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F2.mail.protection.outlook.com (10.167.247.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:20:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:20:46 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 0/3] cpufreq: amd-pstate: Capacity Aware Scheduling on hybrid platforms
Date: Wed, 25 Nov 2026 22:50:28 +0530
Message-ID: <20261125172031.741740-1-Vishal.Badole@amd.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F2:EE_|CH1PPFA0A5C3BCA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a051069-5fb7-4866-31b6-08df4b1873cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|921020|56012099006|10067099003|11063799006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102130727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	jvoZHbrSZeUg850+DmD0NedWXlvhLGl9Et/90HhDYH3slZNJ41iVBOi/XopnnrOSGMaSCbt2OyW+BBQB18Lg5uA7IItFuBADFtY4Y1OoOlAkI68F0SnYZzjoimrXWwevzVw+dygAodiDlh1vOoJuOxXm33naZc0MFJOynSXTs7oAQbR2wEIMZccf6FEUzhEVysUrkeSkQ2tG8sJWZgI/OZcxSiEXU7HNbEsWqQly2O0sASz4lrRNhbAN1TMKQ0/KmOOqgEzzrnWJeOyas/nBFyCP/kQZS1/vRxd+xOGLDezLZSOoc5AYcDSc5xr0om/GQR1of8A/NnXLfQP3SNDN56s/64mgr5eqO9I8b3ytThIVJFxbCbqy6a7Mn5wDPqoT1LFLZ0UpFIjprms2MI69c3DGWUew1xeYs6/1a772JhUrTpmEeZ3yDauzTpEullzS5rdBmS4nf5haYPRj97TR1m8pXRxvRKpVIj0ta4orSR7gYX3REwW6Xq7UIybZNulaHY94ylmcwl6RxU0Wrvt+MizkXkhfQhPqjRTUlnaFjX/v4//9RU1jSqcWqLp+15Czo06KuzRM+MV9kjw2gnv7VV87vLmVpB+uXXFQVw6ZJVQOL30r5/B/aYYziEx4FujbAUGgLKyGZ6E7hrcwOtO0sI9C1XfjU8kjbad9bhr4EZ4G4ZBh8TkoggdxfhsZ+kkzeQII6LGlES9NC9uIfBKtXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(921020)(56012099006)(10067099003)(11063799006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102130727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ItnEIYZzSTYfuMK/z8SoaRniu15x9/uiiysTjuuC/A7SYr/cEnuNrFELFT/3lNc1Gmzdrg1l2D+iv0a0GBrmyjkuONmmwz30slsJwErW+U+/cL8rPXls4V8sklueFp/JdT8rw9eshj0cWHgjk/eVsRW3su3WxH2KoaRAF9ViPlrYx0zNHcW2r9ij/nHDH+uq82heZCwr5/XbhtZAOdJGGCA7oo1K8vtr8cZXNzYPIIOFDceXXUyDUdNjC42HTYu4weX/bmEbEgt3qErBi3NNLsKh2xvGIV0LvXdMUc8AtGRhJyClgk0o/kzsS8z79pELbEUjGPQOjdTvpTJJdhlV5XCSdzX7rIYpabDVCjnlN+r/EUGRw/1ZRT5R8r3CE+w3knvvHlT3g60UXs9JwdjF3PYKlz7/HLrIqslx/yj0wu/b9JzvXU/OAhWDLS6XL+pH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:20:50.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a051069-5fb7-4866-31b6-08df4b1873cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFA0A5C3BCA

This series enables Capacity Aware Scheduling (CAS) for AMD heterogeneous
processors.

amd-pstate does not export per-CPU capacity today, so the scheduler treats
all cores as equal and places tasks without regard to core strength.

Patch 1 moves the HFI check before amd-pstate driver registration, making
the preferred-core scheduling decision before per-CPU initialization.

Patch 2 makes amd-pstate publish asymmetric per-CPU capacities via the arch
hybrid capacity scaling interface. CAS is enabled by default on supported
hardware and can be turned off with the "amd_cas=disable" boot parameter.

Patch 3 makes amd-hfi stand down when CAS is active, since both manage the
same scheduler state. HFI initialization is deferred until amd-pstate has
established the CAS state.

Changes since v1:
- Add a preparation patch to finalize prefcore before driver registration.
- Select the reference CPU from all online CPUs instead of assuming CPU 0.
  Scale by maximum frequency when available for both CPUs, or by effective
  highest performance otherwise.
- Update the reference when a stronger CPU is initialized and rescale
  existing CPUs, including offline CPUs with retained policy data.
- Move the public AMD P-state header to arch/x86/include/asm/amd/.
- Defer HFI initialization to a late initcall for the CAS state check.
- Link to v1:
  https://lore.kernel.org/all/20261114150310.1377654-1-Vishal.Badole@amd.com/

Krishnamoorthi M (1):
  platform/x86/amd: hfi: Stand down when amd-pstate CAS is active

Vishal Badole (2):
  cpufreq: amd-pstate: Finalize prefcore before registration
  cpufreq: amd-pstate: Set asymmetric CPU capacity on hybrid platforms

 MAINTAINERS                           |   1 +
 arch/x86/include/asm/amd/amd-pstate.h |  16 +++
 arch/x86/kernel/acpi/cppc.c           |   4 +-
 drivers/cpufreq/amd-pstate.c          | 157 ++++++++++++++++++++++++--
 drivers/platform/x86/amd/hfi/hfi.c    |   9 +-
 5 files changed, 177 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/include/asm/amd/amd-pstate.h

-- 
2.34.1

